package Pendulum
extends Modelica.Icons.Package;
  model Pendulum_N_MultiBody
    extends Modelica.Icons.Example;
    constant Integer N = 2 "Number of individual elements";
    parameter Real L = 1 "Total length";
    parameter Real d = 0.05 "Diameter";
    parameter Real D = 0.01/L "damping";

    inner Modelica.Mechanics.MultiBody.World world(enableAnimation=false)
      annotation (Placement(transformation(extent={{-46,6},{-26,26}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute revolute[N](each useAxisFlange=true, phi(start=cat(1,{-0.3}, zeros(N-1)), each fixed=true), w(each start=0, each fixed=true))
      annotation (Placement(transformation(extent={{-6,6},{14,26}})));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder[N](each r={L/N,0,0},
        each diameter=d)
      annotation (Placement(transformation(extent={{34,6},{54,26}})));
    Modelica.Mechanics.Rotational.Components.Damper damper[N](each d=D)
      annotation (Placement(transformation(extent={{-10,40},{12,60}})));
  equation
    connect(world.frame_b, revolute[1].frame_a) annotation (Line(
        points={{-26,16},{-6,16}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
        points={{14,16},{34,16}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bodyCylinder[1:N-1].frame_b, revolute[2:N].frame_a) annotation (Line(
        points={{54,16},{64,16},{64,-8},{-16,-8},{-16,16},{-6,16}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(damper.flange_a, revolute.support) annotation (Line(
        points={{-10,50},{-10,36},{-2,36},{-2,26}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(damper.flange_b, revolute.axis) annotation (Line(
        points={{12,50},{12,36},{4,36},{4,26}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
            preserveAspectRatio=false),
                        graphics), Icon(coordinateSystem(extent={{-100,-100},{
              100,100}})),
      experiment(StopTime=10));
  end Pendulum_N_MultiBody;

  model Pendulum_3DN_MultiBody
    extends Modelica.Icons.Example;
    constant Integer N = 4 "Number of individual elements";
    parameter Real L = 1 "Total length";
    parameter Real d = 0.05 "Diameter";
    parameter Real D = 0.01/L "damping";

    function getAxis
      input Integer i;
      output Real axis[3];
    algorithm
      if (rem(i,2) == 0) then
        axis := {0,1,0};
      else
        axis := {0,0,1};
      end if;
    end getAxis;

    inner Modelica.Mechanics.MultiBody.World world(enableAnimation=false)
      annotation (Placement(transformation(extent={{-46,6},{-26,26}})));
    Modelica.Mechanics.MultiBody.Joints.Revolute revolute[N](each useAxisFlange=true, n={getAxis(i) for i in 1:N}, phi(each start=-1, each fixed=true), w(each start=0, each fixed=true))
      annotation (Placement(transformation(extent={{-6,6},{14,26}})));
    Modelica.Mechanics.MultiBody.Parts.BodyCylinder bodyCylinder[N](each r={L/N,0,0},
        each diameter=d)
      annotation (Placement(transformation(extent={{34,6},{54,26}})));
    Modelica.Mechanics.Rotational.Components.Damper damper[N](each d=D)
      annotation (Placement(transformation(extent={{-10,40},{12,60}})));
  equation
    connect(world.frame_b, revolute[1].frame_a) annotation (Line(
        points={{-26,16},{-6,16}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
        points={{14,16},{34,16}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(bodyCylinder[1:N-1].frame_b, revolute[2:N].frame_a) annotation (Line(
        points={{54,16},{64,16},{64,-8},{-16,-8},{-16,16},{-6,16}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(damper.flange_a, revolute.support) annotation (Line(
        points={{-10,50},{-10,36},{-2,36},{-2,26}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(damper.flange_b, revolute.axis) annotation (Line(
        points={{12,50},{12,36},{4,36},{4,26}},
        color={0,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
            preserveAspectRatio=false),
                        graphics), Icon(coordinateSystem(extent={{-100,-100},{
              100,100}})),
      experiment(StopTime=10));
  end Pendulum_3DN_MultiBody;

  model Pendulum_10
    extends Pendulum_N_MultiBody(N = 10);
  end Pendulum_10;

  model Pendulum_20
    extends Pendulum_N_MultiBody(N = 20);
  end Pendulum_20;

  model Pendulum_30
    extends Pendulum_N_MultiBody(N = 30);
  end Pendulum_30;

  model Pendulum_40
    extends Pendulum_N_MultiBody(N = 40);
  end Pendulum_40;

  model Pendulum_50
    extends Pendulum_N_MultiBody(N = 50);
  end Pendulum_50;

  model Pendulum_60
    extends Pendulum_N_MultiBody(N = 60);
  end Pendulum_60;

  model Pendulum_70
    extends Pendulum_N_MultiBody(N = 70);
  end Pendulum_70;

  model Pendulum_80
    extends Pendulum_N_MultiBody(N = 80);
  end Pendulum_80;

  model Pendulum_90
    extends Pendulum_N_MultiBody(N = 90);
  end Pendulum_90;

  model Pendulum_100
    extends Pendulum_N_MultiBody(N = 100);
  end Pendulum_100;

  model Pendulum_110
    extends Pendulum_N_MultiBody(N = 110);
  end Pendulum_110;

  model Pendulum_120
    extends Pendulum_N_MultiBody(N = 120);
  end Pendulum_120;

  model Pendulum_130
    extends Pendulum_N_MultiBody(N = 130);
  end Pendulum_130;

  model Pendulum_140
    extends Pendulum_N_MultiBody(N = 140);
  end Pendulum_140;

  model Pendulum_150
    extends Pendulum_N_MultiBody(N = 150);
  end Pendulum_150;

  model Pendulum3D_10
    extends Pendulum_3DN_MultiBody(N = 10);
  end Pendulum3D_10;

  model Pendulum3D_20
    extends Pendulum_3DN_MultiBody(N = 20);
  end Pendulum3D_20;

  model Pendulum3D_30
    extends Pendulum_3DN_MultiBody(N = 30);
  end Pendulum3D_30;

  model Pendulum3D_40
    extends Pendulum_3DN_MultiBody(N = 40);
  end Pendulum3D_40;

  model Pendulum3D_50
    extends Pendulum_3DN_MultiBody(N = 50);
  end Pendulum3D_50;

  model Pendulum3D_60
    extends Pendulum_3DN_MultiBody(N = 60);
  end Pendulum3D_60;

  model Pendulum3D_70
    extends Pendulum_3DN_MultiBody(N = 70);
  end Pendulum3D_70;

  model Pendulum3D_80
    extends Pendulum_3DN_MultiBody(N = 80);
  end Pendulum3D_80;

  model Pendulum3D_90
    extends Pendulum_3DN_MultiBody(N = 90);
  end Pendulum3D_90;

  model Pendulum3D_100
    extends Pendulum_3DN_MultiBody(N = 100);
  end Pendulum3D_100;

  model Pendulum3D_110
    extends Pendulum_3DN_MultiBody(N = 110);
  end Pendulum3D_110;

  model Pendulum3D_120
    extends Pendulum_3DN_MultiBody(N = 120);
  end Pendulum3D_120;

  model Pendulum3D_130
    extends Pendulum_3DN_MultiBody(N = 130);
  end Pendulum3D_130;

  model Pendulum3D_140
    extends Pendulum_3DN_MultiBody(N = 140);
  end Pendulum3D_140;

  model Pendulum3D_150
    extends Pendulum_3DN_MultiBody(N = 150);
  end Pendulum3D_150;

end Pendulum;
