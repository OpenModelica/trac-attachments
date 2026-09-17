package Test
  model BaseModel
    parameter Real a;
  equation

  end BaseModel;

  model ExtendedModel
    extends Test.BaseModel;
    parameter Real b;
    Real c;
  equation
  c = b+a;
  end ExtendedModel;

  model Container
  ExtendedModel extendedModel annotation(
      Placement(visible = true, transformation(origin = {-16, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end Container;
end Test;
