package Test
  model A
    parameter Real p1, p2;
  end A;
  
  model B
    A a(final p1 = 10, p2 = 5) annotation(
      Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  end B;
  
  model C
    extends B(a(p1=100));
  end C;
end Test;
