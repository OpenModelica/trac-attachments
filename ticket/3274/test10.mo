model test10
  inner PowerSystems.System system(sim = "st") annotation(Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Nodes.GroundOne grd1 annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sources.PQsource PQsource1(V_nom = 24000, S_nom = 50000000) annotation(Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Transformers.TrafoStray trafo(par = data, redeclare PowerSystems.AC3ph.Ports.Topology.Delta top_p) annotation(Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter PowerSystems.AC3ph.Transformers.Parameters.TrafoStray data(V_nom = {24000, 161000}, S_nom = 50000000, r = {0.022, 1}, x = {1.17, 52.65}) annotation(Placement(visible = true, transformation(origin = {0, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Nodes.GroundOne grd11 annotation(Placement(visible = true, transformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sources.InfBus infBus(V_nom = 161000) annotation(Placement(visible = true, transformation(origin = {54, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(trafo.term_n, infBus.term) annotation(Line(points = {{10, 0}, {44, 0}, {44, 0}, {44, 0}}, color = {0, 120, 120}));
  connect(infBus.neutral, grd11.term) annotation(Line(points = {{64, 0}, {82, 0}, {82, 0}, {82, 0}, {82, 0}}, color = {0, 0, 255}));
  connect(PQsource1.term, trafo.term_p) annotation(Line(points = {{-36, 0}, {-10, 0}, {-10, 0}, {-10, 0}}, color = {0, 120, 120}));
  connect(grd1.term, PQsource1.neutral) annotation(Line(points = {{-70, 0}, {-56, 0}, {-56, 0}, {-56, 0}}, color = {0, 0, 255}));
end test10;