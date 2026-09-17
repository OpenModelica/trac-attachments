within ;
package EV_DAEissue "Package per semplici EV senza azionamenti"
  model EVbasic
    "Simulates an Electric Vehcile based on BASMADrive electric drive model"
    import Modelica;
    parameter Modelica.SIunits.Mass vMass=16000 "Vehicle mass";
    Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius=
          0.5715) annotation (Placement(visible=true, transformation(extent={{
              18,0},{38,20}}, rotation=0)));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation (
        Placement(visible=true, transformation(
          origin={78,-20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Mechanics.Translational.Components.Mass mass(m=vMass) annotation (
        Placement(visible=true, transformation(extent={{46,0},{66,20}},
            rotation=0)));
    DragForce dragF(
      m=vMass,
      Cx=0.65,
      rho=1.226,
      S=6.0,
      fc=0.013) annotation (Placement(visible=true, transformation(
          origin={110,-30},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-14,0},{6,20}})));
    Modelica.Blocks.Math.Gain gain1(k=1000) annotation (Placement(visible=true,
          transformation(
          origin={-34,10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{-74,0},{-54,20}})));
    Modelica.Blocks.Sources.Constant const(k=10)
      annotation (Placement(transformation(extent={{-102,0},{-82,20}})));
  equation
    connect(gain1.y, torque.tau)
      annotation (Line(points={{-23,10},{-16,10}}, color={0,0,127}));
    connect(dragF.flange, mass.flange_b)
      annotation (Line(points={{110,-20},{110,10},{66,10}}, color={0,127,0}));
    connect(mass.flange_b, velSens.flange)
      annotation (Line(points={{66,10},{78,10},{78,-10}}, color={0,127,0}));
    connect(wheel.flangeT, mass.flange_a)
      annotation (Line(points={{38,10},{46,10}}, color={0,127,0}));
    connect(wheel.flangeR, torque.flange)
      annotation (Line(points={{18,10},{6,10}}));
    connect(gain1.u, feedback.y)
      annotation (Line(points={{-46,10},{-50,10},{-55,10}}, color={0,0,127}));
    connect(feedback.u2, velSens.v) annotation (Line(points={{-64,2},{-64,2},{
            -64,-26},{-64,-44},{78,-44},{78,-31}}, color={0,0,127}));
    connect(feedback.u1, const.y)
      annotation (Line(points={{-72,10},{-81,10}}, color={0,0,127}));
    annotation (
      experimentSetupOutput(derivatives=false),
      Documentation(info="<html>
             <p>Modello Semplice di veicolo elettrico usato per l&apos;esercitazione di SEB a.a. 2011-12.</p>
             <p><h4>Nota operativa</h4></p>
             <p>Questa versione &egrave; inserita nella libreria EVQSPkg, che &egrave; autocontenuta</p>
              <p>OM 23136 OK </p>
             </html>"),
      Commands,
      Diagram(coordinateSystem(
          extent={{-120,-60},{120,60}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={2,2})),
      Icon(coordinateSystem(
          extent={{-120,-60},{120,60}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={2,2})),
      experiment(StopTime=80, Interval=0.1));
  end EVbasic;

  model DragForce "Vehicle rolling and aerodinamical drag force"
    import Modelica.Constants.g_n;
    extends
      Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
    extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
    Modelica.SIunits.Force f "Total drag force";
    Modelica.SIunits.Velocity v "vehicle velocity";
    Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
    Real Sign;
    parameter Modelica.SIunits.Mass m "vehicle mass";
    parameter Modelica.SIunits.Density rho(start=1.226) "air density";
    parameter Modelica.SIunits.Area S "vehicle cross area";
    parameter Real fc(start=0.01) "rolling friction coefficient";
    parameter Real Cx "aerodinamic drag coefficient";
  protected
    parameter Real A=fc*m*g_n;
    parameter Real B=1/2*rho*S*Cx;
    // Constant auxiliary variable
  equation
    //  s = flange.s;
    v = der(s);
    a = der(v);
    // Le seguenti definizioni seguono l'ordine e le ridchieste del modello "PartialFriction" di
    // Modelica.Mechanics.Translational.Interfaces"
    v_relfric = v;
    a_relfric = a;
    f0 = A "forza a velocit?  0 ma con scorrimento";
    f0_max = A "massima forza  velocit?  0 e senza scorrimento ";
    free = false "sarebbe true quando la ruota si stacca dalla strada";
    // Ora il calcolo di f, e la sua attribuzione alla flangia:
    flange.f - f = 0;
    // friction force
    if v > 0 then
      Sign = 1;
    else
      Sign = -1;
    end if;
    f - B*v^2*Sign = if locked then sa*unitForce else f0*(if startForward then
      Modelica.Math.tempInterpol1(
        v,
        [0, 1],
        2) else if startBackward then -Modelica.Math.tempInterpol1(
        -v,
        [0, 1],
        2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(
        v,
        [0, 1],
        2) else -Modelica.Math.tempInterpol1(
        -v,
        [0, 1],
        2));
    annotation (
      Documentation(info="<html>
            <p>This component modesl the total (rolling &egrave;+ aerrodynamic vehicle drag resistance: </p>
            <p>f=mgh+(1/2)*rho*Cx*S*v^2</p>
            <p>It models reliably the stuck phase. based on Modelica-Intrerfaces.PartialFriction model</p>
            </html>"),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Polygon(
            points={{-98,10},{22,10},{22,41},{92,0},{22,-41},{22,-10},{-98,-10},
                {-98,10}},
            lineColor={0,127,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(points={{-42,-50},{87,-50}}, color={0,0,0}),
          Polygon(
            points={{-72,-50},{-41,-40},{-41,-60},{-72,-50}},
            lineColor={0,0,0},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-90,-90},{-70,-88},{-50,-82},{-30,-72},{-10,-58},{10,-40},
                {30,-18},{50,8},{70,38},{90,72},{110,110}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-82,90},{80,50}},
            lineColor={0,0,255},
            textString="%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics));
  end DragForce;
  annotation (uses(Modelica(version="3.2.1")));
end EV_DAEissue;
