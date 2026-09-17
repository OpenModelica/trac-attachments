partial model A
end A;

model B
end B;

model C
  replaceable B b1 constrainedby A annotation(Placement(transformation(extent = {{-110, -20}, {-80, 10}})));
end C;