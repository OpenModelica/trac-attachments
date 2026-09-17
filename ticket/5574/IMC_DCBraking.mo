within ;
package IMC_DCBraking
  extends Modelica.Icons.ExamplesPackage;

  partial model DCBraking_Template
    "Induction machine with DC current braking"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    constant Integer m=3 "Number of phases";
    parameter Modelica.SIunits.Current INominal=100 "Nominal RMS current per phase";
    parameter Modelica.SIunits.Current Idc "DC braking current";
    parameter Modelica.SIunits.Current is[3] "Phase currents";
    parameter Modelica.SIunits.AngularVelocity w0(displayUnit="rev/min")=
      2*pi*imcData.fsNominal/imcData.p "Initial mehcanical speed";
    parameter Modelica.SIunits.Inertia JLoad=4*imcData.Jr
      "Load's moment of inertia";
    Modelica.SIunits.Torque tauElectrical=imc.tauElectrical "Electrical torque";
    Modelica.SIunits.Torque tauShaft=imc.tauShaft "Shaft torque";
    Modelica.SIunits.AngularVelocity wMechanical(displayUnit="rev/min") = imc.wMechanical
      "Shaft speed";
    parameter
      Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData
      imcData annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
    Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
      imc(
      p=imcData.p,
      fsNominal=imcData.fsNominal,
      Rs=imcData.Rs,
      TsRef=imcData.TsRef,
      alpha20s(displayUnit="1/K") = imcData.alpha20s,
      Lssigma=imcData.Lssigma,
      Jr=imcData.Jr,
      Js=imcData.Js,
      Lszero=imcData.Lszero,
      frictionParameters=imcData.frictionParameters,
      phiMechanical(fixed=true, start=0),
      wMechanical(fixed=true, start=w0),
      statorCoreParameters=imcData.statorCoreParameters,
      strayLoadParameters=imcData.strayLoadParameters,
      Lm=imcData.Lm,
      Lrsigma=imcData.Lrsigma,
      Rr=imcData.Rr,
      TrRef=imcData.TrRef,
      TsOperational=293.15,
      alpha20r=imcData.alpha20r,
      TrOperational=293.15)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    Modelica.Electrical.Machines.Utilities.TerminalBox
      terminalBox(m=m)
      annotation (Placement(transformation(extent={{20,6},{40,26}})));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin1(m=m, k=1)
      annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin2(m=m, k=2)
      annotation (Placement(transformation(extent={{-20,30},{-40,50}})));
    Modelica.Electrical.Analog.Sources.ConstantCurrent
      constantCurrent(I=Idc)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,62})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
  initial equation
    der(imc.idq_rs[1])=0;
    der(imc.idq_rs[2])=0;
  equation
    connect(imc.flange, loadInertia.flange_a)
      annotation (Line(points={{40,0},{50,0}}, color={0,0,0}));
    connect(plugToPin1.pin_p, constantCurrent.n)
      annotation (Line(points={{-32,80},{-50,80},{-50,72}}, color={0,0,255}));
    connect(plugToPin2.pin_p, constantCurrent.p)
      annotation (Line(points={{-32,40},{-50,40},{-50,52}}, color={0,0,255}));
    connect(plugToPin2.plug_p, plugToPin1.plug_p) annotation (Line(points={{-28,40},
            {-20,40},{-20,80},{-28,80}}, color={0,0,255}));
    connect(terminalBox.plug_sn, imc.plug_sn)
      annotation (Line(points={{24,10},{24,10}}, color={0,0,255}));
    connect(terminalBox.plug_sp, imc.plug_sp)
      annotation (Line(points={{36,10},{36,10}}, color={0,0,255}));
    connect(plugToPin2.plug_p, terminalBox.plugSupply)
      annotation (Line(points={{-28,40},{30,40},{30,12}}, color={0,0,255}));
    connect(plugToPin2.pin_p, ground.p)
      annotation (Line(points={{-32,40},{-60,40}}, color={0,0,255}));
    annotation (experiment(
        StopTime=25,
        Interval=0.001,
        Tolerance=1e-06,
        __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>
The stator windings of an induction machine are fed by a DC current, causing a stationary current space phasor. 
Since the rotor is turning, voltage is induced in the rotor cage which in turn drives rotor currents. 
This creates a braking torque.
</p>
<p>
Choose a layout and plot tauElectrical and tauShaft versus wMechanical.
</p>
<p>Default machine parameters are used.</p>
<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Fischer2017]</td>
      <td>R. Fischer, 
         Elektrische Maschinen, 17<sup>th</sup> ed., chapter 5.3.3.,
        <em>Hanser</em>,
        ISBN 978-3-446-45218-3, 2017.</td>
    </tr>
</html>"));
  end DCBraking_Template;

  model DCBraking_Y3 "Induction machine with DC current braking"
    extends DCBraking_Template(
      terminalBox(terminalConnection="Y"),
      Idc=INominal*sqrt(2),
      is=Idc*{1,-1/2,-1/2});
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin3(m=m, k=3)
      annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  initial equation
    imc.is[2]=is[2];
  equation
    connect(plugToPin2.plug_p, plugToPin3.plug_p) annotation (Line(points={{-28,40},
            {-20,40},{-20,0},{-28,0}}, color={0,0,255}));
    connect(constantCurrent.p, plugToPin3.pin_p)
      annotation (Line(points={{-50,52},{-50,0},{-32,0}}, color={0,0,255}));
    annotation (experiment(
        StopTime=25,
        Interval=0.001,
        Tolerance=1e-06,
        __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>
The stator windings of an induction machine are fed by a DC current, causing a stationary current space phasor. 
Since the rotor is turning, voltage is induced in the rotor cage which in turn drives rotor currents. 
This creates a braking torque.
</p>
<p>
Choose a layout and plot tauElectrical and tauShaft versus wMechanical.
</p>
<p>Default machine parameters are used.</p>
<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Fischer2017]</td>
      <td>R. Fischer, 
         Elektrische Maschinen, 17<sup>th</sup> ed., chapter 5.3.3.,
        <em>Hanser</em>,
        ISBN 978-3-446-45218-3, 2017.</td>
    </tr>
</html>"));
  end DCBraking_Y3;

  model DCBraking_Y2 "Induction machine with DC current braking"
    extends DCBraking_Template(
      terminalBox(terminalConnection="Y"),
      Idc=INominal*sqrt(3/2),
      is=Idc*{1,-1,0});
  initial equation
    annotation (experiment(
        StopTime=25,
        Interval=0.001,
        Tolerance=1e-06,
        __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>
The stator windings of an induction machine are fed by a DC current, causing a stationary current space phasor. 
Since the rotor is turning, voltage is induced in the rotor cage which in turn drives rotor currents. 
This creates a braking torque.
</p>
<p>
Choose a layout and plot tauElectrical and tauShaft versus wMechanical.
</p>
<p>Default machine parameters are used.</p>
<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Fischer2017]</td>
      <td>R. Fischer, 
         Elektrische Maschinen, 17<sup>th</sup> ed., chapter 5.3.3.,
        <em>Hanser</em>,
        ISBN 978-3-446-45218-3, 2017.</td>
    </tr>
</html>"));
  end DCBraking_Y2;

  model DCBraking_D2 "Induction machine with DC current braking"
    extends DCBraking_Template(
      terminalBox(terminalConnection="D"),
      Idc=INominal*3/sqrt(2),
      is=Idc*{2/3,-1/3,-1/3});
  initial equation
    imc.is[2]=is[2];
    annotation (experiment(
        StopTime=25,
        Interval=0.001,
        Tolerance=1e-06,
        __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>
The stator windings of an induction machine are fed by a DC current, causing a stationary current space phasor. 
Since the rotor is turning, voltage is induced in the rotor cage which in turn drives rotor currents. 
This creates a braking torque.
</p>
<p>
Choose a layout and plot tauElectrical and tauShaft versus wMechanical.
</p>
<p>Default machine parameters are used.</p>
<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Fischer2017]</td>
      <td>R. Fischer, 
         Elektrische Maschinen, 17<sup>th</sup> ed., chapter 5.3.3.,
        <em>Hanser</em>,
        ISBN 978-3-446-45218-3, 2017.</td>
    </tr>
</html>"));
  end DCBraking_D2;

  model DCBraking_D3 "Induction machine with DC current braking"
    extends DCBraking_Template(
      terminalBox(terminalConnection="D"),
      Idc=INominal*sqrt(6),
      is=Idc*{1/2,-1/2,0});
    Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin3(m=m, k=3)
      annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  initial equation
    der(imc.idq_ss[1])=0;
    der(imc.idq_ss[2])=0;
  equation
    connect(plugToPin2.plug_p, plugToPin3.plug_p) annotation (Line(points={{-28,40},
            {-20,40},{-20,0},{-28,0}}, color={0,0,255}));
    connect(constantCurrent.p, plugToPin3.pin_p)
      annotation (Line(points={{-50,52},{-50,0},{-32,0}}, color={0,0,255}));
    annotation (experiment(
        StopTime=25,
        Interval=0.001,
        Tolerance=1e-06,
        __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>
The stator windings of an induction machine are fed by a DC current, causing a stationary current space phasor. 
Since the rotor is turning, voltage is induced in the rotor cage which in turn drives rotor currents. 
This creates a braking torque.
</p>
<p>
Choose a layout and plot tauElectrical and tauShaft versus wMechanical.
</p>
<p>Default machine parameters are used.</p>
<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Fischer2017]</td>
      <td>R. Fischer, 
         Elektrische Maschinen, 17<sup>th</sup> ed., chapter 5.3.3.,
        <em>Hanser</em>,
        ISBN 978-3-446-45218-3, 2017.</td>
    </tr>
</html>"));
  end DCBraking_D3;
  annotation (uses(Modelica(version="3.2.3")));
end IMC_DCBraking;
