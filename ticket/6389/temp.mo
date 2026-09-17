package PowerSysPro
  //Copyright 2020 EDF
  import CM = PowerSysPro.Functions;

  package Functions "Functions and constants"
    //final constant Real pi= 2 * Functions.asin(1.0) "Pi number";

   function abs "Absolute value of complex number"
      input Complex c "Complex number";
      output Real result "= abs(c)";

   algorithm
      result := (c.re ^ 2 + c.im ^ 2) ^ 0.5;

   end abs;

   function fromPolar "Complex from polar representation"
      input Real len "abs of complex";
      input Types.myAngle phi "arg of complex";
      output Complex c "= len * cos(phi) + j * len * sin(phi)";
   algorithm
      c :=Complex(len*cos(phi), len*sin(phi));

   end fromPolar;

   function conj "Conjugate of complex number"
      input Complex c1 "Complex number";
      output Complex c2 "= c1.re - j*c1.im";
   algorithm
      c2 := Complex(c1.re, -c1.im);

   end conj;

  function cos "Cosine"
    input Types.myAngle u "Independent variable";
    output Real y "Dependent variable y=cos(u)";

  external "builtin" y = cos(u);

  end cos;

  function sin "Sine"
    input Types.myAngle u "Independent variable";
    output Real y "Dependent variable y=sin(u)";

  external "builtin" y = sin(u);

  end sin;

  function asin "Inverse sine (-1 <= u <= 1)"
    input Real u "Independent variable";
    output Types.myAngle y "Dependent variable y=asin(u)";

  external "builtin" y = asin(u);

  end asin;
    annotation (
      Icon(graphics={  Text(extent = {{-72, 58.9}, {78, -53.1}}, lineColor = {28, 108, 200}, fontName = "Segoe Print", textString = "F")}),
      Documentation(info = "<html>
    <p>Rewrite MSL functions for portability needs.</p>
</body></html>"));
  end Functions;

  package Types "Domain-specific type definitions"
    type myVoltage = Real(nominal = 1e3, unit = "V", displayUnit = "kV");
    type myCurrent = Real(nominal = 1e-3, unit = "A", displayUnit = "A");
    type myActivePower = Real(unit = "W", displayUnit = "kW");
    type myReactivePower = Real(unit = "var", displayUnit = "kvar");
    type myApparentPower = Real(unit = "VA", displayUnit = "kVA");
    type myApparentPowerMVA = Real(unit = "kVA", displayUnit = "MVA");
    type myResistance = Real(unit = "Ohm", displayUnit = "Ohm");
    type myReactance = Real(unit = "Ohm", displayUnit = "Ohm");
    type myConductance = Real(unit = "S", displayUnit = "S");
    type mySusceptance = Real(unit = "S", displayUnit = "S");
    type myAngle = Real(unit = "rad", displayUnit = "deg");
    type myPerUnit = Real(unit = "1");
    type myTime = Real(unit = "s", displayUnit = "s");
    operator record myComplexVoltage =
      Complex(redeclare myVoltage re "Imaginary part of complex voltage",
              redeclare myVoltage im "Real part of complex voltage")
      "Complex voltage";
    operator record myComplexCurrent =
      Complex(redeclare myCurrent re "Real part of complex current",
              redeclare myCurrent im "Imaginary part of complex current")
      "Complex current";
    operator record myComplexAdmittance =
      Complex(redeclare myConductance re "Real part of complex admittance (conductance)",
              redeclare mySusceptance im "Imaginary part of complex admittance (susceptance)")
      "Complex admittance";
    operator record myComplexImpedance =
      Complex(redeclare myResistance re "Real part of complex impedance (resistance)",
              redeclare myReactance im "Imaginary part of complex impedance (reactance)")
      "Complex impedance";
    operator record myComplexPerUnit =
       Complex(re(unit = "1"),
               im(unit = "1"))
       "Complexe per unit";
    annotation (
      Documentation(info = "<html>
    <p>This package gathers dedicated icons for all models in this library.</p>
</body></html>"));
  end Types;

  annotation (
    version = "Version 2.1.2 February 18th, 2021",
    Documentation(info = "<html><head></head><body>
    <p>Copyright © 2020-2021, EDF.</p>
    <p>The use of the PowerSysPro library is granted by EDF under the provisions of the Modelica License 2. A copy of this license can be obtained&nbsp;<a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">here</a>.</p>
    <p></p><p>-------------------------------------------------------------------------------------------------------------</p>
<p>For further technical information, see the <a href=\"modelica://PowerSysPro.Information\">Information</a>.</p>
</body></html>"),
    Diagram(graphics={  Text(lineColor = {28, 108, 200}, extent = {{-174, 28}, {180, -28}}, fontSize = 14, textStyle = {TextStyle.Bold}, textString = "Open electrical library
developed at EDF Lab. Paris-Saclay")}),
    Icon(graphics={                                                                                                                                                                                                        Text(extent={{
              -208,70},{214,-60}},                                                                                                                                                                                                      lineColor=
              {28,108,200},                                                                                                                                                                                                        fontName=
              "Segoe Print",
          textString="PSP")}),
    uses(Modelica(version="4.0.0")));
end PowerSysPro;
