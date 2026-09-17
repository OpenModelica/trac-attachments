model TestInheritanceGUI
  model M1
    Modelica.Blocks.Sources.Step step(height = 2, offset = 3, startTime = 4)  annotation(
      Placement(visible = true, transformation(origin = {-16, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end M1;

  model M2
    extends TestInheritanceGUI.M1(step.startTime = 5);
  equation

  end M2;

  model M3
    extends TestInheritanceGUI.M2;
  equation

  end M3;
equation

annotation(
    uses(Modelica(version = "3.2.2")));end TestInheritanceGUI;
