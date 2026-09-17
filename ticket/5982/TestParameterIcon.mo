package TestParameterIcon
  model M
    parameter Real p = 10;
  equation

  annotation(
      Icon(graphics = {Text(origin = {5, 5}, extent = {{-89, 79}, {89, -79}}, textString = "p = %p"), Rectangle(extent = {{-100, 100}, {100, -100}})}));end M;

  model S
   parameter Real q = 5;
  TestParameterIcon.M m annotation(
      Placement(visible = true, transformation(origin = {-7.10543e-15, -22}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  equation

  annotation(
      Diagram(graphics = {Text(origin = {-1, 70}, extent = {{-41, 10}, {41, -10}}, textString = "q = %q")}));end S;
equation

end TestParameterIcon;
