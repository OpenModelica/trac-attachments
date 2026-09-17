package DragFolder
model DragForce "Vehicle rolling and aerodinamical drag force"
  import Modelica.Constants.g_n;
  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
  Modelica.SIunits.Force f "Total drag force";
  Modelica.SIunits.Velocity v "vehicle velocity";
  Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
  Real Sign;
  parameter Modelica.SIunits.Mass m "vehicle mass";
  parameter Modelica.SIunits.Density rho(start = 1.226) "air density";
  parameter Modelica.SIunits.Area S "vehicle cross area";
  parameter Real fc(start = 0.01) "rolling friction coefficient";
  parameter Real Cx "aerodinamic drag coefficient";
  final parameter Real A = fc * m * g_n;
  final parameter Real B = 1 / 2 * rho * S * Cx;
  final parameter Real mu[:, 2] = [0, 1];
  Real debug = f - B * v ^ 2 * Sign;
  // Constant auxiliary variable
equation
//  s = flange.s;
  v = der(s);
  a = der(v);
// Le seguenti definizioni seguono l'ordine e le richieste del modello "PartialFriction" di
// Modelica.Mechanics.Translational.Interfaces"
  v_relfric = v;
  a_relfric = a;
  f0 = A "Friction force for v_relfric=0 and forward sliding";
  f0_max = A "Maximum friction force for v_relfric=0 and locked";
  free = false "true when there is not wheel-road contact (never!)";
// Ora il calcolo di f, e la sua attribuzione alla flangia:
  flange.f - f = 0;
// friction force
  if v > 0 then
    Sign = 1;
  else
    Sign = -1;
  end if;
  f - B * v ^ 2 * Sign = if locked then sa * unitForce else f0 * (if startForward then Modelica.Math.Vectors.interpolate(mu[:, 1], mu[:, 2], v) else if startBackward then -Modelica.Math.Vectors.interpolate(mu[:, 1], mu[:, 2], -v) else if pre(mode) == Forward then Modelica.Math.Vectors.interpolate(mu[:, 1], mu[:, 2], v) else -Modelica.Math.Vectors.interpolate(mu[:, 1], mu[:, 2], -v));
  annotation(
    Documentation(info = "<html>
            <p>This component modesl the total (rolling and aerodynamic vehicle drag resistance: </p>
            <p>F=fc*m*g+(1/2)*rho*Cx*S*v^2</p>
            <p>It models reliably the stuck phase. Based on Modelica-Intrerfaces.PartialFriction model</p>
            </html>"),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-98, 10}, {22, 10}, {22, 41}, {92, 0}, {22, -41}, {22, -10}, {-98, -10}, {-98, 10}}, lineColor = {0, 127, 0}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Line(points = {{-42, -50}, {87, -50}}, color = {0, 0, 0}), Polygon(points = {{-72, -50}, {-41, -40}, {-41, -60}, {-72, -50}}, lineColor = {0, 0, 0}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid), Line(points = {{-90, -90}, {-70, -88}, {-50, -82}, {-30, -72}, {-10, -58}, {10, -40}, {30, -18}, {50, 8}, {70, 38}, {90, 72}, {110, 110}}, color = {0, 0, 255}, thickness = 0.5), Text(extent = {{-82, 90}, {80, 50}}, lineColor = {0, 0, 255}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics));
end DragForce;

  annotation(
    Icon(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end DragFolder;
