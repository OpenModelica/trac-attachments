package TestModifierOrder
  model M
    parameter Real z = 1;
    parameter Real a = 2;
    parameter Real b = 3;
    parameter Real Z = 7;
    parameter Real B = 4;
  end M;

  model S
  M m(B = 6, Z = 5, a = 3, b = 4, z = 2)  annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end S;
  
  model S1
  M m(
    B = 6,
    Z = 5,
    a = 3,
    b = 4,
    z = 2)  annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  
  end S1;
  
  model S2
  M m(
    B = 6,
    Z = 5,
    a = 3,
    b = 14,
    z = 2)  annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  
  end S2;
  
  model S3
  M m(
    a = 3,
    b = 4,
    B = 6,
    Z = 5,
    z = 2)  annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  
  end S3;
  
  model S4
  M m(
    
    B = 6,
    Z = 5,a = 3,
    b = 14,
    z = 2)  annotation(
      Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  
  end S4;


end TestModifierOrder;
