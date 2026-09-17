within Project1;
model SuspensionMechanism "Suspension mechanism for tutorials"
  extends
    VDLMotorsports.Chassis.Suspensions.Linkages.Templates.DoubleWishbonePushrodS1;
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation FromWishboneToPushrod(r=
        r0R1L1_scaled - r0L1L2U_scaled) annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={77,39})));
equation
  connect(pushrod.frame_a, FromWishboneToPushrod.frame_b) annotation (Line(
      points={{36,60},{77,60},{77,50}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(lowerWishbone.frame_b, FromWishboneToPushrod.frame_a) annotation (
      Line(
      points={{8,-70},{36,-70},{36,0},{77,0},{77,28}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SuspensionMechanism;
