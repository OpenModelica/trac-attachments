within ;
package MutualInductanceTesting

  model MutualInductorTest
    extends Modelica.Icons.Example;

    parameter Integer m=4 "Number of phases";
    parameter Modelica.SIunits.Voltage Vmax=0.5 "Peak supply voltage";
    parameter Modelica.SIunits.Frequency f=50 "Frequency";
    parameter Modelica.SIunits.Resistance R=2.50862436E-02;
    parameter Modelica.SIunits.Inductance L11=9.346575024E-04;
    parameter Modelica.SIunits.Inductance L12=3.186119548E-04;
    parameter Modelica.SIunits.Inductance L13=6.89656993E-04;
    parameter Modelica.SIunits.Inductance L14=4.550194689E-04;
    parameter Modelica.SIunits.Inductance L21=3.186119548E-04;
    parameter Modelica.SIunits.Inductance L22=9.346575024E-04;
    parameter Modelica.SIunits.Inductance L23=4.550194689E-04;
    parameter Modelica.SIunits.Inductance L24=6.89656993E-04;
    parameter Modelica.SIunits.Inductance L31=6.896570219E-04;
    parameter Modelica.SIunits.Inductance L32=4.550194784E-04;
    parameter Modelica.SIunits.Inductance L33=9.346544792E-04;
    parameter Modelica.SIunits.Inductance L34=6.896568904E-04;
    parameter Modelica.SIunits.Inductance L41=4.550194784E-04;
    parameter Modelica.SIunits.Inductance L42=6.896570219E-04;
    parameter Modelica.SIunits.Inductance L43=6.896568904E-04;
    parameter Modelica.SIunits.Inductance L44=9.346544792E-04;
    parameter Modelica.SIunits.Inductance L[m,m]={{L11,L12,L13,L14},{L21,L22,L23,L24},{L31,L32,L33,L34},{L41,L42,L43,L44}};

    MutualInductor mutualInductor(L=L, m=m,epsilon=1E-7) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource(
      m=m,
      V=fill(Vmax/sqrt(2), m),
      phi=fill(0, m),
      f=f) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,10})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(m=m, R_ref=fill(R, m))  annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m=m) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,-20})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  equation
    connect(ground.pin, star.pin_n) annotation (Line(points={{-60,-40},{-60,-35},{-60,-30}}, color={85,170,255}));
    connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-60,-10},{-60,-5},{-60,0}}, color={85,170,255}));
    connect(voltageSource.plug_p, resistor.plug_p) annotation (Line(points={{-60,20},{-60,20},{-60,28},{-60,30},{-50,30}}, color={85,170,255}));
    connect(resistor.plug_n, mutualInductor.plug_p) annotation (Line(points={{-30,30},{-25,30},{-20,30}}, color={85,170,255}));
    connect(mutualInductor.plug_n, star.plug_p) annotation (Line(points={{0,30},{6,30},{10,30},{10,-4},{10,-10},{-60,-10}},  color={85,170,255}));
  end MutualInductorTest;

  model MutualInductor
    extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.OnePort;
    import Modelica.ComplexMath.j;
    parameter Real epsilon=1e-9
      "Relative accuracy tolerance of matrix symmetry";
    parameter Modelica.SIunits.Inductance L[m, m] "Mutual inductance matrix";
  initial equation
    if abs(Modelica.Math.Matrices.det(L)) < epsilon then
      Modelica.Utilities.Streams.print(
        "Warning: mutual inductance matrix singular!");
    end if;
  equation
    assert(sum(abs(L - transpose(L))) < epsilon*sum(abs(L)),
      "Mutual inductance matrix is not symmetric");
    for j in 1:m loop
      v[j] = sum(j*omega*L[j, k]*i[k] for k in 1:m);
    end for;
    annotation (Documentation(info="<html>
<p>
Model of a multi phase inductor providing a mutual inductance matrix model.
</p>
<H4>Implementation</H4>
<pre>
  v[1] = j*omega*L[1,1]*i[1] + j*omega*L[1,2]*i[2] + ... + j*omega*L[1,m]*i[m]
  v[2] = j*omega*L[2,1]*i[1] + j*omega*L[2,2]*i[2] + ... + j*omega*L[2,m]*i[m]
     :              :                     :                           :
  v[m] = j*omega*L[m,1]*i[1] + j*omega*L[m,2]*i[2] + ... + j*omega*L[m,m]*i[m]
</pre>

</html>"),
         Icon(graphics={
          Ellipse(extent={{30,-50},{60,10}}, lineColor={85,170,255}),
          Ellipse(extent={{0,-50},{30,10}}, lineColor={85,170,255}),
          Ellipse(extent={{-30,-50},{0,10}}, lineColor={85,170,255}),
          Ellipse(extent={{-60,-50},{-30,10}}, lineColor={85,170,255}),
          Line(points={{-80,20},{-80,-20},{-60,-20}}, color={85,170,255}),
          Line(points={{-80,20},{-60,20}}, color={85,170,255}),
          Ellipse(extent={{-60,-10},{-30,50}}, lineColor={85,170,255}),
          Ellipse(extent={{-30,-10},{0,50}}, lineColor={85,170,255}),
          Ellipse(extent={{0,-10},{30,50}}, lineColor={85,170,255}),
          Ellipse(extent={{30,-10},{60,50}}, lineColor={85,170,255}),
          Line(points={{60,20},{80,20}}, color={85,170,255}),
          Line(points={{80,20},{80,-20},{60,-20}}, color={85,170,255}),
          Rectangle(
            extent={{-60,0},{60,20}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Rectangle(
            extent={{-60,-20},{60,0}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Line(points={{-90,0},{-80,0}}, color={85,170,255}),
          Line(points={{80,0},{90,0}}, color={85,170,255}),
          Text(
            extent={{100,60},{-100,100}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-100,-100},{100,-60}},
            lineColor={0,0,0},
            textString="m=%m")}));
  end MutualInductor;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(Modelica(version="3.2.2")));
end MutualInductanceTesting;
