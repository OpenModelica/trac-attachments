within ;
package OMCBug

  model Bug
    Modelica.Blocks.Interfaces.RealInput x
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  initial equation
    assert(x>0,"x have to be greater 0 at initial");
  equation

    annotation ();
  end Bug;

  model BugToplvl

    OMCBug.Bug bug
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=-1,
      duration=0.5,
      offset=1)
      annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
  equation
    connect(bug.x, ramp.y)
      annotation (Line(points={{-10,0},{-26,0},{-43,0}}, color={0,0,127}));
    annotation ();
  end BugToplvl;
  annotation (uses(Modelica(version="3.2.1")));
end OMCBug;
