package RecordParamBug "package to reproduce bug when editing a parameter of Record type in OMEdit 1.12. Pierre Haessig 2017-12-01"

   record SType
      parameter Real x;
      parameter Real y;
   end SType;
    
  constant SType sa(x=1, y=1);
  constant SType sb(x=2, y=2);
    
  model testComponent
    extends Modelica.Icons.Example;
    Component component1 annotation(
      Placement(visible = true, transformation(origin = {-8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
      Diagram(graphics = {Text(origin = {10, 61}, extent = {{-90, 41}, {90, -41}}, textString = "Bug in OM 1.12. \n 1. Change paramereter in component")}));
  end testComponent;
  
  model Component
    parameter SType sx = sa "sa or sb";
  end Component;

end RecordParamBug;