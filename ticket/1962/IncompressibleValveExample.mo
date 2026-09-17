within ;
package IncompressibleValveExample

  model Two_Port_Valve
        import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;

    parameter Real[3] body_r_start={0,0,0};
    parameter Real[3] body_v_start={0,0,0};
      parameter Real mass=1;
    parameter Boolean has_mass=true;
    parameter Real J_xxyyzz[3]={1,1,1};
    parameter Real c_of_g_position[3]={0,0,0};
    parameter SI.Position[3,3] transform_mount_01 = [0, 0, 0; 1, 0, 0; 0, 1, 0];

  package Transported_Fluid
                            extends
        Modelica.Media.Interfaces.PartialSimpleMedium(
      mediumName="SimpleLiquidWater",
      cp_const=4184,
      cv_const=4184,
      d_const=995.586,
      eta_const=1.e-3,
      lambda_const=0.598,
      a_const=1484,
      T_min=Cv.from_degC(-1),
      T_max=Cv.from_degC(200),
      T0=273.15,
      MM_const=0.018015268,
      fluidConstants=Modelica.Media.Water.simpleWaterConstants);
  end Transported_Fluid;

    Modelica.Fluid.Valves.ValveIncompressible valveIncompressible(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      dp_nominal=dp_nominal,
      m_flow_nominal=m_flow_nominal,
      redeclare function valveCharacteristic =
          Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.quadratic)
                          annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={2,-76})));
    Modelica.Blocks.Math.BooleanToReal        switch1 annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={2,-6})));
    Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=-90,
          origin={2,60}),    iconTransformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={0,52})));
    replaceable package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater;

    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
    parameter Modelica.SIunits.Pressure dp_nominal;
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_nominal
      "Nominal mass flowrate";
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r=
          c_of_g_position) if has_mass and world.driveTrainMechanics3D
      annotation (Placement(transformation(extent={{58,-106},{78,-86}})));
    Modelica.Mechanics.MultiBody.Parts.Body body_mass(
      animation=false,
      m=mass,
      I_11=J_xxyyzz[1],
      I_22=J_xxyyzz[2],
      I_33=J_xxyyzz[3],
      r_CM={0,0,0},
      r_0(start=body_r_start),
      v_0(start=body_v_start),
      angles_fixed=false,
      w_0_fixed=false) if    has_mass and world.driveTrainMechanics3D
                annotation (Placement(transformation(extent={{98,-106},{118,-86}})));
    Modelica.Mechanics.MultiBody.Parts.FixedRotation origin_to_mount_01_transform(
      r=transform_mount_01[1,:],
      rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors,
      n_x=transform_mount_01[2,:],
      n_y=transform_mount_01[3,:]) if world.driveTrainMechanics3D
             annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-2,-176})));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a mount_01 if world.driveTrainMechanics3D annotation (Placement(
          transformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={-2,-196}), iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=90,
          origin={0,-140})));
    outer Modelica.Mechanics.MultiBody.World world
      annotation (Placement(transformation(extent={{-200,40},{-180,60}})));
    Modelica.Fluid.Interfaces.FluidPort_a fluid_in(redeclare package Medium =
          Transported_Fluid)
      annotation (Placement(transformation(extent={{-208,-52},{-188,-32}}),
          iconTransformation(extent={{-208,-52},{-188,-32}})));
    Modelica.Fluid.Interfaces.FluidPort_b fluid_out(redeclare package Medium =
          Transported_Fluid)
      annotation (Placement(transformation(extent={{192,-50},{212,-30}}),
          iconTransformation(extent={{192,-50},{212,-30}})));
  equation
    connect(switch1.y, valveIncompressible.opening) annotation (Line(
        points={{2,-12.6},{2,-40.3},{2,-40.3},{2,-68}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(switch1.u, u) annotation (Line(
        points={{2,1.2},{2,30.6},{2,30.6},{2,60}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(fluid_in, valveIncompressible.port_a) annotation (Line(
        points={{-198,-42},{-103,-42},{-103,-76},{-8,-76}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(valveIncompressible.port_b, fluid_out) annotation (Line(
        points={{12,-76},{107,-76},{107,-40},{202,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(fixedTranslation.frame_b,body_mass. frame_a)      annotation (Line(
        points={{78,-96},{98,-96}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(origin_to_mount_01_transform.frame_b,mount_01)  annotation (Line(
        points={{-2,-186},{-2,-196}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(origin_to_mount_01_transform.frame_a, fixedTranslation.frame_a)
      annotation (Line(
        points={{-2,-166},{-2,-132},{58,-132},{58,-96}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,
              -200},{200,60}}),
                        graphics), Icon(coordinateSystem(extent={{-200,-200},{
              200,60}}, preserveAspectRatio=true),
                                        graphics={Rectangle(
            extent={{-200,60},{200,-140}},
            lineColor={0,0,255},
            lineThickness=1)}));
  end Two_Port_Valve;

  model Test_Two_Port_Valve

  inner Modelica.Mechanics.MultiBody.World world;

  replaceable package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
    Modelica.Fluid.Sources.Boundary_pT inlet(
      p=200000,
      redeclare package Medium =
          Medium,
      nPorts=1) annotation (Placement(transformation(extent={{-66,0},{-46,20}})));
    Modelica.Fluid.Sources.Boundary_pT outlet(
      p=100000,
      redeclare package Medium =
          Medium,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={54,10})));
    Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=1)
      annotation (Placement(transformation(extent={{50,48},{30,68}})));
    Two_Port_Valve two_Port_Valve(m_flow_nominal=0.3333,
      body_r_start={0,0,0},
      body_v_start={0,0,0},
      dp_nominal=200000000)
      annotation (Placement(transformation(extent={{-22,-8},{16,10}})));
  equation

    connect(inlet.ports[1], two_Port_Valve.fluid_in) annotation (Line(
        points={{-46,10},{-28,10},{-28,5.16842},{-21.81,5.16842}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(two_Port_Valve.u, booleanStep.y) annotation (Line(
        points={{-3,9.62105},{-3,58},{29,58}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(two_Port_Valve.fluid_out, outlet.ports[1]) annotation (Line(
        points={{16.19,5.26316},{30.095,5.26316},{30.095,10},{44,10}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(graphics),
      experiment(StopTime=2),
      __Dymola_experimentSetupOutput);
  end Test_Two_Port_Valve;
  annotation (uses(Modelica(version="3.2")));
end IncompressibleValveExample;
