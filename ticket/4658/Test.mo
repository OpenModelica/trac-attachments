package Test
model A
  type ActionType = enumeration (direct "action is direct",
                                 reverse "action is reverse");
end A;

model B
  extends A;
  parameter ActionType action1;
  parameter Test.A.ActionType action2;
end B;

model C
    B b1 annotation(
      Placement(visible = true, transformation(origin = {-50, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
end C;  
end Test;
