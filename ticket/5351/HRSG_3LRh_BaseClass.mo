partial model HRSG_3LRh_BaseClass
"Base class for Heat Recovery Steam Generator with three pressure levels and reheat"
  replaceable package FlueGasMedium = ThermoPower.Media.FlueGas
    constrainedby Modelica.Media.Interfaces.PartialMedium;
  replaceable package FluidMedium = ThermoPower.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;

  ThermoPower.Water.FlangeA WaterIn(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{140,-220},{180,-180}},
          rotation=0)));

  ThermoPower.Water.FlangeB Sh_HP_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-180,-220},{-140,-180}},
          rotation=0)));
  ThermoPower.Gas.FlangeA GasIn(redeclare package Medium = FlueGasMedium) annotation (
     Placement(transformation(extent={{-220,-60},{-180,-20}}, rotation=0)));
  ThermoPower.Gas.FlangeB GasOut(redeclare package Medium = FlueGasMedium)
    annotation (Placement(transformation(extent={{180,-60},{220,-20}},
          rotation=0)));
  ThermoPower.Water.FlangeA Rh_IP_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-120,-220},{-80,-180}},
          rotation=0)));
  ThermoPower.Water.FlangeB Rh_IP_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-60,-220},{-20,-180}},
          rotation=0)));
  ThermoPower.Water.FlangeB Sh_LP_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{60,-220},{100,-180}},
          rotation=0)));
  ThermoPower.PowerPlants.Buses.Sensors SensorsBus annotation (Placement(transformation(extent={{
            180,140},{220,180}}, rotation=0)));
  ThermoPower.PowerPlants.Buses.Actuators ActuatorsBus annotation (Placement(transformation(
          extent={{220,80},{180,120}}, rotation=0)));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
                extent={{-200,200},{200,-200}},
                lineColor={170,170,255},
                fillColor={230,230,230},
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-140,160},{-80,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Polygon(
                points={{-140,130},{-80,130},{-80,134},{-80,134},{-82,142},
            {-84,146},{-88,152},{-94,156},{-98,158},{-106,160},{-110,160},
            {-114,160},{-122,158},{-126,156},{-132,152},{-136,146},{-138,
            142},{-140,134},{-140,130}},
                lineColor={0,0,255},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-30,160},{30,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Polygon(
                points={{-30,130},{30,130},{30,134},{30,134},{28,142},{26,
            146},{22,152},{16,156},{12,158},{4,160},{0,160},{-4,160},{-12,
            158},{-16,156},{-22,152},{-26,146},{-28,142},{-30,134},{-30,
            130}},
                lineColor={0,0,255},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{80,160},{140,100}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),Polygon(
                points={{80,130},{140,130},{140,134},{140,134},{138,142},
            {136,146},{132,152},{126,156},{122,158},{114,160},{110,160},{
            106,160},{98,158},{94,156},{88,152},{84,146},{82,142},{80,134},
            {80,130}},
                lineColor={0,0,255},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid),Rectangle(
                extent={{-200,60},{200,-140}},
                lineColor={170,170,255},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),Line(
                points={{-110,60},{-110,20},{-70,0},{-150,-40},{-70,-80},
            {-110,-100},{-110,-140}},
                color={0,0,255},
                thickness=0.5),Line(
                points={{0,60},{0,20},{40,0},{-40,-40},{40,-80},{0,-100},
            {0,-140}},
                color={0,0,255},
                thickness=0.5),Line(
                points={{110,60},{110,20},{150,0},{70,-40},{150,-80},{110,
            -100},{110,-140}},
                color={0,0,255},
                thickness=0.5)}), Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics));
end HRSG_3LRh_BaseClass;
