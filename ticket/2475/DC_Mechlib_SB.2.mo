package DC_Mechlib_SB "Simster library"
  package Components
    package Linear
      model Clamp "Fixed translational clamp"
        import SI = Modelica.SIunits;
        parameter SI.Position s0 = 0 "fixed position";
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation(Placement(transformation(origin = {0,0}, extent = {{-10,10},{10,-10}}, rotation = 180), iconTransformation(extent = {{-10,10},{10,-10}}, rotation = 180, origin = {100,0})));
      equation
        flange.s = s0;
        annotation(Icon(graphics = {Polygon(points = {{0,60},{-60,-40},{60,-40},{0,60}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-64,-56},{-52,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{42,-56},{54,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{28,-56},{40,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{14,-56},{26,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-2,-56},{10,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-18,-56},{-6,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,-56},{-22,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-50,-56},{-38,-40}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component supplies a constant position value.
</p>

<h4>2. Application area</h4>
<p>
The component serves for the clamping of other components at a certain position.
</p>

<h4>3. Features</h4>
<p>
No special features are included.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
No limits or assumptions are required.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The flange_a.s complies the parameter <i>s0</i>.
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
flange.s = s0;
</td>
</table>
</ul>
</p>

</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Clamp, linear</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Fixed</p></td>
<td><p>Component from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
</p>


<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Clamp;
      model Deformation
        import SI = Modelica.SIunits;
        parameter SI.Length L "idle stroke";
        parameter SI.TranslationalSpringConstant c1 "stiffness elastic compression";
        parameter SI.TranslationalSpringConstant c2 "stiffness plastic compression";
        parameter SI.TranslationalSpringConstant c3 "stiffness decompression compression";
        parameter SI.Force Fel "elastic limit";
        parameter SI.Length minPos "Position change before decompression";
        parameter Integer nmax "Numer of lifts for multi lift deformation";
        parameter Boolean Multistroke "Multi lift deformation";
        SI.Position s;
        SI.Velocity v "Geschwindigkeit";
        SI.Position Smax "maximale Position";
        Integer Deformationsmode;
        SI.Position s3;
        Integer n;
      protected
        constant Integer idle_stroke = 0;
        constant Integer elastic = 1;
        constant Integer compression = 2;
        constant Integer decompression = 3;
        constant Integer zero_force = 4;
        parameter Real s1 = L + Fel / c1;
      public
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}), iconTransformation(extent = {{-110,-10},{-90,10}})));
      algorithm
        when Deformationsmode == idle_stroke and s > L and s <= s1 then
                  Deformationsmode:=elastic;        elsewhen Deformationsmode == elastic and s <= L then
          Deformationsmode:=idle_stroke;
elsewhen Deformationsmode == elastic and s > s1 and v > 0 then
          Deformationsmode:=compression;
elsewhen Deformationsmode == compression and v < 0 and s < Smax - minPos then
          Deformationsmode:=decompression;
elsewhen Deformationsmode == decompression and flange_a.f > 0.0000000001 then
          Deformationsmode:=zero_force;
          s3:=s;
elsewhen Deformationsmode == zero_force and s > s3 and v > 0 and n < nmax and Multistroke then
          Deformationsmode:=compression;
          n:=n + 1;
elsewhen Deformationsmode == decompression and v > 0 and s > Smax - minPos then
          Deformationsmode:=compression;
elsewhen Deformationsmode == zero_force and s < L then
          Deformationsmode:=idle_stroke;
elsewhen Deformationsmode == zero_force and s > s3 and v < 0 and not Multistroke then
          Deformationsmode:=decompression;
        end when;
      equation
        s = flange_a.s;
        v = der(s);
        if Deformationsmode == elastic then
          flange_a.f = -c1 * (s - L);
        elseif Deformationsmode == compression then
          flange_a.f = -(c2 * (s - s1) + Fel);
        elseif Deformationsmode == decompression then
          flange_a.f = -(c3 * (s - Smax) + c2 * (Smax - s1) + Fel);
        else
          flange_a.f = 0;
        end if;
        Smax = noEvent(max(s, Smax)) annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
        annotation(Diagram(coordinateSystem(extent = {{-100,-120},{100,80}})), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-80,80},{-80,-80},{80,-80}}, color = {0,0,0}, smooth = Smooth.None),Polygon(points = {{-60,-80},{-40,20},{80,60},{40,-80},{-60,-80}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{-88,48},{-56,26}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "F
"),Text(extent = {{54,-74},{98,-98}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "x"),Text(extent = {{-86,-12},{-52,-40}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "c"),Text(extent = {{-20,66},{14,38}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "c"),Text(extent = {{50,-6},{84,-34}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "c"),Text(extent = {{-78,48},{-46,26}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "e
"),Text(extent = {{64,-74},{108,-98}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "0"),Text(extent = {{62,-6},{96,-34}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "3"),Text(extent = {{-74,-12},{-40,-40}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "1"),Text(extent = {{-8,66},{26,38}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "2"),Text(extent = {{-70,48},{-38,26}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, textString = "l
")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The <i>Deformation</i> component calculates the force that is required in order to deform a workpiece. 
The idle stroke specifies the path that has to be travelled until the workpiece to be deformed is reached.
</p>

<h4>2. Application area</h4>
<p>
Use this model to calculate the counterforce resulting from a certain movement into a workpiece.
</p>

<h4>3. Features</h4>
<p>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
To avoid an unwanted change from compression to decompression, e.g. at small vibrations, the parameter Position change before decompression was inserted. 
The workpiece has to move back the entered length before the decompression starts. Within the the enterd length the stiffness of the plastic comporession is used.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The behaviour of the model can be clarified by means of a state diagram with the five states 
<i>zero force</i>, <i>idle stroke</i>, <i>elastic</i>, <i>compression</i> and <i>decompression</i> (see figure 2). 

</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/statesdeformation\" width=\"1000\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>state diagram of the deformation model</caption>
</table> 
</p>
<p>
Depending on the <i> deformationMode </i> the counterforce is calculated in the equation section as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
if deformationMode == elastic<br>
  flange_a.f = -c1 * (s - L);
</td>
</table>
</ul>
</p>
<p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if deformationsMode == compression <br>
    flange_a.f = -(c2 * (s - s1) + Fel);
</td>
</table>
</ul>
</p>
<p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if deformationsMode == decompression then<br>
    flange_a.f = -(c3 * (s - Smax) + k2 * (Smax - s1) + Fel);
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  else<br>
   flange_a.f = 0;
</td>
</table>
</ul>
</p>

<p>
If the workpiece is reached, the elastic deformation starts (stiffness <i>c1</i>). 
It continues until the force exceeds the set elasticity force <i>Fel</i>. At that time, the plastic deformation starts. 
It is divided into two more phases, plastic compression (stiffness <i>c2</i>) and decompression (stiffness <i>c3</i>). 
Plastic compression continues until the direction of movement is inverted. After that, plastic decompression starts (see Figure 2).

</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/deformation.jpg\" width=\"400\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>state diagram of the deformation model</caption>
</table> 
</p>
</p>
<p>
The position and velocity are calculated in the equation section as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
s = flange_a.s<br>
v = <font color=#FF0000>der</font>(s);<br>
</td>
</table>
</ul>
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Deformation</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<b><u>10.1 Testcase 1: Deformation with position allegation (for Dymola)</u></b>
</p>
<p>
This testcase checks if the counterforce is correct for a certain movement.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a deformation block, a position block and a timeTable block which is conected with a gain block (the latter three taken from the MSL).
The output of the gain blocks is connected with the input of the position block, while the position block output is connected 
with the deformation.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<br><u>timeTable</u>:<br>
 table = [0, 0; 1, 20; 2, 25; 3, 28; 5, 15]<br>
<br><u>gain</u>:<br>
 k = 0.001<br>
<br><u>deformation</u>:<br>
 L = 10 mm<br>
 c1 = 100000 N/m<br>
 c2 = 50000 N/m<br>
 c3 = 150000 N/m<br>
 Fel = 200 N<br>
 minPos = 0.1 mm<br>
 nmax = 1 <br>
 Multistroke = false <br>

<br><u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
flange_a <i>f</i> is tracked and plotted over the position
</p>


<h5>Plausibility checks</h5>
<p>
No force should act while flange_a.s is smaller then the idle stroke. After it reached the workpiece the force should be calculated with the corresponding contactstiffness. 
The curve should look like a quadangle with the gradients of c1, c2 and c3 (Note: Only if the results are plotted with the position as x-coordinate).
</p>


<h4>11. Implementation details</h4>
<P> 
In the implementation are no particularities.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Deformation;
      model DryFricStribeck
        import SI = Modelica.SIunits;
        parameter SI.Force Fh = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.Force Fc = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter SI.Mass m = 1 "mass";
        parameter SI.Acceleration g = 0 "gravity";
        parameter Real vis = 0 "viscous friction value in Ns/mm " annotation(Dialog(group = "Friction"));
        parameter SI.Velocity vh = 0.000001 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter Real stribeckFactor = Utilities.stribeckFunction(sticktionForce, vis, vh);
        //constant SI.Velocity velLimit = 0.0000005;
        parameter SI.Force sticktionForce = Fh - Fc;
        SI.Velocity v(stateSelect = StateSelect.always);
        SI.Acceleration a;
        SI.Force fR;
        SI.Force F_stribeck;
        Boolean Stiction;
        Boolean StartForw;
        Boolean Forward;
        Boolean StartBack;
        Boolean Backward;
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
      equation
        v = der(flange_a.s);
        a = der(v);
        flange_a.f = if Forward then Fh else if Backward then -Fh else if StartForw then F_stribeck else if StartBack then F_stribeck else fR;
        Forward = initial() and v > 0 or pre(StartForw) and v > 0 or pre(Forward) and not v <= 0;
        Backward = initial() and v < 0 or pre(StartBack) and v < 0 or pre(Backward) and not v >= 0;
        StartForw = pre(Stiction) and fR > Fh or pre(StartForw) and not (v > 0 or a <= 0 and not v > 0);
        StartBack = pre(Stiction) and fR < (-Fh) or pre(StartBack) and not (v < 0 or a >= 0 and not v < 0);
        Stiction = not (Forward or Backward or StartForw or StartBack);
        F_stribeck = Fc * sign(v) + vis * v + sticktionForce * exp(-stribeckFactor * abs(v)) * sign(v);
        0 = if Stiction or initial() then a else fR;
        when Stiction and not initial() then
                  reinit(v, 0);
        
        end when;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-80,-20},{60,-60}}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, pattern = LinePattern.None),Line(points = {{-80,60},{-80,-60},{60,-60},{60,-20}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-60,60},{80,20}}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, pattern = LinePattern.None),Line(points = {{-60,20},{-60,60},{80,60},{80,0},{100,0}}, pattern = LinePattern.None, smooth = Smooth.None)}));
      end DryFricStribeck;
      model ForceConstant
        import SI = Modelica.SIunits;
        parameter Real F;
        parameter String unit = "N" annotation(choices(choice = "N", choice = "kN", choice = "dyn", choice = "kp", choice = "pdl", choice = "lbf", choice = "yd"));
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        Modelica.Blocks.Sources.RealExpression realExpression(y = F) annotation(Placement(transformation(extent = {{-40,30},{-20,50}})));
        Modelica.Mechanics.Translational.Sources.Force2 force2_1 annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        if unit == "N" then
          force2_1.f = F;
        elseif unit == "kN" then
          force2_1.f = F * 1000;
        elseif unit == "dyn" then
          force2_1.f = F / 100000;
        elseif unit == "kp" then
          force2_1.f = F / 0.101972;
        elseif unit == "pdl" then
          force2_1.f = F / 7.233011;
        elseif unit == "lbf" then
          force2_1.f = F / 0.224809;
        else
          force2_1.f = F;
        end if;
        connect(force2_1.flange_b,flange_b) annotation(Line(points = {{10,0},{100,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(force2_1.flange_a,flange_a) annotation(Line(points = {{-10,0},{-100,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-84,40},{-58,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Text(extent = {{-24,76},{24,12}}, lineColor = {0,0,0}, lineThickness = 0.5, fillPattern = FillPattern.Solid, textString = "F"),Line(points = {{58,40},{82,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Line(points = {{70,50},{70,26}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Polygon(points = {{10,2},{10,-2},{70,-2},{70,-10},{80,0},{70,10},{70,2},{10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{-10,2},{-10,-2},{-70,-2},{-70,-10},{-80,0},{-70,10},{-70,2},{-10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Diagram(graphics), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component describes an active force. It outputs the force entered in the parameter <i> F </i> at coupling B with a positive sign and at coupling A with a negative sign.
</p>

<h4>2. Application area</h4>
<p>
Use this component to strain a certain force to other components.
</p>

<h4>3. Features</h4>
<p>
Choose the unit of the force through the drop-down menue.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
Both flanges have to be connected.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
Modelling contains the Force2 block from the MSL, which is connected with the flanges.
The flange_b.f complies the parameter <i>F</i> in a certain unit, where <i>F</i> is a real expression.
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
if unit = N<br>
force2_1.f = F;<br>
</td>
</table>
</ul>
</p>
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Force, constant</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Force2</p></td>
<td><p>Component from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Force acting on clamp and mass.</u></b>
</p>
<p>
This testcase checks if the movenment of a mass with a constant acting force is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a ForceConstant- and a Mass-block. The positive flange of the force is connected with flange_a of the mass.
The negative force acts on the clamp.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>ForceConstant</u>:<br>
F = 10 N<br>
<u>Mass</u>:<br>
g = 0 <br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
mass: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 0 and raise with a constant positive acceleration.
</p>
</p>


<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end ForceConstant;
      model ForceVariable "\"Transforms  signals to forces"
        parameter String unit = "N" annotation(choices(choice = "N", choice = "kN", choice = "dyn", choice = "kp", choice = "pdl", choice = "lbf", choice = "yd"));
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a "(left) driving flange (flange axis directed in to cut plane, e. g. from left to right)" annotation(Placement(transformation(extent = {{-110,-10},{-90,10}}, rotation = 0), iconTransformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b "(right) driven flange (flange axis directed out of cut plane)" annotation(Placement(transformation(extent = {{90,-10},{110,10}}, rotation = 0), iconTransformation(extent = {{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput f "Driving force as input signal" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {0,106}), iconTransformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {0,100})));
      equation
        if unit == "N" then
          flange_a.f = f;
        elseif unit == "kN" then
          flange_a.f = f * 1000;
        elseif unit == "dyn" then
          flange_a.f = f / 100000;
        elseif unit == "kp" then
          flange_a.f = f / 0.101972;
        elseif unit == "pdl" then
          flange_a.f = f / 7.233011;
        elseif unit == "lbf" then
          flange_a.f = f / 0.224809;
        else
          flange_a.f = f;
        end if;
        flange_a.f = -flange_b.f;
        annotation(Diagram(graphics), Icon(graphics = {Line(points = {{-84,40},{-58,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Text(extent = {{-24,76},{24,12}}, lineColor = {0,0,0}, lineThickness = 0.5, fillPattern = FillPattern.Solid, textString = "F"),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{58,40},{82,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Line(points = {{70,50},{70,26}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Polygon(points = {{10,2},{10,-2},{70,-2},{70,-10},{80,0},{70,10},{70,2},{10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{-10,2},{-10,-2},{-70,-2},{-70,-10},{-80,0},{-70,10},{-70,2},{-10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
Common force specification. This component allows to apply any force on a mechanical connection.
The signal at the input is applied to the flange_b with the selected unit. On the flange_a acts the corresponding counterforce with a negative sign.
</p>

<h4>2. Application area</h4>
<p>
Use this component to strain a variable force to other components.
</p>

<h4>3. Features</h4>
<p>
Choose the unit of the force through the drop-down menue.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
Both flanges have to be connected.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
Modelling contains the Force2 block of the MSL.
The flange_b.f complies the parameter <i>F</i> in a certain force unit, where <i>F</i> is a real input.
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
if unit = N<br>
force2_1.f = F;
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 flange_b.f = -flange_a.f;
</td>
</table>
</ul>
</p>

</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Force, variable</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Force</p></td>
<td><p>Component from the MSL </p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a ForceVariable-, a step- and a Mass-block. The positive flange of the force is connected with flange_a of the mass.
The negative force acts on the clamp. The stepblock forms the shape of the force.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>step</u>:<br>
height = 10<br>
offset = -5<br>
startTime = 0.5 s<br>
<u>Mass</u>:<br>
g = 0 <br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 2s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
mass: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 0 and fall with a constant negative acceleration of 5 m/s^2. After the step the acceleration should change to +5 and force the mass into the positive direction.
</p>
</p>
</p>


<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end ForceVariable;
      model Mass
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Acceleration g = -9.81 "gravitation";
        parameter SI.Mass m = 1 "mass";
        parameter Boolean initialize_s = false annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_v = false annotation(Dialog(group = "Initialization"));
        parameter SI.Position s_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity v_init = 0 annotation(Dialog(group = "Initialization"));
        SI.Position s;
        SI.Velocity v;
        SI.Acceleration a;
      initial equation
        if initialize_s then
          s = s_init;
        end if;
        if initialize_v then
          v = v_init;
        end if;
      equation
        assert(m > 0, "Negative mass is not allowed");
        v = der(s);
        a = der(v);
        m * a = m * g + flange_a.f + flange_b.f;
        s = flange_b.s;
        flange_b.s = flange_a.s;
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-60,20},{60,-40}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-50,16},{48,-26}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "m")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component represents a mass with a translational degree of freedom. 
Sign convention: A positive force at flange_a moves the mass in the positive direction. A negative force at flange_a moves the mass to the negative direction. 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of a mass.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>Using the <i>gravitation parameter</i>, the weight force of the mass can be set whereas positive gravitation corresponds to acceleration in positive direction.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The parameter <i>mass</i> must be greater zero.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
v = der(s);<br>
a = der(v);<br>
m * a = m * g + flange_a.f + flange_b.f;<br>
s = flange_b.s;<br>
flange_b.s = flange_a.s;
</td>
</table>
</ul>
</p>



<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Mass</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Mass</p></td>
<td><p>Model from the MSL (Include expansion aswell)</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Mass with Initial velocity and gravitation</u></b>
</p>
<p>
This testcase checks if the movenment of the mass wtih initial conditions is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains only a mass block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>mass</u>:<br>
initialize_s = true;<br>
initialize_v = true;<br>
s_init = 1 m;<br>
v_init = 20 m/s<br>
 

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
mass: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at the initial position of 1 m and a start velocity of 20 m/s. The gravitation causes a weight force, which acts in the negative direction.
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Mass;
      model MassEndstop
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Position lowlim = -0.5 "Lower Limit of endstop" annotation(Dialog(group = "Hard stop"));
        parameter SI.Position uplim = 0.5 "Upper limit of endstop" annotation(Dialog(group = "Hard stop"));
        parameter Real restitutionCoefficient(min = 5, max = 100, displayUnit = "%") = 5 "damping constant" annotation(Dialog(group = "Hard stop"));
        parameter SI.Mass m = 1 "Mass";
        parameter SI.Acceleration g = 0;
        parameter Boolean initialize_s = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_v = true annotation(Dialog(group = "Initialization"));
        parameter SI.Position s_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity v_init = 0 annotation(Dialog(group = "Initialization"));
        SI.Position pos;
        SI.Velocity vel(stateSelect = StateSelect.always);
        SI.Acceleration acce;
        SI.Force deltaf;
        Boolean Contact_up(start = false, fixed = true);
        Boolean Contact_down(start = false, fixed = true);
        Boolean Free(start = true, fixed = true);
      protected
        SI.Velocity vReachContact = 0.00001;
        SI.Velocity vLeaveContact = 0.00005;
        Real stosszahl = 1 - restitutionCoefficient / 100;
      initial equation
        if initialize_s then
          pos = s_init;
        end if;
        if initialize_v then
          vel = v_init;
        end if;
      initial algorithm
        assert(uplim > lowlim, "The upper limit must be grater then the lower limit.");
        assert(pos <= uplim, "The initial position must be smaller than or equal to the upper limit.");
        assert(pos >= lowlim, "The initial position must be greater than or equal to the lower limit.");
        assert(m > 0, "Negative mass is not allowed");
      equation
        Contact_up = initial() and flange_a.s >= uplim or pre(Free) and flange_a.s > uplim and vel > vReachContact;
        Contact_down = initial() and flange_a.s <= lowlim or pre(Free) and lowlim > flange_a.s and -vel > vReachContact;
        Free = initial() or pre(Contact_up) and (abs(vel) > vLeaveContact or deltaf < 0) or pre(Contact_down) and (abs(vel) > vLeaveContact or deltaf > 0) or pre(Free) and flange_a.s < uplim or flange_a.s > lowlim;
        acce = if Contact_up then g else if Contact_down then 0 else (deltaf + m * g) / m;
        when (Contact_up or Contact_down) and not initial() then
                  reinit(vel, -stosszahl * vel);
        
        end when;
        deltaf = flange_a.f - flange_b.f;
        pos = flange_a.s;
        vel = der(flange_a.s);
        acce = der(vel);
        flange_a.s = flange_b.s;
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-60,20},{60,-40}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-50,16},{48,-26}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "m"),Polygon(points = {{-80,0},{-80,-60},{80,-60},{80,0},{100,0},{100,-80},{-100,-80},{-100,0},{-80,0}}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component represents a mass with a translational degree of freedom. The mass can move between two defined contacts.
Sign convention: A positive force at flange_a moves the sliding mass in the positive direction. A negative force at flange_a moves the sliding mass to the negative direction. 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of a mass inside a defined range.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>The contact between the mass and the stop is modeled by a mechanical collision.</li>
<li>Input signals need to be a translatorical connecter which transers the postion <i>s</i> and the force <i>f</i>.</li>
<li>The parameter <i>Contact damping</i> describes the behavior of the impact.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The collisions between the mass and the contacts are not modeled by a spring-damper-pattern but an elastic impact.</li>
<li>The parameter <i>lower limit</i> must be smaller then the <i> upper limit</i>.</li>
<li>The parameter <i>mass</i> must be greater zero.</li>
<li>The parameter <i>Contact damping</i> must be between 5% and 100%.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
A Contact-damping value of 100% describes an ideal inelastic impact, where no energy is left for bouncing. A value of 0% describes an ideal elastic contact where the whole energy is used to bounce.
Ideal elastic impacts don?t occur in the real life. Also it would cause problems in the solver-proceedings. Thats why a lower limit of 5% is determined. The following picture shows the effects of different damping constants on a falling mass with gravity.</p> 

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:\10_ETI22\__Kollegen\_SvenB?tzing\DC_Mechlib\images\damping-constant.jpg\" width=\"1000\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Impact of different damping constants.</caption>
</table> 
</p>

<p>
The behaviour of the model can be clarified by means of a state diagram with the three states <i>contact_up</i>, <i>contact_down</i> and <i>free</i>
(see figure 2).
</p>

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
       <img src=\"W:\10_ETI22\__Kollegen\_SvenB?tzing\DC_Mechlib\images\states.jpg\" width=\"800\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>State diagram of the massendstop block</caption>
</table> 
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Mass, hard stop</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>MassWithStopAndFriction</p></td>
<td><p>Stribeck-friction is included aswell / restitutionCoefficient of 100%</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: MassEndstop with pulse-force-input signal (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the mass is correct for a pulse-shaped continous inputforce.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a massEndstop block, a force block and a pulse block (the latter two taken from the MSL).
The output of the pulse blocks is connected with the input of the force block, while the force block output is connected 
with the massEndstop input.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>massEndstop</u>:<br>
 lowlim = 0<br>
 uplim  = 1<br>
 restitutionCoefficient = 25<br>
 mass = 1<br>
 gravity = -9.81<br>
<u>pulse</u>:<br>
amplitude = 100<br> 
period = 1<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 2s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massEndstop: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start with 0 and raise to the upper limit. Then the mass should be bounced to other direction. 
When the pulse block dont create any force the movenment should be shaped like a freefall until the lower limit is reached.
</p>


<h4>11. Implementation details</h4>
<P> 
The internal boolean variable define the actual state. They are calculated in the equation part as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=0><tr>
<td>
  Contact_up = initial() and flange_a.s >= uplim or pre(Free) and flange_a.s > uplim and vel > vReachContact;<br>
  Contact_down = initial() and flange_a.s <= lowlim or pre(Free) and lowlim > flange_a.s and -vel > vReachContact;<br>
  Free = initial() or pre(Contact_up) and (abs(vel) > vLeaveContact or deltaf < 0) or pre(Contact_down) and (abs(vel) > vLeaveContact <br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or deltaf > 0) or pre(Free) and flange_a.s < uplim or flange_a.s > lowlim;
</td>
</table>
</ul>
</p>
<p>
Depending on the state the velocity is reinitialized and the acceleration <i>acce</i> is calculated in the equation section as follows:
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  acce = g; &nbsp;&nbsp;&nbsp;&nbsp;if Contact_up
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  acce = 0; &nbsp;&nbsp;&nbsp;&nbsp;if Contact_down
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  acce = (deltaf + m * g) / m; &nbsp;&nbsp;&nbsp;&nbsp;else
</td>
</table>
</ul>
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  when (Contact_up or Contact_down) and not initial() then<br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reinit(vel, -stosszahl * vel);<br>
  end when;
</td>
</table>
</ul>
</p>
<p>
<h5>Selected variables used in above equations</h5>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>flange_a.s</TD><TD VALIGN=\"TOP\">Output variable of the used PartialTwoFlanges block.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>deltaf</TD><TD VALIGN=\"TOP\">Differenz between output variables of the used PartialTwoFlanges block.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>lowlim</TD><TD VALIGN=\"TOP\">Constant real parameter representing the lower hard stop</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>uplim</TD><TD VALIGN=\"TOP\">Constant real parameter representing the upper hard stop</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>m</TD><TD VALIGN=\"TOP\">Parameter mass </TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>acce</TD><TD VALIGN=\"TOP\">Internal variable representing the acceleration</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>vel</TD><TD VALIGN=\"TOP\">Internal variable representing the velocity</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>g</TD><TD VALIGN=\"TOP\">Parameter gravity which act on the mass</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>stosszahl</TD><TD VALIGN=\"TOP\">Internal variable representing the behavior of the impact. Calculated by the parameter <i>damping constant</i>. </TD></TR>
</TABLE>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end MassEndstop;
      model MassFriction
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Force Fh = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.Force Fc = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter SI.Mass m = 1 "mass";
        parameter SI.Acceleration g = 0 "gravity";
        parameter Real vis = 0 "viscous friction value in Ns/mm " annotation(Dialog(group = "Friction"));
        parameter SI.Velocity vh(min = 0.00000000001) = 0.000001 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter Boolean initialize_s = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_v = true annotation(Dialog(group = "Initialization"));
        parameter SI.Position s_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity v_init = 0 annotation(Dialog(group = "Initialization"));
        SI.Force F_stribeck;
        SI.Force Ffric "total friction";
        SI.Position s;
        SI.Velocity v "velocity";
        SI.Acceleration a "acceleration";
        SI.Force deltaf;
        Boolean None = if Fh == 0 and Fc == 0 then true else false;
        Boolean Stick(start = false, fixed = true);
        Boolean StartSlip(start = false, fixed = true);
        Boolean Slip(start = true, fixed = true);
      protected
        parameter Real stribeckFactor = Utilities.stribeckFunction(sticktionForce, vis, vh);
        constant SI.Velocity velLimit = 0.0000005;
        parameter SI.Force sticktionForce = Fh - Fc;
      initial equation
        if initialize_s then
          s = s_init;
        end if;
        if initialize_v then
          v = v_init;
        end if;
        assert(m > 0, "Negative mass is not allowed");
        assert(Fh > Fc, "The Static friction/Haftreibung should be larger than the Running friction/Coulomb?sche reibung!");
      equation
        Slip = initial() and abs(v) > velLimit or pre(StartSlip) and abs(v) > velLimit or pre(Slip) and abs(v) > velLimit;
        StartSlip = pre(Stick) and deltaf > Fh or pre(StartSlip) and not (v > velLimit or a <= 0 and not v > 0);
        Stick = initial() and abs(v) < velLimit or abs(v) < velLimit / 5 and not (Slip or StartSlip);
        F_stribeck = Fc * sign(v) + vis * v + sticktionForce * exp(-stribeckFactor * abs(v)) * sign(v);
        a = if Stick then 0 else (deltaf + m * g) / m;
        when Stick and not initial() then
                  reinit(v, 0);
        
        end when;
        Ffric = if Slip and v > 0 then Fc else if Slip and v < 0 then -Fc else if StartSlip then F_stribeck else 0;
        deltaf = flange_a.f - flange_b.f - Ffric;
        s = flange_a.s;
        v = der(flange_a.s);
        a = der(v);
        flange_a.s = flange_b.s;
        annotation(Icon(graphics = {Polygon(points = {{-100,-60},{-80,-50},{-80,-60},{-60,-50},{-60,-60},{-40,-50},{-40,-60},{-20,-50},{-20,-60},{0,-50},{0,-60},{20,-50},{20,-60},{40,-50},{40,-60},{60,-50},{60,-50},{60,-60},{80,-50},{80,-60},{-100,-60}}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Polygon(points = {{80,-60},{100,-50},{100,-60},{100,-80},{-100,-80},{-100,-60},{80,-60}}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-60,20},{60,-40}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-50,16},{48,-26}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "m"),Line(points = {{-100,-60},{80,-60}}, color = {135,135,135}, smooth = Smooth.None)}), DymolaStoredErrors, Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<P>
This element describes the <i>Stribeck friction characteristics</i> of a sliding mass,
i. e. the frictional force acting between the sliding mass and the fixed surface 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of a mass to which a frction acts.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>The component simulates the linear friction in the sense of the Stribeck friction. This is composed of the following three frictions:</li>
  <ul>
  <li> the constant Coulomb friction,</li> 
  <li> the speed-proportional viscous friction ,</li> 
  <li> the Stribeck friction (describes the transition from static friction to sliding friction).</li> 
  </ul>
<li>The resulting overall friction force is the sum of the three components</i>  
<li>Input signals need to be a translatorical connecter which transers the postion <i>s</i> and the force <i>f</i>.</li>
<li>The parameter <i>vh</i> describes the transitional velocity.</li>
<li>The parameter <i>vis</i> describes the viscous friction value.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>

<p>
<ul>
<li>The parameter <i>static friction</i> must be smaller then the <i>sliding friction</i>.</li>
<li>The parameter <i>mass</i> must be greater zero.</li>
<li>The mass is idealized as a point mass, it doesnt have any expansion.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The following picture shows the components of the resulting overall friction force in the sense of the Stribeck friction.
</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <IMG src=\"modelica://Modelica/Resources/Images/Translational/Stribeck.png\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Stribeck charactaristic</caption>
</table> 
</p>
<p>
The behaviour of the model can be clarified by means of a state diagram with the three states <i>Stick</i>, <i>StartSlip</i> and <i>Slip</i>
(see figure 2). 

</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:\10_ETI22\__Kollegen\_SvenB?tzing\DC_Mechlib\images\statesfriction.jpg\" width=\"800\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>state diagram of the friction model</caption>
</table> 
</p>
<p>
Depending on the state the frictionforce is calculated in the equation section as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  Ffric = if Slip and v > 0 then Fc else if Slip and v &lt; 0 then -Fc else if StartSlip then F_stribeck else 0;
</td>
</table>
</ul>
</p>
<p>The dynamic behavior is set by the following equations:</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  deltaf = flange_a.f - flange_b.f - Ffric;<br>
  s = flange_a.s;<br>
  v = der(flange_a.s);<br>
  a = der(v);<br>
  flange_a.s = flange_b.s;<br>
</td>
</table>
</ul>
</p>


<p>
<h5>Selected variables used in above equations</h5>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Fc</TD><TD VALIGN=\"TOP\">Real parameter representing the sliding friction.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Ffric</TD><TD VALIGN=\"TOP\">Real variable representing the total friction force.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>deltaf</TD><TD VALIGN=\"TOP\">Real variable representing the sum of all incoming forces</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>F_stribeck</TD><TD VALIGN=\"TOP\">Real variable representing the force resulting out of the stribeck factor.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>m</TD><TD VALIGN=\"TOP\">Parameter mass </TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>acce</TD><TD VALIGN=\"TOP\">Internal variable representing the acceleration</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>v</TD><TD VALIGN=\"TOP\">Internal variable representing the velocity</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>flange_a.s</TD><TD VALIGN=\"TOP\">Output variable of the used PartialTwoFlanges block.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>flange_a.b</TD><TD VALIGN=\"TOP\">Output variable of the used PartialTwoFlanges block.</TD></TR>
</TABLE>
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Mass, friction</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>MassWithStopAndFriction</p></td>
<td><p>Stop is included aswell</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<b><u>10.1 Testcase 1: MassFriction with timetable-force-input signal (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the mass is correct for a variable-shaped continous inputforce.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a massFriction block, a force block and a timetable block (the latter two taken from the MSL).
The output of the timetable blocks is connected with the input of the force block, while the force block output is connected 
with the massFriction input.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p> 
<u>timetable</u>:<br>
table=[0, 50; 0.1, 0; 1, 0]<br>
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massFriction: flange_a  <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start with 0 and raise steeply while a force is acting. Then the mass is decelerated by the friction force, which acts in the opposed direction of the movement. 
Once the velocity is smaller then a defined limit and all external forces are smaller then the static force, the mass stops.<br><br>
</p>

<b><u>10.2 Testcase 2: MassFriction with initial velocity (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the mass with initial velocity is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains only a massFriction block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p> 
<u>massFriction</u>:<br>
v0 = 2<br>
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massFriction: flange_a  <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start with 0 and start velocity of 2 (v0 = 2). The velocity of the mass is decelerated by the friction force, which acts in the opposed direction of the movement. 
Once the velocity is smaller then a defined limit and all external forces are smaller then the static force (no external forces in this case), the mass stops.
</p>

<h4>11. Implementation details</h4>
In the implementation are no particularities.

<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end MassFriction;
      model MassVariable
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Acceleration g = -9.81 "gravitation";
        parameter Boolean initialize_s = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_v = true annotation(Dialog(group = "Initialization"));
        parameter SI.Position s_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity v_init = 0 annotation(Dialog(group = "Initialization"));
        SI.Position s;
        SI.Velocity v;
        SI.Acceleration a;
        Modelica.Blocks.Interfaces.RealInput m(unit = "kg") annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {0,106})));
      initial equation
        if initialize_s then
          s = s_init;
        end if;
        if initialize_v then
          v = v_init;
        end if;
      equation
        if m < 0 then
          Modelica.Utilities.Streams.error("Negativ mass is not allowed!");
        end if;
        v = der(s);
        a = der(v);
        m * a = m * g + flange_a.f + flange_b.f;
        flange_a.s = s;
        flange_b.s = s;
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-60,20},{60,-40}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-50,16},{48,-26}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "m")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component represents a mass with a translational degree of freedom. The value of the mass is a real input. 
Sign convention: A positive force at flange_a moves the mass in the positive direction. A negative force at flange_a moves the mass to the negative direction. 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of a variable mass.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>Using the <i>gravitation parameter</i>, the weight force of the mass can be set whereas positive gravitation corresponds to acceleration in positive direction.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The value of the real input signal <i>m</i> must be greater zero.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
v = der(s);<br>
a = der(v);<br>
m * a = m * g + flange_a.f + flange_b.f;<br>
s = flange_b.s;<br>
flange_b.s = flange_a.s;
</td>
</table>
</ul>
</p>



<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Mass, addidional</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Mass</p></td>
<td><p>Model from the MSL (Include expansion aswell; mass is parameter)</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Variable mass with constant force</u></b>
</p>
<p>
This testcase checks if the movenment of the changing mass is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a ForceConstant-, a step- and a MassVaraible-block. The positive flange of the force is connected with flange_a of the mass.
The negative force acts on the clamp. The stepblock forms the weight of the mass.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>MassVariable</u>:<br>
g = 0<br>
<u>ForceConstant</u>:<br>
F = 5 N<br>
<u>step</u>:<br>
height = 9 <br>
offset = 1<br>
startTime = 0.5 s<br>
 

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
MassVariable: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 0 and adept an acceleration of 5 m/s^2. After the step at 0.5 the mass gets ten times heavier, so the accelertion should jump to a tenth part.
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end MassVariable;
      model MassFrictionEndstop
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Mass m = 1 "mass";
        parameter SI.Acceleration g = 0;
        parameter SI.Force Fh = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.Force Fc = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter Real vis = 0 "viscous friction value" annotation(Dialog(group = "Friction"));
        parameter SI.Velocity vh(min = 0.00000000001) = 0.000001 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter SI.Position lowlim = -0.5 "Lower Limit of endstop" annotation(Dialog(group = "Hard stop"));
        parameter SI.Position uplim = 0.5 "Upper limit of endstop" annotation(Dialog(group = "Hard stop"));
        parameter Real restitutionCoefficient(min = 5, max = 100) = 5 "damping endstop in percentage" annotation(Dialog(group = "Hard stop"));
        parameter Boolean initialize_s = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_v = true annotation(Dialog(group = "Initialization"));
        parameter SI.Position s_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity v_init = 0 annotation(Dialog(group = "Initialization"));
        SI.Position pos;
        SI.Velocity v(stateSelect = StateSelect.always);
        SI.Acceleration acce;
        SI.Force deltaf;
        SI.Force Ffric "total friction";
        SI.Force F_stribeck;
        parameter Real stribeckFactor = Utilities.stribeckFunction(sticktionForce, vis, vh);
        constant SI.Velocity velLimit = 0.0000005;
        parameter SI.Force sticktionForce = Fh - Fc;
        SI.Velocity vReachContact = 0.00001;
        SI.Velocity vLeaveContact = 0.00005;
        Real stosszahl = 1 - restitutionCoefficient / 100;
        Boolean Contact_up(start = false, fixed = true);
        Boolean Contact_down(start = false, fixed = true);
        Boolean Free(start = true, fixed = true);
        Boolean Stiction(start = false, fixed = true);
        //Boolean StartForw;
        //Boolean Forward;
        //Boolean StartBack;
        //Boolean Backward;
        Boolean Slip(start = true, fixed = true);
        Boolean StartSlip(start = false, fixed = true);
      initial equation
        if initialize_s then
          pos = s_init;
        end if;
        if initialize_v then
          v = v_init;
        end if;
      initial algorithm
        assert(uplim > lowlim, "The upper limit must be grater then the lower limit.");
        assert(pos <= uplim, "The initial position must be smaller than or equal to the upper limit.");
        assert(pos >= lowlim, "The initial position must be greater than or equal to the lower limit.");
        assert(m > 0, "Negative mass is not allowed");
      algorithm
        when (Contact_up or Contact_down) and not initial() and not Stiction then
                  reinit(v, -stosszahl * v);        
        end when;
        when Stiction and not initial() and not (Contact_up or Contact_down) then
                  reinit(v, 0);        
        end when;
      equation
        //        States        //
        Slip = initial() and abs(v) > velLimit or pre(StartSlip) and abs(v) > velLimit or pre(Slip) and abs(v) > velLimit;
        StartSlip = pre(Stiction) and deltaf > Fh or pre(StartSlip) and not (v > velLimit or acce <= 0 and not v > 0);
        Stiction = not (Slip or StartSlip);
        Contact_up = initial() and flange_a.s >= uplim or pre(Free) and flange_a.s > uplim and v > vReachContact;
        Contact_down = initial() and flange_a.s <= lowlim or pre(Free) and lowlim > flange_a.s and -v > vReachContact;
        Free = initial() or pre(Contact_up) and (abs(v) > vLeaveContact or deltaf < 0) or pre(Contact_down) and (abs(v) > vLeaveContact or deltaf > 0) or pre(Free) and flange_a.s < uplim or flange_a.s > lowlim;
        //                      //
        acce = if Contact_up then g else if Contact_down then 0 else (deltaf + m * g) / m;
        F_stribeck = Fc * sign(v) + vis * v + sticktionForce * exp(-stribeckFactor * abs(v)) * sign(v);
        Ffric = if Slip and v > 0 then Fc else if Slip and v < 0 then -Fc else if StartSlip then F_stribeck else 0;
        deltaf = flange_a.f - flange_b.f - Ffric;
        pos = flange_a.s;
        v = der(flange_a.s);
        acce = der(v);
        flange_a.s = flange_b.s;
        annotation(Placement(transformation(extent = {{-46,-10},{-26,10}})), Diagram(graphics), Icon(graphics = {Polygon(points = {{-100,-60},{-80,-50},{-80,-60},{-60,-50},{-60,-60},{-40,-50},{-40,-60},{-20,-50},{-20,-60},{0,-50},{0,-60},{20,-50},{20,-60},{40,-50},{40,-60},{60,-50},{60,-50},{60,-60},{80,-50},{80,-60},{-100,-60}}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Polygon(points = {{80,-60},{100,-50},{100,-60},{100,-80},{-100,-80},{-100,-60},{80,-60}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}, lineThickness = 1),Rectangle(extent = {{-80,0},{-100,-68}}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, pattern = LinePattern.None),Rectangle(extent = {{100,0},{80,-68}}, pattern = LinePattern.None, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-60,20},{60,-40}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-50,16},{48,-26}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "m"),Line(points = {{-80,-60},{-80,0},{-90,0}}, pattern = LinePattern.None, smooth = Smooth.None),Line(points = {{-100,-80},{100,-80}}, pattern = LinePattern.None, smooth = Smooth.None),Line(points = {{80,-50},{80,0},{90,0}}, pattern = LinePattern.None, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<P>
This element describes the <i>Stribeck friction characteristics</i> of a sliding mass between two defined contact,
The mass have a translational degree of freedom. 
Sign convention: A positive force at flange_a moves the sliding mass in the positive direction. A negative force at flange_a moves the sliding mass to the negative direction. 
The model is a combination of the componets <i>massEndstop</i> and <i>massFriction<i/>.

</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of a mass with frction inside a defined range .
</p>

<h4>3. Features</h4>
<p> For all features, options, limits, and equations see the documentations of the used components <i>massEndstop</i> and <i>massFriction<i/>.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Mass, friction, hard stop</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>MassWithStopAndFriction</p></td>
<td><p>optional heatport</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: MassFrictionEndstop with initial position and initial velocity (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the mass with initial position and initial velocity is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel only contains massFrictionEndstop block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>massFrictionEndstop</u>:<br>
 restitutionCoefficient = 70<br>
 gravity = 0<br>
 initialize = true<br> 
 s0 = 0.5<br>
 v0 = -5 <br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massFrictionEndstop: flange_a  <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start with 0.5 (s0 = 0.5) and a start velocity of 10 (v0 = 10). <s>s</s> descreases until it reachs the lower limit, there the velocity have to chance direction.
After the bounce the velocity of the mass get to small through the friction and the element stops at a certain point.
</p>
<p>
<b><u>10.2 Testcase 2: MassFrictionEndstop with pulse-force-input signal (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the mass is correct for a pulse-shaped continous inputforce.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a massFrictionEndstop block, a force block and a pulse block (the latter two taken from the MSL).
The output of the pulse blocks is connected with the input of the force block, while the force block output is connected 
with the massFrictionEndstop input.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>

<u>pulse</u>:<br>
amplitude = 50<br> 
period = 1<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 2s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massFrictionEndstop: flange_a  <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start with 0 and raise to the upper limit. Then the mass should be bounced to other direction, then it get moved again to the upper limit, because the pulse-shaped force still acts
When the pulse block dont create any force the velocity gets deccelerated by the friction. When the new period of the pulse function begin, the movenment will repeat in a similar way.
</p>

<h4>11. Implementation details</h4>
<P> 
For details see the documentations of the used components.
</p>

<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>


</HTML>"));
      end MassFrictionEndstop;
      model Position "Transform a Signal to a Position"
        import SI = Modelica.SIunits;
        import T = Modelica.Mechanics.Translational;
        parameter Boolean initialize_v = false annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity v_init = 0 annotation(Dialog(group = "Initialization"));
        T.Sources.Position position(v(start = if initialize_v then v_init else 0), exact = if initialize_v then false else true, f_crit = 10000) annotation(Placement(visible = true, transformation(origin = {0,0}, extent = {{-13,-13},{13,13}}, rotation = 0)));
        parameter String unit = "mm" annotation(choices(choice = "mm", choice = "m", choice = "cm", choice = "dm", choice = "ft", choice = "in", choice = "yd"));
        T.Interfaces.Flange_b flange "Flange of component" annotation(Placement(transformation(extent = {{90,-10},{110,10}}, rotation = 0)));
        Modelica.Blocks.Interfaces.RealInput s_ref "Reference position of flange as input signal" annotation(Placement(transformation(extent = {{-126,-20},{-86,20}}, rotation = 0), iconTransformation(extent = {{-126,-20},{-86,20}})));
      equation
        if unit == "mm" then
          position.s_ref = s_ref / 1000;
        elseif unit == "m" then
          position.s_ref = s_ref;
        elseif unit == "cm" then
          position.s_ref = s_ref / 100;
        elseif unit == "dm" then
          position.s_ref = s_ref / 10;
        elseif unit == "ft" then
          position.s_ref = s_ref / 3.2808399;
        elseif unit == "in" then
          position.s_ref = s_ref / 39.370079;
        elseif unit == "yd" then
          position.s_ref = s_ref / 1.0936133;
        else
          position.s_ref = s_ref;
        end if;
        connect(position.flange,flange) annotation(Line(points = {{13,0},{100,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-50,70},{50,-70}}, lineColor = {0,0,0}),Text(extent = {{-42,46},{40,-46}}, lineColor = {0,0,0}, textString = "S", textStyle = {TextStyle.Bold})}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This block supplies a position corresponding to the signal input
</p>

<h4>2. Application area</h4>
<p>
Common position specification.
</p>

<h4>3. Features</h4>
<p>
Using the <i>unit</i> parameter, the unit of the specified signal can be set. By setting the parameter <i> initialize_v<i> u can decide about a start velocity

</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The behavior is defined by the equation:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 position.s_ref = s_ref;
</td>
</table>
</ul>
</p>
<p>
Note: No exact position values at start, if initial velocity is given.
</p>
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Position</i>. 
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Position</p></td>
<td><p>Model from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Position allegation</u></b>
</p>
<p>
This testcase checks if the movenment of a mass with a position allegation is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Ramp-, a Position-block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>ramp</u>:<br>
duration = 1<br>
<u>Position</u>:<br>
initialize_v = true <br>
v_init = -2 m/s <br>
unit = &quot;m&quot;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 0.1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Position: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 0 and a velocity of -2. It should raise in the same way the reference increases.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"), experiment(Interval = 0.001), __Dymola_experimentSetupOutput);
      end Position;
      model PressureSpring
        import SI = Modelica.SIunits;
        parameter SI.TranslationalSpringConstant c = 100 "spring constant";
        parameter SI.TranslationalSpringConstant c2 = 1000 "spring constant";
        parameter SI.TranslationalDampingConstant d = 1 "damping constant";
        parameter SI.Force Fstart = 0 "Preload";
        parameter SI.Length LB = 0.5 "block lenght";
        parameter Real n = 1 "exponent of force calculation";
        SI.Length s "actual length";
        SI.Length x "spring expansion";
        SI.Velocity v "spring velocity";
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        SI.Length L0 "unstreched length";
      equation
        when initial() then
                  L0 = Fstart / c + flange_b.s - flange_a.s;
        
        end when;
        s = flange_b.s - flange_a.s;
        v = der(s);
        x = s - L0;
        flange_a.f = -flange_b.f;
        if s >= L0 then
          flange_b.f = 0;
        elseif s >= LB and s < L0 then
          flange_b.f = -(-c * x + d * v);
        else
          flange_b.f = -(c * (L0 - LB) + c2 * (LB - s) ^ n);
        end if;
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-40,50},{-60,50},{-60,-50},{-48,-50},{-48,-42}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-48,-38},{8,-64}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{8,-38},{16,-38}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-64},{16,-64}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-52},{60,-52},{60,50},{40,50}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{40,50},{36,30},{26,70},{16,30},{6,70},{-4,30},{-14,70},{-24,30},{-34,70}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,70},{-40,50}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component models a spring with a given preload
</p>

<h4>2. Application area</h4>
<p>
Use this model to calculate the resulting spring force.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>Use the <i> Preload </i> parameter to simulate a bias</li>
<li> Only when the spring gets compressed, a force is established. </li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
If the actual length of the spring is less than their block length, the stiffness increased by multiples.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
The spring is unstretched when its current length (s) is greater than the free length (L0).

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
s = flange_b.s - flange_a.s;
v = der(s);
x = s - L0;
flange_a.f = - flange_b.f;
</td>
</table>
</ul>
</p>
<p>
Depending on the position and the value of the L0 the springforce is calculated in the equation part as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 if (s >= L0) then<br>
     flange_b.f = 0;<br>
 elseif (s >= LB) and (s %lt; L0) then<br>
     flange_b.f = - c * x + d * v;<br>
 else<br>
     flange_b.f = c * (L0 - LB) + c2 * (LB - s)^n;<br>
 end if;<br>
</td>
</table>
</ul>
</p>
<p>
The relationship is evident in Figure 1:
</p>

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/pressureSpring.jpg\" width=\"600\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Parameter of PressureSpring-block</caption>
</table> 
</p>

<h4>7. Model validation</h4>
<p>
No validation yet.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Clamped PresureSpring connected with a mass</u></b>
</p>
<p>
This testcase checks if the movenment of the mass is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a clamp-, a PressureSpring- and a mass-block. The flange_a of the spring is connected with the clamp and the other flange is connected with the mass.
The mass starts with a veocity of -1 m/s.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>mass</u>:<br>
g = 0;<br>
initialize_s = true;<br>
initialize_v = true;<br>
s_init = 1 m;<br>
v_init = -1 m/s<br>
<u>mass</u>:<br>
n = 3;<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1.5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
mass: flange_a <i>s</i>
      flange_a <i>f</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at the initial position of 0 m and a start velocity of -1 m/s. The mass should compress the spring, this cause a force against the movement of the mass.
The acting force should raise with the compression and change the direction of the movement. As soon the actual position is greater then the initial position the springforce will be zero.
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>

<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Further implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end PressureSpring;
      model RackandPin "linear to rotatory"
        import SI = Modelica.SIunits;
        parameter SI.Length Radius = 0.5 "Gearwheel radius";
        Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel(radius = Radius) annotation(Placement(transformation(extent = {{10,-10},{-10,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_T annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_R annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
      equation
        connect(idealRollingWheel.flangeR,flange_R) annotation(Line(points = {{10,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(idealRollingWheel.flangeT,flange_T) annotation(Line(points = {{-10,0},{-100,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{60,-60},{-60,60}}, lineColor = {0,0,0}),Ellipse(extent = {{-8,8},{8,-8}}, lineColor = {0,0,0}, fillPattern = FillPattern.Solid, fillColor = {135,135,135}),Rectangle(extent = {{-80,-60},{80,-70}}, lineColor = {0,0,0}),Line(points = {{-86,-72},{88,-72}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-80,-72},{-88,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{80,-72},{72,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{60,-72},{52,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{40,-72},{32,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{20,-72},{12,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{0,-72},{-8,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-20,-72},{-28,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-40,-72},{-48,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-60,-72},{-68,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-20,-20},{20,-20}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{0,-8},{-8,-20},{-16,-28}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{0,-8},{8,-20},{0,-28}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component simulates a rack and pinion gear. 

</p>

<h4>2. Application area</h4>
<p>
Use this component to convert linear movements into angular movements.
</p>

<h4>3. Features</h4>
<p>
By defining the Gearwheel radius, its possible to set the propotion between linear and angular movements.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The model is taken from the MSL.
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Rack and Pinion</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>IdealRollingWheel</p></td>
<td><p>Component from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Transform a given linear movement into a rotational.</u></b>
</p>
<p>
This testcase checks if the movenment is transformed correctly.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Ramp-, a Position- and a RackandPin-Block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>ramp</u>:<br>
duration = 1<br>
<u>Position</u>:<br>
unit = &quot;m&quot;<br>
<u>RackandPin</u>:<br>
Radius = 0.1 m;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 0.1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
RackandPin: flange_T <i>s</i>
RackandPin: flange_R <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> and <i>phi</i> should start at 0 and raise straightly. <i>s</i> should reach 1 <i>m</i> and phi should reach 10 <i>rad</i>, with the choosen parameters.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end RackandPin;
      model Rope
        import SI = Modelica.SIunits;
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        parameter SI.Length L0 = 1 "Anfangsl?nge";
        parameter SI.Diameter D = 0.01 "Durchmesser";
        parameter SI.TranslationalDampingConstant d = 0 "D?mpfung";
        parameter SI.ModulusOfElasticity E = 20000000;
        parameter Real fill = 1 "fillfactor";
        SI.TranslationalSpringConstant c;
        SI.Area A;
        SI.Length L;
        //SI.Length Lcur;
        SI.Velocity v1;
        SI.Velocity v2;
      protected
        Real pi = Modelica.Constants.pi;
      equation
        //Lcur = flange_b.s - flange_a.s;
        L = abs(flange_b.s - flange_a.s);
        flange_b.f = -flange_a.f;
        A = pi * (D / 2) ^ 2 * fill;
        c = E * A / L;
        v1 = der(flange_a.s);
        v2 = der(flange_b.s);
        if L < L0 then
          flange_a.f = 0;
        else
          flange_a.f = c * (L - L0) + d * (v2 - v1);
        end if;
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-100,78},{-100,76}}, lineColor = {0,0,255}),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Polygon(points = {{-60,40},{-58,44},{-56,46},{-52,48},{-48,48},{-44,46},{-42,44},{-40,40},{-60,-40},{-62,-44},{-64,-46},{-68,-48},{-72,-48},{-76,-46},{-78,-44},{-80,-40},{-60,40}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{-40,40},{-38,44},{-36,46},{-32,48},{-28,48},{-24,46},{-22,44},{-20,40},{-40,-40},{-42,-44},{-44,-46},{-48,-48},{-52,-48},{-56,-46},{-58,-44},{-60,-40},{-40,40}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{40,40},{42,44},{44,46},{48,48},{52,48},{56,46},{58,44},{60,40},{40,-40},{38,-44},{36,-46},{32,-48},{28,-48},{24,-46},{22,-44},{20,-40},{40,40}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{20,40},{22,44},{24,46},{28,48},{32,48},{36,46},{38,44},{40,40},{20,-40},{18,-44},{16,-46},{12,-48},{8,-48},{4,-46},{2,-44},{0,-40},{20,40}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{0,40},{2,44},{4,46},{8,48},{12,48},{16,46},{18,44},{20,40},{0,-40},{-2,-44},{-4,-46},{-8,-48},{-12,-48},{-16,-46},{-18,-44},{-20,-40},{0,40}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{-20,40},{-18,44},{-16,46},{-12,48},{-8,48},{-4,46},{-2,44},{0,40},{-20,-40},{-22,-44},{-24,-46},{-28,-48},{-32,-48},{-36,-46},{-38,-44},{-40,-40},{-20,40}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{60,40},{62,44},{64,46},{68,48},{72,48},{76,46},{78,44},{80,40},{60,-40},{58,-44},{56,-46},{52,-48},{48,-48},{44,-46},{42,-44},{40,-40},{60,40}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {215,215,215}, fillPattern = FillPattern.Solid),Polygon(points = {{-60,82},{-60,78},{50,78},{50,70},{60,80},{50,90},{50,82},{-60,82}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component simulates a rope with a given length.
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate a rope
</p>

<h4>3. Features</h4>
<p>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
L = abs(flange_b.s - flange_a.s);<br>
flange_b.f = -flange_a.f;<br>
A = pi * (diameter / 2) ^ 2 * fillf;<br>
c = ModulusE * A /L;<br>
v1 = der(flange_a.s);<br>
v2 = der(flange_b.s);<br>
</td>
</table>
</ul>
</p>
<p>
If the rope is untensioned, i.e. its current length is less than the initial length, no force is generated. Otherwise, the rope behaves like a spring. 
This behavior gives the following equations
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
if L &lt;= l0 then
    flange_a.f = 0;
else
    flange_a.f = c * (L - l0) + d * (v2 - v1);
</td>
</table>
</ul>
</p>



<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Cable</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Falling mass fixed at a rope</u></b>
</p>
<p>
This testcase checks if the movenment of a falling mass attached at a rope is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a clamp-, a rope- and a mass-block. The clap fixes the flange_a of the rope, at the flange_b of the rope the mass is connected.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>

<u>mass</u>:<br>
initialize_s = true;<br>
initialize_v = true;<br>
s_init = 0.5 m;<br>
v_init = 0 m/s<br>
 

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
mass: flange_a <i>s</i><br>
      flange_a <i>f</i><br>
  
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at the initial position of 0.5 m and a start velocity of 0 m/s. The gravitation causes a weight force, which acts in the negative direction.
The rope doesnt act any force until the mass reachs - 1m. The rope is fully taut and expand because of the mass. A positive force should result from the expandation.
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>

<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Further implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Rope;
      model SpringDamper
        import SI = Modelica.SIunits;
        parameter SI.TranslationalSpringConstant c = 100 "spring-constant";
        parameter SI.TranslationalDampingConstant d = 1 "dampingconstant";
        parameter SI.Force Fstart = 0 "Preload";
        parameter SI.Length idl_str = 0.1 "Idle stroke";
        SI.Length s "actual lenght";
        SI.Length x "spring expansion";
        SI.Velocity v "spring velocity";
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        SI.Length L0 "unstreched lenght";
      equation
        when initial() then
                  L0 = flange_b.s - flange_a.s - Fstart / c;
        
        end when;
        s = flange_b.s - flange_a.s;
        v = der(s);
        x = s - L0;
        flange_a.f = -flange_b.f;
        if abs(x) > abs(idl_str) then
          flange_b.f = sign(x) * c * (abs(x) - abs(idl_str)) + d * v;
        else
          flange_b.f = 0;
        end if;
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-40,50},{-60,50},{-60,-50},{-48,-50},{-48,-42}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-48,-38},{8,-64}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{8,-38},{16,-38}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-64},{16,-64}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-52},{60,-52},{60,50},{40,50}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{40,50},{36,30},{26,70},{16,30},{6,70},{-4,30},{-14,70},{-24,30},{-34,70}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,70},{-40,50}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component represents a linear spring-damper characteristics.
</p>

<h4>2. Application area</h4>
<p>
Use this model to calculate the resulting spring force.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>Use the <i> Preload </i> parameter to simulate a bias</li>
<li> Inside the idle stroke no force results from the spring </li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
The idle stroke is the range the component can be deformed without building up any force. In order to simulate extension and compression springs, the idle stroke is on both sides of the unstretched length. If the spring has an unstretched length of 20mm and an idle stroke of 1mm, no force is created in the range of 19 to 21mm. Before simulation starts the unstreched length is calculated by the formula l0 = F0 / c.
The result size spring length is the distance between the two couplings and indicates the actual spring length.
The spring excursion indicates the length the spring is compressed or extended. If the spring is extended 5mm, the spring must be compressed 5mm to be unstreched.
Note: The spring is unstretched in the idle stroke range and the spring excursion is zero.

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
s = flange_b.s - flange_a.s;<br>
   v = der(s);<br>
   x = s - L0;<br>
   flange_a.f = - flange_b.f;<br>
</td>
</table>
</ul>
</p>
<p>
Depending on the position and the value of the idle stroke the springforce is calculated in the equation part as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 if abs(x) > abs(idl_str) then<br>
     flange_b.f = sign(x)* c * (abs(x) - abs(idl_str)) + d * v;<br>
 else<br>
     flange_b.f = 0;<br>
</td>
</table>
</ul>
</p>
<p>
The relationship is evident in Figure 1:
</p>

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/springparameter.jpg\" width=\"400\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Parameter of SpringDamper-block</caption>
</table> 
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Spring-Damper, linear</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>SpringDamper</p></td>
<td><p>Model from the MSL (Parameter, srel0 instead of idlestroke and preload force)</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Clamped SpringDamper connected with a mass</u></b>
</p>
<p>
This testcase checks if the movenment of the damped mass is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a clamp-, a SpringDamper- and a mass-block. The flange_a of the spring is connected with the clamp and the other flange is connected with the mass.
The mass starts with a veocity of 5 m/s.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>mass</u>:<br>
g = 0;<br>
initialize_s = true;<br>
initialize_v = true;<br>
s_init = 0 m;<br>
v_init = 5 m/s<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
mass: flange_a <i>s</i>
      flange_a <i>f</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at the initial position of 0 m and a start velocity of 5 m/s. The springforce should be zero until the mass-position is lower then the idle stroke.
The acting force should raise with the position and force the mass to turn the direction of the movement. This proccess should repeat with a lower amplitude (depending on the damping constant).
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Further implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end SpringDamper;
      model SpringDamperKomplex
        import SI = Modelica.SIunits;
        parameter SI.TranslationalSpringConstant c = 100 "spring-constant";
        parameter SI.TranslationalDampingConstant d = 1 "dampingconstant";
        parameter SI.Length L0 = 0.5 "unstreched lenght";
        parameter SI.Length idl_str = 0.01 "Idle stroke";
        SI.Length s "actual lenght";
        SI.Length x "spring expansion";
        SI.Velocity v "spring velocity";
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        SI.Force F0 "Preload";
      equation
        when initial() then
                  F0 = c * (flange_b.s - flange_a.s - L0);
        
        end when;
        s = flange_b.s - flange_a.s;
        v = der(s);
        x = s - L0;
        flange_a.f = -flange_b.f;
        if abs(x) > abs(idl_str) then
          flange_b.f = sign(x) * c * (abs(x) - abs(idl_str)) + d * v;
        else
          flange_b.f = 0;
        end if;
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-40,50},{-60,50},{-60,-50},{-48,-50},{-48,-42}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-48,-38},{8,-64}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{8,-38},{16,-38}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-64},{16,-64}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-52},{60,-52},{60,50},{40,50}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{40,50},{36,30},{26,70},{16,30},{6,70},{-4,30},{-14,70},{-24,30},{-34,70}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,70},{-40,50}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component represents a linear spring-damper characteristics.
</p>

<h4>2. Application area</h4>
<p>
Use this model to calculate the resulting spring force with a given unstreched length.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>A Preload gets calculated through the given unstreched length</li>
<li> Inside the idle stroke the spring can be movend without any force</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
The idle stroke is the range the component can be deformed without building up any force. In order to simulate extension and compression springs, the idle stroke is on both sides of the unstretched length. If the spring has an unstretched length of 20mm and an idle stroke of 1mm, no force is created in the range of 19 to 21mm. Before simulation starts the unstreched length is calculated by the formula l0 = F0 / c.
The result size spring length is the distance between the two couplings and indicates the actual spring length.
The spring excursion indicates the length the spring is compressed or extended. If the spring is extended 5mm, the spring must be compressed 5mm to be unstreched.
Note: The spring is unstretched in the idle stroke range and the spring excursion is zero.

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
s = flange_b.s - flange_a.s;<br>
   v = der(s);<br>
   x = s - L0;<br>
   flange_a.f = - flange_b.f;<br>
</td>
</table>
</ul>
</p>
<p>
Depending on the position and the value of the idle stroke the springforce is calculated in the equation part as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 if abs(x) > abs(idl_str) then<br>
     flange_b.f = sign(x)* c * (abs(x) - abs(idl_str)) + d * v;<br>
 else<br>
     flange_b.f = 0;<br>
</td>
</table>
</ul>
</p>
<p>
The relationship is evident in Figure 1:
</p>

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/springkomplexparameter.jpg\" width=\"400\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Parameter of SpringDamper-block</caption>
</table> 
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Spring-Damper, linear, komplex</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>SpringDamper</p></td>
<td><p>Model from the MSL (Parameter, srel0 instead of idlestroke and unstreched length)</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Clamped SpringDamperkomplex connected with a mass</u></b>
</p>
<p>
This testcase checks if the movenment of the damped mass is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a clamp-, a SpringDamperKomplex- and a mass-block. The flange_a of the spring is connected with the clamp and the other flange is connected with the mass.
The mass starts with a veocity of 5 m/s.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>mass</u>:<br>
g = 0;<br>
initialize_s = true;<br>
initialize_v = true;<br>
s_init = 0 m;<br>
v_init = 5 m/s<br>
<u>SpringDamperKomplex</u>:<br>
L0 = 0.05 m <br>
idl_str = 0.005 m <br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
mass: flange_a <i>s</i>
      flange_a <i>f</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at the initial position of 0 m and a start velocity of 5 m/s. The springforce should be zero until the mass-position is lower then the idle stroke.
The acting force should raise with the position and force the mass to turn the direction of the movement. This proccess should repeat with a lower amplitude (depending on the damping constant).
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>

<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Further implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end SpringDamperKomplex;
      model TwoMassFriction
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Mass mA = 1 "mass body A";
        parameter SI.Mass mB = 1 "mass body 1";
        parameter SI.Force Fh = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.Force Fc = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter Real vis(unit = "N.s/m") = 0 "viscous friction value" annotation(Dialog(group = "Friction"));
        parameter SI.Velocity vh(min = 0.00000000001) = 0.000001 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter SI.Acceleration g = -9.81 "gravity";
        parameter Boolean initialize_sA = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_sB = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_vA = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_vB = true annotation(Dialog(group = "Initialization"));
        parameter SI.Position sA_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Position sB_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity vA_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity vB_init = 0 annotation(Dialog(group = "Initialization"));
        SI.Position sA;
        SI.Position sB;
        SI.Velocity vA;
        SI.Velocity vB;
        SI.Acceleration aA;
        SI.Acceleration aB;
        SI.Force Ffric "total friction";
        SI.Force F_stribeck;
        SI.Force deltaf "difference of forces";
        SI.Velocity deltav "difference of velocities";
        parameter Real stribeckFactor = Utilities.stribeckFunction(sticktionForce, vis, vh);
        parameter SI.Force sticktionForce = Fh - Fc;
        constant SI.Velocity velLimit = 0.000005;
        Boolean None = if Fh == 0 and Fc == 0 then true else false;
        Boolean Stick(start = false, fixed = true);
        Boolean StartSlip(start = false, fixed = true);
        Boolean Slip(start = true, fixed = true);
      initial equation
        if initialize_sA then
          sA = sA_init;
        end if;
        if initialize_vA then
          vA = vA_init;
        end if;
        if initialize_sB then
          sB = sB_init;
        end if;
        if initialize_vB then
          vB = vB_init;
        end if;
        /*if abs(vA-vB) < velLimit then
    Stick = true;
  else
    Stick = false;
  end if;

  if abs(vA-vB) > velLimit then
    Slip = true;
  else
    Slip = false;
  end if;*/
      equation
        assert(mA > 0, "Negative mass is not allowed!");
        assert(mB > 0, "Negative mass is not allowed!");
        assert(Fh > Fc, "The Static friction should be larger than the Running friction!");
        Slip = initial() and abs(deltav) > velLimit or pre(StartSlip) and abs(deltav) > velLimit or pre(Slip) and abs(deltav) > velLimit;
        StartSlip = pre(Stick) and abs(Ffric) > Fh or pre(StartSlip) and not (deltav > velLimit or aA - aB <= 0);
        Stick = initial() and abs(deltav) < velLimit / 5 or not (Slip or StartSlip);
        when Stick and not initial() then
                  reinit(vB, vA);
        
        end when;
        sA = flange_a.s;
        sB = flange_b.s;
        vA = der(flange_a.s);
        vB = der(flange_b.s);
        aA = der(vA);
        aB = der(vB);
        deltav = vA - vB;
        deltaf = flange_a.f - flange_b.f;
        F_stribeck = Fc * sign(deltav) + vis * deltav + sticktionForce * exp(-stribeckFactor * abs(deltav)) * sign(deltav);
        aA = if None then (flange_a.f - deltav * vis + mA * g) / mA else if Stick then (flange_a.f + flange_b.f + g * (mA + mB)) / (mA + mB) else (flange_a.f - Ffric + g * mA) / mA;
        aB = if None then (flange_b.f - deltav * vis + mB * g) / mB else if Stick then (flange_a.f + flange_b.f + g * (mA + mB)) / (mA + mB) else (flange_b.f + Ffric + g * mB) / mB;
        Ffric = if Stick then flange_a.f - (flange_a.f + flange_b.f) / (mA + mB) * mA else if StartSlip or Slip then F_stribeck else 0;
        annotation(Icon(graphics = {Rectangle(extent = {{-60,80},{60,20}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-60,-20},{60,-80}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Polygon(points = {{-80,4},{-80,-14},{-60,-4},{-60,-14},{-40,-4},{-40,-14},{-20,-4},{-20,-14},{0,-4},{0,-14},{20,-4},{20,-14},{40,-4},{40,-14},{60,-4},{60,-14},{80,-4},{80,14},{60,4},{60,14},{40,4},{40,14},{20,4},{20,14},{0,4},{0,14},{-20,4},{-20,14},{-40,4},{-40,14},{-60,4},{-60,14},{-80,4}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Text(extent = {{-62,74},{36,32}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "m"),Text(extent = {{-54,-30},{24,-70}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "m"),Text(extent = {{-36,74},{62,32}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "B"),Text(extent = {{-28,-30},{50,-70}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {135,135,135}, fillPattern = FillPattern.Solid, textString = "A"),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<P>
This element describes the <i>Stribeck friction characteristics</i> of a sliding mass, on a movable ground
i. e. the frictional force acting between the sliding Piston and the mobile cylinderhousing.
Sign convention: A positive force at flange_a moves the massB in the positive direction. A positive force at flange_b moves the sliding massA to the positive direction.  
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of two masses to which frction acts.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>The component simulates the linear friction in the sense of the Stribeck friction. This is composed of the following three frictions:</li>
  <ul>
  <li> the constant Coulomb friction,</li> 
  <li> the speed-proportional viscous friction ,</li> 
  <li> the Stribeck friction (describes the transition from static friction to sliding friction).</li> 
  </ul>
<li>The resulting overall friction force is the sum of the three components</i>  
<li>Input signals need to be a translatorical connecter which transers the postion <i>s</i> and the force <i>f</i>.</li>
<li>The parameter <i>vh</i> describes the transitional velocity.</li>
<li>The parameter <i>vis</i> describes the viscous friction value.</li>
<li>As long the absolute friction force is smaller then the static friction value, the path of mass A and B will be the same.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>

<p>
<ul>
<li>The parameter <i>static friction</i> must be smaller then the <i>sliding friction</i>.</li>
<li>The parameter <i>massA</i> and <i>massB</i> must be greater zero.</li>
<li>The mass is idealized as a point mass, it doesnt have any expansion.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The following picture shows the components of the resulting overall friction force in the sense of the Stribeck friction.
</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <IMG src=\"modelica://Modelica/Resources/Images/Translational/Stribeck.png\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Stribeck charactaristic</caption>
</table> 
</p>
<p>
The behaviour of the model can be clarified by means of a state diagram with the three states <i>Stick</i>, <i>StartSlip</i> and <i>Slip</i>
(see figure 2). 

</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/statestwomassfriction.jpg\" width=\"800\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>state diagram of the friction model</caption>
</table> 
</p>
<p>
Depending on the <i> FrictionMode </i> the acceleration of both masses and the frictionforce are calculated in the equation section as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if frictionMode is Stick:<br>
  Ffric = flange_a.f-((flange_a.f + flange_b.f)/(mA + mB))*mA;<br>
    aA = (flange_a.f + flange_b.f + g*(mA + mB))/(mA + mB);<br>
    aB = (flange_a.f + flange_b.f + g*(mA + mB))/(mA + mB);

</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if frictionMode is StartSlip:<br>
  Ffric = Fc * sign(deltav) + vis * deltav + sticktionForce * exp(-stribeckFactor * abs(deltav)) * sign(deltav);<br>
    aA = (flange_a.f - Ffric + g * mA)/mA;<br>
    aB = (flange_b.f + Ffric + g * mB)/mB;
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if frictionMode is Stick:<br>
   Ffric = Fc * sign(deltav) + vis * deltav + sticktionForce * exp(-stribeckFactor * abs(deltav)) * sign(deltav);<br>
    aA = (flange_a.f - Ffric + g * mA)/mA;<br>
    aB = (flange_b.f + Ffric + g * mB)/mB;
</td>
</table>
</ul>
</p>
<p>
<h5>Selected variables used in above equations</h5>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>vis</TD><TD VALIGN=\"TOP\">Constant real parameter representing the viscous friction value.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>sticktionForce</TD><TD VALIGN=\"TOP\">Real variable representing the differenz between static friction and sliding friction.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Fc</TD><TD VALIGN=\"TOP\">Real parameter representing the sliding friction.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Ffric</TD><TD VALIGN=\"TOP\">Real variable representing the total friction force.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>deltaf</TD><TD VALIGN=\"TOP\">Real variable representing the sum of all incoming forces</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>stribeckFactor</TD><TD VALIGN=\"TOP\">Real variable representing the stribeck factor.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>frictionMode</TD><TD VALIGN=\"TOP\">Internal integer variable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>mA</TD><TD VALIGN=\"TOP\">Parameter massA </TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>mB</TD><TD VALIGN=\"TOP\">Parameter massB </TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>aA</TD><TD VALIGN=\"TOP\">Internal variable representing the acceleration of mas A</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>aB</TD><TD VALIGN=\"TOP\">Internal variable representing the acceleration of mas B</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>deltav</TD><TD VALIGN=\"TOP\">Internal variable representing the difference of velocities of the masses</TD></TR>
</TABLE>
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the internal Rexroth Simster component <i>TwoMassFrictionEndstop</i>, which is used to simulate the cylinder with housingport.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<b><u>10.1 Testcase 1: TwoMassFriction with step-shaped force (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the two masses is correct for a step-shaped continous inputforce.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a TwoMassFriction block, a force block and a step block (the latter two taken from the MSL).
The output of the step block is connected with the input of the force block, while the force block output is connected 
with the TwoMassFriction input.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p> 
<u>step</u>:<br>
height = 12;<br>
offset = 8;<br>
startTime = 0.5;<br>
<u>TwoMassFriction</u>:<br>
mA = 1;<br>
mB = 1;<br>
g = 0;<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 3s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
TwomassFriction: flange_a.s, flange_b.s 
</p>


<h5>Plausibility checks</h5>
<p>
<i>sA</i> and <i>sB</i> should start with 0 and raise together while the total friction is less than the static friction. At the startTime of the step-shaped force,
 the absolute friction force between both masses gets greater then the static friction and mass B starts to slip on mass A. Mass B gain speed trough the acting force, while mass A nearly retains its speed.
<br><br></p>

<b><u>10.2 Testcase 2: TwoMassFriction with timetable-shaped force (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the two masses is correct for an timetable-force input.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a TwoMassFriction block, a force block and a timeTable block (the latter two taken from the MSL).
The output of the time table block is connected with the input of the force block, while the force block output is connected 
with the TwoMassFriction input.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p> 
<u>timetable</u>:<br>
table = [0, 0; 1.5, 30; 1.51, 0; 5, 0]<br>
<u>TwoMassFriction</u>:<br>
mA = 1;<br>
mB = 1;<br>
g = 0;<br>
vis = 1;<br>
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 4s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massFriction: flange_a.s, flange_b.s
</p>


<h5>Plausibility checks</h5>
<p>
<i>sA</i> and <i>sB</i> should start with 0 and start moving together until the absolute friction force exceeds the sticktion force. The velocity of the mass B increases during the force.
 When no external force acts the sliding friction decreases the speed of the mass B until it reachs the level of the velocity of mass A.
 The state become stick and mass B moves with mass A. 
</p>

<h4>11. Implementation details</h4>
In the implementation are no particularities.

<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end TwoMassFriction;
      model TwoMassEndstop
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Mass mA = 10 "mass A";
        parameter SI.Mass mB = 1 "mass B";
        parameter Real restitutionCoefficient = 5 "damping constant in %" annotation(Dialog(group = "Hard stop"));
        parameter SI.Distance secondStopDistance = 0.5 "second stop distance" annotation(Dialog(group = "Hard stop"));
        parameter SI.Acceleration g = -9.81 "gravity";
        parameter Boolean secondStop = true "Use second stop" annotation(Dialog(group = "Hard stop"));
        parameter Boolean initialize_sA = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_sB = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_vA = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_vB = true annotation(Dialog(group = "Initialization"));
        parameter SI.Position sA_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Position sB_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity vA_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity vB_init = 0 annotation(Dialog(group = "Initialization"));
        SI.Position sA "position of mass A";
        SI.Position sB "position of mass B";
        SI.Velocity vA "velocity of mass A";
        SI.Velocity vB "velocity of mass B";
        SI.Acceleration aRelA "relative acceleration of mass A";
        SI.Acceleration aRelB "relative acceleration of mass B";
        SI.Position Distance;
        Boolean Contact(start = false, fixed = true);
        Boolean ContactTwo(start = false, fixed = true);
        Boolean Free(start = true, fixed = true);
        SI.Velocity vReachContact = 0.00001;
        SI.Velocity vLeaveContact = 0.00005;
        Real stosszahl = 1 - restitutionCoefficient / 100;
      initial equation
        if initialize_sA then
          sA = sA_init;
        end if;
        if initialize_vA then
          vA = vA_init;
        end if;
        if initialize_sB then
          sB = sB_init;
        end if;
        if initialize_vB then
          vB = vB_init;
        end if;
      initial algorithm
        assert(flange_a.s <= flange_b.s, "Initial position of massA must be smaller or equal to the initial position of massB!");
        assert(mA > 0, "Negative mass is not allowed");
        assert(mB > 0, "Negative mass is not allowed");
        if secondStop then 
          assert(flange_a.s >= flange_b.s - secondStopDistance, "Initial position of massA must be greater or equal to the initial position of massB - stopDistance!");
        else

        end if;
      equation
        Free = not Contact and not ContactTwo;
        //initial() or pre(Free) and flange_b.s > flange_a.s and flange_b.s - secondStopDistance < flange_a.s or pre(Contact) and vB-vA>vLeaveContact or pre(ContactTwo) and vA-vB>vLeaveContact;
        Contact = initial() and flange_a.s >= flange_b.s or pre(Free) and flange_a.s > flange_b.s and (abs(vA - vB) < vReachContact or vA > vB) or pre(Contact) and vB - vA < vLeaveContact;
        ContactTwo = initial() and secondStop and flange_b.s - secondStopDistance >= flange_a.s or pre(Free) and flange_b.s - secondStopDistance > flange_a.s and (vB - vA > vReachContact or vB > vA) or pre(ContactTwo) and vA - vB < vLeaveContact;
        aRelA = if Contact and aRelA >= 0 and aRelB >= 0 then min((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if Contact and aRelA < 0 and aRelB < 0 then (flange_a.f + g * mA) / mA else if Contact and aRelA > 0 and aRelB < 0 then 0 else if ContactTwo and aRelA > 0 and aRelB > 0 then (flange_a.f + g * mA) / mA else if ContactTwo and aRelA < 0 and aRelB < 0 then max((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if ContactTwo and aRelA < 0 and aRelB > 0 then 0 else (flange_a.f + g * mA) / mA;
        aRelB = if Contact and aRelA > 0 and aRelB > 0 then (flange_b.f + g * mB) / mB else if Contact and aRelA < 0 and aRelB < 0 then max((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if Contact and aRelA > 0 and aRelB < 0 then 0 else if ContactTwo and aRelA >= 0 and aRelB >= 0 then min((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if ContactTwo and aRelA < 0 and aRelB < 0 then (flange_b.f + g * mB) / mB else if ContactTwo and aRelA < 0 and aRelB > 0 then 0 else (flange_b.f + g * mB) / mB;
        sA = flange_a.s;
        sB = flange_b.s;
        vA = der(flange_a.s);
        vB = der(flange_b.s);
        aRelA = der(vA);
        aRelB = der(vB);
        Distance = flange_a.s + secondStopDistance;
        when Contact and not initial() then
                  reinit(vA, (mA * pre(vA) + mB * pre(vB) - mB * (pre(vA) - pre(vB)) * stosszahl) / (mA + mB));
          reinit(vB, (mA * pre(vA) + mB * pre(vB) - mA * (pre(vB) - pre(vA)) * stosszahl) / (mA + mB));
        
        end when;
        when Contact and not initial() and (vB < vA or abs(vA - vB) < vReachContact) then
                  reinit(vB, vA);
        
        end when;
        when ContactTwo and not initial() then
                  reinit(vA, (mA * pre(vA) + mB * pre(vB) - mB * (pre(vA) - pre(vB)) * stosszahl) / (mA + mB));
          reinit(vB, (mA * pre(vA) + mB * pre(vB) - mA * (pre(vB) - pre(vA)) * stosszahl) / (mA + mB));
        
        end when;
        when ContactTwo and not initial() and (vB > vA or abs(vB - vA) < vReachContact) then
                  reinit(vB, vA);
        
        end when;
        /*when Contact then
    reinit(sB,sA);
  end when;

  when ContactTwo then
    reinit(sB,sA+secondStopDistance);
  end when;*/
        annotation(Icon(graphics = {Rectangle(extent = {{-90,80},{90,-80}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-72,60},{70,-60}}, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-46,46},{-4,-46}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-48,-58},{34,-84}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "m"),Text(extent = {{-58,12},{24,-14}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "B"),Rectangle(extent = {{-6,10},{100,-10}}, pattern = LinePattern.None, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-32,-58},{50,-84}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "A"),Text(extent = {{-72,12},{10,-14}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "m"),Rectangle(extent = {{50,-28},{66,-24}}, pattern = LinePattern.None, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{84,-10},{90,-10}}, pattern = LinePattern.None, smooth = Smooth.None),Rectangle(extent = {{94,-4},{110,0}}, pattern = LinePattern.None, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{70,10},{90,14}}, pattern = LinePattern.None, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{94,-4},{110,0}}, pattern = LinePattern.None, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{70,-14},{90,-10}}, pattern = LinePattern.None, lineColor = {0,0,0}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Line(points = {{84,-10},{90,-10}}, pattern = LinePattern.None, smooth = Smooth.None),Line(points = {{-4,10},{90,10}}, smooth = Smooth.None, color = {0,0,0}),Line(points = {{-4,-10},{90,-10}}, smooth = Smooth.None, color = {0,0,0}),Line(points = {{70,14},{90,14}}, smooth = Smooth.None, color = {0,0,0}),Line(points = {{70,-14},{90,-14}}, smooth = Smooth.None, color = {0,0,0}),Rectangle(extent = {{16,34},{62,30}}, pattern = LinePattern.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Polygon(points = {{16,38},{16,26},{10,32},{16,38}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{60,38},{60,26},{66,32},{60,38}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{22,-84},{22,-96},{28,-90},{22,-84}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{-22,-84},{-22,-96},{-28,-90},{-22,-84}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-22,-88},{24,-92}}, pattern = LinePattern.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component represents two masses with a translational degree of freedom. The mass B can move between two defined contacts which are relative to the position of mass A.

Sign convention: A positive force at flange_a moves the massA in the positive direction. A positive force at flange_b moves the sliding massB to the positive direction. 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of two masses with relative endstops, i. e. the collision between the sliding Piston(mB) and the mobile cylinderhousing(mA). 
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>The contact between massB and massA is modeled by a mechanical collision.</li>
<li>Input signals need to be a translatorical connecter which transers the postion <i>s</i> and the force <i>f</i>.</li>
<li>The parameter <i>Contact damping</i> describes the behavior of the impact.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The collisions between the mass and the contacts are not modeled by a spring-damper-pattern but an elastic impact.</li>
<li>The velocities after the contact are simulated by conservation of momentum.</li>
<li>The initial position of mass B <i>sB</i> must be between the position of mass A <i>sA</i> and the secondEndstop <i>sA + secondStopDistance</i>.</li>
<li>The parameters <i>massA</i> and <i>massB</i> must be greater zero.</li>
<li>The parameter <i>Contact damping</i> must be between 5% and 100%.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
A Contact-damping value of 100% describes an ideal inelastic impact, where no energy is left for bouncing. A value of 0% describes an ideal elastic contact where the whole energy is used to bounce.
Ideal elastic impacts don?t occur in the real life. Also it would cause problems in the solver-proceedings. Thats why a lower limit of 5% is determined. The following picture shows the effects of different damping constants on a falling mass with gravity.</p> 

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/damping-constant.jpg\" width=\"1000\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Impact of different damping constants.</caption>
</table> 
</p>

<p>
The behaviour of the model can be clarified by means of a state diagram with the two or three states <i>Contact</i>, <i>ContactTwo</i> and <i>Free</i>
(see figure 2).
</p>

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
       <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/statesTwomassEndstop.jpg\" width=\"800\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>State diagram of the TwoMassEndstop block</caption>
</table> 
</p>
Depending on the state of the modell the velocities of mass A and B get reinitiated to the corresponding values and the accelerations are calculated in the equation section as follows:

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if contactMode == Contact and aRelA >= 0 and aRelB >= 0 then<br>
       aRelA = min((flange_a.f + g*mA)/mA,(flange_b.f + g*mB)/mB);<br>
       aRelB = (flange_b.f + g*mB)/mB;

</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if contactMode == Contact and aRelA &lt;= 0 and aRelB &lt;= 0 then<br>
       aRelA = (flange_a.f + g*mA)/mA;<br>
       aRelB =  max((flange_a.f + g*mA)/mA,(flange_b.f + g*mB)/mB);
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if contactMode == Contact and aRelA >= 0 and aRelB &lt;= 0 then<br>
       aRelA = 0;<br>
       aRelB = 0;
</td>
</table>
</ul>
</p>

<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if contactMode == ContactTwo and aRelA >= 0 and aRelB >= 0 then<br>
       aRelB = min((flange_a.f + g*mA)/mA,(flange_b.f + g*mB)/mB);<br>
       aRelA = (flange_a.f + g*mA)/mA;
</td>
</table>
</ul>
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if contactMode == ContactTwo and aRelA &lt;= 0 and aRelB &lt;= 0 then<br>
       aRelB = (flange_b.f + g*mB)/mB;<br>
       aRelA =  max((flange_a.f + g*mA)/mA,(flange_b.f + g*mB)/mB);
</td>
</table>
</ul>
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if contactMode == ContactTwo and aRelA &lt;= 0 and aRelB >= 0 then<br>
       aRelA = 0;<br>
       aRelB = 0;
</td>
</table>
</ul>
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  else <br>
      aRelA = (flange_a.f + g*mA)/mA;<br>
      aRelB = (flange_b.f + g*mB)/mB;
</td>
</table>
</ul>
</p>
<p>
<h4>7. Model validation</h4>
<p>
The model is validated to the internal Rexroth Simster component <i>TwoMassFrictionEndstop</i>, which is used to simulate the cylinder.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: TwoMassEndstop with step-force-input signal (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of two masses is correct for a step-shaped inputforce on massB.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a TwoMassEndstop block, a force block and a step block (the latter two taken from the MSL).
The output of the pulse blocks is connected with the input of the force block, while the force block output is connected 
with flange_b of the TwoMassEndstop block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>step</u>:<br>
height = 10;<br>
offset = 0;<br>
startTime = 0.5;<br>
<u>TwoMassEndstop</u>:<br>
restitutionCoefficient = 30;<br>
secondStop = true;<br>
g = 0;<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 3s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massEndstop: flange_a.s and flange_b.s
</p>


<h5>Plausibility checks</h5>
<p>
<i>sA</i> and <i>sB</i> should start with 0 and stay there until the step force acts. Then the massB raise to the second stop and bounce to other direction. At this point massA should receive a velocity from the impact. 
This process should repeat as long the relative velocity of massB to massA is lower then the velocitylimit. The masses should get in contact. Then the massB follows the movement of massA.
</p>

<p>
<b><u>10.2 Testcase 2: TwoMassEndstop with initial conditions (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of two masses with initial conditions is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains only a TwoMassEndstop block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>TwoMassEndstop</u>:<br>
mA = 1000;<br>
mB = 1;<br>
restitutionCoefficient = 100;<br>
secondStop = true;<br>
g = 0;<br>
sB.start = 0.5;<br>
vA.start = 1;<br> 

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massEndstop: flange_a.s and flange_b.s
</p>


<h5>Plausibility checks</h5>
<p>
<i>sA</i> should start at 0 with a initial velocity of 1 and <i>sB</i> should start at 0.5 and stay there until the massA reachs it. Then the massB follows the movement of massA, the mode of contact should be stick.
</p>

<h4>11. Implementation details</h4>
<P> 
In the implementation are no particularities.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end TwoMassEndstop;
      model TwoMassFrictionEndstop
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges;
        parameter SI.Mass mA = 1 "mass A";
        parameter SI.Mass mB = 1 "mass B";
        parameter SI.Acceleration g = -9.81;
        parameter SI.Force Fh = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.Force Fc = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter Real vis = 0 "viscous friction value" annotation(Dialog(group = "Friction"));
        parameter SI.Velocity vh(min = 0.00000000001) = 0.000001 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter SI.Position secondStopDistance = 0.5 "second Stop Distance" annotation(Dialog(group = "Hard stop"));
        parameter Boolean secondStop = false annotation(Dialog(group = "Hard stop"));
        parameter Real restitutionCoefficient(min = 5, max = 100) = 5 "damping endstop in percentage" annotation(Dialog(group = "Hard stop"));
        parameter SI.Position sA_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Position sB_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity vA_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.Velocity vB_init = 0 annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_sA = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_sB = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_vA = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_vB = true annotation(Dialog(group = "Initialization"));
        SI.Position sA "position of mass A";
        SI.Position sB "position of mass B";
        SI.Velocity vA "velocity of mass A";
        SI.Velocity vB "velocity of mass B";
        SI.Acceleration aRelA "relative acceleration of mass A";
        SI.Acceleration aRelB "relative acceleration of mass B";
      protected
        Boolean Contact(start = false, fixed = true);
        Boolean ContactTwo(start = false, fixed = true);
        Boolean Free(start = true, fixed = true);
        Boolean None = if Fh == 0 and Fc == 0 then true else false;
        Boolean Stick(start = false, fixed = true);
        Boolean StartSlip(start = false, fixed = true);
        Boolean Slip(start = true, fixed = true);
        SI.Velocity vReachContact = 0.00001;
        SI.Velocity vLeaveContact = 0.00005;
        Real stosszahl = 1 - restitutionCoefficient / 100;
        SI.Force Ffric "total friction";
        SI.Force F_stribeck;
        SI.Force deltaf "difference of forces";
        SI.Velocity deltav "difference of velocities";
        parameter Real stribeckFactor = Utilities.stribeckFunction(sticktionForce, vis, vh);
        parameter SI.Force sticktionForce = Fh - Fc;
        constant SI.Velocity velLimit = 0.000005;
      initial equation
        if initialize_sA then
          sA = sA_init;
        end if;
        if initialize_vA then
          vA = vA_init;
        end if;
        if initialize_sB then
          sB = sB_init;
        end if;
        if initialize_vB then
          vB = vB_init;
        end if;
      equation
        //   STATE EVENTS   //
        Free = not Contact and not ContactTwo or pre(Contact) and (abs(deltav) > vLeaveContact or deltaf > 0) or pre(ContactTwo) and (abs(deltav) > vLeaveContact or deltaf > 0) or pre(Free) and flange_a.s < flange_b.s and flange_a.s > flange_b.s - secondStopDistance;
        Contact = initial() and flange_a.s >= flange_b.s or pre(Free) and flange_a.s > flange_b.s and (abs(vA - vB) < vReachContact or vA > vB) or pre(Contact) and vB - vA < vLeaveContact;
        ContactTwo = initial() and secondStop and flange_b.s - secondStopDistance >= flange_a.s or pre(Free) and flange_b.s - secondStopDistance > flange_a.s and (vB - vA > vReachContact or vB > vA) or pre(ContactTwo) and vA - vB < vLeaveContact;
        Slip = initial() and abs(deltav) > velLimit or pre(StartSlip) and abs(deltav) > velLimit / 5 or pre(Slip) and abs(deltav) > velLimit / 5;
        StartSlip = pre(Stick) and abs(Ffric) >= Fh or pre(StartSlip) and not abs(deltav) > velLimit / 5;
        Stick = initial() and abs(deltav) < velLimit or not Slip and not StartSlip;
        //////////////////////
        sA = flange_a.s;
        sB = flange_b.s;
        vA = der(flange_a.s);
        vB = der(flange_b.s);
        aRelA = der(vA);
        aRelB = der(vB);
        deltav = vA - vB;
        deltaf = flange_a.f - flange_b.f;
        F_stribeck = Fc * sign(deltav) + vis * deltav + sticktionForce * exp(-stribeckFactor * abs(deltav)) * sign(deltav);
        aRelA = if None then (flange_a.f - deltav * vis + mA * g) / mA else if Stick then (flange_a.f + flange_b.f + g * (mA + mB)) / (mA + mB) else if Contact and aRelA >= 0 and aRelB >= 0 then min((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if Contact and aRelA < 0 and aRelB < 0 then (flange_a.f + g * mA) / mA else if Contact and aRelA > 0 and aRelB < 0 then 0 else if ContactTwo and aRelA > 0 and aRelB > 0 then (flange_a.f + g * mA) / mA else if ContactTwo and aRelA < 0 and aRelB < 0 then max((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if ContactTwo and aRelA < 0 and aRelB > 0 then 0 else (flange_a.f - Ffric + g * mA) / mA;
        aRelB = if None then (flange_b.f - deltav * vis + mB * g) / mB else if Stick then (flange_a.f + flange_b.f + g * (mA + mB)) / (mA + mB) else if Contact and aRelA > 0 and aRelB > 0 then (flange_b.f + g * mB) / mB else if Contact and aRelA < 0 and aRelB < 0 then max((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if Contact and aRelA > 0 and aRelB < 0 then 0 else if ContactTwo and aRelA >= 0 and aRelB >= 0 then min((flange_a.f + g * mA) / mA, (flange_b.f + g * mB) / mB) else if ContactTwo and aRelA < 0 and aRelB < 0 then (flange_b.f + g * mB) / mB else if ContactTwo and aRelA < 0 and aRelB > 0 then 0 else (flange_b.f + Ffric + g * mB) / mB;
        Ffric = if Stick then flange_a.f - (flange_a.f + flange_b.f) / (mA + mB) * mA else if StartSlip or Slip then F_stribeck else 0;
      algorithm
        //      REINITS      //
        when Contact and not initial() then
                  reinit(vA, (mA * pre(vA) + mB * pre(vB) - mB * (pre(vA) - pre(vB)) * stosszahl) / (mA + mB));
          reinit(vB, (mA * pre(vA) + mB * pre(vB) - mA * (pre(vB) - pre(vA)) * stosszahl) / (mA + mB));        
        end when;
        when Contact and not initial() and (vB < vA or abs(vB - vA) < vReachContact) then
                  reinit(vB, vA);        
        end when;
        when ContactTwo and not initial() then
                  reinit(vA, (mA * pre(vA) + mB * pre(vB) - mB * (pre(vA) - pre(vB)) * stosszahl) / (mA + mB));
          reinit(vB, (mA * pre(vA) + mB * pre(vB) - mA * (pre(vB) - pre(vA)) * stosszahl) / (mA + mB));        
        end when;
        when ContactTwo and not initial() and (vB > vA or abs(vA - vB) < vReachContact) then
                  reinit(vB, vA);        
        end when;
        /*when Contact then
    reinit(sB,sA);
  end when;

  when ContactTwo then
    reinit(sB,sA+secondStopDistance);
  end when;*/
        ///////////////////////
        annotation(Icon(graphics = {Rectangle(extent = {{-90,80},{90,-80}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Polygon(points = {{-72,60},{-54,50},{-54,60},{-36,50},{-36,60},{-18,50},{-18,60},{0,50},{0,60},{18,50},{18,60},{36,50},{36,60},{54,50},{54,60},{70,50},{70,-60},{52,-50},{52,-60},{34,-50},{34,-60},{16,-50},{16,-60},{-2,-50},{-2,-60},{-20,-50},{-20,-60},{-38,-50},{-38,-60},{-56,-50},{-56,-60},{-72,-50},{-72,60}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-46,46},{-4,-46}}, lineColor = {0,0,0}, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Text(extent = {{-48,-58},{34,-84}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "m"),Text(extent = {{-58,12},{24,-14}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "B"),Text(extent = {{-32,-58},{50,-84}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "A"),Text(extent = {{-72,12},{10,-14}}, lineColor = {0,0,0}, lineThickness = 0.5, fillColor = {175,175,175}, fillPattern = FillPattern.Solid, textString = "m"),Rectangle(extent = {{94,10},{-8,-10}}, pattern = LinePattern.None, fillColor = {175,175,175}, fillPattern = FillPattern.Solid),Rectangle(extent = {{70,14},{90,10}}, pattern = LinePattern.None, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Rectangle(extent = {{70,-10},{90,-14}}, pattern = LinePattern.None, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Line(points = {{-4,10},{90,10}}, smooth = Smooth.None, color = {0,0,0}),Line(points = {{-4,-10},{90,-10}}, smooth = Smooth.None, color = {0,0,0}),Line(points = {{70,14},{90,14}}, pattern = LinePattern.None, smooth = Smooth.None),Line(points = {{70,-14},{90,-14}}, pattern = LinePattern.None, smooth = Smooth.None),Polygon(points = {{60,38},{60,26},{66,32},{60,38}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{16,38},{16,26},{10,32},{16,38}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Rectangle(extent = {{16,34},{62,30}}, pattern = LinePattern.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Polygon(points = {{22,-84},{22,-96},{28,-90},{22,-84}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{-22,-84},{-22,-96},{-28,-90},{-22,-84}}, pattern = LinePattern.None, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-22,-88},{24,-92}}, pattern = LinePattern.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, lineColor = {0,0,0}),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<P>
This element describes the <i>Stribeck friction characteristics</i> between two sliding masses, within relative limits.
The masses have a translational degree of freedom. 
Sign convention: A positive force at flange_a moves the massA in the positive direction. A positive force at flange_b moves the sliding massB to the positive direction. 
The model is a combination of the componets <i>TwoMassEndstop</i> and <i>TwoMassFriction<i/>.

</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the movement of two masses with frction inside a relative range, i. e. a hdyraulic cylinder where the piston moves inside of the moveable housing with a defined piston stroke and friction between them. 
</p>

<h4>3. Features</h4>
<p> For all features, options, limits, and equations see the documentations of the used components <i>massEndstop</i> and <i>massFriction<i/>.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the internal Rexroth Simster component <i>TwoMassFrictionEndstop</i>, which is used to simulate the cylinder.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>MassWithStopAndFriction</p></td>
<td><p>only one moveable mass</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: TwoMassFrictionEndstop with timetable-shaped force (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the two masses is correct for an impulse-force input.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a TwoMassFrictionEndstop block, a force block and a timeTable block (the latter two taken from the MSL).
The output of the time table block is connected with the input of the force block, while the force block output is connected 
with flange_b of TwoMassFrictionEndstop.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p> 
<u>timetable</u>:<br>
table = [0, 0; 0.5, 0; 0.51, 11; 2, 11; 2.01, 0; 5, 0]<br>
<u>TwoMassFrictionEndstop</u>:<br>
mA = 100;<br>
mB = 5;<br>
secondStop = true;<br>
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>

Simulation time: 0s ... 3s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massFrictionEndstop: flange_a.s, flange_b.s
</p>


<h5>Plausibility checks</h5>
<p>
<i>sA</i> and <i>sB</i> should start with 0 and begin to raise at 0.5. Because the jump in force is not idealized massA will get a velocity aswell. MassB should bounce at the second stop and
 turn his speed in the other direction, because of the impact massA increase further. As soon the external force is gone, the friction is the active force. So the massB will decrease until a certain level of speed is undershot.
 It stops and get carried forward by massA.
</p>

<h4>11. Implementation details</h4>
<P> 
For details see the documentations of the used components.
</p>

<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>


</HTML>"), Diagram(graphics));
      end TwoMassFrictionEndstop;
      model Velocity "Singal to velocity"
        import SI = Modelica.SIunits;
        parameter Boolean initialize_s = false annotation(Dialog(group = "Initialization"));
        parameter SI.Position s_init = 0 annotation(Dialog(group = "Initialization"));
        Modelica.Mechanics.Translational.Sources.Speed speed(s(start = if initialize_s then s_init else 0), exact = true) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        parameter String unit = "mm/s" annotation(choices(choice = "mm/s", choice = "m/s", choice = "km/h", choice = "m/min", choice = "in/s", choice = "ft/s", choice = "mph"));
        Modelica.Blocks.Interfaces.RealInput s_ref "Reference position of flange as input signal" annotation(Placement(transformation(extent = {{-126,-20},{-86,20}}, rotation = 0)));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange "Flange of component" annotation(Placement(transformation(extent = {{90,-10},{110,10}}, rotation = 0)));
      equation
        if unit == "mm/s" then
          speed.v_ref = s_ref / 1000;
        elseif unit == "m/s" then
          speed.v_ref = s_ref;
        elseif unit == "km/h" then
          speed.v_ref = s_ref / 3.6;
        elseif unit == "m/min" then
          speed.v_ref = s_ref / 60;
        elseif unit == "in/s" then
          speed.v_ref = s_ref / 39.370079;
        elseif unit == "ft/s" then
          speed.v_ref = s_ref / 3.2808399;
        elseif unit == "mph" then
          speed.v_ref = s_ref / 2.236936;
        else
          speed.v_ref = s_ref;
        end if;
        connect(speed.flange,flange) annotation(Line(points = {{10,0},{100,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-50,70},{50,-70}}, lineColor = {0,0,0}),Text(extent = {{-40,44},{42,-48}}, lineColor = {0,0,0}, textStyle = {TextStyle.Bold}, textString = "V")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This block supplies a velocity corresponding to the signal input
</p>

<h4>2. Application area</h4>
<p>
Common velocity specification.
</p>

<h4>3. Features</h4>
<p>
Using the <i>unit</i> parameter, the unit of the specified signal can be set. By setting the parameter <i> initialize_s<i> u can decide about a start position.

</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The behavior is defined by the equation:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
speed.v_ref = s_ref;
</td>
</table>
</ul>
</p>
<p>
Note: No exact velocity values at start, if initial position is given.
</p>
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Velocity</i>. 
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Speed</p></td>
<td><p>Model from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Velocity allegation.</u></b>
</p>
<p>
This testcase checks if the movenment of a mass with a velocity allegation is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Ramp-, a Velocity-block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>ramp</u>:<br>
duration = 1<br>
<u>Velocity</u>:<br>
initialize_s = true <br>
s_init = 1 m <br>
unit = &quot;m/s&quot;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 0.1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Velocity: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 1. The velocity should raise in the same way the ramp increases.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Velocity;
      package Utilities
        model ForceCombi
          Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-10,90},{10,110}})));
          Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b annotation(Placement(transformation(extent = {{-70,-110},{-50,-90}}), iconTransformation(extent = {{-70,-110},{-50,-90}})));
          Modelica.Mechanics.Translational.Interfaces.Flange_b flange_c annotation(Placement(transformation(extent = {{50,-110},{70,-90}})));
        equation
          flange_a.f = flange_b.f - flange_c.f;
          flange_b.s = flange_a.s;
          flange_c.s = -flange_a.s;
          annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Polygon(points = {{-64,-80},{-64,-32},{-64,-30},{-70,-30},{-60,-20},{-50,-30},{-56,-30},{-56,-80},{-64,-80}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {95,95,95}, fillPattern = FillPattern.Solid),Polygon(points = {{56,-80},{56,-32},{56,-30},{50,-30},{60,-20},{70,-30},{64,-30},{64,-80},{56,-80}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {95,95,95}, fillPattern = FillPattern.Solid),Polygon(points = {{-4,24},{-4,72},{-4,74},{-10,74},{0,84},{10,74},{4,74},{4,24},{-4,24}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {95,95,95}, fillPattern = FillPattern.Solid),Text(extent = {{16,-42},{46,-64}}, lineColor = {0,0,0}, fillColor = {95,95,95}, fillPattern = FillPattern.Solid, textString = "F2"),Text(extent = {{-46,-42},{-16,-64}}, lineColor = {0,0,0}, fillColor = {95,95,95}, fillPattern = FillPattern.Solid, textString = "F1"),Text(extent = {{14,60},{64,38}}, lineColor = {0,0,0}, fillColor = {95,95,95}, fillPattern = FillPattern.Solid, textString = "Fges")}));
        end ForceCombi;
        function stribeckFunction "Function to calculate the stribeckFactor"
          // INPUTS
          input Real sticktionForce;
          input Real vis;
          input Real vh;
          // OUTPUTS
          output Real stribeckFactor;
        algorithm
          if not sticktionForce == 0 then 
            if not vis == 0 then 
              stribeckFactor:=-log(vis * vh / sticktionForce) / vh;
              for i in 0:10 loop
                              stribeckFactor:=stribeckFactor - (-stribeckFactor * sticktionForce * exp(-stribeckFactor * vh) + vis) / (sticktionForce * exp(-stribeckFactor * vh) * (stribeckFactor * vh - 1));
              end for;
            else
              stribeckFactor:=-log(0.000001 / sticktionForce) / vh;
            end if;
          else

          end if;
        end stribeckFunction;
      end Utilities;
      annotation(uses(Modelica(version = "3.2")), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/Linearbib.jpg\" width=\"2932\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Differences between DC_Mechlib and Simstercomponents</caption>
</table> 
</p>


</HTML>"));
    end Linear;
    package Rotatory
      model Angle
        import SI = Modelica.SIunits;
        parameter String unit = "grad" annotation(choices(choice = "grad", choice = "rad"));
        parameter SI.AngularVelocity w_init = 0 "Initial angular velocity" annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_w = false annotation(Dialog(group = "Initialization"));
        final constant Real pi = 2 * Modelica.Math.asin(1.0);
        Modelica.Mechanics.Rotational.Sources.Position position(exact = if initialize_w then false else true, f_crit = 10000, w(start = if initialize_w then w_init else 0)) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput phi annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
      equation
        if unit == "grad" then
          position.phi_ref = phi * pi / 180;
        elseif unit == "rad" then
          position.phi_ref = phi;
        else
          position.phi_ref = phi;
        end if;
        connect(position.flange,flange_b) annotation(Line(points = {{10,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-50,70},{50,-70}}, lineColor = {0,0,0}),Text(extent = {{-40,52},{42,-40}}, lineColor = {0,0,0}, textStyle = {TextStyle.Bold}, textString = "?")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This block supplies a angle corresponding to the signal input
</p>

<h4>2. Application area</h4>
<p>
Common angle specification.
</p>

<h4>3. Features</h4>
<p>
Using the <i>unit</i> parameter, the unit of the specified signal can be set. By setting the parameter <i> initialize_w<i> u can decide about a start velocity <i> w_init</i>.

</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The behavior is defined by the equation:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 position.s_ref = s_ref;
</td>
</table>
</ul>
</p>
<p>
Note: No exact position values at start, if initial velocity is given.
</p>
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Angle</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Position</p></td>
<td><p>Model from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Angle allegation</u></b>
</p>
<p>
This testcase checks if the predefined rotation is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Ramp-, a Angle-block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>ramp</u>:<br>
duration = 1<br>
<u>Position</u>:<br>
initialize_w = true <br>
w_init = 180 grad/s <br>
unit = &quot;rad&quot;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 0.1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Angle: flange_a <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 0 and a velocity of 180 grad/s. It should raise in the same way the reference increases.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Angle;
      model CableReel
        import SI = Modelica.SIunits;
        import DC_Mechlib_SB;
        parameter SI.Inertia J = 1 "Inertia";
        parameter SI.Length Radius = 1 "Diameter";
        parameter SI.Torque Mslip = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter Real vis(unit = "N.s.m/rad") = 0 "viscous friction value" annotation(Dialog(group = "Friction"));
        parameter SI.Torque Mstick = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.AngularVelocity wh = 0 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter SI.Angle phi_init = 0 "initial angle" annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity w_init = 0 "initial omega" annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = false annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_w = false annotation(Dialog(group = "Initialization"));
        SI.Velocity v1 = der(flange_b1.s);
        SI.Acceleration a1 = der(v1);
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{-10,90},{10,110}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-70,-110},{-50,-90}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b1 annotation(Placement(transformation(extent = {{50,-110},{70,-90}})));
        DC_Mechlib_SB.Components.Rotatory.InertiaFriction inertiaFriction(J = J, Mslip = Mslip, vis = vis, phi_init = phi_init, omega_init = w_init, initialize_phi = initialize_phi, initialize_omega = initialize_w, Mstick = Mstick, wh = wh) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = -90, origin = {0,50})));
        DC_Mechlib_SB.Components.Rotatory.RackandPin rackandPin(Radius = Radius) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = -90, origin = {0,-10})));
        DC_Mechlib_SB.Components.Linear.Utilities.ForceCombi test annotation(Placement(transformation(extent = {{-10,-60},{10,-40}})));
      equation
        connect(inertiaFriction.flange_a,flange_b) annotation(Line(points = {{0.00000000000000183697,60},{0,60},{0,100}}, color = {0,0,0}, smooth = Smooth.None));
        connect(rackandPin.flange_R,inertiaFriction.flange_b) annotation(Line(points = {{0.00000000000000183697,0},{0.00000000000000183697,10},{-0.00000000000000183697,10},{-0.00000000000000183697,40}}, color = {0,0,0}, smooth = Smooth.None));
        connect(test.flange_a,rackandPin.flange_T) annotation(Line(points = {{0,-40},{0,-20},{-0.00000000000000183697,-20}}, color = {0,127,0}, smooth = Smooth.None));
        connect(flange_a,test.flange_b) annotation(Line(points = {{-60,-100},{-6,-100},{-6,-60}}, color = {0,127,0}, smooth = Smooth.None));
        connect(flange_b1,test.flange_c) annotation(Line(points = {{60,-100},{6,-100},{6,-60}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{-60,60},{60,-60}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-6,6},{6,-6}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Line(points = {{-60,0},{-60,-100}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{60,0},{60,-100}}, color = {0,0,0}, smooth = Smooth.None)}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component simulates a cablereel with a rotational degree of freedom. 

</p>

<h4>2. Application area</h4>
<p>
Use this component to merge forces and torque and get a resulting movement
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>By defining the radius, its possible to set the propotion between linear and angular movements.</li>
<li>The torques acting on the roll are calculated from the forces acting on the mechanical flanges.</li>
<li>Positive forces correspond to a pulling at the roll and thus provide for a positive torque at flange_a and for a negative one at flange_b1</li>
<li>The total of these two torques and the torque at the rotational flange result in the total torque acting on the roll and being responsible for its rotation.</li>
<li>This rotation can still be counteracted by means of Coulomb and viscous friction.</li>
</ul>
The friction is implementated by the mean of stribeck-friction. For further explanation see the documentation of <i>InertiaFriction</i>.
</p>


<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The parameter <i>J</i> must be greater zero.</li>
<li>The mass is idealized as a point mass, it doesnt have any expansion.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The model is a combination of the components <i>RackandPin</i> and <i>InertiaFriction</i>, both taken from the DC_Mechlib.
For Modelling details and equations see the documentations of both.
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Cable reel</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: CableReel with a constant torque and variable force</u></b>
</p>
<p>
This testcase checks if the rotation and transformation is calculated correctly
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains two Clamp-, a ToqreConstant-, a ForceVariable, a step and a CableReel-Block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>step</u>:<br>
startTime = 0.5<br>
height = -5<br>
<u>CableReel</u>:<br>
Mslip = 1 Nm;<br>
J = 0.1 kg*m^2;<br>
vis = 0.001 Nsm/rad;<br>
<u>TorqueConstant</u>:<br>
Torque = 5 Nm;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
CableReel: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 0 and raise with a constant acceleration. Until the force acting on flange_a is zero only the friction is counteracting the rotation.
The force acts against the moment, because of a the propotion through the given radius the overall torque is zero. The cable reel gets decelerated by the friction until it stops.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end CableReel;
      model Clamp
        import SI = Modelica.SIunits;
        parameter SI.Angle Angle = 0;
        final constant Real pi = 2 * Modelica.Math.asin(1.0);
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
      equation
        flange_b.phi = Angle annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        annotation(choices(choice = "rad", choice = "grad"), Icon(graphics = {Polygon(points = {{0,60},{-60,-40},{60,-40},{0,60}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-64,-56},{-52,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{42,-56},{54,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{28,-56},{40,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{14,-56},{26,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-2,-56},{10,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-18,-56},{-6,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,-56},{-22,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-50,-56},{-38,-40}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component supplies a constant angle.
</p>

<h4>2. Application area</h4>
<p>
The component serves for the clamping of other rotational components at a certain angle.
</p>

<h4>3. Features</h4>
<p>
No special features are included.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
No limits or assumptions are required.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The flange_a.phi complies the parameter <i>Angle</i>.
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
flange_b.phi = Angle;
</td>
</table>
</ul>
</p>

</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Clamp, rotatory</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Fixed</p></td>
<td><p>Component from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
</p>


<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Clamp;
      model Gear "Gear with efficiency"
        import SI = Modelica.SIunits;
        parameter Real i = 1 "ratio";
        SI.Torque M1th "theoritische Moment";
        SI.Power P "reale Leistung";
        SI.AngularVelocity omega "Winkelgeschwindigkeit Antriebe";
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {0,108}), iconTransformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {0,103})));
      equation
        assert(u > 0, "zero or negative efficiency not allowed");
        flange_a.phi = flange_b.phi * i;
        M1th = flange_b.tau / i;
        omega = der(flange_a.phi);
        P = M1th * omega;
        flange_a.tau = -(M1th - tanh(P) * M1th * (1 - u / 100));
        annotation(Icon(graphics = {Rectangle(extent = {{-40,16},{-20,-24}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-40,96},{-20,16}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{20,76},{40,35}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{20,36},{40,-44}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{40,10},{100,-10}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-20,66},{20,46}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-100,10},{-40,-10}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Polygon(points = {{-60,-68},{-60,-72},{50,-72},{50,-80},{60,-70},{50,-60},{50,-68},{-60,-68}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0})}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component represents a simplified gear with efficiency as a input signal
</p>

<h4>2. Application area</h4>
<p>
The transmission is a component for the system simulation.
It is used for power transmission with a gear stage. When power is transmitted in mechanical systems friction allways occurs.
The losses can be simulated by this component
</p>

<h4>3. Features</h4>
<p>
No special features are included.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
No limits or assumptions are required.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The output angle is calculated by the input angle and the given ratio. 
To calculate the power loss the constant efficiency is either multiplied or divided, according to the direction of power flow.
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
flange_a.phi = flange_b.phi * i;<br>
M1th = flange_b.tau / i;<br>
omega = der( flange_a.phi);<br>
P = M1th * omega;<br>

flange_a.tau = -( M1th - tanh(P) * M1th * (1- u / 100));<br>
</td>
</table>
</ul>
</p>

</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Gear</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>lossyGear</p></td>
<td><p>Loss-input trough losstable</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Gear with efficency</u></b>
</p>
<p>
This testcase checks if the rotational movement of the mass is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Inertia- Gear- TorqueConstant- Clamp- and a constblock, the last one is taken from the MSL. 
The efficency of the gear is given by the constantblock. On flange_b of the gear acts a positive torque, the negative flange acts on the clamp.
At the other flange, an inertia is connected.

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>Inertia</u>:<br>
initialize_phi = true;<br>
initialize_w = true;<br>
s_init = 0 rad;<br>
v_init = 0 rad/s<br>

<u>Gear</u>:<br>
i = 2;<br>

<u>TorqueConstant</u>:<br>
Torque = 5;<br>

<u>const</u>:<br>
k = 50;<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Gear: flange_a <i>phi</i>
      flange_b <i>phi</i>
</p>

<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at the initial angle of 0 and a start velocity of 0 rad/s. The torque should get reduced by the ratio and the efficency. The resulting positiv moment should rotate the inertia.
<i>phi</i> at flange_b of the gear should always be the half because of the ratio of 2.
</p>

<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Gear;
      model GearKomplex
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
        import SI = Modelica.SIunits;
        final constant Real pi = 2 * Modelica.Math.asin(1.0);
        parameter SI.Inertia J = 0.001 "Inertia";
        parameter SI.Torque Mslip = 0 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter SI.Torque Mstick = 0 "static friction" annotation(Dialog(group = "Friction"));
        parameter Real vis(unit = "N.s.m/rad") = 0 "viscous friction value" annotation(Dialog(group = "Friction"));
        parameter SI.AngularVelocity wh = 0 annotation(Dialog(group = "Friction"));
        parameter Real ratio = 1 "Transmission ratio (flange_a.phi/flange_b.phi)";
        parameter SI.Angle phi_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity omega_init = 0 annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = false annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_omega = false annotation(Dialog(group = "Initialization"));
        Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = ratio) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        InertiaFriction inertiaFriction(J = J, vis = vis, phi_init = phi_init, omega_init = omega_init, initialize_phi = initialize_phi, initialize_omega = initialize_omega, Mslip = Mslip, Mstick = Mstick, wh = wh) annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
      equation
        connect(flange_a,inertiaFriction.flange_a) annotation(Line(points = {{-100,0},{-50,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(inertiaFriction.flange_b,idealGear.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(idealGear.flange_b,flange_b) annotation(Line(points = {{10,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-40,16},{-20,-24}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-40,96},{-20,16}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{20,76},{40,35}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{20,36},{40,-44}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{40,10},{100,-10}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-20,66},{20,46}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-100,10},{-40,-10}}, lineColor = {0,0,0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {192,192,192}),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Polygon(points = {{-60,-68},{-60,-72},{50,-72},{50,-80},{60,-70},{50,-60},{50,-68},{-60,-68}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component represents a gear with friction
</p>

<h4>2. Application area</h4>
<p>
The transmission is a component for the system simulation.
It is used for power transmission with a gear stage. When power is transmitted in mechanical systems friction allways occurs.
The losses can be simulated by this component
</p>

<h4>3. Features</h4>
<p>
No special features are included.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
No limits or assumptions are required.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
This componet is a combination of the model <i>idealGear</i> from the MSL and the model <i>InertiaFriction</i>. For details and further explanation see the seperated documentations.
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>GearKomplex</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>lossyGear</p></td>
<td><p>Loss-input trough losstable instead of frictin</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Gear with friction</u></b>
</p>
<p>
This testcase checks if the rotational movement of the flanges is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp- a TorqueConst- and a GearKomplexblock. 
The efficency of the gear is given by the friction parameters. On flange_a of the gear acts a positive torque, the negative torque acts on the clamp.


<h5>Decisive parameter values and solver settings</h5>
<p>
<u>GearKomplex</u>:<br>
initialize_phi = true;<br>
initialize_w = true;<br>
s_init = 0 rad;<br>
v_init = 0 rad/s;<br>
J = 0.1 kg*m^2;<br>
ratio = 2;<br>
Mslip = 2 NM;<br>
vis = 0.001 Nsm/rad<br>

<u>TorqueConstant</u>:<br>
Torque = 5;<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Gear: flange_a <i>phi</i>
      flange_b <i>phi</i>
</p>

<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at the initial angle of 0 and a start velocity of 0 rad/s. The torque should get reduced by the ratio and the efficency. The resulting positiv moment should rotate the inertia.
<i>phi</i> at flange_b of the gear should always be the half because of the ratio of 2.
</p>

<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end GearKomplex;
      model Inertia
        import SI = Modelica.SIunits;
        parameter SI.Inertia J = 1 "Inertia";
        parameter SI.Angle phi_init = 0 "initial Angle" annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity w_init = 0 "initial Revolution" annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = false annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_w = false annotation(Dialog(group = "Initialization"));
        SI.Angle phi;
        SI.AngularVelocity omega;
        SI.AngularAcceleration a;
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
      initial equation
        if initialize_phi then
          phi = phi_init;
        end if;
        if initialize_w then
          omega = w_init;
        end if;
      equation
        assert(J > 0, "Negative inertia is not allowed");
        phi = flange_a.phi;
        flange_a.phi = flange_b.phi;
        omega = der(phi);
        a = der(omega);
        J * a = flange_a.tau + flange_b.tau;
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{-60,60},{60,-60}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-80,0},{-80,10},{-78,26},{-70,42},{-56,58},{-38,70},{-20,78},{0,80}}, color = {0,0,0}, smooth = Smooth.None),Polygon(points = {{-80,-20},{-86,0},{-74,0},{-80,-20}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-54,48},{52,-48}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "J")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component represents a mass with a rotational degree of freedom. 
Sign convention: A positive torque at flange_a rotates the inertia in the positive direction. A negative torque at flange_a rotates the inertia to the negative direction. 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the rotation of a inertia.
</p>

<h4>3. Features</h4>
<p>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The parameter <i>J</i> must be greater zero.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
phi = flange_a.phi;<br>
  flange_a.phi = flange_b.phi;<br>
  omega = der(phi);<br>
  a = der(omega);<br>
  J * a = flange_a.tau + flange_b.tau;<br>
</td>
</table>
</ul>
</p>



<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Inertia</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Inertia</p></td>
<td><p>Model from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Inertia with Initial angle and angular velocity</u></b>
</p>
<p>
This testcase checks if the rotation of the mass wtih initial conditions is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains only a Inertia-block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>Inertia</u>:<br>
initialize_s = true;<br>
initialize_v = true;<br>
s_init = 45 grad;<br>
v_init = 90 grad/s<br>
 

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Inertia: flange_a <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at the initial position of 45 deg and a start velocity of 90 deg/s. The mass should rotate continoulsy with the same speed until it reachs 135 degrees at time 1.
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Inertia;
      model InertiaEndstop
        import SI = Modelica.SIunits;
        final constant Real pi = 2 * Modelica.Math.asin(1.0);
        parameter SI.Inertia J = 1 "Inertia";
        parameter SI.Angle lowcont = -pi "Lower contact" annotation(Dialog(group = "Hard stop"));
        parameter SI.Angle upcont = pi "Upper contact" annotation(Dialog(group = "Hard stop"));
        parameter Real restitutionCoefficient(min = 5, max = 100) = 5 "damping constant" annotation(Dialog(group = "Hard stop"));
        parameter SI.Angle phi_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity omega_init = 0 annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_omega = true annotation(Dialog(group = "Initialization"));
        SI.Angle phi;
        SI.AngularVelocity omega;
        SI.AngularAcceleration a;
        SI.Torque deltaM = flange_a.tau - flange_b.tau;
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
      protected
        SI.AngularVelocity wReachContact = 0.00001;
        SI.AngularVelocity wLeaveContact = 0.00005;
        Real stosszahl = 1 - restitutionCoefficient / 100;
        Boolean Contact_up(start = false, fixed = true);
        Boolean Contact_down(start = false, fixed = true);
        Boolean Free(start = true, fixed = true);
      initial equation
        if initialize_phi then
          phi = phi_init;
        end if;
        if initialize_omega then
          omega = omega_init;
        end if;
      initial algorithm
        assert(upcont > lowcont, "The upper limit must be grater then the lower limit.");
        assert(lowcont <= phi and phi <= upcont, "The initial position must be between the upper and the lower limit.");
        assert(J > 0, "Negative inertia is not allowed");
      equation
        Contact_up = initial() and flange_a.phi >= upcont or pre(Free) and flange_a.phi > upcont and omega > wReachContact;
        Contact_down = initial() and flange_a.phi <= lowcont or pre(Free) and lowcont > flange_a.phi and -omega > wReachContact;
        Free = initial() or pre(Contact_up) and (abs(omega) > wLeaveContact or deltaM < 0) or pre(Contact_down) and (abs(omega) > wLeaveContact or deltaM > 0) or pre(Free) and flange_a.phi < upcont or flange_a.phi > lowcont;
        a = if Contact_up then 0 else if Contact_down then 0 else deltaM / J;
        when (Contact_up or Contact_down) and not initial() then
                  reinit(omega, -stosszahl * omega);
        
        end when;
        phi = flange_a.phi;
        flange_a.phi = flange_b.phi;
        omega = der(phi);
        a = der(omega);
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{-60,60},{60,-60}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-80,0},{-80,10},{-78,26},{-70,42},{-56,58},{-38,70},{-20,78},{0,80}}, color = {0,0,0}, smooth = Smooth.None),Polygon(points = {{-80,-20},{-86,0},{-74,0},{-80,-20}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-54,48},{52,-48}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "J"),Polygon(points = {{-48,-36},{-36,-48},{-52,-64},{-64,-52},{-48,-36}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Polygon(points = {{0,-64},{-16,-90},{16,-90},{0,-64}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-14,-90},{-18,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{10,-90},{6,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{4,-90},{0,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-2,-90},{-6,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-8,-90},{-12,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{16,-90},{12,-96}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component represents a mass with a rotational degree of freedom. The mass can move between two defined contacts.
Sign convention: A positive torque at flange_a turns the rotating mass in the positive direction. A negative torque at flange_a turns it to the negative direction. 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the rotation of a mass inside a defined range.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>The contact between the mass and the stop is modeled by a mechanical collision.</li>
<li>The parameter <i>damping contact</i> describes the behavior of the impact.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The collisions between the inertia and the contacts are not modeled by spring-damper-pattern but an elastic impact.</li>
<li>The parameter <i>lowcont</i> must be smaller then the <i> upcont</i>.</li>
<li>The parameter <i>inertia</i> must be greater zero.</li>
<li>The parameter <i>damping contact</i> must be between 5% and 100%.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
A Contact-damping value of 100% describes an ideal inelastic impact, where no energy is left for bouncing. A value of 0% describes an ideal elastic contact where the whole energy is used to bounce.
Ideal elastic impacts don?t occur in the real life. Also it would cause problems in the solver-proceedings. Thats why a lower limit of 5% is determined. The following picture shows the effects of different damping constants on a falling mass with gravity.</p> 

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:\10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/damping-constant.jpg\" width=\"1000\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Impact of different damping constants.</caption>
</table> 
</p>

<p>
The behaviour of the model can be clarified by means of a state diagram with the three states <i>contact_up</i>, <i>contact_down</i> and <i>free</i>
(see figure 2). The actual position and its derivative are necessary to detect the state switch from either <i> contact_UP </i> or <i> contact_DOWN </i> to <i> Free </i> and the other way around.
</p>

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
       <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/statesendstoprot.jpg\" width=\"800\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>State diagram of the InertiaEndstop block</caption>
</table> 
</p>

<p>
Depending on the <i> contactMode </i> the angle and the angular velocity are reinitialized and the acceleration <i>acce</i> is calculated in the equation section as follows:
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  acce = 0; &nbsp;&nbsp;&nbsp;&nbsp;if contactMode is contact_UP
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  acce = 0; &nbsp;&nbsp;&nbsp;&nbsp;if contactMode is contact_DOWN
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  J * a = flange_a.tau - flange_b.tau; &nbsp;&nbsp;&nbsp;&nbsp;if contactMode is Free
</td>
</table>
</ul>
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Inertia, hard stop</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>MassWithStopAndFriction</p></td>
<td><p>Stribeck-friction is included aswell / translational degree of freedom</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: InertiaEndstop with initial conditions (for Dymola)</u></b>
</p>
<p>
This testcase checks if the rotation of the mass with initial conditions is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains only a InertiaEndstop block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>InertiaEndstop</u>:<br>
 lowcont = -pi<br>
 upcont  = pi<br>
 restitutionCoefficient = 50<br>
 initialize_phi = true<br>
 initialize_omega = true<br>
 omega_init = 360 deg/s<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 2s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
InertiaEndstop: flange_a <i>phi</i>;
InertiaEndstop: <i>omega</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start with 0 and omega have to start at the given value of 360 deg/s. <i>phi</i> should raise to the upper limit. Then the mass should be bounced to other direction
and <i>omega</i> should get decreased to the half.
</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end InertiaEndstop;
      model InertiaFriction
        import SI = Modelica.SIunits;
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
        parameter SI.Inertia J = 1 "Inertia";
        parameter SI.Torque Mstick = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.Torque Mslip = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter Real vis(unit = "N.s.m/rad") = 0 "viscous friction value" annotation(Dialog(group = "Friction"));
        parameter SI.AngularVelocity wh(min = 0.00000000001) = 0.000001 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter SI.Angle phi_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity omega_init = 0 annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_omega = true annotation(Dialog(group = "Initialization"));
        SI.Angle phi;
        SI.AngularVelocity omega;
        SI.AngularAcceleration a;
        SI.Torque Mfric "total friction";
        SI.Torque deltaM;
        SI.Torque M_stribeck;
      protected
        parameter Real stribeckFactor = DC_Mechlib_SB.Components.Linear.Utilities.stribeckFunction(sticktionMoment, vis, wh);
        Boolean None = if Mstick == 0 and Mslip == 0 then true else false;
        Boolean Stick(start = false, fixed = true);
        Boolean StartSlip(start = false, fixed = true);
        Boolean Slip(start = true, fixed = true);
        constant SI.AngularVelocity velLimit = 0.0000005;
        parameter SI.Torque sticktionMoment = Mstick - Mslip;
      initial equation
        if initialize_phi then
          phi = phi_init;
        end if;
        if initialize_omega then
          omega = omega_init;
        end if;
        assert(Mstick >= Mslip, "The Static friction/Haftreibung should be larger than the Running friction/Coulomb?sche reibung!");
        assert(J > 0, "Negative inertia is not allowed");
      equation
        phi = flange_a.phi;
        flange_a.phi = flange_b.phi;
        omega = der(phi);
        a = der(omega);
        Slip = initial() and abs(omega) > velLimit or pre(StartSlip) and abs(omega) > velLimit or pre(Slip) and abs(omega) > velLimit;
        StartSlip = pre(Stick) and deltaM > Mstick or pre(StartSlip) and not (omega > velLimit or a <= 0 and not omega > 0);
        Stick = initial() and abs(omega) < velLimit or abs(omega) < velLimit / 5 and not (Slip or StartSlip);
        M_stribeck = Mslip * sign(omega) + vis * omega + sticktionMoment * exp(-stribeckFactor * abs(omega)) * sign(omega);
        a = if Stick then 0 else deltaM / J;
        when Stick and not initial() then
                  reinit(omega, 0);
        
        end when;
        Mfric = if Slip and omega > 0 then Mslip else if Slip and omega < 0 then -Mslip else if StartSlip then M_stribeck else 0;
        deltaM = flange_a.tau - flange_b.tau - Mfric;
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{-60,60},{60,-60}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-80,0},{-80,10},{-78,26},{-70,42},{-56,58},{-38,70},{-20,78},{0,80}}, color = {0,0,0}, smooth = Smooth.None),Polygon(points = {{-80,-20},{-86,0},{-74,0},{-80,-20}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-54,48},{52,-48}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "J"),Polygon(points = {{32,56},{42,52},{52,44},{60,32},{66,14},{66,-4},{64,-18},{58,-36},{50,-48},{38,-56},{58,-56},{66,-48},{72,-38},{78,-20},{80,-4},{80,10},{78,24},{72,38},{62,52},{56,56},{32,56}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<P>
This element describes the <i>Stribeck friction characteristics</i> of a rotational mass,
i. e. the frictional force acting between the twisting mass and the fixed racked
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the rotation of a mass to which a frction acts.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>The component simulates the linear friction in the sense of the Stribeck friction. This is composed of the following three frictions:</li>
  <ul>
  <li> the constant Coulomb friction,</li> 
  <li> the speed-proportional viscous friction ,</li> 
  <li> the Stribeck friction (describes the transition from static friction to sliding friction).</li> 
  </ul>
<li>The resulting overall friction force is the sum of the three components</i>  
<li>The parameter <i>vh</i> describes the static velocity limit.</li>
<li>The parameter <i>vis</i> describes the viscous friction value.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>

<p>
<ul>
<li>The parameter <i>static friction</i> must be smaller then the <i>sliding friction</i>.</li>
<li>The parameter <i>J</i> must be greater zero.</li>
<li>The mass is idealized as a point mass, it doesnt have any expansion.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The following picture shows the components of the resulting overall friction torque in the sense of the Stribeck friction.
</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <IMG src=\"modelica://Modelica/Resources/Images/Translational/Stribeck.png\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Stribeck charactaristic</caption>
</table> 
</p>
<p>
The behaviour of the model can be clarified by means of a state diagram with the three states <i>Stick</i>, <i>StartSlip</i> and <i>Slip</i>
(see figure 2). 

</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/statesfrictionRot.jpg\" width=\"800\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 2: </b>state diagram of the friction model</caption>
</table> 
</p>
<p>
Depending on the <i> FrictionMode </i> the angular acceleration and the frictiontorque are calculated in the equation section as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if frictionMode is Stick:<br>
  a = 0;<br>
    Mfric = min(abs(deltaM), Mstick) * sign(deltaM);<br>
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if frictionMode is StartSlip:<br>
  Mfric = Mslip * sign(omega) + vis * omega + sticktionMoment * exp(-stribeckFactor * abs(omega)) * sign(omega);<br>
    a = (deltaM - Mfric) / J;<br>
</td>
</table>
</ul>
</p>

<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if frictionMode is Slip:<br>
  Mfric = Mslip * sign(omega) + vis * omega + sticktionMoment * exp(-stribeckFactor * abs(omega)) * sign(omega);<br>
    a = (deltaM - Mfric) / J;<br>
</td>
</table>
</ul>
</p>

<p>
<h5>Selected variables used in above equations</h5>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>vis</TD><TD VALIGN=\"TOP\">Constant real parameter representing the viscous friction value.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>sticktionMoment</TD><TD VALIGN=\"TOP\">Real variable representing the differenz between static friction and sliding friction.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Mslip</TD><TD VALIGN=\"TOP\">Real parameter representing the sliding friction.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Mfric</TD><TD VALIGN=\"TOP\">Real variable representing the total friction force.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>deltaM</TD><TD VALIGN=\"TOP\">Real variable representing the sum of all incoming moments</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>stribeckFactor</TD><TD VALIGN=\"TOP\">Real variable representing the stribeck factor.</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>frictionMode</TD><TD VALIGN=\"TOP\">Internal integer variable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>J</TD><TD VALIGN=\"TOP\">Parameter Inertia </TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>a</TD><TD VALIGN=\"TOP\">Internal variable representing the acceleration</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>w</TD><TD VALIGN=\"TOP\">Internal variable representing the angular velocity</TD></TR>
</TABLE>
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Inertia, friction</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>MassWithStopAndFriction</p></td>
<td><p>Stop is included aswell / Linear </p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<b><u>10.1 Testcase 1: InertiaFriction with timetable-torque-input signal (for Dymola)</u></b>
</p>
<p>
This testcase checks if the rotation of the inertia is correct for a variable-shaped continous inputtorque.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a InertiaFriction block, a torque block and a timetable block (the latter two taken from the MSL).
The output of the timetable blocks is connected with the input of the force block, while the force block output is connected 
with the InertiaFriction input.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p> 
<u>timetable</u>:<br>
table=[0, 50; 0.1, 0; 1, 0]<br>
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
InertiaFriction: flange_a  <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start with 0 and raise steeply while a moment is acting. Then the Inertia is decelerated by the friction torque, which acts in the opposed direction of the rotation. 
Once the velocity is smaller then a defined limit and all external torques are smaller then the static moment, the mass stops.<br><br>
</p>

<b><u>10.2 Testcase 2: InertiaFriction with initial velocity (for Dymola)</u></b>
</p>
<p>
This testcase checks if the rotation of the mass with initial velocity is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains only a InertiaFriction block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p> 
<u>InertiaFriction</u>:<br>
initialize_phi = true <br>
initialize_omega = true <br>
omega_init = 180 deg/s<br>
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
InertiaFriction: flange_a  <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start with 0 and start velocity of 180 deg/s. The velocity of the mass is decelerated by the friction torque, which acts in the opposed direction of the rotation. 
Once the velocity is smaller then a defined limit and all external moments are smaller then the static moment (no external torque in this case), the mass stops.
</p>

<h4>11. Implementation details</h4>
In the implementation are no particularities.

<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end InertiaFriction;
      model InertiaFrictionEndstop
        import SI = Modelica.SIunits;
        final constant Real pi = 2 * Modelica.Math.asin(1.0);
        parameter SI.Inertia J = 1 "Inertia";
        parameter SI.Torque Mstick = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.Torque Mslip = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter Real vis(unit = "N.s.m/rad") = 0 "viscous friction value in Nsm/grad " annotation(Dialog(group = "Friction"));
        parameter SI.AngularVelocity wh(min = 0.00000000001) = 0.000001 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter SI.Angle lowcont = -pi "Lower contact" annotation(Dialog(group = "Hard stop"));
        parameter SI.Angle upcont = pi "Upper contact" annotation(Dialog(group = "Hard stop"));
        parameter Real restitutionCoefficient(min = 5, max = 100) = 5 "damping constant" annotation(Dialog(group = "Hard stop"));
        parameter SI.Angle phi_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity omega_init = 0 annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = true annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_omega = true annotation(Dialog(group = "Initialization"));
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
        SI.Angle phi;
        SI.AngularVelocity w(stateSelect = StateSelect.always);
        SI.AngularAcceleration a;
        SI.Torque deltaM;
        SI.Torque Mfric "total friction";
        SI.Torque M_stribeck;
        parameter Real stribeckFactor = DC_Mechlib_SB.Components.Linear.Utilities.stribeckFunction(sticktionMoment, vis, wh);
        constant SI.AngularVelocity velLimit = 0.0000005;
        parameter SI.Torque sticktionMoment = Mstick - Mslip;
        SI.AngularVelocity wReachContact = 0.00001;
        SI.AngularVelocity wLeaveContact = 0.00005;
        Real stosszahl = 1 - restitutionCoefficient / 100;
        Boolean Contact_up(start = false, fixed = true);
        Boolean Contact_down(start = false, fixed = true);
        Boolean Free(start = true, fixed = true);
        Boolean Stiction(start = false, fixed = true);
        Boolean Slip(start = true, fixed = true);
        Boolean StartSlip(start = false, fixed = true);
      initial equation
        if initialize_phi then
          phi = phi_init;
        end if;
        if initialize_omega then
          w = omega_init;
        end if;
      initial algorithm
        assert(upcont > lowcont, "The upper limit must be grater then the lower limit.");
        assert(phi <= upcont, "The initial position must be smaller than or equal to the upper limit.");
        assert(phi >= lowcont, "The initial position must be greater than or equal to the lower limit.");
        assert(J > 0, "Negative mass is not allowed");
      equation
        when (Contact_up or Contact_down) and not initial() and not Stiction then
                  reinit(w, -stosszahl * w);
        
        end when;
        when Stiction and not initial() and not (Contact_up or Contact_down) then
                  reinit(w, 0);
        
        end when;
        //        States        //
        Slip = initial() and abs(w) > velLimit or pre(StartSlip) and abs(w) > velLimit or pre(Slip) and abs(w) > velLimit;
        StartSlip = pre(Stiction) and deltaM > Mstick or pre(StartSlip) and not (w > velLimit or a <= 0 and not w > 0);
        Stiction = not (Slip or StartSlip);
        Contact_up = initial() and flange_a.phi >= upcont or pre(Free) and flange_a.phi > upcont and w > wReachContact;
        Contact_down = initial() and flange_a.phi <= lowcont or pre(Free) and lowcont > flange_a.phi and -w > wReachContact;
        Free = initial() or pre(Contact_up) and (abs(w) > wLeaveContact or deltaM < 0) or pre(Contact_down) and (abs(w) > wLeaveContact or deltaM > 0) or pre(Free) and flange_a.phi < upcont or flange_a.phi > lowcont;
        //                      //
        a = if Contact_up then 0 else if Contact_down then 0 else deltaM / J;
        M_stribeck = Mslip * sign(w) + vis * w + sticktionMoment * exp(-stribeckFactor * abs(w)) * sign(w);
        Mfric = if Slip and w > 0 then Mslip else if Slip and w < 0 then -Mslip else if StartSlip then M_stribeck else 0;
        deltaM = flange_a.tau - flange_b.tau - Mfric;
        phi = flange_a.phi;
        w = der(flange_a.phi);
        a = der(w);
        flange_a.phi = flange_b.phi;
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{-60,60},{60,-60}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-80,0},{-80,10},{-78,26},{-70,42},{-56,58},{-38,70},{-20,78},{0,80}}, color = {0,0,0}, smooth = Smooth.None),Polygon(points = {{-80,-20},{-86,0},{-74,0},{-80,-20}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-54,48},{52,-48}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "J"),Polygon(points = {{-48,-36},{-36,-48},{-52,-64},{-64,-52},{-48,-36}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Polygon(points = {{0,-64},{-16,-90},{16,-90},{0,-64}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-14,-90},{-18,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{10,-90},{6,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{4,-90},{0,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-2,-90},{-6,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-8,-90},{-12,-96}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{16,-90},{12,-96}}, color = {0,0,0}, smooth = Smooth.None),Polygon(points = {{32,56},{42,52},{52,44},{60,32},{66,14},{66,-4},{64,-18},{58,-36},{50,-48},{38,-56},{58,-56},{66,-48},{72,-38},{78,-20},{80,-4},{80,10},{78,24},{72,38},{62,52},{56,56},{32,56}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {135,135,135}, fillPattern = FillPattern.Solid)}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<P>
This element describes the <i>Stribeck friction characteristics</i> of a rotating mass between two defined contact,
The mass have a rotational degree of freedom. 
Sign convention: A positive torque at flange_a turns the rotating mass in the positive direction. A negative torque at flange_a turns the mass to the negative direction. 
The model is a combination of the componets <i>InertiaEndstop</i> and <i>InertiaFriction<i/>.

</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the rotation of a mass with frction inside a defined range .
</p>

<h4>3. Features</h4>
<p> For all features, options, limits, and equations see the documentations of the used components <i>massEndstop</i> and <i>massFriction<i/>.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Inertia, friction, hard stop</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>MassWithStopAndFriction</p></td>
<td><p>optional heatport / translational</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: InertiaFrictionEndstop with initial position and initial velocity (for Dymola)</u></b>
</p>
<p>
This testcase checks if the rotation of the mass with initial position and initial velocity is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel only contains InertiaFrictionEndstop block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>InertiaFrictionEndstop</u>:<br>
 vis = 0.1 Nsm/rad<br>
 restitutionCoefficient = 25<br>
 gravity = 0<br>
 initialize_phi = true<br> 
 initialize_omega = true<br> 
 phi_init = 180 deg<br>
 omega_init = 360 deg/s <br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
InertiaFrictionEndstop: flange_a  <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at 180 deg (phi_init = 180) and a start velocity of 360 deg/s (omega_init = 360). <s>phi</s> descreases until it reachs the lower limit, there the velocity have to chance direction.
After the bounce the velocity of the mass get to small through the friction and the element stops at a certain point.
</p>
<p>
<b><u>10.2 Testcase 2: InertiaFrictionEndstop with different torques on both flanges (for Dymola)</u></b>
</p>
<p>
This testcase checks if the movenment of the mass is correct for a pulse-shaped continous inputforce.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a massFrictionEndstop block, a force block and a pulse block (the latter two taken from the MSL).
The output of the pulse blocks is connected with the input of the force block, while the force block output is connected 
with the massFrictionEndstop input.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>

<u>pulse</u>:<br>
amplitude = 50<br> 
period = 1<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 2s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
massFrictionEndstop: flange_a  <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start with 0 and raise to the upper limit. Then the mass should be bounced to other direction, then it get moved again to the upper limit, because the pulse-shaped force still acts
When the pulse block dont create any force the velocity gets deccelerated by the friction. When the new period of the pulse function begin, the movenment will repeat in a similar way.
</p>

<h4>11. Implementation details</h4>
<P> 
For details see the documentations of the used components.
</p>

<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>


</HTML>"));
      end InertiaFrictionEndstop;
      model InertiaVaraible
        import SI = Modelica.SIunits;
        parameter SI.Angle phi_init = 0 "initial Angle" annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity w_init = 0 "initial Revolution" annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = false annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_w = false annotation(Dialog(group = "Initialization"));
        SI.Angle phi;
        SI.AngularVelocity omega;
        SI.AngularAcceleration a;
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
        Modelica.Blocks.Interfaces.RealInput J(unit = "kg.m2") annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {0,106})));
      initial equation
        if initialize_phi then
          phi = phi_init;
        end if;
        if initialize_w then
          omega = w_init;
        end if;
      equation
        assert(J > 0, "Negative inertia is not allowed");
        phi = flange_a.phi;
        flange_a.phi = flange_b.phi;
        omega = der(phi);
        a = der(omega);
        J * a = flange_a.tau + flange_b.tau;
        annotation(Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{-60,60},{60,-60}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{-80,0},{-80,10},{-78,26},{-70,42},{-56,58},{-38,70},{-20,78},{0,80}}, color = {0,0,0}, smooth = Smooth.None),Polygon(points = {{-80,-20},{-86,0},{-74,0},{-80,-20}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-54,48},{52,-48}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "J")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component represents a mass with a rotational degree of freedom. The value of the inertia is a real input. 
Sign convention: A positive torque at flange_a turns the mass in the positive direction. A negative torque at flange_a turns the mass to the negative direction. 
</p>

<h4>2. Application area</h4>
<p>
Use this model to simulate the rotation of a variable inertia.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>Using the initialization parameters, the start condiction can be set.</li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The value of the real input signal <i>J</i> must be greater zero.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
phi = flange_a.phi;<br>
  flange_a.phi = flange_b.phi;<br>
  omega = der(phi);<br>
  a = der(omega);<br>
  J * a = flange_a.tau + flange_b.tau;<br>
</td>
</table>
</ul>
</p>



<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Inertia, additional</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Inertia</p></td>
<td><p>Model from the MSL; Inertia is parameter)</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Variable inertia with constant moment</u></b>
</p>
<p>
This testcase checks if the rotation of the changing mass is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a TorqueConstant-, a step- and a InertiaVariable-block. The positive flange of the torque is connected with flange_a of the inertia.
The negative moment acts on the clamp. The stepblock forms the inertia of the mass.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>

<u>MomentConstant</u>:<br>
Torque = 5 Nm<br>
<u>step</u>:<br>
height = 9 <br>
offset = 1<br>
startTime = 0.5 s<br>
 

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
InertiaVariable: flange_a <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at 0 and adept an acceleration of 5 rad/s^2. After the step at 0.5 the inertia gets ten times heavier, so the accelertion should jump to a tenth part.
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end InertiaVaraible;
      model RackandPin "rotatory to linear"
        import SI = Modelica.SIunits;
        final constant Real pi = 2 * Modelica.Math.asin(1.0);
        parameter SI.Length Radius = 0.5 "Gearwheel radius";
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange_T annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_R annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Rotational.Components.IdealGearR2T idealGearR2T(ratio = 1 / Radius) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(flange_R,idealGearR2T.flangeR) annotation(Line(points = {{-100,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(idealGearR2T.flangeT,flange_T) annotation(Line(points = {{10,0},{100,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics), Icon(graphics = {Ellipse(extent = {{60,-60},{-60,60}}, lineColor = {0,0,0}),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Ellipse(extent = {{-8,8},{8,-8}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-80,-60},{80,-70}}, lineColor = {0,0,0}),Line(points = {{-86,-72},{88,-72}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-80,-72},{-88,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{80,-72},{72,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{60,-72},{52,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{40,-72},{32,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{20,-72},{12,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{0,-72},{-8,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-20,-72},{-28,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-40,-72},{-48,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-60,-72},{-68,-84}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-20,-20},{20,-20}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{0,-8},{-8,-20},{-16,-28}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{0,-8},{8,-20},{0,-28}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
The component simulates a rack and pinion gear. 

</p>

<h4>2. Application area</h4>
<p>
Use this component to convert angular movements into linear movements.
</p>

<h4>3. Features</h4>
<p>
By defining the Gearwheel radius, its possible to set the propotion between linear and angular movements.
</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The model is taken from the MSL.
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Rack and Pinion</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>IdealRollingWheel</p></td>
<td><p>Component from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Transform a given rotational movement into a linear.</u></b>
</p>
<p>
This testcase checks if the movenment is transformed correctly.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Ramp-, a Angle- and a RackandPin-Block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>ramp</u>:<br>
duration = 1<br>
height = 360<br>
<u>Angle</u>:<br>
unit = &quot;grad&quot;<br>
<u>RackandPin</u>:<br>
Radius = 0.5 m;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
RackandPin: flange_T <i>s</i>
RackandPin: flange_R <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> and <i>phi</i> should start at 0 and raise straightly. <i>s</i> should reach 3.14(pi) <i>m</i> and phi should reach 360 <i>grad</i> at time 1.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end RackandPin;
      model Revolution
        import SI = Modelica.SIunits;
        parameter String unit = "rad/s" annotation(choices(choice = "rad/s", choice = "rad/min", choice = "rpm", choice = "deg/s"));
        parameter SI.Angle phi_init = 0 "Initial angular velocity" annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = false annotation(Dialog(group = "Initialization"));
        final constant Real pi = 2 * Modelica.Math.asin(1.0);
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput omega annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
        Modelica.Mechanics.Rotational.Sources.Speed speed(exact = if initialize_phi then false else true, f_crit = 10000, phi(start = if initialize_phi then phi_init else 0)) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        if unit == "rad/s" then
          speed.w_ref = omega;
        elseif unit == "rad/min" then
          speed.w_ref = omega / 60;
        elseif unit == "rpm" then
          speed.w_ref = omega * 2 * pi / 60;
        elseif unit == "deg/s" then
          speed.w_ref = omega * pi / 180;
        else
          speed.w_ref = omega;
        end if;
        connect(speed.flange,flange_b) annotation(Line(points = {{10,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Rectangle(extent = {{-50,70},{50,-70}}, lineColor = {0,0,0}),Text(extent = {{-40,52},{42,-40}}, lineColor = {0,0,0}, textStyle = {TextStyle.Bold}, textString = "?")}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This block supplies a angular velocity corresponding to the signal input
</p>

<h4>2. Application area</h4>
<p>
Common angular velocity specification.
</p>

<h4>3. Features</h4>
<p>
Using the <i>unit</i> parameter, the unit of the specified signal can be set. By setting the parameter <i> initialize_phi<i> u can decide about a start angle.

</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The behavior is defined by the equation:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
speed.w_ref = omega;
</td>
</table>
</ul>
</p>
<p>
Note: No exact velocity values at start, if initial angle is given.
</p>
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Revolution</i>. 
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>Speed</p></td>
<td><p>Model from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Velocity allegation.</u></b>
</p>
<p>
This testcase checks if predefined revolution is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Ramp-, a Revolution-block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>ramp</u>:<br>
duration = 1<br>
<u>Revoltion</u>:<br>
initialize_phi = true <br>
phi_init = 90 grad <br>
unit = &quot;rad/s&quot;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 0.1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Velocity: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 90 deg. The velocity should raise in the same way the ramp increases.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Revolution;
      model SpringDamper
        import SI = Modelica.SIunits;
        parameter SI.RotationalSpringConstant c = 100 "spring-constant";
        parameter SI.RotationalDampingConstant d = 1 "dampingconstant";
        parameter SI.Torque TorqueStart = 0 "Preload";
        parameter SI.Angle idl_str = 0.1 "Idle stroke";
        SI.Angle phi "actual lenght";
        SI.Angle x "spring expansion";
        SI.AngularVelocity w "spring velocity";
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        SI.Angle phi0 "unstreched lenght";
      equation
        when initial() then
                  phi0 = flange_b.phi - flange_a.phi - TorqueStart / c;
        
        end when;
        phi = flange_b.phi - flange_a.phi;
        w = der(phi);
        x = phi - phi0;
        flange_a.tau = -flange_b.tau;
        if abs(x) > abs(idl_str) then
          flange_b.tau = sign(x) * c * (abs(x) - abs(idl_str)) + d * w;
        else
          flange_b.tau = 0;
        end if;
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-40,50},{-60,50},{-60,-50},{-48,-50},{-48,-42}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-48,-38},{8,-64}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{8,-38},{16,-38}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-64},{16,-64}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-52},{60,-52},{60,50},{40,50}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{40,50},{36,30},{26,70},{16,30},{6,70},{-4,30},{-14,70},{-24,30},{-34,70}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,70},{-40,50}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component represents a linear spring-damper characteristics.
</p>

<h4>2. Application area</h4>
<p>
Use this model to calculate the resulting spring moment.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>Use the <i> Preload </i> parameter to simulate a bias</li>
<li> Inside the idle stroke no torque results from the spring </li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
The idle stroke (L) is the stroke the component can rotate without creating any torque. The idle stroke is on both sides of the spring mounting position. For a mounting position of 20 degrees and an idle stroke of 1 degree there is no torque for the range from 19 to 21 degrees.
The result size Spring angle, absolute (?ges ) is calculated by the angular difference of the two couplings and indicates the actual rotation of the spring.
The cantilever (?rel ) indicates how much the spring is twisted relative to the mounting position.
Note: The spring has no tension in the idle stroke range. The cantilever for the whole idle stroke is zero.


The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
phi = flange_b.phi - flange_a.phi;<br>
  w = der(phi);<br>
  x = phi - phi0;<br>
  flange_a.tau = - flange_b.tau;<br>
</td>
</table>
</ul>
</p>
<p>
Depending on the angle and the value of the idle stroke the springtorque is calculated in the equation part as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 if abs(x) > abs(idl_str) then<br>
     flange_b.tau = sign(x)* c * (abs(x) - abs(idl_str)) + d * w;<br>
   else<br>
     flange_b.tau = 0;<br>
   end if;<br>

</td>
</table>
</ul>
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Spring-Damper, rotatory</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>SpringDamper</p></td>
<td><p>Model from the MSL (Parameter, srel0 instead of idlestroke and preload force)</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Clamped SpringDamper connected with a Inertia</u></b>
</p>
<p>
This testcase checks if the movenment of the damped mass is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a clamp-, a SpringDamper- and a Inertia-block. The flange_a of the spring is connected with the clamp and the other flange is connected with the Inertia.
The Inertia starts with a angular veocity of 6 rad/s.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>Inertia</u>:<br>
initialize_phi = true;<br>
initialize_w = true;<br>
s_init = 0 rad;<br>
v_init = 6 rad/s<br>

<u>SpringDamper</u>:<br>
c = 1000 nm/rad;<br>
d = 10 Nms/rad;<br>
idl_str = 0.5 rad;<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 10s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
SpringDamper: flange_b <i>phi</i>
      flange_b <i>tau</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at the initial angle of 0 and a start velocity of 6 rad/s. The springforce should be zero until the inertia-angle is higher then the idle stroke.
The acting torque should raise with the angle and force the mass to rotate into the other direction. This proccess should repeat with a lower amplitude (depending on the damping constant).
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Further implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end SpringDamper;
      model SpringDamperKomplex
        import SI = Modelica.SIunits;
        parameter SI.RotationalSpringConstant c = 100 "spring-constant";
        parameter SI.RotationalDampingConstant d = 1 "dampingconstant";
        parameter SI.Angle phi0 = 1 "unstreched lenght";
        parameter SI.Angle idl_str = 0.1 "Idle stroke";
        SI.Angle phi "actual lenght";
        SI.Angle x "spring expansion";
        SI.AngularVelocity w "spring velocity";
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        SI.Torque TorqueStart "Preload";
      equation
        when initial() then
                  TorqueStart = c * (flange_b.phi - flange_a.phi - phi0);
        
        end when;
        phi = flange_b.phi - flange_a.phi;
        w = der(phi);
        x = phi - phi0;
        flange_a.tau = -flange_b.tau;
        if abs(x) > abs(idl_str) then
          flange_b.tau = sign(x) * c * (abs(x) - abs(idl_str)) + d * w;
        else
          flange_b.tau = 0;
        end if;
        annotation(Diagram(graphics), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-40,50},{-60,50},{-60,-50},{-48,-50},{-48,-42}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-48,-38},{8,-64}}, lineColor = {0,0,0}, fillColor = {135,135,135}, fillPattern = FillPattern.Solid),Line(points = {{8,-38},{16,-38}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-64},{16,-64}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{8,-52},{60,-52},{60,50},{40,50}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{40,50},{36,30},{26,70},{16,30},{6,70},{-4,30},{-14,70},{-24,30},{-34,70}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-34,70},{-40,50}}, color = {0,0,0}, smooth = Smooth.None)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component represents a linear spring-damper characteristics.
</p>

<h4>2. Application area</h4>
<p>
Use this model to calculate the resulting spring torque.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>Use the <i> Preload </i> parameter to simulate a bias</li>
<li> Inside the idle stroke no moment results from the spring </li>
</ul>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
The idle stroke (L) is the stroke the component can rotate without creating any torque. The idle stroke is on both sides of the spring mounting position. For a mounting position of 20 degrees and an idle stroke of 1 degree there is no torque for the range from 19 to 21 degrees.
The result size Spring angle, absolute (?ges ) is calculated by the angular difference of the two couplings and indicates the actual rotation of the spring.
The cantilever (?rel ) indicates how much the spring is twisted relative to the mounting position.
Note: The spring has no tension in the idle stroke range. The cantilever for the whole idle stroke is zero.

The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
phi = flange_b.phi - flange_a.phi;<br>
   w = der(phi);<br>
   x = phi - phi0;<br>
   flange_a.tau = - flange_b.tau;<br>
</td>
</table>
</ul>
</p>
<p>
Depending on the angle and the value of the idle stroke the springtorque is calculated in the equation part as follows:
</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 if abs(x) > abs(idl_str) then<br>
     flange_b.tau = sign(x)* c * (abs(x) - abs(idl_str)) + d * w;<br>
   else<br>
     flange_b.tau = 0;<br>
   end if;<br>
</td>
</table>
</ul>
</p>

<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Spring-Damper, complex, rotatory</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>SpringDamper</p></td>
<td><p>Model from the MSL (Parameter, srel0 instead of idlestroke and preload force)</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Clamped SpringDamper connected with a inertia</u></b>
</p>
<p>
This testcase checks if the rotation of the damped inertia is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a SpringDamperKomplex- and a Inertia-block. The flange_a of the spring is connected with the clamp and the other flange is connected with the inertia.
The inertia starts with a veocity of 6 rad/s.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>Inertia</u>:<br>
initialize_phi = true;<br>
initialize_w = true;<br>
s_init = 0 rad;<br>
v_init = 6 rad/s<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 10s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
SpringDamperKomplex: flange_b <i>phi</i>
      flange_b <i>tau</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at the initial position of 0 and a start velocity of 6 rad/s. The springtorque should be zero until the inertia-angle is lower then the idle stroke.
The acting moment should raise with the angle and force the inertia to rotate in the other direction. This proccess should repeat with a lower amplitude (depending on the damping constant).
</p>


<h4>11. Implementation details</h4>
<p>
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Further implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end SpringDamperKomplex;
      model TorqueConstant
        import SI = Modelica.SIunits;
        parameter Real Torque;
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
        Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport = false) annotation(Placement(transformation(extent = {{4,-10},{24,10}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y = Torque) annotation(Placement(transformation(extent = {{-78,42},{-58,62}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport = false) annotation(Placement(transformation(extent = {{-20,-10},{-40,10}})));
        Modelica.Blocks.Math.Gain gain(k = -1) annotation(Placement(transformation(extent = {{-36,18},{-16,38}})));
      equation
        connect(torque.flange,flange_b) annotation(Line(points = {{24,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torque1.flange,flange_a) annotation(Line(points = {{-40,0},{-100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(realExpression.y,torque.tau) annotation(Line(points = {{-57,52},{2,52},{2,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(gain.u,realExpression.y) annotation(Line(points = {{-38,28},{-42,28},{-42,52},{-57,52}}, color = {0,0,127}, smooth = Smooth.None));
        connect(gain.y,torque1.tau) annotation(Line(points = {{-15,28},{-18,28},{-18,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(choices(choice = "N", choice = "kN", choice = "dyn", choice = "kp", choice = "pdl", choice = "lbf", choice = "yd"), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-84,40},{-58,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Text(extent = {{-24,76},{24,12}}, lineColor = {0,0,0}, lineThickness = 0.5, fillPattern = FillPattern.Solid, textString = "M"),Line(points = {{58,40},{82,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Line(points = {{70,50},{70,26}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Polygon(points = {{10,2},{10,-2},{70,-2},{70,-10},{80,0},{70,10},{70,2},{10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{-10,2},{-10,-2},{-70,-2},{-70,-10},{-80,0},{-70,10},{-70,2},{-10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component describes an active torque. It outputs the torque entered in the parameter <i> Torque </i> at coupling B with a positive sign and at coupling A with a negative sign.
</p>

<h4>2. Application area</h4>
<p>
Use this component to strain a certain moment to other rotational components.
</p>

<h4>3. Features</h4>
<p>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
Both flanges have to be connected.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
Modelling contains the torque block from the MSL, which is connected with the flanges.
The flange_b.f complies the parameter <i>Torque</i> in Nm, where <i>Torque</i> is a real expression.
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
torque.tau = Torque;
</td>
</table>
</ul>
</p>

</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Torque, constant</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>torque</p></td>
<td><p>Component from the MSL</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Torque acting on clamp and Inertia.</u></b>
</p>
<p>
This testcase checks if the rotational movenment of a Inertia with a constant acting moment is correct.
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a TorqueConstant- and a Inertia-block. The positive flange of the torque is connected with flange_a of the Inertia.
The negative torque acts on the clamp.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>TorqueConstant</u>:<br>
Torque = 10 Nm<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 1s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Inertia: flange_a <i>tau</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>tau</i> should start at 0 and raise with a constant positive acceleration.
</p>
</p>


<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end TorqueConstant;
      model TorqueVariable
        import SI = Modelica.SIunits;
        Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {0,100})));
        extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;
        Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport = true) annotation(Placement(transformation(extent = {{4,-10},{24,10}})));
      equation
        connect(torque.support,flange_a) annotation(Line(points = {{14,-10},{-44,-10},{-44,0},{-100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torque.flange,flange_b) annotation(Line(points = {{24,0},{100,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torque.tau,u) annotation(Line(points = {{2,0},{0,0},{0,100},{0,100}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(choices(choice = "N", choice = "kN", choice = "dyn", choice = "kp", choice = "pdl", choice = "lbf", choice = "yd"), Icon(graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Line(points = {{-84,40},{-58,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Text(extent = {{-24,76},{24,12}}, lineColor = {0,0,0}, lineThickness = 0.5, fillPattern = FillPattern.Solid, textString = "M"),Line(points = {{58,40},{82,40}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Line(points = {{70,50},{70,26}}, color = {0,0,0}, thickness = 0.5, smooth = Smooth.None),Polygon(points = {{10,2},{10,-2},{70,-2},{70,-10},{80,0},{70,10},{70,2},{10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Polygon(points = {{-10,2},{-10,-2},{-70,-2},{-70,-10},{-80,0},{-70,10},{-70,2},{-10,2}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
Common torque specification. This component allows to apply any moment on a mechanical rotational connection.
The signal at the input is applied to the flange_b with the selected unit. On the flange_a acts the corresponding countertorque with a negative sign.
</p>

<h4>2. Application area</h4>
<p>
Use this component to strain a variable torque to other rotational components.
</p>

<h4>3. Features</h4>
<p>
</p>

<h4>4. Model assumptions and limits</h4>
<p>
Both flanges have to be connected.
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
Modelling contains the torque block of the MSL.
The flange_b.tau complies the parameter <i>u</i> in a torque with the unit Nm, where <i>u</i> is a real input.


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Torque, variable</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>torque</p></td>
<td><p>Component from the MSL </p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">no</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a TorqueVariable-, a step- and a Inertia-block. The positive flange of the moment is connected with flange_a of the Inertia.
The negative torque acts on the clamp. The stepblock forms the shape of the torque.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>step</u>:<br>
height = 10<br>
offset = -5<br>
startTime = 0.5 s<br>

 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 2s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Inertia: flange_a <i>phi</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>phi</i> should start at 0 and fall with a constant negative angular acceleration of 5 m/s^2. After the step the acceleration should change to +5 and forces the Inertia to spin into the positive direction.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
No exceptional implematation.
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>10/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end TorqueVariable;
      model Winch
        import SI = Modelica.SIunits;
        parameter SI.Inertia J = 1 "Inertia";
        parameter SI.Torque Mslip = 5 "sliding friction" annotation(Dialog(group = "Friction"));
        parameter SI.Torque Mstick = 10 "static friction" annotation(Dialog(group = "Friction"));
        parameter SI.AngularVelocity wh = 0 "static velocity limit" annotation(Dialog(group = "Friction"));
        parameter Real vis(unit = "N.s.m/rad") = 0 "viscous friction value" annotation(Dialog(group = "Friction"));
        parameter SI.Angle phi_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity omega_init = 0 annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = false annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_omega = false annotation(Dialog(group = "Initialization"));
        parameter SI.Length Radius = 1 "Diameter";
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        InertiaFriction inertiaFriction(J = J, Mslip = Mslip, vis = vis, phi_init = phi_init, omega_init = omega_init, initialize_phi = initialize_phi, initialize_omega = initialize_omega, Mstick = Mstick, wh = wh) annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        RackandPin rackandPin(Radius = Radius) annotation(Placement(transformation(extent = {{20,-10},{40,10}})));
      equation
        connect(flange_b,inertiaFriction.flange_a) annotation(Line(points = {{-100,0},{-50,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(inertiaFriction.flange_b,rackandPin.flange_R) annotation(Line(points = {{-30,0},{20,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(rackandPin.flange_T,flange_a) annotation(Line(points = {{40,0},{100,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Icon(graphics = {Rectangle(extent = {{-100,70},{-96,-70}}, lineColor = {0,0,0}),Rectangle(extent = {{96,70},{100,-70}}, lineColor = {0,0,0}),Rectangle(extent = {{-96,40},{96,-40}}, lineColor = {0,0,0}),Line(points = {{-96,-18},{-88,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-96,28},{-70,-42}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-50,-40},{-80,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{50,-40},{20,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{30,-40},{0,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{10,-40},{-20,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-10,-40},{-40,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-30,-40},{-60,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{90,-40},{60,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{70,-40},{40,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{80,40},{96,-4}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Polygon(points = {{-60,72},{-60,68},{50,68},{50,60},{60,70},{50,80},{50,72},{-60,72}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Diagram(graphics), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component simulates a winch, which converts a rotary motion into a tensile movement. 
</p>

<h4>2. Application area</h4>
<p>
Use this component to simulate the convertion between linear and rotatorial movement
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>By defining the radius, its possible to set the propotion between linear and angular movements.</li>
<li>The torques acting on the roll are calculated from the forces acting on the mechanical flange.</li>
<li>A positive forces correspond to a pulling at the roll and thus provide for a positive torque at flange_a</li>
<li>The total of the two torques  at the rotational flange result in the total torque acting on the roll and being responsible for its rotation.</li>
<li>This rotation can still be counteracted by means of Coulomb and viscous friction.</li>
</ul>
The friction is implementated by the mean of stribeck-friction. For further explanation see the documentation of <i>InertiaFriction</i>.
</p>


<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The parameter <i>J</i> must be greater zero.</li>
<li>The mass is idealized as a point mass, it doesnt have any expansion.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
The model is a combination of the components <i>RackandPin</i> and <i>InertiaFriction</i>, both taken from the DC_Mechlib.
For Modelling details and equations see the documentations of both.
</p>


<h4>7. Model validation</h4>
<p>
The model is validated to the Rexroth Simster component <i>Winch</i>.
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: CableReel with a constant torque and variable force</u></b>
</p>
<p>
This testcase checks if the rotation and transformation is calculated correctly
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a two Clamp-, a ToqreConstant-, a ForceVariable, a step and a Winch-Block.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>step</u>:<br>
startTime = 0.5<br>
height = -5<br>
<u>Winch</u>:<br>
Mslip = 1 Nm;<br>
<u>TorqueConstant</u>:<br>
Torque = 5 Nm;<br>
 
<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Winch: flange_a <i>s</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>s</i> should start at 0 and raise with a constant acceleration. Until the force acting on flange_a is zero only the friction is counteracting the rotation.
The force acts against the moment, because of a the propotion through the given radius the overall torque is zero. The cable reel gets decelerated by the friction until it stops.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end Winch;
      model WinchKomplex
        import SI = Modelica.SIunits;
        import Modelica.Constants.pi;
        parameter SI.Radius r0 "initial radius Winch" annotation(Dialog(group = "Winch"));
        parameter SI.Mass m0 "initial mass Winch" annotation(Dialog(group = "Winch"));
        parameter SI.Density rho "thickness rope" annotation(Dialog(group = "Rope"));
        parameter SI.Diameter d "diameter rope" annotation(Dialog(group = "Rope"));
        parameter Real a "Increase in radius Winch per rad" annotation(Dialog(group = "Winch"));
        parameter SI.Angle phi_init = 0 annotation(Dialog(group = "Initialization"));
        parameter SI.AngularVelocity w_init = 0 annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_phi = false annotation(Dialog(group = "Initialization"));
        parameter Boolean initialize_w = false annotation(Dialog(group = "Initialization"));
        SI.Radius r "radius Winch";
        SI.Mass m "mass of Winch";
        SI.Inertia J "Inertia Winch";
        SI.Velocity v;
        SI.AngularVelocity omega;
        Real p;
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
        Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = -90, origin = {0,110})));
      initial equation
        if initialize_phi then
          flange_b.phi = phi_init;
        end if;
        if initialize_w then
          omega = w_init;
        end if;
      equation
        assert(m0 > 0, "Negative initial mass is not allowed");
        assert(r0 > 0, "Negative initial radius is not allowed");
        assert(d > 0, "Negative diameter is not allowed");
        assert(rho > 0, "Negative thickness is not allowed");
        r = r0 + a * flange_b.phi;
        flange_a.s = r * flange_b.phi;
        v = (r0 + 2 * a * flange_b.phi) * omega;
        omega = der(flange_b.phi);
        p = r0 + 2 * a * flange_b.phi;
        m = m0 + pi * d ^ 2 * r * flange_b.phi * rho / 4;
        if flange_a.f > 0 then
          J = m * r ^ 2 / 2 + u * p ^ 2;
          flange_b.tau = flange_a.f * p - 2 * u * p * a * omega ^ 2;
        else
          J = 0;
          flange_b.tau = 0;
        end if;
        annotation(Icon(graphics = {Rectangle(extent = {{-100,70},{-96,-70}}, lineColor = {0,0,0}),Rectangle(extent = {{96,70},{100,-70}}, lineColor = {0,0,0}),Rectangle(extent = {{-96,40},{96,-40}}, lineColor = {0,0,0}),Line(points = {{-96,-18},{-88,-40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-96,28},{-70,-42}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-50,-40},{-80,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{50,-40},{20,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{30,-40},{0,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{10,-40},{-20,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-10,-40},{-40,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{-30,-40},{-60,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{90,-40},{60,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{70,-40},{40,40}}, color = {0,0,0}, smooth = Smooth.None),Line(points = {{80,40},{96,-4}}, color = {0,0,0}, smooth = Smooth.None),Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,0}),Polygon(points = {{-60,72},{-60,68},{50,68},{50,60},{60,70},{50,80},{50,72},{-60,72}}, lineColor = {0,0,0}, smooth = Smooth.None, fillColor = {0,0,0}, fillPattern = FillPattern.Solid)}), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>

<h4>1. Model description</h4>
<p>
This component simulates a winch, which converts a rotary motion into a tensile movement. 
</p>

<h4>2. Application area</h4>
<p>
The rope connected to the winch changes its length depending on the rotational direction of the winch. The winds is comparable to the rotational-translational gear.
</p>

<h4>3. Features</h4>
<p>
<ul>
<li>By defining the initial radius, its possible to set the propotion between linear and angular movements.</li>
<li>The initial mass is described by <i>m0</i>.
<li>The torques acting on the roll are calculated from the forces acting on the mechanical flange.</li>
<li>A positive forces correspond to a pulling at the roll and thus provide for a positive torque at flange_a</li>
<li>The total of the two torques  at the rotational flange result in the total torque acting on the roll and being responsible for its rotation.</li>
<li>The rope is described by the parameter <i>rho</i> (thickness) and <i>d</i> (diameter)</li>
<li>The increase in radius through furling is set by <i>a</i>
</ul>
</p>


<h4>4. Model assumptions and limits</h4>
<p>
<ul>
<li>The parameter <i>m0</i>, <i>r0</i>, <i>rho</i> and <i>d</i> must be greater zero.</li>
<li>The mass is idealized as a point mass, it doesnt have any expansion.</li>
</ul>
</p>

<h4>5. Solver settings</h4>
<p>
It is recommended to use the Dassl solver with a solver tolerance of 1e-6 or below.
</p>

<h4>6. Modelling details and equations</h4>
<p>
If the winds turns to the left (flange_b.phi positive), the length of the rope decreases and the winch radius increases. When the winds is turning to the right (flange_b.phi negative), 
length of the rope increases and the radius of the cable drum gets reduces.
In addition, the cable can only afford traction, but not compressive force. Fout> 0 means a pulling force.

<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/winch.jpg\" width=\"825\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Real winch and approximation into signals.</caption>
</table> 
</p>

</p>
The behavior is defined by the equations:
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
 r = r0 + a * flange_b.phi;<br>
 flange_a.s = r * flange_b.phi;<br>
 v = (r0 + 2 * a * flange_b.phi) * omega;<br>
 omega = der( flange_b.phi);<br>
 p = r0 + 2 * a * flange_b.phi;<br>
 m = m0 + pi * (d^2) * r * flange_b.phi * rho/4;
</td>
</table>
</ul>
</p>
<p>
Depending on the force sign the inertia <i>J</i> and the torque is calculated as follows:

</p>
<p>
<ul>
<table cellspacing=1 cellpadding=5 border=1><tr>
<td>
  if flange_a.f > 0 then<br>
    J = m * (r^2) / 2 + u * (p^2);<br>
    flange_b.tau = flange_a.f * p - 2 * u * p * a * (omega^2);<br>
  else<br>
    J = 0;<br>
    flange_b.tau = 0;<br>
  end if;

</td>
</table>
</ul>
</p>


<h4>7. Model validation</h4>
<p>
</p>

<h4>8. Equivalent and related models</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Name</h5></p></td>
<td valign=\"top\"><p><h5>Description</h5></p></td>
</tr>
<tr>
<td><p>-</p></td>
<td><p>-</p></td>
</tr>
</table>
</p>

<h4>9. Short characteristic of model</h4>
<p>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=5>
<TR><TD VALIGN=\"TOP\" align=left>Model has discontinuities:</TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Model has been validated: </TD> <TD VALIGN=\"TOP\">yes</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Life cycle status:</TD> <TD VALIGN=\"TOP\">stable</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Protection status:</TD> <TD VALIGN=\"TOP\">MSE-0</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Modelica version:</TD> <TD VALIGN=\"TOP\">3.1</TD></TR>
<TR><TD VALIGN=\"TOP\" align=left>Tested simulation tools and versions:</TD> <TD VALIGN=\"TOP\">Dymola 2013</TD></TR>
</TABLE>
</p>

<h4>10. Testcases</h4>
<p>
<b><u>10.1 Testcase 1: Winch with given angle and external force</u></b>
</p>
<p>
This testcase checks if the resulting torque is calculated correctly
</p>

<h5>Test model structure</h5>
<p>
The testmodel contains a Clamp-, a Angle-, a ForceVariable-, a step-, a const-, a sine- and a WinchKomplex-Block. The sine is transformed into a angular position, which is connected to the winch.
The force is formed by the step signal, the positive flange is conected with the winch and the counterforce acts on the clamp.
</p>

<h5>Decisive parameter values and solver settings</h5>
<p>
<u>step</u>:<br>
startTime = 0.5<br>
height = 5<br>
<u>Winch</u>:<br>
r0 = 0.1 m; <br>
m0 = 5 kg; <br>
a = 0.002; <br>
rho = 10 kg/m^3; <br>
d = 0.1 m; <br>
<u>sine</u>:<br>
amplitude = 180;<br>
freqHz = 1 Hz;<br> 
<u>const</u>:<br>
k = 1;<br>

<u>Info</u>: all unmentioned parameters have default values.
</p>
<p>
Simulation time: 0s ... 5s.<br>
The Dassl solver with a tolerance of 1e-6 with 500 simulation intervals should be selected for this test model.
</p>

<h5>Input values and stimuli signals</h5>
<p>
Everything is set by the model parameters.
</p>

<h5>Tracked variables</h5>
<p>
Winch: flange_b <i>tau</i>
</p>


<h5>Plausibility checks</h5>
<p>
<i>tau</i> should start at 0 and stay there until a force acts. Because of the rotation the rope gets shorter and the radius and mass of the winch increases. The force is transformed 
into a torque acting on the winch. It should be formed like a sine but have different amplitudes because of the changing inertia.
</p>

</p>


<h4>11. Implementation details</h4>
<P> 
</p>


<h4>12. History</h4>
<p>
<table cellspacing=\"0\" cellpadding=\"5\" border=\"1\"><tr>
<td valign=\"top\"><p><h5>Date (mm/yyyy)</h5></p></td>
<td valign=\"top\"><p><h5>Author (dept.)</h5></p></td>
<td valign=\"top\"><p><h5>Comment</h5></p></td>
</tr>
<tr>
<td><p>11/2013</p></td>
<td><p>Sven Baetzing (DC/ETI22)</p></td>
<td><p>Initial implementation and documentation</p></td>
</tr>
</table>
</p>

</HTML>"));
      end WinchKomplex;
      annotation(uses(Modelica(version = "3.2")), Documentation(info = "<HTML>
                
   <p>
Responsible organisation: DC/ETI22
</p>
<p>
<table border=0 cellspacing=0 cellpadding=2>
  <tr>
    <td>
      <img src=\"W:/10_ETI22/__Kollegen/_SvenB?tzing/DC_Mechlib/images/Rotbib.jpg\" width=\"2086\" align=\"center\">
    </td>
  </tr>
  <caption align=\"bottom\"><b>Figure 1: </b>Differences between DC_Mechlib and Simstercomponents</caption>
</table> 
</p>


</HTML>"));
    end Rotatory;
  end Components;
  package testcases
    package Linear
      model Deformation
        Components.Linear.Deformation deformation(Multistroke = false, c1 = 100000, c2 = 50000, c3 = 150000, Fel = 200, minPos(displayUnit = "mm") = 0.0001, nmax = 1, L(displayUnit = "mm") = 0.01) annotation(Placement(transformation(extent = {{42,-10},{62,10}})));
        Modelica.Mechanics.Translational.Sources.Position position(exact = false, f_crit = 1000) annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
        Modelica.Blocks.Sources.TimeTable timeTable(table = [0,0;1,20;2,25;3,28;5,15]) annotation(Placement(transformation(extent = {{-80,-10},{-60,10}})));
        Modelica.Blocks.Math.Gain gain(k = 0.001) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
      equation
        connect(gain.y,position.s_ref) annotation(Line(points = {{-19,0},{-2,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(timeTable.y,gain.u) annotation(Line(points = {{-59,0},{-42,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(position.flange,deformation.flange_a) annotation(Line(points = {{20,0},{42,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end Deformation;
      model ForceConstant
        Components.Linear.Mass mass(g = 0) annotation(Placement(transformation(extent = {{20,-10},{40,10}})));
        Components.Linear.ForceConstant forceConstant(F = 10) annotation(Placement(transformation(extent = {{-20,-10},{0,10}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
      equation
        connect(forceConstant.flange_b,mass.flange_a) annotation(Line(points = {{0,0},{20,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(clamp.flange,forceConstant.flange_a) annotation(Line(points = {{-40,0},{-20,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end ForceConstant;
      model ForceVariable
        Components.Linear.ForceVariable forceVariable annotation(Placement(transformation(extent = {{-30,-10},{-10,10}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-80,-10},{-60,10}})));
        Components.Linear.Mass mass(g = 0) annotation(Placement(transformation(extent = {{10,-10},{30,10}})));
        Modelica.Blocks.Sources.Step step(height = 10, offset = -5, startTime = 0.5) annotation(Placement(transformation(extent = {{-80,30},{-60,50}})));
      equation
        connect(step.y,forceVariable.f) annotation(Line(points = {{-59,40},{-20,40},{-20,10}}, color = {0,0,127}, smooth = Smooth.None));
        connect(clamp.flange,forceVariable.flange_a) annotation(Line(points = {{-60,0},{-30,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(forceVariable.flange_b,mass.flange_a) annotation(Line(points = {{-10,0},{10,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end ForceVariable;
      model mass
        Components.Linear.Mass mass(initialize_s = true, initialize_v = true, s_init = 1, v_init = 10) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      end mass;
      model massEndstop
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-22,-10},{-2,10}})));
        Modelica.Blocks.Sources.Pulse pulse(amplitude = 100, period = 1, width = 50) annotation(Placement(transformation(extent = {{-72,-10},{-52,10}})));
        Components.Linear.MassEndstop massEndstop(lowlim = 0, uplim = 1, restitutionCoefficient = 25, g = -9.81, initialize_s = true, initialize_v = true) annotation(Placement(transformation(extent = {{20,-10},{40,10}})));
      equation
        connect(pulse.y,force.f) annotation(Line(points = {{-51,0},{-24,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(force.flange,massEndstop.flange_a) annotation(Line(points = {{-2,0},{20,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end massEndstop;
      model massFriction
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-26,-10},{-6,10}})));
        Modelica.Blocks.Sources.TimeTable timeTable(table = [0,50;0.1,0;1,0]) annotation(Placement(transformation(extent = {{-74,-10},{-54,10}})));
        Components.Linear.MassFriction massFriction(initialize_s = true, initialize_v = true) annotation(Placement(transformation(extent = {{8,-10},{28,10}})));
      equation
        connect(timeTable.y,force.f) annotation(Line(points = {{-53,0},{-28,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(force.flange,massFriction.flange_a) annotation(Line(points = {{-6,0},{8,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end massFriction;
      model massFriction2
        Components.Linear.MassFriction massFriction(initialize_s = true, initialize_v = true, v_init = 2) annotation(Placement(transformation(extent = {{-8,-10},{12,10}})));
        annotation(Diagram(graphics));
      end massFriction2;
      model massFrictionEndstop
        Components.Linear.MassFrictionEndstop massFrictionEndstop(restitutionCoefficient = 70, initialize_s = true, initialize_v = true, s_init = 0.5, v_init = -5) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        annotation(Diagram(graphics));
      end massFrictionEndstop;
      model massFrictionEndstop2
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-26,-10},{-6,10}})));
        Modelica.Blocks.Sources.Pulse pulse(amplitude = 50, period = 1) annotation(Placement(transformation(extent = {{-74,-10},{-54,10}})));
        Components.Linear.MassFrictionEndstop massFrictionEndstop(initialize_s = true, initialize_v = true) annotation(Placement(transformation(extent = {{20,-10},{40,10}})));
      equation
        connect(pulse.y,force.f) annotation(Line(points = {{-53,0},{-28,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(force.flange,massFrictionEndstop.flange_a) annotation(Line(points = {{-6,0},{20,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end massFrictionEndstop2;
      model massVariable
        Components.Linear.MassVariable massVariable(g = 0) annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
        Components.Linear.ForceConstant forceConstant(F = 5) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-80,-10},{-60,10}})));
        Modelica.Blocks.Sources.Step step(startTime = 0.5, height = 9, offset = 1) annotation(Placement(transformation(extent = {{-40,30},{-20,50}})));
      equation
        connect(forceConstant.flange_b,massVariable.flange_a) annotation(Line(points = {{-20,0},{0,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(clamp.flange,forceConstant.flange_a) annotation(Line(points = {{-60,0},{-40,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(step.y,massVariable.m) annotation(Line(points = {{-19,40},{10,40},{10,10.6}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end massVariable;
      model position
        Modelica.Blocks.Sources.Ramp ramp(duration = 1, height = 1) annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Components.Linear.Position position(initialize_v = true, v_init(displayUnit = "mm/s") = 0.5, unit = "m") annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(ramp.y,position.s_ref) annotation(Line(points = {{-29,0},{-10.6,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics), experiment(Interval = 0.001), __Dymola_experimentSetupOutput);
      end position;
      model PressureSpring
        Components.Linear.PressureSpring pressureSpring(c = 100, c2 = 1000, d = 1, LB = 0.5, n = 3, Fstart = 0) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
        Components.Linear.Mass mass(g = 0, m = 10, initialize_s = true, initialize_v = true, s_init = 1, v_init = -1) annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-80,-10},{-60,10}})));
      equation
        connect(mass.flange_a,pressureSpring.flange_b) annotation(Line(points = {{0,0},{-20,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(clamp.flange,pressureSpring.flange_a) annotation(Line(points = {{-60,0},{-40,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end PressureSpring;
      model RackandPinTrans
        Components.Linear.RackandPin rackandPin(Radius(displayUnit = "m") = 0.1) annotation(Placement(transformation(extent = {{38,-10},{58,10}})));
        Components.Linear.Position position(unit = "m") annotation(Placement(transformation(extent = {{-20,-10},{0,10}})));
        Modelica.Blocks.Sources.Ramp ramp(duration = 1) annotation(Placement(transformation(extent = {{-82,-10},{-62,10}})));
      equation
        connect(position.flange,rackandPin.flange_T) annotation(Line(points = {{0,0},{38,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(ramp.y,position.s_ref) annotation(Line(points = {{-61,0},{-20.6,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end RackandPinTrans;
      model Rope
        Components.Linear.Mass mass(initialize_s = true, initialize_v = true, s_init = 0.5) annotation(Placement(transformation(extent = {{30,-10},{50,10}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Components.Linear.Rope rope(E = 10000000) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(clamp.flange,rope.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(rope.flange_b,mass.flange_a) annotation(Line(points = {{10,0},{30,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end Rope;
      model springdamper
        Components.Linear.Mass mass(g = 0, initialize_s = true, initialize_v = true, s_init = 0, v_init = 5) annotation(Placement(transformation(extent = {{30,-10},{50,10}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Components.Linear.SpringDamper springDamper annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(clamp.flange,springDamper.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(springDamper.flange_b,mass.flange_a) annotation(Line(points = {{10,0},{30,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end springdamper;
      model springdamperkomplex
        Components.Linear.Mass mass(g = 0, initialize_s = true, initialize_v = true, s_init = 0, v_init = 5) annotation(Placement(transformation(extent = {{30,-10},{50,10}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Components.Linear.SpringDamperKomplex springDamperKomplex(L0 = 0.05, idl_str = 0.005) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(clamp.flange,springDamperKomplex.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(springDamperKomplex.flange_b,mass.flange_a) annotation(Line(points = {{10,0},{30,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end springdamperkomplex;
      model TwoMassFriction
        Components.Linear.TwoMassFriction twoMassFriction(g = 0, mA = 10, mB = 10, Fc = 2, vh(displayUnit = "m/s") = 0.000001, initialize_sA = true, initialize_sB = true, initialize_vA = true, initialize_vB = true, Stick(fixed = true)) annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-38,-10},{-18,10}})));
        Modelica.Blocks.Sources.Step step(startTime = 0.5, height = 92, offset = 8) annotation(Placement(transformation(extent = {{-80,-10},{-60,10}})));
      equation
        connect(force.flange,twoMassFriction.flange_a) annotation(Line(points = {{-18,0},{0,0}}, color = {0,127,0}, thickness = 0.5, smooth = Smooth.None));
        connect(step.y,force.f) annotation(Line(points = {{-59,0},{-40,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end TwoMassFriction;
      model TwoMassEndstop
        Modelica.Blocks.Sources.Step step(startTime = 0.5, height = 10) annotation(Placement(transformation(extent = {{-82,-10},{-62,10}})));
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
        Components.Linear.TwoMassEndstop twoMassEndstop1(restitutionCoefficient = 30, g = 0, secondStop = true, initialize_sA = true, initialize_sB = true, initialize_vA = true, initialize_vB = true) annotation(Placement(transformation(extent = {{-20,20},{0,40}})));
      equation
        connect(step.y,force.f) annotation(Line(points = {{-61,0},{-42,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(twoMassEndstop1.flange_b,force.flange) annotation(Line(points = {{0,30},{14,30},{14,0},{-20,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end TwoMassEndstop;
      model TwoMassFrictionEndstop
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-44,-10},{-24,10}})));
        Modelica.Blocks.Sources.TimeTable timeTable(table = [0,0;0.5,0;0.51,11;2,11;2.01,0;5,0]) annotation(Placement(transformation(extent = {{-86,-10},{-66,10}})));
        Components.Linear.TwoMassFrictionEndstop twoMassFrictionEndstop1(mA = 100, mB = 5, g = 0, secondStop = true) annotation(Placement(transformation(extent = {{8,-10},{-12,10}})));
      equation
        connect(timeTable.y,force.f) annotation(Line(points = {{-65,0},{-46,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(twoMassFrictionEndstop1.flange_b,force.flange) annotation(Line(points = {{-12,0},{-24,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end TwoMassFrictionEndstop;
      model TwoMassFriction2
        Components.Linear.TwoMassFriction twoMassFriction(g = 0, mA = 1, mB = 1, vis = 1, initialize_sA = true, initialize_sB = true, initialize_vA = true, initialize_vB = true) annotation(Placement(transformation(extent = {{4,-10},{24,10}})));
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
        Modelica.Blocks.Sources.TimeTable timeTable(table = [0,0;1.5,30;1.51,0;5,0]) annotation(Placement(transformation(extent = {{-80,-10},{-60,10}})));
      equation
        connect(force.flange,twoMassFriction.flange_a) annotation(Line(points = {{-20,0},{4,0}}, color = {0,127,0}, thickness = 0.5, smooth = Smooth.None));
        connect(timeTable.y,force.f) annotation(Line(points = {{-59,0},{-42,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end TwoMassFriction2;
      model TwoMassEndstopInit
        Components.Linear.TwoMassEndstop twoMassEndstop(mA = 1000, mB = 1, restitutionCoefficient = 100, g = 0, secondStop = true, initialize_sA = true, initialize_sB = true, initialize_vA = true, initialize_vB = true, sB_init = 0.5, vA_init = 1) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      end TwoMassEndstopInit;
      model velocity
        Modelica.Blocks.Sources.Ramp ramp(duration = 1) annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
        Components.Linear.Velocity velocity(initialize_s = true, s_init = 1, unit = "m/s") annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(velocity.s_ref,ramp.y) annotation(Line(points = {{-10.6,0},{-39,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end velocity;
      model massEndstoptest
        DC_Mechlib_SB.Components.Linear.MassEndstopNOTUSED massEndstop(m = 50, g = 0, restitutionCoefficient = 90, lowlim = 0, uplim = 0.2) annotation(Placement(transformation(extent = {{22,-10},{42,10}})));
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-22,-10},{-2,10}})));
        Modelica.Blocks.Sources.Trapezoid trapezoid(rising = 0.1, width = 0.9, falling = 0.1, period = 2, nperiod = 3, amplitude = 100, offset = -50) annotation(Placement(transformation(extent = {{-70,-10},{-50,10}})));
      equation
        connect(force.flange,massEndstop.flange_a) annotation(Line(points = {{-2,0},{22,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(trapezoid.y,force.f) annotation(Line(points = {{-49,0},{-24,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end massEndstoptest;
      model test
        Modelica.Mechanics.Translational.Components.Mass mass(m = 1, v(start = 5, fixed = true), s(fixed = true)) annotation(Placement(transformation(extent = {{-8,-10},{12,10}})));
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{-54,-10},{-34,10}})));
        Modelica.Blocks.Sources.Step step(height = 15, startTime = 0.5) annotation(Placement(transformation(extent = {{-94,-10},{-74,10}})));
        Components.Linear.DryFricStribeck dryFricStribeck annotation(Placement(transformation(extent = {{-38,20},{-18,40}})));
      equation
        connect(mass.flange_a,force.flange) annotation(Line(points = {{-8,0},{-34,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(force.f,step.y) annotation(Line(points = {{-56,0},{-73,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(dryFricStribeck.flange_a,mass.flange_a) annotation(Line(points = {{-18,30},{-18,0},{-8,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end test;
      model test2
        Modelica.Blocks.Sources.Ramp ramp(duration = 2, height = 500) annotation(Placement(transformation(extent = {{-70,38},{-50,58}})));
        Modelica.Mechanics.Translational.Sources.Force force annotation(Placement(transformation(extent = {{18,20},{38,40}})));
        Components.Linear.TwoMassFrictionEndstop twoMassFrictionEndstop(mA = 100, mB = 5, g = 0, secondStop = true) annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
      equation
        connect(force.flange,twoMassFrictionEndstop.flange_b) annotation(Line(points = {{38,30},{40,30},{40,0},{20,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(ramp.y,force.f) annotation(Line(points = {{-49,48},{-16,48},{-16,30},{16,30}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end test2;
      model test3
        Components.Linear.TwoMassFrictionEndstop twoMassFrictionEndstop(mA = 100, mB = 5, g = 0, secondStop = true, sB_init = 0.1, vB_init = -5, initialize_sA = true, initialize_sB = true, initialize_vA = true, initialize_vB = true) annotation(Placement(transformation(extent = {{-8,-10},{12,10}})));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end test3;
    end Linear;
    package Rotatory
      model Winch
        Components.Rotatory.Winch winch(Mslip = 1) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-100,-10},{-80,10}})));
        Components.Rotatory.TorqueConstant torqueConstant(Torque = 5) annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
        Components.Linear.Clamp clamp1 annotation(Placement(transformation(extent = {{100,-10},{80,10}})));
        Components.Linear.ForceVariable forceVariable annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
        Modelica.Blocks.Sources.Step step(height = 5, startTime = 0.5) annotation(Placement(transformation(extent = {{20,20},{40,40}})));
      equation
        connect(winch.flange_b,torqueConstant.flange_b) annotation(Line(points = {{-10,0},{-40,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torqueConstant.flange_a,clamp.flange_b) annotation(Line(points = {{-60,0},{-80,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(step.y,forceVariable.f) annotation(Line(points = {{41,30},{50,30},{50,10}}, color = {0,0,127}, smooth = Smooth.None));
        connect(winch.flange_a,forceVariable.flange_a) annotation(Line(points = {{10,0},{40,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(forceVariable.flange_b,clamp1.flange) annotation(Line(points = {{60,0},{80,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true), graphics), Icon(coordinateSystem(extent = {{-100,-100},{100,100}})));
      end Winch;
      model RackandPin
        Modelica.Blocks.Sources.Ramp ramp(duration = 1, height = 360) annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Components.Rotatory.Angle angle(unit = "grad") annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Components.Rotatory.RackandPin rackandPin annotation(Placement(transformation(extent = {{30,-10},{50,10}})));
      equation
        connect(ramp.y,angle.phi) annotation(Line(points = {{-29,0},{-10,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(angle.flange_b,rackandPin.flange_R) annotation(Line(points = {{10,0},{30,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end RackandPin;
      model TorqueConstant
        Components.Rotatory.Inertia inertia annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
        Components.Rotatory.TorqueConstant torqueConstant(Torque = 10) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(torqueConstant.flange_b,inertia.flange_a) annotation(Line(points = {{10,0},{40,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end TorqueConstant;
      model TorqueVariable
        Modelica.Blocks.Sources.Step step(height = 10, offset = -5, startTime = 0.5) annotation(Placement(transformation(extent = {{-60,20},{-40,40}})));
        Components.Rotatory.Inertia inertia annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
        Components.Rotatory.TorqueVariable torqueVariable annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(clamp.flange_b,torqueVariable.flange_a) annotation(Line(points = {{-40,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(step.y,torqueVariable.u) annotation(Line(points = {{-39,30},{0,30},{0,10}}, color = {0,0,127}, smooth = Smooth.None));
        connect(torqueVariable.flange_b,inertia.flange_a) annotation(Line(points = {{10,0},{40,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end TorqueVariable;
      model Angle
        Modelica.Blocks.Sources.Ramp ramp(duration = 1, height = 1) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
        Components.Rotatory.Angle angle(w_init(displayUnit = "deg/s") = 3.1415926535898, initialize_w = true, unit = "rad") annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
      equation
        connect(ramp.y,angle.phi) annotation(Line(points = {{-19,0},{0,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end Angle;
      model Revolution
        Components.Rotatory.Revolution revolution(phi_init = 1.5707963267949, initialize_phi = true) annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
        Modelica.Blocks.Sources.Ramp ramp(duration = 1) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
      equation
        connect(ramp.y,revolution.omega) annotation(Line(points = {{-19,0},{0,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end Revolution;
      model SpringDamper
        Components.Rotatory.SpringDamper springDamper(idl_str(displayUnit = "rad") = 0.5, c = 1000, d = 10) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Components.Rotatory.Inertia inertia(w_init(displayUnit = "rad/s") = 6, initialize_phi = true, initialize_w = true) annotation(Placement(transformation(extent = {{30,-10},{50,10}})));
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
      equation
        connect(clamp.flange_b,springDamper.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(springDamper.flange_b,inertia.flange_a) annotation(Line(points = {{10,0},{30,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end SpringDamper;
      model SpringDamperkomplex
        Components.Rotatory.SpringDamperKomplex springDamperKomplex1(phi0(displayUnit = "rad"), idl_str(displayUnit = "rad")) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Components.Rotatory.Inertia inertia(w_init(displayUnit = "rad/s") = 6, initialize_phi = true, initialize_w = true) annotation(Placement(transformation(extent = {{30,-10},{50,10}})));
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
      equation
        connect(clamp.flange_b,springDamperKomplex1.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(springDamperKomplex1.flange_b,inertia.flange_a) annotation(Line(points = {{10,0},{30,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end SpringDamperkomplex;
      model Inertia
        Components.Rotatory.Inertia inertia(initialize_phi = true, initialize_w = true, phi_init = 0.78539816339745, w_init = 1.5707963267949) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      end Inertia;
      model InertiaFriction
        Modelica.Blocks.Sources.TimeTable timeTable(table = [0,50;0.1,0;1,0]) annotation(Placement(transformation(extent = {{-54,-10},{-34,10}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Components.Rotatory.InertiaFriction inertiaFriction(wh(displayUnit = "rad/s"), initialize_phi = true, initialize_omega = true) annotation(Placement(transformation(extent = {{26,-10},{46,10}})));
      equation
        connect(timeTable.y,torque.tau) annotation(Line(points = {{-33,0},{-12,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(torque.flange,inertiaFriction.flange_a) annotation(Line(points = {{10,0},{26,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end InertiaFriction;
      model InertiaFrictionInit
        Components.Rotatory.InertiaFriction inertiaFriction(initialize_phi = true, initialize_omega = true, wh(displayUnit = "rad/s"), omega_init(displayUnit = "deg/s") = 3.1415926535898) annotation(Placement(transformation(extent = {{-8,-10},{12,10}})));
      end InertiaFrictionInit;
      model InertiaEndstop
        Components.Rotatory.InertiaEndstop inertiaEndstop(omega_init(displayUnit = "deg/s") = 6.2831853071796, initialize_phi = true, initialize_omega = true, restitutionCoefficient = 50) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        annotation(Diagram(graphics));
      end InertiaEndstop;
      model InertiaFrictionEndstop
        Components.Rotatory.InertiaFrictionEndstop inertiaFrictionEndstop(vis = 0.1, restitutionCoefficient = 25, initialize_phi = true, initialize_omega = true, J = 10, phi_init = 3.1414181206646, omega_init(displayUnit = "deg/s") = -6.2831853071796) annotation(Placement(transformation(extent = {{-12,-10},{8,10}})));
      end InertiaFrictionEndstop;
      model InertiaFrictionEndstop2
        Components.Rotatory.InertiaFrictionEndstop inertiaFrictionEndstop(vis = 0.1, restitutionCoefficient = 25, omega_init(displayUnit = "deg/s") = 6.2831853071796, initialize_phi = true, initialize_omega = true, J = 10, phi_init = 3.1415752002973) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Modelica.Blocks.Sources.Ramp ramp(height = 15, duration = 1) annotation(Placement(transformation(extent = {{-92,-10},{-72,10}})));
        Modelica.Blocks.Sources.Constant const(k = 5) annotation(Placement(transformation(extent = {{80,-10},{60,10}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque1 annotation(Placement(transformation(extent = {{40,-10},{20,10}})));
      equation
        connect(torque.flange,inertiaFrictionEndstop.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(inertiaFrictionEndstop.flange_b,torque1.flange) annotation(Line(points = {{10,0},{20,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torque1.tau,const.y) annotation(Line(points = {{42,0},{59,0}}, color = {0,0,127}, smooth = Smooth.None));
        connect(ramp.y,torque.tau) annotation(Line(points = {{-71,0},{-52,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end InertiaFrictionEndstop2;
      model InertiaVariable
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
        Components.Rotatory.TorqueConstant torqueConstant(Torque = 5) annotation(Placement(transformation(extent = {{-20,-10},{0,10}})));
        Components.Rotatory.InertiaVaraible inertiaVaraible annotation(Placement(transformation(extent = {{20,-10},{40,10}})));
        Modelica.Blocks.Sources.Step step(startTime = 0.5, offset = 1, height = 9) annotation(Placement(transformation(extent = {{-20,20},{0,40}})));
      equation
        connect(clamp.flange_b,torqueConstant.flange_a) annotation(Line(points = {{-40,0},{-20,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(step.y,inertiaVaraible.J) annotation(Line(points = {{1,30},{30,30},{30,10.6}}, color = {0,0,127}, smooth = Smooth.None));
        connect(torqueConstant.flange_b,inertiaVaraible.flange_a) annotation(Line(points = {{0,0},{20,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end InertiaVariable;
      model Gear
        Components.Rotatory.Gear gear(i = 2) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Components.Rotatory.Inertia inertia(initialize_phi = true, initialize_w = true, w_init(displayUnit = "deg/s") = 0) annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Modelica.Blocks.Sources.Constant const(k = 50) annotation(Placement(transformation(extent = {{-40,40},{-20,60}})));
        Components.Rotatory.TorqueConstant torqueConstant(Torque = 5) annotation(Placement(transformation(extent = {{40,-10},{20,10}})));
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{70,-10},{50,10}})));
      equation
        connect(const.y,gear.u) annotation(Line(points = {{-19,50},{0,50},{0,10.3}}, color = {0,0,127}, smooth = Smooth.None));
        connect(gear.flange_b,torqueConstant.flange_b) annotation(Line(points = {{10,0},{20,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torqueConstant.flange_a,clamp.flange_b) annotation(Line(points = {{40,0},{50,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(inertia.flange_b,gear.flange_a) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end Gear;
      model GearKomplex
        Components.Rotatory.TorqueConstant torqueConstant(Torque = 5) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-70,-10},{-50,10}})));
        Components.Rotatory.GearKomplex gearKomplex1(J = 0.1, Mslip = 2, vis = 0.001, ratio = 2) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
      equation
        connect(clamp.flange_b,torqueConstant.flange_a) annotation(Line(points = {{-50,0},{-40,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(torqueConstant.flange_b,gearKomplex1.flange_a) annotation(Line(points = {{-20,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end GearKomplex;
      model CableReel
        Components.Rotatory.TorqueConstant torqueConstant(Torque = 5) annotation(Placement(transformation(extent = {{-10,30},{10,50}})));
        Components.Rotatory.Clamp clamp annotation(Placement(transformation(extent = {{-50,30},{-30,50}})));
        Components.Linear.ForceVariable forceVariable annotation(Placement(transformation(extent = {{10,-50},{-10,-30}})));
        Components.Linear.Clamp clamp1 annotation(Placement(transformation(extent = {{-50,-50},{-30,-30}})));
        Modelica.Blocks.Sources.Step step(startTime = 0.5, height = 5) annotation(Placement(transformation(extent = {{-30,-10},{-10,10}})));
        Components.Rotatory.CableReel cableReel(wh = 0.001, Mslip = 2, Mstick = 2) annotation(Placement(transformation(extent = {{20,-10},{40,10}})));
      equation
        connect(clamp.flange_b,torqueConstant.flange_a) annotation(Line(points = {{-30,40},{-10,40}}, color = {0,0,0}, smooth = Smooth.None));
        connect(step.y,forceVariable.f) annotation(Line(points = {{-9,0},{0,0},{0,-30}}, color = {0,0,127}, smooth = Smooth.None));
        connect(clamp1.flange,forceVariable.flange_b) annotation(Line(points = {{-30,-40},{-10,-40}}, color = {0,127,0}, smooth = Smooth.None));
        connect(forceVariable.flange_a,cableReel.flange_a) annotation(Line(points = {{10,-40},{18,-40},{18,-10},{24,-10}}, color = {0,127,0}, smooth = Smooth.None));
        connect(torqueConstant.flange_b,cableReel.flange_b) annotation(Line(points = {{10,40},{20,40},{20,10},{30,10}}, color = {0,0,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end CableReel;
      model WinchKomplex
        Components.Rotatory.WinchKomplex winchKomplex(r0 = 0.1, m0 = 5, a = 0.002, d = 0.1, initialize_phi = false, initialize_w = false, rho = 10) annotation(Placement(transformation(extent = {{-10,-10},{10,10}})));
        Components.Linear.ForceVariable forceVariable annotation(Placement(transformation(extent = {{50,-10},{30,10}})));
        Modelica.Blocks.Sources.Step step(height = 5, startTime = 0.5, offset = 0) annotation(Placement(transformation(extent = {{10,20},{30,40}})));
        Modelica.Blocks.Sources.Constant const(k = 1) annotation(Placement(transformation(extent = {{-30,20},{-10,40}})));
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 0, origin = {90,0})));
        Components.Rotatory.Angle angle annotation(Placement(transformation(extent = {{-50,-10},{-30,10}})));
        Modelica.Blocks.Sources.Sine sine(freqHz = 1, amplitude = 180) annotation(Placement(transformation(extent = {{-100,-10},{-80,10}})));
      equation
        connect(forceVariable.flange_b,winchKomplex.flange_a) annotation(Line(points = {{30,0},{10,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(step.y,forceVariable.f) annotation(Line(points = {{31,30},{40,30},{40,10}}, color = {0,0,127}, smooth = Smooth.None));
        connect(const.y,winchKomplex.u) annotation(Line(points = {{-9,30},{0,30},{0,11}}, color = {0,0,127}, smooth = Smooth.None));
        connect(clamp.flange,forceVariable.flange_a) annotation(Line(points = {{80,0},{50,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(angle.flange_b,winchKomplex.flange_b) annotation(Line(points = {{-30,0},{-10,0}}, color = {0,0,0}, smooth = Smooth.None));
        connect(sine.y,angle.phi) annotation(Line(points = {{-79,0},{-50,0}}, color = {0,0,127}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end WinchKomplex;
      model test
        Components.Linear.Clamp clamp annotation(Placement(transformation(extent = {{-80,-10},{-60,10}})));
        Components.Linear.ForceConstant forceConstant(F = 5) annotation(Placement(transformation(extent = {{-40,-10},{-20,10}})));
        Components.Linear.MassFriction massFriction(v_init = -5) annotation(Placement(transformation(extent = {{2,-10},{22,10}})));
      equation
        connect(clamp.flange,forceConstant.flange_a) annotation(Line(points = {{-60,0},{-40,0}}, color = {0,127,0}, smooth = Smooth.None));
        connect(forceConstant.flange_b,massFriction.flange_a) annotation(Line(points = {{-20,0},{2,0}}, color = {0,127,0}, smooth = Smooth.None));
        annotation(Diagram(graphics));
      end test;
    end Rotatory;
  end testcases;
  annotation(uses(Modelica(version = "3.2")));
end DC_Mechlib_SB;

