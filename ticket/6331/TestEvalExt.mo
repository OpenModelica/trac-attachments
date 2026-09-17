package TestEvalExt
  record MyRecord "a record whose members are assigned by an external fuuction"
    Real p1 = extfunc1(), p2 = 2. * extfunc1();
  end MyRecord;

  parameter MyRecord myParams(p1 = 0.1 * extfunc1(), p2 = extfunc1());
  parameter MyRecord[1] myParamsArray = {myParams};
  parameter MyRecord[1] myParamsArray2;

  model test1 "initialzing a constant by an external function (NOT WORKING!)"
    constant MyRecord params(p1 = 0.1 * extfunc1(), p2 = extfunc1());
    //<-- it's a constant assigned by an external function..
  end test1;

  model test2 "initialzing a parameter by an external function (WORKING!)"
    parameter MyRecord params(p1 = 0.1 * extfunc1(), p2 = extfunc1());
    //<-- it's a parameter assigned by an external function..
  end test2;

  model test3 "initialzing a parameter and an array (WORKING!)"
    parameter MyRecord params(p1 = 0.1 * extfunc1(), p2 = extfunc1());
    // <-- a parameter
    parameter MyRecord[2] params_array = {params, params};
    // <-- a array of the parameter
  end test3;

  model test4 "getting a subelement from the initialized parameter (WORKING!)"
    extends test3;
    parameter Real p1 = params_array[2].p1;
    //from an inherited array
    parameter Real p2 = myParams.p2;
    //from a parameter in the package (initialized outside..)
  end test4;

  model test5 "getting a subelement from the parameter array (NOT WORKING!)"
    extends test3;
    parameter Real p2 = myParamsArray[1].p2;
    // <-- from an array of paramater of the package (initialized outside..)
    parameter Real p2 = myParamsArray2[1].p2;
    // <-- it doesn't work too..
  end test5;

  function extfunc1
    output Real ret;
  
    external "C"  annotation(
      Include = "
        double extfunc1(void){
            return 1.234;
         }
       ");
  end extfunc1;
end TestEvalExt;
