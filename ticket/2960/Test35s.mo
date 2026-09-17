within ;
package Test35s "Electric and Hybrid Power train library Rev May 2016"
  //Character to force UTF usage in Dymola: €
  extends Modelica.Icons.Package;

  package MapBased
    "Contains map-based models of Internal combustion engines and electric drives"
    extends Modelica.Icons.Package;

    class Information
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>The map-based folder contains simple model whose only dynamics is due to their mechanical inertia.</p>
<p>The ice model, since implemnts an Internal Combustion Engine, can deliber power, but never absorbs, while the other, two (&QUOT;oneFlange&QUOT; and &QUOT;twoFlange&QUOT;) simulate electric drive trains, i.e. the assembly of an electric machine and the corresponding ACDC converter, can absorb or deliver.</p>
<p>The input torque of the ice model is in Newton-metres, whil e in the other cases it is normalised: it is between -1 and +1, where -1 means maximum available torque to be absorbed, +1 to be delivered.</p>
<p>All the models come in two versions:</p>
<ul>
<li>version without &QUOT;Conn&QUOT; in the name: they get the input signals from a Real input connector. The input signal indicates a torque request.</li>
<li>version with &QUOT;Conn&QUOT; in the name: they exchange several quantities through an expandable connector.</li>
</ul>
<p><br><u>Names and meaning </u>of the pre-defined quantities circulating through the connection bus in the model versions having &QUOT;Conn&QUOT; in their names.</p>
<p>All the names are composed by two or three parts. The first one indicates the component to which the variable refers, (for instance &QUOT;ice&QUOT;) the central one which kind of variable it is (for instance &QUOT;tau&QUOT; means torque), finally the(optional) third part indicates info about de variable for instance &QUOT;del&QUOT; means delivered, i.e.for a power a positivive value indicates that the power is delivered to the outside by the component the variable belongs to, the opposite happens when the third part of the name in &QUOT;abs&QUOT; (stands for absorbed). Another exmple is &QUOT;Norm&QUOT;: this third part of a name indicates that the correspondng quantity is normalised (see above in this info).</p>
<p><br><u>Full list</u> of the variables defined or used in the component of the MAP-based folder (other names that are used in the bus in the FullVehicle Examples, will be discussed in the examples themselves):</p>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\"><tr>
<td valign=\"top\"><p><br><i>Nome</i> </p></td>
<td valign=\"top\"><p>sender </p></td>
<td valign=\"top\"><p>users </p></td>
<td valign=\"top\"><p>comment</p></td>
</tr>
<tr>
<td valign=\"top\"><p>iceTauRef </p></td>
<td valign=\"top\"></td>
<td valign=\"top\"><p><br>Ice</p></td>
<td valign=\"top\"><p>torque reference sent to ice through Conn (Nm)</p></td>
</tr>
<tr>
<td valign=\"top\"><p>icePowDel</p></td>
<td valign=\"top\"><p>Ice</p></td>
<td valign=\"top\"><p> </p></td>
<td valign=\"top\"><p>the mechanical power the ice delivers</p></td>
</tr>
<tr>
<td valign=\"top\"><p>iceW</p></td>
<td valign=\"top\"><p>Ice</p></td>
<td valign=\"top\"></td>
<td valign=\"top\"><p><br>ice rotational speed (rad/s)</p></td>
</tr>
<tr>
<td valign=\"top\"><p>genTauNorm</p></td>
<td valign=\"top\"></td>
<td valign=\"top\"><p><br>OneFlange</p></td>
<td valign=\"top\"><p>normalised torque OneFlange  must deliver</p><p>It is used in examples in which OneFlange Instance is called &QUOT;gen&QUOT;</p></td>
</tr>
<tr>
<td valign=\"top\"><p>genTauLim</p></td>
<td valign=\"top\"><p>OneFlange</p></td>
<td valign=\"top\"></td>
<td valign=\"top\"><p><br>maximum (limit) torque OneFlance must deliver</p><p><br>It is used in examples in which OneFlange Instance is called &QUOT;gen&QUOT;</p></td>
</tr>
<tr>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
</tr>
<tr>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
<td valign=\"top\"></td>
</tr>
</table>
</html>"), uses(Modelica(version="3.2.1")));
    end Information;

    model MBiceConnP
      "Simple map-based ice model with connector; follows power request"
      extends Partial.PartialMBiceP;
      import Modelica.Constants.*;
      parameter Real vMass=1300;
      parameter Real wIceStart=167;
      // rad/s
      SupportModels.Conn conn annotation (Placement(
          visible=true,
          transformation(extent={{-20,-78},{20,-118}}, rotation=0),
          iconTransformation(extent={{-20,-78},{20,-118}}, rotation=0)));
      Modelica.Blocks.Continuous.Integrator tokgFuel(k=1/3.6e6) annotation (
          Placement(visible=true, transformation(
            origin={28,-70},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Modelica.Blocks.Math.Product product1 annotation (Placement(visible=true,
            transformation(
            origin={28,-40},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
    equation
      connect(tokW.y, product1.u2) annotation (Line(points={{-18,-29},{-18,-29},
              {-18,-36},{10,-36},{10,-20},{22,-20},{22,-28},{22,-28}}, color={0,
              0,127}));
      connect(feedback.u1, conn.icePowRef) annotation (Line(points={{-88,52},{-92,
              52},{-92,-98},{0,-98}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Pice.power, conn.icePowDel) annotation (Line(points={{68,63},{68,
              63},{68,6},{78,6},{78,-98},{0,-98}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(w.w, conn.iceW) annotation (Line(points={{58,25},{58,25},{58,6},{
              58,-98},{0,-98}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(product1.u1, toGramsPerkWh.y) annotation (Line(points={{34,-28},{
              34,-20},{42,-20},{42,-13}}, color={0,0,127}));
      connect(tokgFuel.u, product1.y) annotation (Line(points={{28,-58},{28,-51},
              {28,-51}}, color={0,0,127}));
      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            initialScale=0.1,
            extent={{-100,-100},{100,100}})),
        experiment(
          StopTime=200,
          __Dymola_NumberOfIntervals=1000,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Simple map-based ICE model for power-split power trains - with connector</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is a &QUOT;connector&QUOT; version of MBiceP.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">For a general descritiption see the info of MBiceP.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Signals connected to the connector:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowRef (input) is the power request (W). Negative values are internally converted to zero</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- iceW (output) is the measured ICE speed (rad/s)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowDel (output) delivered power (W)</span></p>
</html>"),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2})),
        uses(Modelica(version="3.2.2")));
    end MBiceConnP;

    model MBiceConnOO
      "Simple map-based ice model with connector; follows power request with ON-OFF"
      extends Partial.PartialMBiceP;
      import Modelica.Constants.*;
      parameter Real vMass=1300;
      parameter Real wIceStart=167;
      // rad/s
      SupportModels.Conn conn annotation (Placement(
          visible=true,
          transformation(extent={{-20,-78},{20,-118}}, rotation=0),
          iconTransformation(extent={{-20,-78},{20,-118}}, rotation=0)));
      Modelica.Blocks.Continuous.Integrator tokgFuel(k=1/3.6) annotation (
          Placement(visible=true, transformation(
            origin={38,-76},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      Modelica.Blocks.Logical.Switch switch1 annotation (Placement(visible=true,
            transformation(
            origin={2,-46},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(visible=
              true, transformation(extent={{-46,-74},{-26,-54}}, rotation=0)));
      Modelica.Blocks.Math.Product toG_perHour annotation (Placement(visible=
              true, transformation(
            origin={38,-42},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
    equation
      connect(toG_perHour.u1, toGramsPerkWh.y) annotation (Line(points={{44,-30},
              {42,-30},{42,-13},{42,-13}}, color={0,0,127}));
      connect(switch1.y, toG_perHour.u2) annotation (Line(points={{13,-46},{20,
              -46},{20,-22},{32,-22},{32,-30},{32,-30}}, color={0,0,127}));
      connect(toG_perHour.y, tokgFuel.u) annotation (Line(points={{38,-53},{38,
              -53},{38,-64},{38,-64}}, color={0,0,127}));
      connect(tokW.y, switch1.u1) annotation (Line(points={{-18,-29},{-18,-29},
              {-18,-38},{-10,-38},{-10,-38}}, color={0,0,127}));
      connect(switch1.u3, zero.y) annotation (Line(points={{-10,-54},{-18.5,-54},
              {-18.5,-64},{-25,-64}}, color={0,0,127}));
      connect(switch1.u2, conn.iceON) annotation (Line(points={{-10,-46},{-60,-46},
              {-60,-82},{0,-82},{0,-98}}, color={255,0,255}));
      connect(feedback.u1, conn.icePowRef) annotation (Line(points={{-88,52},{-88,
              52},{-88,-98},{0,-98}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(Pice.power, conn.icePowDel) annotation (Line(points={{68,63},{68,
              63},{68,6},{78,6},{78,-98},{0,-98}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(w.w, conn.iceW) annotation (Line(points={{58,25},{58,25},{58,6},{
              58,-98},{0,-98}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            initialScale=0.1,
            extent={{-100,-100},{100,100}})),
        experiment(
          StopTime=200,
          __Dymola_NumberOfIntervals=1000,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Simple map-based ICE model for power-split power trains - with connector</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is a &QUOT;connector&QUOT; version of MBiceP.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">For a general descritiption see the info of MBiceP.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Signals connected to the connector:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowRef (input) is the power request (W). Negative values are internally converted to zero</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- iceW (output) is the measured ICE speed (rad/s)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowDel (output) delivered power (W)</span></p>
</html>"),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2})),
        uses(Modelica(version="3.2.2")));
    end MBiceConnOO;

    model MBOneFlangeConn "Simple map-based one-flange electric drive "
      extends Partial.PartialMBOneFlange;
      SupportModels.Conn conn annotation (Placement(
          visible=true,
          transformation(extent={{-18,-60},{22,-100}}, rotation=0),
          iconTransformation(extent={{80,-58},{120,-98}}, rotation=0)));
      Modelica.Blocks.Sources.RealExpression mechPow(y=powSensor.power)
        annotation (Placement(transformation(extent={{38,-56},{18,-36}})));
    equation
      connect(createTau.u2, conn.genTauRef) annotation (Line(
          points={{-28,4},{-42,4},{-42,-68},{2,-68},{2,-80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(mechPow.y, conn.genPowDel) annotation (Line(
          points={{17,-46},{2,-46},{2,-80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(limTau.y, conn.genTauLim) annotation (Line(
          points={{15,30},{-36,30},{-36,30},{-42,30},{-42,-68},{2,-68},{2,-80}},

          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));

      connect(wSensor.w, conn.genW) annotation (Line(
          points={{78,35.2},{78,-68},{2,-68},{2,-80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (
        Diagram(coordinateSystem(
            extent={{-100,-80},{100,80}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={
            Line(points={{62,-7},{82,-7}}),
            Rectangle(extent={{-70,80},{100,-80}}),
            Line(points={{-98,40},{-70,40}}, color={0,0,255}),
            Line(points={{-92,-40},{-70,-40}}, color={0,0,255}),
            Text(
              origin={0,20},
              lineColor={0,0,255},
              extent={{-70,98},{100,60}},
              textString="%name")}),
        Documentation(info="<html>
<p>The input signal is interpreted as a <u>normalised</u> torque request (0 means null torque, 1 maximum availabile torque).</p>
<p>The maximum available torque is internally computed considering a direct torque maximum (tauMax) and a power maximum (powMax) </p>
<p>The requested torque is applied to a mechancal inertia. The inertia is interfaced by means ot two flanges with the exterior.</p>
<p>The model then computes the inner losses and absorbs the total power from the DC input.</p>
<p><br><u>Signals connected to the bus connecto</u>r (the names are chosen from the examples FullVehicles!PSecu1 and PSecu2 where the one-flange machine is called &QUOT;gen&QUOT;):</p>
<p>- genTauRef (input) is the torque request (Nm)</p>
<p>- genPowDel (output) is the delivered mechanical power (W)</p>
<p>- genTauLim (output) maximum available torque at the given machine rotational speed (Nm)</p>
</html>"));
    end MBOneFlangeConn;

    model MBTwoFlangeConn "Simple map-based two-flange electric drive model"
      extends Partial.PartialMBTwoFlange;
      SupportModels.Conn conn1 annotation (Placement(
          visible=true,
          transformation(extent={{-112,-58},{-72,-98}}, rotation=0),
          iconTransformation(extent={{-112,-58},{-72,-98}}, rotation=0)));
    equation
      connect(outBPow_.power, conn1.motPowDelB) annotation (Line(
          points={{64,39},{64,-78},{-92,-78},{-92,-78}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(speedRing.w, conn1.motW) annotation (Line(
          points={{-80,29},{-86,29},{-86,28},{-92,28},{-92,-78}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(add.y, conn1.motPowDelAB) annotation (Line(
          points={{28,-1},{28,-22},{78,-22},{78,-78},{-92,-78}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(createTau.u2, conn1.motTauRef) annotation (Line(
          points={{-20,-10},{-92,-10},{-92,-78}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={
            Rectangle(
              fillColor={192,192,192},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,10},{-66,-10}}),
            Rectangle(
              fillColor={192,192,192},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{66,8},{100,-12}}),
            Rectangle(origin={-25,2}, extent={{-75,74},{125,-74}}),
            Line(
              origin={20,-2},
              points={{-60,94},{-60,76}},
              color={0,0,255}),
            Line(
              origin={-20,-2},
              points={{60,94},{60,76}},
              color={0,0,255})}),
        Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Simple map-based ICE model for power-split power trains - with connector</b> </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is a &QUOT;connector&QUOT; version of MBice.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">For a general descritiption see the info of MBice.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Signals connected to the connector:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowRef (input) is the power request (W). Negative values are internally converted to zero</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- iceW (output) is the measured ICE speed (rad/s)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowDel (output) delivered power (W)</span></p>
</html>"));
    end MBTwoFlangeConn;

    package MBsupport "Useful Additional Models"
      extends Modelica.Icons.Package;

      model ToConnIceTauRef "signal adaptor to send iceTauRef to a connector"
        Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
              transformation(extent={{-94,-20},{-54,20}}), iconTransformation(
                extent={{-94,-20},{-54,20}})));
        SupportModels.Conn conn annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={60,0}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={60,0})));
      equation
        connect(u, conn.iceTauRef) annotation (Line(
            points={{-74,0},{60,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{
                  60,60}}), graphics={Rectangle(
                      extent={{-60,40},{60,-40}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(
                      points={{-38,0},{30,0}},
                      color={0,0,0},
                      smooth=Smooth.None),Polygon(
                      points={{42,0},{22,8},{22,-8},{42,0}},
                      lineColor={0,0,0},
                      smooth=Smooth.None,
                      fillColor={0,0,0},
                      fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}), graphics),
          Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Adapter for an input signal into &QUOT;iceTauRef&QUOT; signal in the library connector.</span></p>
</html>"));
      end ToConnIceTauRef;

      model ToConnGenTauRef "signal adaptor to send genTauRef to a connector"
        Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
              transformation(extent={{-90,-20},{-50,20}}), iconTransformation(
                extent={{-90,-20},{-50,20}})));
        SupportModels.Conn conn annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={58,0}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={58,0})));
      equation
        connect(u, conn.genTauRef) annotation (Line(
            points={{-70,0},{58,0}},
            color={0,0,127},
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{
                  60,60}}), graphics={Rectangle(
                      extent={{-60,40},{60,-40}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(
                      points={{-40,0},{32,0}},
                      color={0,0,0},
                      smooth=Smooth.None),Polygon(
                      points={{42,0},{22,8},{22,-8},{42,0}},
                      lineColor={0,0,0},
                      smooth=Smooth.None,
                      fillColor={0,0,0},
                      fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}}), graphics),
          Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Adapter for an input signal into &QUOT;genTauRef&QUOT; signal in the library connector.</span></p>
</html>"));
      end ToConnGenTauRef;

      package Internal
        "Models intended to be used by other models of this package, not by the final user"
        block LimTau "Torque limiter"
          Modelica.Blocks.Interfaces.RealInput w annotation (Placement(
                transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          parameter Real powMax(start=50000) "Maximum mechanical power (W)";
          parameter Real tauMax(start=400) "Maximum torque (Nm)";
          parameter Real wMax(start=1500, min=powMax/tauMax)
            "Maximum speed (rad/s)";
          Integer state
            "=0 below base speed; =1 before wMax; =2 in w limit, =3 above wMax";
          //0 or 1 if tauMax or powMax is delivered; =2 or 3 if w>wMax
        protected
          parameter Real alpha=0.10
            "fraction of wMax over which the torque is to be brought to zero";
        algorithm
          if w < powMax/tauMax then
            state := 0;
            y := tauMax;
          else
            state := 1;
            y := powMax/w;
          end if;
          //over wMax the torque max is to be rapidly brought to zero
          if w > wMax then
            if w < (1 + alpha)*wMax then
              state := 2;
              y := powMax/wMax*(1 - (w - wMax)/(alpha*wMax));
            else
              state := 3;
              y := 0;
            end if;
          end if;
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics),
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                          extent={{-100,60},{100,-60}},
                          lineColor={0,0,0},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Polygon(
                          points={{-4,34},{6,16},{22,2},{38,-10},{56,-16},{72,-18},
                    {72,-38},{12,-38},{-72,-38},{-72,34},{-4,34}},
                          lineColor={0,0,0},
                          smooth=Smooth.None,
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Line(
                          points={{-72,54},{-72,-40},{-74,-40}},
                          color={0,0,0},
                          thickness=0.5,
                          smooth=Smooth.None,
                          arrow={Arrow.Filled,Arrow.None}),Line(
                          points={{90,-38},{-74,-38}},
                          color={0,0,0},
                          thickness=0.5,
                          smooth=Smooth.None,
                          arrow={Arrow.Filled,Arrow.None}),Text(
                          extent={{-100,80},{96,52}},
                          lineColor={0,0,255},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid,
                          textString="%name
    "),Text(              extent={{70,-48},{84,-54}},
                          lineColor={0,0,255},
                          textString="W"),Text(
                          extent={{-96,48},{-82,42}},
                          lineColor={0,0,255},
                          textString="T")}),
            Documentation(info="<html>
<p>Gives the maximum output torque as a function of the input speed.</p>
<p>When w&LT;wMax the output is Tmax if Tmax*w&LT;Pnom, othersise it is Pnom/w</p>
<p>But if w is over wMax Tmax is rapidly falling to zero (reaches zero when speed overcomes wMax by 10&percnt;).</p>
<p>Torques and powers are in SI units</p>
</html>"));
        end LimTau;

        block Pel
          "Outputs a power signal computed from the given efficiency and input power"
          Modelica.Blocks.Interfaces.RealInput eta annotation (Placement(
                transformation(extent={{-140,-60},{-100,-20}})));
          Modelica.Blocks.Interfaces.RealInput P annotation (Placement(
                transformation(extent={{-140,20},{-100,60}})));
          Modelica.Blocks.Interfaces.RealOutput Pel
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        algorithm
          if noEvent(P <= 0) then
            Pel := P*eta;
          else
            Pel := P/eta;
          end if;
          annotation (
            Icon(graphics={Rectangle(
                          extent={{-92,56},{98,-48}},
                          lineColor={0,0,255},
                          fillColor={170,255,255},
                          fillPattern=FillPattern.Solid),Text(
                          extent={{-64,30},{48,-14}},
                          lineColor={0,0,255},
                          fillColor={170,255,255},
                          fillPattern=FillPattern.Solid,
                          textString="Pel")}),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics),
            Documentation(info="<html>
<pre><span style=\"font-family: Courier New,courier;\">Outputs&nbsp;a power signal computed from the&nbsp;given&nbsp;efficiency&nbsp;and&nbsp;input&nbsp;power</span></pre>
</html>"));
        end Pel;

        model InertiaTq "Inertia with added torque"
          import SI = Modelica.SIunits;
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
            "Left flange of shaft" annotation (Placement(transformation(extent=
                    {{-110,-10},{-90,10}}, rotation=0)));
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
            "Right flange of shaft" annotation (Placement(transformation(extent
                  ={{90,-10},{110,10}}, rotation=0)));
          parameter SI.Inertia J(min=0, start=1) "Moment of inertia";
          parameter StateSelect stateSelect=StateSelect.default
            "Priority to use phi and w as states"
            annotation (HideResult=true, Dialog(tab="Advanced"));
          SI.Angle phi(stateSelect=stateSelect)
            "Absolute rotation angle of component" annotation (Dialog(group=
                  "Initialization", showStartAttribute=true));
          SI.AngularVelocity w(stateSelect=stateSelect)
            "Absolute angular velocity of component (= der(phi))" annotation (
              Dialog(group="Initialization", showStartAttribute=true));
          SI.AngularAcceleration a
            "Absolute angular acceleration of component (= der(w))" annotation
            (Dialog(group="Initialization", showStartAttribute=true));
          Modelica.Blocks.Interfaces.RealInput tau annotation (Placement(
                transformation(
                extent={{-20.5,-20},{20.5,20}},
                rotation=90,
                origin={-54.5,-100})));
        equation
          phi = flange_a.phi;
          phi = flange_b.phi;
          w = der(phi);
          a = der(w);
          J*a = flange_a.tau + flange_b.tau + tau;
          annotation (
            Documentation(info="<html>
    <p>
    Rotational component with <b>inertia</b> and two rigidly connected flanges.
    </p>

    </HTML>
    "),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(
                          extent={{-100,10},{-50,-10}},
                          lineColor={0,0,0},
                          fillPattern=FillPattern.HorizontalCylinder,
                          fillColor={192,192,192}),Rectangle(
                          extent={{50,10},{100,-10}},
                          lineColor={0,0,0},
                          fillPattern=FillPattern.HorizontalCylinder,
                          fillColor={192,192,192}),Line(points={{-80,-25},{-60,
                  -25}}, color={0,0,0}),Line(points={{60,-25},{80,-25}}, color=
                  {0,0,0}),Line(points={{-70,-25},{-70,-70}}, color={0,0,0}),
                  Line(points={{70,-25},{70,-70}}, color={0,0,0}),Line(points={
                  {-80,25},{-60,25}}, color={0,0,0}),Line(points={{60,25},{80,
                  25}}, color={0,0,0}),Line(points={{-70,45},{-70,25}}, color={
                  0,0,0}),Line(points={{70,45},{70,25}}, color={0,0,0}),Line(
                  points={{-70,-70},{70,-70}}, color={0,0,0}),Rectangle(
                          extent={{-50,50},{50,-50}},
                          lineColor={0,0,0},
                          fillPattern=FillPattern.HorizontalCylinder,
                          fillColor={192,192,192}),Text(
                          extent={{-150,100},{150,60}},
                          textString="%name",
                          lineColor={0,0,255}),Text(
                          extent={{-150,-80},{150,-120}},
                          lineColor={0,0,0},
                          textString="J=%J")}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics));
        end InertiaTq;

        block ToElectricPower
          "Determines the electric power from the mechanical considering efficiency map"
          parameter Real tauMax(start=400) "Maximum machine torque(Nm)";
          parameter Real powMax(start=22000) "Maximum drive power";
          parameter Real wMax(start=650) "Maximum machine speed(rad/s)";
          parameter Real effTable[:, :]=[0.00, 0.00, 0.25, 0.50, 0.75, 1.00;
              0.00, 0.75, 0.80, 0.81, 0.82, 0.83; 0.25, 0.76, 0.81, 0.82, 0.83,
              0.84; 0.50, 0.77, 0.82, 0.83, 0.84, 0.85; 0.75, 0.78, 0.83, 0.84,
              0.85, 0.87; 1.00, 0.80, 0.84, 0.85, 0.86, 0.88];
          Modelica.Blocks.Tables.CombiTable2D effTable_(
            tableOnFile=false,
            smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
            table=effTable) "normalised efficiency" annotation (Placement(
                transformation(
                extent={{-14,-14},{14,14}},
                rotation=0,
                origin={18,-18})));
          Modelica.Blocks.Interfaces.RealInput w annotation (Placement(
                transformation(extent={{-140,-60},{-100,-20}}),
                iconTransformation(extent={{-140,-60},{-100,-20}})));
          Modelica.Blocks.Interfaces.RealInput tau annotation (Placement(
                transformation(extent={{-140,20},{-100,60}}),
                iconTransformation(extent={{-140,20},{-100,60}})));
          Modelica.Blocks.Interfaces.RealOutput elePow
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Math.Abs abs1 annotation (Placement(transformation(
                  extent={{-76,-50},{-56,-30}})));
          Modelica.Blocks.Math.Abs abs2
            annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
          Modelica.Blocks.Math.Gain normalizeTau(k=1/tauMax) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-36,50})));
          Pel pel
            annotation (Placement(transformation(extent={{60,-12},{84,10}})));
          Modelica.Blocks.Math.Product PMOT
            annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
          Modelica.Blocks.Math.Gain normalizeSpeed(k=1/wMax) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-34,-40})));
        equation
          connect(tau, abs2.u) annotation (Line(
              points={{-120,40},{-94,40},{-94,50},{-82,50}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(w, abs1.u) annotation (Line(
              points={{-120,-40},{-78,-40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(abs2.y, normalizeTau.u) annotation (Line(
              points={{-59,50},{-48,50}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(normalizeTau.y, effTable_.u1) annotation (Line(
              points={{-25,50},{-7.7,50},{-7.7,-9.6},{1.2,-9.6}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(pel.Pel, elePow) annotation (Line(
              points={{85.2,-1},{92.48,-1},{92.48,0},{110,0}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(effTable_.y, pel.eta) annotation (Line(
              points={{33.4,-18},{46,-18},{46,-5.4},{57.6,-5.4}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(PMOT.u1, tau) annotation (Line(
              points={{-74,16},{-84,16},{-84,40},{-120,40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(PMOT.u2, w) annotation (Line(
              points={{-74,4},{-84,4},{-84,-40},{-120,-40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(PMOT.y, pel.P) annotation (Line(
              points={{-51,10},{42,10},{42,3.4},{57.6,3.4}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(abs1.y, normalizeSpeed.u) annotation (Line(
              points={{-55,-40},{-46,-40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(normalizeSpeed.y, effTable_.u2) annotation (Line(
              points={{-23,-40},{-10,-40},{-10,-26.4},{1.2,-26.4}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
                    {100,80}}), graphics),
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                          extent={{-100,72},{100,-72}},
                          lineColor={0,0,0},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Line(
                          points={{-74,-54},{-74,58}},
                          color={0,0,0},
                          smooth=Smooth.None),Line(
                          points={{-82,-48},{78,-48}},
                          color={0,0,0},
                          smooth=Smooth.None),Line(
                          points={{-74,38},{-24,38},{-4,12},{28,-8},{60,-22},{
                    62,-48}},
                          color={0,0,0},
                          smooth=Smooth.None),Polygon(
                          points={{-20,14},{-40,24},{-56,-4},{-38,-36},{12,-38},
                    {26,-28},{22,-20},{8,-6},{-8,4},{-20,14}},
                          lineColor={0,0,0},
                          smooth=Smooth.None,
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Polygon(
                          points={{-28,4},{-38,2},{-32,-20},{0,-32},{10,-28},{
                    12,-20},{-28,4}},
                          lineColor={0,0,0},
                          smooth=Smooth.None,
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid),Text(
                          extent={{-102,118},{100,78}},
                          lineColor={0,0,255},
                          fillColor={255,255,255},
                          fillPattern=FillPattern.Solid,
                          textString="%name"),Text(
                          extent={{26,46},{76,4}},
                          lineColor={0,0,0},
                          textString="M")}),
            Documentation(info="<html>
<p>This block computes the machine and inverter losses from the mechanical input quantities and determines the power to be drawn from the electric circuit. The &QUOT;drawn&QUOT; power can be also a negative numer, meaning that themachine is actually delivering electric power.</p>
<p>The given efficiency map is intended as being built with torques being rations of actual torques to tauMax and speeds being ratios of w to wMax. In case the user uses, inthe given efficiency map,  torques in Nm and speeds in rad/s, the block can be used selecting tauTmax=1, wMax=1.</p>
<p>The choice of having normalised efficiency computation allows simulations of machines different in sizes and similar in characteristics to be repeated without having to rebuild the efficiency maps. </p>
</html>"));
        end ToElectricPower;
      end Internal;

      model ToConnIcePowRef "signal adaptor to send icePowRef to a connector"
        Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
              transformation(extent={{-94,-20},{-54,20}}), iconTransformation(
                extent={{-94,-20},{-54,20}})));
        SupportModels.Conn conn annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={60,0}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={60,0})));
      equation
        connect(u, conn.icePowRef) annotation (Line(points={{-74,0},{60,0},{60,
                0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{
                  60,60}}), graphics={Rectangle(
                      extent={{-60,40},{60,-40}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(
                      points={{-38,0},{30,0}},
                      color={0,0,0},
                      smooth=Smooth.None),Polygon(
                      points={{42,0},{22,8},{22,-8},{42,0}},
                      lineColor={0,0,0},
                      smooth=Smooth.None,
                      fillColor={0,0,0},
                      fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},
                  {60,60}})),
          Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Adapter for an input signal into &QUOT;icePowRef&QUOT; signal in the library connector.</span></p>
</html>"));
      end ToConnIcePowRef;
      annotation (Icon(graphics={
            Ellipse(extent={{-38,40},{38,-36}}, lineColor={0,0,0}),
            Line(
              points={{2,82},{-8,82},{-12,72},{-26,68},{-36,78},{-48,70},{-44,
                  58},{-56,46},{-68,50},{-76,36},{-68,30},{-70,16},{-80,12},{-80,
                  2}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{2,-78},{-8,-78},{-12,-68},{-26,-64},{-36,-74},{-48,-66},
                  {-44,-54},{-56,-42},{-68,-46},{-76,-32},{-68,-26},{-70,-12},{
                  -80,-8},{-80,2}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,-78},{10,-78},{14,-68},{28,-64},{38,-74},{50,-66},{46,
                  -54},{58,-42},{70,-46},{78,-32},{70,-26},{72,-12},{82,-8},{82,
                  2}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,82},{10,82},{14,72},{28,68},{38,78},{50,70},{46,58},{
                  58,46},{70,50},{78,36},{70,30},{72,16},{82,12},{82,2}},
              color={0,0,0},
              smooth=Smooth.None)}));
    end MBsupport;

    package Partial
      model PartialMBOneFlange
        "Partial map-based one-Flange electric drive model"
        parameter Real powMax=22000 "Maximum drive power  (W)";
        parameter Real tauMax=80 "Maximum drive torque (Nm)";
        parameter Real wMax(start=3000, min=powMax/tauMax)
          "Maximum drive speed (rad/s)";
        parameter Real J=0.25 "Rotor's moment of inertia (kg.m^2)";
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
          "Left flange of shaft" annotation (Placement(transformation(extent={{
                  88,50},{108,70}}, rotation=0), iconTransformation(extent={{90,
                  -10},{110,10}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor wSensor annotation (
            Placement(transformation(
              extent={{8,-8},{-8,8}},
              rotation=90,
              origin={78,44})));
        Modelica.Blocks.Math.Abs abs1
          annotation (Placement(transformation(extent={{62,16},{46,32}})));
        MBsupport.Internal.LimTau limTau(
          tauMax=tauMax,
          wMax=wMax,
          powMax=powMax)
          annotation (Placement(transformation(extent={{36,18},{16,42}})));
        MBsupport.Internal.ToElectricPower effMap(
          tauMax=tauMax,
          wMax=wMax,
          powMax=powMax)
          annotation (Placement(transformation(extent={{-6,-28},{-26,-8}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
            Placement(transformation(extent={{-110,30},{-90,50}}),
              iconTransformation(extent={{-110,30},{-90,50}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
            Placement(transformation(extent={{-110,-50},{-90,-30}}),
              iconTransformation(extent={{-110,-50},{-90,-30}})));
        SupportModels.Internal.ConstPDC constPDC(k=10, T=0.01) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-100,0})));
        Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J)
          annotation (Placement(transformation(extent={{22,50},{42,70}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque
          annotation (Placement(transformation(extent={{-16,50},{4,70}})));
        Modelica.Blocks.Math.Gain gain(k=1)
          annotation (Placement(transformation(extent={{-64,-10},{-84,10}})));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powSensor
          annotation (Placement(transformation(extent={{50,50},{70,70}})));
        Modelica.Blocks.Math.Min createTau annotation (Placement(visible=true,
              transformation(extent={{-26,0},{-6,20}}, rotation=0)));
      equation
        assert(wMax >= powMax/tauMax, "\n****\n" +
          "PARAMETER VERIFICATION ERROR:\nwMax must be not lower than powMax/tauMax"
           + "\n***\n");
        connect(abs1.u, wSensor.w) annotation (Line(
            points={{63.6,24},{78,24},{78,35.2}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(effMap.w, wSensor.w) annotation (Line(
            points={{-4,-22},{78,-22},{78,35.2}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(pin_p, constPDC.pin_p) annotation (Line(
            points={{-100,40},{-100,10}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(pin_n, constPDC.pin_n) annotation (Line(
            points={{-100,-40},{-100,-9.8}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(constPDC.Pref, gain.y) annotation (Line(
            points={{-91.8,0},{-85,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limTau.w, abs1.y) annotation (Line(
            points={{38,30},{42,30},{42,24},{45.2,24}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(powSensor.flange_b, flange_a) annotation (Line(
            points={{70,60},{98,60}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(wSensor.flange, flange_a) annotation (Line(
            points={{78,52},{78,60},{98,60}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(effMap.elePow, gain.u) annotation (Line(
            points={{-27,-18},{-46,-18},{-46,0},{-62,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(inertia.flange_a, torque.flange) annotation (Line(
            points={{22,60},{4,60}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(inertia.flange_b, powSensor.flange_a) annotation (Line(
            points={{42,60},{50,60}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(limTau.y, createTau.u1) annotation (Line(
            points={{15,30},{-40,30},{-40,16},{-28,16}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(createTau.y, torque.tau) annotation (Line(
            points={{-5,10},{6,10},{6,40},{-40,40},{-40,60},{-18,60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(createTau.y, effMap.tau) annotation (Line(
            points={{-5,10},{6,10},{6,-14},{-4,-14}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(
              extent={{-100,-80},{100,80}},
              preserveAspectRatio=false,
              initialScale=0.1,
              grid={2,2}), graphics),
          Icon(coordinateSystem(
              extent={{-100,-100},{100,100}},
              preserveAspectRatio=false,
              initialScale=0.1,
              grid={2,2}), graphics={
              Rectangle(
                extent={{-70,80},{100,-80}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-48,48},{52,-44}}),
              Line(points={{62,-7},{82,-7}}),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{52,10},{100,-10}}),
              Text(
                origin={-14,-36},
                extent={{-140,-54},{160,-94}},
                textString="J=%J"),
              Line(points={{-98,40},{-70,40}}, color={0,0,255}),
              Line(points={{-92,-40},{-70,-40}}, color={0,0,255}),
              Text(
                origin={0,20},
                lineColor={0,0,255},
                extent={{-70,98},{100,60}},
                textString="%name",
                fillPattern=FillPattern.Solid,
                fillColor={255,255,255})}),
          Documentation(info="<html>
<p>One-flange electric drive.</p>
<p>The input signal is the requested normalised torque (1 means nominal torque)</p>
</html>"));
      end PartialMBOneFlange;

      model PartialMBTwoFlange
        "Simple map-based two-flange electric drive model"
        parameter Real powMax(start=50000) "Maximum Mechanical drive power (W)";
        parameter Real tauMax(start=400) "Maximum drive Torque  (Nm)";
        parameter Real wMax(start=650) "Maximum drive speed (rad/s)";
        parameter Real J=0.59 "Moment of Inertia (kg.m^2)";
        //  Real state=limTau.state;
        MBsupport.Internal.LimTau limTau(
          tauMax=tauMax,
          wMax=wMax,
          powMax=powMax)
          annotation (Placement(transformation(extent={{-54,-8},{-32,14}})));
        MBsupport.Internal.InertiaTq inertia(w(displayUnit="rad/s", start=0), J
            =J) annotation (Placement(transformation(extent={{6,40},{26,60}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedRing annotation
          (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,40})));
        Modelica.Blocks.Math.Abs abs1
          annotation (Placement(transformation(extent={{-76,-4},{-62,10}})));
        MBsupport.Internal.ToElectricPower effMap(
          tauMax=tauMax,
          wMax=wMax,
          powMax=powMax)
          annotation (Placement(transformation(extent={{20,-46},{40,-26}})));
        SupportModels.Internal.ConstPDC constPDC(k=10, T=0.01) annotation (
            Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={0,100})));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor outBPow_
          annotation (Placement(transformation(extent={{62,40},{82,60}})));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor outAPow_
          annotation (Placement(transformation(extent={{-18,40},{-38,60}})));
        Modelica.Blocks.Math.Add add annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={28,10})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
          "Right flange of shaft" annotation (Placement(
            visible=true,
            transformation(extent={{90,40},{110,60}}, rotation=0),
            iconTransformation(extent={{90,-12},{110,8}}, rotation=0)));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
          "Left flange of shaft" annotation (Placement(
            visible=true,
            transformation(extent={{-110,40},{-90,60}}, rotation=0),
            iconTransformation(extent={{-110,-10},{-90,10}}, rotation=0)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
            Placement(
            visible=true,
            transformation(extent={{-70,90},{-50,110}}, rotation=0),
            iconTransformation(extent={{-50,88},{-30,108}}, rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
            Placement(
            visible=true,
            transformation(extent={{30,90},{50,110}}, rotation=0),
            iconTransformation(extent={{30,90},{50,110}}, rotation=0)));
        Modelica.Blocks.Math.Min createTau annotation (Placement(visible=true,
              transformation(extent={{-18,-14},{2,6}}, rotation=0)));
      equation
        connect(flange_a, speedRing.flange) annotation (Line(
            points={{-100,50},{-80,50}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(abs1.u, speedRing.w) annotation (Line(
            points={{-77.40000000000001,3},{-80,3},{-80,29}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limTau.w, abs1.y) annotation (Line(
            points={{-56.2,3},{-61.3,3}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(effMap.w, speedRing.w) annotation (Line(
            points={{18,-40},{-80,-40},{-80,29}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(pin_p, constPDC.pin_p) annotation (Line(
            points={{-60,100},{-10,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(pin_n, constPDC.pin_n) annotation (Line(
            points={{40,100},{9.8,100}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(effMap.elePow, constPDC.Pref) annotation (Line(
            points={{41,-36},{52,-36},{52,80},{0,80},{0,91.8}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(flange_b, outBPow_.flange_b) annotation (Line(
            points={{100,50},{82,50}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(inertia.flange_b, outBPow_.flange_a) annotation (Line(
            points={{26,50},{62,50}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(inertia.flange_a, outAPow_.flange_a) annotation (Line(
            points={{6,50},{-18,50}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(outAPow_.flange_b, speedRing.flange) annotation (Line(
            points={{-38,50},{-80,50}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(add.u1, outBPow_.power) annotation (Line(
            points={{34,22},{34,28},{64,28},{64,39}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(add.u2, outAPow_.power) annotation (Line(
            points={{22,22},{22,28},{-20,28},{-20,39}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(limTau.y, createTau.u1) annotation (Line(
            points={{-30.9,3},{-26,3},{-26,2},{-20,2}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(createTau.y, inertia.tau) annotation (Line(
            points={{3,-4},{10.55,-4},{10.55,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(effMap.tau, inertia.tau) annotation (Line(
            points={{18,-32},{10,-32},{10,-4},{10.55,-4},{10.55,40}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics),
          Icon(coordinateSystem(
              extent={{-100,-100},{100,100}},
              preserveAspectRatio=false,
              initialScale=0.1,
              grid={2,2}), graphics={
              Rectangle(
                origin={-25,2},
                extent={{-75,74},{125,-74}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                origin={4,-6},
                lineColor={0,0,255},
                extent={{-110,84},{100,44}},
                textString="%name"),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-64,38},{64,-44}}),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-100,10},{-64,-10}}),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{64,8},{100,-12}}),
              Line(
                origin={20,0},
                points={{-60,94},{-60,76}},
                color={0,0,255}),
              Line(
                origin={-20,0},
                points={{60,94},{60,76}},
                color={0,0,255}),
              Text(
                origin={66,-32},
                extent={{-108,-46},{100,-84}},
                textString="J=%J")}),
          Documentation(info="<html>
<p>This model receives from the connector the torque request (variable MotTauInt) and trieds to deliver it.</p>
<p>Howeve,r before delivering the requested torque, the model limits it considering the maximum deliverable torque and power. In addition it computes and considers inner losses as determined by means of a map. </p>
</html>"));
      end PartialMBTwoFlange;

      partial model PartialMBice
        "Simple  map-based Internal Combustion Engine model"
        import Modelica.Constants.*;
        parameter Real vMass=1300;
        parameter Real wIceStart=167;
        // rad/s
        parameter Real iceJ=0.5 "ICE moment of inertia (kg.m^2)";
        parameter Real maxIceTau[:, :]=[0, 80; 100, 80; 350, 95; 500, 95]
          "curve of maximum ice torque (Nm)";
        parameter Real specificCons[:, :]=[0.0, 100, 200, 300, 400, 500; 10,
            630, 580, 550, 580, 630; 20, 430, 420, 400, 400, 450; 30, 320, 325,
            330, 340, 350; 40, 285, 285, 288, 290, 300; 50, 270, 265, 265, 270,
            275; 60, 255, 248, 250, 255, 258; 70, 245, 237, 238, 243, 246; 80,
            245, 230, 233, 237, 240; 90, 235, 230, 228, 233, 235]
          "curve of ice specific consumption (g/kWh)";
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor w annotation (
            Placement(visible=true, transformation(
              origin={52,44},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Math.Min min1 annotation (Placement(visible=true,
              transformation(extent={{-48,50},{-28,70}}, rotation=0)));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
            Placement(
            visible=true,
            transformation(extent={{90,10},{110,30}}, rotation=0),
            iconTransformation(extent={{90,10},{110,30}}, rotation=0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor icePow annotation (
            Placement(visible=true, transformation(extent={{66,50},{86,70}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Sources.Torque Tice annotation (Placement(
              visible=true, transformation(extent={{-12,50},{8,70}}, rotation=0)));
        Modelica.Mechanics.Rotational.Components.Inertia inertia(w(
            fixed=true,
            start=wIceStart,
            displayUnit="rpm"), J=iceJ) annotation (Placement(visible=true,
              transformation(extent={{16,50},{36,70}}, rotation=0)));
        Modelica.Blocks.Math.Product toPow0 annotation (Placement(visible=true,
              transformation(
              origin={0,12},
              extent={{-10,-10},{10,10}},
              rotation=-90)));
        Modelica.Blocks.Math.Product toG_perHour annotation (Placement(visible=
                true, transformation(
              origin={34,-48},
              extent={{-10,-10},{10,10}},
              rotation=-90)));
        //  Modelica.Blocks.Continuous.Integrator toGrams(k = 1 / 3600000.0)
        // annotation(Placement(visible = true, transformation(origin = {26, -44},
        //extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        Modelica.Blocks.Tables.CombiTable1D toLimTau(table=maxIceTau)
          annotation (Placement(visible=true, transformation(
              origin={-72,66},
              extent={{10,-10},{-10,10}},
              rotation=180)));
        Modelica.Blocks.Sources.RealExpression rotorW(y=w.w) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-88,36})));
        Modelica.Blocks.Math.Gain tokW(k=1e-3) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={0,-18})));
        Modelica.Blocks.Tables.CombiTable2D toSpecCons(table=specificCons)
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={40,0})));
      equation
        connect(toPow0.u1, w.w)
          annotation (Line(points={{6,24},{6,33},{52,33}}, color={0,0,127}));
        connect(toPow0.u2, min1.y) annotation (Line(points={{-6,24},{-6,32},{-22,
                32},{-22,60},{-27,60}}, color={0,0,127}));
        connect(w.flange, inertia.flange_b)
          annotation (Line(points={{52,54},{52,60},{36,60}}));
        connect(icePow.flange_a, inertia.flange_b)
          annotation (Line(points={{66,60},{36,60}}));
        connect(Tice.flange, inertia.flange_a)
          annotation (Line(points={{8,60},{16,60}}));
        connect(Tice.tau, min1.y)
          annotation (Line(points={{-14,60},{-27,60}}, color={0,0,127}));
        connect(icePow.flange_b, flange_a)
          annotation (Line(points={{86,60},{94,60},{94,20},{100,20}}));
        connect(min1.u1, toLimTau.y[1]) annotation (Line(
            points={{-50,66},{-61,66}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(toLimTau.u[1], rotorW.y) annotation (Line(
            points={{-84,66},{-88,66},{-88,47}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(toPow0.y, tokW.u) annotation (Line(
            points={{-2.22045e-015,1},{-2.22045e-015,-2},{2.22045e-015,-2},{
                2.22045e-015,-6}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(toSpecCons.y, toG_perHour.u1)
          annotation (Line(points={{40,-11},{40,-36}}, color={0,0,127}));
        connect(toG_perHour.u2, tokW.y) annotation (Line(points={{28,-36},{28,-32},
                {0,-32},{0,-29}}, color={0,0,127}));
        connect(toSpecCons.u2, w.w) annotation (Line(points={{46,12},{46,28},{
                52,28},{52,33}}, color={0,0,127}));
        connect(toSpecCons.u1, min1.y) annotation (Line(points={{34,12},{34,40},
                {-22,40},{-22,60},{-27,60}}, color={0,0,127}));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
                  {100,80}})),
          experiment(
            StopTime=200,
            __Dymola_NumberOfIntervals=1000,
            __Dymola_Algorithm="Lsodar"),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<h4>Basic map-based ICE model.</h4>
<p>It receives as input the reference torque as a fracton of the maximum deliverable torque at a given speed. It can be approximately thought as a signal proportional to the accelerator position oF the vehicle.</p>
<p>The generated torque is the minimum between this signal and the maximum deliverable torque at the actual engine speed (defined by means of a table).</p>
<p>From the generated torque and speed the fuel consumption is computed.</p>
<p>The used maxTorque (toLimTau) and specific fuel consumption (toSpecCons) maps are inspired to public data related to the Toyota Prius&apos; engine </p>
</html>"),
          Icon(coordinateSystem(
              extent={{-100,-100},{100,100}},
              preserveAspectRatio=false,
              initialScale=0.1,
              grid={2,2}), graphics={
              Rectangle(
                extent={{-100,80},{100,-80}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-24,68},{76,-24}}),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{76,30},{100,10}}),
              Text(
                extent={{-140,-32},{140,-70}},
                textString="J=%inertiaJ",
                lineColor={0,0,0}),
              Text(
                origin={0,30},
                lineColor={0,0,255},
                extent={{-140,100},{140,60}},
                textString="%name"),
              Rectangle(extent={{-90,68},{-32,-26}}),
              Rectangle(
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                extent={{-90,22},{-32,0}}),
              Line(points={{-60,56},{-60,32}}),
              Polygon(points={{-60,66},{-66,56},{-54,56},{-60,66}}),
              Polygon(points={{-60,24},{-66,34},{-54,34},{-60,24}}),
              Rectangle(
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid,
                extent={{-64,0},{-54,-20}})}));
      end PartialMBice;

      model PartialMBiceP_old
        "Simple map-based ice model with connector and Power request"
        import Modelica.Constants.*;
        parameter Real contrGain=0.1 "Proportional controller gain (Nm/W)";
        parameter Real wIceStart=167;
        parameter Real iceJ=0.5 "ICE moment of Inertia (kg.m^2)";
        // rad/s
        Modelica.Mechanics.Rotational.Components.Inertia inertia(w(
            fixed=true,
            start=wIceStart,
            displayUnit="rpm"), J=iceJ)
          annotation (Placement(transformation(extent={{20,42},{40,62}})));
        Modelica.Mechanics.Rotational.Sources.Torque iceTau
          annotation (Placement(transformation(extent={{-12,42},{8,62}})));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor Pice
          annotation (Placement(transformation(extent={{66,62},{86,42}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor w annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={52,36})));
        Modelica.Blocks.Math.Product toPow0 annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-22,10})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{-90,62},{-70,42}})));
        Modelica.Blocks.Math.Gain gain(k=contrGain)
          annotation (Placement(transformation(extent={{-58,42},{-38,62}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
            Placement(transformation(extent={{90,-10},{110,10}}),
              iconTransformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Tables.CombiTable2D toGramsPerkWh(table=specificCons)
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={42,-2})));
      protected
        parameter Real specificCons[:, :]=[0.0, 100, 200, 300, 400, 500; 10,
            630, 580, 550, 580, 630; 20, 430, 420, 400, 400, 450; 30, 320, 325,
            330, 340, 350; 40, 285, 285, 288, 290, 300; 50, 270, 265, 265, 270,
            275; 60, 255, 248, 250, 255, 258; 70, 245, 237, 238, 243, 246; 80,
            245, 230, 233, 237, 240; 90, 235, 230, 228, 233, 235]
          "curve of ice specific consumption (g/kWh)";
      public
        Modelica.Blocks.Math.Gain tokW(k=0.001) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-22,-18})));
        Modelica.Blocks.Math.Product toG_perHour annotation (Placement(visible=
                true, transformation(
              origin={24,-48},
              extent={{-10,-10},{10,10}},
              rotation=-90)));
      equation
        connect(iceTau.flange, inertia.flange_a) annotation (Line(
            points={{8,52},{20,52}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(Pice.flange_a, inertia.flange_b) annotation (Line(
            points={{66,52},{40,52}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(Pice.flange_b, flange_a) annotation (Line(
            points={{86,52},{94,52},{94,0},{100,0}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(w.flange, inertia.flange_b) annotation (Line(
            points={{52,46},{52,52},{40,52}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(toPow0.u1, w.w) annotation (Line(
            points={{-16,22},{-16,25},{52,25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(toPow0.u2, iceTau.tau) annotation (Line(
            points={{-28,22},{-28,52},{-14,52}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(feedback.u2, Pice.power) annotation (Line(
            points={{-80,60},{-80,72},{68,72},{68,63}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, iceTau.tau) annotation (Line(
            points={{-37,52},{-14,52}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.u, feedback.y) annotation (Line(
            points={{-60,52},{-71,52}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(toGramsPerkWh.u2, w.w) annotation (Line(points={{48,10},{48,10},
                {48,16},{48,20},{50,20},{52,20},{52,25}}, color={0,0,127}));
        connect(toGramsPerkWh.u1, iceTau.tau) annotation (Line(points={{36,10},
                {36,32},{-28,32},{-28,52},{-14,52}}, color={0,0,127}));
        connect(toPow0.y, tokW.u)
          annotation (Line(points={{-22,-1},{-22,-6}}, color={0,0,127}));
        connect(tokW.y, toG_perHour.u2) annotation (Line(points={{-22,-29},{18,
                -29},{18,-36}}, color={0,0,127}));
        connect(toG_perHour.u1, toGramsPerkWh.y) annotation (Line(points={{30,-36},
                {30,-26},{42,-26},{42,-13}}, color={0,0,127}));
        annotation (
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-80},{100,80}},
              initialScale=0.1), graphics={Text(
                      extent={{-86,6},{-46,-16}},
                      lineColor={0,0,0},
                      textString="follows the power
 reference and
 computes consumption")}),
          experiment(
            StopTime=200,
            __Dymola_NumberOfIntervals=1000,
            __Dymola_Algorithm="Lsodar"),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Simple map-based ICE model for power-split power trains - with connector</b> </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is a &QUOT;connector&QUOT; version of MBice.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">For a general descritiption see the info of MBice.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Signals connected to the connector:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowRef (input) is the power request (W). Negative values are internally converted to zero</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- iceW (output) is the measured ICE speed (rad/s)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowDel (output) delivered power (W)</span></p>
</html>"),
          Icon(coordinateSystem(
              extent={{-100,-100},{100,100}},
              preserveAspectRatio=false,
              initialScale=0.1,
              grid={2,2}), graphics={Rectangle(
                      fillColor={192,192,192},
                      fillPattern=FillPattern.HorizontalCylinder,
                      extent={{-24,48},{76,-44}}),Rectangle(
                      fillColor={192,192,192},
                      fillPattern=FillPattern.HorizontalCylinder,
                      extent={{76,10},{100,-10}}),Text(
                      origin={-2,0},
                      extent={{-140,-52},{140,-90}},
                      textString="J=%J"),Rectangle(extent={{-100,62},{100,-100}}),
                Text( origin={0,10},
                      lineColor={0,0,255},
                      extent={{-140,100},{140,60}},
                      textString="%name"),Rectangle(extent={{-90,48},{-32,-46}}),
                Rectangle(
                      fillColor={95,95,95},
                      fillPattern=FillPattern.Solid,
                      extent={{-90,2},{-32,-20}}),Line(points={{-60,36},{-60,12}}),
                Polygon(points={{-60,46},{-66,36},{-54,36},{-60,46}}),Polygon(
                points={{-60,4},{-66,14},{-54,14},{-60,4}}),Rectangle(
                      fillColor={135,135,135},
                      fillPattern=FillPattern.Solid,
                      extent={{-64,-20},{-54,-40}})}));
      end PartialMBiceP_old;

      model PartialMBiceP
        "Simple map-based ice model with connector and Power request"
        import Modelica.Constants.*;
        parameter Real contrGain=0.1 "Proportional controller gain (Nm/W)";
        parameter Real wIceStart=167;
        parameter Real iceJ=0.5 "ICE moment of Inertia (kg.m^2)";
        // rad/s
        Modelica.Mechanics.Rotational.Components.Inertia inertia(w(
            fixed=true,
            start=wIceStart,
            displayUnit="rpm"), J=iceJ) annotation (Placement(visible=true,
              transformation(extent={{30,42},{50,62}}, rotation=0)));
        Modelica.Mechanics.Rotational.Sources.Torque iceTau annotation (
            Placement(visible=true, transformation(extent={{4,42},{24,62}},
                rotation=0)));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor Pice
          annotation (Placement(transformation(extent={{66,62},{86,42}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor w annotation (
            Placement(visible=true, transformation(
              origin={58,36},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Math.Product toPow0 annotation (Placement(visible=true,
              transformation(
              origin={-18,10},
              extent={{-10,-10},{10,10}},
              rotation=-90)));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{-90,62},{-70,42}})));
        Modelica.Blocks.Math.Gain gain(k=contrGain) annotation (Placement(
              visible=true, transformation(extent={{-62,42},{-42,62}}, rotation
                =0)));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
            Placement(transformation(extent={{90,-10},{110,10}}),
              iconTransformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Tables.CombiTable2D toGramsPerkWh(table=specificCons)
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=-90,
              origin={42,-2})));
        Modelica.Blocks.Math.Gain tokW(k=0.001) annotation (Placement(visible=
                true, transformation(
              origin={-18,-18},
              extent={{-10,-10},{10,10}},
              rotation=-90)));
        Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1e99, uMin=0)
          annotation (Placement(visible=true, transformation(
              origin={-22,52},
              extent={{-10,-10},{10,10}},
              rotation=0)));
      protected
        parameter Real specificCons[:, :]=[0.0, 100, 200, 300, 400, 500; 10,
            630, 580, 550, 580, 630; 20, 430, 420, 400, 400, 450; 30, 320, 325,
            330, 340, 350; 40, 285, 285, 288, 290, 300; 50, 270, 265, 265, 270,
            275; 60, 255, 248, 250, 255, 258; 70, 245, 237, 238, 243, 246; 80,
            245, 230, 233, 237, 240; 90, 235, 230, 228, 233, 235]
          "curve of ice specific consumption (g/kWh)";
      equation
        connect(toPow0.y, tokW.u)
          annotation (Line(points={{-18,-1},{-18,-6}}, color={0,0,127}));
        connect(toPow0.u2, iceTau.tau) annotation (Line(points={{-24,22},{-24,
                32},{-6,32},{-6,52},{2,52}}, color={0,0,127}));
        connect(iceTau.tau, limiter1.y) annotation (Line(points={{2,52},{-10,52},
                {-10,52},{-11,52}}, color={0,0,127}));
        connect(limiter1.u, gain.y) annotation (Line(points={{-34,52},{-42,52},
                {-42,52},{-41,52}}, color={0,0,127}));
        connect(toGramsPerkWh.u1, iceTau.tau) annotation (Line(points={{36,10},
                {36,32},{-6,32},{-6,52},{2,52}}, color={0,0,127}));
        connect(iceTau.flange, inertia.flange_a)
          annotation (Line(points={{24,52},{30,52}}));
        connect(w.flange, inertia.flange_b)
          annotation (Line(points={{58,46},{58,52},{50,52}}));
        connect(Pice.flange_a, inertia.flange_b)
          annotation (Line(points={{66,52},{50,52}}));
        connect(toGramsPerkWh.u2, w.w) annotation (Line(points={{48,10},{48,20},
                {58,20},{58,25}}, color={0,0,127}));
        connect(toPow0.u1, w.w) annotation (Line(points={{-12,22},{-12,25},{58,
                25}}, color={0,0,127}));
        connect(gain.u, feedback.y)
          annotation (Line(points={{-64,52},{-71,52}}, color={0,0,127}));
        connect(Pice.flange_b, flange_a) annotation (Line(
            points={{86,52},{94,52},{94,0},{100,0}},
            color={0,0,0},
            smooth=Smooth.None));
        connect(feedback.u2, Pice.power) annotation (Line(
            points={{-80,60},{-80,72},{68,72},{68,63}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-80},{100,80}},
              initialScale=0.1), graphics={Text(
                      extent={{-86,6},{-46,-16}},
                      lineColor={0,0,0},
                      textString="follows the power
 reference and computes consumption")}),
          Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Simple map-based ICE model for power-split power trains - with connector</b> </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is a &QUOT;connector&QUOT; version of MBice.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">For a general descritiption see the info of MBice.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Signals connected to the connector:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowRef (input) is the power request (W). Negative values are internally converted to zero</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- iceW (output) is the measured ICE speed (rad/s)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- icePowDel (output) delivered power (W)</span></p>
</html>"),
          Icon(coordinateSystem(
              extent={{-100,-100},{100,100}},
              preserveAspectRatio=false,
              initialScale=0.1,
              grid={2,2}), graphics={
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-24,48},{76,-44}}),
              Rectangle(
                fillColor={192,192,192},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{76,10},{100,-10}}),
              Text(
                origin={-2,0},
                extent={{-140,-52},{140,-90}},
                textString="J=%J"),
              Rectangle(extent={{-100,62},{100,-100}}),
              Text(
                origin={0,10},
                lineColor={0,0,255},
                extent={{-140,100},{140,60}},
                textString="%name"),
              Rectangle(extent={{-90,48},{-32,-46}}),
              Rectangle(
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid,
                extent={{-90,2},{-32,-20}}),
              Line(points={{-60,36},{-60,12}}),
              Polygon(points={{-60,46},{-66,36},{-54,36},{-60,46}}),
              Polygon(points={{-60,4},{-66,14},{-54,14},{-60,4}}),
              Rectangle(
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid,
                extent={{-64,-20},{-54,-40}})}),
          uses(Modelica(version="3.2.2")));
      end PartialMBiceP;
    end Partial;

    model MBecu1
      "Power Split hybrid power train controller, not using ON/OFF strategy"
      parameter Real genTorqueMax=80
        "maximum absolute valoe of gen torque (Nm)";
      parameter Real maxTorqueReq=80
        "Torque request (Nm) that corresponds to 1 from driver";
      parameter Real powFiltT=60 "Power filter time constant (s)";
      parameter Real genLoopGain=0.1
        "Control gain between ice speed error and gen torque: Nm/(rad/s)";
      Modelica.Blocks.Interfaces.RealInput tauReference annotation (Placement(
          visible=true,
          transformation(extent={{-140,-20},{-100,20}}, rotation=0),
          iconTransformation(extent={{-140,-20},{-100,20}}, rotation=0)));
      Modelica.Blocks.Continuous.FirstOrder powFilt(T=powFiltT) annotation (
          Placement(visible=true, transformation(
            origin={-40,40},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      SupportModels.Conn conn1 annotation (Placement(
          visible=true,
          transformation(extent={{-20,60},{20,100}}, rotation=0),
          iconTransformation(extent={{-20,78},{20,118}}, rotation=0)));
      Modelica.Blocks.Math.Gain gain(k=genLoopGain) annotation (Placement(
            visible=true, transformation(extent={{32,-30},{52,-10}}, rotation=0)));
      Modelica.Blocks.Math.Feedback feedback annotation (Placement(visible=true,
            transformation(extent={{6,-10},{26,-30}}, rotation=0)));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax=genTorqueMax, uMin=-
            genTorqueMax) annotation (Placement(visible=true, transformation(
            origin={60,40},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Tables.CombiTable1Ds powToW(
        fileName="wToTau.txt",
        tableOnFile=false,
        table=[0, 0; 1884, 126; 9800, 126; 36600, 366; 52300, 523])
        "optimal ice speed as a function of power" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-40,-20})));
      Modelica.Blocks.Math.Gain toNm(k=maxTorqueReq)
        "converts p.u. torque request into Nm" annotation (Placement(visible=
              true, transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,32})));
      Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1e6, uMin=125)
        annotation (Placement(visible=true, transformation(
            origin={-10,-20},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Continuous.FirstOrder genTauFilt(T=1) annotation (
          Placement(visible=true, transformation(
            origin={60,12},
            extent={{10,-10},{-10,10}},
            rotation=-90)));
    equation
      connect(powFilt.u, conn1.motPowDelB) annotation (Line(points={{-40,52},{-40,
              60},{0,60},{0,80}}, color={0,0,127}));
      connect(powFilt.y, conn1.icePowRef) annotation (Line(
          points={{-40,29},{-40,20},{0,20},{0,80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(gain.u, feedback.y)
        annotation (Line(points={{30,-20},{25,-20}}, color={0,0,127}));
      connect(powToW.u, powFilt.y) annotation (Line(
          points={{-52,-20},{-60,-20},{-60,20},{-40,20},{-40,29}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(feedback.u2, conn1.iceW) annotation (Line(
          points={{16,-12},{16,40},{16,40},{16,66},{0,66},{0,80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(limiter.y, conn1.genTauRef) annotation (Line(
          points={{60,51},{60,74},{0,74},{0,80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(toNm.u, tauReference) annotation (Line(
          points={{-80,20},{-80,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(toNm.y, conn1.motTauRef) annotation (Line(
          points={{-80,43},{-80,80},{0,80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(feedback.u1, limiter1.y) annotation (Line(
          points={{8,-20},{1,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(limiter1.u, powToW.y[1]) annotation (Line(
          points={{-22,-20},{-29,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(limiter.u, genTauFilt.y) annotation (Line(
          points={{60,28},{60,23}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(genTauFilt.u, gain.y) annotation (Line(
          points={{60,0},{60,-20},{53,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(
            extent={{-100,-60},{100,80}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={Text(
                  extent={{-82,74},{-24,70}},
                  lineColor={0,0,0},
                  textString="Send requested torque to mot"),Text(
                  extent={{-22,16},{6,12}},
                  lineColor={0,0,0},
                  textString="send filtered 
power to ice"),Text(
                  extent={{62,70},{90,66}},
                  lineColor={0,0,0},
                  textString="send 
reference tau
to gen",          horizontalAlignment=TextAlignment.Left)}),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-100,-102},{100,-140}},
              textString="%name"),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-4,-40},{74,16},{74,-6},{-4,-62},{-4,-40}},
              lineColor={95,95,95},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{8,-38},{28,-48},{20,-54},{0,-44},{8,-38}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,-54},{28,-48},{32,-56},{24,-62},{20,-54}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{24,-62},{32,-56},{32,-78},{24,-84},{24,-62}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-44},{20,-54},{24,-62},{24,-84},{22,-84},{22,-62},{20,
                  -58},{0,-48},{0,-44}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-14,40},{-18,32},{-10,38},{-8,44},{-14,40}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-18,32},{-10,38},{-10,14},{-18,8},{-18,32}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,10},{-20,32},{-16,40},{4,30},{4,26},{-16,36},{-18,32},
                  {-18,8},{-20,10}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-8,46},{12,36},{4,30},{-16,40},{-8,46}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{28,-22},{48,-32},{40,-38},{20,-28},{28,-22}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,-38},{48,-32},{52,-40},{44,-46},{40,-38}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{44,-46},{52,-40},{52,-62},{44,-68},{44,-46}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,-28},{40,-38},{44,-46},{44,-68},{42,-68},{42,-46},{40,
                  -42},{20,-32},{20,-28}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{48,-8},{68,-18},{60,-24},{40,-14},{48,-8}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,-24},{68,-18},{72,-26},{64,-32},{60,-24}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{64,-32},{72,-26},{72,-48},{64,-54},{64,-32}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,-14},{60,-24},{64,-32},{64,-54},{62,-54},{62,-32},{60,
                  -28},{40,-18},{40,-14}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{68,6},{88,-4},{80,-10},{60,0},{68,6}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{80,-10},{88,-4},{92,-12},{84,-18},{80,-10}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{84,-18},{92,-12},{92,-34},{84,-40},{84,-18}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,0},{80,-10},{84,-18},{84,-40},{82,-40},{82,-18},{80,-14},
                  {60,-4},{60,0}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-34,26},{-38,18},{-30,24},{-28,30},{-34,26}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-38,18},{-30,24},{-30,0},{-38,-6},{-38,18}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-4},{-40,18},{-36,26},{-16,16},{-16,12},{-36,22},{-38,
                  18},{-38,-6},{-40,-4}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-28,32},{-8,22},{-16,16},{-36,26},{-28,32}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-54,12},{-58,4},{-50,10},{-48,16},{-54,12}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,4},{-50,10},{-50,-14},{-58,-20},{-58,4}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,-18},{-60,4},{-56,12},{-36,2},{-36,-2},{-56,8},{-58,
                  4},{-58,-20},{-60,-18}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-48,18},{-28,8},{-36,2},{-56,12},{-48,18}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-74,-4},{-78,-12},{-70,-6},{-68,0},{-74,-4}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-78,-12},{-70,-6},{-70,-30},{-78,-36},{-78,-12}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-80,-34},{-80,-12},{-76,-4},{-56,-14},{-56,-18},{-76,-8},
                  {-78,-12},{-78,-36},{-80,-34}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-68,2},{-48,-8},{-56,-14},{-76,-4},{-68,2}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-64,-8},{-4,-40},{-4,-62},{-64,-30},{-64,-8}},
              lineColor={95,95,95},
              fillColor={75,75,75},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-64,-8},{-4,-40},{74,16},{14,48},{-64,-8}},
              lineColor={95,95,95},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-98,92},{98,62}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Text(
              extent={{-100,84},{100,54}},
              lineColor={0,0,0},
              textString="PSD-ecu1")}),
        Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Power Split Power Train Controller without ON/OFF</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This controller operates as follows:</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">it makes the ice deliver the average power needed by the power train</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">it determines the optimal ice speed at which the requested power is delivered with minimum fuel consumption and asks the &QUOT;gen&QUOT; to control so that the ice opertes at that speed</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">the vehicle motion is controlled acting on the &QUOT;mot&QUOT;.</span></li>
</ul>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p>Since this technique allows only approximatively the correct energy balance of the vehicle, the battery tends to sdischarge.This is solved with MBEcu2, in which a closed loop StateOfCharge (SOC) control is added.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">So:</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">powFilt Block filters the delivered power to obtained the power to ask the ICE to deliver</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">toIceWref converts the power to be requested from the ICE by its maximum torque at the actual speed</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">after a limiting block, this torque is the reference signal of a feedback; the corresponnding error controls the Gen torque.</span></li>
</ul>
</html>"));
    end MBecu1;

    model MBecu1soc
      "Power Split hybrid power train controller, with SOC control, without ON/OFF"
      parameter Real genTorqueMax=80
        "maximum absolute valoe of gen torque (Nm)";
      parameter Real socRef=0.6 "Target value of SOC";
      parameter Real socLoopGain=10000 "soc loop gain (W)";
      parameter Real maxTorqueReq=80
        "Torque request (Nm) that corresponds to 1 from driver";
      parameter Real genLoopGain=0.1
        "Control gain between ice speed error and gen torque: Nm/(rad/s)";
      parameter Real powFiltT=60 "Power filter time constant (s)";
      Modelica.Blocks.Interfaces.RealInput tauReference annotation (Placement(
          visible=true,
          transformation(extent={{-140,-20},{-100,20}}, rotation=0),
          iconTransformation(extent={{-140,-20},{-100,20}}, rotation=0)));
      Modelica.Blocks.Continuous.FirstOrder powFilt(T=powFiltT) annotation (
          Placement(visible=true, transformation(
            origin={20,46},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      SupportModels.Conn conn1 annotation (Placement(
          visible=true,
          transformation(extent={{-20,60},{20,100}}, rotation=0),
          iconTransformation(extent={{-20,78},{20,118}}, rotation=0)));
      Modelica.Blocks.Math.Gain gain(k=genLoopGain) annotation (Placement(
            visible=true, transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={84,-4})));
      Modelica.Blocks.Math.Feedback feedback annotation (Placement(visible=true,
            transformation(extent={{36,-30},{56,-50}}, rotation=0)));
      Modelica.Blocks.Tables.CombiTable1Ds toIceWref(
        fileName="wToTau.txt",
        tableOnFile=false,
        table=[0, 0; 1884, 126; 9800, 126; 36600, 366; 52300, 523])
        "optimal ice speed as a function of power" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-16,-40})));
      Modelica.Blocks.Math.Gain toNm(k=maxTorqueReq)
        "converts p.u. torque request into Nm" annotation (Placement(visible=
              true, transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-86,30})));
      Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1e6, uMin=125)
        annotation (Placement(visible=true, transformation(
            origin={14,-40},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Continuous.FirstOrder genTauFilt(T=1) annotation (
          Placement(visible=true, transformation(
            origin={84,38},
            extent={{10,-10},{-10,10}},
            rotation=-90)));
      Modelica.Blocks.Math.Add add annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={18,8})));
      Modelica.Blocks.Math.Feedback fbSOC
        annotation (Placement(transformation(extent={{-50,38},{-30,18}})));
      Modelica.Blocks.Math.Gain socErrToPow(k=socLoopGain) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-10,28})));
      Modelica.Blocks.Sources.Constant socRef_(k=socRef) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-54,-2})));
    equation
      connect(powFilt.u, conn1.motPowDelB) annotation (Line(points={{20,58},{20,
              58},{20,64},{20,64},{0,64},{0,80}}, color={0,0,127}));
      connect(gain.u, feedback.y) annotation (Line(points={{84,-16},{84,-16},{
              84,-40},{82,-40},{56,-40},{56,-40},{55,-40}}, color={0,0,127}));
      connect(feedback.u2, conn1.iceW) annotation (Line(
          points={{46,-32},{46,4},{40,4},{40,64},{0,64},{0,80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(toNm.u, tauReference) annotation (Line(
          points={{-86,18},{-86,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(toNm.y, conn1.motTauRef) annotation (Line(
          points={{-86,41},{-86,80},{0,80}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(feedback.u1, limiter1.y) annotation (Line(
          points={{38,-40},{25,-40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(limiter1.u, toIceWref.y[1]) annotation (Line(
          points={{2,-40},{-5,-40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(genTauFilt.u, gain.y) annotation (Line(
          points={{84,26},{84,7}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(powFilt.y, add.u1) annotation (Line(points={{20,35},{20,26},{24,
              26},{24,20}}, color={0,0,127}));
      connect(socErrToPow.y, add.u2)
        annotation (Line(points={{1,28},{12,28},{12,20}}, color={0,0,127}));
      connect(fbSOC.y, socErrToPow.u)
        annotation (Line(points={{-31,28},{-22,28}}, color={0,0,127}));
      connect(add.y, toIceWref.u) annotation (Line(points={{18,-3},{18,-3},{18,
              -10},{18,-12},{18,-18},{-40,-18},{-40,-40},{-28,-40}}, color={0,0,
              127}));
      connect(fbSOC.u2, conn1.batSOC) annotation (Line(points={{-40,36},{-40,36},
              {-40,80},{0,80}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(socRef_.y, fbSOC.u1)
        annotation (Line(points={{-54,9},{-54,28},{-48,28}}, color={0,0,127}));
      connect(add.y, conn1.icePowRef) annotation (Line(points={{18,-3},{18,-3},
              {18,-18},{18,-12},{56,-12},{56,74},{0,74},{0,80}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(genTauFilt.y, conn1.genTauRef) annotation (Line(points={{84,49},{
              84,49},{84,80},{0,80}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (
        Diagram(coordinateSystem(
            extent={{-100,-60},{100,80}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={Text(
                  extent={{-84,68},{-70,58}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Left,
                  textString="Send 
requested
torque 
to mot"),Text(    extent={{54,68},{82,64}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Right,
                  textString="send 
reference tau
to gen"),Text(    extent={{26,58},{54,54}},
                  lineColor={0,0,0},
                  horizontalAlignment=TextAlignment.Right,
                  textString="send 
ref pow
to ice")}),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-100,-102},{100,-140}},
              textString="%name"),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-4,-40},{74,16},{74,-6},{-4,-62},{-4,-40}},
              lineColor={95,95,95},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{8,-38},{28,-48},{20,-54},{0,-44},{8,-38}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,-54},{28,-48},{32,-56},{24,-62},{20,-54}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{24,-62},{32,-56},{32,-78},{24,-84},{24,-62}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-44},{20,-54},{24,-62},{24,-84},{22,-84},{22,-62},{20,
                  -58},{0,-48},{0,-44}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-14,40},{-18,32},{-10,38},{-8,44},{-14,40}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-18,32},{-10,38},{-10,14},{-18,8},{-18,32}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-20,10},{-20,32},{-16,40},{4,30},{4,26},{-16,36},{-18,32},
                  {-18,8},{-20,10}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-8,46},{12,36},{4,30},{-16,40},{-8,46}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{28,-22},{48,-32},{40,-38},{20,-28},{28,-22}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,-38},{48,-32},{52,-40},{44,-46},{40,-38}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{44,-46},{52,-40},{52,-62},{44,-68},{44,-46}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{20,-28},{40,-38},{44,-46},{44,-68},{42,-68},{42,-46},{40,
                  -42},{20,-32},{20,-28}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{48,-8},{68,-18},{60,-24},{40,-14},{48,-8}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,-24},{68,-18},{72,-26},{64,-32},{60,-24}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{64,-32},{72,-26},{72,-48},{64,-54},{64,-32}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,-14},{60,-24},{64,-32},{64,-54},{62,-54},{62,-32},{60,
                  -28},{40,-18},{40,-14}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{68,6},{88,-4},{80,-10},{60,0},{68,6}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{80,-10},{88,-4},{92,-12},{84,-18},{80,-10}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{84,-18},{92,-12},{92,-34},{84,-40},{84,-18}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,0},{80,-10},{84,-18},{84,-40},{82,-40},{82,-18},{80,-14},
                  {60,-4},{60,0}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-34,26},{-38,18},{-30,24},{-28,30},{-34,26}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-38,18},{-30,24},{-30,0},{-38,-6},{-38,18}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-4},{-40,18},{-36,26},{-16,16},{-16,12},{-36,22},{-38,
                  18},{-38,-6},{-40,-4}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-28,32},{-8,22},{-16,16},{-36,26},{-28,32}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-54,12},{-58,4},{-50,10},{-48,16},{-54,12}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,4},{-50,10},{-50,-14},{-58,-20},{-58,4}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,-18},{-60,4},{-56,12},{-36,2},{-36,-2},{-56,8},{-58,
                  4},{-58,-20},{-60,-18}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-48,18},{-28,8},{-36,2},{-56,12},{-48,18}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-74,-4},{-78,-12},{-70,-6},{-68,0},{-74,-4}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-78,-12},{-70,-6},{-70,-30},{-78,-36},{-78,-12}},
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-80,-34},{-80,-12},{-76,-4},{-56,-14},{-56,-18},{-76,-8},
                  {-78,-12},{-78,-36},{-80,-34}},
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-68,2},{-48,-8},{-56,-14},{-76,-4},{-68,2}},
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-64,-8},{-4,-40},{-4,-62},{-64,-30},{-64,-8}},
              lineColor={95,95,95},
              fillColor={75,75,75},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-64,-8},{-4,-40},{74,16},{14,48},{-64,-8}},
              lineColor={95,95,95},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-98,92},{98,62}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Text(
              extent={{-100,82},{100,54}},
              lineColor={0,0,0},
              textString="PSD-ecu1s")}),
        Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Power Split Power Train Controller without ON/OFF</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This controller is derived from MBecu1, in which the basic description can be found.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">It adds a soc control loop to avoid soc Drifts.</span></p>
</html>"));
    end MBecu1soc;

    model MBecu2
      "Power Split hybrid power train controller, using ON/OFF strategy"
      parameter Real socRef=0.6 "Reference soc";
      parameter Real maxTorqueReq=80
        "Maximum torque that can be requested from mot";
      parameter Real powFiltT=60 "Power filter time constant (s)";
      parameter Real socLoopGain=50e3 "gain of the soc loop (w/pu)";
      parameter Real genLoopGain=0.02 "gain of the soc loop (Nm/(rad/s))";
      parameter Real onThreshold=7000
        "average power over which engine is switched on (W)";
      parameter Real offThreshold=5000
        "average power below which engine is switched off (W)";
      Modelica.Blocks.Interfaces.RealInput tauReference annotation (Placement(
          visible=true,
          transformation(extent={{-140,-20},{-100,20}}, rotation=0),
          iconTransformation(extent={{-140,-20},{-100,20}}, rotation=0)));
      Modelica.Blocks.Continuous.FirstOrder powFilt(T=powFiltT) annotation (
          Placement(visible=true, transformation(
            origin={-50,58},
            extent={{-10,-10},{10,10}},
            rotation=-90)));
      SupportModels.Conn conn1 annotation (Placement(
          visible=true,
          transformation(extent={{-20,78},{20,118}}, rotation=0),
          iconTransformation(extent={{-20,78},{20,118}}, rotation=0)));
      Modelica.Blocks.Math.Gain genWLGain_(k=genLoopGain) "gen speed gain"
        annotation (Placement(visible=true, transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={104,30})));
      Modelica.Blocks.Math.Gain toNm(k=maxTorqueReq)
        "converts p.u. torque request into Nm" annotation (Placement(visible=
              true, transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-88,50})));
      Modelica.Blocks.Continuous.FirstOrder genTauFilt(T=1) annotation (
          Placement(visible=true, transformation(
            origin={104,76},
            extent={{10,-10},{-10,10}},
            rotation=-90)));
      Modelica.Blocks.Math.Add add annotation (Placement(visible=true,
            transformation(
            origin={-36,12},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Tables.CombiTable1Ds powToW(
        fileName="wToTau.txt",
        tableOnFile=false,
        table=[0, 0; 1884, 126; 9800, 126; 36600, 366; 52300, 523])
        "optimal ice speed as a function of power" annotation (Placement(
            visible=true, transformation(
            origin={64,-16},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Nonlinear.Limiter iceSpeedLimiter(uMax=1e6, uMin=125)
        annotation (Placement(visible=true, transformation(
            origin={64,16},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.Blocks.Math.Feedback feedback annotation (Placement(visible=true,
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={64,46})));
      Modelica.Blocks.Sources.Constant socRef_(k=socRef) annotation (Placement(
            visible=true, transformation(extent={{-98,-34},{-78,-14}}, rotation
              =0)));
      Modelica.Blocks.Math.Feedback fbSOC annotation (Placement(visible=true,
            transformation(extent={{-74,-14},{-54,-34}}, rotation=0)));
      Modelica.Blocks.Math.Gain socErrrToPow(k=socLoopGain) annotation (
          Placement(visible=true, transformation(
            origin={-38,-24},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=offThreshold, uHigh=
            onThreshold) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-18,42})));
      Modelica.Blocks.Logical.Switch switch1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={12,12})));
      Modelica.Blocks.Sources.Constant constZero(k=0)
        annotation (Placement(transformation(extent={{20,-30},{0,-10}})));
    equation
      connect(socErrrToPow.y, add.u2) annotation (Line(points={{-27,-24},{-22,-24},
              {-22,-4},{-58,-4},{-58,6},{-48,6}}, color={0,0,127}));
      connect(socErrrToPow.u, fbSOC.y)
        annotation (Line(points={{-50,-24},{-55,-24}}, color={0,0,127}));
      connect(fbSOC.u2, conn1.batSOC) annotation (Line(points={{-64,-16},{-64,-12},
              {-68,-12},{-68,98},{0,98}}, color={0,0,127}));
      connect(fbSOC.u1, socRef_.y)
        annotation (Line(points={{-72,-24},{-77,-24}}, color={0,0,127}));
      connect(feedback.u1, iceSpeedLimiter.y) annotation (Line(points={{64,38},
              {64,38},{64,28},{64,27}}, color={0,0,127}));
      connect(feedback.u2, conn1.iceW) annotation (Line(points={{56,46},{56,72},
              {56,98},{0,98}}, color={0,0,127}));
      connect(genWLGain_.u, feedback.y) annotation (Line(points={{104,18},{104,
              18},{104,0},{88,0},{88,55},{64,55}}, color={0,0,127}));
      connect(iceSpeedLimiter.u, powToW.y[1])
        annotation (Line(points={{64,4},{64,-5}}, color={0,0,127}));
      connect(add.u1, powFilt.y) annotation (Line(points={{-48,18},{-54,18},{-58,
              18},{-58,42},{-50,42},{-50,47}}, color={0,0,127}));
      connect(powFilt.u, conn1.motPowDelB) annotation (Line(points={{-50,70},{-50,
              78},{0,78},{0,98}}, color={0,0,127}));
      connect(toNm.u, tauReference) annotation (Line(
          points={{-88,38},{-88,0},{-120,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(toNm.y, conn1.motTauRef) annotation (Line(
          points={{-88,61},{-88,98},{0,98}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(genWLGain_.y, genTauFilt.u) annotation (Line(
          points={{104,41},{104,64}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(genTauFilt.y, conn1.genTauRef) annotation (Line(
          points={{104,87},{104,98},{0,98}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hysteresis.u, add.y) annotation (Line(
          points={{-18,30},{-18,12},{-25,12}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(hysteresis.y, conn1.iceON) annotation (Line(
          points={{-18,53},{-18,92},{0,92},{0,98}},
          color={255,0,255},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(powToW.u, switch1.y) annotation (Line(
          points={{64,-28},{30,-28},{30,12},{23,12}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(switch1.u1, add.y) annotation (Line(
          points={{0,20},{-18,20},{-18,12},{-25,12}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(switch1.u3, constZero.y) annotation (Line(
          points={{0,4},{-8,4},{-8,-20},{-1,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(switch1.u2, hysteresis.y) annotation (Line(
          points={{0,12},{-8,12},{-8,30},{0,30},{0,62},{-18,62},{-18,53}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(powToW.u, conn1.icePowRef) annotation (Line(
          points={{64,-28},{30,-28},{30,72},{0,72},{0,98}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (
        Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2;\">Power Split Power Train Controller with ON/OFF</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This controller operates as follows:</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">it makes the ice deliver the average power needed by the power train</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">it determines the optimal ice speed at which the requested power is delivered with minimum fuel consumption and asks the &QUOT;gen&QUOT; to control so that the ice opertes at that speed</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">the vehicle motion is controlled acting on the &QUOT;mot&QUOT;.</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">a closed-loop SOC control avoids the battery do become too charged or discharged</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">an ON/OFF control determines ICe switching OFF when the looad is to loow and switching it ON again when the requested power is sifnigicntly high. this normally reduces fuel consumpton.</span></li>
</ul>
<p><span style=\"font-family: MS Shell Dlg 2;\">So:</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">powFilt Block filters the delivered power to obtained the power to ask the ICE to deliver</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">toIceWref converts the power to be requested from the ICE by its maximum torque at the actual speed</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">after a limiting block, this torque is the reference signal of a feedback; the corresponnding error controls the Gen torque.</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">fbSOC sis the feedback for SOC control and socLoopGain is its gain</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">hysteresis manages switching ON/OFF the ice. </span></li>
</ul>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p>Details of ice going to off (e.g. bringing its speed to zero) and to on (i.e. first making ice speed to rise, then start sending fuel) are not implemented.</span></p>
</html>"),
        Diagram(coordinateSystem(
            extent={{-100,-40},{120,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={Text(extent={{-86,92},{-28,88}}, textString=
              "Send requested torque to mot"),Text(extent={{12,50},{40,46}},
              textString="send reterence tau
 to gen")}),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-102,-102},{98,-140}},
              textString="%name"),
            Rectangle(
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-100,100},{100,-100}}),
            Polygon(
              lineColor={95,95,95},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              points={{-4,-40},{74,16},{74,-6},{-4,-62},{-4,-40}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{8,-38},{28,-48},{20,-54},{0,-44},{8,-38}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{20,-54},{28,-48},{32,-56},{24,-62},{20,-54}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{24,-62},{32,-56},{32,-78},{24,-84},{24,-62}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{0,-44},{20,-54},{24,-62},{24,-84},{22,-84},{22,-62},{20,
                  -58},{0,-48},{0,-44}}),
            Polygon(
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid,
              points={{-14,40},{-18,32},{-10,38},{-8,44},{-14,40}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{-18,32},{-10,38},{-10,14},{-18,8},{-18,32}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{-20,10},{-20,32},{-16,40},{4,30},{4,26},{-16,36},{-18,32},
                  {-18,8},{-20,10}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{-8,46},{12,36},{4,30},{-16,40},{-8,46}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{28,-22},{48,-32},{40,-38},{20,-28},{28,-22}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{40,-38},{48,-32},{52,-40},{44,-46},{40,-38}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{44,-46},{52,-40},{52,-62},{44,-68},{44,-46}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{20,-28},{40,-38},{44,-46},{44,-68},{42,-68},{42,-46},{40,
                  -42},{20,-32},{20,-28}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{48,-8},{68,-18},{60,-24},{40,-14},{48,-8}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{60,-24},{68,-18},{72,-26},{64,-32},{60,-24}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{64,-32},{72,-26},{72,-48},{64,-54},{64,-32}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{40,-14},{60,-24},{64,-32},{64,-54},{62,-54},{62,-32},{60,
                  -28},{40,-18},{40,-14}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{68,6},{88,-4},{80,-10},{60,0},{68,6}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{80,-10},{88,-4},{92,-12},{84,-18},{80,-10}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{84,-18},{92,-12},{92,-34},{84,-40},{84,-18}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{60,0},{80,-10},{84,-18},{84,-40},{82,-40},{82,-18},{80,-14},
                  {60,-4},{60,0}}),
            Polygon(
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid,
              points={{-34,26},{-38,18},{-30,24},{-28,30},{-34,26}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{-38,18},{-30,24},{-30,0},{-38,-6},{-38,18}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{-40,-4},{-40,18},{-36,26},{-16,16},{-16,12},{-36,22},{-38,
                  18},{-38,-6},{-40,-4}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{-28,32},{-8,22},{-16,16},{-36,26},{-28,32}}),
            Polygon(
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid,
              points={{-54,12},{-58,4},{-50,10},{-48,16},{-54,12}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{-58,4},{-50,10},{-50,-14},{-58,-20},{-58,4}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{-60,-18},{-60,4},{-56,12},{-36,2},{-36,-2},{-56,8},{-58,
                  4},{-58,-20},{-60,-18}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{-48,18},{-28,8},{-36,2},{-56,12},{-48,18}}),
            Polygon(
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid,
              points={{-74,-4},{-78,-12},{-70,-6},{-68,0},{-74,-4}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              points={{-78,-12},{-70,-6},{-70,-30},{-78,-36},{-78,-12}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={191,191,0},
              fillPattern=FillPattern.Solid,
              points={{-80,-34},{-80,-12},{-76,-4},{-56,-14},{-56,-18},{-76,-8},
                  {-78,-12},{-78,-36},{-80,-34}}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              points={{-68,2},{-48,-8},{-56,-14},{-76,-4},{-68,2}}),
            Polygon(
              lineColor={95,95,95},
              fillColor={75,75,75},
              fillPattern=FillPattern.Solid,
              points={{-64,-8},{-4,-40},{-4,-62},{-64,-30},{-64,-8}}),
            Polygon(
              lineColor={95,95,95},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid,
              points={{-64,-8},{-4,-40},{74,16},{14,48},{-64,-8}}),
            Rectangle(
              fillColor={255,255,255},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-98,92},{98,62}}),
            Text(
              extent={{-100,84},{100,54}},
              lineColor={0,0,0},
              textString="PSD-ecu2")}));
    end MBecu2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-80,-84},{-80,68}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-88,-80},{78,-80}},
            color={0,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{94,-80},{78,-74},{78,-86},{94,-80}},
            lineColor={0,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{8,0},{-8,6},{-8,-6},{8,0}},
            lineColor={0,0,0},
            smooth=Smooth.None,
            origin={-80,76},
            rotation=90),
          Line(
            points={{-84,40},{-14,40}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-14,40},{-4,2},{22,-32},{62,-44},{62,-80}},
            color={0,0,0},
            smooth=Smooth.None)}));
  end MapBased;

  package SupportModels "Useful addtional models"
    extends Modelica.Icons.Package;
    // extends EHPowerTrain.Icons.SupportIcon;

    model PropDriver "Simple Proportional controller driver"
      parameter String CycleFileName="MyCycleName.txt"
        "Drive Cycle Name ex: \"sort1.txt\"";
      parameter Real k "Controller gain";
      parameter Real yMax=1000000.0 "Max output value (absolute)";
      parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint;
      Modelica.Blocks.Interfaces.RealInput V annotation (Placement(
            transformation(
            extent={{-14,-14},{14,14}},
            rotation=90,
            origin={0,-114}), iconTransformation(
            extent={{-12,-12},{12,12}},
            rotation=90,
            origin={0,-112})));
      Modelica.Blocks.Interfaces.RealOutput tauRef(unit="N.m") annotation (
          Placement(transformation(extent={{100,-10},{120,10}}),
            iconTransformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Sources.CombiTimeTable driveCyc(
        columns={2},
        fileName=CycleFileName,
        tableName="Cycle",
        tableOnFile=true)
        annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
      Modelica.Blocks.Math.UnitConversions.From_kmh from_kmh
        annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Math.Gain gain(k=k)
        annotation (Placement(transformation(extent={{32,-10},{52,10}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax=yMax)
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
    equation
      connect(from_kmh.u, driveCyc.y[1]) annotation (Line(
          points={{-50,0},{-65,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(from_kmh.y, feedback.u1) annotation (Line(
          points={{-27,0},{-8,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(feedback.u2, V) annotation (Line(
          points={{0,-8},{0,-114},{1.77636e-015,-114}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(feedback.y, gain.u) annotation (Line(
          points={{9,0},{30,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(gain.y, limiter.u) annotation (Line(
          points={{53,0},{68,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(tauRef, limiter.y) annotation (Line(
          points={{110,0},{91,0}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics),
        Documentation(info="<html>
            <p>Modello semplice di pilota.</p>
            <p>Esso contiene al suo interno il ciclo di riferimento, che insegue attraverso un regolatore solo proporzionale.</p>
            </html>"),
        Icon(coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={
            Rectangle(
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-100,100},{100,-100}}),
            Ellipse(
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              extent={{-23,46},{-12,20}},
              endAngle=360),
            Text(
              origin={0,1.81063},
              lineColor={0,0,255},
              extent={{-104,142.189},{98,104}},
              textString="%name"),
            Polygon(
              fillColor={215,215,215},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-22,-36},{-42,-64},{-16,-64},{16,-64},{-22,-36}}),
            Polygon(
              fillColor={135,135,135},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-32,64},{-62,-28},{-30,-28},{-30,-28},{-32,64}},
              smooth=Smooth.Bezier),
            Polygon(
              fillColor={135,135,135},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-68,-12},{-14,-66},{10,-26},{0,-26},{-68,-12}},
              smooth=Smooth.Bezier),
            Polygon(
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              points={{-22,34},{-30,30},{-40,-24},{2,-22},{2,-10},{0,26},{-22,
                  34}},
              smooth=Smooth.Bezier),
            Ellipse(
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              extent={{-30,68},{-3,34}},
              endAngle=360),
            Polygon(
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-38,58},{-16,74},{-2,60},{4,60},{6,60},{-38,58}},
              smooth=Smooth.Bezier),
            Polygon(
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              points={{30,-20},{-32,-4},{-36,-20},{-24,-34},{30,-20}},
              smooth=Smooth.Bezier),
            Polygon(
              fillPattern=FillPattern.Solid,
              points={{42,-46},{36,-60},{48,-54},{52,-48},{50,-44},{42,-46}},
              smooth=Smooth.Bezier),
            Line(points={{48,10},{26,24},{26,24}}, thickness=0.5),
            Line(points={{20,14},{34,34},{34,34}}, thickness=0.5),
            Polygon(
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              points={{28,28},{32,32},{28,26},{34,30},{30,26},{34,28},{30,24},{
                  26,26},{34,24},{26,24},{26,26},{28,28},{28,28},{26,26},{26,26},
                  {26,26},{28,32},{28,30},{28,28}},
              smooth=Smooth.Bezier),
            Polygon(
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              points={{-18,24},{28,30},{26,22},{-16,8},{-20,8},{-24,18},{-18,24}},

              smooth=Smooth.Bezier),
            Polygon(
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              points={{72,18},{48,18},{36,-2},{58,-62},{72,-62},{72,18}}),
            Polygon(
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              points={{49,-70},{17,-16},{7,-20},{-1,-26},{49,-70}},
              smooth=Smooth.Bezier),
            Line(points={{-7,55},{-3,53}}),
            Line(points={{-9,42},{-5,42}}),
            Line(points={{-7,55},{-3,55}})}));
    end PropDriver;

    model DragForce "Vehicle rolling and aerodinamical drag force"
      import Modelica.Constants.g_n;
      extends
        Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      extends Modelica.Mechanics.Translational.Interfaces.PartialFriction;
      Modelica.SIunits.Force f "Total drag force";
      Modelica.SIunits.Velocity v "Vehicle velocity";
      Modelica.SIunits.Acceleration a "Absolute acceleration of flange";
      Real Sign;
      parameter Modelica.SIunits.Mass m "Vehicle mass";
      parameter Modelica.SIunits.Density rho(start=1.226) "air density";
      parameter Modelica.SIunits.Area S "Vehicle cross area";
      parameter Real fc(start=0.01) "Rolling friction coefficient";
      parameter Real Cx "Aerodinamic drag coefficient";
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
      f0 = A "forza a velocitC  0 ma con scorrimento";
      f0_max = A "massima forza  velocitC  0 e senza scorrimento ";
      free = false "sarebbe true quando la ruota si stacca dalla strada";
      // Ora il calcolo di f, e la sua attribuzione alla flangia:
      flange.f - f = 0;
      // friction force
      if v > 0 then
        Sign = 1;
      else
        Sign = -1;
      end if;
      f - B*v^2*Sign = if locked then sa*unitForce else f0*(if startForward
         then Modelica.Math.tempInterpol1(
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
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
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
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics));
    end DragForce;

    expandable connector Conn
      "Control bus that is adapted to the signals connected to it"
      extends Modelica.Icons.SignalBus;
      annotation (Diagram(graphics));
    end Conn;

    model Batt1Conn
      "Modello di batteria basato su Batt0 con ordine elettrico pari a 1"
      Real powDeliv "battery power (positive when delivered)";
      Real SOC "State Of Charge";
      parameter Modelica.SIunits.ElectricCharge QCellNom(min=0) = 10*3.6e3
        "Nominal admissible electric charge per cell"
        annotation (Dialog(tab="cell data"));
      parameter Modelica.SIunits.Voltage ECellMin(min=0) = 3.3
        "Minimum open source voltage per cell"
        annotation (Dialog(tab="cell data"));
      parameter Modelica.SIunits.Voltage ECellMax(min=0.0001) = 4.15
        "Maximum open source voltage per cell"
        annotation (Dialog(tab="cell data"));
      parameter Real SOCMin(
        min=0,
        max=1) = 0 "Minimum state of charge"
        annotation (Dialog(group="SOC parameters"));
      parameter Real SOCMax(
        min=0,
        max=1) = 1 "Maximum state of charge"
        annotation (Dialog(group="SOC parameters"));
      parameter Real SOCInit(
        min=0,
        max=1) = 0.5 "Initial state of charge"
        annotation (Dialog(group="SOC parameters"));
      parameter Modelica.SIunits.Current ICellMax(min=0) = 10*QCellNom/3.6e3
        "Maximum admissible current" annotation (Dialog(tab="cell data"));
      parameter Modelica.SIunits.Resistance R0Cell(min=0) = 0.05*ECellMax/
        ICellMax "Series resistance \"R0\"" annotation (Dialog(tab="cell data",
            group="Electric circuit parameters"));
      parameter Modelica.SIunits.Resistance R1Cell(min=0) = R0Cell
        "Series resistance \"R1\"" annotation (Dialog(tab="cell data", group=
              "Electric circuit parameters"));
      parameter Modelica.SIunits.Capacitance C1Cell(min=0) = 60/R1Cell
        "Capacitance in parallel with R1" annotation (Dialog(tab="cell data",
            group="Electric circuit parameters"));
      parameter Real efficiency(
        min=0,
        max=0.9999) = 0.85 "Overall charging/discharging energy efficiency"
        annotation (Dialog(group="Parameters related to losses"));
      parameter Modelica.SIunits.Current iCellEfficiency(min=0) = 0.5*ICellMax
        "Cell charging/discharging current the efficiency refers to"
        annotation (Dialog(group="Parameters related to losses"));
      parameter Integer ns=1 "Number of serial connected cells"
        annotation (Dialog(tab="package data", group="Size of the package"));
      parameter Integer np=1 "Number of parallel connected cells"
        annotation (Dialog(tab="package data", group="Size of the package"));
      // determine fraction of drain current with respect to the total package current
      Modelica.Electrical.Analog.Basic.Capacitor cBattery(final C=CBattery)
        annotation (Placement(transformation(
            origin={-60,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor R0(final R=R0Battery)
        annotation (Placement(transformation(
            origin={20,60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.Analog.Sources.SignalCurrent strayCurrent annotation
        (Placement(transformation(
            origin={-6,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Interfaces.Pin p annotation (Placement(
            transformation(extent={{90,50},{110,70}}), iconTransformation(
              extent={{90,52},{110,72}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (Placement(
            transformation(extent={{90,-70},{110,-50}}), iconTransformation(
              extent={{91,-70},{111,-50}})));
      Modelica.Electrical.Analog.Basic.Capacitor C1(C=C1Battery) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-37,50})));
      SupportModels.Conn conn annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-100,-2})));
      Modelica.Blocks.Sources.RealExpression SOCs(y=SOC) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-80,30})));
      Modelica.Blocks.Sources.RealExpression outPow(y=(p.v - n.v)*n.i)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-80,-26})));
      Modelica.Electrical.Analog.Basic.Resistor R1(final R=R1Battery)
        annotation (Placement(visible=true, transformation(
            origin={-37,72},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    protected
      parameter Real k=((1 - efficiency)*(eBattMax + eBattMin) - 2*(1 +
          efficiency)*Rtot*iCellEfficiency)/((1 + efficiency)*(eBattMax +
          eBattMin) - 2*(1 - efficiency)*Rtot*iCellEfficiency);
      parameter Real efficiencyMax=(eBattMin + eBattMax - 2*Rtot*
          iCellEfficiency)/(eBattMin + eBattMax + 2*Rtot*iCellEfficiency);
      final parameter Modelica.SIunits.Capacitance C=QCellNom/(ECellMax -
          ECellMin) "Cell capacitance";
      parameter Modelica.SIunits.Current IBatteryMax=ICellMax*np
        "Maximum battery current";
      parameter Modelica.SIunits.Voltage eBattMin=ECellMin*ns
        "Minimum battery voltage";
      parameter Modelica.SIunits.Voltage eBattMax=ECellMax*ns
        "Maximum battery voltage";
      parameter Modelica.SIunits.ElectricCharge QBatteryNominal=QCellNom*np
        "Battery admissible electric charge";
      parameter Modelica.SIunits.Capacitance CBattery=C*np/ns
        "Battery capacitance";
      parameter Modelica.SIunits.Resistance R0Battery=R0Cell*ns/np
        "Series inner resistance R0 of cell package";
      parameter Modelica.SIunits.Resistance R1Battery=R1Cell*ns/np
        "Series inner resistance R1 of cell package";
      parameter Modelica.SIunits.Resistance Rtot=R0Battery + R1Battery;
      parameter Modelica.SIunits.Capacitance C1Battery=C1Cell*np/ns
        "Battery series inner capacitance C1";
      Modelica.SIunits.Voltage ECell "Cell e.m.f.";
      Modelica.SIunits.Current iCellStray "Cell stray current";
      Modelica.SIunits.Voltage eBatt(start=eBattMin + SOCInit*(eBattMax -
            eBattMin), fixed=true) "Battery e.m.f.";
      Modelica.SIunits.Current iBatteryStray "Cell parasitic current";
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
        annotation (Placement(transformation(extent={{70,50},{90,70}}, rotation
              =0)));
      Modelica.Blocks.Math.Gain gain(k=k) annotation (Placement(transformation(
            origin={60,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Blocks.Math.Abs absolute annotation (Placement(transformation(
              extent={{34,-10},{14,10}}, rotation=0)));
    equation
      connect(R1.p, R0.n) annotation (Line(points={{-27,72},{-18,72},{-18,60},{
              10,60}}, color={0,0,255}));
      connect(R1.p, C1.p) annotation (Line(points={{-27,72},{-18,72},{-18,50},{
              -27,50}}, color={0,0,255}));
      connect(R1.n, cBattery.p) annotation (Line(points={{-47,72},{-60,72},{-60,
              10}}, color={0,0,255}));
      assert(SOCMin >= 0, "SOCMin must be greater than, or equal to 0");
      assert(SOCMax <= 1, "SOCMax must be smaller than, or equal to 1");
      assert(efficiency <= efficiencyMax,
        "Overall charging/discharging energy efficiency is too big with respect to the actual serial resistance (EfficiencyMax ="
         + String(efficiencyMax) + ")");
      assert(SOCMin < SOCMax, "SOCMax(=" + String(SOCMax) +
        ") must be greater than SOCMin(=" + String(SOCMin) + ")");
      assert(SOCInit >= SOCMin, "SOCInit(=" + String(SOCInit) +
        ") must be greater than, or equal to SOCMin(=" + String(SOCMin) + ")");
      assert(SOCInit <= SOCMax, "SOCInit(=" + String(SOCInit) +
        ") must be smaller than, or equal to SOCMax(=" + String(SOCMax) + ")");
      iBatteryStray = strayCurrent.i;
      iCellStray = iBatteryStray/np;
      eBatt = cBattery.v;
      //Solo per dare maggiore chiarezza all'utente con un nome significativo
      ECell = eBatt/ns;
      powDeliv = (p.v - n.v)*n.i;
      assert(abs(p.i/np) < ICellMax, "Battery cell current i=" + String(abs(p.i
        /np)) + "\n exceeds max admissable ICellMax (=" + String(ICellMax) +
        "A)");
      SOC = (eBatt - eBattMin)/(eBattMax - eBattMin);
      //*(SOCMax-SOCMin)+SOCMin);
      assert(SOC <= SOCMax,
        "Battery is fully charged: State of charge reached maximum limit (=" +
        String(SOCMax) + ")");
      assert(SOCMin <= SOC,
        "Battery is fully discharged: State of charge reached minimum limit (="
         + String(SOCMin) + ")");
      connect(R0.p, currentSensor.p)
        annotation (Line(points={{30,60},{70,60}}, color={0,0,255}));
      connect(strayCurrent.p, R0.n)
        annotation (Line(points={{-6,10},{-6,60},{10,60}}, color={0,0,255}));
      connect(currentSensor.i, gain.u) annotation (Line(points={{80,50},{80,-1.46958e-015},
              {72,-1.46958e-015}}, color={0,0,127}));
      connect(absolute.u, gain.y) annotation (Line(points={{36,0},{39.5,0},{
              39.5,1.33227e-015},{49,1.33227e-015}}, color={0,0,127}));
      connect(absolute.y, strayCurrent.i) annotation (Line(points={{13,0},{7,0},
              {7,-1.28588e-015},{1,-1.28588e-015}}, color={0,0,127}));
      connect(currentSensor.n, p)
        annotation (Line(points={{90,60},{90,60},{100,60}}, color={0,0,255}));
      connect(strayCurrent.n, n) annotation (Line(points={{-6,-10},{-6,-60},{
              100,-60}}, color={0,0,255}));
      connect(n, cBattery.n) annotation (Line(points={{100,-60},{-60,-60},{-60,
              -10}}, color={0,0,255}));
      connect(C1.n, cBattery.p) annotation (Line(
          points={{-47,50},{-60,50},{-60,10}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(conn.batSOC, SOCs.y) annotation (Line(
          points={{-100,-2},{-100,8.5},{-80,8.5},{-80,19}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      connect(outPow.y, conn.batPowDel) annotation (Line(
          points={{-80,-15},{-80,-2},{-100,-2}},
          color={0,0,127},
          smooth=Smooth.None), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (
        Documentation(info="<html>
    <p>Modello di batteria  dotato di efficienza colombica non unitaria, secondo quanto discusso nelle dispense SEB.</p>
    <p>Il ramo principaledel modello di cella  presenta una f.e.m. linearmente crescente con il SOC (simulata tramite un condensatore equivalente), una resistenza R0 ed un blocco R-C.</p>
    <p>La batteria &egrave; composta da np filari idi celle in parallelo, ciascuno composto da ns celle in serie.</p>
    <p><br/>SEB a.a. 2012-2013.</p>
    </html>", revisions="<html><table border=\"1\" rules=\"groups\">
    <thead>
    <tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
    </thead>
    <tbody>
    <tr><td>1.0.0</td>  <td>2006-01-12</td>  <td> </td></tr>
    <tr><td>1.0.3</td>  <td>2006-08-31</td>  <td> Improved assert statements </td></tr>
    <tr><td>1.0.6</td>  <td>2007-05-14</td>  <td> The documentation changed slightly </td></tr>
    </tbody>
    </table>
    </html>"),
        Diagram(coordinateSystem(
            extent={{-100,-80},{100,80}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics),
        Icon(coordinateSystem(
            extent={{-100,-80},{100,80}},
            preserveAspectRatio=false,
            initialScale=0.1,
            grid={2,2}), graphics={
            Rectangle(
              lineColor={95,95,95},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-100,80},{80,-82}}),
            Line(points={{-92,6},{-52,6}}, color={0,0,255}),
            Rectangle(
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              extent={{-82,-3},{-65,-10}}),
            Line(points={{-73,63},{98,64}}, color={0,0,255}),
            Rectangle(
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{38,69},{68,57}}),
            Rectangle(
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-37.5,68},{-6.5,56}}),
            Line(points={{-19.5,49},{-19.5,32}}, color={0,0,255}),
            Line(points={{-54.5,63},{-54.5,41},{-25.5,41}}, color={0,0,255}),
            Line(points={{9.5,62},{9.5,40},{-19.5,40}}, color={0,0,255}),
            Line(points={{-73,63},{-73,5}}, color={0,0,255}),
            Line(points={{-73,-6},{-73,-60},{96,-60}}, color={0,0,255}),
            Line(points={{26,63},{26,-61}}, color={0,0,255}),
            Line(points={{-25.5,49},{-25.5,32}}, color={0,0,255}),
            Polygon(
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              points={{26,22},{14,4},{26,-14},{38,4},{26,22}}),
            Line(points={{20,4},{32,4}}, color={0,0,255}),
            Polygon(lineColor={0,0,255}, points={{22,-20},{30,-20},{26,-32},{22,
                  -20}}),
            Text(
              origin={-4,-22},
              lineColor={0,0,255},
              extent={{-100,150},{100,110}},
              textString="%name")}));
    end Batt1Conn;

    package Internal
      "Models intended to be used by other models of this package, not by the final user"
      model ConstPDC "Constant Power DC Load"
        parameter Real k "inner PI follower proportional gain";
        parameter Modelica.SIunits.Time T
          "inner PI follower integral time constant";
        Real v "DC voltage";
        Modelica.Blocks.Math.Feedback feedback1 annotation (Placement(visible=
                true, transformation(
              origin={56,-44},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Blocks.Continuous.PI PI(
          k=k,
          T=T,
          initType=Modelica.Blocks.Types.Init.InitialState) annotation (
            Placement(visible=true, transformation(
              origin={20,-44},
              extent={{-8,-8},{8,8}},
              rotation=180)));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
            Placement(
            visible=true,
            transformation(extent={{-108,58},{-88,78}}, rotation=0),
            iconTransformation(extent={{-10,90},{10,110}}, rotation=0)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
            Placement(
            visible=true,
            transformation(extent={{-108,-74},{-88,-54}}, rotation=0),
            iconTransformation(extent={{-10,-108},{10,-88}}, rotation=0)));
        Modelica.Blocks.Interfaces.RealInput Pref "Reference power" annotation
          (Placement(
            visible=true,
            transformation(
              origin={100,-44},
              extent={{-18,-18},{18,18}},
              rotation=180),
            iconTransformation(
              origin={82,0},
              extent={{-18,-18},{18,18}},
              rotation=180)));
        Modelica.Electrical.Analog.Sensors.PowerSensor pSensor annotation (
            Placement(visible=true, transformation(extent={{-78,58},{-58,78}},
                rotation=0)));
        Modelica.Electrical.Analog.Sensors.VoltageSensor uSensor annotation (
            Placement(visible=true, transformation(
              origin={-43,15},
              extent={{-9,-9},{9,9}},
              rotation=270)));
        Modelica.Electrical.Analog.Sources.SignalCurrent iDrawn annotation (
            Placement(visible=true, transformation(
              origin={-12,18},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Math.Product product annotation (Placement(visible=true,
              transformation(
              origin={18,18},
              extent={{-8,-8},{8,8}},
              rotation=180)));
        Inverse inverse(k=1) annotation (Placement(visible=true, transformation(
              origin={10,50},
              extent={{-10,-10},{10,10}},
              rotation=0)));
      equation
        connect(PI.y, product.u1) annotation (Line(points={{11.2,-44},{2,-44},{
                2,-20},{40,-20},{40,13.2},{27.6,13.2}}, color={0,0,127}));
        connect(inverse.y, product.u2) annotation (Line(points={{20.6,50},{40,
                50},{40,22.8},{27.6,22.8}}, color={0,0,127}));
        connect(uSensor.v, inverse.u) annotation (Line(points={{-52,15},{-54,15},
                {-54,50},{-1,50}}, color={0,0,127}));
        connect(product.y, iDrawn.i)
          annotation (Line(points={{9.2,18},{-5,18}}, color={0,0,127}));
        connect(uSensor.n, iDrawn.n) annotation (Line(points={{-43,6},{-43,-28},
                {-12,-28},{-12,8}}, color={0,0,255}));
        connect(pSensor.nc, iDrawn.p) annotation (Line(points={{-58,68},{-12,68},
                {-12,28}}, color={0,0,255}));
        connect(iDrawn.n, pin_n) annotation (Line(points={{-12,8},{-12,-64},{-98,
                -64}}, color={0,0,255}));
        connect(uSensor.p, pSensor.nc) annotation (Line(points={{-43,24},{-43,
                68},{-58,68}}, color={0,0,255}));
        connect(feedback1.u2, pSensor.power) annotation (Line(points={{56,-36},
                {56,-8},{-76,-8},{-76,57}}, color={0,0,127}));
        connect(pSensor.nv, pin_n) annotation (Line(points={{-68,58},{-68,-64},
                {-98,-64}}, color={0,0,255}));
        connect(feedback1.u1, Pref)
          annotation (Line(points={{64,-44},{100,-44}}, color={0,0,127}));
        connect(iDrawn.n, pin_n) annotation (Line(points={{-12,8},{-12,-64},{-98,
                -64}}, color={0,0,255}));
        connect(pSensor.nv, pin_n) annotation (Line(points={{-68,58},{-68,-64},
                {-98,-64}}, color={0,0,255}));
        connect(feedback1.u2, pSensor.power) annotation (Line(points={{56,-36},
                {56,-8},{-76,-8},{-76,57}}, color={0,0,127}));
        connect(uSensor.n, iDrawn.n) annotation (Line(points={{-43,6},{-43,-28},
                {-12,-28},{-12,8}}, color={0,0,255}));
        connect(uSensor.v, inverse.u) annotation (Line(points={{-52,15},{-54,15},
                {-54,50},{-1,50}}, color={0,0,127}));
        connect(feedback1.y, PI.u)
          annotation (Line(points={{47,-44},{29.6,-44}}, color={0,0,127}));
        v = pin_p.v - pin_n.v;
        connect(pSensor.pc, pin_p) annotation (Line(
            points={{-78,68},{-98,68}},
            color={0,0,255},
            smooth=Smooth.None));
        connect(pSensor.pv, pSensor.pc) annotation (Line(
            points={{-68,78},{-78,78},{-78,68}},
            color={0,0,255},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Line(
                      points={{-4,0},{70,0}},
                      color={0,0,0},
                      smooth=Smooth.None),Line(
                      points={{0,94},{0,-88},{-2,-90}},
                      color={0,0,255},
                      smooth=Smooth.None),Rectangle(
                      extent={{-28,68},{28,-52}},
                      lineColor={0,0,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Text(
                      extent={{42,58},{78,22}},
                      lineColor={255,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid,
                      textString="P")}),
          Documentation(info="<html>
    <p>Questo componente simula, mediante inseguimento di un riferimento esterno, un carico a potenza costante.</p>
    <p>I parametri k e T sono i parametri del regolatore PI che insegue l&apos;input. TIpicamente si potr&agrave; utilizzare k=1 e T di un ordine di grandezza pi&ugrave; piccolo delle costanti di tempo del segnale di ingresso di potenza</p>
    </html>"));
      end ConstPDC;

      block Inverse "Outputs the inverse of (input multiplied by k)"
        import Modelica.Constants.inf;
        import Modelica.Constants.eps;
        Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
              transformation(extent={{-128,-20},{-88,20}}), iconTransformation(
                extent={{-128,-18},{-92,18}})));
        Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
              transformation(extent={{98,-10},{118,10}}), iconTransformation(
                extent={{96,-10},{116,10}})));
        parameter Real k;
      equation
        if abs(u) < eps then
          y = inf;
        else
          y = 1.0/(k*u);
        end if;
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={
                  {-100,-100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
              graphics={Rectangle(
                      extent={{-100,100},{100,-100}},
                      lineColor={0,0,127},
                      fillPattern=FillPattern.Solid,
                      fillColor={255,255,255}),Text(
                      extent={{-10,-4},{60,52}},
                      lineColor={0,0,127},
                      textString="1"),Text(
                      extent={{-32,0},{76,-46}},
                      lineColor={0,0,127},
                      textString="k u"),Line(
                      points={{-14,0},{66,0}},
                      color={0,0,127},
                      smooth=Smooth.None),Text(
                      extent={{-86,-30},{-16,26}},
                      lineColor={0,0,127},
                      textString="y=")}));
      end Inverse;

      model Inverter
        Modelica.Blocks.Interfaces.RealInput u
          annotation (Placement(transformation(extent={{140,-20},{100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
        Modelica.Blocks.Math.Gain gain(k=LossFact)
          annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
        parameter Real LossFact=4 "Loss Factor (W per AC Arms)";
      equation
        connect(gain.u, u) annotation (Line(
            points={{12,0},{120,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(gain.y, y) annotation (Line(
            points={{-11,0},{-110,0}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
                preserveAspectRatio=false), graphics), Icon(coordinateSystem(
              extent={{-100,-100},{100,100}},
              preserveAspectRatio=false,
              initialScale=0.1,
              grid={2,2}), graphics={Rectangle(
                      lineColor={0,0,127},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid,
                      extent={{-100,60},{100,-60}}),Text(
                      origin={0,4},
                      lineColor={0,0,255},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid,
                      extent={{-100,102},{100,62}},
                      textString="%name")}));
      end Inverter;
    end Internal;

    annotation (Icon(graphics={
          Ellipse(extent={{-36,40},{40,-36}}, lineColor={0,0,0}),
          Line(
            points={{4,82},{-6,82},{-10,72},{-24,68},{-34,78},{-46,70},{-42,58},
                {-54,46},{-66,50},{-74,36},{-66,30},{-68,16},{-78,12},{-78,2}},

            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{4,-78},{-6,-78},{-10,-68},{-24,-64},{-34,-74},{-46,-66},{-42,
                -54},{-54,-42},{-66,-46},{-74,-32},{-66,-26},{-68,-12},{-78,-8},
                {-78,2}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{2,-78},{12,-78},{16,-68},{30,-64},{40,-74},{52,-66},{48,-54},
                {60,-42},{72,-46},{80,-32},{72,-26},{74,-12},{84,-8},{84,2}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{2,82},{12,82},{16,72},{30,68},{40,78},{52,70},{48,58},{60,
                46},{72,50},{80,36},{72,30},{74,16},{84,12},{84,2}},
            color={0,0,0},
            smooth=Smooth.None)}));

  end SupportModels;

  package Icons
    model EcuIcon
      SupportModels.Conn conn1 annotation (Placement(
          visible=true,
          transformation(extent={{-20,78},{20,118}}, rotation=0),
          iconTransformation(extent={{-20,80},{20,120}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput motTauInt annotation (Placement(
          visible=true,
          transformation(extent={{-140,-20},{-100,20}}, rotation=0),
          iconTransformation(extent={{-140,-20},{-100,20}}, rotation=0)));
      annotation (Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-4,-40},{74,16},{74,-6},{-4,-62},{-4,-40}},
                  lineColor={95,95,95},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{8,-38},{28,-48},{20,-54},{0,-44},{8,-38}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{20,-54},{28,-48},{32,-56},{24,-62},{20,-54}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{24,-62},{32,-56},{32,-78},{24,-84},{24,-62}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{0,-44},{20,-54},{24,-62},{24,-84},{22,-84},{22,-62},
                {20,-58},{0,-48},{0,-44}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-14,40},{-18,32},{-10,38},{-8,44},{-14,40}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-18,32},{-10,38},{-10,14},{-18,8},{-18,32}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-20,10},{-20,32},{-16,40},{4,30},{4,26},{-16,36},{-18,
                32},{-18,8},{-20,10}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-8,46},{12,36},{4,30},{-16,40},{-8,46}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{28,-22},{48,-32},{40,-38},{20,-28},{28,-22}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{40,-38},{48,-32},{52,-40},{44,-46},{40,-38}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{44,-46},{52,-40},{52,-62},{44,-68},{44,-46}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{20,-28},{40,-38},{44,-46},{44,-68},{42,-68},{42,-46},
                {40,-42},{20,-32},{20,-28}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{48,-8},{68,-18},{60,-24},{40,-14},{48,-8}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{60,-24},{68,-18},{72,-26},{64,-32},{60,-24}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{64,-32},{72,-26},{72,-48},{64,-54},{64,-32}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{40,-14},{60,-24},{64,-32},{64,-54},{62,-54},{62,-32},
                {60,-28},{40,-18},{40,-14}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{68,6},{88,-4},{80,-10},{60,0},{68,6}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{80,-10},{88,-4},{92,-12},{84,-18},{80,-10}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{84,-18},{92,-12},{92,-34},{84,-40},{84,-18}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{60,0},{80,-10},{84,-18},{84,-40},{82,-40},{82,-18},{
                80,-14},{60,-4},{60,0}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-34,26},{-38,18},{-30,24},{-28,30},{-34,26}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-38,18},{-30,24},{-30,0},{-38,-6},{-38,18}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-40,-4},{-40,18},{-36,26},{-16,16},{-16,12},{-36,22},
                {-38,18},{-38,-6},{-40,-4}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-28,32},{-8,22},{-16,16},{-36,26},{-28,32}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-54,12},{-58,4},{-50,10},{-48,16},{-54,12}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-58,4},{-50,10},{-50,-14},{-58,-20},{-58,4}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-60,-18},{-60,4},{-56,12},{-36,2},{-36,-2},{-56,8},{
                -58,4},{-58,-20},{-60,-18}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-48,18},{-28,8},{-36,2},{-56,12},{-48,18}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-74,-4},{-78,-12},{-70,-6},{-68,0},{-74,-4}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-78,-12},{-70,-6},{-70,-30},{-78,-36},{-78,-12}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-80,-34},{-80,-12},{-76,-4},{-56,-14},{-56,-18},{-76,
                -8},{-78,-12},{-78,-36},{-80,-34}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-68,2},{-48,-8},{-56,-14},{-76,-4},{-68,2}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-64,-8},{-4,-40},{-4,-62},{-64,-30},{-64,-8}},
                  lineColor={95,95,95},
                  fillColor={75,75,75},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{-64,-8},{-4,-40},{74,16},{14,48},{-64,-8}},
                  lineColor={95,95,95},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Text(
                  origin={-1,-42},
                  lineColor={0,0,255},
                  extent={{-119,-64},{119,-104}},
                  textString="%name"),Rectangle(
                  extent={{-98,92},{98,62}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None)}), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics));
    end EcuIcon;

    model SupportIcon
      annotation (Icon(graphics={Ellipse(extent={{-38,38},{38,-38}}, lineColor=
              {0,0,0}),Line(
                  points={{2,80},{-8,80},{-12,70},{-26,66},{-36,76},{-48,68},{-44,
                56},{-56,44},{-68,48},{-76,34},{-68,28},{-70,14},{-80,10},{-80,
                0}},
                  color={0,0,0},
                  smooth=Smooth.None),Line(
                  points={{2,-80},{-8,-80},{-12,-70},{-26,-66},{-36,-76},{-48,-68},
                {-44,-56},{-56,-44},{-68,-48},{-76,-34},{-68,-28},{-70,-14},{-80,
                -10},{-80,0}},
                  color={0,0,0},
                  smooth=Smooth.None),Line(
                  points={{0,-80},{10,-80},{14,-70},{28,-66},{38,-76},{50,-68},
                {46,-56},{58,-44},{70,-48},{78,-34},{70,-28},{72,-14},{82,-10},
                {82,0}},
                  color={0,0,0},
                  smooth=Smooth.None),Line(
                  points={{0,80},{10,80},{14,70},{28,66},{38,76},{50,68},{46,56},
                {58,44},{70,48},{78,34},{70,28},{72,14},{82,10},{82,0}},
                  color={0,0,0},
                  smooth=Smooth.None)}));
    end SupportIcon;
  end Icons;

  model FullModel
    import Modelica.Constants.*;
    extends Modelica.Icons.Example;
    parameter Real vMass=1300;
    parameter Real wIceStart=50;
    parameter Real factorDebug=100;
    // rad/s
    Modelica.SIunits.Energy EbatDel "energy delivered by the battery";
    Modelica.SIunits.Energy EgenDelM
      "energy delivered by gen trough mechanical flange";
    Modelica.SIunits.Energy Eroad
      "mechanical energy absorbed by roas (friction & air)";
    Modelica.SIunits.Energy EiceDel "mechanical energy delivered by ice";
    Modelica.SIunits.Energy Emot, Emass;
    Modelica.Mechanics.Rotational.Components.IdealPlanetary PSD(ratio=78/30)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-50,52})));
    Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=3.905)
      annotation (Placement(transformation(extent={{2,42},{22,62}})));
    Modelica.Mechanics.Translational.Sensors.SpeedSensor carVel annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={78,-12})));
    Modelica.Mechanics.Translational.Components.Mass mass(v(fixed=true, start=0),
        m=vMass)
      annotation (Placement(transformation(extent={{54,42},{74,62}})));
    SupportModels.DragForce dragForce(
      fc=0.014,
      rho=1.226,
      m=vMass,
      S=2.2,
      Cx=0.26) annotation (Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={89,29})));
    MapBased.MBiceConnP ice(vMass=vMass, wIceStart=wIceStart)
      annotation (Placement(transformation(extent={{-98,46},{-78,66}})));
    SupportModels.Batt1Conn bat(
      ECellMin=0.9,
      ECellMax=1.45,
      R0Cell=0.0003,
      ns=168,
      QCellNom=2*6.5*3600.0,
      SOCInit=0.6,
      ICellMax=1e5,
      iCellEfficiency=15*6.5) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,0})));
    SupportModels.PropDriver driver(
      CycleFileName="nedc.txt",
      k=1,
      yMax=1.8) annotation (Placement(visible=true, transformation(extent={{-58,
              -50},{-38,-30}}, rotation=0)));
    SupportModels.Conn d annotation (Placement(
        visible=true,
        transformation(extent={{2,-40},{28,-16}}, rotation=0),
        iconTransformation(extent={{4,-52},{30,-28}}, rotation=0)));
    MapBased.MBecu1soc ECU(genLoopGain=1, socLoopGain=1e5) annotation (
        Placement(visible=true, transformation(
          origin={-10,-41},
          extent={{-10,-9},{10,9}},
          rotation=0)));
    MapBased.MBTwoFlangeConn mot annotation (Placement(visible=true,
          transformation(extent={{-28,62},{-8,42}}, rotation=0)));
    Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius=
          0.31) annotation (Placement(visible=true, transformation(
          origin={38,52},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
          visible=true, transformation(
          origin={10,26},
          extent={{10,10},{-10,-10}},
          rotation=270)));
    MapBased.MBOneFlangeConn gen annotation (Placement(visible=true,
          transformation(extent={{-38,14},{-58,34}}, rotation=0)));
  equation
    connect(gen.pin_p, bat.p) annotation (Line(points={{-38,28},{-24,28},{-24,
            10},{-23.75,10}}, color={0,0,255}));
    connect(gen.pin_n, bat.n) annotation (Line(points={{-38,20},{-8.5,20},{-8.5,
            10.1}}, color={0,0,255}));
    connect(gen.flange_a, PSD.sun)
      annotation (Line(points={{-58,24},{-58,24},{-70,24},{-70,52},{-60,52}}));
    connect(gen.conn, ECU.conn1) annotation (Line(
        points={{-58,16.2},{-58,-20},{-10,-20},{-10,-32.18}},
        color={255,204,51},
        thickness=0.5));
    connect(ground.p, bat.n) annotation (Line(points={{0,26},{-8.5,26},{-8.5,
            10.1}}, color={0,0,255}));
    connect(wheel.flangeT, mass.flange_a)
      annotation (Line(points={{48,52},{54,52}}, color={0,127,0}));
    connect(wheel.flangeR, idealGear.flange_b)
      annotation (Line(points={{28,52},{22,52}}));
    connect(PSD.ring, mot.flange_a)
      annotation (Line(points={{-40,52},{-34,52},{-28,52}}));
    connect(idealGear.flange_a, mot.flange_b)
      annotation (Line(points={{2,52},{-4,52},{-4,52.2},{-8,52.2}}));
    connect(mot.pin_p, bat.p) annotation (Line(points={{-22,42.2},{-22,10},{-23.75,
            10}}, color={0,0,255}));
    connect(mot.pin_n, bat.n) annotation (Line(points={{-14,42},{-14,10.1},{-8.5,
            10.1}}, color={0,0,255}));
    connect(mot.conn1, ECU.conn1) annotation (Line(
        points={{-27.2,59.8},{-27.2,76},{50,76},{50,-20},{-10,-20},{-10,-32.18}},

        color={255,204,51},
        thickness=0.5));

    connect(bat.conn, ECU.conn1) annotation (Line(
        points={{-15.75,-10},{-16,-10},{-16,-20},{-10,-20},{-10,-32.18}},
        color={255,204,51},
        thickness=0.5));
    connect(ice.conn, ECU.conn1) annotation (Line(
        points={{-88,46.2},{-88,46.2},{-88,-20},{-10,-20},{-10,-32.18}},
        color={255,204,51},
        thickness=0.5));
    connect(ECU.conn1, d) annotation (Line(
        points={{-10,-32.18},{-10,-28},{15,-28}},
        color={255,204,51},
        thickness=0.5));
    connect(carVel.v, driver.V) annotation (Line(points={{78,-23},{78,-58},{-48,
            -58},{-48,-51.2}}, color={0,0,127}));
    der(EbatDel) = (bat.p.v - bat.n.v)*bat.n.i;
    der(EgenDelM) = gen.pin_p.i*(gen.pin_p.v - gen.pin_n.v) + gen.flange_a.tau*
      der(gen.flange_a.phi);
    der(Eroad) = dragForce.flange.f*der(dragForce.flange.s);
    der(EiceDel) = -ice.flange_a.tau*der(ice.flange_a.phi);
    der(Emot) = mot.flange_a.tau*der(mot.flange_a.phi) + mot.flange_b.tau*der(
      mot.flange_b.phi);
    Emass = 0.5*mass.m*der(mass.flange_a.s)^2;
    connect(PSD.carrier, ice.flange_a) annotation (Line(
        points={{-60,56},{-70,56},{-70,56},{-78,56}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(dragForce.flange, mass.flange_b) annotation (Line(
        points={{89,38},{90,38},{90,52},{74,52}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(carVel.flange, mass.flange_b) annotation (Line(
        points={{78,-2},{78,52},{74,52}},
        color={0,127,0},
        smooth=Smooth.None));
    connect(ECU.tauReference, driver.tauRef) annotation (Line(points={{-22,-41},
            {-29,-41},{-29,-40},{-37,-40}}, color={0,0,127}));
    annotation (
      __Dymola_experimentSetupOutput,
      Documentation(info="<html>
<p>This model tries to make the ICE to operate at the highest possible torque since this corresponds to the best fuel consumption given the delivered power. </p>
<p>This has two main inconveniences:</p>
<ul>
<li>the battery SOC is not controlled and tends to drift</li>
<li>in urban environment the power is too low to allow efficient drive without shutting off the engine.</li>
</ul>
<p>Both these inconveniencess are addressed in podel PSecu2.</p>
</html>"),
      Diagram(coordinateSystem(
          extent={{-100,-60},{100,80}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={2,2})),
      Icon(coordinateSystem(
          extent={{-100,-100},{100,100}},
          preserveAspectRatio=false,
          initialScale=0.1,
          grid={2,2})),
      experiment(
        StartTime=0,
        StopTime=1400,
        Tolerance=0.0001,
        Interval=2.8));
  end FullModel;
  annotation (
    uses(Modelica(version="3.2.2"), Complex(version="3.2.2")),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{-60,16},{78,16},{94,0},{96,-16},{-98,-16},{-90,0},{-76,12},{
              -60,16}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,-4},{-30,-40}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,-6},{74,-42}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,16},{-18,46},{46,46},{74,16},{-54,16}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-86,-6},{-92,4}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{98,-10},{92,-4}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,20},{-20,42},{16,42},{14,20},{-46,20}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{22,42},{42,42},{60,20},{20,20},{22,42}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,-12},{-40,-30}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{44,-14},{64,-32}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>Library containing models of components, subsystems and full vehicle examples for simulation of electric and Hybrid vehicular power trains.</p>
<p>A general description of the library composition and on how to use it effectively is in the compaion paper:</p>
<p>M. Ceraolo &QUOT;Modelica Electric and hybrid power trains library&QUOT; submitted for publication at the 11th International Modelica Conference, 2015, September 21-23, Palais des congr&egrave;s de Versailles, 23-23 September, France</p>
</html>"));
end Test35s;
