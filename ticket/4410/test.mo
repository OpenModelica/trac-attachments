package test
  partial model A
    annotation(
      Diagram,
      Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {2, -1}, extent = {{-32, 41}, {32, -41}}, textString = "A")}));
  end A;

  model B
    extends A;
  end B;

model C
  replaceable B b1 constrainedby A annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
end C;

end test;
