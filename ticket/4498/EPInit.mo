within ;
package EPInit
  "Example for initialization of external objects that require an ordering"

  model Test_EPInit
    EP1 ep1 = EP1();
    EP2 ep2 = EP2(ep1);
  equation
    when time > 0.1 then
      EP1_Print(ep1);
      EP2_Print(ep2);
    end when;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Test_EPInit;


  class EP1
  extends ExternalObject;
    encapsulated function constructor
      import EPInit.EP1;
      output EP1 ep1;
      external "C" ep1 =  EP1_Constructor()
      annotation(Include = "
#include <stdlib.h>
#include \"ModelicaUtilities.h\"
  
void* EP1_Constructor() {
ModelicaFormatMessage(\"Entering EP1_Constructor()\\n\");
  double* ep1_state = (double*)malloc(sizeof(double)*1);
  if (!ep1_state) ModelicaFormatError(\"EP1_Constructor: malloc failed\");
  *ep1_state = 3.3;
  return (void*) ep1_state;   
}
  ");
    end constructor;

    encapsulated function destructor
      import EPInit.EP1;
      input EP1 ep1;
      external "C" EP1_Destructor(ep1)
      annotation(Include = "
#include <stdlib.h>
#include \"ModelicaUtilities.h\"
  
  void EP1_Destructor(void* ep1_state) {
  ModelicaFormatMessage(\"Entering EP1_Destructor()\\n\");
  if (!ep1_state) ModelicaFormatMessage(\"EP1_Destructor: invalid pointer\");
  free(ep1_state);
}
 ");
    end destructor;
  end EP1;

  class EP2
  extends ExternalObject;
    encapsulated function constructor
      import EPInit.EP1;
      import EPInit.EP2;
      input EP1 ep1;
      output EP2 ep2;
      external "C" ep2 =  EP2_Constructor(ep1)
      annotation(Include = "
#include <stdlib.h>
#include \"ModelicaUtilities.h\"
  
void* EP2_Constructor(void* ep1_state) {
  ModelicaFormatMessage(\"Entering EP2_Constructor()\\n\");
  if (!ep1_state) ModelicaFormatMessage(\"EP1_Destructor: invalid pointer\");
  double* ep2_state = (double*)malloc(sizeof(double)*1);
  if (!ep2_state) ModelicaFormatError(\"EP2_Constructor: malloc failed\");
  *ep2_state = *((double*)ep1_state) + 10;  
  return (void*) ep2_state;   
}
  ");
    end constructor;

    encapsulated function destructor
      import EPInit.EP2;
      input EP2 ep2;
      external "C" EP2_Destructor(ep2)
      annotation(Include = "
#include <stdlib.h>
#include \"ModelicaUtilities.h\"
  
  void EP2_Destructor(void* ep2_state) {
  ModelicaFormatMessage(\"Entering EP2_Destructor()\\n\");
  if (!ep2_state) ModelicaFormatMessage(\"EP2_Destructor: invalid pointer\");
  free(ep2_state);
}
 ");
    end destructor;
  end EP2;

  encapsulated function EP1_Print
    import EPInit.EP1;
    input EP1 ep1;
    external "C" EP1_Print(ep1)
    annotation(Include = "
#include \"ModelicaUtilities.h\"
  
void EP1_Print(void* ep1_state) {
  ModelicaFormatMessage(\"Entering EP1_Print()\\n\");
  if (!ep1_state) ModelicaFormatMessage(\"EP1_Print: invalid pointer\");
  ModelicaFormatMessage(\"EP1_Print: ep1_state=%4.2f\\n\", *((double*)ep1_state));
}
 ");
  end EP1_Print;

  encapsulated function EP2_Print
    import EPInit.EP2;
    input EP2 ep2;
    external "C" EP2_Print(ep2)
    annotation(Include = "
#include \"ModelicaUtilities.h\"
  
void EP2_Print(void* ep2_state) {
  ModelicaFormatMessage(\"Entering EP2_Print()\\n\");
  if (!ep2_state) ModelicaFormatMessage(\"EP2_Print: invalid pointer\");
  ModelicaFormatMessage(\"EP2_Print: ep2_state=%4.2f\\n\", *((double*)ep2_state));
}
 ");
  end EP2_Print;
end EPInit;
