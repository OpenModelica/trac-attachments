within ;
model TableTest
import Modelica.Electrical.Digital.Interfaces.Logic;
  Modelica.Electrical.Digital.Sources.Table digitalTable(
    y0=Modelica.Electrical.Digital.Interfaces.Logic.'U',
    t=0:8,
    x={Logic.'U',Logic.'X',Logic.'0',Logic.'1',Logic.'Z',Logic.'W',Logic.'L',
        Logic.'H',Logic.'-'})
    annotation (Placement(transformation(extent={{-59,0},{-39,20}})));
  annotation (uses(Modelica(version="3.2")));
end TableTest;
