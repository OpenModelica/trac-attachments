package Modelica "Modelica Standard Library (Version 3.2)"
extends Modelica.Icons.Package;

  package Blocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

    package Interfaces
    "Library of connectors and partial models for input/output blocks"
      import Modelica.SIunits;
        extends Modelica.Icons.InterfacesPackage;

    connector RealInput = input Real "'input Real' as connector"
      annotation (defaultComponentName="u",
      Icon(graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)},
           coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, initialScale=0.2)),
      Diagram(coordinateSystem(
            preserveAspectRatio=true, initialScale=0.2,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid), Text(
              extent={{-10,85},{-10,60}},
              lineColor={0,0,127},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));

    connector RealOutput = output Real "'output Real' as connector"
      annotation (defaultComponentName="y",
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,50},{0,0},{-100,-50},{-100,50}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{30,110},{30,60}},
              lineColor={0,0,127},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));

    connector BooleanOutput = output Boolean "'output Boolean' as connector"
                                      annotation (defaultComponentName="y",
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={Polygon(
              points={{-100,50},{0,0},{-100,-50},{-100,50}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{30,110},{30,60}},
              lineColor={255,0,255},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Boolean.
</p>
</html>"));

        partial block BlockIcon "Basic graphical layout of input/output block"

          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                extent={{-100,-100},{100,100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output
block (no declarations, no equations). Most blocks
of package Modelica.Blocks inherit directly or indirectly
from this block.
</p>
</html>"));

        end BlockIcon;

        partial block MO "Multiple Output continuous control block"
          extends BlockIcon;

          parameter Integer nout(min=1) = 1 "Number of outputs";
          RealOutput y[nout] "Connector of Real output signals"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
          annotation (
            Documentation(info="<html>
<p>
Block has one continuous Real output signal vector.
</p>
</html>"));

        end MO;

    partial block SIMO "Single Input Multiple Output continuous control block"
      extends BlockIcon;
      parameter Integer nout=1 "Number of outputs";
          RealInput u "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
                rotation=0)));
          RealOutput y[nout] "Connector of Real output signals"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));

      annotation (Documentation(info="<HTML>
<p> Block has one continuous Real input signal and a
    vector of continuous Real output signals.</p>

</HTML>
"));
    end SIMO;
        annotation (
          Documentation(info="<HTML>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</HTML>
",     revisions="<html>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added several new interfaces. <a href=\"modelica://Modelica/Documentation/ChangeNotes1.5.html\">Detailed description</a> available.
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal renamed to RealInput. RealOutputSignal renamed to
       output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
       SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
       SignalGenerator renamed to SignalSource. Introduced the following
       new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
       DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
       BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>
"));
    end Interfaces;

    package Sources
    "Library of signal source blocks generating Real and Boolean signals"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.SourcesPackage;

      model CombiTimeTable
      "Table look-up with respect to time and linear/perodic extrapolation methods (data from matrix/file)"

        parameter Boolean tableOnFile=false
        "= true, if table is defined on file or in function usertab"
          annotation(Dialog(group="table data definition"));
        parameter Real table[:, :] = fill(0.0,0,2)
        "Table matrix (time = first column; e.g., table=[0,2])"
             annotation(Dialog(group="table data definition", enable = not tableOnFile));
        parameter String tableName="NoName"
        "Table name on file or in function usertab (see docu)"
             annotation(Dialog(group="table data definition", enable = tableOnFile));
        parameter String fileName="NoName" "File where matrix is stored"
             annotation(Dialog(group="table data definition", enable = tableOnFile,
                               __Dymola_loadSelector(filter="Text files (*.txt);;Matlab files (*.mat)",
                               caption="Open file in which table is present")));
        parameter Integer columns[:]=2:size(table, 2)
        "Columns of table to be interpolated"
        annotation(Dialog(group="table data interpretation"));
        parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation"
        annotation(Dialog(group="table data interpretation"));
        parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
        "Extrapolation of data outside the definition range"
        annotation(Dialog(group="table data interpretation"));
        parameter Real offset[:]={0} "Offsets of output signals"
        annotation(Dialog(group="table data interpretation"));
        parameter Modelica.SIunits.Time startTime=0
        "Output = offset for time < startTime"
        annotation(Dialog(group="table data interpretation"));
        extends Modelica.Blocks.Interfaces.MO(final nout=max([size(columns, 1); size(offset, 1)]));
        final parameter Real t_min(fixed=false)
        "Minimum abscissa value defined in table";
        final parameter Real t_max(fixed=false)
        "Maximum abscissa value defined in table";

    protected
        final parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)
             *offset[1] else offset);

        Integer tableID;

        function tableTimeInit
        "Initialize 1-dim. table where first column is time (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)"
          input String tableName;
          input String fileName;
          input Real table[ :, :];
          input Real startTime;
          input Modelica.Blocks.Types.Smoothness smoothness;
          input Modelica.Blocks.Types.Extrapolation extrapolation;
          output Integer tableID;
        external "C" tableID = ModelicaTables_CombiTimeTable_init(
                       tableName, fileName, table, size(table, 1), size(table, 2),
                       startTime, smoothness, extrapolation);
          annotation(Library="ModelicaExternalC");
        end tableTimeInit;

        function tableTimeIpo
        "Interpolate 1-dim. table where first column is time (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)"
          input Integer tableID;
          input Integer icol;
          input Real timeIn;
          output Real value;
        external "C" value =
                           ModelicaTables_CombiTimeTable_interpolate(tableID, icol, timeIn);
          annotation(Library="ModelicaExternalC");
        end tableTimeIpo;

        function tableTimeTmin
        "Return minimum time value of 1-dim. table where first column is time (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)"
          input Integer tableID;
          output Real Tmin "minimum time value in table";
        external "C" Tmin =
                          ModelicaTables_CombiTimeTable_minimumTime(tableID);
          annotation(Library="ModelicaExternalC");
        end tableTimeTmin;

        function tableTimeTmax
        "Return maximum time value of 1-dim. table where first column is time (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)"
          input Integer tableID;
          output Real Tmax "maximum time value in table";
        external "C" Tmax =
                          ModelicaTables_CombiTimeTable_maximumTime(tableID);
          annotation(Library="ModelicaExternalC");
        end tableTimeTmax;

      equation
        if tableOnFile then
          assert(tableName<>"NoName", "tableOnFile = true and no table name given");
        end if;
        if not tableOnFile then
          assert(size(table,1) > 0 and size(table,2) > 0, "tableOnFile = false and parameter table is an empty matrix");
        end if;
        for i in 1:nout loop
          y[i] = p_offset[i] + tableTimeIpo(tableID, columns[i], time);
        end for;
        when initial() then
          tableID=tableTimeInit((if not tableOnFile then "NoName" else tableName),
                                (if not tableOnFile then "NoName" else fileName), table,
                                startTime, smoothness, extrapolation);
        end when;
      initial equation
          t_min=tableTimeTmin(tableID);
          t_max=tableTimeTmax(tableID);
        annotation (
          Documentation(info="<HTML>
<p>
This block generates an output signal y[:] by <b>linear interpolation</b> in
a table. The time points and function values are stored in a matrix
<b>table[i,j]</b>, where the first column table[:,1] contains the
time points and the other columns contain the data to be interpolated.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png\">
</p>

<p>
Via parameter <b>columns</b> it can be defined which columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output is computed
by interpolation of column 2 and the second output is computed
by interpolation of column 4 of the table matrix.
The table interpolation has the following properties:
</p>
<ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same
    time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by
    extrapolation according to the setting of parameter
    <b>extrapolation</b>:
<pre>
  extrapolation = 0: hold the first or last value of the table,
                     if outside of the range.
                = 1: extrapolate through the last or first two
                     points of the table.
                = 2: periodically repeat the table data
                     (periodical function).
</pre></li>
<li>Via parameter <b>smoothness</b> it is defined how the data is interpolated:
<pre>
  smoothness = 0: linear interpolation
             = 1: smooth interpolation with Akima Splines such
                  that der(y) is continuous.
</pre></li>
<li>If the table has only <b>one row</b>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameters <b>startTime</b> and <b>offset</b> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <b>relative</b>
    to <b>startTime</b>.
    If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for all outputs.
<li>The table is implemented in a numerically sound way by
    generating <b>time events</b> at interval boundaries,
    in order to not integrate over a discontinuous or not differentiable
    points.
<li>For special applications it is sometimes needed to know the minimum
    and maximum time instant defined in the table as a parameter. For this
    reason parameters <b>t_min</b> and <b>t_max</b> are provided and can be access from
    the outside of the table object.
</li>
</ul>
<p>
Example:
</p>
<pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]; extrapolation = 1 (default)
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation via last 2 points).
</pre>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and binary file format is possible.
      (the ASCII format is described below).
      It is most convenient to generate the binary file from Matlab
      (Matlab 4 storage format), e.g., by command
<pre>
   save tables.mat tab1 tab2 tab3 -V4
</pre>
      when the three tables tab1, tab2, tab3 should be
      used from the model.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks.</li>
</ol>
<p>
Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
and do not access files, whereas method (2) does. Therefore (1) and (3)
are suited for hardware-in-the-loop simulation (e.g., with dSpace hardware).
When the constant \"NO_FILE\" is defined in \"usertab.c\", all parts of the
source code of method (2) are removed by the C-preprocessor, such that
no dynamic memory allocation and no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file need to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double tab1(6,2)   # comment line
  0   0
  1   0
  1   1
  2   4
  3   9
  4  16
double tab2(6,2)   # another comment line
  0   0
  2   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\". Afterwards, the corresponding matrix has to be declared
with type, name and actual dimensions. Finally, in successive
rows of the file, the elements of the matrix have to be given.
Several matrices may be defined one after another.
</p>

</HTML>
",     revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>March 31, 2001</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Used CombiTableTime as a basis and added the
       arguments <b>extrapolation, columns, startTime</b>.
       This allows periodic function definitions. </li>
</ul>
</html>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
              Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-48,70},{2,-50}},
                lineColor={255,255,255},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Line(points={{-48,-50},{-48,70},{52,70},{52,-50},{-48,-50},{-48,-20},
                    {52,-20},{52,10},{-48,10},{-48,40},{52,40},{52,70},{2,70},{2,-51}},
                  color={0,0,0})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-20,90},{20,-30}},
                lineColor={255,255,255},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-20,-30},{-20,90},{80,90},{80,-30},{-20,-30},{-20,0},{
                    80,0},{80,30},{-20,30},{-20,60},{80,60},{80,90},{20,90},{20,-30}},
                  color={0,0,0}),
              Text(
                extent={{-71,-42},{-32,-54}},
                lineColor={0,0,0},
                textString="offset"),
              Polygon(
                points={{-31,-30},{-33,-40},{-28,-40},{-31,-30}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-31,-70},{-34,-60},{-29,-60},{-31,-70},{-31,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-31,-31},{-31,-70}}, color={95,95,95}),
              Line(points={{-20,-30},{-20,-70}}, color={95,95,95}),
              Text(
                extent={{-42,-74},{6,-84}},
                lineColor={0,0,0},
                textString="startTime"),
              Line(points={{-20,-30},{-80,-30}}, color={95,95,95}),
              Text(
                extent={{-73,93},{-44,74}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{66,-81},{92,-92}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-19,83},{20,68}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{21,82},{50,68}},
                lineColor={0,0,0},
                textString="y[1]"),
              Line(points={{50,90},{50,-30}}, color={0,0,0}),
              Line(points={{80,0},{100,0}}, color={0,0,255}),
              Text(
                extent={{34,-30},{71,-42}},
                textString="columns",
                lineColor={0,0,255}),
              Text(
                extent={{51,82},{80,68}},
                lineColor={0,0,0},
                textString="y[2]")}));
      end CombiTimeTable;
          annotation (
            Documentation(info="<HTML>
<p>
This package contains <b>source</b> components, i.e., blocks which
have only output signals. These blocks are used as signal generators
for Real, Integer and Boolean signals.
</p>

<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>offset</b></td>
      <td valign=\"top\">Value which is added to the signal</td>
  </tr>
  <tr><td valign=\"top\"><b>startTime</b></td>
      <td valign=\"top\">Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
The <b>offset</b> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</HTML>
",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><i>Nov. 8, 1999</i>
       by <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><i>Oct. 31, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
    end Sources;

    package Tables
    "Library of blocks to interpolate in one and two-dimensional tables"
      extends Modelica.Icons.Package;

      model CombiTable1Ds
      "Table look-up in one dimension (matrix/file) with one input and n outputs"

        import Modelica.Blocks.Types;
        parameter Boolean tableOnFile=false
        "true, if table is defined on file or in function usertab"
          annotation(Dialog(group="table data definition"));
        parameter Real table[:, :]=fill(0.0,0,2)
        "table matrix (grid = first column; e.g., table=[0,2])"
             annotation(Dialog(group="table data definition", enable = not tableOnFile));
        parameter String tableName="NoName"
        "table name on file or in function usertab (see docu)"
             annotation(Dialog(group="table data definition", enable = tableOnFile));
        parameter String fileName="NoName" "file where matrix is stored"
             annotation(Dialog(group="table data definition", enable = tableOnFile,
                               __Dymola_loadSelector(filter="Text files (*.txt);;Matlab files (*.mat)",
                               caption="Open file in which table is present")));
        parameter Integer columns[:]=2:size(table, 2)
        "columns of table to be interpolated"
        annotation(Dialog(group="table data interpretation"));
        parameter Modelica.Blocks.Types.Smoothness smoothness=Types.Smoothness.LinearSegments
        "smoothness of table interpolation"
        annotation(Dialog(group="table data interpretation"));
        extends Modelica.Blocks.Interfaces.SIMO(final nout=size(columns, 1));

    protected
        Integer tableID;

        function tableInit
        "Initialize 1-dim. table defined by matrix (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)"
          input String tableName;
          input String fileName;
          input Real table[ :, :];
          input Modelica.Blocks.Types.Smoothness smoothness;
          output Integer tableID;
        external "C" tableID = ModelicaTables_CombiTable1D_init(
                       tableName, fileName, table, size(table, 1), size(table, 2),
                       smoothness);
          annotation(Library="ModelicaExternalC");
        end tableInit;

        function tableIpo
        "Interpolate 1-dim. table defined by matrix (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)"
          input Integer tableID;
          input Integer icol;
          input Real u;
          output Real value;
        external "C" value =
                           ModelicaTables_CombiTable1D_interpolate(tableID, icol, u);
          annotation(Library="ModelicaExternalC");
        end tableIpo;

      equation
        if tableOnFile then
          assert(tableName<>"NoName", "tableOnFile = true and no table name given");
        end if;
        if not tableOnFile then
          assert(size(table,1) > 0 and size(table,2) > 0, "tableOnFile = false and parameter table is an empty matrix");
        end if;

        for i in 1:nout loop
          y[i] = if not tableOnFile and size(table,1)==1 then
                   table[1, columns[i]] else tableIpo(tableID, columns[i], u);
        end for;
        when initial() then
          tableID=tableInit(if tableOnFile then tableName else "NoName",
                            if tableOnFile then fileName else "NoName", table, smoothness);
        end when;
        annotation (
          Documentation(info="<html>
<p>
<b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>.
Via parameter <b>columns</b> it can be defined how many columns of the
table are interpolated. If, e.g., icol={2,4}, it is assumed that one input
and 2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre>
<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new interpolation
     starts at the interval used in the last call.</li>
<li> If the table has only <b>one row</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u</b> is <b>outside</b> of the defined <b>interval</b>, i.e.,
     u &gt; table[size(table,1),1] or u &lt; table[1,1], the corresponding
     value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> The grid values (first column) have to be <b>strict</b>
     monotonically increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and binary file format is possible.
      (the ASCII format is described below).
      It is most convenient to generate the binary file from Matlab
      (Matlab 4 storage format), e.g., by command
<pre>
   save tables.mat tab1 tab2 tab3 -V4
</pre>
      when the three tables tab1, tab2, tab3 should be
      used from the model.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks.</li>
</ol>
<p>
Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
and do not access files, whereas method (2) does. Therefore (1) and (3)
are suited for hardware-in-the-loop simulation (e.g., with dSpace hardware).
When the constant \"NO_FILE\" is defined, all parts of the
source code of method (2) are removed by the C-preprocessor, such that
no dynamic memory allocation and no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file need to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\". Afterwards, the corresponding matrix has to be declared
with type, name and actual dimensions. Finally, in successive
rows of the file, the elements of the matrix have to be given.
Several matrices may be defined one after another.
</p>
</HTML>
"),       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,
                    -40},{-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},
                    {60,-20},{60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}, color={
                    0,0,0}),
              Line(points={{0,40},{0,-40}}, color={0,0,0}),
              Rectangle(
                extent={{-60,40},{-30,20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,20},{-30,0}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,0},{-30,-20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,-20},{-30,-40}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-60,60},{60,-60}},
                fillColor={235,235,235},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Line(points={{-100,0},{-58,0}}, color={0,0,255}),
              Line(points={{60,0},{100,0}}, color={0,0,255}),
              Text(
                extent={{-100,100},{100,64}},
                textString="1 dimensional linear table interpolation",
                lineColor={0,0,255}),
              Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                    -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                    {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                    0,0,0}),
              Line(points={{0,40},{0,-40}}, color={0,0,0}),
              Rectangle(
                extent={{-54,40},{-28,20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,20},{-28,0}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,0},{-28,-20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,-20},{-28,-40}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-52,56},{-34,44}},
                textString="u",
                lineColor={0,0,255}),
              Text(
                extent={{-22,54},{2,42}},
                textString="y[1]",
                lineColor={0,0,255}),
              Text(
                extent={{4,54},{28,42}},
                textString="y[2]",
                lineColor={0,0,255}),
              Text(
                extent={{0,-40},{32,-54}},
                textString="columns",
                lineColor={0,0,255})}));
      end CombiTable1Ds;
      annotation (Documentation(info="<html>
<p>
This package contains blocks for one- and two-dimensional
interpolation in tables.
</p>
</html>"));
    end Tables;

    package Types
    "Library of constants and types with choices, especially to build menus"
      extends Modelica.Icons.Package;

      type Smoothness = enumeration(
        LinearSegments "Table points are linearly interpolated",
        ContinuousDerivative
          "Table points are interpolated such that the first derivative is continuous")
      "Enumeration defining the smoothness of table interpolation";

      type Extrapolation = enumeration(
        HoldLastPoint "Hold the last table point outside of the table scope",
        LastTwoPoints
          "Extrapolate linearly through the last two table points outside of the table scope",

        Periodic "Repeat the table scope periodically")
      "Enumeration defining the extrapolation of time table interpolation";
      annotation ( Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
    end Types;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(extent={{-32,-6},{16,-35}}, lineColor={0,0,0}),
        Rectangle(extent={{-32,-56},{16,-85}}, lineColor={0,0,0}),
        Line(points={{16,-20},{49,-20},{49,-71},{16,-71}}, color={0,0,0}),
        Line(points={{-32,-72},{-64,-72},{-64,-21},{-32,-21}}, color={0,0,0}),
        Polygon(
          points={{16,-71},{29,-67},{29,-74},{16,-71}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-21},{-46,-17},{-46,-25},{-32,-21}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
                            Documentation(info="<html>
<p>
This library contains input/output blocks to build up block diagrams.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<p>
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
",   revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced new block connectors and adapated all blocks to the new connectors.
       Included subpackages Continuous, Discrete, Logical, Nonlinear from
       package ModelicaAdditions.Blocks.
       Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
       and in the new package Modelica.Blocks.Tables.
       Added new blocks to Blocks.Sources and Blocks.Logical.
       </li>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New subpackage Examples, additional components.
       </li>
<li><i>June 20, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
       Michael Tiller:<br>
       Introduced a replaceable signal type into
       Blocks.Interfaces.RealInput/RealOutput:
<pre>
   replaceable type SignalType = Real
</pre>
       in order that the type of the signal of an input/output block
       can be changed to a physical type, for example:
<pre>
   Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre>
      </li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed to Blocks. New subpackages Math, Nonlinear.
       Additional components in subpackages Interfaces, Continuous
       and Sources. </li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
  end Blocks;

  package Media "Library of media property models"
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;

  package Interfaces "Interfaces for media models"
    extends Modelica.Icons.InterfacesPackage;
    import SI = Modelica.SIunits;

    partial package PartialMedium
    "Partial medium properties (base package of all media packages)"

      import SI = Modelica.SIunits;
      extends Modelica.Icons.MaterialPropertiesPackage;

      // Constants to be set in Medium
      constant
      Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables
        ThermoStates "Enumeration type for independent variables";
      constant String mediumName = "unusablePartialMedium" "Name of the medium";
      constant String substanceNames[:]={mediumName}
      "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
      constant String extraPropertiesNames[:]=fill("", 0)
      "Names of the additional (extra) transported properties. Set extraPropertiesNames=fill(\"\",0) if unused";
      constant Boolean singleState
      "= true, if u and d are not a function of pressure";
      constant Boolean reducedX=true
      "= true if medium contains the equation sum(X) = 1.0; set reducedX=true if only one substance (see docu for details)";
      constant Boolean fixedX=false
      "= true if medium contains the equation X = reference_X";
      constant AbsolutePressure reference_p=101325
      "Reference pressure of Medium: default 1 atmosphere";
      constant Temperature reference_T=298.15
      "Reference temperature of Medium: default 25 deg Celsius";
      constant MassFraction reference_X[nX]= fill(1/nX, nX)
      "Default mass fractions of medium";
      constant AbsolutePressure p_default=101325
      "Default value for pressure of medium (for initialization)";
      constant Temperature T_default = Modelica.SIunits.Conversions.from_degC(20)
      "Default value for temperature of medium (for initialization)";
      constant SpecificEnthalpy h_default = specificEnthalpy_pTX(p_default, T_default, X_default)
      "Default value for specific enthalpy of medium (for initialization)";
      constant MassFraction X_default[nX]=reference_X
      "Default value for mass fractions of medium (for initialization)";

      final constant Integer nS=size(substanceNames, 1) "Number of substances" annotation(Evaluate=true);
      constant Integer nX = nS "Number of mass fractions"
                                   annotation(Evaluate=true);
      constant Integer nXi=if fixedX then 0 else if reducedX then nS - 1 else nS
      "Number of structurally independent mass fractions (see docu for details)"
        annotation(Evaluate=true);

      final constant Integer nC=size(extraPropertiesNames, 1)
      "Number of extra (outside of standard mass-balance) transported properties"
       annotation(Evaluate=true);
      constant Real C_nominal[nC](min=fill(Modelica.Constants.eps, nC)) = 1.0e-6*ones(nC)
      "Default for the nominal values for the extra properties";
      replaceable record FluidConstants
      "critical, triple, molecular and other standard data of fluid"
        extends Modelica.Icons.Record;
        String iupacName
        "complete IUPAC name (or common name, if non-existent)";
        String casRegistryNumber
        "chemical abstracts sequencing number (if it exists)";
        String chemicalFormula
        "Chemical formula, (brutto, nomenclature according to Hill";
        String structureFormula "Chemical structure formula";
        MolarMass molarMass "molar mass";
      end FluidConstants;

      replaceable record ThermodynamicState
      "Minimal variable set that is available as input argument to every medium function"
        extends Modelica.Icons.Record;
      end ThermodynamicState;

      replaceable partial model BaseProperties
      "Base properties (p, d, T, h, u, R, MM and, if applicable, X and Xi) of a medium"
        InputAbsolutePressure p "Absolute pressure of medium";
        InputMassFraction[nXi] Xi(start=reference_X[1:nXi])
        "Structurally independent mass fractions";
        InputSpecificEnthalpy h "Specific enthalpy of medium";
        Density d "Density of medium";
        Temperature T "Temperature of medium";
        MassFraction[nX] X(start=reference_X)
        "Mass fractions (= (component mass)/total mass  m_i/m)";
        SpecificInternalEnergy u "Specific internal energy of medium";
        SpecificHeatCapacity R "Gas constant (of mixture if applicable)";
        MolarMass MM "Molar mass (of mixture or single fluid)";
        ThermodynamicState state
        "thermodynamic state record for optional functions";
        parameter Boolean preferredMediumStates=false
        "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
          annotation (Evaluate=true, Dialog(tab="Advanced"));
        parameter Boolean standardOrderComponents = true
        "if true, and reducedX = true, the last element of X will be computed from the other ones";
        SI.Conversions.NonSIunits.Temperature_degC T_degC=
            Modelica.SIunits.Conversions.to_degC(T)
        "Temperature of medium in [degC]";
        SI.Conversions.NonSIunits.Pressure_bar p_bar=
         Modelica.SIunits.Conversions.to_bar(p)
        "Absolute pressure of medium in [bar]";

        // Local connector definition, used for equation balancing check
        connector InputAbsolutePressure = input SI.AbsolutePressure
        "Pressure as input signal connector";
        connector InputSpecificEnthalpy = input SI.SpecificEnthalpy
        "Specific enthalpy as input signal connector";
        connector InputMassFraction = input SI.MassFraction
        "Mass fraction as input signal connector";

      equation
        if standardOrderComponents then
          Xi = X[1:nXi];

            if fixedX then
              X = reference_X;
            end if;
            if reducedX and not fixedX then
              X[nX] = 1 - sum(Xi);
            end if;
            for i in 1:nX loop
              assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "Mass fraction X[" +
                     String(i) + "] = " + String(X[i]) + "of substance "
                     + substanceNames[i] + "\nof medium " + mediumName + " is not in the range 0..1");
            end for;

        end if;

        assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" +
          mediumName + "\" is negative\n(Temperature = " + String(T) + " K)");
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}), Text(
                extent={{-152,164},{152,102}},
                textString="%name",
                lineColor={0,0,255})}),
                    Documentation(info="<html>
<p>
Model <b>BaseProperties</b> is a model within package <b>PartialMedium</b>
and contains the <b>declarations</b> of the minimum number of
variables that every medium model is supposed to support.
A specific medium inherits from model <b>BaseProperties</b> and provides
the equations for the basic properties.</p>
<p>
The BaseProperties model contains the following <b>7+nXi variables</b>
(nXi is the number of independent mass fractions defined in package
PartialMedium):
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">absolute pressure</td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</td></tr>
  <tr><td valign=\"top\">Xi[nXi]</td>
      <td valign=\"top\">kg/kg</td>
      <td valign=\"top\">independent mass fractions m_i/m</td></tr>
  <tr><td valign=\"top\">R</td>
      <td valign=\"top\">J/kg.K</td>
      <td valign=\"top\">gas constant</td></tr>
  <tr><td valign=\"top\">M</td>
      <td valign=\"top\">kg/mol</td>
      <td valign=\"top\">molar mass</td></tr>
</table>
<p>
In order to implement an actual medium model, one can extend from this
base model and add <b>5 equations</b> that provide relations among
these variables. Equations will also have to be added in order to
set all the variables within the ThermodynamicState record state.</p>
<p>
If standardOrderComponents=true, the full composition vector X[nX]
is determined by the equations contained in this base class, depending
on the independent mass fraction vector Xi[nXi].</p>
<p>Additional <b>2 + nXi</b> equations will have to be provided
when using the BaseProperties model, in order to fully specify the
thermodynamic conditions. The input connector qualifier applied to
p, h, and nXi indirectly declares the number of missing equations,
permitting advanced equation balance checking by Modelica tools.
Please note that this doesn't mean that the additional equations
should be connection equations, nor that exactly those variables
should be supplied, in order to complete the model.
For further information, see the Modelica.Media User's guide, and
Section 4.7 (Balanced Models) of the Modelica 3.0 specification.</p>
</html>"));
      end BaseProperties;

      replaceable partial function setState_pTX
      "Return thermodynamic state as function of p, T and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      end setState_pTX;

      replaceable partial function setState_phX
      "Return thermodynamic state as function of p, h and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      end setState_phX;

      replaceable partial function setState_psX
      "Return thermodynamic state as function of p, s and composition X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      end setState_psX;

      replaceable partial function setState_dTX
      "Return thermodynamic state as function of d, T and composition X or Xi"
        extends Modelica.Icons.Function;
        input Density d "density";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      end setState_dTX;

      replaceable partial function setSmoothState
      "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
        extends Modelica.Icons.Function;
        input Real x "m_flow or dp";
        input ThermodynamicState state_a "Thermodynamic state if x > 0";
        input ThermodynamicState state_b "Thermodynamic state if x < 0";
        input Real x_small(min=0)
        "Smooth transition in the region -x_small < x < x_small";
        output ThermodynamicState state
        "Smooth thermodynamic state for all x (continuous and differentiable)";
        annotation(Documentation(info="<html>
<p>
This function is used to approximate the equation
</p>
<pre>
    state = <b>if</b> x &gt; 0 <b>then</b> state_a <b>else</b> state_b;
</pre>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<pre>
   state := <b>smooth</b>(1, <b>if</b> x &gt;  x_small <b>then</b> state_a <b>else</b>
                      <b>if</b> x &lt; -x_small <b>then</b> state_b <b>else</b> f(state_a, state_b));
</pre>

<p>
This is performed by applying function <b>Media.Common.smoothStep</b>(..)
on every element of the thermodynamic state record.
</p>

<p>
If <b>mass fractions</b> X[:] are approximated with this function then this can be performed
for all <b>nX</b> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(state.X) = 1, provided sum(state_a.X) = sum(state_b.X) = 1.
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise state.X is either state_a.X or state_b.X):
</p>

<pre>
    X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
    X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
       ...
    X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre>

<p>
or
</p>

<pre>
    X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
    X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
       ...
    X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
    c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre>

<p>
Summing all mass fractions together results in
</p>

<pre>
    sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
           = c*(1 - 1) + (1 + 1)/2
           = 1
</pre>

</html>"));
      end setSmoothState;

      replaceable partial function dynamicViscosity "Return dynamic viscosity"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DynamicViscosity eta "Dynamic viscosity";
      end dynamicViscosity;

      replaceable partial function thermalConductivity
      "Return thermal conductivity"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output ThermalConductivity lambda "Thermal conductivity";
      end thermalConductivity;

      replaceable function prandtlNumber "Return the Prandtl number"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output PrandtlNumber Pr "Prandtl number";
      algorithm
        Pr := dynamicViscosity(state)*specificHeatCapacityCp(state)/thermalConductivity(
          state);
      end prandtlNumber;

      replaceable partial function pressure "Return pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output AbsolutePressure p "Pressure";
      end pressure;

      replaceable partial function temperature "Return temperature"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output Temperature T "Temperature";
      end temperature;

      replaceable partial function density "Return density"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output Density d "Density";
      end density;

      replaceable partial function specificEnthalpy "Return specific enthalpy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnthalpy h "Specific enthalpy";
      end specificEnthalpy;

      replaceable partial function specificInternalEnergy
      "Return specific internal energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnergy u "Specific internal energy";
      end specificInternalEnergy;

      replaceable partial function specificEntropy "Return specific entropy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEntropy s "Specific entropy";
      end specificEntropy;

      replaceable partial function specificGibbsEnergy
      "Return specific Gibbs energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnergy g "Specific Gibbs energy";
      end specificGibbsEnergy;

      replaceable partial function specificHelmholtzEnergy
      "Return specific Helmholtz energy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificEnergy f "Specific Helmholtz energy";
      end specificHelmholtzEnergy;

      replaceable partial function specificHeatCapacityCp
      "Return specific heat capacity at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificHeatCapacity cp
        "Specific heat capacity at constant pressure";
      end specificHeatCapacityCp;

      function heatCapacity_cp = specificHeatCapacityCp
      "alias for deprecated name";

      replaceable partial function specificHeatCapacityCv
      "Return specific heat capacity at constant volume"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SpecificHeatCapacity cv
        "Specific heat capacity at constant volume";
      end specificHeatCapacityCv;

      function heatCapacity_cv = specificHeatCapacityCv
      "alias for deprecated name";

      replaceable partial function isentropicExponent
      "Return isentropic exponent"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output IsentropicExponent gamma "Isentropic exponent";
      end isentropicExponent;

      replaceable partial function isentropicEnthalpy
      "Return isentropic enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p_downstream "downstream pressure";
        input ThermodynamicState refState "reference state for entropy";
        output SpecificEnthalpy h_is "Isentropic enthalpy";
        annotation(Documentation(info="<html>
<p>
This function computes an isentropic state transformation:
</p>
<ol>
<li> A medium is in a particular state, refState.</li>
<li> The enhalpy at another state (h_is) shall be computed
     under the assumption that the state transformation from refState to h_is
     is performed with a change of specific entropy ds = 0 and the pressure of state h_is
     is p_downstream and the composition X upstream and downstream is assumed to be the same.</li>
</ol>

</html>"));
      end isentropicEnthalpy;

      replaceable partial function velocityOfSound "Return velocity of sound"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output VelocityOfSound a "Velocity of sound";
      end velocityOfSound;

      replaceable partial function isobaricExpansionCoefficient
      "Return overall the isobaric expansion coefficient beta"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output IsobaricExpansionCoefficient beta
        "Isobaric expansion coefficient";
        annotation(Documentation(info="<html>
<pre>
beta is defined as  1/v * der(v,T), with v = 1/d, at constant pressure p.
</pre>
</html>"));
      end isobaricExpansionCoefficient;

      function beta = isobaricExpansionCoefficient
      "alias for isobaricExpansionCoefficient for user convenience";

      replaceable partial function isothermalCompressibility
      "Return overall the isothermal compressibility factor"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output SI.IsothermalCompressibility kappa "Isothermal compressibility";
        annotation(Documentation(info="<html>
<pre>

kappa is defined as - 1/v * der(v,p), with v = 1/d at constant temperature T.

</pre>
</html>"));
      end isothermalCompressibility;

      function kappa = isothermalCompressibility
      "alias of isothermalCompressibility for user convenience";

      // explicit derivative functions for finite element models
      replaceable partial function density_derp_h
      "Return density derivative w.r.t. pressure at const specific enthalpy"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByPressure ddph "Density derivative w.r.t. pressure";
      end density_derp_h;

      replaceable partial function density_derh_p
      "Return density derivative w.r.t. specific enthalpy at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByEnthalpy ddhp
        "Density derivative w.r.t. specific enthalpy";
      end density_derh_p;

      replaceable partial function density_derp_T
      "Return density derivative w.r.t. pressure at const temperature"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByPressure ddpT "Density derivative w.r.t. pressure";
      end density_derp_T;

      replaceable partial function density_derT_p
      "Return density derivative w.r.t. temperature at constant pressure"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output DerDensityByTemperature ddTp
        "Density derivative w.r.t. temperature";
      end density_derT_p;

      replaceable partial function density_derX
      "Return density derivative w.r.t. mass fraction"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output Density[nX] dddX "Derivative of density w.r.t. mass fraction";
      end density_derX;

      replaceable partial function molarMass
      "Return the molar mass of the medium"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state record";
        output MolarMass MM "Mixture molar mass";
      end molarMass;

      replaceable function specificEnthalpy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_pTX(p,T,X));
        annotation(inverse(T = temperature_phX(p,h,X)));
      end specificEnthalpy_pTX;

      replaceable function specificEntropy_pTX
      "Return specific enthalpy from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output SpecificEntropy s "Specific entropy";
      algorithm
        s := specificEntropy(setState_pTX(p,T,X));

        annotation(inverse(T = temperature_psX(p,s,X)));
      end specificEntropy_pTX;

      replaceable function density_pTX "Return density from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:] "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_pTX(p,T,X));
      end density_pTX;

      replaceable function temperature_phX
      "Return temperature from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_phX(p,h,X));
      end temperature_phX;

      replaceable function density_phX "Return density from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_phX(p,h,X));
      end density_phX;

      replaceable function temperature_psX
      "Return temperature from p,s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := temperature(setState_psX(p,s,X));
        annotation(inverse(s = specificEntropy_pTX(p,T,X)));
      end temperature_psX;

      replaceable function density_psX "Return density from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output Density d "Density";
      algorithm
        d := density(setState_psX(p,s,X));
      end density_psX;

      replaceable function specificEnthalpy_psX
      "Return specific enthalpy from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output SpecificEnthalpy h "Specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_psX(p,s,X));
      end specificEnthalpy_psX;

      type AbsolutePressure = SI.AbsolutePressure (
          min=0,
          max=1.e8,
          nominal=1.e5,
          start=1.e5)
      "Type for absolute pressure with medium specific attributes";

      type Density = SI.Density (
          min=0,
          max=1.e5,
          nominal=1,
          start=1) "Type for density with medium specific attributes";
      type DynamicViscosity = SI.DynamicViscosity (
          min=0,
          max=1.e8,
          nominal=1.e-3,
          start=1.e-3)
      "Type for dynamic viscosity with medium specific attributes";
      type EnthalpyFlowRate = SI.EnthalpyFlowRate (
          nominal=1000.0,
          min=-1.0e8,
          max=1.e8)
      "Type for enthalpy flow rate with medium specific attributes";
      type MassFlowRate = SI.MassFlowRate (
          quantity="MassFlowRate." + mediumName,
          min=-1.0e5,
          max=1.e5) "Type for mass flow rate with medium specific attributes";
      type MassFraction = Real (
          quantity="MassFraction",
          final unit="kg/kg",
          min=0,
          max=1,
          nominal=0.1) "Type for mass fraction with medium specific attributes";
      type MoleFraction = Real (
          quantity="MoleFraction",
          final unit="mol/mol",
          min=0,
          max=1,
          nominal=0.1) "Type for mole fraction with medium specific attributes";
      type MolarMass = SI.MolarMass (
          min=0.001,
          max=0.25,
          nominal=0.032) "Type for molar mass with medium specific attributes";
      type MolarVolume = SI.MolarVolume (
          min=1e-6,
          max=1.0e6,
          nominal=1.0) "Type for molar volume with medium specific attributes";
      type IsentropicExponent = SI.RatioOfSpecificHeatCapacities (
          min=1,
          max=500000,
          nominal=1.2,
          start=1.2)
      "Type for isentropic exponent with medium specific attributes";
      type SpecificEnergy = SI.SpecificEnergy (
          min=-1.0e8,
          max=1.e8,
          nominal=1.e6)
      "Type for specific energy with medium specific attributes";
      type SpecificInternalEnergy = SpecificEnergy
      "Type for specific internal energy with medium specific attributes";
      type SpecificEnthalpy = SI.SpecificEnthalpy (
          min=-1.0e10,
          max=1.e10,
          nominal=1.e6)
      "Type for specific enthalpy with medium specific attributes";
      type SpecificEntropy = SI.SpecificEntropy (
          min=-1.e7,
          max=1.e7,
          nominal=1.e3)
      "Type for specific entropy with medium specific attributes";
      type SpecificHeatCapacity = SI.SpecificHeatCapacity (
          min=0,
          max=1.e7,
          nominal=1.e3,
          start=1.e3)
      "Type for specific heat capacity with medium specific attributes";
      type SurfaceTension = SI.SurfaceTension
      "Type for surface tension with medium specific attributes";
      type Temperature = SI.Temperature (
          min=1,
          max=1.e4,
          nominal=300,
          start=300) "Type for temperature with medium specific attributes";
      type ThermalConductivity = SI.ThermalConductivity (
          min=0,
          max=500,
          nominal=1,
          start=1)
      "Type for thermal conductivity with medium specific attributes";
      type PrandtlNumber = SI.PrandtlNumber (
          min=1e-3,
          max=1e5,
          nominal=1.0)
      "Type for Prandtl number with medium specific attributes";
      type VelocityOfSound = SI.Velocity (
          min=0,
          max=1.e5,
          nominal=1000,
          start=1000)
      "Type for velocity of sound with medium specific attributes";
      type ExtraProperty = Real (min=0.0, start=1.0)
      "Type for unspecified, mass-specific property transported by flow";
      type CumulativeExtraProperty = Real (min=0.0, start=1.0)
      "Type for conserved integral of unspecified, mass specific property";
      type ExtraPropertyFlowRate = Real(unit="kg/s")
      "Type for flow rate of unspecified, mass-specific property";
      type IsobaricExpansionCoefficient = Real (
          min=0,
          max=1.0e8,
          unit="1/K")
      "Type for isobaric expansion coefficient with medium specific attributes";
      type DipoleMoment = Real (
          min=0.0,
          max=2.0,
          unit="debye",
          quantity="ElectricDipoleMoment")
      "Type for dipole moment with medium specific attributes";

      type DerDensityByPressure = SI.DerDensityByPressure
      "Type for partial derivative of density with resect to pressure with medium specific attributes";
      type DerDensityByEnthalpy = SI.DerDensityByEnthalpy
      "Type for partial derivative of density with resect to enthalpy with medium specific attributes";
      type DerEnthalpyByPressure = SI.DerEnthalpyByPressure
      "Type for partial derivative of enthalpy with resect to pressure with medium specific attributes";
      type DerDensityByTemperature = SI.DerDensityByTemperature
      "Type for partial derivative of density with resect to temperature with medium specific attributes";

      package Choices "Types, constants to define menu choices"

        type IndependentVariables = enumeration(
          T "Temperature",
          pT "Pressure, Temperature",
          ph "Pressure, Specific Enthalpy",
          phX "Pressure, Specific Enthalpy, Mass Fraction",
          pTX "Pressure, Temperature, Mass Fractions",
          dTX "Density, Temperature, Mass Fractions")
        "Enumeration defining the independent variables of a medium";

        type Init = enumeration(
          NoInit "NoInit (no initialization)",
          InitialStates "InitialStates (initialize medium states)",
          SteadyState "SteadyState (initialize in steady state)",
          SteadyMass
            "SteadyMass (initialize density or pressure in steady state)")
        "Enumeration defining initialization for fluid flow"
                  annotation (Evaluate=true);

        type ReferenceEnthalpy = enumeration(
          ZeroAt0K
            "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",

          ZeroAt25C
            "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",

          UserDefined
            "The user-defined reference enthalpy is used at 293.15 K (25 degC)")
        "Enumeration defining the reference enthalpy of a medium"
            annotation (Evaluate=true);

        type ReferenceEntropy = enumeration(
          ZeroAt0K "The entropy is 0 at 0 K (default)",
          ZeroAt0C "The entropy is 0 at 0 degC",
          UserDefined
            "The user-defined reference entropy is used at 293.15 K (25 degC)")
        "Enumeration defining the reference entropy of a medium"
            annotation (Evaluate=true);

        type pd = enumeration(
          default "Default (no boundary condition for p or d)",
          p_known "p_known (pressure p is known)",
          d_known "d_known (density d is known)")
        "Enumeration defining whether p or d are known for the boundary condition"
            annotation (Evaluate=true);

        type Th = enumeration(
          default "Default (no boundary condition for T or h)",
          T_known "T_known (temperature T is known)",
          h_known "h_known (specific enthalpy h is known)")
        "Enumeration defining whether T or h are known as boundary condition"
            annotation (Evaluate=true);

        annotation (Documentation(info="<html>
<p>
Enumerations and data types for all types of fluids
</p>

<p>
Note: Reference enthalpy might have to be extended with enthalpy of formation.
</p>
</html>"));
      end Choices;

      annotation (Documentation(info="<html>
<p>
<b>PartialMedium</b> is a package and contains all <b>declarations</b> for
a medium. This means that constants, models, and functions
are defined that every medium is supposed to support
(some of them are optional). A medium package
inherits from <b>PartialMedium</b> and provides the
equations for the medium. The details of this package
are described in
<a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.
</p>
</html>
",   revisions="<html>

</html>"));
    end PartialMedium;

    partial package PartialPureSubstance
    "base class for pure substances of one chemical substance"
      extends PartialMedium(final reducedX = true, final fixedX=true);

     replaceable function setState_pT "Return thermodynamic state from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output ThermodynamicState state "thermodynamic state record";
     algorithm
        state := setState_pTX(p,T,fill(0,0));
     end setState_pT;

      replaceable function setState_ph
      "Return thermodynamic state from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        output ThermodynamicState state "thermodynamic state record";
      algorithm
        state := setState_phX(p,h,fill(0, 0));
      end setState_ph;

      replaceable function setState_ps
      "Return thermodynamic state from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output ThermodynamicState state "thermodynamic state record";
      algorithm
        state := setState_psX(p,s,fill(0,0));
      end setState_ps;

      replaceable function setState_dT
      "Return thermodynamic state from d and T"
        extends Modelica.Icons.Function;
        input Density d "density";
        input Temperature T "Temperature";
        output ThermodynamicState state "thermodynamic state record";
      algorithm
        state := setState_dTX(d,T,fill(0,0));
      end setState_dT;

      replaceable function density_ph "Return density from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        output Density d "Density";
      algorithm
        d := density_phX(p, h, fill(0,0));
      end density_ph;

      replaceable function temperature_ph "Return temperature from p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        output Temperature T "Temperature";
      algorithm
        T := temperature_phX(p, h, fill(0,0));
      end temperature_ph;

      replaceable function pressure_dT "Return pressure from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        output AbsolutePressure p "Pressure";
      algorithm
        p := pressure(setState_dTX(d, T, fill(0,0)));
      end pressure_dT;

      replaceable function specificEnthalpy_dT
      "Return specific enthalpy from d and T"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := specificEnthalpy(setState_dTX(d, T, fill(0,0)));
      end specificEnthalpy_dT;

      replaceable function specificEnthalpy_ps
      "Return specific enthalpy from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := specificEnthalpy_psX(p,s,fill(0,0));
      end specificEnthalpy_ps;

      replaceable function temperature_ps "Return temperature from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output Temperature T "Temperature";
      algorithm
        T := temperature_psX(p,s,fill(0,0));
      end temperature_ps;

      replaceable function density_ps "Return density from p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        output Density d "Density";
      algorithm
        d := density_psX(p, s, fill(0,0));
      end density_ps;

      replaceable function specificEnthalpy_pT
      "Return specific enthalpy from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output SpecificEnthalpy h "specific enthalpy";
      algorithm
        h := specificEnthalpy_pTX(p, T, fill(0,0));
      end specificEnthalpy_pT;

      replaceable function density_pT "Return density from p and T"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        output Density d "Density";
      algorithm
        d := density(setState_pTX(p, T, fill(0,0)));
      end density_pT;

      redeclare replaceable partial model extends BaseProperties(
        final standardOrderComponents=true)
      end BaseProperties;
    end PartialPureSubstance;

  partial package PartialMixtureMedium
    "Base class for pure substances of several chemical substances"
      extends PartialMedium;

      redeclare replaceable record extends ThermodynamicState
      "thermodynamic state variables"
        AbsolutePressure p "Absolute pressure of medium";
        Temperature T "Temperature of medium";
        MassFraction X[nX]
        "Mass fractions (= (component mass)/total mass  m_i/m)";
      end ThermodynamicState;

      redeclare replaceable record extends FluidConstants
      "extended fluid constants"
        Temperature criticalTemperature "critical temperature";
        AbsolutePressure criticalPressure "critical pressure";
        MolarVolume criticalMolarVolume "critical molar Volume";
        Real acentricFactor "Pitzer acentric factor";
        Temperature triplePointTemperature "triple point temperature";
        AbsolutePressure triplePointPressure "triple point pressure";
        Temperature meltingPoint "melting point at 101325 Pa";
        Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
        DipoleMoment dipoleMoment
        "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
        Boolean hasIdealGasHeatCapacity=false
        "true if ideal gas heat capacity is available";
        Boolean hasCriticalData=false "true if critical data are known";
        Boolean hasDipoleMoment=false "true if a dipole moment known";
        Boolean hasFundamentalEquation=false "true if a fundamental equation";
        Boolean hasLiquidHeatCapacity=false
        "true if liquid heat capacity is available";
        Boolean hasSolidHeatCapacity=false
        "true if solid heat capacity is available";
        Boolean hasAccurateViscosityData=false
        "true if accurate data for a viscosity function is available";
        Boolean hasAccurateConductivityData=false
        "true if accurate data for thermal conductivity is available";
        Boolean hasVapourPressureCurve=false
        "true if vapour pressure data, e.g., Antoine coefficents are known";
        Boolean hasAcentricFactor=false
        "true if Pitzer accentric factor is known";
        SpecificEnthalpy HCRIT0=0.0
        "Critical specific enthalpy of the fundamental equation";
        SpecificEntropy SCRIT0=0.0
        "Critical specific entropy of the fundamental equation";
        SpecificEnthalpy deltah=0.0
        "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
        SpecificEntropy deltas=0.0
        "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
      end FluidConstants;

    constant FluidConstants[nS] fluidConstants "constant data for the fluid";

    replaceable function gasConstant
      "Return the gas constant of the mixture (also for liquids)"
        extends Modelica.Icons.Function;
        input ThermodynamicState state "thermodynamic state";
        output SI.SpecificHeatCapacity R "mixture gas constant";
    end gasConstant;

      function moleToMassFractions
      "Return mass fractions X from mole fractions"
        extends Modelica.Icons.Function;
        input SI.MoleFraction moleFractions[:] "Mole fractions of mixture";
        input MolarMass[:] MMX "molar masses of components";
        output SI.MassFraction X[size(moleFractions, 1)]
        "Mass fractions of gas mixture";
    protected
        MolarMass Mmix =  moleFractions*MMX "molar mass of mixture";
      algorithm
        for i in 1:size(moleFractions, 1) loop
          X[i] := moleFractions[i]*MMX[i] /Mmix;
        end for;
        annotation(smoothOrder=5);
      end moleToMassFractions;

      function massToMoleFractions
      "Return mole fractions from mass fractions X"
        extends Modelica.Icons.Function;
        input SI.MassFraction X[:] "Mass fractions of mixture";
        input SI.MolarMass[:] MMX "molar masses of components";
        output SI.MoleFraction moleFractions[size(X, 1)]
        "Mole fractions of gas mixture";
    protected
        Real invMMX[size(X, 1)] "inverses of molar weights";
        SI.MolarMass Mmix "molar mass of mixture";
      algorithm
        for i in 1:size(X, 1) loop
          invMMX[i] := 1/MMX[i];
        end for;
        Mmix := 1/(X*invMMX);
        for i in 1:size(X, 1) loop
          moleFractions[i] := Mmix*X[i]/MMX[i];
        end for;
        annotation(smoothOrder=5);
      end massToMoleFractions;

  end PartialMixtureMedium;

    partial package PartialCondensingGases
    "Base class for mixtures of condensing and non-condensing gases"
      extends PartialMixtureMedium(
           ThermoStates = Choices.IndependentVariables.pTX);

    replaceable partial function saturationPressure
      "Return saturation pressure of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature Tsat "saturation temperature";
      output AbsolutePressure psat "saturation pressure";
    end saturationPressure;

    replaceable partial function enthalpyOfVaporization
      "Return vaporization enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      output SpecificEnthalpy r0 "vaporization enthalpy";
    end enthalpyOfVaporization;

    replaceable partial function enthalpyOfLiquid
      "Return liquid enthalpy of condensing fluid"
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      output SpecificEnthalpy h "liquid enthalpy";
    end enthalpyOfLiquid;

    replaceable partial function enthalpyOfGas
      "Return enthalpy of non-condensing gas mixture"
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      input MassFraction[:] X "vector of mass fractions";
      output SpecificEnthalpy h "specific enthalpy";
    end enthalpyOfGas;

    replaceable partial function enthalpyOfCondensingGas
      "Return enthalpy of condensing gas (most often steam)"
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      output SpecificEnthalpy h "specific enthalpy";
    end enthalpyOfCondensingGas;

    replaceable partial function enthalpyOfNonCondensingGas
      "Return enthalpy of the non-condensing species"
      extends Modelica.Icons.Function;
      input Temperature T "temperature";
      output SpecificEnthalpy h "specific enthalpy";
    end enthalpyOfNonCondensingGas;
    end PartialCondensingGases;
    annotation (Documentation(info="<HTML>
<p>
This package provides basic interfaces definitions of media models for different
kind of media.
</p>
</HTML>"));
  end Interfaces;

  package Common
    "data structures and fundamental functions for fluid properties"
    extends Modelica.Icons.Package;

    function smoothStep
    "Approximation of a general step, such that the characteristic is continuous and differentiable"
      extends Modelica.Icons.Function;
      input Real x "Abszissa value";
      input Real y1 "Ordinate value for x > 0";
      input Real y2 "Ordinate value for x < 0";
      input Real x_small(min=0) = 1e-5
      "Approximation of step for -x_small <= x <= x_small; x_small > 0 required";
      output Real y
      "Ordinate value to approximate y = if x > 0 then y1 else y2";
    algorithm
      y := smooth(1, if x >  x_small then y1 else
                     if x < -x_small then y2 else
                     if abs(x_small)>0 then (x/x_small)*((x/x_small)^2 - 3)*(y2-y1)/4 + (y1+y2)/2 else (y1+y2)/2);

      annotation(Documentation(revisions="<html>
<ul>
<li><i>April 29, 2008</i>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implemented.</li>
<li><i>August 12, 2008</i>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>",   info="<html>
<p>
This function is used to approximate the equation
</p>
<pre>
    y = <b>if</b> x &gt; 0 <b>then</b> y1 <b>else</b> y2;
</pre>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<pre>
   y = <b>smooth</b>(1, <b>if</b> x &gt;  x_small <b>then</b> y1 <b>else</b>
                 <b>if</b> x &lt; -x_small <b>then</b> y2 <b>else</b> f(y1, y2));
</pre>

<p>
In the region -x_small &lt; x &lt; x_small a 2nd order polynomial is used
for a smooth transition from y1 to y2.
</p>

<p>
If <b>mass fractions</b> X[:] are approximated with this function then this can be performed
for all <b>nX</b> mass fractions, instead of applying it for nX-1 mass fractions and computing
the last one by the mass fraction constraint sum(X)=1. The reason is that the approximating function has the
property that sum(X) = 1, provided sum(X_a) = sum(X_b) = 1
(and y1=X_a[i], y2=X_b[i]).
This can be shown by evaluating the approximating function in the abs(x) &lt; x_small
region (otherwise X is either X_a or X_b):
</p>

<pre>
    X[1]  = smoothStep(x, X_a[1] , X_b[1] , x_small);
    X[2]  = smoothStep(x, X_a[2] , X_b[2] , x_small);
       ...
    X[nX] = smoothStep(x, X_a[nX], X_b[nX], x_small);
</pre>

<p>
or
</p>

<pre>
    X[1]  = c*(X_a[1]  - X_b[1])  + (X_a[1]  + X_b[1])/2
    X[2]  = c*(X_a[2]  - X_b[2])  + (X_a[2]  + X_b[2])/2;
       ...
    X[nX] = c*(X_a[nX] - X_b[nX]) + (X_a[nX] + X_b[nX])/2;
    c     = (x/x_small)*((x/x_small)^2 - 3)/4
</pre>

<p>
Summing all mass fractions together results in
</p>

<pre>
    sum(X) = c*(sum(X_a) - sum(X_b)) + (sum(X_a) + sum(X_b))/2
           = c*(1 - 1) + (1 + 1)/2
           = 1
</pre>
</html>"));
    end smoothStep;

   package OneNonLinearEquation
    "Determine solution of a non-linear algebraic equation in one unknown without derivatives in a reliable and efficient way"
     extends Modelica.Icons.Package;

      replaceable record f_nonlinear_Data
      "Data specific for function f_nonlinear"
        extends Modelica.Icons.Record;
      end f_nonlinear_Data;

      replaceable partial function f_nonlinear
      "Nonlinear algebraic equation in one unknown: y = f_nonlinear(x,p,X)"
        extends Modelica.Icons.Function;
        input Real x "Independent variable of function";
        input Real p = 0.0
        "disregaded variables (here always used for pressure)";
        input Real[:] X = fill(0,0)
        "disregaded variables (her always used for composition)";
        input f_nonlinear_Data f_nonlinear_data
        "Additional data for the function";
        output Real y "= f_nonlinear(x)";
        // annotation(derivative(zeroDerivative=y)); // this must hold for all replaced functions
      end f_nonlinear;

      replaceable function solve
      "Solve f_nonlinear(x_zero)=y_zero; f_nonlinear(x_min) - y_zero and f_nonlinear(x_max)-y_zero must have different sign"
        import Modelica.Utilities.Streams.error;
        extends Modelica.Icons.Function;
        input Real y_zero
        "Determine x_zero, such that f_nonlinear(x_zero) = y_zero";
        input Real x_min "Minimum value of x";
        input Real x_max "Maximum value of x";
        input Real pressure = 0.0
        "disregaded variables (here always used for pressure)";
        input Real[:] X = fill(0,0)
        "disregaded variables (here always used for composition)";
         input f_nonlinear_Data f_nonlinear_data
        "Additional data for function f_nonlinear";
         input Real x_tol =  100*Modelica.Constants.eps
        "Relative tolerance of the result";
         output Real x_zero "f_nonlinear(x_zero) = y_zero";
    protected
         constant Real eps = Modelica.Constants.eps "machine epsilon";
         constant Real x_eps = 1e-10
        "Slight modification of x_min, x_max, since x_min, x_max are usually exactly at the borders T_min/h_min and then small numeric noise may make the interval invalid";
         Real x_min2 = x_min - x_eps;
         Real x_max2 = x_max + x_eps;
         Real a = x_min2 "Current best minimum interval value";
         Real b = x_max2 "Current best maximum interval value";
         Real c "Intermediate point a <= c <= b";
         Real d;
         Real e "b - a";
         Real m;
         Real s;
         Real p;
         Real q;
         Real r;
         Real tol;
         Real fa "= f_nonlinear(a) - y_zero";
         Real fb "= f_nonlinear(b) - y_zero";
         Real fc;
         Boolean found = false;
      algorithm
         // Check that f(x_min) and f(x_max) have different sign
         fa :=f_nonlinear(x_min2, pressure, X, f_nonlinear_data) - y_zero;
         fb :=f_nonlinear(x_max2, pressure, X, f_nonlinear_data) - y_zero;
         fc := fb;
         if fa > 0.0 and fb > 0.0 or
            fa < 0.0 and fb < 0.0 then
            error("The arguments x_min and x_max to OneNonLinearEquation.solve(..)\n" +
                  "do not bracket the root of the single non-linear equation:\n" +
                  "  x_min  = " + String(x_min2) + "\n" +
                  "  x_max  = " + String(x_max2) + "\n" +
                  "  y_zero = " + String(y_zero) + "\n" +
                  "  fa = f(x_min) - y_zero = " + String(fa) + "\n" +
                  "  fb = f(x_max) - y_zero = " + String(fb) + "\n" +
                  "fa and fb must have opposite sign which is not the case");
         end if;

         // Initialize variables
         c :=a;
         fc :=fa;
         e :=b - a;
         d :=e;

         // Search loop
         while not found loop
            if abs(fc) < abs(fb) then
               a :=b;
               b :=c;
               c :=a;
               fa :=fb;
               fb :=fc;
               fc :=fa;
            end if;

            tol :=2*eps*abs(b) + x_tol;
            m :=(c - b)/2;

            if abs(m) <= tol or fb == 0.0 then
               // root found (interval is small enough)
               found :=true;
               x_zero :=b;
            else
               // Determine if a bisection is needed
               if abs(e) < tol or abs(fa) <= abs(fb) then
                  e :=m;
                  d :=e;
               else
                  s :=fb/fa;
                  if a == c then
                     // linear interpolation
                     p :=2*m*s;
                     q :=1 - s;
                  else
                     // inverse quadratic interpolation
                     q :=fa/fc;
                     r :=fb/fc;
                     p :=s*(2*m*q*(q - r) - (b - a)*(r - 1));
                     q :=(q - 1)*(r - 1)*(s - 1);
                  end if;

                  if p > 0 then
                     q :=-q;
                  else
                     p :=-p;
                  end if;

                  s :=e;
                  e :=d;
                  if 2*p < 3*m*q-abs(tol*q) and p < abs(0.5*s*q) then
                     // interpolation successful
                     d :=p/q;
                  else
                     // use bi-section
                     e :=m;
                     d :=e;
                  end if;
               end if;

               // Best guess value is defined as "a"
               a :=b;
               fa :=fb;
               b :=b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
               fb :=f_nonlinear(b, pressure, X, f_nonlinear_data) - y_zero;

               if fb > 0 and fc > 0 or
                  fb < 0 and fc < 0 then
                  // initialize variables
                  c :=a;
                  fc :=fa;
                  e :=b - a;
                  d :=e;
               end if;
            end if;
         end while;
      end solve;

      annotation (Documentation(info="<html>
<p>
This function should currently only be used in Modelica.Media,
since it might be replaced in the future by another strategy,
where the tool is responsible for the solution of the non-linear
equation.
</p>

<p>
This library determines the solution of one non-linear algebraic equation \"y=f(x)\"
in one unknown \"x\" in a reliable way. As input, the desired value y of the
non-linear function has to be given, as well as an interval x_min, x_max that
contains the solution, i.e., \"f(x_min) - y\" and \"f(x_max) - y\" must
have a different sign. If possible, a smaller interval is computed by
inverse quadratic interpolation (interpolating with a quadratic polynomial
through the last 3 points and computing the zero). If this fails,
bisection is used, which always reduces the interval by a factor of 2.
The inverse quadratic interpolation method has superlinear convergence.
This is roughly the same convergence rate as a globally convergent Newton
method, but without the need to compute derivatives of the non-linear
function. The solver function is a direct mapping of the Algol 60 procedure
\"zero\" to Modelica, from:
</p>

<dl>
<dt> Brent R.P.:</dt>
<dd> <b>Algorithms for Minimization without derivatives</b>.
     Prentice Hall, 1973, pp. 58-59.</dd>
</dl>

<p>
Due to current limitations of the
Modelica language (not possible to pass a function reference to a function),
the construction to use this solver on a user-defined function is a bit
complicated (this method is from Hans Olsson, Dassault Syst&egrave;mes AB). A user has to
provide a package in the following way:
</p>

<pre>
  <b>package</b> MyNonLinearSolver
    <b>extends</b> OneNonLinearEquation;

    <b>redeclare record extends</b> Data
      // Define data to be passed to user function
      ...
    <b>end</b> Data;

    <b>redeclare function extends</b> f_nonlinear
    <b>algorithm</b>
       // Compute the non-linear equation: y = f(x, Data)
    <b>end</b> f_nonlinear;

    // Dummy definition that has to be present for current Dymola
    <b>redeclare function extends</b> solve
    <b>end</b> solve;
  <b>end</b> MyNonLinearSolver;

  x_zero = MyNonLinearSolver.solve(y_zero, x_min, x_max, data=data);
</pre>
</html>"));
   end OneNonLinearEquation;
    annotation (Documentation(info="<HTML><h4>Package description</h4>
      <p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
      High accuracy fluid property models share a lot of common structure, even if the actual models are different.
      Common data structures and computations shared by these property models are collected in this library.
   </p>

</HTML>
",   revisions="<html>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
      for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions: <i>December, 2002</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a> and move to Modelica
                            properties library.</li>
      <li>Inclusion into Modelica.Media: September 2003 </li>
      </ul>

      <address>Author: Hubertus Tummescheit, <br>
      Lund University<br>
      Department of Automatic Control<br>
      Box 118, 22100 Lund, Sweden<br>
      email: hubertus@control.lth.se
      </address>
</html>"));
  end Common;

    package Air "Medium models for air"
      extends Modelica.Icons.MaterialPropertiesPackage;

      package MoistAir "Air: Moist air model (240 ... 400 K)"
        extends Interfaces.PartialCondensingGases(
           mediumName="Moist air",
           substanceNames={"water", "air"},
           final reducedX=true,
           final singleState=false,
           reference_X={0.01,0.99},
           fluidConstants = {IdealGases.Common.FluidData.H2O,IdealGases.Common.FluidData.N2});

        constant Integer Water=1
        "Index of water (in substanceNames, massFractions X, etc.)";

        constant Integer Air=2
        "Index of air (in substanceNames, massFractions X, etc.)";

        constant Real k_mair =  steam.MM/dryair.MM "ratio of molar weights";

        constant IdealGases.Common.DataRecord dryair = IdealGases.Common.SingleGasesData.Air;

        constant IdealGases.Common.DataRecord steam = IdealGases.Common.SingleGasesData.H2O;

        constant SI.MolarMass[2] MMX = {steam.MM,dryair.MM}
        "Molar masses of components";
        import Modelica.Media.Interfaces;
        import Modelica.Math;
        import SI = Modelica.SIunits;
        import Cv = Modelica.SIunits.Conversions;
        import Modelica.Constants;
        import Modelica.Media.IdealGases.Common.SingleGasNasa;

        redeclare record extends ThermodynamicState
        "ThermodynamicState record for moist air"
        end ThermodynamicState;

        redeclare replaceable model extends BaseProperties(
          T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
          p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
          Xi(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
          redeclare final constant Boolean standardOrderComponents=true)
        "Moist air base properties record"

          /* p, T, X = X[Water] are used as preferred states, since only then all
     other quantities can be computed in a recursive sequence.
     If other variables are selected as states, static state selection
     is no longer possible and non-linear algebraic equations occur.
      */
          MassFraction x_water "Mass of total water/mass of dry air";
          Real phi "Relative humidity";

      protected
          MassFraction X_liquid "Mass fraction of liquid or solid water";
          MassFraction X_steam "Mass fraction of steam water";
          MassFraction X_air "Mass fraction of air";
          MassFraction X_sat
          "Steam water mass fraction of saturation boundary in kg_water/kg_moistair";
          MassFraction x_sat
          "Steam water mass content of saturation boundary in kg_water/kg_dryair";
          AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
        equation
          assert(T >= 200.0 and T <= 423.15, "
Temperature T is not in the allowed range
200.0 K <= (T ="     + String(T) + " K) <= 423.15 K
required from medium model \""           + mediumName + "\".");
          MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);

          p_steam_sat = min(saturationPressure(T),0.999*p);
          X_sat = min(p_steam_sat * k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 - Xi[Water]), 1.0)
          "Water content at saturation with respect to actual water content";
          X_liquid = max(Xi[Water] - X_sat, 0.0);
          X_steam  = Xi[Water]-X_liquid;
          X_air    = 1-Xi[Water];

          h = specificEnthalpy_pTX(p,T,Xi);
          R = dryair.R*(X_air/(1 - X_liquid)) + steam.R*X_steam/(1 - X_liquid);
          //
          u = h - R*T;
          d = p/(R*T);
          /* Note, u and d are computed under the assumption that the volume of the liquid
         water is neglible with respect to the volume of air and of steam
      */
          state.p = p;
          state.T = T;
          state.X = X;

          // these x are per unit mass of DRY air!
          x_sat    = k_mair*p_steam_sat/max(100*Constants.eps,p - p_steam_sat);
          x_water = Xi[Water]/max(X_air,100*Constants.eps);
          phi = p/p_steam_sat*Xi[Water]/(Xi[Water] + k_mair*X_air);
          annotation(Documentation(info="<html>
<p>This model computes thermodynamic properties of moist air from three independent (thermodynamic or/and numerical) state variables. Preferred numerical states are temperature T, pressure p and the reduced composition vector Xi, which contains the water mass fraction only. As an EOS the <b>ideal gas law</b> is used and associated restrictions apply. The model can also be used in the <b>fog region</b>, when moisture is present in its liquid state. However, it is assumed that the liquid water volume is negligible compared to that of the gas phase. Computation of thermal properties is based on property data of <a href=\"modelica://Modelica.Media.Air.DryAirNasa\"> dry air</a> and water (source: VDI-W&auml;rmeatlas), respectively. Besides the standard thermodynamic variables <b>absolute and relative humidity</b>, x_water and phi, respectively, are given by the model. Upper case X denotes absolute humidity with respect to mass of moist air while absolute humidity with respect to mass of dry air only is denoted by a lower case x throughout the model. See <a href=\"modelica://Modelica.Media.Air.MoistAir\">package description</a> for further information.</p>
</html>"));
        end BaseProperties;

        redeclare function setState_pTX
        "Return thermodynamic state as function of pressure p, temperature T and composition X"
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input MassFraction X[:]=reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state";
        algorithm
          state := if size(X,1) == nX then ThermodynamicState(p=p,T=T, X=X) else
                 ThermodynamicState(p=p,T=T, X=cat(1,X,{1-sum(X)}));
          annotation(smoothOrder=2,
                      Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from pressure p, temperature T and composition X.
</html>"));
        end setState_pTX;

        redeclare function setState_phX
        "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input SpecificEnthalpy h "Specific enthalpy";
          input MassFraction X[:]=reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state";
        algorithm
          state := if size(X,1) == nX then ThermodynamicState(p=p,T=T_phX(p,h,X),X=X) else
                 ThermodynamicState(p=p,T=T_phX(p,h,X), X=cat(1,X,{1-sum(X)}));
          annotation(smoothOrder=2,
                      Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from pressure p, specific enthalpy h and composition X.
</html>"));
        end setState_phX;

        redeclare function setState_dTX
        "Return thermodynamic state as function of density d, temperature T and composition X"
          extends Modelica.Icons.Function;
          input Density d "density";
          input Temperature T "Temperature";
          input MassFraction X[:]=reference_X "Mass fractions";
          output ThermodynamicState state "Thermodynamic state";
        algorithm
          state := if size(X,1) == nX then ThermodynamicState(p=d*({steam.R,dryair.R}*X)*T,T=T,X=X) else
                 ThermodynamicState(p=d*({steam.R,dryair.R}*cat(1,X,{1-sum(X)}))*T,T=T, X=cat(1,X,{1-sum(X)}));
          annotation(smoothOrder=2,
                      Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state record</a> is computed from density d, temperature T and composition X.
</html>"));
        end setState_dTX;

      redeclare function extends setSmoothState
        "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
      algorithm
        state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                    T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small),
                                    X=Media.Common.smoothStep(x, state_a.X, state_b.X, x_small));
      end setSmoothState;

        redeclare function extends gasConstant
        "Return ideal gas constant as a function from thermodynamic state, only valid for phi<1"

        algorithm
          R := dryair.R*(1-state.X[Water]) + steam.R*state.X[Water];
          annotation(smoothOrder=2,
                      Documentation(info="<html>
The ideal gas constant for moist air is computed from <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state</a> assuming that all water is in the gas phase.
</html>"));
        end gasConstant;

        function saturationPressureLiquid
        "Return saturation pressure of water as a function of temperature T in the range of 273.16 to 373.16 K"

          extends Modelica.Icons.Function;
          input SI.Temperature Tsat "saturation temperature";
          output SI.AbsolutePressure psat "saturation pressure";
        algorithm
          psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));
          annotation(Inline=false,smoothOrder=5,derivative=saturationPressureLiquid_der,
            Documentation(info="<html>
Saturation pressure of water above the triple point temperature is computed from temperature. It's range of validity is between
273.16 and 373.16 K. Outside these limits a less accurate result is returned.
</html>"));
        end saturationPressureLiquid;

        function saturationPressureLiquid_der
        "Time derivative of saturationPressureLiquid"

          extends Modelica.Icons.Function;
          input SI.Temperature Tsat "Saturation temperature";
          input Real dTsat(unit="K/s") "Saturation temperature derivative";
          output Real psat_der(unit="Pa/s") "Saturation pressure";
        algorithm
        /*psat := 611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719));*/
          psat_der:=611.657*Math.exp(17.2799 - 4102.99/(Tsat - 35.719))*4102.99*dTsat/(Tsat - 35.719)/(Tsat - 35.719);

          annotation(Inline=false,smoothOrder=5,
            Documentation(info="<html>
Derivative function of <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\">saturationPressureLiquid</a>
</html>"));
        end saturationPressureLiquid_der;

        function sublimationPressureIce
        "Return sublimation pressure of water as a function of temperature T between 223.16 and 273.16 K"

          extends Modelica.Icons.Function;
          input SI.Temperature Tsat "sublimation temperature";
          output SI.AbsolutePressure psat "sublimation pressure";
        algorithm
          psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));
          annotation(Inline=false,smoothOrder=5,derivative=sublimationPressureIce_der,
            Documentation(info="<html>
Sublimation pressure of water below the triple point temperature is computed from temperature. It's range of validity is between
 223.16 and 273.16 K. Outside of these limits a less accurate result is returned.
</html>"));
        end sublimationPressureIce;

        function sublimationPressureIce_der
        "Derivative function for 'sublimationPressureIce'"

          extends Modelica.Icons.Function;
          input SI.Temperature Tsat "Sublimation temperature";
          input Real dTsat(unit="K/s")
          "Time derivative of sublimation temperature";
          output Real psat_der(unit="Pa/s") "Sublimation pressure";
        algorithm
          /*psat := 611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat));*/
          psat_der:=611.657*Math.exp(22.5159*(1.0 - 273.16/Tsat))*22.5159*273.16*dTsat/Tsat/Tsat;
          annotation(Inline=false,smoothOrder=5,
            Documentation(info="<html>
Derivative function of <a href=\"modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce\">saturationPressureIce</a>
</html>"));
        end sublimationPressureIce_der;

        redeclare function extends saturationPressure
        "Return saturation pressure of water as a function of temperature T between 223.16 and 373.16 K"

        algorithm
          psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);
          annotation(Inline=false,smoothOrder=5,derivative=saturationPressure_der,
            Documentation(info="<html>
Saturation pressure of water in the liquid and the solid region is computed using an Antoine-type correlation. It's range of validity is between 223.16 and 373.16 K. Outside of these limits a (less accurate) result is returned. Functions for the
<a href=\"modelica://Modelica.Media.Air.MoistAir.sublimationPressureIce\">solid</a> and the <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressureLiquid\"> liquid</a> region, respectively, are combined using the first derivative continuous <a href=\"modelica://Modelica.Media.Air.MoistAir.Utilities.spliceFunction\">spliceFunction</a>.
</html>"));
        end saturationPressure;

        function saturationPressure_der
        "Derivative function for 'saturationPressure'"
          input Temperature Tsat "Saturation temperature";
          input Real dTsat(unit="K/s")
          "Time derivative of saturation temperature";
          output Real psat_der(unit="Pa/s") "Saturation pressure";

        algorithm
          /*psat := Utilities.spliceFunction(saturationPressureLiquid(Tsat),sublimationPressureIce(Tsat),Tsat-273.16,1.0);*/
          psat_der := Utilities.spliceFunction_der(
            saturationPressureLiquid(Tsat),
            sublimationPressureIce(Tsat),
            Tsat - 273.16,
            1.0,
            saturationPressureLiquid_der(Tsat=Tsat, dTsat=dTsat),
            sublimationPressureIce_der(Tsat=Tsat, dTsat=dTsat),
            dTsat,
            0);
          annotation(Inline=false,smoothOrder=5,
            Documentation(info="<html>
Derivative function of <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressure\">saturationPressure</a>
</html>"));
        end saturationPressure_der;

       redeclare function extends enthalpyOfVaporization
        "Return enthalpy of vaporization of water as a function of temperature T, 0 - 130 degC"

       algorithm
        /*r0 := 1e3*(2501.0145 - (T - 273.15)*(2.3853 + (T - 273.15)*(0.002969 - (T
      - 273.15)*(7.5293e-5 + (T - 273.15)*4.6084e-7))));*/
       //katrin: replaced by linear correlation, simpler and more accurate in the entire region
       //source VDI-Waermeatlas, linear inter- and extrapolation between values for 0.01 &deg;C and 40 &deg;C.
       r0:=(2405900-2500500)/(40-0)*(T-273.16)+2500500;
         annotation(smoothOrder=2,
                      Documentation(info="<html>
Enthalpy of vaporization of water is computed from temperature in the region of 0 to 130 &deg;C.
</html>"));
       end enthalpyOfVaporization;

       redeclare function extends enthalpyOfLiquid
        "Return enthalpy of liquid water as a function of temperature T(use enthalpyOfWater instead)"

       algorithm
         h := (T - 273.15)*1e3*(4.2166 - 0.5*(T - 273.15)*(0.0033166 + 0.333333*(T - 273.15)*(0.00010295
            - 0.25*(T - 273.15)*(1.3819e-6 + 0.2*(T - 273.15)*7.3221e-9))));
         annotation(Inline=false,smoothOrder=5,
            Documentation(info="<html>
Specific enthalpy of liquid water is computed from temperature using a polynomial approach. Kept for compatibility reasons, better use <a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a> instead.
</html>"));
       end enthalpyOfLiquid;

       redeclare function extends enthalpyOfGas
        "Return specific enthalpy of gas (air and steam) as a function of temperature T and composition X"

       algorithm
         h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5)*X[Water]
              + SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)*(1.0-X[Water]);
         annotation(Inline=false,smoothOrder=5,
            Documentation(info="<html>
Specific enthalpy of moist air is computed from temperature, provided all water is in the gaseous state. The first entry in the composition vector X must be the mass fraction of steam. For a function that also covers the fog region please refer to <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
       end enthalpyOfGas;

       redeclare function extends enthalpyOfCondensingGas
        "Return specific enthalpy of steam as a function of temperature T"

       algorithm
         h := SingleGasNasa.h_Tlow(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5);
         annotation(Inline=false,smoothOrder=5,
            Documentation(info="<html>
Specific enthalpy of steam is computed from temperature.
</html>"));
       end enthalpyOfCondensingGas;

       redeclare function extends enthalpyOfNonCondensingGas
        "Return specific enthalpy of dry air as a function of temperature T"

       algorithm
         h := SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684);
         annotation(Inline=false,smoothOrder=1,
            Documentation(info="<html>
Specific enthalpy of dry air is computed from temperature.
</html>"));
       end enthalpyOfNonCondensingGas;

      function enthalpyOfWater
        "Computes specific enthalpy of water (solid/liquid) near atmospheric pressure from temperature T"
        input SIunits.Temperature T "Temperature";
        output SIunits.SpecificEnthalpy h "Specific enthalpy of water";
      algorithm
      /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

        h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
      annotation (derivative=enthalpyOfWater_der, Documentation(info="<html>
Specific enthalpy of water (liquid and solid) is computed from temperature using constant properties as follows:<br>
<ul>
<li>  heat capacity of liquid water:4200 J/kg
<li>  heat capacity of solid water: 2050 J/kg
<li>  enthalpy of fusion (liquid=>solid): 333000 J/kg
</ul>
Pressure is assumed to be around 1 bar. This function is usually used to determine the specific enthalpy of the liquid or solid fraction of moist air.
</html>"));
      end enthalpyOfWater;

      function enthalpyOfWater_der "Derivative function of enthalpyOfWater"
        input SIunits.Temperature T "Temperature";
        input Real dT(unit="K/s") "Time derivative of temperature";
        output Real dh(unit="J/(kg.s)") "Time derivative of specific enthalpy";
      algorithm
      /*simple model assuming constant properties:
  heat capacity of liquid water:4200 J/kg
  heat capacity of solid water: 2050 J/kg
  enthalpy of fusion (liquid=>solid): 333000 J/kg*/

        //h:=Utilities.spliceFunction(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1);
        dh:=Utilities.spliceFunction_der(4200*(T-273.15),2050*(T-273.15)-333000,T-273.16,0.1,4200*dT,2050*dT,dT,0);
          annotation (Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.enthalpyOfWater\">enthalpyOfWater</a>.

</html>"));
      end enthalpyOfWater_der;

       redeclare function extends pressure
        "Returns pressure of ideal gas as a function of the thermodynamic state record"

       algorithm
        p := state.p;
         annotation(smoothOrder=2,
                      Documentation(info="<html>
Pressure is returned from the thermodynamic state record input as a simple assignment.
</html>"));
       end pressure;

       redeclare function extends temperature
        "Return temperature of ideal gas as a function of the thermodynamic state record"

       algorithm
         T := state.T;
         annotation(smoothOrder=2,
                      Documentation(info="<html>
Temperature is returned from the thermodynamic state record input as a simple assignment.
</html>"));
       end temperature;

      function T_phX
        "Return temperature as a function of pressure p, specific enthalpy h and composition X"
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction[:] X "Mass fractions of composition";
        output Temperature T "Temperature";

      protected
      package Internal
          "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
        extends Modelica.Media.Common.OneNonLinearEquation;
        redeclare record extends f_nonlinear_Data
            "Data to be passed to non-linear function"
          extends Modelica.Media.IdealGases.Common.DataRecord;
        end f_nonlinear_Data;

        redeclare function extends f_nonlinear
        algorithm
            y := h_pTX(p,x,X);
        end f_nonlinear;

        // Dummy definition has to be added for current Dymola
        redeclare function extends solve
        end solve;
      end Internal;

      algorithm
        T := Internal.solve(h, 240, 400, p, X[1:nXi], steam);
          annotation (Documentation(info="<html>
Temperature is computed from pressure, specific enthalpy and composition via numerical inversion of function <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
      end T_phX;

       redeclare function extends density
        "Returns density of ideal gas as a function of the thermodynamic state record"

       algorithm
         d := state.p/(gasConstant(state)*state.T);
         annotation(smoothOrder=2,
                      Documentation(info="<html>
Density is computed from pressure, temperature and composition in the thermodynamic state record applying the ideal gas law.
</html>"));
       end density;

      redeclare function extends specificEnthalpy
        "Return specific enthalpy of moist air as a function of the thermodynamic state record"

      algorithm
        h := h_pTX(state.p, state.T, state.X);
        annotation(smoothOrder=2,
                      Documentation(info="<html>
Specific enthalpy of moist air is computed from the thermodynamic state record. The fog region is included for both, ice and liquid fog.
</html>"));
      end specificEnthalpy;

      function h_pTX
        "Return specific enthalpy of moist air as a function of pressure p, temperature T and composition X"
        extends Modelica.Icons.Function;
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        input SI.MassFraction X[:] "Mass fractions of moist air";
        output SI.SpecificEnthalpy h "Specific enthalpy at p, T, X";
      protected
        SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
        SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
        SI.MassFraction X_liquid "mass fraction of liquid water";
        SI.MassFraction X_steam "mass fraction of steam water";
        SI.MassFraction X_air "mass fraction of air";
      algorithm
        p_steam_sat :=saturationPressure(T);
        //p_steam_sat :=min(saturationPressure(T), 0.999*p);
        X_sat:=min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 - X[
          Water]), 1.0);
        X_liquid :=max(X[Water] - X_sat, 0.0);
        X_steam  :=X[Water] - X_liquid;
        X_air    :=1 - X[Water];
       /* h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
               SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
    {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;*/
         h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
                     SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
          {X_steam, X_air} + enthalpyOfWater(T)*X_liquid;
        annotation(derivative=h_pTX_der, Inline=false,
            Documentation(info="<html>
Specific enthalpy of moist air is computed from pressure, temperature and composition with X[1] as the total water mass fraction. The fog region is included for both, ice and liquid fog.
</html>"));
      end h_pTX;

      function h_pTX_der "Derivative function of h_pTX"
        extends Modelica.Icons.Function;
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        input SI.MassFraction X[:] "Mass fractions of moist air";
        input Real dp(unit="Pa/s") "Pressure derivative";
        input Real dT(unit="K/s") "Temperature derivative";
        input Real dX[:](each unit="1/s") "Composition derivative";
        output Real h_der(unit="J/(kg.s)")
          "Time derivative of specific enthalpy";
      protected
        SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
        SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
        SI.MassFraction X_liquid "Mass fraction of liquid water";
        SI.MassFraction X_steam "Mass fraction of steam water";
        SI.MassFraction X_air "Mass fraction of air";
        SI.MassFraction x_sat
          "Absolute humidity per unit mass of dry air at saturation";
        Real dX_steam(unit="1/s") "Time deriveative of steam mass fraction";
        Real dX_air(unit="1/s") "Time derivative of dry air mass fraction";
        Real dX_liq(unit="1/s")
          "Time derivative of liquid/solid water mass fraction";
        Real dps(unit="Pa/s") "Time derivative of saturation pressure";
        Real dx_sat(unit="1/s")
          "Time derivative of abolute humidity per unit mass of dry air";
      algorithm
        p_steam_sat :=saturationPressure(T);
        x_sat:=p_steam_sat*k_mair/max(100*Modelica.Constants.eps, p - p_steam_sat);
        X_sat:=min(x_sat*(1 - X[Water]), 1.0);
        X_liquid :=Utilities.spliceFunction(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6);
        X_steam  :=X[Water] - X_liquid;
        X_air    :=1 - X[Water];

        dX_air:=-dX[Water];
        dps:=saturationPressure_der(Tsat=T, dTsat=dT);
        dx_sat:=k_mair*(dps*(p-p_steam_sat)-p_steam_sat*(dp-dps))/(p-p_steam_sat)/(p-p_steam_sat);
        dX_liq:=Utilities.spliceFunction_der(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0);
        //dX_liq:=if X[Water]>=X_sat then (1+x_sat)*dX[Water]-(1-X[Water])*dx_sat else 0;
        dX_steam:=dX[Water]-dX_liq;

        h_der:= X_steam*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow_der(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5, dT=dT)+
                dX_steam*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5) +
                X_air*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow_der(data=dryair, T=T, refChoice=3, h_off=25104.684, dT=dT) +
                dX_air*Modelica.Media.IdealGases.Common.SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684) +
                X_liquid*enthalpyOfWater_der(T=T, dT=dT) +
                dX_liq*enthalpyOfWater(T);

        annotation(Inline=false,smoothOrder=1,
            Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
      end h_pTX_der;

      redeclare function extends isentropicExponent
        "Return isentropic exponent (only for gas fraction!)"
      algorithm
        gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
      end isentropicExponent;

      redeclare function extends specificInternalEnergy
        "Return specific internal energy of moist air as a function of the thermodynamic state record"
        extends Modelica.Icons.Function;
        output SI.SpecificInternalEnergy u "Specific internal energy";
      algorithm
         u := specificInternalEnergy_pTX(state.p,state.T,state.X);

        annotation(smoothOrder=2,
                      Documentation(info="<html>
Specific internal energy is determined from the thermodynamic state record, assuming that the liquid or solid water volume is negligible.
</html>"));
      end specificInternalEnergy;

      function specificInternalEnergy_pTX
        "Return specific internal energy of moist air as a function of pressure p, temperature T and composition X"
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        input SI.MassFraction X[:] "Mass fractions of moist air";
        output SI.SpecificInternalEnergy u "Specific internal energy";
      protected
        SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
        SI.MassFraction X_liquid "Mass fraction of liquid water";
        SI.MassFraction X_steam "Mass fraction of steam water";
        SI.MassFraction X_air "Mass fraction of air";
        SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
        Real R_gas "Ideal gas constant";
      algorithm
        p_steam_sat :=saturationPressure(T);
        X_sat:=min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 - X[
          Water]), 1.0);
        X_liquid :=max(X[Water] - X_sat, 0.0);
        X_steam  :=X[Water] - X_liquid;
        X_air    :=1 - X[Water];
        R_gas:= dryair.R*X_air/(1-X_liquid)+steam.R* X_steam/(1-X_liquid);
        u       := X_steam*SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5)+
                   X_air*SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)
                   + enthalpyOfWater(T)*X_liquid-R_gas*T;

          annotation (derivative=specificInternalEnergy_pTX_der, Documentation(info="<html>
Specific internal energy is determined from pressure p, temperature T and composition X, assuming that the liquid or solid water volume is negligible.
</html>"));
      end specificInternalEnergy_pTX;

      function specificInternalEnergy_pTX_der
        "Derivative function for specificInternalEnergy_pTX"
        input SI.Pressure p "Pressure";
        input SI.Temperature T "Temperature";
        input SI.MassFraction X[:] "Mass fractions of moist air";
        input Real dp(unit="Pa/s") "Pressure derivative";
        input Real dT(unit="K/s") "Temperature derivative";
        input Real dX[:](each unit="1/s") "Mass fraction derivatives";
        output Real u_der(unit="J/(kg.s)")
          "Specific internal energy derivative";
      protected
        SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
        SI.MassFraction X_liquid "Mass fraction of liquid water";
        SI.MassFraction X_steam "Mass fraction of steam water";
        SI.MassFraction X_air "Mass fraction of air";
        SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
        SI.SpecificHeatCapacity R_gas "Ideal gas constant";

        SI.MassFraction x_sat
          "Absolute humidity per unit mass of dry air at saturation";
        Real dX_steam(unit="1/s") "Time deriveative of steam mass fraction";
        Real dX_air(unit="1/s") "Time derivative of dry air mass fraction";
        Real dX_liq(unit="1/s")
          "Time derivative of liquid/solid water mass fraction";
        Real dps(unit="Pa/s") "Time derivative of saturation pressure";
        Real dx_sat(unit="1/s")
          "Time derivative of abolute humidity per unit mass of dry air";
        Real dR_gas(unit="J/(kg.K.s)") "Time derivative of ideal gas constant";
      algorithm
        p_steam_sat :=saturationPressure(T);
        x_sat:=p_steam_sat*k_mair/max(100*Modelica.Constants.eps, p - p_steam_sat);
        X_sat:=min(x_sat*(1 - X[Water]), 1.0);
        X_liquid :=Utilities.spliceFunction(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6);
        X_steam  :=X[Water] - X_liquid;
        X_air    :=1 - X[Water];
        R_gas:= steam.R*X_steam/(1-X_liquid)+dryair.R* X_air/(1-X_liquid);

        dX_air:=-dX[Water];
        dps:=saturationPressure_der(Tsat=T, dTsat=dT);
        dx_sat:=k_mair*(dps*(p-p_steam_sat)-p_steam_sat*(dp-dps))/(p-p_steam_sat)/(p-p_steam_sat);
        dX_liq:=Utilities.spliceFunction_der(X[Water] - X_sat, 0.0, X[Water] - X_sat,1e-6,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0,(1+x_sat)*dX[Water]-(1-X[Water])*dx_sat,0.0);
        dX_steam:=dX[Water]-dX_liq;
        dR_gas:=(steam.R*(dX_steam*(1-X_liquid)+dX_liq*X_steam)+dryair.R*(dX_air*(1-X_liquid)+dX_liq*X_air))/(1-X_liquid)/(1-X_liquid);

        u_der:=X_steam*SingleGasNasa.h_Tlow_der(data=steam, T=T, refChoice=3, h_off=46479.819+2501014.5, dT=dT)+
               dX_steam*SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5) +
               X_air*SingleGasNasa.h_Tlow_der(data=dryair, T=T, refChoice=3, h_off=25104.684, dT=dT) +
               dX_air*SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684) +
               X_liquid*enthalpyOfWater_der(T=T, dT=dT) +
               dX_liq*enthalpyOfWater(T) - dR_gas*T-R_gas*dT;
          annotation (Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.specificInternalEnergy_pTX\">specificInternalEnergy_pTX</a>.
</html>"));
      end specificInternalEnergy_pTX_der;

       redeclare function extends specificEntropy
        "Return specific entropy from thermodynamic state record, only valid for phi<1"

      protected
          MoleFraction[2] Y = massToMoleFractions(state.X,{steam.MM,dryair.MM})
          "molar fraction";
       algorithm
         s:=SingleGasNasa.s0_Tlow(dryair, state.T)*(1-state.X[Water])
           + SingleGasNasa.s0_Tlow(steam, state.T)*state.X[Water]
           - (state.X[Water]*Modelica.Constants.R/MMX[Water]*(if state.X[Water]<Modelica.Constants.eps then state.X[Water] else Modelica.Math.log(Y[Water]*state.p/reference_p))
             + (1-state.X[Water])*Modelica.Constants.R/MMX[Air]*(if (1-state.X[Water])<Modelica.Constants.eps then (1-state.X[Water]) else Modelica.Math.log(Y[Air]*state.p/reference_p)));
           annotation(Inline=false,smoothOrder=2,
            Documentation(info="<html>
Specific entropy is calculated from the thermodynamic state record, assuming ideal gas behavior and including entropy of mixing. Liquid or solid water is not taken into account, the entire water content X[1] is assumed to be in the vapor state (relative humidity below 1.0).
</html>"));
       end specificEntropy;

      redeclare function extends specificGibbsEnergy
        "Return specific Gibbs energy as a function of the thermodynamic state record, only valid for phi<1"
        extends Modelica.Icons.Function;
      algorithm
        g := h_pTX(state.p,state.T,state.X) - state.T*specificEntropy(state);
        annotation(smoothOrder=2,
                      Documentation(info="<html>
The Gibbs Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy
        "Return specific Helmholtz energy as a function of the thermodynamic state record, only valid for phi<1"
        extends Modelica.Icons.Function;
      algorithm
        f := h_pTX(state.p,state.T,state.X) - gasConstant(state)*state.T - state.T*specificEntropy(state);
        annotation(smoothOrder=2,
                      Documentation(info="<html>
The Specific Helmholtz Energy is computed from the thermodynamic state record for moist air with a water content below saturation.
</html>"));
      end specificHelmholtzEnergy;

       redeclare function extends specificHeatCapacityCp
        "Return specific heat capacity at constant pressure as a function of the thermodynamic state record"

      protected
         Real dT(unit="s/K") = 1.0;
       algorithm
         cp := h_pTX_der(state.p,state.T,state.X, 0.0, 1.0, zeros(size(state.X,1)))*dT
          "Definition of cp: dh/dT @ constant p";
         //      cp:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water])
         //        + SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water];
         annotation(Inline=false,smoothOrder=2,
            Documentation(info="<html>
The specific heat capacity at constant pressure <b>cp</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
       end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv
        "Return specific heat capacity at constant volume as a function of the thermodynamic state record"

      algorithm
        cv:= SingleGasNasa.cp_Tlow(dryair, state.T)*(1-state.X[Water]) +
          SingleGasNasa.cp_Tlow(steam, state.T)*state.X[Water]
          - gasConstant(state);
         annotation(Inline=false,smoothOrder=2,
            Documentation(info="<html>
The specific heat capacity at constant density <b>cv</b> is computed from temperature and composition for a mixture of steam (X[1]) and dry air. All water is assumed to be in the vapor state.
</html>"));
      end specificHeatCapacityCv;

      redeclare function extends dynamicViscosity
        "Return dynamic viscosity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"

          import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
      algorithm
        eta := Polynomials_Temp.evaluate({(-4.96717436974791E-011), 5.06626785714286E-008, 1.72937731092437E-005},
             Cv.to_degC(state.T));
        annotation(smoothOrder=2,
                      Documentation(info="<html>
Dynamic viscosity is computed from temperature using a simple polynomial for dry air, assuming that moisture influence is small. Range of  validity is from 73.15 K to 373.15 K.
</html>"));
      end dynamicViscosity;

      redeclare function extends thermalConductivity
        "Return thermal conductivity as a function of the thermodynamic state record, valid from 73.15 K to 373.15 K"

          import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
      algorithm
        lambda := Polynomials_Temp.evaluate({(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},
         Cv.to_degC(state.T));
        annotation(smoothOrder=2,
                      Documentation(info="<html>
Thermal conductivity is computed from temperature using a simple polynomial for dry air, assuming that moisture influence is small. Range of  validity is from 73.15 K to 373.15 K.
</html>"));
      end thermalConductivity;

        package Utilities "utility functions"

          function spliceFunction "Spline interpolation of two functions"
              input Real pos "Returned value for x-deltax >= 0";
              input Real neg "Returned value for x+deltax <= 0";
              input Real x "Function argument";
              input Real deltax=1 "Region around x with spline interpolation";
              output Real out;
        protected
              Real scaledX;
              Real scaledX1;
              Real y;
          algorithm
              scaledX1 := x/deltax;
              scaledX := scaledX1*Modelica.Math.asin(1);
              if scaledX1 <= -0.999999999 then
                y := 0;
              elseif scaledX1 >= 0.999999999 then
                y := 1;
              else
                y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1)/2;
              end if;
              out := pos*y + (1 - y)*neg;
              annotation (derivative=spliceFunction_der);
          end spliceFunction;

          function spliceFunction_der "Derivative of spliceFunction"
              input Real pos;
              input Real neg;
              input Real x;
              input Real deltax=1;
              input Real dpos;
              input Real dneg;
              input Real dx;
              input Real ddeltax=0;
              output Real out;
        protected
              Real scaledX;
              Real scaledX1;
              Real dscaledX1;
              Real y;
          algorithm
              scaledX1 := x/deltax;
              scaledX := scaledX1*Modelica.Math.asin(1);
              dscaledX1 := (dx - scaledX1*ddeltax)/deltax;
              if scaledX1 <= -0.99999999999 then
                y := 0;
              elseif scaledX1 >= 0.9999999999 then
                y := 1;
              else
                y := (Modelica.Math.tanh(Modelica.Math.tan(scaledX)) + 1)/2;
              end if;
              out := dpos*y + (1 - y)*dneg;
              if (abs(scaledX1) < 1) then
                out := out + (pos - neg)*dscaledX1*Modelica.Math.asin(1)/2/(
                  Modelica.Math.cosh(Modelica.Math.tan(scaledX))*Modelica.Math.cos(
                  scaledX))^2;
              end if;
          end spliceFunction_der;
        end Utilities;
        annotation (Documentation(info="<html>
<h4>Thermodynamic Model</h4>
<p>This package provides a full thermodynamic model of moist air including the fog region and temperatures below zero degC.
The governing assumptions in this model are:</p>
<ul>
<li>the perfect gas law applies</li>
<li>water volume other than that of steam is neglected</li></ul>
<p>All extensive properties are expressed in terms of the total mass in order to comply with other media in this libary. However, for moist air it is rather common to express the absolute humidity in terms of mass of dry air only, which has advantages when working with charts. In addition, care must be taken, when working with mass fractions with respect to total mass, that all properties refer to the same water content when being used in mathematical operations (which is always the case if based on dry air only). Therefore two absolute humidities are computed in the <b>BaseProperties</b> model: <b>X</b> denotes the absolute humidity in terms of the total mass while <b>x</b> denotes the absolute humitity per unit mass of dry air. In addition, the relative humidity <b>phi</b> is also computed.</p>
<p>At the triple point temperature of water of 0.01 &deg;C or 273.16 K and a relative humidity greater than 1 fog may be present as liquid and as ice resulting in a specific enthalpy somewhere between those of the two isotherms for solid and liquid fog, respectively. For numerical reasons a coexisting mixture of 50% solid and 50% liquid fog is assumed in the fog region at the triple point in this model.</p>

<h4>Range of validity</h4>
<p>From the assumptions mentioned above it follows that the <b>pressure</b> should be in the region around <b>atmospheric</b> conditions or below (a few bars may still be fine though). Additionally a very high water content at low temperatures would yield incorrect densities, because the volume of the liquid or solid phase would not be negligible anymore. The model does not provide information on limits for water drop size in the fog region or transport information for the actual condensation or evaporation process in combination with surfaces. All excess water which is not in its vapour state is assumed to be still present in the air regarding its energy but not in terms of its spatial extent.<br><br>
The thermodynamic model may be used for <b>temperatures</b> ranging from <b>240 - 400 K</b>. This holds for all functions unless otherwise stated in their description. However, although the model works at temperatures above the saturation temperature it is questionable to use the term \"relative humidity\" in this region. Please note, that although several functions compute pure water properties, they are designed to be used within the moist air medium model where properties are dominated by air and steam in their vapor states, and not for pure liquid water applications.</p>

<h4>Transport Properties</h4>
<p>Several additional functions that are not needed to describe the thermodynamic system, but are required to model transport processes, like heat and mass transfer, may be called. They usually neglect the moisture influence unless otherwise stated.</p>

<h4>Application</h4>
<p>The model's main area of application is all processes that involve moist air cooling under near atmospheric pressure with possible moisture condensation. This is the case in all domestic and industrial air conditioning applications. Another large domain of moist air applications covers all processes that deal with dehydration of bulk material using air as a transport medium. Engineering tasks involving moist air are often performed (or at least visualized) by using charts that contain all relevant thermodynamic data for a moist air system. These so called psychrometric charts can be generated from the medium properties in this package. The model <a href=\"modelica://Modelica.Media.Air.MoistAir.PsychrometricData\">PsychrometricData</a> may be used for this purpose in order to obtain data for figures like those below (the plotting itself is not part of the model though).</p>

<img src=\"modelica://Modelica/Resources/Images/Media/Air/Mollier.png\">

<img src=\"modelica://Modelica/Resources/Images/Media/Air/PsycroChart.png\">

<p>
<b>Legend:</b> blue - constant specific enthalpy, red - constant temperature, black - constant relative humidity</p>

</html>"));
      end MoistAir;
      annotation (Documentation(info="<html>
  <p>This package contains different medium models for air:</p>
<ul>
<li><b>SimpleAir</b><br>
    Simple dry air medium in a limited temperature range.</li>
<li><b>DryAirNasa</b><br>
    Dry air as an ideal gas from Media.IdealGases.MixtureGases.Air.</li>
<li><b>MoistAir</b><br>
    Moist air as an ideal gas mixture of steam and dry air with fog below and above the triple point temperature.</li>
</ul>
</html>"));
    end Air;

    package IdealGases
    "Data and models of ideal gases (single, fixed and dynamic mixtures) from NASA source"
      extends Modelica.Icons.MaterialPropertiesPackage;

      package Common "Common packages and data for the ideal gas models"
      extends Modelica.Icons.Package;

      record DataRecord
        "Coefficient data record for properties of ideal gases based on NASA source"
        extends Modelica.Icons.Record;
        String name "Name of ideal gas";
        SI.MolarMass MM "Molar mass";
        SI.SpecificEnthalpy Hf "Enthalpy of formation at 298.15K";
        SI.SpecificEnthalpy H0 "H0(298.15K) - H0(0K)";
        SI.Temperature Tlimit
          "Temperature limit between low and high data sets";
        Real alow[7] "Low temperature coefficients a";
        Real blow[2] "Low temperature constants b";
        Real ahigh[7] "High temperature coefficients a";
        Real bhigh[2] "High temperature constants b";
        SI.SpecificHeatCapacity R "Gas constant";
        annotation (Documentation(info="<HTML>
<p>
This data record contains the coefficients for the
ideal gas equations according to:
</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
</blockquote>
<p>
The equations have the following structure:
</p>
<IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/singleEquations.png\">
<p>
The polynomials for h(T) and s0(T) are derived via integration from the one for cp(T)  and contain the integration constants b1, b2 that define the reference specific enthalpy and entropy. For entropy differences the reference pressure p0 is arbitrary, but not for absolute entropies. It is chosen as 1 standard atmosphere (101325 Pa).
</p>
<p>
For most gases, the region of validity is from 200 K to 6000 K.
The equations are splitted into two regions that are separated
by Tlimit (usually 1000 K). In both regions the gas is described
by the data above. The two branches are continuous and in most
gases also differentiable at Tlimit.
</p>
</HTML>"));
      end DataRecord;

      partial package SingleGasNasa
        "Medium model of an ideal gas based on NASA source"

        extends Interfaces.PartialPureSubstance(
           ThermoStates = Choices.IndependentVariables.pT,
           mediumName=data.name,
           substanceNames={data.name},
           singleState=false,
           Temperature(min=200, max=6000, start=500, nominal=500),
           SpecificEnthalpy(start=if referenceChoice==ReferenceEnthalpy.ZeroAt0K then data.H0 else
              if referenceChoice==ReferenceEnthalpy.UserDefined then h_offset else 0, nominal=1.0e5),
           Density(start=10, nominal=10),
           AbsolutePressure(start=10e5, nominal=10e5));

        redeclare record extends ThermodynamicState
          "thermodynamic state variables for ideal gases"
          AbsolutePressure p "Absolute pressure of medium";
          Temperature T "Temperature of medium";
        end ThermodynamicState;

        redeclare record extends FluidConstants "Extended fluid constants"
          Temperature criticalTemperature "critical temperature";
          AbsolutePressure criticalPressure "critical pressure";
          MolarVolume criticalMolarVolume "critical molar Volume";
          Real acentricFactor "Pitzer acentric factor";
          Temperature triplePointTemperature "triple point temperature";
          AbsolutePressure triplePointPressure "triple point pressure";
          Temperature meltingPoint "melting point at 101325 Pa";
          Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
          DipoleMoment dipoleMoment
            "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
          Boolean hasIdealGasHeatCapacity=false
            "true if ideal gas heat capacity is available";
          Boolean hasCriticalData=false "true if critical data are known";
          Boolean hasDipoleMoment=false "true if a dipole moment known";
          Boolean hasFundamentalEquation=false "true if a fundamental equation";
          Boolean hasLiquidHeatCapacity=false
            "true if liquid heat capacity is available";
          Boolean hasSolidHeatCapacity=false
            "true if solid heat capacity is available";
          Boolean hasAccurateViscosityData=false
            "true if accurate data for a viscosity function is available";
          Boolean hasAccurateConductivityData=false
            "true if accurate data for thermal conductivity is available";
          Boolean hasVapourPressureCurve=false
            "true if vapour pressure data, e.g., Antoine coefficents are known";
          Boolean hasAcentricFactor=false
            "true if Pitzer accentric factor is known";
          SpecificEnthalpy HCRIT0=0.0
            "Critical specific enthalpy of the fundamental equation";
          SpecificEntropy SCRIT0=0.0
            "Critical specific entropy of the fundamental equation";
          SpecificEnthalpy deltah=0.0
            "Difference between specific enthalpy model (h_m) and f.eq. (h_f) (h_m - h_f)";
          SpecificEntropy deltas=0.0
            "Difference between specific enthalpy model (s_m) and f.eq. (s_f) (s_m - s_f)";
        end FluidConstants;

          import SI = Modelica.SIunits;
          import Modelica.Math;
          import Modelica.Media.Interfaces.PartialMedium.Choices.ReferenceEnthalpy;

        constant Boolean excludeEnthalpyOfFormation=true
          "If true, enthalpy of formation Hf is not included in specific enthalpy h";
        constant ReferenceEnthalpy referenceChoice=Choices.
              ReferenceEnthalpy.ZeroAt0K "Choice of reference enthalpy";
        constant SpecificEnthalpy h_offset=0.0
          "User defined offset for reference enthalpy, if referenceChoice = UserDefined";

        constant IdealGases.Common.DataRecord data
          "Data record of ideal gas substance";

        constant FluidConstants[nS] fluidConstants
          "constant data for the fluid";

        redeclare model extends BaseProperties(
         T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
         p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
          "Base properties of ideal gas medium"
        equation
          assert(T >= 200 and T <= 6000, "
Temperature T (= "       + String(T) + " K) is not in the allowed range
200 K <= T <= 6000 K required from medium model \""       + mediumName + "\".
");
          MM = data.MM;
          R = data.R;
          h = h_T(data, T, excludeEnthalpyOfFormation, referenceChoice, h_offset);
          u = h - R*T;

          // Has to be written in the form d=f(p,T) in order that static
          // state selection for p and T is possible
          d = p/(R*T);
          // connect state with BaseProperties
          state.T = T;
          state.p = p;
        end BaseProperties;

          redeclare function setState_pTX
          "Return thermodynamic state as function of p, T and composition X"
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input Temperature T "Temperature";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := ThermodynamicState(p=p,T=T);
          end setState_pTX;

          redeclare function setState_phX
          "Return thermodynamic state as function of p, h and composition X"
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input SpecificEnthalpy h "Specific enthalpy";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := ThermodynamicState(p=p,T=T_h(h));
          end setState_phX;

          redeclare function setState_psX
          "Return thermodynamic state as function of p, s and composition X"
            extends Modelica.Icons.Function;
            input AbsolutePressure p "Pressure";
            input SpecificEntropy s "Specific entropy";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := ThermodynamicState(p=p,T=T_ps(p,s));
          end setState_psX;

          redeclare function setState_dTX
          "Return thermodynamic state as function of d, T and composition X"
            extends Modelica.Icons.Function;
            input Density d "density";
            input Temperature T "Temperature";
            input MassFraction X[:]=reference_X "Mass fractions";
            output ThermodynamicState state;
          algorithm
            state := ThermodynamicState(p=d*data.R*T,T=T);
          end setState_dTX;

            redeclare function extends setSmoothState
          "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
            algorithm
              state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                          T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
            end setSmoothState;

        redeclare function extends pressure "return pressure of ideal gas"
        algorithm
          p := state.p;
        end pressure;

        redeclare function extends temperature
          "return temperature of ideal gas"
        algorithm
          T := state.T;
        end temperature;

        redeclare function extends density "return density of ideal gas"
        algorithm
          d := state.p/(data.R*state.T);
        end density;

        redeclare function extends specificEnthalpy "Return specific enthalpy"
          extends Modelica.Icons.Function;
        algorithm
          h := h_T(data,state.T);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy
          "Return specific internal energy"
          extends Modelica.Icons.Function;
        algorithm
          u := h_T(data,state.T) - data.R*state.T;
        end specificInternalEnergy;

        redeclare function extends specificEntropy "Return specific entropy"
          extends Modelica.Icons.Function;
        algorithm
          s := s0_T(data, state.T) - data.R*Modelica.Math.log(state.p/reference_p);
        end specificEntropy;

        redeclare function extends specificGibbsEnergy
          "Return specific Gibbs energy"
          extends Modelica.Icons.Function;
        algorithm
          g := h_T(data,state.T) - state.T*specificEntropy(state);
        end specificGibbsEnergy;

        redeclare function extends specificHelmholtzEnergy
          "Return specific Helmholtz energy"
          extends Modelica.Icons.Function;
        algorithm
          f := h_T(data,state.T) - data.R*state.T - state.T*specificEntropy(state);
        end specificHelmholtzEnergy;

        redeclare function extends specificHeatCapacityCp
          "Return specific heat capacity at constant pressure"
        algorithm
          cp := cp_T(data, state.T);
        end specificHeatCapacityCp;

        redeclare function extends specificHeatCapacityCv
          "Compute specific heat capacity at constant volume from temperature and gas data"
        algorithm
          cv := cp_T(data, state.T) - data.R;
        end specificHeatCapacityCv;

        redeclare function extends isentropicExponent
          "Return isentropic exponent"
        algorithm
          gamma := specificHeatCapacityCp(state)/specificHeatCapacityCv(state);
        end isentropicExponent;

        redeclare function extends velocityOfSound "Return velocity of sound"
          extends Modelica.Icons.Function;
        algorithm
          a := sqrt(max(0,data.R*state.T*cp_T(data, state.T)/specificHeatCapacityCv(state)));
        end velocityOfSound;

        function isentropicEnthalpyApproximation
          "approximate method of calculating h_is from upstream properties and downstream pressure"
          extends Modelica.Icons.Function;
          input SI.Pressure p2 "downstream pressure";
          input ThermodynamicState state "properties at upstream location";
          input Boolean exclEnthForm=excludeEnthalpyOfFormation
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";
          input ReferenceEnthalpy refChoice=referenceChoice
            "Choice of reference enthalpy";
          input SpecificEnthalpy h_off=h_offset
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          output SI.SpecificEnthalpy h_is "isentropic enthalpy";
        protected
          IsentropicExponent gamma =  isentropicExponent(state)
            "Isentropic exponent";
        algorithm
          h_is := h_T(data,state.T,exclEnthForm,refChoice,h_off) +
            gamma/(gamma - 1.0)*state.p/density(state)*((p2/state.p)^((gamma - 1)/gamma) - 1.0);
        end isentropicEnthalpyApproximation;

        redeclare function extends isentropicEnthalpy
          "Return isentropic enthalpy"
        input Boolean exclEnthForm=excludeEnthalpyOfFormation
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";
        input ReferenceEnthalpy refChoice=referenceChoice
            "Choice of reference enthalpy";
        input SpecificEnthalpy h_off=h_offset
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
        algorithm
          h_is := isentropicEnthalpyApproximation(p_downstream,refState,exclEnthForm,refChoice,h_off);
        end isentropicEnthalpy;

        redeclare function extends isobaricExpansionCoefficient
          "Returns overall the isobaric expansion coefficient beta"
        algorithm
          beta := 1/state.T;
        end isobaricExpansionCoefficient;

        redeclare function extends isothermalCompressibility
          "Returns overall the isothermal compressibility factor"
        algorithm
          kappa := 1.0/state.p;
        end isothermalCompressibility;

        redeclare function extends density_derp_T
          "Returns the partial derivative of density with respect to pressure at constant temperature"
        algorithm
          ddpT := 1/(state.T*data.R);
        end density_derp_T;

        redeclare function extends density_derT_p
          "Returns the partial derivative of density with respect to temperature at constant pressure"
        algorithm
          ddTp := -state.p/(state.T*state.T*data.R);
        end density_derT_p;

        redeclare function extends density_derX
          "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
        algorithm
          dddX := fill(0,nX);
        end density_derX;

        function cp_T
          "Compute specific heat capacity at constant pressure from temperature and gas data"
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          output SI.SpecificHeatCapacity cp
            "Specific heat capacity at temperature T";
        algorithm
          cp := smooth(0,if T < data.Tlimit then data.R*(1/(T*T)*(data.alow[1] + T*(
            data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T
            *(data.alow[6] + data.alow[7]*T))))))) else data.R*(1/(T*T)*(data.ahigh[1]
             + T*(data.ahigh[2] + T*(1.*data.ahigh[3] + T*(data.ahigh[4] + T*(data.
            ahigh[5] + T*(data.ahigh[6] + data.ahigh[7]*T))))))));
          annotation (InlineNoEvent=false,smoothOrder=2);
        end cp_T;

        function cp_Tlow
          "Compute specific heat capacity at constant pressure, low T region"
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          output SI.SpecificHeatCapacity cp
            "Specific heat capacity at temperature T";
        algorithm
          cp := data.R*(1/(T*T)*(data.alow[1] + T*(
            data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T
            *(data.alow[6] + data.alow[7]*T)))))));
          annotation (Inline=false, derivative(zeroDerivative=data) = cp_Tlow_der);
        end cp_Tlow;

        function cp_Tlow_der
          "Compute specific heat capacity at constant pressure, low T region"
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          input Real dT "Temperature derivative";
          output Real cp_der "Derivative of specific heat capacity";
        algorithm
          cp_der := dT*data.R/(T*T*T)*(-2*data.alow[1] + T*(
            -data.alow[2] + T*T*(data.alow[4] + T*(2.*data.alow[5] + T
            *(3.*data.alow[6] + 4.*data.alow[7]*T)))));
        end cp_Tlow_der;

        function h_T "Compute specific enthalpy from temperature and gas data; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
            import Modelica.Media.Interfaces.PartialMedium.Choices;
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          input Boolean exclEnthForm=excludeEnthalpyOfFormation
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";
          input Choices.ReferenceEnthalpy refChoice=referenceChoice
            "Choice of reference enthalpy";
          input SI.SpecificEnthalpy h_off=h_offset
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
            //     annotation (InlineNoEvent=false, Inline=false,
            //                 derivative(zeroDerivative=data,
            //                            zeroDerivative=exclEnthForm,
            //                            zeroDerivative=refChoice,
            //                            zeroDerivative=h_off) = h_T_der);
        algorithm
          h := smooth(0,(if T < data.Tlimit then data.R*((-data.alow[1] + T*(data.
            blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
            alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))
            /T) else data.R*((-data.ahigh[1] + T*(data.bhigh[1] + data.ahigh[2]*
            Math.log(T) + T*(1.*data.ahigh[3] + T*(0.5*data.ahigh[4] + T*(1/3*data.
            ahigh[5] + T*(0.25*data.ahigh[6] + 0.2*data.ahigh[7]*T))))))/T)) + (if
            exclEnthForm then -data.Hf else 0.0) + (if (refChoice
             == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if
            refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else
                  0.0));
          annotation (Inline=false,smoothOrder=2);
        end h_T;

        function h_T_der "derivative function for h_T"
            import Modelica.Media.Interfaces.PartialMedium.Choices;
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          input Boolean exclEnthForm=excludeEnthalpyOfFormation
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";
          input Choices.ReferenceEnthalpy refChoice=referenceChoice
            "Choice of reference enthalpy";
          input SI.SpecificEnthalpy h_off=h_offset
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          input Real dT "Temperature derivative";
          output Real h_der "Specific enthalpy at temperature T";
        algorithm
          h_der := dT*cp_T(data,T);
        end h_T_der;

        function h_Tlow "Compute specific enthalpy, low T region; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
            import Modelica.Media.Interfaces.PartialMedium.Choices;
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          input Boolean exclEnthForm=excludeEnthalpyOfFormation
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";
          input Choices.ReferenceEnthalpy refChoice=referenceChoice
            "Choice of reference enthalpy";
          input SI.SpecificEnthalpy h_off=h_offset
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          output SI.SpecificEnthalpy h "Specific enthalpy at temperature T";
            //     annotation (Inline=false,InlineNoEvent=false, derivative(zeroDerivative=data,
            //                                zeroDerivative=exclEnthForm,
            //                                zeroDerivative=refChoice,
            //                                zeroDerivative=h_off) = h_Tlow_der);
        algorithm
          h := data.R*((-data.alow[1] + T*(data.
            blow[1] + data.alow[2]*Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.
            alow[4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))
            /T) + (if
            exclEnthForm then -data.Hf else 0.0) + (if (refChoice
             == Choices.ReferenceEnthalpy.ZeroAt0K) then data.H0 else 0.0) + (if
            refChoice == Choices.ReferenceEnthalpy.UserDefined then h_off else
                  0.0);
          annotation(Inline=false,InlineNoEvent=false,smoothOrder=2);
        end h_Tlow;

        function h_Tlow_der "Compute specific enthalpy, low T region; reference is decided by the
    refChoice input, or by the referenceChoice package constant by default"
            import Modelica.Media.Interfaces.PartialMedium.Choices;
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          input Boolean exclEnthForm=excludeEnthalpyOfFormation
            "If true, enthalpy of formation Hf is not included in specific enthalpy h";
          input Choices.ReferenceEnthalpy refChoice=referenceChoice
            "Choice of reference enthalpy";
          input SI.SpecificEnthalpy h_off=h_offset
            "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
          input Real dT(unit="K/s") "Temperature derivative";
          output Real h_der(unit="J/(kg.s)")
            "Derivative of specific enthalpy at temperature T";
        algorithm
          h_der := dT*cp_Tlow(data,T);
        end h_Tlow_der;

        function s0_T "Compute specific entropy from temperature and gas data"
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          output SI.SpecificEntropy s "Specific entropy at temperature T";
        algorithm
          s := noEvent(if T < data.Tlimit then data.R*(data.blow[2] - 0.5*data.alow[
            1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
            data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
            7]*T)))) else data.R*(data.bhigh[2] - 0.5*data.ahigh[1]/(T*T) - data.
            ahigh[2]/T + data.ahigh[3]*Math.log(T) + T*(data.ahigh[4]
             + T*(0.5*data.ahigh[5] + T*(1/3*data.ahigh[6] + 0.25*data.ahigh[7]*T)))));
          annotation (InlineNoEvent=false,smoothOrder=1);
        end s0_T;

        function s0_Tlow "Compute specific entropy, low T region"
          extends Modelica.Icons.Function;
          input IdealGases.Common.DataRecord data "Ideal gas data";
          input SI.Temperature T "Temperature";
          output SI.SpecificEntropy s "Specific entropy at temperature T";
        algorithm
          s := data.R*(data.blow[2] - 0.5*data.alow[
            1]/(T*T) - data.alow[2]/T + data.alow[3]*Math.log(T) + T*(
            data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6] + 0.25*data.alow[
            7]*T))));
          annotation (InlineNoEvent=false,smoothOrder=1);
        end s0_Tlow;

        function dynamicViscosityLowPressure
          "Dynamic viscosity of low pressure gases"
          extends Modelica.Icons.Function;
          input SI.Temp_K T "Gas temperature";
          input SI.Temp_K Tc "Critical temperature of gas";
          input SI.MolarMass M "Molar mass of gas";
          input SI.MolarVolume Vc "Critical molar volume of gas";
          input Real w "Acentric factor of gas";
          input DipoleMoment mu "Dipole moment of gas molecule";
          input Real k =  0.0 "Special correction for highly polar substances";
          output SI.DynamicViscosity eta "Dynamic viscosity of gas";
        protected
          parameter Real Const1_SI=40.785*10^(-9.5)
            "Constant in formula for eta converted to SI units";
          parameter Real Const2_SI=131.3/1000.0
            "Constant in formula for mur converted to SI units";
          Real mur=Const2_SI*mu/sqrt(Vc*Tc)
            "Dimensionless dipole moment of gas molecule";
          Real Fc=1 - 0.2756*w + 0.059035*mur^4 + k
            "Factor to account for molecular shape and polarities of gas";
          Real Tstar "Dimensionless temperature defined by equation below";
          Real Ov "Viscosity collision integral for the gas";

        algorithm
          Tstar := 1.2593*T/Tc;
          Ov := 1.16145*Tstar^(-0.14874) + 0.52487*exp(-0.7732*Tstar) + 2.16178*exp(-2.43787
            *Tstar);
          eta := Const1_SI*Fc*sqrt(M*T)/(Vc^(2/3)*Ov);
          annotation (smoothOrder=2,
                      Documentation(info="<html>
<p>
The used formula are based on the method of Chung et al (1984, 1988) referred to in ref [1] chapter 9.
The formula 9-4.10 is the one being used. The Formula is given in non-SI units, the follwong onversion constants were used to
transform the formula to SI units:
</p>

<ul>
<li> <b>Const1_SI:</b> The factor 10^(-9.5) =10^(-2.5)*1e-7 where the
     factor 10^(-2.5) originates from the conversion of g/mol->kg/mol + cm^3/mol->m^3/mol
      and the factor 1e-7 is due to conversionfrom microPoise->Pa.s.</li>
<li>  <b>Const2_SI:</b> The factor 1/3.335641e-27 = 1e-3/3.335641e-30
      where the factor 3.335641e-30 comes from debye->C.m and
      1e-3 is due to conversion from cm^3/mol->m^3/mol</li>
</ul>

<h4>References:</h4>
<p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>

<h4>Author</h4>
<p>T. Skoglund, Lund, Sweden, 2004-08-31</p>

</html>"));
        end dynamicViscosityLowPressure;

        redeclare replaceable function extends dynamicViscosity
          "dynamic viscosity"
        algorithm
          assert(fluidConstants[1].hasCriticalData,
          "Failed to compute dynamicViscosity: For the species \"" + mediumName + "\" no critical data is available.");
          assert(fluidConstants[1].hasDipoleMoment,
          "Failed to compute dynamicViscosity: For the species \"" + mediumName + "\" no critical data is available.");
          eta := dynamicViscosityLowPressure(state.T,
                             fluidConstants[1].criticalTemperature,
                             fluidConstants[1].molarMass,
                             fluidConstants[1].criticalMolarVolume,
                             fluidConstants[1].acentricFactor,
                             fluidConstants[1].dipoleMoment);
          annotation (smoothOrder=2);
        end dynamicViscosity;

        function thermalConductivityEstimate
          "Thermal conductivity of polyatomic gases(Eucken and Modified Eucken correlation)"
          extends Modelica.Icons.Function;
          input SpecificHeatCapacity Cp "Constant pressure heat capacity";
          input DynamicViscosity eta "Dynamic viscosity";
          input Integer method(min=1,max=2)=1
            "1: Eucken Method, 2: Modified Eucken Method";
          output ThermalConductivity lambda "Thermal conductivity [W/(m.k)]";
        algorithm
          lambda := if method == 1 then eta*(Cp - data.R + (9/4)*data.R) else eta*(Cp
             - data.R)*(1.32 + 1.77/((Cp/Modelica.Constants.R) - 1.0));
          annotation (smoothOrder=2,
                      Documentation(info="<html>
<p>
This function provides two similar methods for estimating the
thermal conductivity of polyatomic gases.
The Eucken method (input method == 1) gives good results for low temperatures,
but it tends to give an underestimated value of the thermal conductivity
(lambda) at higher temperatures.<br>
The Modified Eucken method (input method == 2) gives good results for
high-temperatures, but it tends to give an overestimated value of the
thermal conductivity (lambda) at low temperatures.
</p>
</html>"));
        end thermalConductivityEstimate;

        redeclare replaceable function extends thermalConductivity
          "thermal conductivity of gas"
          input Integer method=1 "1: Eucken Method, 2: Modified Eucken Method";
        algorithm
          assert(fluidConstants[1].hasCriticalData,
          "Failed to compute thermalConductivity: For the species \"" + mediumName + "\" no critical data is available.");
          lambda := thermalConductivityEstimate(specificHeatCapacityCp(state),
            dynamicViscosity(state), method=method);
          annotation (smoothOrder=2);
        end thermalConductivity;

        redeclare function extends molarMass
          "return the molar mass of the medium"
        algorithm
          MM := data.MM;
        end molarMass;

        function T_h "Compute temperature from specific enthalpy"
          input SpecificEnthalpy h "Specific enthalpy";
          output Temperature T "Temperature";

        protected
        package Internal
            "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
          extends Modelica.Media.Common.OneNonLinearEquation;
          redeclare record extends f_nonlinear_Data
              "Data to be passed to non-linear function"
            extends Modelica.Media.IdealGases.Common.DataRecord;
          end f_nonlinear_Data;

          redeclare function extends f_nonlinear
          algorithm
              y := h_T(f_nonlinear_data,x);
          end f_nonlinear;

          // Dummy definition has to be added for current Dymola
          redeclare function extends solve
          end solve;
        end Internal;

        algorithm
          T := Internal.solve(h, 200, 6000, 1.0e5, {1}, data);
        end T_h;

        function T_ps "Compute temperature from pressure and specific entropy"
          input AbsolutePressure p "Pressure";
          input SpecificEntropy s "Specific entropy";
          output Temperature T "Temperature";

        protected
        package Internal
            "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
          extends Modelica.Media.Common.OneNonLinearEquation;
          redeclare record extends f_nonlinear_Data
              "Data to be passed to non-linear function"
            extends Modelica.Media.IdealGases.Common.DataRecord;
          end f_nonlinear_Data;

          redeclare function extends f_nonlinear
          algorithm
              y := s0_T(f_nonlinear_data,x)- data.R*Modelica.Math.log(p/reference_p);
          end f_nonlinear;

          // Dummy definition has to be added for current Dymola
          redeclare function extends solve
          end solve;
        end Internal;

        algorithm
          T := Internal.solve(s, 200, 6000, p, {1}, data);
        end T_ps;

        annotation (
          Documentation(info="<HTML>
<p>
This model calculates medium properties
for an ideal gas of a single substance, or for an ideal
gas consisting of several substances where the
mass fractions are fixed. Independent variables
are temperature <b>T</b> and pressure <b>p</b>.
Only density is a function of T and p. All other quantities
are solely a function of T. The properties
are valid in the range:
</p>
<pre>
   200 K &le; T &le; 6000 K
</pre>
<p>
The following quantities are always computed:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy h = h(T)</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy u = u(T)</b></td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density d = d(p,T)</td></tr>
</table>
<p>
For the other variables, see the functions in
Modelica.Media.IdealGases.Common.SingleGasNasa.
Note, dynamic viscosity and thermal conductivity are only provided
for gases that use a data record from Modelica.Media.IdealGases.FluidData.
Currently these are the following gases:
</p>
<pre>
  Ar
  C2H2_vinylidene
  C2H4
  C2H5OH
  C2H6
  C3H6_propylene
  C3H7OH
  C3H8
  C4H8_1_butene
  C4H9OH
  C4H10_n_butane
  C5H10_1_pentene
  C5H12_n_pentane
  C6H6
  C6H12_1_hexene
  C6H14_n_heptane
  C7H14_1_heptene
  C8H10_ethylbenz
  CH3OH
  CH4
  CL2
  CO
  CO2
  F2
  H2
  H2O
  He
  N2
  N2O
  NH3
  NO
  O2
  SO2
  SO3
</pre>
<p>
<b>Sources for model and literature:</b><br>
Original Data: Computer program for calculation of complex chemical
equilibrium compositions and applications. Part 1: Analysis
Document ID: 19950013764 N (95N20180) File Series: NASA Technical Reports
Report Number: NASA-RP-1311  E-8017  NAS 1.61:1311
Authors: Gordon, Sanford (NASA Lewis Research Center)
 Mcbride, Bonnie J. (NASA Lewis Research Center)
Published: Oct 01, 1994.
</p>
<p><b>Known limits of validity:</b></br>
The data is valid for
temperatures between 200 K and 6000 K.  A few of the data sets for
monatomic gases have a discontinuous 1st derivative at 1000 K, but
this never caused problems so far.
</p>
<p>
This model has been copied from the ThermoFluid library
and adapted to the Modelica.Media package.
</p>
</HTML>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}),
               graphics),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}),
                      graphics));
      end SingleGasNasa;

        package FluidData "Critical data, dipole moments and related data"
          extends Modelica.Icons.Package;
          import Modelica.Media.Interfaces.PartialMedium;
          import Modelica.Media.IdealGases.Common.SingleGasesData;

          constant SingleGasNasa.FluidConstants N2(
                               chemicalFormula =        "N2",
                               iupacName =              "unknown",
                               structureFormula =       "unknown",
                               casRegistryNumber =      "7727-37-9",
                               meltingPoint =            63.15,
                               normalBoilingPoint =      77.35,
                               criticalTemperature =    126.20,
                               criticalPressure =        33.98e5,
                               criticalMolarVolume =     90.10e-6,
                               acentricFactor =           0.037,
                               dipoleMoment =             0.0,
                               molarMass =              SingleGasesData.N2.MM,
                               hasDipoleMoment =       true,
                               hasIdealGasHeatCapacity=true,
                               hasCriticalData =       true,
                               hasAcentricFactor =     true);

          constant SingleGasNasa.FluidConstants H2O(
                               chemicalFormula =        "H2O",
                               iupacName =              "unknown",
                               structureFormula =       "unknown",
                               casRegistryNumber =      "7732-18-5",
                               meltingPoint =           273.15,
                               normalBoilingPoint =     373.15,
                               criticalTemperature =    647.14,
                               criticalPressure =       220.64e5,
                               criticalMolarVolume =     55.95e-6,
                               acentricFactor =           0.344,
                               dipoleMoment =             1.8,
                               molarMass =              SingleGasesData.H2O.MM,
                               hasDipoleMoment =       true,
                               hasIdealGasHeatCapacity=true,
                               hasCriticalData =       true,
                               hasAcentricFactor =     true);
          annotation (Documentation(info="<html>
<p>
This package contains FluidConstants data records for the following 37 gases
(see also the description in
<a href=\"modelica://Modelica.Media.IdealGases\">Modelica.Media.IdealGases</a>):
</p>
<pre>
Argon             Methane          Methanol       Carbon Monoxide  Carbon Dioxide
Acetylene         Ethylene         Ethanol        Ethane           Propylene
Propane           1-Propanol       1-Butene       N-Butane         1-Pentene
N-Pentane         Benzene          1-Hexene       N-Hexane         1-Heptane
N-Heptane         Ethylbenzene     N-Octane       Chlorine         Fluorine
Hydrogen          Steam            Helium         Ammonia          Nitric Oxide
Nitrogen Dioxide  Nitrogen         Nitrous        Oxide            Neon Oxygen
Sulfur Dioxide    Sulfur Trioxide
</pre>

</html>"));
        end FluidData;

        package SingleGasesData
        "Ideal gas data based on the NASA Glenn coefficients"
          extends Modelica.Icons.Package;

          constant IdealGases.Common.DataRecord Air(
            name="Air",
            MM=0.0289651159,
            Hf=-4333.833858403446,
            H0=298609.6803431054,
            Tlimit=1000,
            alow={10099.5016,-196.827561,5.00915511,-0.00576101373,1.06685993e-005,-7.94029797e-009,
                2.18523191e-012},
            blow={-176.796731,-3.921504225},
            ahigh={241521.443,-1257.8746,5.14455867,-0.000213854179,7.06522784e-008,-1.07148349e-011,
                6.57780015e-016},
            bhigh={6462.26319,-8.147411905},
            R=287.0512249529787);

          constant IdealGases.Common.DataRecord H2O(
            name="H2O",
            MM=0.01801528,
            Hf=-13423382.81725291,
            H0=549760.6476280135,
            Tlimit=1000,
            alow={-39479.6083,575.573102,0.931782653,0.00722271286,-7.34255737e-006,
                4.95504349e-009,-1.336933246e-012},
            blow={-33039.7431,17.24205775},
            ahigh={1034972.096,-2412.698562,4.64611078,0.002291998307,-6.836830479999999e-007,
                9.426468930000001e-011,-4.82238053e-015},
            bhigh={-13842.86509,-7.97814851},
            R=461.5233290850878);

          constant IdealGases.Common.DataRecord N2(
            name="N2",
            MM=0.0280134,
            Hf=0,
            H0=309498.4543111511,
            Tlimit=1000,
            alow={22103.71497,-381.846182,6.08273836,-0.00853091441,1.384646189e-005,-9.62579362e-009,
                2.519705809e-012},
            blow={710.846086,-10.76003744},
            ahigh={587712.406,-2239.249073,6.06694922,-0.00061396855,1.491806679e-007,-1.923105485e-011,
                1.061954386e-015},
            bhigh={12832.10415,-15.86640027},
            R=296.8033869505308);
          annotation ( Documentation(info="<HTML>
<p>This package contains ideal gas models for the 1241 ideal gases from</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
</blockquote>

<pre>
 Ag        BaOH+           C2H4O_ethylen_o DF      In2I4    Nb      ScO2
 Ag+       Ba_OH_2         CH3CHO_ethanal  DOCl    In2I6    Nb+     Sc2O
 Ag-       BaS             CH3COOH         DO2     In2O     Nb-     Sc2O2
 Air       Ba2             OHCH2COOH       DO2-    K        NbCl5   Si
 Al        Be              C2H5            D2      K+       NbO     Si+
 Al+       Be+             C2H5Br          D2+     K-       NbOCl3  Si-
 Al-       Be++            C2H6            D2-     KAlF4    NbO2    SiBr
 AlBr      BeBr            CH3N2CH3        D2O     KBO2     Ne      SiBr2
 AlBr2     BeBr2           C2H5OH          D2O2    KBr      Ne+     SiBr3
 AlBr3     BeCl            CH3OCH3         D2S     KCN      Ni      SiBr4
 AlC       BeCl2           CH3O2CH3        e-      KCl      Ni+     SiC
 AlC2      BeF             CCN             F       KF       Ni-     SiC2
 AlCl      BeF2            CNC             F+      KH       NiCl    SiCl
 AlCl+     BeH             OCCN            F-      KI       NiCl2   SiCl2
 AlCl2     BeH+            C2N2            FCN     Kli      NiO     SiCl3
 AlCl3     BeH2            C2O             FCO     KNO2     NiS     SiCl4
 AlF       BeI             C3              FO      KNO3     O       SiF
 AlF+      BeI2            C3H3_1_propynl  FO2_FOO KNa      O+      SiFCl
 AlFCl     BeN             C3H3_2_propynl  FO2_OFO KO       O-      SiF2
 AlFCl2    BeO             C3H4_allene     F2      KOH      OD      SiF3
 AlF2      BeOH            C3H4_propyne    F2O     K2       OD-     SiF4
 AlF2-     BeOH+           C3H4_cyclo      F2O2    K2+      OH      SiH
 AlF2Cl    Be_OH_2         C3H5_allyl      FS2F    K2Br2    OH+     SiH+
 AlF3      BeS             C3H6_propylene  Fe      K2CO3    OH-     SiHBr3
 AlF4-     Be2             C3H6_cyclo      Fe+     K2C2N2   O2      SiHCl
 AlH       Be2Cl4          C3H6O_propylox  Fe_CO_5 K2Cl2    O2+     SiHCl3
 AlHCl     Be2F4           C3H6O_acetone   FeCl    K2F2     O2-     SiHF
 AlHCl2    Be2O            C3H6O_propanal  FeCl2   K2I2     O3      SiHF3
 AlHF      Be2OF2          C3H7_n_propyl   FeCl3   K2O      P       SiHI3
 AlHFCl    Be2O2           C3H7_i_propyl   FeO     K2O+     P+      SiH2
 AlHF2     Be3O3           C3H8            Fe_OH_2 K2O2     P-      SiH2Br2
 AlH2      Be4O4           C3H8O_1propanol Fe2Cl4  K2O2H2   PCl     SiH2Cl2
 AlH2Cl    Br              C3H8O_2propanol Fe2Cl6  K2SO4    PCl2    SiH2F2
 AlH2F     Br+             CNCOCN          Ga      Kr       PCl2-   SiH2I2
 AlH3      Br-             C3O2            Ga+     Kr+      PCl3    SiH3
 AlI       BrCl            C4              GaBr    li       PCl5    SiH3Br
 AlI2      BrF             C4H2_butadiyne  GaBr2   li+      PF      SiH3Cl
 AlI3      BrF3            C4H4_1_3-cyclo  GaBr3   li-      PF+     SiH3F
 AlN       BrF5            C4H6_butadiene  GaCl    liAlF4   PF-     SiH3I
 AlO       BrO             C4H6_1butyne    GaCl2   liBO2    PFCl    SiH4
 AlO+      OBrO            C4H6_2butyne    GaCl3   liBr     PFCl-   SiI
 AlO-      BrOO            C4H6_cyclo      GaF     liCl     PFCl2   SiI2
 AlOCl     BrO3            C4H8_1_butene   GaF2    liF      PFCl4   SiN
 AlOCl2    Br2             C4H8_cis2_buten GaF3    liH      PF2     SiO
 AlOF      BrBrO           C4H8_isobutene  GaH     liI      PF2-    SiO2
 AlOF2     BrOBr           C4H8_cyclo      GaI     liN      PF2Cl   SiS
 AlOF2-    C               C4H9_n_butyl    GaI2    liNO2    PF2Cl3  SiS2
 AlOH      C+              C4H9_i_butyl    GaI3    liNO3    PF3     Si2
 AlOHCl    C-              C4H9_s_butyl    GaO     liO      PF3Cl2  Si2C
 AlOHCl2   CBr             C4H9_t_butyl    GaOH    liOF     PF4Cl   Si2F6
 AlOHF     CBr2            C4H10_n_butane  Ga2Br2  liOH     PF5     Si2N
 AlOHF2    CBr3            C4H10_isobutane Ga2Br4  liON     PH      Si3
 AlO2      CBr4            C4N2            Ga2Br6  li2      PH2     Sn
 AlO2-     CCl             C5              Ga2Cl2  li2+     PH2-    Sn+
 Al_OH_2   CCl2            C5H6_1_3cyclo   Ga2Cl4  li2Br2   PH3     Sn-
 Al_OH_2Cl CCl2Br2         C5H8_cyclo      Ga2Cl6  li2F2    PN      SnBr
 Al_OH_2F  CCl3            C5H10_1_pentene Ga2F2   li2I2    PO      SnBr2
 Al_OH_3   CCl3Br          C5H10_cyclo     Ga2F4   li2O     PO-     SnBr3
 AlS       CCl4            C5H11_pentyl    Ga2F6   li2O+    POCl3   SnBr4
 AlS2      CF              C5H11_t_pentyl  Ga2I2   li2O2    POFCl2  SnCl
 Al2       CF+             C5H12_n_pentane Ga2I4   li2O2H2  POF2Cl  SnCl2
 Al2Br6    CFBr3           C5H12_i_pentane Ga2I6   li2SO4   POF3    SnCl3
 Al2C2     CFCl            CH3C_CH3_2CH3   Ga2O    li3+     PO2     SnCl4
 Al2Cl6    CFClBr2         C6D5_phenyl     Ge      li3Br3   PO2-    SnF
 Al2F6     CFCl2           C6D6            Ge+     li3Cl3   PS      SnF2
 Al2I6     CFCl2Br         C6H2            Ge-     li3F3    P2      SnF3
 Al2O      CFCl3           C6H5_phenyl     GeBr    li3I3    P2O3    SnF4
 Al2O+     CF2             C6H5O_phenoxy   GeBr2   Mg       P2O4    SnI
 Al2O2     CF2+            C6H6            GeBr3   Mg+      P2O5    SnI2
 Al2O2+    CF2Br2          C6H5OH_phenol   GeBr4   MgBr     P3      SnI3
 Al2O3     CF2Cl           C6H10_cyclo     GeCl    MgBr2    P3O6    SnI4
 Al2S      CF2ClBr         C6H12_1_hexene  GeCl2   MgCl     P4      SnO
 Al2S2     CF2Cl2          C6H12_cyclo     GeCl3   MgCl+    P4O6    SnO2
 Ar        CF3             C6H13_n_hexyl   GeCl4   MgCl2    P4O7    SnS
 Ar+       CF3+            C6H14_n_hexane  GeF     MgF      P4O8    SnS2
 B         CF3Br           C7H7_benzyl     GeF2    MgF+     P4O9    Sn2
 B+        CF3Cl           C7H8            GeF3    MgF2     P4O10   Sr
 B-        CF4             C7H8O_cresol_mx GeF4    MgF2+    Pb      Sr+
 BBr       CH+             C7H14_1_heptene GeH4    MgH      Pb+     SrBr
 BBr2      CHBr3           C7H15_n_heptyl  GeI     MgI      Pb-     SrBr2
 BBr3      CHCl            C7H16_n_heptane GeO     MgI2     PbBr    SrCl
 BC        CHClBr2         C7H16_2_methylh GeO2    MgN      PbBr2   SrCl+
 BC2       CHCl2           C8H8_styrene    GeS     MgO      PbBr3   SrCl2
 BCl       CHCl2Br         C8H10_ethylbenz GeS2    MgOH     PbBr4   SrF
 BCl+      CHCl3           C8H16_1_octene  Ge2     MgOH+    PbCl    SrF+
 BClOH     CHF             C8H17_n_octyl   H       Mg_OH_2  PbCl2   SrF2
 BCl_OH_2  CHFBr2          C8H18_n_octane  H+      MgS      PbCl3   SrH
 BCl2      CHFCl           C8H18_isooctane H-      Mg2      PbCl4   SrI
 BCl2+     CHFClBr         C9H19_n_nonyl   HAlO    Mg2F4    PbF     SrI2
 BCl2OH    CHFCl2          C10H8_naphthale HAlO2   Mn       PbF2    SrO
 BF        CHF2            C10H21_n_decyl  HBO     Mn+      PbF3    SrOH
 BFCl      CHF2Br          C12H9_o_bipheny HBO+    Mo       PbF4    SrOH+
 BFCl2     CHF2Cl          C12H10_biphenyl HBO2    Mo+      PbI     Sr_OH_2
 BFOH      CHF3            Ca              HBS     Mo-      PbI2    SrS
 BF_OH_2   CHI3            Ca+             HBS+    MoO      PbI3    Sr2
 BF2       CH2             CaBr            HCN     MoO2     PbI4    Ta
 BF2+      CH2Br2          CaBr2           HCO     MoO3     PbO     Ta+
 BF2-      CH2Cl           CaCl            HCO+    MoO3-    PbO2    Ta-
 BF2Cl     CH2ClBr         CaCl+           HCCN    Mo2O6    PbS     TaCl5
 BF2OH     CH2Cl2          CaCl2           HCCO    Mo3O9    PbS2    TaO
 BF3       CH2F            CaF             HCl     Mo4O12   Rb      TaO2
 BF4-      CH2FBr          CaF+            HD      Mo5O15   Rb+     Ti
 BH        CH2FCl          CaF2            HD+     N        Rb-     Ti+
 BHCl      CH2F2           CaH             HDO     N+       RbBO2   Ti-
 BHCl2     CH2I2           CaI             HDO2    N-       RbBr    TiCl
 BHF       CH3             CaI2            HF      NCO      RbCl    TiCl2
 BHFCl     CH3Br           CaO             HI      ND       RbF     TiCl3
 BHF2      CH3Cl           CaO+            HNC     ND2      RbH     TiCl4
 BH2       CH3F            CaOH            HNCO    ND3      RbI     TiO
 BH2Cl     CH3I            CaOH+           HNO     NF       RbK     TiO+
 BH2F      CH2OH           Ca_OH_2         HNO2    NF2      Rbli    TiOCl
 BH3       CH2OH+          CaS             HNO3    NF3      RbNO2   TiOCl2
 BH3NH3    CH3O            Ca2             HOCl    NH       RbNO3   TiO2
 BH4       CH4             Cd              HOF     NH+      RbNa    U
 BI        CH3OH           Cd+             HO2     NHF      RbO     UF
 BI2       CH3OOH          Cl              HO2-    NHF2     RbOH    UF+
 BI3       CI              Cl+             HPO     NH2      Rb2Br2  UF-
 BN        CI2             Cl-             HSO3F   NH2F     Rb2Cl2  UF2
 BO        CI3             ClCN            H2      NH3      Rb2F2   UF2+
 BO-       CI4             ClF             H2+     NH2OH    Rb2I2   UF2-
 BOCl      CN              ClF3            H2-     NH4+     Rb2O    UF3
 BOCl2     CN+             ClF5            HBOH    NO       Rb2O2   UF3+
 BOF       CN-             ClO             HCOOH   NOCl     Rb2O2H2 UF3-
 BOF2      CNN             ClO2            H2F2    NOF      Rb2SO4  UF4
 BOH       CO              Cl2             H2O     NOF3     Rn      UF4+
 BO2       CO+             Cl2O            H2O+    NO2      Rn+     UF4-
 BO2-      COCl            Co              H2O2    NO2-     S       UF5
 B_OH_2    COCl2           Co+             H2S     NO2Cl    S+      UF5+
 BS        COFCl           Co-             H2SO4   NO2F     S-      UF5-
 BS2       COF2            Cr              H2BOH   NO3      SCl     UF6
 B2        COHCl           Cr+             HB_OH_2 NO3-     SCl2    UF6-
 B2C       COHF            Cr-             H3BO3   NO3F     SCl2+   UO
 B2Cl4     COS             CrN             H3B3O3  N2       SD      UO+
 B2F4      CO2             CrO             H3B3O6  N2+      SF      UOF
 B2H       CO2+            CrO2            H3F3    N2-      SF+     UOF2
 B2H2      COOH            CrO3            H3O+    NCN      SF-     UOF3
 B2H3      CP              CrO3-           H4F4    N2D2_cis SF2     UOF4
 B2H3_db   CS              Cs              H5F5    N2F2     SF2+    UO2
 B2H4      CS2             Cs+             H6F6    N2F4     SF2-    UO2+
 B2H4_db   C2              Cs-             H7F7    N2H2     SF3     UO2-
 B2H5      C2+             CsBO2           He      NH2NO2   SF3+    UO2F
 B2H5_db   C2-             CsBr            He+     N2H4     SF3-    UO2F2
 B2H6      C2Cl            CsCl            Hg      N2O      SF4     UO3
 B2O       C2Cl2           CsF             Hg+     N2O+     SF4+    UO3-
 B2O2      C2Cl3           CsH             HgBr2   N2O3     SF4-    V
 B2O3      C2Cl4           CsI             I       N2O4     SF5     V+
 B2_OH_4   C2Cl6           Csli            I+      N2O5     SF5+    V-
 B2S       C2F             CsNO2           I-      N3       SF5-    VCl4
 B2S2      C2FCl           CsNO3           IF5     N3H      SF6     VN
 B2S3      C2FCl3          CsNa            IF7     Na       SF6-    VO
 B3H7_C2v  C2F2            CsO             I2      Na+      SH      VO2
 B3H7_Cs   C2F2Cl2         CsOH            In      Na-      SH-     V4O10
 B3H9      C2F3            CsRb            In+     NaAlF4   SN      W
 B3N3H6    C2F3Cl          Cs2             InBr    NaBO2    SO      W+
 B3O3Cl3   C2F4            Cs2Br2          InBr2   NaBr     SO-     W-
 B3O3FCl2  C2F6            Cs2CO3          InBr3   NaCN     SOF2    WCl6
 B3O3F2Cl  C2H             Cs2Cl2          InCl    NaCl     SO2     WO
 B3O3F3    C2HCl           Cs2F2           InCl2   NaF      SO2-    WOCl4
 B4H4      C2HCl3          Cs2I2           InCl3   NaH      SO2Cl2  WO2
 B4H10     C2HF            Cs2O            InF     NaI      SO2FCl  WO2Cl2
 B4H12     C2HFCl2         Cs2O+           InF2    Nali     SO2F2   WO3
 B5H9      C2HF2Cl         Cs2O2           InF3    NaNO2    SO3     WO3-
 Ba        C2HF3           Cs2O2H2         InH     NaNO3    S2      Xe
 Ba+       C2H2_vinylidene Cs2SO4          InI     NaO      S2-     Xe+
 BaBr      C2H2Cl2         Cu              InI2    NaOH     S2Cl2   Zn
 BaBr2     C2H2FCl         Cu+             InI3    NaOH+    S2F2    Zn+
 BaCl      C2H2F2          Cu-             InO     Na2      S2O     Zr
 BaCl+     CH2CO_ketene    CuCl            InOH    Na2Br2   S3      Zr+
 BaCl2     O_CH_2O         CuF             In2Br2  Na2Cl2   S4      Zr-
 BaF       HO_CO_2OH       CuF2            In2Br4  Na2F2    S5      ZrN
 BaF+      C2H3_vinyl      CuO             In2Br6  Na2I2    S6      ZrO
 BaF2      CH2Br-COOH      Cu2             In2Cl2  Na2O     S7      ZrO+
 BaH       C2H3Cl          Cu3Cl3          In2Cl4  Na2O+    S8      ZrO2
 BaI       CH2Cl-COOH      D               In2Cl6  Na2O2    Sc
 BaI2      C2H3F           D+              In2F2   Na2O2H2  Sc+
 BaO       CH3CN           D-              In2F4   Na2SO4   Sc-
 BaO+      CH3CO_acetyl    DBr             In2F6   Na3Cl3   ScO
 BaOH      C2H4            DCl             In2I2   Na3F3    ScO+
</pre>

</HTML>"));
        end SingleGasesData;
      annotation (Documentation(info="<html>

</html>"));
      end Common;
    annotation (
      __Dymola_classOrder={"Common", "SingleGases", "MixtureGases"},
    Documentation(info="<HTML>
<p>This package contains data for the 1241 ideal gases from</p>
<blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
</blockquote>
<p>Medium models for some of these gases are available in package
<a href=\"modelica://Modelica.Media.IdealGases.SingleGases\">IdealGases.SingleGases</a>
and some examples for mixtures are available in package <a href=\"modelica://Modelica.Media.IdealGases.MixtureGases\">IdealGases.MixtureGases</a>
</p>
<h4>Using and Adapting Medium Models</h4>
<p>
The data records allow computing the ideal gas specific enthalpy, specific entropy and heat capacity of the substances listed below. From them, even the Gibbs energy and equilibrium constants for reactions can be computed. Critical data that is needed for computing the viscosity and thermal conductivity is not included. In order to add mixtures or single substance medium packages that are
subtypes of
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">Interfaces.PartialMedium</a>
(i.e., can be utilized at all places where PartialMedium is defined),
a few additional steps have to be performed:
<ol>
<li>
All single gas media need to define a constant instance of record
<a href=\"modelica://Modelica.Media.IdealGases.Common.SingleGasNasa.FluidConstants\">IdealGases.Common.SingleGasNasa.FluidConstants</a>.
For 37 ideal gases such records are provided in package
<a href=\"modelica://Modelica.Media.IdealGases.Common.FluidData\">IdealGases.Common.FluidData</a>.
For the other gases, such a record instance has to be provided by the user, e.g., by getting
the data from a commercial or public data base. A public source of the needed data is for example the <a href=\"http://webbook.nist.gov/chemistry/\"> NIST Chemistry WebBook</a></li>

<li>When the data is available, and a user has an instance of a
<a href=\"modelica://Modelica.Media.IdealGases.Common.SingleGasNasa.FluidConstants\">FluidConstants</a> record filled with data, a medium package has to be written. Note that only the dipole moment, the accentric factor and critical data are necessary for the viscosity and thermal conductivity functions.</li>
<ul>
<li>For single components, a new package following the pattern in
<a href=\"modelica://Modelica.Media.IdealGases.SingleGases\">IdealGases.SingleGases</a> has to be created, pointing both to a data record for cp and to a user-defined fluidContants record.</li>
<li>For mixtures of several components, a new package following the pattern in
<a href=\"modelica://Modelica.Media.IdealGases.MixtureGases\">IdealGases.MixtureGases</a> has to be created, building an array of data records for cp and an array of (partly) user-defined fluidContants records.</li>
</ul>
</ol>
<p>Note that many properties can computed for the full set of 1241 gases listed below, but due to the missing viscosity and thermal conductivity functions, no fully Modelica.Media-compliant media can be defined.</p>
</p>
<p>
Data records for heat capacity, specific enthalpy and specific entropy exist for the following substances and ions:
</p>
<pre>
 Ag        BaOH+           C2H4O_ethylen_o DF      In2I4    Nb      ScO2
 Ag+       Ba_OH_2         CH3CHO_ethanal  DOCl    In2I6    Nb+     Sc2O
 Ag-       BaS             CH3COOH         DO2     In2O     Nb-     Sc2O2
 Air       Ba2             OHCH2COOH       DO2-    K        NbCl5   Si
 Al        Be              C2H5            D2      K+       NbO     Si+
 Al+       Be+             C2H5Br          D2+     K-       NbOCl3  Si-
 Al-       Be++            C2H6            D2-     KAlF4    NbO2    SiBr
 AlBr      BeBr            CH3N2CH3        D2O     KBO2     Ne      SiBr2
 AlBr2     BeBr2           C2H5OH          D2O2    KBr      Ne+     SiBr3
 AlBr3     BeCl            CH3OCH3         D2S     KCN      Ni      SiBr4
 AlC       BeCl2           CH3O2CH3        e-      KCl      Ni+     SiC
 AlC2      BeF             CCN             F       KF       Ni-     SiC2
 AlCl      BeF2            CNC             F+      KH       NiCl    SiCl
 AlCl+     BeH             OCCN            F-      KI       NiCl2   SiCl2
 AlCl2     BeH+            C2N2            FCN     Kli      NiO     SiCl3
 AlCl3     BeH2            C2O             FCO     KNO2     NiS     SiCl4
 AlF       BeI             C3              FO      KNO3     O       SiF
 AlF+      BeI2            C3H3_1_propynl  FO2_FOO KNa      O+      SiFCl
 AlFCl     BeN             C3H3_2_propynl  FO2_OFO KO       O-      SiF2
 AlFCl2    BeO             C3H4_allene     F2      KOH      OD      SiF3
 AlF2      BeOH            C3H4_propyne    F2O     K2       OD-     SiF4
 AlF2-     BeOH+           C3H4_cyclo      F2O2    K2+      OH      SiH
 AlF2Cl    Be_OH_2         C3H5_allyl      FS2F    K2Br2    OH+     SiH+
 AlF3      BeS             C3H6_propylene  Fe      K2CO3    OH-     SiHBr3
 AlF4-     Be2             C3H6_cyclo      Fe+     K2C2N2   O2      SiHCl
 AlH       Be2Cl4          C3H6O_propylox  Fe_CO_5 K2Cl2    O2+     SiHCl3
 AlHCl     Be2F4           C3H6O_acetone   FeCl    K2F2     O2-     SiHF
 AlHCl2    Be2O            C3H6O_propanal  FeCl2   K2I2     O3      SiHF3
 AlHF      Be2OF2          C3H7_n_propyl   FeCl3   K2O      P       SiHI3
 AlHFCl    Be2O2           C3H7_i_propyl   FeO     K2O+     P+      SiH2
 AlHF2     Be3O3           C3H8            Fe_OH_2 K2O2     P-      SiH2Br2
 AlH2      Be4O4           C3H8O_1propanol Fe2Cl4  K2O2H2   PCl     SiH2Cl2
 AlH2Cl    Br              C3H8O_2propanol Fe2Cl6  K2SO4    PCl2    SiH2F2
 AlH2F     Br+             CNCOCN          Ga      Kr       PCl2-   SiH2I2
 AlH3      Br-             C3O2            Ga+     Kr+      PCl3    SiH3
 AlI       BrCl            C4              GaBr    li       PCl5    SiH3Br
 AlI2      BrF             C4H2_butadiyne  GaBr2   li+      PF      SiH3Cl
 AlI3      BrF3            C4H4_1_3-cyclo  GaBr3   li-      PF+     SiH3F
 AlN       BrF5            C4H6_butadiene  GaCl    liAlF4   PF-     SiH3I
 AlO       BrO             C4H6_1butyne    GaCl2   liBO2    PFCl    SiH4
 AlO+      OBrO            C4H6_2butyne    GaCl3   liBr     PFCl-   SiI
 AlO-      BrOO            C4H6_cyclo      GaF     liCl     PFCl2   SiI2
 AlOCl     BrO3            C4H8_1_butene   GaF2    liF      PFCl4   SiN
 AlOCl2    Br2             C4H8_cis2_buten GaF3    liH      PF2     SiO
 AlOF      BrBrO           C4H8_isobutene  GaH     liI      PF2-    SiO2
 AlOF2     BrOBr           C4H8_cyclo      GaI     liN      PF2Cl   SiS
 AlOF2-    C               C4H9_n_butyl    GaI2    liNO2    PF2Cl3  SiS2
 AlOH      C+              C4H9_i_butyl    GaI3    liNO3    PF3     Si2
 AlOHCl    C-              C4H9_s_butyl    GaO     liO      PF3Cl2  Si2C
 AlOHCl2   CBr             C4H9_t_butyl    GaOH    liOF     PF4Cl   Si2F6
 AlOHF     CBr2            C4H10_n_butane  Ga2Br2  liOH     PF5     Si2N
 AlOHF2    CBr3            C4H10_isobutane Ga2Br4  liON     PH      Si3
 AlO2      CBr4            C4N2            Ga2Br6  li2      PH2     Sn
 AlO2-     CCl             C5              Ga2Cl2  li2+     PH2-    Sn+
 Al_OH_2   CCl2            C5H6_1_3cyclo   Ga2Cl4  li2Br2   PH3     Sn-
 Al_OH_2Cl CCl2Br2         C5H8_cyclo      Ga2Cl6  li2F2    PN      SnBr
 Al_OH_2F  CCl3            C5H10_1_pentene Ga2F2   li2I2    PO      SnBr2
 Al_OH_3   CCl3Br          C5H10_cyclo     Ga2F4   li2O     PO-     SnBr3
 AlS       CCl4            C5H11_pentyl    Ga2F6   li2O+    POCl3   SnBr4
 AlS2      CF              C5H11_t_pentyl  Ga2I2   li2O2    POFCl2  SnCl
 Al2       CF+             C5H12_n_pentane Ga2I4   li2O2H2  POF2Cl  SnCl2
 Al2Br6    CFBr3           C5H12_i_pentane Ga2I6   li2SO4   POF3    SnCl3
 Al2C2     CFCl            CH3C_CH3_2CH3   Ga2O    li3+     PO2     SnCl4
 Al2Cl6    CFClBr2         C6D5_phenyl     Ge      li3Br3   PO2-    SnF
 Al2F6     CFCl2           C6D6            Ge+     li3Cl3   PS      SnF2
 Al2I6     CFCl2Br         C6H2            Ge-     li3F3    P2      SnF3
 Al2O      CFCl3           C6H5_phenyl     GeBr    li3I3    P2O3    SnF4
 Al2O+     CF2             C6H5O_phenoxy   GeBr2   Mg       P2O4    SnI
 Al2O2     CF2+            C6H6            GeBr3   Mg+      P2O5    SnI2
 Al2O2+    CF2Br2          C6H5OH_phenol   GeBr4   MgBr     P3      SnI3
 Al2O3     CF2Cl           C6H10_cyclo     GeCl    MgBr2    P3O6    SnI4
 Al2S      CF2ClBr         C6H12_1_hexene  GeCl2   MgCl     P4      SnO
 Al2S2     CF2Cl2          C6H12_cyclo     GeCl3   MgCl+    P4O6    SnO2
 Ar        CF3             C6H13_n_hexyl   GeCl4   MgCl2    P4O7    SnS
 Ar+       CF3+            C6H14_n_hexane  GeF     MgF      P4O8    SnS2
 B         CF3Br           C7H7_benzyl     GeF2    MgF+     P4O9    Sn2
 B+        CF3Cl           C7H8            GeF3    MgF2     P4O10   Sr
 B-        CF4             C7H8O_cresol_mx GeF4    MgF2+    Pb      Sr+
 BBr       CH+             C7H14_1_heptene GeH4    MgH      Pb+     SrBr
 BBr2      CHBr3           C7H15_n_heptyl  GeI     MgI      Pb-     SrBr2
 BBr3      CHCl            C7H16_n_heptane GeO     MgI2     PbBr    SrCl
 BC        CHClBr2         C7H16_2_methylh GeO2    MgN      PbBr2   SrCl+
 BC2       CHCl2           C8H8_styrene    GeS     MgO      PbBr3   SrCl2
 BCl       CHCl2Br         C8H10_ethylbenz GeS2    MgOH     PbBr4   SrF
 BCl+      CHCl3           C8H16_1_octene  Ge2     MgOH+    PbCl    SrF+
 BClOH     CHF             C8H17_n_octyl   H       Mg_OH_2  PbCl2   SrF2
 BCl_OH_2  CHFBr2          C8H18_n_octane  H+      MgS      PbCl3   SrH
 BCl2      CHFCl           C8H18_isooctane H-      Mg2      PbCl4   SrI
 BCl2+     CHFClBr         C9H19_n_nonyl   HAlO    Mg2F4    PbF     SrI2
 BCl2OH    CHFCl2          C10H8_naphthale HAlO2   Mn       PbF2    SrO
 BF        CHF2            C10H21_n_decyl  HBO     Mn+      PbF3    SrOH
 BFCl      CHF2Br          C12H9_o_bipheny HBO+    Mo       PbF4    SrOH+
 BFCl2     CHF2Cl          C12H10_biphenyl HBO2    Mo+      PbI     Sr_OH_2
 BFOH      CHF3            Ca              HBS     Mo-      PbI2    SrS
 BF_OH_2   CHI3            Ca+             HBS+    MoO      PbI3    Sr2
 BF2       CH2             CaBr            HCN     MoO2     PbI4    Ta
 BF2+      CH2Br2          CaBr2           HCO     MoO3     PbO     Ta+
 BF2-      CH2Cl           CaCl            HCO+    MoO3-    PbO2    Ta-
 BF2Cl     CH2ClBr         CaCl+           HCCN    Mo2O6    PbS     TaCl5
 BF2OH     CH2Cl2          CaCl2           HCCO    Mo3O9    PbS2    TaO
 BF3       CH2F            CaF             HCl     Mo4O12   Rb      TaO2
 BF4-      CH2FBr          CaF+            HD      Mo5O15   Rb+     Ti
 BH        CH2FCl          CaF2            HD+     N        Rb-     Ti+
 BHCl      CH2F2           CaH             HDO     N+       RbBO2   Ti-
 BHCl2     CH2I2           CaI             HDO2    N-       RbBr    TiCl
 BHF       CH3             CaI2            HF      NCO      RbCl    TiCl2
 BHFCl     CH3Br           CaO             HI      ND       RbF     TiCl3
 BHF2      CH3Cl           CaO+            HNC     ND2      RbH     TiCl4
 BH2       CH3F            CaOH            HNCO    ND3      RbI     TiO
 BH2Cl     CH3I            CaOH+           HNO     NF       RbK     TiO+
 BH2F      CH2OH           Ca_OH_2         HNO2    NF2      Rbli    TiOCl
 BH3       CH2OH+          CaS             HNO3    NF3      RbNO2   TiOCl2
 BH3NH3    CH3O            Ca2             HOCl    NH       RbNO3   TiO2
 BH4       CH4             Cd              HOF     NH+      RbNa    U
 BI        CH3OH           Cd+             HO2     NHF      RbO     UF
 BI2       CH3OOH          Cl              HO2-    NHF2     RbOH    UF+
 BI3       CI              Cl+             HPO     NH2      Rb2Br2  UF-
 BN        CI2             Cl-             HSO3F   NH2F     Rb2Cl2  UF2
 BO        CI3             ClCN            H2      NH3      Rb2F2   UF2+
 BO-       CI4             ClF             H2+     NH2OH    Rb2I2   UF2-
 BOCl      CN              ClF3            H2-     NH4+     Rb2O    UF3
 BOCl2     CN+             ClF5            HBOH    NO       Rb2O2   UF3+
 BOF       CN-             ClO             HCOOH   NOCl     Rb2O2H2 UF3-
 BOF2      CNN             ClO2            H2F2    NOF      Rb2SO4  UF4
 BOH       CO              Cl2             H2O     NOF3     Rn      UF4+
 BO2       CO+             Cl2O            H2O+    NO2      Rn+     UF4-
 BO2-      COCl            Co              H2O2    NO2-     S       UF5
 B_OH_2    COCl2           Co+             H2S     NO2Cl    S+      UF5+
 BS        COFCl           Co-             H2SO4   NO2F     S-      UF5-
 BS2       COF2            Cr              H2BOH   NO3      SCl     UF6
 B2        COHCl           Cr+             HB_OH_2 NO3-     SCl2    UF6-
 B2C       COHF            Cr-             H3BO3   NO3F     SCl2+   UO
 B2Cl4     COS             CrN             H3B3O3  N2       SD      UO+
 B2F4      CO2             CrO             H3B3O6  N2+      SF      UOF
 B2H       CO2+            CrO2            H3F3    N2-      SF+     UOF2
 B2H2      COOH            CrO3            H3O+    NCN      SF-     UOF3
 B2H3      CP              CrO3-           H4F4    N2D2_cis SF2     UOF4
 B2H3_db   CS              Cs              H5F5    N2F2     SF2+    UO2
 B2H4      CS2             Cs+             H6F6    N2F4     SF2-    UO2+
 B2H4_db   C2              Cs-             H7F7    N2H2     SF3     UO2-
 B2H5      C2+             CsBO2           He      NH2NO2   SF3+    UO2F
 B2H5_db   C2-             CsBr            He+     N2H4     SF3-    UO2F2
 B2H6      C2Cl            CsCl            Hg      N2O      SF4     UO3
 B2O       C2Cl2           CsF             Hg+     N2O+     SF4+    UO3-
 B2O2      C2Cl3           CsH             HgBr2   N2O3     SF4-    V
 B2O3      C2Cl4           CsI             I       N2O4     SF5     V+
 B2_OH_4   C2Cl6           Csli            I+      N2O5     SF5+    V-
 B2S       C2F             CsNO2           I-      N3       SF5-    VCl4
 B2S2      C2FCl           CsNO3           IF5     N3H      SF6     VN
 B2S3      C2FCl3          CsNa            IF7     Na       SF6-    VO
 B3H7_C2v  C2F2            CsO             I2      Na+      SH      VO2
 B3H7_Cs   C2F2Cl2         CsOH            In      Na-      SH-     V4O10
 B3H9      C2F3            CsRb            In+     NaAlF4   SN      W
 B3N3H6    C2F3Cl          Cs2             InBr    NaBO2    SO      W+
 B3O3Cl3   C2F4            Cs2Br2          InBr2   NaBr     SO-     W-
 B3O3FCl2  C2F6            Cs2CO3          InBr3   NaCN     SOF2    WCl6
 B3O3F2Cl  C2H             Cs2Cl2          InCl    NaCl     SO2     WO
 B3O3F3    C2HCl           Cs2F2           InCl2   NaF      SO2-    WOCl4
 B4H4      C2HCl3          Cs2I2           InCl3   NaH      SO2Cl2  WO2
 B4H10     C2HF            Cs2O            InF     NaI      SO2FCl  WO2Cl2
 B4H12     C2HFCl2         Cs2O+           InF2    Nali     SO2F2   WO3
 B5H9      C2HF2Cl         Cs2O2           InF3    NaNO2    SO3     WO3-
 Ba        C2HF3           Cs2O2H2         InH     NaNO3    S2      Xe
 Ba+       C2H2_vinylidene Cs2SO4          InI     NaO      S2-     Xe+
 BaBr      C2H2Cl2         Cu              InI2    NaOH     S2Cl2   Zn
 BaBr2     C2H2FCl         Cu+             InI3    NaOH+    S2F2    Zn+
 BaCl      C2H2F2          Cu-             InO     Na2      S2O     Zr
 BaCl+     CH2CO_ketene    CuCl            InOH    Na2Br2   S3      Zr+
 BaCl2     O_CH_2O         CuF             In2Br2  Na2Cl2   S4      Zr-
 BaF       HO_CO_2OH       CuF2            In2Br4  Na2F2    S5      ZrN
 BaF+      C2H3_vinyl      CuO             In2Br6  Na2I2    S6      ZrO
 BaF2      CH2Br-COOH      Cu2             In2Cl2  Na2O     S7      ZrO+
 BaH       C2H3Cl          Cu3Cl3          In2Cl4  Na2O+    S8      ZrO2
 BaI       CH2Cl-COOH      D               In2Cl6  Na2O2    Sc
 BaI2      C2H3F           D+              In2F2   Na2O2H2  Sc+
 BaO       CH3CN           D-              In2F4   Na2SO4   Sc-
 BaO+      CH3CO_acetyl    DBr             In2F6   Na3Cl3   ScO
 BaOH      C2H4            DCl             In2I2   Na3F3    ScO+
</pre></HTML>"));
    end IdealGases;

    package Incompressible
    "Medium model for T-dependent properties, defined by tables or polynomials"
      extends Modelica.Icons.MaterialPropertiesPackage;
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      import Modelica.Constants;
      import Modelica.Math;

      package Common "Common data structures"
        extends Modelica.Icons.Package;

        record BaseProps_Tpoly "Fluid state record"
          extends Modelica.Icons.Record;
          SI.Temperature T "temperature";
          SI.Pressure p "pressure";
          //    SI.Density d "density";
        end BaseProps_Tpoly;
      end Common;

      package TableBased "Incompressible medium properties based on tables"
        import Poly = Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
        extends Modelica.Media.Interfaces.PartialMedium(
           ThermoStates = if enthalpyOfT then Choices.IndependentVariables.T else Choices.IndependentVariables.pT,
           final reducedX=true,
           final fixedX = true,
           mediumName="tableMedium",
           redeclare record ThermodynamicState=Common.BaseProps_Tpoly,
           singleState=true);

        constant Boolean enthalpyOfT=true
        "true if enthalpy is approximated as a function of T only, (p-dependence neglected)";

        constant Boolean densityOfT = size(tableDensity,1) > 1
        "true if density is a function of temperature";

        constant Temperature T_min "Minimum temperature valid for medium model";

        constant Temperature T_max "Maximum temperature valid for medium model";

        constant Temperature T0=273.15 "reference Temperature";

        constant SpecificEnthalpy h0=0 "reference enthalpy at T0, reference_p";

        constant SpecificEntropy s0=0 "reference entropy at T0, reference_p";

        constant MolarMass MM_const=0.1 "Molar mass";

        constant Integer npol=2 "degree of polynomial used for fitting";

        constant Integer neta=size(tableViscosity,1)
        "number of data points for viscosity";

        constant Real[:,2] tableDensity "Table for rho(T)";

        constant Real[:,2] tableHeatCapacity "Table for Cp(T)";

        constant Real[:,2] tableViscosity "Table for eta(T)";

        constant Real[:,2] tableConductivity "Table for lambda(T)";

        constant Boolean TinK "true if T[K],Kelvin used for table temperatures";

        constant Boolean hasDensity = not (size(tableDensity,1)==0)
        "true if table tableDensity is present";

        constant Boolean hasHeatCapacity = not (size(tableHeatCapacity,1)==0)
        "true if table tableHeatCapacity is present";

        constant Boolean hasViscosity = not (size(tableViscosity,1)==0)
        "true if table tableViscosity is present";

        final constant Real invTK[neta] = if size(tableViscosity,1) > 0 then
            invertTemp(tableViscosity[:,1],TinK) else fill(0,0);

        final constant Real poly_rho[:] = if hasDensity then
                                             Poly.fitting(tableDensity[:,1],tableDensity[:,2],npol) else
                                               zeros(npol+1) annotation(__Dymola_keepConstant = true);

        final constant Real poly_Cp[:] = if hasHeatCapacity then
                                             Poly.fitting(tableHeatCapacity[:,1],tableHeatCapacity[:,2],npol) else
                                               zeros(npol+1) annotation(__Dymola_keepConstant = true);

        final constant Real poly_eta[:] = if hasViscosity then
                                             Poly.fitting(invTK, Math.log(tableViscosity[:,2]),npol) else
                                               zeros(npol+1) annotation(__Dymola_keepConstant = true);

        final constant Real poly_lam[:] = if size(tableConductivity,1)>0 then
                                             Poly.fitting(tableConductivity[:,1],tableConductivity[:,2],npol) else
                                               zeros(npol+1) annotation(__Dymola_keepConstant = true);

        function invertTemp "function to invert temperatures"
          input Real[:] table "table temperature data";
          input Boolean Tink "flag for Celsius or Kelvin";
          output Real invTable[size(table,1)] "inverted temperatures";
        algorithm
          for i in 1:size(table,1) loop
            invTable[i] := if TinK then 1/table[i] else 1/Cv.from_degC(table[i]);
          end for;
        end invertTemp;

        redeclare model extends BaseProperties(
          final standardOrderComponents=true,
          p_bar=Cv.to_bar(p),
          T_degC(start = T_start-273.15)=Cv.to_degC(T),
          T(start = T_start,
            stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default))
        "Base properties of T dependent medium"
        //  redeclare parameter SpecificHeatCapacity R=Modelica.Constants.R,

          SI.SpecificHeatCapacity cp "specific heat capacity";
          parameter SI.Temperature T_start = 298.15 "initial temperature";
        equation
          assert(hasDensity,"Medium " + mediumName +
                            " can not be used without assigning tableDensity.");
          assert(T >= T_min and T <= T_max, "Temperature T (= " + String(T) +
                 " K) is not in the allowed range (" + String(T_min) +
                 " K <= T <= " + String(T_max) + " K) required from medium model \""
                 + mediumName + "\".");
          R = Modelica.Constants.R;
          cp = Poly.evaluate(poly_Cp,if TinK then T else T_degC);
          h = if enthalpyOfT then h_T(T) else  h_pT(p,T,densityOfT);
          if singleState then
            u = h_T(T) - reference_p/d;
          else
            u = h - p/d;
          end if;
          d = Poly.evaluate(poly_rho,if TinK then T else T_degC);
          state.T = T;
          state.p = p;
          MM = MM_const;
          annotation(Documentation(info="<html>
<p>
Note that the inner energy neglects the pressure dependence, which is only
true for an incompressible medium with d = constant. The neglected term is
p-reference_p)/rho*(T/rho)*(partial rho /partial T). This is very small for
liquids due to proportionality to 1/d^2, but can be problematic for gases that are
modeled incompressible.
</p>
<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.independentVariables  is set to  Choices.independentVariables.T otherwise
it is set to Choices.independentVariables.pT.</p>
<p>
Enthalpy is never a function of T only (h = h(T) + (p-reference_p)/d), but the
error is also small and non-linear systems can be avoided. In particular,
non-linear systems are small and local as opposed to large and over all volumes.
</p>

<p>
Entropy is calculated as
</p>
<pre>
  s = s0 + integral(Cp(T)/T,dt)
</pre>
<p>
which is only exactly true for a fluid with constant density d=d0.
</p>
</html>
      "));
        end BaseProperties;

        redeclare function extends setState_pTX
        "Returns state record, given pressure and temperature"
        algorithm
          state := ThermodynamicState(p=p,T=T);
        end setState_pTX;

        redeclare function extends setState_dTX
        "Returns state record, given pressure and temperature"
        algorithm
          assert(false, "for incompressible media with d(T) only, state can not be set from density and temperature");
        end setState_dTX;

        redeclare function extends setState_phX
        "Returns state record, given pressure and specific enthalpy"
        algorithm
          state :=ThermodynamicState(p=p,T=T_ph(p,h));
        end setState_phX;

        redeclare function extends setState_psX
        "Returns state record, given pressure and specific entropy"
        algorithm
          state :=ThermodynamicState(p=p,T=T_ps(p,s));
        end setState_psX;

            redeclare function extends setSmoothState
        "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
            algorithm
              state :=ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                         T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
            end setSmoothState;

        redeclare function extends specificHeatCapacityCv
        "Specific heat capacity at constant volume (or pressure) of medium"

        algorithm
          assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                                 + mediumName + ".");
          cv := Poly.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
         annotation(smoothOrder=2);
        end specificHeatCapacityCv;

        redeclare function extends specificHeatCapacityCp
        "Specific heat capacity at constant volume (or pressure) of medium"

        algorithm
          assert(hasHeatCapacity,"Specific Heat Capacity, Cv, is not defined for medium "
                                                 + mediumName + ".");
          cp := Poly.evaluate(poly_Cp,if TinK then state.T else state.T - 273.15);
         annotation(smoothOrder=2);
        end specificHeatCapacityCp;

        redeclare function extends dynamicViscosity
        "Return dynamic viscosity as a function of the thermodynamic state record"

        algorithm
          assert(size(tableViscosity,1)>0,"DynamicViscosity, eta, is not defined for medium "
                                                 + mediumName + ".");
          eta := Math.exp(Poly.evaluate(poly_eta, 1/state.T));
         annotation(smoothOrder=2);
        end dynamicViscosity;

        redeclare function extends thermalConductivity
        "Return thermal conductivity as a function of the thermodynamic state record"

        algorithm
          assert(size(tableConductivity,1)>0,"ThermalConductivity, lambda, is not defined for medium "
                                                 + mediumName + ".");
          lambda := Poly.evaluate(poly_lam,if TinK then state.T else Cv.to_degC(state.T));
         annotation(smoothOrder=2);
        end thermalConductivity;

        function s_T "compute specific entropy"
          input Temperature T "temperature";
          output SpecificEntropy s "specific entropy";
        algorithm
          s := s0 + (if TinK then
            Poly.integralValue(poly_Cp[1:npol],T, T0) else
            Poly.integralValue(poly_Cp[1:npol],Cv.to_degC(T),Cv.to_degC(T0)))
            + Modelica.Math.log(T/T0)*
            Poly.evaluate(poly_Cp,if TinK then 0 else Modelica.Constants.T_zero);
         annotation(smoothOrder=2);
        end s_T;

        redeclare function extends specificEntropy "Return specific entropy
 as a function of the thermodynamic state record"

      protected
          Integer npol=size(poly_Cp,1)-1;
        algorithm
          assert(hasHeatCapacity,"Specific Entropy, s(T), is not defined for medium "
                                                 + mediumName + ".");
          s := s_T(state.T);
         annotation(smoothOrder=2);
        end specificEntropy;

        function h_T "Compute specific enthalpy from temperature"
          import Modelica.SIunits.Conversions.to_degC;
          extends Modelica.Icons.Function;
          input SI.Temperature T "Temperature";
          output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
        algorithm
          h :=h0 + Poly.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
          T0 else Cv.to_degC(T0));
         annotation(derivative=h_T_der);
        end h_T;

        function h_T_der "Compute specific enthalpy from temperature"
          import Modelica.SIunits.Conversions.to_degC;
          extends Modelica.Icons.Function;
          input SI.Temperature T "Temperature";
          input Real dT "temperature derivative";
          output Real dh "derivative of Specific enthalpy at T";
        algorithm
          dh :=Poly.evaluate(poly_Cp, if TinK then T else Cv.to_degC(T))*dT;
         annotation(smoothOrder=1);
        end h_T_der;

        function h_pT "Compute specific enthalpy from pressure and temperature"
          import Modelica.SIunits.Conversions.to_degC;
          extends Modelica.Icons.Function;
          input SI.Pressure p "Pressure";
          input SI.Temperature T "Temperature";
          input Boolean densityOfT = false
          "include or neglect density derivative dependence of enthalpy"   annotation(Evaluate);
          output SI.SpecificEnthalpy h "Specific enthalpy at p, T";
        algorithm
          h :=h0 + Poly.integralValue(poly_Cp, if TinK then T else Cv.to_degC(T), if TinK then
          T0 else Cv.to_degC(T0)) + (p - reference_p)/Poly.evaluate(poly_rho, if TinK then
                  T else Cv.to_degC(T))
            *(if densityOfT then (1 + T/Poly.evaluate(poly_rho, if TinK then T else Cv.to_degC(T))
          *Poly.derivativeValue(poly_rho,if TinK then T else Cv.to_degC(T))) else 1.0);
         annotation(smoothOrder=2);
        end h_pT;

        redeclare function extends temperature
        "Return temperature as a function of the thermodynamic state record"
        algorithm
         T := state.T;
         annotation(smoothOrder=2);
        end temperature;

        redeclare function extends pressure
        "Return pressure as a function of the thermodynamic state record"
        algorithm
         p := state.p;
         annotation(smoothOrder=2);
        end pressure;

        redeclare function extends density
        "Return density as a function of the thermodynamic state record"
        algorithm
          d := Poly.evaluate(poly_rho,if TinK then state.T else Cv.to_degC(state.T));
         annotation(smoothOrder=2);
        end density;

        redeclare function extends specificEnthalpy
        "Return specific enthalpy as a function of the thermodynamic state record"
        algorithm
          h := if enthalpyOfT then h_T(state.T) else h_pT(state.p,state.T);
         annotation(smoothOrder=2);
        end specificEnthalpy;

        redeclare function extends specificInternalEnergy
        "Return specific internal energy as a function of the thermodynamic state record"
        algorithm
          u := if enthalpyOfT then h_T(state.T) else h_pT(state.p,state.T)
            - (if singleState then  reference_p/density(state) else state.p/density(state));
         annotation(smoothOrder=2);
        end specificInternalEnergy;

        function T_ph "Compute temperature from pressure and specific enthalpy"
          input AbsolutePressure p "pressure";
          input SpecificEnthalpy h "specific enthalpy";
          output Temperature T "temperature";
      protected
          package Internal
          "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data
            "superfluous record, fix later when better structure of inverse functions exists"
                constant Real[5] dummy = {1,2,3,4,5};
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear
            "p is smuggled in via vector"
            algorithm
              y := if singleState then h_T(x) else h_pT(p,x);
            end f_nonlinear;

            // Dummy definition has to be added for current Dymola
            redeclare function extends solve
            end solve;
          end Internal;
        algorithm
         T := Internal.solve(h, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
          annotation(Inline=false, LateInline=true, inverse=h_pT(p,T));
        end T_ph;

        function T_ps "Compute temperature from pressure and specific enthalpy"
          input AbsolutePressure p "pressure";
          input SpecificEntropy s "specific entropy";
          output Temperature T "temperature";
      protected
          package Internal
          "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
            extends Modelica.Media.Common.OneNonLinearEquation;

            redeclare record extends f_nonlinear_Data
            "superfluous record, fix later when better structure of inverse functions exists"
                constant Real[5] dummy = {1,2,3,4,5};
            end f_nonlinear_Data;

            redeclare function extends f_nonlinear
            "p is smuggled in via vector"
            algorithm
              y := s_T(x);
            end f_nonlinear;

            // Dummy definition has to be added for current Dymola
            redeclare function extends solve
            end solve;
          end Internal;
        algorithm
         T := Internal.solve(s, T_min, T_max, p, {1}, Internal.f_nonlinear_Data());
        end T_ps;

        package Polynomials_Temp
        "Temporary Functions operating on polynomials (including polynomial fitting); only to be used in Modelica.Media.Incompressible.TableBased"
          extends Modelica.Icons.Package;

          function evaluate "Evaluate polynomial at a given abszissa value"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            output Real y "Value of polynomial at u";
          algorithm
            y := p[1];
            for j in 2:size(p, 1) loop
              y := p[j] + u*y;
            end for;
            annotation(derivative(zeroDerivative=p)=evaluate_der);
          end evaluate;

          function derivativeValue
          "Value of derivative of polynomial at abszissa value u"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            output Real y "Value of derivative of polynomial at u";
        protected
            Integer n=size(p, 1);
          algorithm
            y := p[1]*(n - 1);
            for j in 2:size(p, 1)-1 loop
              y := p[j]*(n - j) + u*y;
            end for;
            annotation(derivative(zeroDerivative=p)=derivativeValue_der);
          end derivativeValue;

          function secondDerivativeValue
          "Value of 2nd derivative of polynomial at abszissa value u"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            output Real y "Value of 2nd derivative of polynomial at u";
        protected
            Integer n=size(p, 1);
          algorithm
            y := p[1]*(n - 1)*(n - 2);
            for j in 2:size(p, 1)-2 loop
              y := p[j]*(n - j)*(n - j - 1) + u*y;
            end for;
          end secondDerivativeValue;

          function integralValue
          "Integral of polynomial p(u) from u_low to u_high"
            extends Modelica.Icons.Function;
            input Real p[:] "Polynomial coefficients";
            input Real u_high "High integrand value";
            input Real u_low=0 "Low integrand value, default 0";
            output Real integral=0.0
            "Integral of polynomial p from u_low to u_high";
        protected
            Integer n=size(p, 1) "degree of integrated polynomial";
            Real y_low=0 "value at lower integrand";
          algorithm
            for j in 1:n loop
              integral := u_high*(p[j]/(n - j + 1) + integral);
              y_low := u_low*(p[j]/(n - j + 1) + y_low);
            end for;
            integral := integral - y_low;
            annotation(derivative(zeroDerivative=p)=integralValue_der);
          end integralValue;

          function fitting
          "Computes the coefficients of a polynomial that fits a set of data points in a least-squares sense"
            extends Modelica.Icons.Function;
            input Real u[:] "Abscissa data values";
            input Real y[size(u, 1)] "Ordinate data values";
            input Integer n(min=1)
            "Order of desired polynomial that fits the data points (u,y)";
            output Real p[n + 1]
            "Polynomial coefficients of polynomial that fits the date points";
        protected
            Real V[size(u, 1), n + 1] "Vandermonde matrix";
          algorithm
            // Construct Vandermonde matrix
            V[:, n + 1] := ones(size(u, 1));
            for j in n:-1:1 loop
              V[:, j] := {u[i] * V[i, j + 1] for i in 1:size(u,1)};
            end for;

            // Solve least squares problem
            p :=Modelica.Math.Matrices.leastSquares(V, y);
            annotation (Documentation(info="<HTML>
<p>
Polynomials.fitting(u,y,n) computes the coefficients of a polynomial
p(u) of degree \"n\" that fits the data \"p(u[i]) - y[i]\"
in a least squares sense. The polynomial is
returned as a vector p[n+1] that has the following definition:
</p>
<pre>
  p(u) = p[1]*u^n + p[2]*u^(n-1) + ... + p[n]*u + p[n+1];
</pre>
</HTML>"));
          end fitting;

          function evaluate_der "Evaluate polynomial at a given abszissa value"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            input Real du "Abszissa value";
            output Real dy "Value of polynomial at u";
        protected
            Integer n=size(p, 1);
          algorithm
            dy := p[1]*(n - 1);
            for j in 2:size(p, 1)-1 loop
              dy := p[j]*(n - j) + u*dy;
            end for;
            dy := dy*du;
          end evaluate_der;

          function integralValue_der
          "Time derivative of integral of polynomial p(u) from u_low to u_high, assuming only u_high as time-dependent (Leibnitz rule)"
            extends Modelica.Icons.Function;
            input Real p[:] "Polynomial coefficients";
            input Real u_high "High integrand value";
            input Real u_low=0 "Low integrand value, default 0";
            input Real du_high "High integrand value";
            input Real du_low=0 "Low integrand value, default 0";
            output Real dintegral=0.0
            "Integral of polynomial p from u_low to u_high";
          algorithm
            dintegral := evaluate(p,u_high)*du_high;
          end integralValue_der;

          function derivativeValue_der
          "time derivative of derivative of polynomial"
            extends Modelica.Icons.Function;
            input Real p[:]
            "Polynomial coefficients (p[1] is coefficient of highest power)";
            input Real u "Abszissa value";
            input Real du "delta of abszissa value";
            output Real dy
            "time-derivative of derivative of polynomial w.r.t. input variable at u";
        protected
            Integer n=size(p, 1);
          algorithm
            dy := secondDerivativeValue(p,u)*du;
          end derivativeValue_der;
          annotation (Documentation(info="<HTML>
<p>
This package contains functions to operate on polynomials,
in particular to determine the derivative and the integral
of a polynomial and to use a polynomial to fit a given set
of data points.
</p>
<p>

<p><b>Copyright &copy; 2004-2010, Modelica Association and DLR.</b></p>

<p><i>
This package is <b>free</b> software. It can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i>
</p>

</HTML>
",         revisions="<html>
<ul>
<li><i>Oct. 22, 2004</i> by Martin Otter (DLR):<br>
       Renamed functions to not have abbrevations.<br>
       Based fitting on LAPACK<br>
       New function to return the polynomial of an indefinite integral<li>
<li><i>Sept. 3, 2004</i> by Jonas Eborn (Scynamics):<br>
       polyderval, polyintval added<li>
<li><i>March 1, 2004</i> by Martin Otter (DLR):<br>
       first version implemented
</li>
</ul>
</html>"));
        end Polynomials_Temp;
      annotation(__Dymola_keepConstant = true, Documentation(info="<HTML>
<p>
This is the base package for medium models of incompressible fluids based on
tables. The minimal data to provide for a useful medium description is tables
of density and heat capacity as functions of temperature.
</p>

<p>It should be noted that incompressible media only have 1 state per control volume (usually T),
but have both T and p as inputs for fully correct properties. The error of using only T-dependent
properties is small, therefore a Boolean flag enthalpyOfT exists. If it is true, the
enumeration Choices.independentVariables  is set to  Choices.independentVariables.T otherwise
it is set to Choices.independentVariables.pT.</p>

<h4>Using the package TableBased</h4>
<p>
To implement a new medium model, create a package that <b>extends</b> TableBased
and provides one or more of the constant tables:
</p>

<pre>
tableDensity        = [T, d];
tableHeatCapacity   = [T, Cp];
tableConductivity   = [T, lam];
tableViscosity      = [T, eta];
tableVaporPressure  = [T, pVap];
</pre>

<p>
The table data is used to fit constant polynomials of order <b>npol</b>, the
temperature data points do not need to be same for different properties. Properties
like enthalpy, inner energy and entropy are calculated consistently from integrals
and derivatives of d(T) and Cp(T). The minimal
data for a useful medium model is thus density and heat capacity. Transport
properties and vapor pressure are optional, if the data tables are empty the corresponding
function calls can not be used.
</p>
</HTML>"),
        Documentation(info="<HTML>
<h4>Table based media</h4>
<p>
This is the base package for medium models of incompressible fluids based on
tables. The minimal data to provide for a useful medium description is tables
of density and heat capacity as functions of temperature.
</p>
<h4>Using the package TableBased</h4>
<p>
To implement a new medium model, create a package that <b>extends</b> TableBased
and provides one or more of the constant tables:
<pre>
tableDensity        = [T, d];
tableHeatCapacity   = [T, Cp];
tableConductivity   = [T, lam];
tableViscosity      = [T, eta];
tableVaporPressure  = [T, pVap];
</pre>
The table data is used to fit constant polynomials of order <b>npol</b>, the
temperature data points do not need to be same for different properties. Properties
like enthalpy, inner energy and entropy are calculated consistently from integrals
and derivatives of d(T) and Cp(T). The minimal
data for a useful medium model is thus density and heat capacity. Transport
properties and vapor pressure are optional, if the data tables are empty the corresponding
function calls can not be used.
</HTML>"));
      end TableBased;
      annotation (
        Documentation(info="<HTML>
<h4>Incompressible media package</h4>
<p>
This package provides a structure and examples of how to create simple
medium models of incompressible fluids, meaning fluids with very little
pressure influence on density. The medium properties is typically described
in terms of tables, functions or polynomial coefficients.
</p>
<h4>Definitions</h4>
<p>
The common meaning of <em>incompressible</em> is that properties like density
and enthalpy are independent of pressure. Thus properties are conveniently
described as functions of temperature, e.g., as polynomials density(T) and cp(T).
However, enthalpy can not be independent of pressure since h = u - p/d. For liquids
it is anyway
common to neglect this dependence since for constant density the neglected term
is (p - p0)/d, which in comparison with cp is very small for most liquids. For
water, the equivalent change of temperature to increasing pressure 1 bar is
0.025 Kelvin.
</p>
<p>
Two boolean flags are used to choose how enthalpy and inner energy is calculated:
<ul>
<li><b>enthalpyOfT</b>=true, means assuming that enthalpy is only a function
of temperature, neglecting the pressure dependent term.</li>
<li><b>singleState</b>=true, means also neglect the pressure influence on inner
energy, which makes all medium properties pure functions of temperature.</li>
</ul>
The default setting for both these flags is true, which enables the simulation tool
to choose temperature as the only medium state and avoids non-linear equation
systems, see the section about
<a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">Static
state selection</a> in the Modelica.Media User's Guide.

</p>
<h4>Contents</h4>
<p>
Currently, the package contains the following parts:
</p>
<ol>
<li> <a href=\"modelica://Modelica.Media.Incompressible.TableBased\">
      Table based medium models</a></li>
<li> <a href=\"modelica://Modelica.Media.Incompressible.Examples\">
      Example medium models</a></li>
</ol>

<p>
A few examples are given in the Examples package. The model
<a href=\"modelica://Modelica.Media.Incompressible.Examples.Glycol47\">
Examples.Glycol47</a> shows how the medium models can be used. For more
realistic examples of how to implement volume models with medium properties
look in the <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Medium
usage section</a> of the User's Guide.
</p>

</HTML>"));
    end Incompressible;
  annotation (
    Documentation(info="<HTML>
<p>
This library contains <a href=\"modelica://Modelica.Media.Interfaces\">interface</a>
definitions for media and the following <b>property</b> models for
single and multiple substance fluids with one and multiple phases:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Media.IdealGases\">Ideal gases:</a><br>
     1241 high precision gas models based on the
     NASA Glenn coefficients, plus ideal gas mixture models based
     on the same data.</li>
<li> <a href=\"modelica://Modelica.Media.Water\">Water models:</a><br>
     ConstantPropertyLiquidWater, WaterIF97 (high precision
     water model according to the IAPWS/IF97 standard)</li>
<li> <a href=\"modelica://Modelica.Media.Air\">Air models:</a><br>
     SimpleAir, DryAirNasa, and MoistAir</li>
<li> <a href=\"modelica://Modelica.Media.Incompressible\">
     Incompressible media:</a><br>
     TableBased incompressible fluid models (properties are defined by tables rho(T),
     HeatCapacity_cp(T), etc.)</li>
<li> <a href=\"modelica://Modelica.Media.CompressibleLiquids\">
     Compressible liquids:</a><br>
     Simple liquid models with linear compressibility</li>
</ul>
<p>
The following parts are useful, when newly starting with this library:
<ul>
<li> <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage\">Modelica.Media.UsersGuide.MediumUsage</a>
     describes how to use a medium model in a component model.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.MediumDefinition\">
     Modelica.Media.UsersGuide.MediumDefinition</a>
     describes how a new fluid medium model has to be implemented.</li>
<li> <a href=\"modelica://Modelica.Media.UsersGuide.ReleaseNotes\">Modelica.Media.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"modelica://Modelica.Media.Examples\">Modelica.Media.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
Copyright &copy; 1998-2010, Modelica Association.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>"));
  end Media;

  package Thermal
  "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow"
    extends Modelica.Icons.Package;

    package HeatTransfer
    "Library of 1-dimensional heat transfer with lumped elements"
      import Modelica.SIunits.Conversions.*;
      extends Modelica.Icons.Package;

      package Sources "Thermal sources"
      extends Modelica.Icons.SourcesPackage;

        model FixedTemperature "Fixed temperature boundary condition in Kelvin"

          parameter Modelica.SIunits.Temperature T "Fixed temperature at port";
          Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                    -10},{110,10}}, rotation=0)));
        equation
          port.T = T;
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255}),
                Text(
                  extent={{-150,-110},{150,-140}},
                  lineColor={0,0,0},
                  textString="T=%T"),
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillColor={159,159,223},
                  fillPattern=FillPattern.Backward),
                Text(
                  extent={{0,0},{-100,-100}},
                  lineColor={0,0,0},
                  textString="K"),
                Line(
                  points={{-52,0},{56,0}},
                  color={191,0,0},
                  thickness=0.5),
                Polygon(
                  points={{50,-20},{50,20},{90,0},{50,-20}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<HTML>
<p>
This model defines a fixed temperature T at its port in Kelvin,
i.e., it defines a fixed temperature as a boundary condition.
</p>
</HTML>
"),         Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Rectangle(
                  extent={{-100,100},{100,-101}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillColor={159,159,223},
                  fillPattern=FillPattern.Backward),
                Line(
                  points={{-52,0},{56,0}},
                  color={191,0,0},
                  thickness=0.5),
                Text(
                  extent={{0,0},{-100,-100}},
                  lineColor={0,0,0},
                  textString="K"),
                Polygon(
                  points={{52,-20},{52,20},{90,0},{52,-20}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}));
        end FixedTemperature;

        model FixedHeatFlow "Fixed heat flow boundary condition"
          parameter Modelica.SIunits.HeatFlowRate Q_flow
          "Fixed heat flow rate at port";
          parameter Modelica.SIunits.Temperature T_ref=293.15
          "Reference temperature";
          parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Temperature coefficient of heat flow rate";
          Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                    -10},{110,10}}, rotation=0)));
        equation
          port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Text(
                  extent={{-150,100},{150,60}},
                  textString="%name",
                  lineColor={0,0,255}),
                Text(
                  extent={{-150,-55},{150,-85}},
                  lineColor={0,0,0},
                  textString="Q_flow=%Q_flow"),
                Line(
                  points={{-100,-20},{48,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-100,20},{46,20}},
                  color={191,0,0},
                  thickness=0.5),
                Polygon(
                  points={{40,0},{40,40},{70,20},{40,0}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{40,-40},{40,0},{70,-20},{40,-40}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{70,40},{90,-40}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={
                Text(
                  extent={{-100,40},{0,-36}},
                  lineColor={0,0,0},
                  textString="Q_flow=const."),
                Line(
                  points={{-48,-20},{60,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-48,20},{60,20}},
                  color={191,0,0},
                  thickness=0.5),
                Polygon(
                  points={{60,0},{60,40},{90,20},{60,0}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{60,-40},{60,0},{90,-20},{60,-40}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<HTML>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The constant amount of heat
flow rate Q_flow is given as a parameter. The heat flows into the
component to which the component FixedHeatFlow is connected,
if parameter Q_flow is positive.
</p>
<p>
If parameter alpha is > 0, the heat flow is mulitplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given an reference temperature T_ref).
</p>
</HTML>
"));
        end FixedHeatFlow;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics),   Documentation(info="<html>

</html>"));
      end Sources;

      package Interfaces "Connectors and partial models"
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort "Thermal port for 1-dim. heat transfer"
          Modelica.SIunits.Temperature T "Port temperature";
          flow Modelica.SIunits.HeatFlowRate Q_flow
          "Heat flow rate (positive if flowing from outside into the component)";
          annotation (Documentation(info="<html>

</html>"));
        end HeatPort;

        connector HeatPort_a
        "Thermal port for 1-dim. heat transfer (filled rectangular icon)"

          extends HeatPort;

          annotation(defaultComponentName = "port_a",
            Documentation(info="<HTML>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <b>positive</b> heat flow
rate <b>Q_flow</b> is considered to flow <b>into</b> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <b>HeatPort_a</b> and
<b>HeatPort_b</b> are identical with the only exception of the different
<b>icon layout</b>.</p></HTML>
"),         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                  extent={{-50,50},{50,-50}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-120,120},{100,60}},
                  lineColor={191,0,0},
                  textString="%name")}));
        end HeatPort_a;

        connector HeatPort_b
        "Thermal port for 1-dim. heat transfer (unfilled rectangular icon)"

          extends HeatPort;

          annotation(defaultComponentName = "port_b",
            Documentation(info="<HTML>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <b>positive</b> heat flow
rate <b>Q_flow</b> is considered to flow <b>into</b> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <b>HeatPort_a</b> and
<b>HeatPort_b</b> are identical with the only exception of the different
<b>icon layout</b>.</p></HTML>
"),         Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                  extent={{-50,50},{50,-50}},
                  lineColor={191,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-100,120},{120,60}},
                  lineColor={191,0,0},
                  textString="%name")}),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={191,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}));
        end HeatPort_b;
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics),
                                   Documentation(info="<html>

</html>"));
      end Interfaces;
      annotation (
         Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
            Polygon(
              points={{-54,-6},{-61,-7},{-75,-15},{-79,-24},{-80,-34},{-78,-42},{-73,
                  -49},{-64,-51},{-57,-51},{-47,-50},{-41,-43},{-38,-35},{-40,-27},
                  {-40,-20},{-42,-13},{-47,-7},{-54,-5},{-54,-6}},
              lineColor={128,128,128},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-75,-15},{-79,-25},{-80,-34},{-78,-42},{-72,-49},{-64,-51},{
                  -57,-51},{-47,-50},{-57,-47},{-65,-45},{-71,-40},{-74,-33},{-76,-23},
                  {-75,-15},{-75,-15}},
              lineColor={0,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{39,-6},{32,-7},{18,-15},{14,-24},{13,-34},{15,-42},{20,-49},
                  {29,-51},{36,-51},{46,-50},{52,-43},{55,-35},{53,-27},{53,-20},{
                  51,-13},{46,-7},{39,-5},{39,-6}},
              lineColor={160,160,164},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{18,-15},{14,-25},{13,-34},{15,-42},{21,-49},{29,-51},{36,-51},
                  {46,-50},{36,-47},{28,-45},{22,-40},{19,-33},{17,-23},{18,-15},{
                  18,-15}},
              lineColor={0,0,0},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-9,-23},{-9,-10},{18,-17},{-9,-23}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-41,-17},{-9,-17}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-17,-40},{15,-40}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{-17,-46},{-17,-34},{-40,-40},{-17,-46}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<HTML>
<p>
This package contains components to model <b>1-dimensional heat transfer</b>
with lumped elements. This allows especially to model heat transfer in
machines provided the parameters of the lumped elements, such as
the heat capacity of a part, can be determined by measurements
(due to the complex geometries and many materials used in machines,
calculating the lumped element parameters from some basic analytic
formulas is usually not possible).
</p>
<p>
Example models how to use this library are given in subpackage <b>Examples</b>.<br>
For a first simple example, see <b>Examples.TwoMasses</b> where two masses
with different initial temperatures are getting in contact to each
other and arriving after some time at a common temperature.<br>
<b>Examples.ControlledTemperature</b> shows how to hold a temperature
within desired limits by switching on and off an electric resistor.<br>
A more realistic example is provided in <b>Examples.Motor</b> where the
heating of an electrical motor is modelled, see the following screen shot
of this example:
</p>
<img src=\"modelica://Modelica/Resources/Images/Thermal/HeatTransfer/driveWithHeatTransfer.png\" ALT=\"driveWithHeatTransfer\">
<p>
The <b>filled</b> and <b>non-filled red squares</b> at the left and
right side of a component represent <b>thermal ports</b> (connector HeatPort).
Drawing a line between such squares means that they are thermally connected.
The variables of a HeatPort connector are the temperature <b>T</b> at the port
and the heat flow rate <b>Q_flow</b> flowing into the component (if Q_flow is positive,
the heat flows into the element, otherwise it flows out of the element):
</p>
<pre>   Modelica.SIunits.Temperature  T  \"absolute temperature at port in Kelvin\";
   Modelica.SIunits.HeatFlowRate Q_flow  \"flow rate at the port in Watt\";
</pre>
<p>
Note, that all temperatures of this package, including initial conditions,
are given in Kelvin. For convenience, in subpackages <b>HeatTransfer.Celsius</b>,
 <b>HeatTransfer.Fahrenheit</b> and <b>HeatTransfer.Rankine</b> components are provided such that source and
sensor information is available in degree Celsius, degree Fahrenheit, or degree Rankine,
respectively. Additionally, in package <b>SIunits.Conversions</b> conversion
functions between the units Kelvin and Celsius, Fahrenheit, Rankine are
provided. These functions may be used in the following way:
</p>
<pre>  <b>import</b> SI=Modelica.SIunits;
  <b>import</b> Modelica.SIunits.Conversions.*;
     ...
  <b>parameter</b> SI.Temperature T = from_degC(25);  // convert 25 degree Celsius to Kelvin
</pre>

<p>
There are several other components available, such as AxialConduction (discretized PDE in
axial direction), which have been temporarily removed from this library. The reason is that
these components reference material properties, such as thermal conductivity, and currently
the Modelica design group is discussing a general scheme to describe material properties.
</p>
<p>
For technical details in the design of this library, see the following reference:<br>
<b>Michael Tiller (2001)</b>: <a href=\"http://www.amazon.de\">
Introduction to Physical Modeling with Modelica</a>.
Kluwer Academic Publishers Boston.
</p>
<p>
<b>Acknowledgements:</b><br>
Several helpful remarks from the following persons are acknowledged:
John Batteh, Ford Motors, Dearborn, U.S.A;
<a href=\"http://www.haumer.at/\">Anton Haumer</a>, Technical Consulting &amp; Electrical Engineering, Austria;
Ludwig Marvan, VA TECH ELIN EBG Elektronik GmbH, Wien, Austria;
Hans Olsson, Dassault Syst&egrave;mes AB, Sweden;
Hubertus Tummescheit, Lund Institute of Technology, Lund, Sweden.
</p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
  </dd>
</dl>
<p><b>Copyright &copy; 2001-2010, Modelica Association, Michael Tiller and DLR.</b></p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
",     revisions="<html>
<ul>
<li><i>July 15, 2002</i>
       by Michael Tiller, <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Nikolaus.Schuermann/\">Nikolaus Sch&uuml;rmann</a>:<br>
       Implemented.
</li>
<li><i>June 13, 2005</i>
       by <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
       Refined placing of connectors (cosmetic).<br>
       Refined all Examples; removed Examples.FrequencyInverter, introducing Examples.Motor<br>
       Introduced temperature dependent correction (1 + alpha*(T - T_ref)) in Fixed/PrescribedHeatFlow<br>
</li>
  <li> v1.1.1 2007/11/13 Anton Haumer<br>
       componentes moved to sub-packages</li>
  <li> v1.2.0 2009/08/26 Anton Haumer<br>
       added component ThermalCollector</li>

</ul>
</html>"));
    end HeatTransfer;
  annotation (Documentation(info="<html>
<p>
This package contains libraries to model heat transfer
and fluid heat flow.
</p>
</html>"));
  end Thermal;

  package Math
  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

  package Matrices "Library of functions operating on matrices"
    extends Modelica.Icons.Package;

    function leastSquares
    "Solve linear equation A*x = b (exactly if possible, or otherwise in a least square sense; A may be non-square and may be rank deficient)"
      extends Modelica.Icons.Function;
      input Real A[:, :] "Matrix A";
      input Real b[size(A, 1)] "Vector b";
      input Real rcond=100*Modelica.Constants.eps
      "Reciprocal condition number to estimate the rank of A";
      output Real x[size(A, 2)]
      "Vector x such that min|A*x-b|^2 if size(A,1) >= size(A,2) or min|x|^2 and A*x=b, if size(A,1) < size(A,2)";
      output Integer rank "Rank of A";
  protected
      Integer info;
      Real xx[max(size(A,1),size(A,2))];
    algorithm
      if min(size(A)) > 0 then
        (xx,info,rank) := LAPACK.dgelsx_vec(A, b, rcond);
         x := xx[1:size(A,2)];
         assert(info == 0, "Solving an overdetermined or underdetermined linear system\n" +
                           "of equations with function \"Matrices.leastSquares\" failed.");
      else
         x := fill(0.0, size(A, 2));
      end if;
      annotation (
        Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
x = Matrices.<b>leastSquares</b>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns a solution of equation A*x = b in a least
square sense (A may be rank deficient):
</p>
<pre>
  minimize | A*x - b |
</pre>

<p>
Several different cases can be distinguished (note, <b>rank</b> is an
output argument of this function):
</p>

<p>
<b>size(A,1) = size(A,2)</b>
</p>

<p> A solution is returned for a regular, as well as a singular matrix A:
</p>

<ul>
<li> <b>rank</b> = size(A,1):<br>
     A is <b>regular</b> and the returned solution x fulfills the equation
     A*x = b uniquely.</li>

<li> <b>rank</b> &lt; size(A,1):<br>
     A is <b>singular</b> and no unique solution for equation A*x = b exists.
     <ul>
     <li>  If an infinite number of solutions exists, the one is selected that fulfills
           the equation and at the same time has the minimum norm |x| for all solution
           vectors that fulfill the equation.</li>
     <li>  If no solution exists, x is selected such that |A*x - b| is as small as
           possible (but A*x - b is not zero).</li>
     </ul>
</ul>

<p>
<b>size(A,1) &gt; size(A,2):</b>
</p>

<p>
The equation A*x = b has no unique solution. The solution x is selected such that
|A*x - b| is as small as possible. If rank = size(A,2), this minimum norm solution is
unique. If rank &lt; size(A,2), there are an infinite number of solutions leading to the
same minimum value of |A*x - b|. From these infinite number of solutions, the one with the
minimum norm |x| is selected. This gives a unique solution that minimizes both
|A*x - b| and |x|.
</p>

<p>
<b>size(A,1) &lt; size(A,2):</b>
</p>

<ul>
<li> <b>rank</b> = size(A,1):<br>
     There are an infinite number of solutions that fulfill the equation A*x = b.
     From this infinite number, the unique solution is selected that minimizes |x|.
     </li>

<li> <b>rank</b> &lt; size(A,1):<br>
     There is either no solution of equation A*x = b, or there are again an infinite
     number of solutions. The unique solution x is returned that minimizes
      both |A*x - b| and |x|.</li>
</ul>

<p>
Note, the solution is computed with the LAPACK function \"dgelsx\",
i.e., QR or LQ factorization of A with column pivoting.
</p>

<h4>Algorithmic details</h4>

<p>
The function first computes a QR factorization with column pivoting:
</p>

<pre>
      A * P = Q * [ R11 R12 ]
                  [  0  R22 ]
</pre>

<p>
with R11 defined as the largest leading submatrix whose estimated
condition number is less than 1/rcond.  The order of R11, <b>rank</b>,
is the effective rank of A.
</p>

<p>
Then, R22 is considered to be negligible, and R12 is annihilated
by orthogonal transformations from the right, arriving at the
complete orthogonal factorization:
</p>

<pre>
     A * P = Q * [ T11 0 ] * Z
                 [  0  0 ]
</pre>

<p>
The minimum-norm solution is then
</p>

<pre>
     x = P * Z' [ inv(T11)*Q1'*b ]
                [        0       ]
</pre>

<p>
where Q1 consists of the first \"rank\" columns of Q.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>
(same as leastSquares, but with a right hand side matrix), <br>
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
(for square, regular matrices A)
</p>

</html>"));
    end leastSquares;

    package LAPACK
    "Interface to LAPACK library (should usually not directly be used but only indirectly via Modelica.Math.Matrices)"
      extends Modelica.Icons.Package;

      function dgelsx_vec
      "Computes the minimum-norm solution to a real linear least squares problem with rank deficient A"

        extends Modelica.Icons.Function;
        input Real A[:, :];
        input Real b[size(A,1)];
        input Real rcond=0.0 "Reciprocal condition number to estimate rank";
        output Real x[max(nrow,ncol)]= cat(1,b,zeros(max(nrow,ncol)-nrow))
        "solution is in first size(A,2) rows";
        output Integer info;
        output Integer rank "Effective rank of A";
    protected
        Integer nrow=size(A,1);
        Integer ncol=size(A,2);
        Integer nx=max(nrow,ncol);
        Integer lwork=max( min(nrow,ncol)+3*ncol, 2*min(nrow,ncol)+1);
        Real work[lwork];
        Real Awork[nrow,ncol]=A;
        Integer jpvt[ncol]=zeros(ncol);
        external "FORTRAN 77" dgelsx(nrow, ncol, 1, Awork, nrow, x, nx, jpvt,
                                    rcond, rank, work, lwork, info) annotation (Library="Lapack");

        annotation (
          Documentation(info="Lapack documentation
  Purpose
  =======

  DGELSX computes the minimum-norm solution to a real linear least
  squares problem:
      minimize || A * X - B ||
  using a complete orthogonal factorization of A.  A is an M-by-N
  matrix which may be rank-deficient.

  Several right hand side vectors b and solution vectors x can be
  handled in a single call; they are stored as the columns of the
  M-by-NRHS right hand side matrix B and the N-by-NRHS solution
  matrix X.

  The routine first computes a QR factorization with column pivoting:
      A * P = Q * [ R11 R12 ]
                  [  0  R22 ]
  with R11 defined as the largest leading submatrix whose estimated
  condition number is less than 1/RCOND.  The order of R11, RANK,
  is the effective rank of A.

  Then, R22 is considered to be negligible, and R12 is annihilated
  by orthogonal transformations from the right, arriving at the
  complete orthogonal factorization:
     A * P = Q * [ T11 0 ] * Z
                 [  0  0 ]
  The minimum-norm solution is then
     X = P * Z' [ inv(T11)*Q1'*B ]
                [        0       ]
  where Q1 consists of the first RANK columns of Q.

  Arguments
  =========

  M       (input) INTEGER
          The number of rows of the matrix A.  M >= 0.

  N       (input) INTEGER
          The number of columns of the matrix A.  N >= 0.

  NRHS    (input) INTEGER
          The number of right hand sides, i.e., the number of
          columns of matrices B and X. NRHS >= 0.

  A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
          On entry, the M-by-N matrix A.
          On exit, A has been overwritten by details of its
          complete orthogonal factorization.

  LDA     (input) INTEGER
          The leading dimension of the array A.  LDA >= max(1,M).

  B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
          On entry, the M-by-NRHS right hand side matrix B.
          On exit, the N-by-NRHS solution matrix X.
          If m >= n and RANK = n, the residual sum-of-squares for
          the solution in the i-th column is given by the sum of
          squares of elements N+1:M in that column.

  LDB     (input) INTEGER
          The leading dimension of the array B. LDB >= max(1,M,N).

  JPVT    (input/output) INTEGER array, dimension (N)
          On entry, if JPVT(i) .ne. 0, the i-th column of A is an
          initial column, otherwise it is a free column.  Before
          the QR factorization of A, all initial columns are
          permuted to the leading positions; only the remaining
          free columns are moved as a result of column pivoting
          during the factorization.
          On exit, if JPVT(i) = k, then the i-th column of A*P
          was the k-th column of A.

  RCOND   (input) DOUBLE PRECISION
          RCOND is used to determine the effective rank of A, which
          is defined as the order of the largest leading triangular
          submatrix R11 in the QR factorization with pivoting of A,
          whose estimated condition number < 1/RCOND.

  RANK    (output) INTEGER
          The effective rank of A, i.e., the order of the submatrix
          R11.  This is the same as the order of the submatrix T11
          in the complete orthogonal factorization of A.

  WORK    (workspace) DOUBLE PRECISION array, dimension
                      (max( min(M,N)+3*N, 2*min(M,N)+NRHS )),

  INFO    (output) INTEGER
          = 0:  successful exit
          < 0:  if INFO = -i, the i-th argument had an illegal value    "));

      end dgelsx_vec;
        annotation (Documentation(info="<html>
<p>
This package contains external Modelica functions as interface to the
LAPACK library
(<a href=\"http://www.netlib.org/lapack\">http://www.netlib.org/lapack</a>)
that provides FORTRAN subroutines to solve linear algebra
tasks. Usually, these functions are not directly called, but only via
the much more convenient interface of
<a href=\"modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a>.
The documentation of the LAPACK functions is a copy of the original
FORTRAN code. The details of LAPACK are described in:
</p>

<dl>
<dt>Anderson E., Bai Z., Bischof C., Blackford S., Demmel J., Dongarra J.,
    Du Croz J., Greenbaum A., Hammarling S., McKenney A., and Sorensen D.:</dt>
<dd> <a href=\"http://www.netlib.org/lapack/lug/lapack_lug.html\">Lapack Users' Guide</a>.
     Third Edition, SIAM, 1999.</dd>
</dl>

<p>
See also <a href=\"http://en.wikipedia.org/wiki/Lapack\">http://en.wikipedia.org/wiki/Lapack</a>.
</p>

<p>
This package contains a direct interface to the LAPACK subroutines
</p>

</html>"));
    end LAPACK;
    annotation (
      Documentation(info="<HTML>
<h4>Library content</h4>
<p>
This library provides functions operating on matrices. Below, the
functions are ordered according to categories and a typical
call of the respective function is shown.
Most functions are solely an interface to the external
<a href=\"modelica://Modelica.Math.Matrices.LAPACK\">LAPACK</a> library.
</p>

<p>
Note: A' is a short hand notation of transpose(A):
</p>

<p><b>Basic Information</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.toString\">toString</a>(A)
     - returns the string representation of matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.isEqual\">isEqual</a>(M1, M2)
     - returns true if matrices M1 and M2 have the same size and the same elements.</li>
</ul>

<p><b>Linear Equations</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.solve\">solve</a>(A,b)
     - returns solution x of the linear equation A*x=b (where b is a vector,
       and A is a square matrix that must be regular).</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.solve2\">solve2</a>(A,B)
     - returns solution X of the linear equation A*X=B (where B is a matrix,
       and A is a square matrix that must be regular)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares\">leastSquares</a>(A,b)
     - returns solution x of the linear equation A*x=b in a least squares sense
       (where b is a vector and A may be non-square and may be rank deficient)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">leastSquares2</a>(A,B)
     - returns solution X of the linear equation A*X=B in a least squares sense
       (where B is a matrix and A may be non-square and may be rank deficient)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.equalityLeastSquares\">equalityLeastSquares</a>(A,a,B,b)
     - returns solution x of a linear equality constrained least squares problem:
       min|A*x-a|^2 subject to B*x=b</<li>

<li> (LU,p,info) = <a href=\"modelica://Modelica.Math.Matrices.LU\">LU</a>(A)
     - returns the LU decomposition with row pivoting of a rectangular matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve\">LU_solve</a>(LU,p,b)
     - returns solution x of the linear equation L*U*x[p]=b with a b
       vector and an LU decomposition from \"LU(..)\".</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">LU_solve2</a>(LU,p,B)
     - returns solution X of the linear equation L*U*X[p,:]=B with a B
       matrix and an LU decomposition from \"LU(..)\".</li>
</ul>

<p><b>Matrix Factorizations</b></p>
<ul>
<li> (eval,evec) = <a href=\"modelica://Modelica.Math.Matrices.eigenValues\">eigenValues</a>(A)
     - returns eigen values \"eval\" and eigen vectors \"evec\" for a real,
       nonsymmetric matrix A in a Real representation.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">eigenValueMatrix</a>(eval)
     - returns real valued block diagonal matrix of the eigenvalues \"eval\" of matrix A.</li>

<li> (sigma,U,VT) = <a href=\"modelica://Modelica.Math.Matrices.singularValues\">singularValues</a>(A)
     - returns singular values \"sigma\" and left and right singular vectors U and VT
       of a rectangular matrix A.</li>

<li> (Q,R,p) = <a href=\"modelica://Modelica.Math.Matrices.QR\">QR</a>(A)
     - returns the QR decomposition with column pivoting of a rectangular matrix A
       such that Q*R = A[:,p].</li>

<li> (H,U) = <a href=\"modelica://Modelica.Math.Matrices.hessenberg\">hessenberg</a>(A)
     - returns the upper Hessenberg form H and the orthogonal transformation matrix U
       of a square matrix A such that H = U'*A*U.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.realSchur\">realSchur</a>(A)
     - returns the real Schur form of a square matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.cholesky\">cholesky</a>(A)
     - returns the cholesky factor H of a real symmetric positive definite matrix A so that A = H'*H.</li>

<li> (D,Aimproved) = <a href=\"modelica://Modelica.Math.Matrices.balance\">balance</a>(A)
     - returns an improved form Aimproved of a square matrix A that has a smaller condition as A,
       with Aimproved = inv(diagonal(D))*A*diagonal(D).</li>
</ul>

<p><b>Matrix Properties</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.trace\">trace</a>(A)
     - returns the trace of square matrix A, i.e., the sum of the diagonal elements.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.det\">det</a>(A)
     - returns the determinant of square matrix A (using LU decomposition; try to avoid det(..))</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.inv\">inv</a>(A)
     - returns the inverse of square matrix A (try to avoid, use instead \"solve2(..) with B=identity(..))</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.rank\">rank</a>(A)
     - returns the rank of square matrix A (computed with singular value decomposition)</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.conditionNumber\">conditionNumber</a>(A)
     - returns the condition number norm(A)*norm(inv(A)) of a square matrix A in the range 1..&infin;.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.rcond\">rcond</a>(A)
     - returns the reciprocal condition number 1/conditionNumber(A) of a square matrix A in the range 0..1.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.norm\">norm</a>(A)
     - returns the 1-, 2-, or infinity-norm of matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.frobeniusNorm\">frobeniusNorm</a>(A)
     - returns the Frobenius norm of matrix A.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.nullSpace\">nullSpace</a>(A)
     - returns the null space of matrix A.</li>
</ul>

<p><b>Matrix Exponentials</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.exp\">exp</a>(A)
     - returns the exponential e^A of a matrix A by adaptive Taylor series
       expansion with scaling and balancing</li>

<li> (phi, gamma) = <a href=\"modelica://Modelica.Math.Matrices.integralExp\">integralExp</a>(A,B)
     - returns the exponential phi=e^A and the integral gamma=integral(exp(A*t)*dt)*B as needed
       for a discretized system with zero order hold.</li>

<li> (phi, gamma, gamma1) = <a href=\"modelica://Modelica.Math.Matrices.integralExpT\">integralExpT</a>(A,B)
     - returns the exponential phi=e^A, the integral gamma=integral(exp(A*t)*dt)*B,
       and the time-weighted integral gamma1 = integral((T-t)*exp(A*t)*dt)*B as needed
       for a discretized system with first order hold.</li>
</ul>

<p><b>Matrix Equations</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">continuousLyapunov</a>(A,C)
     - returns solution X of the continuous-time Lyapunov equation X*A + A'*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">continuousSylvester</a>(A,B,C)
     - returns solution X of the continuous-time Sylvester equation A*X + X*B = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">continuousRiccati</a>(A,B,R,Q)
     - returns solution X of the continuous-time algebraic Riccat equation
       A'*X + X*A - X*B*inv(R)*B'*X + Q = 0</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">discreteLyapunov</a>(A,C)
     - returns solution X of the discretes-time Lyapunov equation A'*X*A + sgn*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">discreteSylvester</a>(A,B,C)
     - returns solution X of the discrete-time Sylvester equation A*X*B + sgn*X = C</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">discreteRiccati</a>(A,B,R,Q)
     - returns solution X of the discrete-time algebraic Riccat equation
       A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0</li>
</ul>

<p><b>Matrix Manipulation</b></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.sort\">sort</a>(M)
     - returns the sorted rows or columns of matrix M in ascending or descending order.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.flipLeftRight\">flipLeftRight</a>(M)
     - returns matrix M so that the columns of M are flipped in left/right direction.</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.flipUpDown\">flipUpDown</a>(M)
     - returns matrix M so that the rows of M are flipped in up/down direction.</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Vectors\">Vectors</a>

</HTML>
"));
  end Matrices;

  function sin "Sine"
    extends baseIcon1;
    input Modelica.SIunits.Angle u;
    output Real y;

  external "builtin" y=  sin(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},
                {-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},
                {-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},
                {29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{
                57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={0,0,0}),
          Text(
            extent={{12,84},{84,36}},
            lineColor={192,192,192},
            textString="sin")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{100,0},{84,6},{84,-6},{100,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},{
                -43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},{
                -14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},{
                29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,
                -61.9},{63.9,-47.2},{72,-24.8},{80,0}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-105,72},{-85,88}},
            textString="1",
            lineColor={0,0,255}),
          Text(
            extent={{70,25},{90,5}},
            textString="2*pi",
            lineColor={0,0,255}),
          Text(
            extent={{-103,-72},{-83,-88}},
            textString="-1",
            lineColor={0,0,255}),
          Text(
            extent={{82,-6},{102,-26}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{-80,80},{-28,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{-80,-80},{50,-80}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = sin(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end sin;

  function cos "Cosine"
    extends baseIcon1;
    input SI.Angle u;
    output Real y;

  external "builtin" y=  cos(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
                {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},
                {-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},
                {24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,
                73.4},{75.2,78.6},{80,80}}, color={0,0,0}),
          Text(
            extent={{-36,82},{36,34}},
            lineColor={192,192,192},
            textString="cos")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-103,72},{-83,88}},
            textString="1",
            lineColor={0,0,255}),
          Text(
            extent={{-103,-72},{-83,-88}},
            textString="-1",
            lineColor={0,0,255}),
          Text(
            extent={{70,25},{90,5}},
            textString="2*pi",
            lineColor={0,0,255}),
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{98,0},{82,6},{82,-6},{98,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},{-48.6,
                26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},{-4.42,
                -78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},{24.5,
                -45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,73.4},
                {75.2,78.6},{80,80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{78,-6},{98,-26}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{-80,-80},{18,-80}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = cos(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end cos;

  function tan "Tangent (u shall not be -pi/2, pi/2, 3*pi/2, ...)"
    extends baseIcon2;
    input SI.Angle u;
    output Real y;

  external "builtin" y=  tan(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},
                {-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},
                {33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,
                47.4},{76,56.1},{77.6,63.8},{80,80}}, color={0,0,0}),
          Text(
            extent={{-90,72},{-18,24}},
            lineColor={192,192,192},
            textString="tan")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-37,-72},{-17,-88}},
            textString="-5.8",
            lineColor={0,0,255}),
          Text(
            extent={{-33,86},{-13,70}},
            textString=" 5.8",
            lineColor={0,0,255}),
          Text(
            extent={{68,-13},{88,-33}},
            textString="1.4",
            lineColor={0,0,255}),
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{98,0},{82,6},{82,-6},{98,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},
                {-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},
                {33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,
                47.4},{76,56.1},{77.6,63.8},{80,80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{82,22},{102,2}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{0,80},{86,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{80,88},{80,-16}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = tan(u), with -&infin; &lt; u &lt; &infin;
(if u is a multiple of (2n-1)*pi/2, y = tan(u) is +/- infinity).
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end tan;

  function asin "Inverse sine (-1 <= u <= 1)"
    extends baseIcon2;
    input Real u;
    output SI.Angle y;

  external "builtin" y=  asin(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
                -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,
                52.7},{75.2,62.2},{77.6,67.5},{80,80}}, color={0,0,0}),
          Text(
            extent={{-88,78},{-16,30}},
            lineColor={192,192,192},
            textString="asin")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-40,-72},{-15,-88}},
            textString="-pi/2",
            lineColor={0,0,255}),
          Text(
            extent={{-38,88},{-13,72}},
            textString=" pi/2",
            lineColor={0,0,255}),
          Text(
            extent={{68,-9},{88,-29}},
            textString="+1",
            lineColor={0,0,255}),
          Text(
            extent={{-90,21},{-70,1}},
            textString="-1",
            lineColor={0,0,255}),
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{98,0},{82,6},{82,-6},{98,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,-49.8},
                {-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,52.7},{
                75.2,62.2},{77.6,67.5},{80,80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{82,24},{102,4}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{0,80},{86,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{80,86},{80,-10}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = asin(u), with -1 &le; u &le; +1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end asin;

  function cosh "Hyperbolic cosine"
    extends baseIcon2;
    input Real u;
    output Real y;

  external "builtin" y=  cosh(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,-86.083},{68,-86.083}}, color={192,192,192}),
          Polygon(
            points={{90,-86.083},{68,-78.083},{68,-94.083},{90,-86.083}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,
                1.29},{-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{-39,
                -64.3},{-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},{
                23.7,-75.2},{34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{
                59.1,-27.5},{63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{
                77.6,61.1},{80,80}}, color={0,0,0}),
          Text(
            extent={{4,66},{66,20}},
            lineColor={192,192,192},
            textString="cosh")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,-84.083},{84,-84.083}}, color={95,95,95}),
          Polygon(
            points={{98,-84.083},{82,-78.083},{82,-90.083},{98,-84.083}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,80},{-77.6,61.1},{-74.4,39.3},{-71.2,20.7},{-67.1,1.29},
                {-63.1,-14.6},{-58.3,-29.8},{-52.7,-43.5},{-46.2,-55.1},{-39,-64.3},
                {-30.2,-71.7},{-18.9,-77.1},{-4.42,-79.9},{10.9,-79.1},{23.7,-75.2},
                {34.2,-68.7},{42.2,-60.6},{48.6,-51.2},{54.3,-40},{59.1,-27.5},{
                63.1,-14.6},{67.1,1.29},{71.2,20.7},{74.4,39.3},{77.6,61.1},{80,
                80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-31,72},{-11,88}},
            textString="27",
            lineColor={0,0,255}),
          Text(
            extent={{64,-83},{84,-103}},
            textString="4",
            lineColor={0,0,255}),
          Text(
            extent={{-94,-63},{-74,-83}},
            textString="-4",
            lineColor={0,0,255}),
          Text(
            extent={{80,-60},{100,-80}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{0,80},{88,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{80,84},{80,-90}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = cosh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cosh.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end cosh;

  function tanh "Hyperbolic tangent"
    extends baseIcon2;
    input Real u;
    output Real y;

  external "builtin" y=  tanh(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={0.5,0.5}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-47.8,-78.7},{-35.8,-75.7},{-27.7,-70.6},{-22.1,
                -64.2},{-17.3,-55.9},{-12.5,-44.3},{-7.64,-29.2},{-1.21,-4.82},{
                6.83,26.3},{11.7,42},{16.5,54.2},{21.3,63.1},{26.9,69.9},{34.2,75},
                {45.4,78.4},{72,79.9},{80,80}}, color={0,0,0}),
          Text(
            extent={{-88,72},{-16,24}},
            lineColor={192,192,192},
            textString="tanh")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={0.5,0.5}), graphics={
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{96,0},{80,6},{80,-6},{96,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-80.5},{-47.8,-79.2},{-35.8,-76.2},{-27.7,-71.1},{-22.1,
                -64.7},{-17.3,-56.4},{-12.5,-44.8},{-7.64,-29.7},{-1.21,-5.32},{
                6.83,25.8},{11.7,41.5},{16.5,53.7},{21.3,62.6},{26.9,69.4},{34.2,
                74.5},{45.4,77.9},{72,79.4},{80,79.5}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-29,72},{-9,88}},
            textString="1",
            lineColor={0,0,255}),
          Text(
            extent={{3,-72},{23,-88}},
            textString="-1",
            lineColor={0,0,255}),
          Text(
            extent={{82,-2},{102,-22}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{0,80},{88,80}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = tanh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end tanh;

  function exp "Exponential, base e"
    extends baseIcon2;
    input Real u;
    output Real y;

  external "builtin" y=  exp(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),
          Polygon(
            points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
                {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
                67.1,18.6},{72,38.2},{76,57.6},{80,80}}, color={0,0,0}),
          Text(
            extent={{-86,50},{-14,2}},
            lineColor={192,192,192},
            textString="exp")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,-80.3976},{84,-80.3976}}, color={95,95,95}),
          Polygon(
            points={{98,-80.3976},{82,-74.3976},{82,-86.3976},{98,-80.3976}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},{
                34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
                67.1,18.6},{72,38.2},{76,57.6},{80,80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-31,72},{-11,88}},
            textString="20",
            lineColor={0,0,255}),
          Text(
            extent={{-92,-81},{-72,-101}},
            textString="-3",
            lineColor={0,0,255}),
          Text(
            extent={{66,-81},{86,-101}},
            textString="3",
            lineColor={0,0,255}),
          Text(
            extent={{2,-69},{22,-89}},
            textString="1",
            lineColor={0,0,255}),
          Text(
            extent={{78,-54},{98,-74}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{0,80},{88,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{80,84},{80,-84}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end exp;

  function log "Natural (base e) logarithm (u shall be > 0)"
    extends baseIcon1;
    input Real u;
    output Real y;

  external "builtin" y=  log(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-79.2,-50.6},{-78.4,-37},{-77.6,-28},{-76.8,-21.3},
                {-75.2,-11.4},{-72.8,-1.31},{-69.5,8.08},{-64.7,17.9},{-57.5,28},
                {-47,38.1},{-31.8,48.1},{-10.1,58},{22.1,68},{68.7,78.1},{80,80}},
              color={0,0,0}),
          Text(
            extent={{-6,-24},{66,-72}},
            lineColor={192,192,192},
            textString="log")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{100,0},{84,6},{84,-6},{100,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-78,-80},{-77.2,-50.6},{-76.4,-37},{-75.6,-28},{-74.8,-21.3},
                {-73.2,-11.4},{-70.8,-1.31},{-67.5,8.08},{-62.7,17.9},{-55.5,28},
                {-45,38.1},{-29.8,48.1},{-8.1,58},{24.1,68},{70.7,78.1},{82,80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-105,72},{-85,88}},
            textString="3",
            lineColor={0,0,255}),
          Text(
            extent={{60,-3},{80,-23}},
            textString="20",
            lineColor={0,0,255}),
          Text(
            extent={{-78,-7},{-58,-27}},
            textString="1",
            lineColor={0,0,255}),
          Text(
            extent={{84,26},{104,6}},
            lineColor={95,95,95},
            textString="u"),
          Text(
            extent={{-100,9},{-80,-11}},
            textString="0",
            lineColor={0,0,255}),
          Line(
            points={{-80,80},{84,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{82,82},{82,-6}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = log(10) (the natural logarithm of u),
with u &gt; 0:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\">
</p>
</html>"),   Library="ModelicaExternalC");
  end log;

  partial function baseIcon1
    "Basic icon for mathematical function with y-axis on left side"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                          Diagram(
          coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,80},{-88,80}}, color={95,95,95}),
          Line(points={{-80,-80},{-88,-80}}, color={95,95,95}),
          Line(points={{-80,-90},{-80,84}}, color={95,95,95}),
          Text(
            extent={{-75,104},{-55,84}},
            lineColor={95,95,95},
            textString="y"),
          Polygon(
            points={{-80,98},{-86,82},{-74,82},{-80,98}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis on the left side.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
  end baseIcon1;

  partial function baseIcon2
    "Basic icon for mathematical function with y-axis in middle"

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,-80},{0,68}}, color={192,192,192}),
          Polygon(
            points={{0,90},{-8,68},{8,68},{0,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                          Diagram(graphics={
          Line(points={{0,80},{-8,80}}, color={95,95,95}),
          Line(points={{0,-80},{-8,-80}}, color={95,95,95}),
          Line(points={{0,-90},{0,84}}, color={95,95,95}),
          Text(
            extent={{5,104},{25,84}},
            lineColor={95,95,95},
            textString="y"),
          Polygon(
            points={{0,98},{-6,82},{6,82},{0,98}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis in the middle.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
  end baseIcon2;
  annotation (
    Invisible=true,
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(
          extent={{-59,-9},{42,-56}},
          lineColor={0,0,0},
          textString="f(x)")}),
    Documentation(info="<HTML>
<p>
This package contains <b>basic mathematical functions</b> (such as sin(..)),
as well as functions operating on
<a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
<a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
<a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
</p>

<dl>
<dt><b>Main Authors:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
    Marcus Baur<br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p>
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
",   revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Function tempInterpol2 added.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</html>"));
  end Math;

  package Utilities
  "Library of utility functions dedicated to scripting (operating on files, streams, strings, system)"
    extends Modelica.Icons.Package;

    package Streams "Read from files and write to files"
      extends Modelica.Icons.Package;

      function error "Print error message and cancel all actions"
        extends Modelica.Icons.Function;
        input String string "String to be printed to error message window";
        external "C" ModelicaError(string);
        annotation (Library="ModelicaExternalC",
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Streams.<b>error</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Print the string \"string\" as error message and
cancel all actions. Line breaks are characterized
by \"\\n\" in the string.
</p>
<h4>Example</h4>
<blockquote><pre>
  Streams.error(\"x (= \" + String(x) + \")\\nhas to be in the range 0 .. 1\");
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.print\">Streams.print</a>,
<a href=\"modelica://ModelicaReference.Operators.string\">String</a>
</p>
</html>"));
      end error;
      annotation (
        Documentation(info="<HTML>
<h4>Library content</h4>
<p>
Package <b>Streams</b> contains functions to input and output strings
to a message window or on files. Note that a string is interpreted
and displayed as html text (e.g., with print(..) or error(..))
if it is enclosed with the Modelica html quotation, e.g.,
</p>
<center>
string = \"&lt;html&gt; first line &lt;br&gt; second line &lt;/html&gt;\".
</center>
<p>
It is a quality of implementation, whether (a) all tags of html are supported
or only a subset, (b) how html tags are interpreted if the output device
does not allow to display formatted text.
</p>
<p>
In the table below an example call to every function is given:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function/type</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string)<br>
          <a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string,fileName)</td>
      <td valign=\"top\"> Print string \"string\" or vector of strings to message window or on
           file \"fileName\".</td>
  </tr>
  <tr><td valign=\"top\">stringVector =
         <a href=\"modelica://Modelica.Utilities.Streams.readFile\">readFile</a>(fileName)</td>
      <td valign=\"top\"> Read complete text file and return it as a vector of strings.</td>
  </tr>
  <tr><td valign=\"top\">(string, endOfFile) =
         <a href=\"modelica://Modelica.Utilities.Streams.readLine\">readLine</a>(fileName, lineNumber)</td>
      <td valign=\"top\">Returns from the file the content of line lineNumber.</td>
  </tr>
  <tr><td valign=\"top\">lines =
         <a href=\"modelica://Modelica.Utilities.Streams.countLines\">countLines</a>(fileName)</td>
      <td valign=\"top\">Returns the number of lines in a file.</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.error\">error</a>(string)</td>
      <td valign=\"top\"> Print error message \"string\" to message window
           and cancel all actions</td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Streams.close\">close</a>(fileName)</td>
      <td valign=\"top\"> Close file if it is still open. Ignore call if
           file is already closed or does not exist. </td>
  </tr>
</table>
<p>
Use functions <b>scanXXX</b> from package
<a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
to parse a string.
</p>
<p>
If Real, Integer or Boolean values shall be printed
or used in an error message, they have to be first converted
to strings with the builtin operator
<a href=\"modelica://ModelicaReference.Operators.string\">String</a>(...).
Example:
</p>
<pre>
  <b>if</b> x &lt; 0 <b>or</b> x &gt; 1 <b>then</b>
     Streams.error(\"x (= \" + String(x) + \") has to be in the range 0 .. 1\");
  <b>end if</b>;
</pre>
</HTML>
"));
    end Streams;

    package Strings "Operations on strings"
      extends Modelica.Icons.Package;

      function compare "Compare two strings lexicographically"
        extends Modelica.Icons.Function;
        input String string1;
        input String string2;
        input Boolean caseSensitive=true
        "= false, if case of letters is ignored";
        output Modelica.Utilities.Types.Compare result "Result of comparison";
      external "C" result = ModelicaStrings_compare(string1, string2, caseSensitive);
        annotation (Library="ModelicaExternalC", Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = Strings.<b>compare</b>(string1, string2);
result = Strings.<b>compare</b>(string1, string2, caseSensitive=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Compares two strings. If the optional argument caseSensitive=false,
upper case letters are treated as if they would be lower case letters.
The result of the comparison is returned as:
</p>
<pre>
  result = Modelica.Utilities.Types.Compare.Less     // string1 &lt; string2
         = Modelica.Utilities.Types.Compare.Equal    // string1 = string2
         = Modelica.Utilities.Types.Compare.Greater  // string1 &gt; string2
</pre>
<p>
Comparison is with regards to lexicographical order,
e.g., \"a\" &lt; \"b\";
</p>
</html>"));
      end compare;

      function isEqual "Determine whether two strings are identical"
        extends Modelica.Icons.Function;
        input String string1;
        input String string2;
        input Boolean caseSensitive=true
        "= false, if lower and upper case are ignored for the comparison";
        output Boolean identical "True, if string1 is identical to string2";
      algorithm
        identical :=compare(string1, string2, caseSensitive) == Types.Compare.Equal;
        annotation (
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>isEqual</b>(string1, string2);
Strings.<b>isEqual</b>(string1, string2, caseSensitive=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Compare whether two strings are identical,
optionally ignoring case.
</p>
</html>"));
      end isEqual;
      annotation (
        Documentation(info="<HTML>
<h4>Library content</h4>
<p>
Package <b>Strings</b> contains functions to manipulate strings.
</p>
<p>
In the table below an example
call to every function is given using the <b>default</b> options.
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\">len = <a href=\"modelica://Modelica.Utilities.Strings.length\">length</a>(string)</td>
      <td valign=\"top\">Returns length of string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.substring\">substring</a>(string1,startIndex,endIndex)
       </td>
      <td valign=\"top\">Returns a substring defined by start and end index</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n)<br>
 result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n,string)</td>
      <td valign=\"top\">Repeat a blank or a string n times.</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.compare\">compare</a>(string1, string2)</td>
      <td valign=\"top\">Compares two substrings with regards to alphabetical order</td></tr>
  <tr><td valign=\"top\">identical =
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">isEqual</a>(string1,string2)</td>
      <td valign=\"top\">Determine whether two strings are identical</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.count\">count</a>(string,searchString)</td>
      <td valign=\"top\">Count the number of occurrences of a string</td></tr>
  <tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.find\">find</a>(string,searchString)</td>
      <td valign=\"top\">Find first occurrence of a string in another string</td></tr>
<tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.findLast\">findLast</a>(string,searchString)</td>
      <td valign=\"top\">Find last occurrence of a string in another string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.replace\">replace</a>(string,searchString,replaceString)</td>
      <td valign=\"top\">Replace one or all occurrences of a string</td></tr>
  <tr><td valign=\"top\">stringVector2 = <a href=\"modelica://Modelica.Utilities.Strings.sort\">sort</a>(stringVector1)</td>
      <td valign=\"top\">Sort vector of strings in alphabetic order</td></tr>
  <tr><td valign=\"top\">(token, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanToken\">scanToken</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a token (Real/Integer/Boolean/String/Identifier/Delimiter/NoToken)</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">scanReal</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Real constant</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanInteger\">scanInteger</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an Integer constant</td></tr>
  <tr><td valign=\"top\">(boolean, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanBoolean\">scanBoolean</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Boolean constant</td></tr>
  <tr><td valign=\"top\">(string2, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanString\">scanString</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a String constant</td></tr>
  <tr><td valign=\"top\">(identifier, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanIdentifier\">scanIdentifier</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an identifier</td></tr>
  <tr><td valign=\"top\">(delimiter, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanDelimiter\">scanDelimiter</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for delimiters</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.scanNoToken\">scanNoToken</a>(string,startIndex)</td>
      <td valign=\"top\">Check that remaining part of string consists solely of <br>
          white space or line comments (\"// ...\\n\").</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.syntaxError\">syntaxError</a>(string,index,message)</td>
      <td valign=\"top\"> Print a \"syntax error message\" as well as a string and the <br>
           index at which scanning detected an error</td></tr>
</table>
<p>
The functions \"compare\", \"isEqual\", \"count\", \"find\", \"findLast\", \"replace\", \"sort\"
have the optional
input argument <b>caseSensitive</b> with default <b>true</b>.
If <b>false</b>, the operation is carried out without taking
into account whether a character is upper or lower case.
</p>
</HTML>"));
    end Strings;

    package Types "Type definitions used in package Modelica.Utilities"
      extends Modelica.Icons.Package;

      type Compare = enumeration(
        Less "String 1 is lexicographically less than string 2",
        Equal "String 1 is identical to string 2",
        Greater "String 1 is lexicographically greater than string 2")
      "Enumeration defining comparision of two strings";
      annotation (Documentation(info="<html>
<p>
This package contains type definitions used in Modelica.Utilities.
</p>

</html>"));
    end Types;
      annotation (
  Documentation(info="<html>
<p>
This package contains Modelica <b>functions</b> that are
especially suited for <b>scripting</b>. The functions might
be used to work with strings, read data from file, write data
to file or copy, move and remove files.
</p>
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.UsersGuide\">Modelica.Utilities.User's Guide</a>
     discusses the most important aspects of this library.</li>
<li> <a href=\"modelica://Modelica.Utilities.Examples\">Modelica.Utilities.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
The following main sublibraries are available:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.Files\">Files</a>
     provides functions to operate on files and directories, e.g.,
     to copy, move, remove files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>
     provides functions to read from files and write to files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
     provides functions to operate on strings. E.g.
     substring, find, replace, sort, scanToken.</li>
<li> <a href=\"modelica://Modelica.Utilities.System\">System</a>
     provides functions to interact with the environment.
     E.g., get or set the working directory or environment
     variables and to send a command to the default shell.</li>
</ul>

<p>
Copyright &copy; 1998-2010, Modelica Association, DLR, and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>
"));
  end Utilities;

  package Constants
  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Package;

    final constant Real pi=2*Modelica.Math.asin(1.0);

    final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";

    final constant Real small=1.e-60
    "Smallest number such that small and -small are representable on the machine";

    final constant Real R(final unit="J/(mol.K)") = 8.314472
    "Molar gas constant";

    final constant Real sigma(final unit="W/(m2.K4)") = 5.670400e-8
    "Stefan-Boltzmann constant";

    final constant NonSI.Temperature_degC T_zero=-273.15
    "Absolute zero temperature";
    annotation (
      Documentation(info="<html>
<p>
This package provides often needed constants from mathematics, machine
dependent constants and constants from nature. The latter constants
(name, value, description) are from the following source:
</p>

<dl>
<dt>Peter J. Mohr and Barry N. Taylor (1999):</dt>
<dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 1998</b>.
    Journal of Physical and Chemical Reference Data, Vol. 28, No. 6, 1999 and
    Reviews of Modern Physics, Vol. 72, No. 2, 2000. See also <a href=
\"http://physics.nist.gov/cuu/Constants/\">http://physics.nist.gov/cuu/Constants/</a></dd>
</dl>

<p>CODATA is the Committee on Data for Science and Technology.</p>

<dl>
<dt><b>Main Author:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 11 16<br>
    D-82230 We&szlig;ling<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>

<p>
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>
",   revisions="<html>
<ul>
<li><i>Nov 8, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Constants updated according to 2002 CODATA values.</li>
<li><i>Dec 9, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants updated according to 1998 CODATA values. Using names, values
       and description text from this source. Included magnetic and
       electric constant.</li>
<li><i>Sep 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants eps, inf, small introduced.</li>
<li><i>Nov 15, 1997</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"),
      Invisible=true,
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(
            points={{-34,-38},{12,-38}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-20,-38},{-24,-48},{-28,-56},{-34,-64}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-2,-38},{2,-46},{8,-56},{14,-64}},
            color={0,0,0},
            thickness=0.5)}),
      Diagram(graphics={
          Rectangle(
            extent={{200,162},{380,312}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{200,312},{220,332},{400,332},{380,312},{200,312}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{400,332},{400,182},{380,162},{380,312},{400,332}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{210,302},{370,272}},
            lineColor={160,160,164},
            textString="Library"),
          Line(
            points={{266,224},{312,224}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{280,224},{276,214},{272,206},{266,198}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{298,224},{302,216},{308,206},{314,198}},
            color={0,0,0},
            thickness=1),
          Text(
            extent={{152,412},{458,334}},
            lineColor={255,0,0},
            textString="Modelica.Constants")}));
  end Constants;

  package Icons "Library of icons"
    extends Icons.Package;

    partial package Package "Icon for standard packages"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
    end Package;

    partial package BasesPackage "Icon for packages containing base classes"
    //extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-30,10},{10,-30}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>This icon shall be used for a package/library that contains base models and classes, respectively.</p>
</html>"));
    end BasesPackage;

    partial package InterfacesPackage "Icon for packages containing interfaces"
    //extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,50},{20,50},{50,10},{80,10},{80,-30},{50,-30},{20,-70},{
                  0,-70},{0,50}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,10},{-70,10},{-40,50},{-20,50},{-20,-70},{-40,-70},{
                  -70,-30},{-100,-30},{-100,10}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>This icon indicates packages containing interfaces.</p>
</html>"));
    end InterfacesPackage;

    partial package SourcesPackage "Icon for packages containing sources"
    //extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-28,12},{-28,-40},{36,-14},{-28,12}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-28,-14},{-68,-14}},
              color={0,0,0},
              smooth=Smooth.None)}),
                                Documentation(info="<html>
<p>This icon indicates a package which contains sources.</p>
</html>"));
    end SourcesPackage;

    partial package MaterialPropertiesPackage
    "Icon for package containing property classes"
    //extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-68,50},{52,-70}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={215,230,240})}),
                                Documentation(info="<html>
<p>This icon indicates a package that contains properties</p>
</html>"));
    end MaterialPropertiesPackage;

    partial class MaterialProperty "Icon for property classes"

      annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),       graphics={
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={215,230,240})}),
                                Documentation(info="<html>
<p>This icon indicates a property class.</p>
</html>"));
    end MaterialProperty;

    partial function Function "Icon for functions"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(extent={{-140,162},{136,102}}, textString=
                                                   "%name"),
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,100},{100,-100}},
              lineColor={255,127,0},
              textString=
                   "f")}),Documentation(Error, info="<html>
<p>This icon indicates Modelica functions.</p>
</html>"));
    end Function;

    partial record Record "Icon for records"

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-100,50},{100,-100}},
              fillColor={255,255,127},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Text(
              extent={{-127,115},{127,55}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
            Line(points={{-100,0},{100,0}}, color={0,0,0}),
            Line(points={{0,50},{0,-100}}, color={0,0,0})}),
                                                          Documentation(info="<html>
<p>
This icon is indicates a record.
</p>
</html>"));
    end Record;

    partial package Library
    "This icon will be removed in future Modelica versions, use Package instead"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>This icon of a package will be removed in future versions of the library.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Package\">Package</a> shall be used.</p>
</html>"));
    end Library;
    annotation(Documentation(__Dymola_DocumentationClass=true, info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer. </p>
<dl>
<dt><b>Main Authors:</b> </dt>
    <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dd><dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd><dd>Oberpfaffenhofen</dd><dd>Postfach 1116</dd><dd>D-82230 Wessling</dd><dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd><br>
    <dd>Christian Kral</dd><dd><a href=\"http://www.ait.ac.at/\">Austrian Institute of Technology, AIT</a></dd><dd>Mobility Department</dd><dd>Giefinggasse 2</dd><dd>1210 Vienna, Austria</dd><dd>email: <a href=\"mailto:christian.kral@ait.ac.at\">christian.kral@ait.ac.at</a></dd><br>
    <dd align=\"justify\">Johan Andreasson</dd><dd align=\"justify\"><a href=\"http://www.modelon.se/\">Modelon AB</a></dd><dd align=\"justify\">Ideon Science Park</dd><dd align=\"justify\">22370 Lund, Sweden</dd><dd align=\"justify\">email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>
<p>Copyright &copy; 1998-2010, Modelica Association, DLR, AIT, and Modelon AB. </p>
<p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
</html>"));
  end Icons;

  package SIunits
  "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;

    package Conversions
    "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Package;

      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Package;

        type Temperature_degC = Real (final quantity="ThermodynamicTemperature",
              final unit="degC")
        "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)"
                                                                                                            annotation(__Dymola_absoluteValue=true);

        type Angle_deg = Real (final quantity="Angle", final unit="deg")
        "Angle in degree";

        type Pressure_bar = Real (final quantity="Pressure", final unit="bar")
        "Absolute pressure in bar";
        annotation (Documentation(info="<HTML>
<p>
This package provides predefined types, such as <b>Angle_deg</b> (angle in
degree), <b>AngularVelocity_rpm</b> (angular velocity in revolutions per
minute) or <b>Temperature_degF</b> (temperature in degree Fahrenheit),
which are in common use but are not part of the international standard on
units according to ISO 31-1992 \"General principles concerning quantities,
units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
the use of their multiples and of certain other units\".</p>
<p>If possible, the types in this package should not be used. Use instead
types of package Modelica.SIunits. For more information on units, see also
the book of Francois Cardarelli <b>Scientific Unit Conversion - A
Practical Guide to Metrication</b> (Springer 1997).</p>
<p>Some units, such as <b>Temperature_degC/Temp_C</b> are both defined in
Modelica.SIunits and in Modelica.Conversions.NonSIunits. The reason is that these
definitions have been placed erroneously in Modelica.SIunits although they
are not SIunits. For backward compatibility, these type definitions are
still kept in Modelica.SIunits.</p>
</HTML>
"),   Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{-66,-13},{52,-67}},
                lineColor={0,0,0},
                textString="[km/h]")}));
      end NonSIunits;

      function to_degC "Convert from Kelvin to degCelsius"
        extends ConversionIcon;
        input Temperature Kelvin "Kelvin value";
        output NonSIunits.Temperature_degC Celsius "Celsius value";
      algorithm
        Celsius := Kelvin + Modelica.Constants.T_zero;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-20,100},{-100,20}},
                lineColor={0,0,0},
                textString="K"), Text(
                extent={{100,-20},{20,-100}},
                lineColor={0,0,0},
                textString="degC")}));
      end to_degC;

      function from_degC "Convert from degCelsius to Kelvin"
        extends ConversionIcon;
        input NonSIunits.Temperature_degC Celsius "Celsius value";
        output Temperature Kelvin "Kelvin value";
      algorithm
        Kelvin := Celsius - Modelica.Constants.T_zero;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-20,100},{-100,20}},
                lineColor={0,0,0},
                textString="degC"),  Text(
                extent={{100,-20},{20,-100}},
                lineColor={0,0,0},
                textString="K")}));
      end from_degC;

      function to_deg "Convert from radian to degree"
        extends ConversionIcon;
        input Angle radian "radian value";
        output NonSIunits.Angle_deg degree "degree value";
      algorithm
        degree := (180.0/Modelica.Constants.pi)*radian;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{10,100},{-100,46}},
                lineColor={0,0,0},
                textString="rad"), Text(
                extent={{100,-44},{-10,-100}},
                lineColor={0,0,0},
                textString="deg")}));
      end to_deg;

      function to_bar "Convert from Pascal to bar"
        extends ConversionIcon;
        input Pressure Pa "Pascal value";
        output NonSIunits.Pressure_bar bar "bar value";
      algorithm
        bar := Pa/1e5;
        annotation (Inline=true,Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Text(
                extent={{-12,100},{-100,56}},
                lineColor={0,0,0},
                textString="Pa"),     Text(
                extent={{98,-52},{-4,-100}},
                lineColor={0,0,0},
                textString="bar")}));
      end to_bar;

      partial function ConversionIcon "Base icon for conversion functions"

        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={191,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{30,0}}, color={191,0,0}),
              Polygon(
                points={{90,0},{30,20},{30,-20},{90,0}},
                lineColor={191,0,0},
                fillColor={191,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-115,155},{115,105}},
                textString="%name",
                lineColor={0,0,255})}));
      end ConversionIcon;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true,
                       extent={{-100,-100},{100,100}}), graphics),
                                Documentation(info="<HTML>
<p>This package provides conversion functions from the non SI Units
defined in package Modelica.SIunits.Conversions.NonSIunits to the
corresponding SI Units defined in package Modelica.SIunits and vice
versa. It is recommended to use these functions in the following
way (note, that all functions have one Real input and one Real output
argument):</p>
<pre>
  <b>import</b> SI = Modelica.SIunits;
  <b>import</b> Modelica.SIunits.Conversions.*;
     ...
  <b>parameter</b> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to Kelvin
  <b>parameter</b> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
  <b>parameter</b> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                      // to radian per seconds
</pre>

</HTML>
"));
    end Conversions;

    type Angle = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");

    type Length = Real (final quantity="Length", final unit="m");

    type Area = Real (final quantity="Area", final unit="m2");

    type Time = Real (final quantity="Time", final unit="s");

    type Velocity = Real (final quantity="Velocity", final unit="m/s");

    type Density = Real (
        final quantity="Density",
        final unit="kg/m3",
        displayUnit="g/cm3",
        min=0);

    type Pressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar");

    type AbsolutePressure = Pressure (min=0);

    type DynamicViscosity = Real (
        final quantity="DynamicViscosity",
        final unit="Pa.s",
        min=0);

    type SurfaceTension = Real (final quantity="SurfaceTension", final unit="N/m");

    type Power = Real (final quantity="Power", final unit="W");

    type EnthalpyFlowRate = Real (final quantity="EnthalpyFlowRate", final unit=
            "W");

    type MassFlowRate = Real (quantity="MassFlowRate", final unit="kg/s");

    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0,
        start = 288.15,
        displayUnit="degC")
    "Absolute temperature (use type TemperatureDifference for relative temperatures)"
                                                                                                        annotation(__Dymola_absoluteValue=true);

    type Temp_K = ThermodynamicTemperature;

    type Temperature = ThermodynamicTemperature;

    type TemperatureDifference = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K") annotation(__Dymola_absoluteValue=false);

    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit="1/K");

    type Compressibility = Real (final quantity="Compressibility", final unit=
            "1/Pa");

    type IsothermalCompressibility = Compressibility;

    type HeatFlowRate = Real (final quantity="Power", final unit="W");

    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit=
               "W/(m.K)");

    type ThermalConductance = Real (final quantity="ThermalConductance", final unit=
               "W/K");

    type ThermalDiffusivity = Real (final quantity="ThermalDiffusivity", final unit=
               "m2/s");

    type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K");

    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");

    type RatioOfSpecificHeatCapacities = Real (final quantity=
            "RatioOfSpecificHeatCapacities", final unit="1");

    type SpecificEntropy = Real (final quantity="SpecificEntropy", final unit=
            "J/(kg.K)");

    type SpecificEnergy = Real (final quantity="SpecificEnergy", final unit=
            "J/kg");

    type SpecificInternalEnergy = SpecificEnergy;

    type SpecificEnthalpy = SpecificEnergy;

    type DerDensityByEnthalpy = Real (final unit="kg.s2/m5");

    type DerDensityByPressure = Real (final unit="s2/m2");

    type DerDensityByTemperature = Real (final unit="kg/(m3.K)");

    type DerEnthalpyByPressure = Real (final unit="J.m.s2/kg2");

    type Irradiance = Real (final quantity="Irradiance", final unit="W/m2");

    type Emissivity = Real (final quantity="Emissivity", final unit="1");

    type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol",min=0);

    type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol", min=0);

    type MassFraction = Real (final quantity="MassFraction", final unit="1");

    type MoleFraction = Real (final quantity="MoleFraction", final unit="1");

    type PrandtlNumber = Real (final quantity="PrandtlNumber", final unit="1");
    annotation (
      Invisible=true,
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={Text(
            extent={{-63,-13},{45,-67}},
            lineColor={0,0,0},
            textString="[kg.m2]")}),
      Documentation(info="<html>
<p>This package provides predefined types, such as <i>Mass</i>,
<i>Angle</i>, <i>Time</i>, based on the international standard
on units, e.g.,
</p>

<pre>   <b>type</b> Angle = Real(<b>final</b> quantity = \"Angle\",
                     <b>final</b> unit     = \"rad\",
                     displayUnit    = \"deg\");
</pre>

<p>
as well as conversion functions from non SI-units to SI-units
and vice versa in subpackage
<a href=\"modelica://Modelica.SIunits.Conversions\">Conversions</a>.
</p>

<p>
For an introduction how units are used in the Modelica standard library
with package SIunits, have a look at:
<a href=\"modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
</p>

<p>
Copyright &copy; 1998-2010, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>Jan. 27, 2010</i> by Christian Kral:<br/>Added complex units.</li>
<li><i>Dec. 14, 2005</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
<li><i>October 21, 2002</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br/>Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
<li><i>June 6, 2000</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
<li><i>Oct. 27, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
<li><i>Sept. 18, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
<li><i>Aug 12, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
<li><i>June 29, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><i>April 8, 1998</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
<li><i>Nov. 15, 1997</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>:<br/>Some chapters realized.</li>
</ul>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{169,86},{349,236}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{169,236},{189,256},{369,256},{349,236},{169,236}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Polygon(
            points={{369,256},{369,106},{349,86},{349,236},{369,256}},
            fillColor={235,235,235},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Text(
            extent={{179,226},{339,196}},
            lineColor={160,160,164},
            textString="Library"),
          Text(
            extent={{206,173},{314,119}},
            lineColor={0,0,0},
            textString="[kg.m2]"),
          Text(
            extent={{163,320},{406,264}},
            lineColor={255,0,0},
            textString="Modelica.SIunits")}));
  end SIunits;
annotation (
preferredView="info",
version="3.2",
versionBuild=9,
versionDate="2010-10-25",
dateModified = "2012-02-09 11:32:00Z",
revisionId="",
uses(Complex(version="1.0"), ModelicaServices(version="1.2")),
conversion(
 noneFromVersion="3.1",
 noneFromVersion="3.0.1",
 noneFromVersion="3.0",
 from(version="2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")),
__Dymola_classOrder={"UsersGuide","Blocks","StateGraph","Electrical","Magnetic","Mechanics","Fluid","Media","Thermal",
      "Math","Utilities","Constants", "Icons", "SIunits"},
Settings(NewStateSelection=true),
Documentation(info="<HTML>
<p>
Package <b>Modelica&reg;</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica&reg; language from the
Modelica Association, see
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides model components in many domains that are based on
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.UsersGuide.Overview\">Overview</a>
  provides an overview of the Modelica Standard Library
  inside the <a href=\"modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
<li><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
 summarizes the changes of new versions of this package.</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Contact\">Contact</a>
  lists the contributors of the Modelica Standard Library.</li>
<li> The <b>Examples</b> packages in the various libraries, demonstrate
  how to use the components of the corresponding sublibrary.</li>
</ul>

<p>
This version of the Modelica Standard Library consists of
</p>
<ul>
<li> <b>1280</b> models and blocks, and</li>
<li> <b>910</b> functions
</ul>
<p>
that are directly usable (= number of public, non-partial classes).
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2010, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, Fraunhofer, A.Haumer, Modelon,
TU Hamburg-Harburg, Politecnico di Milano.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>
"));
end Modelica;

package IDEAS "Integrated District Energy Assessment Simulation"
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;

  model SimInfoManager
  "Simulation information manager for handling time and climate data required in each for simulation."

    replaceable parameter IDEAS.Climate.Meteo.Files.min60 detail constrainedby
    IDEAS.Climate.Meteo.Detail "Timeframe detail of the climate data"
                                               annotation (Dialog(group="Climate"));
    replaceable parameter IDEAS.Climate.Meteo.Locations.Uccle city constrainedby
    IDEAS.Climate.Meteo.Location "Location of the depicted climate data"
                                                annotation (Dialog(group="Climate"));
    parameter Boolean occBeh = false
    "put to true if  user behaviour is to be read from files"
                                           annotation(Dialog(group="User behaviour"));

    parameter Boolean DHW = false
    "put to true if domestic how water (DHW) consumption is to be read from files"
                                           annotation(Dialog(group="User behaviour"));
    parameter Boolean PV = false
    "put to true if photovoltaics is to be read from files "
                                           annotation(Dialog(group="Photovoltaics"));

    replaceable parameter IDEAS.Occupants.Extern.Interfaces.Occ_Files occupants constrainedby
    IDEAS.Occupants.Extern.Interfaces.Occ_Files
    "Specifies the files with occupant behavior"   annotation(Dialog(group="User behaviour"));
    parameter Integer nOcc = 33 "Number of occupant profiles to be read" annotation(Dialog(group="User behaviour"));

    parameter String fileNamePv = "onePVpanel10min"
    "Filename for photvoltaic profiles"                                                           annotation(Dialog(group="Photovoltaics"));
    parameter Integer nPV = 33 "Number of photovoltaic profiles" annotation(Dialog(group="Photovoltaics"));
    parameter Integer PNom = 1000
    "Nominal power (W) of the photovoltaic profiles"                               annotation(Dialog(group="Photovoltaics"));

protected
    final parameter String filNamClim = "../Inputs/" + city.locNam + detail.filNam;
    final parameter Modelica.SIunits.Angle lat(displayUnit="deg") = city.lat
    "latitude of the locatioin";
    final parameter Modelica.SIunits.Angle lon(displayUnit="deg") = city.lon;
    final parameter Modelica.SIunits.Temperature Tdes = city.Tdes
    "design outdoor temperature";
    final parameter Modelica.SIunits.Temperature TdesGround = city.TdesGround
    "design ground temperature";
    final parameter Modelica.SIunits.Time timZonSta = city.timZonSta
    "standard time zone";
    final parameter Boolean DST = city.DST
    "boolean to take into account daylight saving time";
    final parameter Integer yr = city.yr "depcited year for DST only";

    final parameter Boolean BesTest = Modelica.Utilities.Strings.isEqual(city.locNam,"BesTest")
    "boolean to determine if this simulation is a BESTEST simulation";

public
    Modelica.SIunits.Irradiance solDirPer = climate_solar.y[3]
    "direct irradiation on normal to solar zenith";
    Modelica.SIunits.Irradiance solDirHor = climate_solar.y[1]-climate_solar.y[2]
    "direct irradiation on horizontal surface";
    Modelica.SIunits.Irradiance solDifHor = climate_solar.y[2]
    "difuse irradiation on horizontal surface";
    Modelica.SIunits.Irradiance solGloHor = solDirHor + solDifHor
    "global irradiation on horizontal";
    Modelica.SIunits.Temperature Te = climate_nonSolar.y[1] + 273.15
    "ambient outdoor temperature for determination of sky radiation exchange";
    Modelica.SIunits.Temperature Tsky "effective overall sky temperature";
    Modelica.SIunits.Temperature TeAv = Te
    "running average of ambient outdoor temperature of the last 5 days, not yet implemented";
    Modelica.SIunits.Temperature Tground = TdesGround "ground temperature";
    Modelica.SIunits.Velocity Va "air velocity";
    Real Fc "cloud factor";
    Modelica.SIunits.Irradiance irr = climate_solar.y[1];
    Boolean summer = timMan.summer;

    Boolean day = true;

    Modelica.SIunits.Time timLoc = timMan.timLoc "Local time";
    Modelica.SIunits.Time timSol = timMan.timSol "Solar time";
    Modelica.SIunits.Time timCal = timMan.timCal "Calendar time";

protected
    IDEAS.Climate.Time.SimTimes timMan(
      delay=detail.timestep/2,
      timZonSta=timZonSta,
      lon=lon,
      DST=false,
      ifSolCor=true)
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Blocks.Tables.CombiTable1Ds climate_nonSolar(final smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      final tableOnFile=true, final tableName="data",final fileName=filNamClim, final columns = {15,16,12,10})
      annotation (Placement(transformation(extent={{-40,66},{-26,80}})));
    Modelica.Blocks.Tables.CombiTable1Ds climate_solar(
      final tableOnFile=true, final tableName="data",final fileName=filNamClim, final columns = {7,11,14},
      final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
      annotation (Placement(transformation(extent={{-40,46},{-26,60}})));

public
  Modelica.Blocks.Tables.CombiTable1Ds tabQCon(
      final smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableOnFile = true,
      tableName = "data",
      fileName = "..\\Inputs\\" + occupants.filQCon,
      columns=2:nOcc+1) if occBeh annotation (Placement(transformation(extent={{-40,-34},
              {-26,-20}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabQRad(
      final smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableOnFile = true,
      tableName = "data",
      fileName = "..\\Inputs\\" + occupants.filQRad,
      columns=2:nOcc+1) if occBeh annotation (Placement(transformation(extent={{-36,-38},
              {-22,-24}})));
  Modelica.Blocks.Sources.CombiTimeTable
                                       tabPre(
      final smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableOnFile = true,
      tableName = "data",
      fileName = "..\\Inputs\\" + occupants.filPres,
      columns=2:nOcc+1) if occBeh annotation (Placement(transformation(extent={{0,-34},
              {14,-20}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabP(
      final smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableOnFile = true,
      tableName = "data",
      fileName = "..\\Inputs\\" + occupants.filP,
      columns=2:nOcc+1) if occBeh annotation (Placement(transformation(extent={{-40,-58},
              {-26,-44}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabQ(
      final smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableOnFile = true,
      tableName = "data",
      fileName = "..\\Inputs\\" + occupants.filQ,
      columns=2:nOcc+1) if occBeh annotation (Placement(transformation(extent={{-36,-62},
              {-22,-48}})));
  Modelica.Blocks.Sources.CombiTimeTable
                                       tabDHW(
      final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableOnFile=true,
      tableName="data",
      fileName="..\\Inputs\\" + occupants.filDHW,
      columns=2:nOcc+1) if DHW
                              annotation (Placement(transformation(extent={{0,-58},
              {14,-44}})));
  Modelica.Blocks.Tables.CombiTable1Ds tabPPV(
      final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableOnFile=true,
      tableName="data",
      fileName="..\\Inputs\\" + fileNamePv,
      columns=2:nPV + 1) if
                           PV annotation (Placement(transformation(extent={{-36,2},
              {-22,16}})));

  equation
    if not BesTest then
      Tsky = Te - (23.8 - 0.2025 * (Te-273.15)*(1-0.87*Fc));
      Fc = 0.2;
      Va = 2.5;
    else
      Tsky = climate_nonSolar.y[2]+273.15;
      Fc = climate_nonSolar.y[3]*0.87;
      Va = climate_nonSolar.y[4];
    end if;

    connect(timMan.timCalSol, climate_solar.u) annotation (Line(
        points={{-60,62},{-52,62},{-52,53},{-41.4,53}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timMan.timSol, climate_nonSolar.u) annotation (Line(
        points={{-60,70},{-50,70},{-50,73},{-41.4,73}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timMan.timCal, tabQCon.u) annotation (Line(
        points={{-60,66},{-52,66},{-52,-27},{-41.4,-27}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timMan.timCal, tabQRad.u) annotation (Line(
        points={{-60,66},{-50,66},{-50,-31},{-37.4,-31}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timMan.timCal, tabP.u) annotation (Line(
        points={{-60,66},{-52,66},{-52,-51},{-41.4,-51}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timMan.timCal, tabQ.u) annotation (Line(
        points={{-60,66},{-50,66},{-50,-55},{-37.4,-55}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(timMan.timCal, tabPPV.u) annotation (Line(
        points={{-60,66},{-48,66},{-48,9},{-37.4,9}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation(defaultComponentName="sim", defaultComponentPrefixes="inner",  missingInnerMessage="Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation drag IDEAS.SimInfoManager into your model.",
          Icon(graphics={
          Ellipse(
            extent={{-60,78},{74,-58}},
            lineColor={95,95,95},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{18,52},{30,44},{36,44},{36,46},{34,48},{34,56},{22,60},{16,60},
                {10,58},{6,54},{8,52},{2,52},{-8,48},{-14,52},{-24,48},{-26,40},{-18,
                40},{-14,32},{-14,28},{-12,24},{-16,10},{-8,2},{-8,-2},{-6,-6},{-4,
                -4},{0,-6},{2,-12},{10,-18},{18,-24},{22,-30},{26,-36},{32,-44},{34,
                -50},{36,-58},{60,-44},{72,-28},{72,-18},{64,-14},{58,-12},{48,-12},
                {44,-14},{40,-16},{34,-16},{26,-24},{20,-22},{20,-18},{24,-12},{16,
                -16},{8,-12},{8,-8},{10,-2},{16,0},{24,0},{28,-2},{30,-8},{32,-6},
                {28,2},{30,12},{34,18},{36,20},{38,24},{34,26},{36,32},{26,38},{18,
                38},{20,32},{18,28},{12,32},{14,38},{16,42},{24,40},{22,46},{16,50},
                {18,52}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-34,64},{-30,62},{-26,64},{-24,60},{-36,58},{-24,52},{-16,54},
                {-14,62},{-8,68},{6,74},{12,74},{22,70},{28,64},{30,64},{44,62},{46,
                58},{42,56},{50,50},{66,34},{68,20},{74,12},{80,46},{70,78},{44,90},
                {2,90},{-32,80},{-34,64}},
            lineColor={255,255,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Bitmap(extent={{22,-8},{20,-8}},  fileName=""),
          Ellipse(extent={{-60,78},{74,-58}}, lineColor={95,95,95}),
          Polygon(
            points={{-66,-20},{-70,-16},{-72,-20},{-68,-30},{-60,-42},{-60,-40},{-62,
                -32},{-66,-20}},
            lineColor={127,0,0},
            smooth=Smooth.None,
            fillColor={127,67,62},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-62,-4},{-58,0},{-54,-2},{-54,-12},{-52,-20},{-48,-24},{-50,-28},
                {-50,-30},{-54,-28},{-56,-26},{-58,-12},{-62,-4}},
            lineColor={127,0,0},
            smooth=Smooth.None,
            fillColor={127,67,62},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-48,0},{-46,4},{-42,4},{-40,0},{-40,-4},{-38,-16},{-38,-22},{
                -40,-24},{-44,-22},{-44,-16},{-48,0}},
            lineColor={127,0,0},
            smooth=Smooth.None,
            fillColor={127,67,62},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-32,2},{-28,4},{-24,4},{-24,0},{-24,-12},{-24,-20},{-26,-24},
                {-30,-24},{-32,-6},{-32,2}},
            lineColor={127,0,0},
            smooth=Smooth.None,
            fillColor={127,67,62},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-6,-36},{-12,-42},{-8,-42},{-4,-36},{0,-26},{-2,-22},{-6,-22},
                {-8,-26},{-10,-32},{-8,-36},{-6,-36}},
            lineColor={127,0,0},
            smooth=Smooth.None,
            fillColor={127,67,62},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,-44},{-58,-40},{-54,-40},{-50,-36},{-42,-32},{-36,-32},{-32,
                -28},{-26,-28},{-24,-34},{-24,-36},{-26,-38},{-20,-42},{-16,-46},{
                -12,-46},{-8,-48},{-10,-52},{-12,-60},{-16,-66},{-20,-68},{-26,-70},
                {-30,-70},{-34,-70},{-36,-74},{-40,-76},{-42,-76},{-48,-72},{-54,-62},
                {-60,-44}},
            lineColor={127,0,0},
            smooth=Smooth.None,
            fillColor={127,67,62},
            fillPattern=FillPattern.Solid)}),
      Diagram(graphics),
      Documentation(info="<html>
</html>"));
  end SimInfoManager;

  package Climate "Climate data"
    extends Modelica.Icons.Package;

    package Meteo
      extends Modelica.Icons.Package;

      partial model Detail

      parameter String filNam;
      parameter Modelica.SIunits.Time timestep;

      end Detail;

      partial model Location "Geogrphical location"

        parameter Modelica.SIunits.Angle lat(displayUnit="degree")
        "latitude of the locatioin";
        parameter Modelica.SIunits.Angle lon(displayUnit="degree")
        "longitude of the locatioin";
        parameter Modelica.SIunits.Temperature Tdes
        "Design outdoor temperature";
        parameter Modelica.SIunits.Temperature TdesGround
        "Design ground temperature";
        parameter Modelica.SIunits.Time timZonSta "Standard (winter) time zone";
        parameter Boolean DST "Take into account daylight saving time or not";
        parameter Integer yr "Ddepcited year for DST only";
        parameter String locNam;

      end Location;

      package Files
        extends Modelica.Icons.Package;

        model min60 "60-minute data"
          extends IDEAS.Climate.Meteo.Detail(filNam="_60.txt",
              timestep=3600);
        end min60;
      end Files;

      package Locations
        extends Modelica.Icons.Package;

        model Uccle "Uccle, Belgium"
          extends IDEAS.Climate.Meteo.Location(
            lat=50.800/180*Modelica.Constants.pi,
            lon=4.317/180*Modelica.Constants.pi,
            Tdes=265.15,
            TdesGround=284.15,
            timZonSta=3600,
            DST=true,
            yr=2010,
            locNam="climate");
        end Uccle;
      end Locations;

      package Solar
        extends Modelica.Icons.Package;

        package BaseClasses
        "Baseclass elements for solar incidence calculation"
        extends Modelica.Icons.BasesPackage;

          model AngleDay

          Real day;
          Real t;
          Real N "year";

          equation
          N=(time-365*24*60*30)/60/60/24/365;
          t=time-86400*N;
          day=t/60/60/24/365.25*2*Modelica.Constants.pi-0.048869;

          end AngleDay;

          block AngleHour

          extends Modelica.Blocks.Interfaces.BlockIcon;

            outer IDEAS.SimInfoManager sim
              annotation (Placement(transformation(extent={{-92,74},{-72,94}})));

            Modelica.Blocks.Interfaces.RealOutput angHou(
              final quantity="Angle",
              final unit="rad",
              displayUnit="deg") "hour angle"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));

          algorithm
          angHou :=(sim.timSol/3600 - 12)*2*Modelica.Constants.pi/24;

            annotation (Diagram(graphics));
          end AngleHour;

          model AngleSolar "solar angle to surface"

          extends Modelica.Blocks.Interfaces.BlockIcon;

          parameter Modelica.SIunits.Angle inc(displayUnit="degree")
            "inclination";
          parameter Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
          parameter Modelica.SIunits.Angle lat(displayUnit="degree");

        public
            Modelica.Blocks.Interfaces.RealInput angDec(final quantity="Angle", final unit="rad",displayUnit="deg")
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealInput angHou(final quantity="Angle", final unit="rad",displayUnit="deg")
              annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
            Modelica.Blocks.Interfaces.RealOutput angInc(final quantity="Angle", final unit="rad",displayUnit="deg")
            "Incidence angle"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));

        protected
            Real cosDec = Modelica.Math.cos(angDec);
            Real sinDec = Modelica.Math.sin(angDec);
            Real cosHou = Modelica.Math.cos(angHou);
            Real sinHou = Modelica.Math.sin(angHou);
            Real cosLat = Modelica.Math.cos(lat);
            Real sinLat = Modelica.Math.sin(lat);

          equation
            angInc = acos(cos(inc)*(cosDec*cosHou*cosLat + sinDec*sinLat) + sin(inc)*(sin(azi)*cosDec*sinHou + cos(azi)*(cosDec*cosHou*sinLat - sinDec*cosLat)));

            annotation (Icon(graphics={
                  Ellipse(
                    extent={{88,88},{40,42}},
                    lineColor={255,255,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Polygon(
                    points={{-90,-76},{-40,-36},{40,-36},{90,-76},{-90,-76}},
                    lineColor={95,95,95},
                    smooth=Smooth.None),
                  Polygon(
                    points={{16,-42},{22,-68},{-72,0},{-18,-18},{16,-42}},
                    lineColor={0,0,0},
                    smooth=Smooth.None,
                    fillPattern=FillPattern.Solid,
                    fillColor={175,175,175}),
                  Line(
                    points={{-6,-36},{84,40}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Line(
                    points={{-6,-36},{64,68}},
                    color={0,0,0},
                    smooth=Smooth.None)}), Diagram(graphics));
          end AngleSolar;

          model AngleZenith "solar angle to surface"

          extends Modelica.Blocks.Interfaces.BlockIcon;

          parameter Modelica.SIunits.Angle lat(displayUnit="degree");

        public
            Modelica.Blocks.Interfaces.RealInput angDec(quantity="Angle", unit="rad")
            "declination"
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealInput angHou(quantity="Angle", unit="rad")
            "hour angle"
              annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
            Modelica.Blocks.Interfaces.RealOutput angZen(
              final quantity="Angle",
              final unit="rad",
              displayUnit="deg") "Zenith Angle"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));

          equation
          angZen = acos(cos(lat)*cos(angDec)*cos(angHou)+sin(lat)*sin(angDec));

            annotation (Diagram(graphics), Icon(graphics={
                  Polygon(
                    points={{-88,-78},{-38,-38},{42,-38},{92,-78},{-88,-78}},
                    lineColor={95,95,95},
                    smooth=Smooth.None,
                    fillColor={175,175,175},
                    fillPattern=FillPattern.Solid),
                  Ellipse(
                    extent={{90,90},{42,44}},
                    lineColor={255,255,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{66,68},{-2,-56}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Line(
                    points={{-2,-56},{-2,84}},
                    color={0,0,0},
                    smooth=Smooth.None)}));
          end AngleZenith;

          block Declination "solar declination"

          extends Modelica.Blocks.Interfaces.BlockIcon;

            outer IDEAS.SimInfoManager sim
              annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
            Modelica.Blocks.Interfaces.RealOutput delta(final quantity="Angle", final unit="rad",displayUnit="deg")
            "Declination angle"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));
          equation
            delta = asin(-sin(23.45*2*Modelica.Constants.pi/360)*cos((sim.timLoc/86400+10)*2*Modelica.Constants.pi/365.25));

            annotation (Icon(graphics={
                  Ellipse(
                    extent={{-74,74},{78,-72}},
                    lineColor={0,0,0},
                    fillColor={85,170,255},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{0,90},{0,-88}},
                    color={0,0,0},
                    smooth=Smooth.None),
                  Line(
                    points={{-28,-86},{32,88}},
                    color={0,0,0},
                    smooth=Smooth.None)}));
          end Declination;

          model solDifTil

          extends Modelica.Blocks.Interfaces.BlockIcon;

          parameter Modelica.SIunits.Area A;
          parameter Modelica.SIunits.Angle inc(displayUnit="degree")
            "inclination";

          Modelica.Blocks.Interfaces.RealOutput solDifTil
              annotation (Placement(transformation(extent={{90,50},{110,70}})));
          outer IDEAS.SimInfoManager         sim
              annotation (Placement(transformation(extent={{60,72},{80,92}})));

            Modelica.Blocks.Interfaces.RealInput angZen
              annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
            Modelica.Blocks.Interfaces.RealInput angInc
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));

          final parameter Modelica.SIunits.Angle i = inc/180*Modelica.Constants.pi;

            SkyClearness skyClearness
              annotation (Placement(transformation(extent={{-60,10},{-42,28}})));
            RelativeAirMass relativeAirMass
              annotation (Placement(transformation(extent={{-60,-18},{-42,0}})));
            SkyBrightness skyBrightness
              annotation (Placement(transformation(extent={{-34,-18},{-16,0}})));
            SkyBrightnessCoefficients skyBrightnessCoefficients
              annotation (Placement(transformation(extent={{0,22},{18,40}})));
            Perez perez(A=A, inc=inc) annotation (Placement(transformation(extent={{40,44},{60,64}})));

          equation
            connect(angZen, skyClearness.angZen) annotation (Line(
                points={{-100,20},{-70,20},{-70,24},{-66,24},{-60,24.4}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(angZen, relativeAirMass.angZen) annotation (Line(
                points={{-100,20},{-70,20},{-70,-3.6},{-60,-3.6}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(relativeAirMass.relAirMas, skyBrightness.relAirMas) annotation (
                Line(
                points={{-42,-3.6},{-40,-3.6},{-40,-3.6},{-38,-3.6},{-38,-3.6},{-34,-3.6}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(angZen, skyBrightnessCoefficients.angZen) annotation (Line(
                points={{-100,20},{-70,20},{-70,36.4},{0,36.4}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(skyClearness.skyCle, skyBrightnessCoefficients.skyCle) annotation (
                Line(
                points={{-42,24.4},{-22,24.4},{-22,32.8},{0,32.8}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(skyBrightness.skyBri, skyBrightnessCoefficients.skyBri) annotation (
               Line(
                points={{-16,-3.6},{-8,-3.6},{-8,29.2},{0,29.2}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(skyBrightnessCoefficients.F1, perez.F1) annotation (Line(
                points={{18,36.4},{22,36},{26,36},{26,52},{40,52}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(skyBrightnessCoefficients.F2, perez.F2) annotation (Line(
                points={{18,32.8},{30,32.8},{30,48},{40,48}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(angZen, perez.angZen) annotation (Line(
                points={{-100,20},{-70,20},{-70,56},{40,56}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(angInc, perez.angInc) annotation (Line(
                points={{-100,60},{40,60}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(perez.solDifTil, solDifTil) annotation (Line(
                points={{60,60},{100,60}},
                color={0,0,127},
                smooth=Smooth.None));
            annotation (Diagram(graphics));
          end solDifTil;

          model solDirTil

          extends Modelica.Blocks.Interfaces.BlockIcon;

          parameter Modelica.SIunits.Area A;
          parameter Modelica.SIunits.Angle inc(displayUnit="degree")
            "inclination";

            Modelica.Blocks.Interfaces.RealInput angSol
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealOutput solDirTil
              annotation (Placement(transformation(extent={{90,50},{110,70}})));
            outer IDEAS.SimInfoManager sim
              annotation (Placement(transformation(extent={{-60,60},{-40,80}})));

          algorithm
            if inc <= Modelica.Constants.small then
              solDirTil := IDEAS.BaseClasses.Math.MaxSmooth(
                0,
                A*sim.solDirHor,
                delta=0.01);
            else
              solDirTil := IDEAS.BaseClasses.Math.MaxSmooth(
                0,
                cos(angSol)*sim.solDirPer*A,
                delta=0.01);
            end if;
          end solDirTil;

          model solradExtraTerra

          extends Modelica.Blocks.Interfaces.BlockIcon;

          IDEAS.Climate.Meteo.Solar.BaseClasses.AngleDay angleDay;

            Modelica.Blocks.Interfaces.RealOutput sol
              annotation (Placement(transformation(extent={{90,50},{110,70}})));
          algorithm
          sol := 1366.1*(1+0.0033412*cos(angleDay.day));

            annotation (Icon(graphics));
          end solradExtraTerra;

          block RelativeAirMass
            extends Modelica.Blocks.Interfaces.BlockIcon;

            Modelica.Blocks.Interfaces.RealInput angZen(
              quantity="Angle",
              unit="rad",
              displayUnit="degreeC") "zenith angle"
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealOutput relAirMas "relative air mass"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));

        protected
          Real angZenLim "limited zenith angle";
          Real angZenDeg "limited zenith angle in degrees";

          algorithm
            angZenLim := IDEAS.BaseClasses.Math.MinSmooth(
              angZen,
              Modelica.Constants.pi/2,
              0.01);
          angZenDeg := Modelica.SIunits.Conversions.to_deg(angZenLim);
          relAirMas := 1/(cos(angZenLim) + 0.50572*(96.07995-angZenDeg)^(-1.6364));

          end RelativeAirMass;

          block SkyClearness
            extends Modelica.Blocks.Interfaces.BlockIcon;
            Modelica.Blocks.Interfaces.RealInput angZen(
              quantity="Angle",
              unit="rad",
              displayUnit="degreeC") "zenith angle"
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealOutput skyCle "sky clearness"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));
            outer IDEAS.SimInfoManager         sim
              annotation (Placement(transformation(extent={{-80,72},{-60,92}})));

        protected
          final parameter Real kappa = 1.041
            "original kappa of 1.014 but for degrees";
          Real solDifHor "smoothed horizontal difuse radiation";

          algorithm
            solDifHor := IDEAS.BaseClasses.Math.MaxSmooth(
              sim.solDifHor,
              1e-4,
              1e-5);
          skyCle := smooth(1, if noEvent(sim.solGloHor < 1) then 1 else ((sim.solGloHor)/solDifHor + kappa*angZen^3) / (1 + kappa*angZen^3));

              annotation (Diagram(graphics));
          end SkyClearness;

          block SkyBrightness
            extends Modelica.Blocks.Interfaces.BlockIcon;
            outer IDEAS.SimInfoManager         sim
              annotation (Placement(transformation(extent={{-80,72},{-60,92}})));
            Modelica.Blocks.Interfaces.RealInput relAirMas "relative air mass"
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealOutput skyBri "sky brightness"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));

          algorithm
            skyBri := IDEAS.BaseClasses.Math.MinSmooth(
              sim.solDifHor*relAirMas/1367,
              1,
              0.025);

            annotation (Diagram(graphics));
          end SkyBrightness;

          block SkyBrightnessCoefficients
            extends Modelica.Blocks.Interfaces.BlockIcon;
            Modelica.Blocks.Interfaces.RealInput skyCle
              annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
            Modelica.Blocks.Interfaces.RealInput angZen
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealInput skyBri
              annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
            Modelica.Blocks.Interfaces.RealOutput F1
            "circumsolar brightening coefficient"
              annotation (Placement(transformation(extent={{90,50},{110,70}})));

            Modelica.Blocks.Interfaces.RealOutput F2
            "horizon brightening coefficient"
              annotation (Placement(transformation(extent={{90,10},{110,30}})));

        protected
            Real F11;
            Real F12;
            Real F13;
            Real F21;
            Real F22;
            Real F23;
            final parameter Real d = 0.01;
            Real[8] a;
            Real[8] b;

          algorithm
            //first we define the discrete sky clearness categories a[:]
            b[1] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,1.065 - skyCle,d);
            b[2] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,1.23 - skyCle,d);
            b[3] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,1.50 - skyCle,d);
            b[4] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,1.95 - skyCle,d);
            b[5] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,2.8 - skyCle,d);
            b[6] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,4.5 - skyCle,d);
            b[7] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,6.2 - skyCle,d);
            b[8] := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(1,0,skyCle - 6.2,d);
            a[1] := b[1];
            a[1] := b[2] - b[1];
            a[2] := b[3] - b[2];
            a[3] := b[4] - b[3];
            a[4] := b[5] - b[4];
            a[5] := b[6] - b[5];
            a[6] := b[7] - b[6];
            a[7] := b[8];

            F11 := -0.008*a[1] + 0.130*a[2] + 0.330*a[3] + 0.568*a[4] + 0.873*a[5] + 1.132*a[6] + 1.060*a[7] + 0.678*a[8];
            F12 := 0.588*a[1] + 0.683*a[2] + 0.487*a[3] + 0.187*a[4] - 0.392*a[5] - 1.237*a[6] - 1.600*a[7] - 0.327*a[8];
            F13 := -0.062*a[1] - 0.151*a[2] - 0.221*a[3] - 0.295*a[4] - 0.362*a[5] - 0.412*a[6] - 0.359*a[7] - 0.250*a[8];
            F21 := -0.060*a[1] - 0.019*a[2] + 0.055*a[3] + 0.109*a[4] + 0.226*a[5] + 0.288*a[6] + 0.264*a[7] + 0.156*a[8];
            F22 := 0.072*a[1] + 0.066*a[2] - 0.064*a[3] - 0.152*a[4] - 0.462*a[5] - 0.823*a[6] - 1.127*a[7] - 1.377*a[8];
            F23 := -0.022*a[1] - 0.029*a[2] - 0.026*a[3] - 0.014*a[4] + 0.001*a[5] + 0.056*a[6] + 0.131*a[7] + 0.251*a[8];
            F1 := IDEAS.BaseClasses.Math.MaxSmooth(
              0,
              F11 + F12*skyBri + F13*angZen,
              0.01);
            F2 := F21 + F22*skyBri + F23*angZen;

            annotation (Diagram(graphics));
          end SkyBrightnessCoefficients;

          block Perez
            extends Modelica.Blocks.Interfaces.BlockIcon;
            outer IDEAS.SimInfoManager         sim
              annotation (Placement(transformation(extent={{-68,72},{-48,92}})));
            parameter Real rho = 0.2 "Ground reflectance";
            parameter Modelica.SIunits.Angle inc(displayUnit="degree")
            "surface inclination";
            parameter Modelica.SIunits.Area A "surface area";

            Modelica.Blocks.Interfaces.RealInput F1
            "Circomsolar brightening coefficient"
              annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
            Modelica.Blocks.Interfaces.RealInput F2
            "horizon brightening coefficient"
              annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
            Modelica.Blocks.Interfaces.RealInput angZen(quantity="Angle", unit="rad", displayUnit="degree")
            "zenith angle"
              annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
            Modelica.Blocks.Interfaces.RealInput angInc(quantity="Angle", unit="rad", displayUnit="degree")
            "incedence angle"
              annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
            Modelica.Blocks.Interfaces.RealOutput solDifTil
              annotation (Placement(transformation(extent={{90,50},{110,70}})));

        protected
            Real a;
            Real b;

          algorithm
            a := IDEAS.BaseClasses.Math.MaxSmooth(
              0,
              cos(angInc),
              0.01);
            b := IDEAS.BaseClasses.Math.MaxSmooth(
              0.087,
              cos(angZen),
              0.01);

            if inc <= Modelica.Constants.small then
              solDifTil := A * sim.solDifHor;
            else
              solDifTil := A * sim.solDifHor * (0.5*(1-F1)*(1+cos(inc)) + F1*a/b + F2*sin(inc)) + A * sim.solGloHor * 0.5 * rho * (1-cos(inc));
            end if;
          end Perez;
        end BaseClasses;

        model RadSol "solar angle to surface"

        extends Modelica.Blocks.Interfaces.BlockIcon;

        parameter Modelica.SIunits.Angle inc(displayUnit="degree")
          "inclination";
        parameter Modelica.SIunits.Angle azi(displayUnit="degree") "azimuth";
        parameter Modelica.SIunits.Angle lat(displayUnit="degree") = sim.city.lat
          "latitude";
        parameter Modelica.SIunits.Area A;

          outer IDEAS.SimInfoManager sim
            annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

          BaseClasses.Declination
                               declination
            annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
          BaseClasses.AngleHour
                             angleHour
            annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
          BaseClasses.AngleSolar
                              angSolar(inc=inc, azi=azi,lat=lat)
            annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
          BaseClasses.solDirTil
                             solDirTil(A=A,inc=inc)
            annotation (Placement(transformation(extent={{0,20},{20,40}})));
          BaseClasses.solDifTil
                             solDifTil(A=A,inc=inc)
            annotation (Placement(transformation(extent={{0,-2},{20,18}})));
          BaseClasses.solradExtraTerra
                                    extraTerra
            annotation (Placement(transformation(extent={{-80,-24},{-60,-4}})));
          Modelica.Blocks.Interfaces.RealOutput solDir
            annotation (Placement(transformation(extent={{90,50},{110,70}})));
          Modelica.Blocks.Interfaces.RealOutput solDif
            annotation (Placement(transformation(extent={{90,10},{110,30}})));
          BaseClasses.AngleZenith
                               angleZenith(lat=lat)
            annotation (Placement(transformation(extent={{-40,-2},{-20,18}})));
          Modelica.Blocks.Interfaces.RealOutput angInc "Angle of incidence"
            annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
          Modelica.Blocks.Interfaces.RealOutput angZen "Angle of incidence"
            annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
          Modelica.Blocks.Interfaces.RealOutput angHou "Angle of incidence"
            annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
        equation
          connect(declination.delta, angSolar.angDec) annotation (Line(
              points={{-60,36},{-40,36}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angleHour.angHou, angSolar.angHou) annotation (Line(
              points={{-60,14},{-48,14},{-48,32},{-40,32}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(solDirTil.solDirTil, solDir) annotation (Line(
              points={{20,36},{56,36},{56,60},{100,60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(solDifTil.solDifTil, solDif) annotation (Line(
              points={{20,14},{56,14},{56,20},{100,20}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(declination.delta, angleZenith.angDec) annotation (Line(
              points={{-60,36},{-50,36},{-50,14},{-40,14}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angleHour.angHou, angleZenith.angHou) annotation (Line(
              points={{-60,14},{-50,14},{-50,10},{-40,10}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angleZenith.angZen, solDifTil.angZen) annotation (Line(
              points={{-20,14},{-6,14},{-6,10},{0,10}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angSolar.angInc, solDifTil.angInc) annotation (Line(
              points={{-20,36},{-4,36},{-4,14},{0,14}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angSolar.angInc, solDirTil.angSol) annotation (Line(
              points={{-20,36},{0,36}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angSolar.angInc, angInc) annotation (Line(
              points={{-20,36},{-10,36},{-10,-40},{100,-40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angleHour.angHou, angHou) annotation (Line(
              points={{-60,14},{-50,14},{-50,-80},{100,-80}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(angleZenith.angZen, angZen) annotation (Line(
              points={{-20,14},{-14,14},{-14,-60},{100,-60}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Diagram(graphics), Icon(graphics={
                Polygon(
                  points={{-90,-80},{-40,-40},{40,-40},{90,-80},{-90,-80}},
                  lineColor={95,95,95},
                  smooth=Smooth.None),
                Polygon(
                  points={{16,-46},{22,-72},{-72,-4},{-18,-22},{16,-46}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Solid,
                  fillColor={175,175,175}),
                Ellipse(
                  extent={{88,84},{40,38}},
                  lineColor={255,255,0},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid)}));
        end RadSol;
      end Solar;
    end Meteo;

    package Time
      extends Modelica.Icons.Package;

      package BaseClasses
        extends Modelica.Icons.BasesPackage;

        model CalendarTime

        extends Modelica.Blocks.Interfaces.BlockIcon;

        parameter Boolean ifSolCor;

          Modelica.Blocks.Interfaces.RealInput timSim
            annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
          Modelica.Blocks.Interfaces.RealInput delay
            annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
          Modelica.Blocks.Interfaces.RealOutput timCal
            annotation (Placement(transformation(extent={{90,30},{110,50}})));
          Modelica.Blocks.Interfaces.RealOutput timCalSol
            annotation (Placement(transformation(extent={{90,-50},{110,-30}})));

        equation
          timCal = timSim;// - integer(timSim/31536000)*31536000;

        if ifSolCor then
          timCalSol = timSim + delay;
        else
          timCalSol = timSim;
        end if;

          annotation (Diagram(graphics));
        end CalendarTime;

        model LocalTime

        extends Modelica.Blocks.Interfaces.BlockIcon;

        parameter Modelica.SIunits.Angle lon(displayUnit="deg") "longitude";

          Modelica.Blocks.Interfaces.RealInput timZon "time zone"
            annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
          Modelica.Blocks.Interfaces.RealInput timSim "simulation time"
            annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
          Modelica.Blocks.Interfaces.RealOutput timLoc "local time"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));

        equation
          timLoc = timSim - timZon + lon * 43200 / Modelica.Constants.pi;

          annotation (Diagram(graphics));
        end LocalTime;

        model SimulationDelay

        extends Modelica.Blocks.Interfaces.BlockIcon;

        parameter Modelica.SIunits.Time delay;

          Modelica.Blocks.Interfaces.RealOutput timSim
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));

        equation
          timSim = delay;

          annotation (Diagram(graphics));
        end SimulationDelay;

        model SimulationTime

        extends Modelica.Blocks.Interfaces.BlockIcon;

          Modelica.Blocks.Interfaces.RealOutput timSim
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));

        equation
          timSim = rem(time,31536000);

          annotation (Diagram(graphics));
        end SimulationTime;

        model SolarTime

        extends Modelica.Blocks.Interfaces.BlockIcon;

          Modelica.Blocks.Interfaces.RealInput timLoc(quantity="Time", unit="s")
            annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
          Modelica.Blocks.Interfaces.RealInput timSim(quantity="Time", unit="s")
            annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
          Modelica.Blocks.Interfaces.RealOutput timSol(quantity="Time", unit="s")
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));

      protected
          Modelica.SIunits.Angle Bt;
          Modelica.SIunits.Time delta "difference of solar time to local time";
          Modelica.SIunits.Time nDay "Zero-based day number in seconds";

        algorithm
          nDay := timSim;
          Bt := Modelica.Constants.pi*((nDay + 86400)/86400 - 81)/182;
          delta := 60*(9.87*sin(2*Bt) - 7.53*cos(Bt) - 1.5*sin(Bt));
          timSol := timLoc + delta;

          annotation (Diagram(graphics));
        end SolarTime;

        block TimeZone

        extends Modelica.Blocks.Interfaces.BlockIcon;

        parameter Modelica.SIunits.Time timZonSta "standard time zone";
        parameter Boolean DST = true;
        parameter Integer yr "depcited year";

          Modelica.Blocks.Interfaces.RealInput timCal "time zone"
            annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
          Modelica.Blocks.Interfaces.RealOutput timZon "calendar time"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));

          parameter Modelica.SIunits.Time DSTstart = 86400*(31+28+31-rem(5*yr/4+4,7))+2*3600;
          parameter Modelica.SIunits.Time DSTend = 86400*(31+28+31+30+31+30+31+31+30+31-rem(5*yr/4+1,7))+2*3600;
          // Source : http://www.webexhibits.org/daylightsaving/i.html

          Modelica.Blocks.Interfaces.BooleanOutput summer annotation (Placement(
                transformation(
                extent={{10,-10},{-10,10}},
                rotation=-90,
                origin={0,100})));

        equation
          if timCal >= DSTstart and timCal <= DSTend then
            if DST then
              timZon = timZonSta + 3600;
              summer = true;
            else
              timZon = timZonSta;
              summer = false;
            end if;
          else
            timZon = timZonSta;
            summer = false;
          end if;

        end TimeZone;
      end BaseClasses;

      block SimTimes

      extends Modelica.Blocks.Interfaces.BlockIcon;

      parameter Modelica.SIunits.Angle lon(displayUnit="deg") = 4.317
        "longitude";
      parameter Modelica.SIunits.Time delay(displayUnit="s") = 0
        "delay for solar data";
      parameter Modelica.SIunits.Time timZonSta = 3600 "standard time zone";
      parameter Boolean DST = false "take into account daylight saving time";
      parameter Integer yr = 2010 "depcited year for DST only";
      parameter Boolean ifSolCor = true;

        Modelica.Blocks.Interfaces.RealOutput timSol "solar time"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealOutput timCal "calendar time"
          annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
        Modelica.Blocks.Interfaces.RealOutput timCalSol
        "calendar time for solar data"
          annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
        Modelica.Blocks.Interfaces.RealOutput timLoc
          annotation (Placement(transformation(extent={{90,30},{110,50}})));
        Modelica.Blocks.Interfaces.BooleanOutput summer
          annotation (Placement(transformation(extent={{90,70},{110,90}})));

    protected
        IDEAS.Climate.Time.BaseClasses.LocalTime
                           localTime(lon=lon)
          annotation (Placement(transformation(extent={{-10,-6},{10,14}})));
        IDEAS.Climate.Time.BaseClasses.SolarTime
                           solarTime
          annotation (Placement(transformation(extent={{30,-10},{50,10}})));
        IDEAS.Climate.Time.BaseClasses.CalendarTime
                              calendarTime(ifSolCor=ifSolCor)
          annotation (Placement(transformation(extent={{30,-54},{50,-34}})));
        IDEAS.Climate.Time.BaseClasses.SimulationTime
                                simulationTime
          annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
        IDEAS.Climate.Time.BaseClasses.SimulationDelay
                                 simulationDelay(delay=delay)
          annotation (Placement(transformation(extent={{-90,-58},{-70,-38}})));
        IDEAS.Climate.Time.BaseClasses.TimeZone
                          timeZone(timZonSta=timZonSta, DST=DST, yr=yr)
          annotation (Placement(transformation(extent={{-50,-6},{-30,14}})));

      equation
        connect(localTime.timLoc, solarTime.timLoc) annotation (Line(
            points={{10,4},{30,4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(solarTime.timSol, timSol) annotation (Line(
            points={{50,0},{100,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(calendarTime.timCal, timCal) annotation (Line(
            points={{50,-40},{100,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(calendarTime.timCalSol, timCalSol) annotation (Line(
            points={{50,-48},{60,-48},{60,-80},{100,-80}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(simulationDelay.timSim, calendarTime.delay) annotation (Line(
            points={{-70,-48},{30,-48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(simulationTime.timSim, calendarTime.timSim) annotation (Line(
            points={{-70,-20},{-22,-20},{-22,-40},{30,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(simulationTime.timSim, localTime.timSim) annotation (Line(
            points={{-70,-20},{-22,-20},{-22,0},{-10,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(simulationTime.timSim, solarTime.timSim) annotation (Line(
            points={{-70,-20},{20,-20},{20,-4},{30,-4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(timeZone.timZon, localTime.timZon) annotation (Line(
            points={{-30,4},{-22,4},{-22,8},{-10,8}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(calendarTime.timCal, timeZone.timCal) annotation (Line(
            points={{50,-40},{60,-40},{60,-26},{-56,-26},{-56,4},{-50,4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(localTime.timLoc, timLoc) annotation (Line(
            points={{10,4},{20,4},{20,40},{100,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(timeZone.summer, summer) annotation (Line(
            points={{-40,14},{-40,80},{100,80}},
            color={255,0,255},
            smooth=Smooth.None));
        annotation (
          defaultComponentName="timMan",
          Documentation(info="<html>
<p>
This component defines all required types of time in the simulation.
</p>
</html>
",       revisions="<html>
<ul>
<li>
April 6, 2011, by Ruben Baetens:<br>
First implementation.
</li>
</ul>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=true,extent={{-100,-100},{100,100}}),
                          graphics),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                          graphics={Text(
                extent={{-78,48},{74,-42}},
                lineColor={0,0,0},
                textString="time")}));
      end SimTimes;
    end Time;
  end Climate;

  package Buildings "Transient building models and model components"
    extends Modelica.Icons.Package;

    package Components
    "Building components for high-order building models or component analysis"
    extends Modelica.Icons.Package;

      model OuterWall "Opaque building envelope construction"

        extends IDEAS.Buildings.Components.Interfaces.StateWall;

        replaceable parameter Data.Constructions.CavityWall constructionType
                                          constrainedby
        Data.Interfaces.Construction(
            final insulationType = insulationType, final insulationTickness = insulationThickness)
        "Type of building construction"   annotation (__Dymola_choicesAllMatching = true,
          Placement(transformation(extent={{-38,72},{-34,76}})),
          Dialog(group="Construction details"));

        replaceable parameter Data.Insulation.Rockwool insulationType constrainedby
        Data.Interfaces.Insulation(  final d= insulationThickness)
        "Type of thermal insulation"   annotation (__Dymola_choicesAllMatching = true,
          Placement(transformation(extent={{-38,84},{-34,88}})),
          Dialog(group="Construction details"));
        parameter Modelica.SIunits.Length insulationThickness = 0.05
        "Thermal insulation thickness"
          annotation (Dialog(group="Construction details"));
        parameter Modelica.SIunits.Area AWall "Total wall area";
        parameter Modelica.SIunits.Angle inc
        "Inclination of the wall, i.e. 90deg denotes vertical";
        parameter Modelica.SIunits.Angle azi
        "Azimuth of the wall, i.e. 0deg denotes South";

        final parameter Real U_value=1/(1/8 + sum(constructionType.mats.R) + 1/25)
        "Wall U-value";
        final parameter Modelica.SIunits.Power QNom=U_value*AWall*(273.15 + 21 - sim.city.Tdes)
        "Design heat losses at reference outdoor temperature";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_emb
        "port for gains by embedded active layers"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

        //protected
        IDEAS.Climate.Meteo.Solar.RadSol radSol(
          final inc=inc,
          final azi=azi,
          final A=AWall)
        "determination of incident solar radiation on wall based on inclination and azimuth"
          annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
        IDEAS.Buildings.Components.BaseClasses.MultiLayerOpaque layMul(
          final A=AWall,
          final inc=inc,
          final nLay = constructionType.nLay,
          final mats = constructionType.mats,
          final locGain = constructionType.locGain)
        "declaration of array of resistances and capacitances for wall simulation"
          annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
        IDEAS.Buildings.Components.BaseClasses.ExteriorConvection extCon(final A=AWall)
        "convective surface heat transimission on the exterior side of the wall"
          annotation (Placement(transformation(extent={{-20,-60},{-40,-40}})));
        IDEAS.Buildings.Components.BaseClasses.InteriorConvection intCon(final A=AWall, final inc=
             inc)
        "convective surface heat transimission on the interior side of the wall"
          annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
        IDEAS.Buildings.Components.BaseClasses.ExteriorSolarAbsorption solAbs(final A=AWall)
        "determination of absorbed solar radiation by wall based on incident radiation"
          annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
        IDEAS.Buildings.Components.BaseClasses.ExteriorHeatRadidation extRad(final A=AWall,
            inc=inc)
        "determination of radiant heat exchange with the environment and sky"
          annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));

      equation
        connect(radSol.solDir, solAbs.solDir) annotation (Line(
            points={{-50,-24},{-40,-24}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(radSol.solDif, solAbs.solDif) annotation (Line(
            points={{-50,-28},{-40,-28}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(extCon.port_a, layMul.port_a) annotation (Line(
            points={{-20,-50},{-16,-50},{-16,-30},{-10,-30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(solAbs.port_a, layMul.port_a) annotation (Line(
            points={{-20,-30},{-10,-30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(extRad.port_a, layMul.port_a) annotation (Line(
            points={{-20,-10},{-16,-10},{-16,-30},{-10,-30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(layMul.port_b, intCon.port_a) annotation (Line(
            points={{10,-30},{20,-30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(layMul.iEpsSw_a, solAbs.epsSw) annotation (Line(
            points={{-10,-26},{-14,-26},{-14,-24},{-20,-24}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(layMul.iEpsLw_a, extRad.epsLw) annotation (Line(
            points={{-10,-22},{-14,-22},{-14,-4},{-20,-4}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(port_emb, layMul.port_gain) annotation (Line(
            points={{0,-100},{0,-40}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(intCon.port_b, surfCon_a) annotation (Line(
            points={{40,-30},{50,-30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(layMul.port_b, surfRad_a) annotation (Line(
            points={{10,-30},{16,-30},{16,-60},{50,-60}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(layMul.iEpsLw_b, iEpsLw_a) annotation (Line(
            points={{10,-22},{14,-22},{14,30},{56,30}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(layMul.iEpsSw_b, iEpsSw_a) annotation (Line(
            points={{10,-26},{16,-26},{16,0},{56,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(layMul.area, area_a) annotation (Line(
            points={{0,-20},{0,60},{56,60}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}}),
              graphics={
              Polygon(
                points={{-50,60},{-30,60},{-30,80},{50,80},{50,100},{-50,100},{-50,60}},
                pattern=LinePattern.None,
                lineThickness=0.5,
                smooth=Smooth.None,
                fillColor={175,175,175},
                fillPattern=FillPattern.Backward),
              Rectangle(
                extent={{-30,-70},{-50,-20}},
                lineThickness=0.5,
                fillColor={175,175,175},
                fillPattern=FillPattern.Backward,
                pattern=LinePattern.None),
              Line(
                points={{-50,60},{-50,66},{-50,100},{50,100}},
                color={175,175,175},
                smooth=Smooth.None),
              Line(
                points={{-50,60},{-30,60},{-30,80},{50,80}},
                color={175,175,175},
                smooth=Smooth.None),
              Line(
                points={{-50,-20},{-30,-20},{-30,-70},{-30,-70},{52,-70}},
                color={175,175,175},
                smooth=Smooth.None),
              Line(
                points={{-50,-20},{-50,-90},{50,-90}},
                color={175,175,175},
                smooth=Smooth.None),
              Line(
                points={{-44,60},{-30,60},{-30,80},{-28,80},{50,80}},
                pattern=LinePattern.None,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{-44,-20},{-30,-20},{-30,-70}},
                pattern=LinePattern.None,
                thickness=0.5,
                smooth=Smooth.None),
              Line(
                points={{-44,60},{-44,-20}},
                smooth=Smooth.None,
                color={175,175,175})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics),
          Documentation(info="<html>
<p><h4><font color=\"#008000\">General description</font></h4></p>
<p><h5>Goal</h5></p>
<p>The <code>OuterWall.mo</code> model describes the transient behaviour of opaque builiding enelope constructions. The description of the thermal response of a wall is structured as in the 3 different occurring processes, i.e. the heat balance of the exterior surface, heat conduction between both surfaces and the heat balance of the interior surface.</p>
<p><h5>Description</h5></p>
<p>For the purpose of dynamic building simulation, the partial differential equation of the continuous time and space model of heat transport through a solid is most often simplified into ordinary differential equations with a finite number of parameters representing only one-dimensional heat transport through a construction layer. Within this context, the wall is modeled with lumped elements, i.e. a model where temperatures and heat fluxes are determined from a system composed of a sequence of discrete resistances and capacitances R_{n+1}, C_{n}. The number of capacitive elements $n$ used in modeling the transient thermal response of the wall denotes the order of the lumped capacitance model.</p>
<p>The heat balance of the exterior surface is determined as Q_{net} = Q_{c} + Q_{SW} + Q_{LW,e} + Q_{LW,sky} where Q_{net} denotes the heat flow into the wall, Q_{c} denotes heat transfer by convection, Q_{SW} denotes short-wave absorption of direct and diffuse solar light, Q_{LW,e} denotes long-wave heat exchange with the environment and Q_{nLW,sky} denotes long-wave heat exchange with the sky. The exterior convective heat flow is computed as Q_{c} = 5,01.A.v_{10}^{0.85}.(T_{db}-T{s}) where A is the surface area, T_{db} is the dry-bulb exterior air temperature, T_{s} is the surface temperature and v_{10} is the wind speed in the undisturbed flow at 10 meter above the ground and where the stated correlation is valid for a v_{10} range of [0.15,7.5] meter per second <a href=\"IDEAS.Buildings.UsersGuide.References\">[Defraeye 2011]</a>. The v_{10}-dependent term denoting the exterior convective heat transfer coefficient h_{ce} is determined as max(f(v_{10}), 5.6) in order to take into account buoyancy effects at low wind speeds <a href=\"IDEAS.Buildings.UsersGuide.References\">[Jurges 1924]</a>. Longwave radiation between the surface and environment Q_{LW,e} is determined as Q_{LW,e} = sigma.e.A.( T_{s}^4 - F_{sky}.T_{sky}^4 - (1-F_{sky})T_{db}^4 ) as derived from the Stefan-Boltzmann law wherefore sigma the Stefan-Boltzmann constant <a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a>, e the longwave emissivity of the exterior surface, F_{sky} the radiant-interchange configuration factor between the surface and sky <a href=\"IDEAS.Buildings.UsersGuide.References\">[Hamilton 1952]</a>, and the surface and the environment respectively and T_{s} and T_{sky} are the exterior surface and sky temperature respectively. Shortwave solar irradiation absorbed by the exterior surface is determined as Q_{SW} = e_{SW}.A.E_{SW} where e_{SW} is the shortwave absorption of the surface and E_{SW} the total irradiation on the depicted surface. </p>
<p>The heat balance of the interior surface is determined as Q_{net} = Q_{c} + Sum(Q_{SW,i}) + Sum(Q_{LW,i}) where Q_{net} denotes the heat flow into the wall, Q_{c} denotes heat transfer by convection, Q_{SW,i} denotes short-wave absorption of direct and diffuse solar light netering the interior zone through windows and Q_{LW,i} denotes long-wave heat exchange with the surounding interior surfaces. </p>
<p>The surface heat resistances <img src=\"modelica://IDEAS/Images/equations/equation-mp9YB9Y0.png\" alt=\"R_s\"/> for the exterior and interior surface respectively are determined as 1/R_{s} = A.h_{c} where A is the surface area and where h_ {c} is the exterior and interior convective heat transfer coefficient. The interior natural convective heat transfer coefficient h_{c,i} <img src=\"modelica://IDEAS/Images/equations/equation-eZGZlJrg.png\" alt=\"h_ci\"/> is computed for each interior surface as h_{c,i} = n1.D^{n2}.(T_{a}-T_{s})^{n3} where D is the characteristic length of the surface, T_{a} is the indoor air temperature and n are correlation coefficients. These parameters {n1, n2, n3} are identical to {1.823,-0.121,0.293} for vertical surfaces <a href=\"IDEAS.Buildings.UsersGuide.References\">[Khalifa 2001]</a>, {2.175,-0.076,0.308} for horizontal surfaces wherefore the heat flux is in the same direction as the buoyancy force <a href=\"IDEAS.Buildings.UsersGuide.References\">[Khalifa 2001]</a>, and {2.72,-,0.13} for horizontal surfaces wherefore the heat flux is in the opposite direction as the buoyancy force <a href=\"IDEAS.Buildings.UsersGuide.References\">[Awbi 1999]</a>. The interior natural convective heat transfer coefficient is only described as function of the temperature difference. </p>
<p>Similar to the thermal model for heat transfer through a wall, a thermal circuit formulation for the direct radiant exchange between surfaces can be derived <a href=\"IDEAS.Buildings.UsersGuide.References\">[Buchberg 1955, Oppenheim 1956]</a>. The resulting heat exchange by longwave radiation between two surface s_{i} and s_{j} can be described as Q_{si,sj} = sigma.A_{si}.(T_{si}^{4}-T_{sj}^{4})/((1-e_{si})/e_{si} + 1/F_{si,sj} + A_{si}/sum(A_{si}) ) as derived from the Stefan-Boltzmann law wherefore e_{si} and e_{sj} are the emissivity of surfaces s_{i} and s_{j} respectively, F_{si,sj} is radiant-interchange configuration factor <a href=\"IDEAS.Buildings.UsersGuide.References\">[Hamilton 1952]</a> between surfaces s_{i} and s_{j} , A_{i} and A_{j} are the areas of surfaces s_{i} and s_{j} respectively, sigma is the Stefan-Boltzmann constant <a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a> and R_{i} and T_{j} are the surface temperature of surfaces s_{i} and s_{j} respectively. The above description of longwave radiation for a room or thermal zone results in the necessity of a very detailed input, i.e. the configuration between all surfaces needs to be described by their shape, position and orientation in order to define F_{si,sj}, and difficulties to introduce windows and internal gains in the zone of interest. Simplification is achieved by means of a delta-star transformation <a href=\"IDEAS.Buildings.UsersGuide.References\">[Kenelly 1899]</a> and by definition of a (fictive) radiant star node in the zone model. Literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption. The heat exchange by longwave radiation between surface <img src=\"modelica://IDEAS/Images/equations/equation-Mjd7rCtc.png\" alt=\"s_i\"/> and the radiant star node in the zone model can be described as Q_{si,sj} = sigma.A_{si}.(T_{si}^{4}-T_{sr}^{4})/((1-e_{si})/e_{si} + A_{si}/sum(A_{si}) ) = sigma where e_{si} is the emissivity of surface s_{i}, A_{si} is the area of surface s_{i}, sum(A_{si}) is the sum of areas for all surfaces s_{i} of the thermal zone, sigma is the Stefan-Boltzmann constant <a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a> and T_{si} and T_{sr} are the temperatures of surfaces <img src=\"modelica://IDEAS/Images/equations/equation-olgnuMEg.png\" alt=\"s_i\"/> and the radiant star node respectively. Absorption of shortwave solar radiation on the interior surface is handled equally as for the outside surface. Determination of the receiving solar radiation on the interior surface after passing through windows is dealt with in the zone model.</p>
<p><h4><font color=\"#008000\">Validation </font></h4></p>
<p>By means of the <code>BESTEST.mo</code> examples in the <code>Validation.mo</code> package.</p>
</html>"));
      end OuterWall;

      package Interfaces "Building component interfaces"
      extends Modelica.Icons.InterfacesPackage;

        partial model StateWall
        "Partial model for building envelope components"

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surfCon_a
          "Convective surface node"
            annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b surfRad_a
          "Radiative surface node"
            annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
          Modelica.Blocks.Interfaces.RealOutput iEpsLw_a
          "Longwave emissivity for radiative heat losses"
            annotation (Placement(transformation(extent={{46,20},{66,40}})));
          Modelica.Blocks.Interfaces.RealOutput iEpsSw_a
          "Shortwave emissivity for solar gain distribution"
            annotation (Placement(transformation(extent={{46,-10},{66,10}})));
          Modelica.Blocks.Interfaces.RealOutput area_a
          "Total interior surface area of the wall"   annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={56,60})));
          inner outer IDEAS.SimInfoManager sim
          "Simulation information manager for climate data"
            annotation (Placement(transformation(extent={{30,-100},{50,-80}})));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                    100}}), graphics),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-50,-100},{50,100}}),
                graphics));

        end StateWall;
      end Interfaces;

      package BaseClasses
      extends Modelica.Icons.BasesPackage;

        model MonoLayerOpaque "single material layer"

          parameter Modelica.SIunits.Area A "Layer area";
          parameter IDEAS.Buildings.Data.Interfaces.Material mat
          "Layer material";
          parameter Modelica.SIunits.Angle inc "Inclination";

          parameter Modelica.SIunits.Temperature TStart = 289.15
          "Start temperature for each of the states";

          final parameter Integer nSta = mat.nSta;
          final parameter Integer nFlo = mat.nSta + 1;
          final parameter Real R = mat.R "Total specific thermal resistance";
          final parameter Modelica.SIunits.ThermalConductance G=(A*mat.k*nSta)/mat.d;
          final parameter Modelica.SIunits.HeatCapacity C=(A*mat.rho*mat.c*mat.d)/nSta;

      public
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start=TStart))
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b(T(start=TStart))
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.SIunits.Temperature[nSta] T(start=ones(nSta)*TStart)
          "Temperature at the states";
          Modelica.SIunits.HeatFlowRate[nFlo] Q_flow
          "Heat flow rate from state i to i+1";

        equation
          // connectors
          port_a.Q_flow = +Q_flow[1];
          port_b.Q_flow = -Q_flow[nFlo];

          // edge resistances
          port_a.T - T[1] = Q_flow[1]/(G*2);
          T[nSta] - port_b.T = Q_flow[nSta + 1]/(G*2);

          // Q_flow[i] is heat flowing from (i-1) to (i)
          for i in 2:nSta loop
            T[i - 1] - T[i] = Q_flow[i]/G;
          end for;

          // Heat storages in the masses
          for i in 1:nSta loop
            der(T[i]) = (Q_flow[i] - Q_flow[i + 1])/C;
          end for;

          annotation (
            Diagram(graphics),
            Icon(graphics={
                Rectangle(
                  extent={{-90,80},{90,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Text(
                  extent={{-150,113},{150,73}},
                  textString="%name",
                  lineColor={0,0,255}),
                Ellipse(
                  extent={{-40,-42},{40,38}},
                  lineColor={127,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-39,40},{39,-40}},
                  lineColor={127,0,0},
                  fontName="Calibri",
                  origin={0,-1},
                  rotation=90,
                  textString="S")}),
            Documentation(info="<html>
<p>For the purpose of dynamic building simulation, the partial differential equation of the continuous time and space model of heat transport through a solid is most often simplified into ordinary differential equations with a finite number of parameters representing only one-dimensional heat transport through a construction layer. Within this context, the wall is modeled with lumped elements, i.e. a model where temperatures and heat fluxes are determined from a system composed of a sequence of discrete resistances and capacitances R_{n+1}, C_{n}. The number of capacitive elements $n$ used in modeling the transient thermal response of the wall denotes the order of the lumped capacitance model.</p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-pqp0E04K.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-I7KXJhSH.png\"/> is the added energy to the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-B0HPmGTu.png\"/> is the temperature of the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-t7aqbnLB.png\"/> is the thermal capacity of the lumped capacity equal to<img src=\"modelica://IDEAS/Images/equations/equation-JieDs0oi.png\"/> for which rho denotes the density and <img src=\"modelica://IDEAS/Images/equations/equation-ml5CM4zK.png\"/> is the specific heat capacity of the material and <img src=\"modelica://IDEAS/Images/equations/equation-hOGNA6h5.png\"/> the equivalent thickness of the lumped element, where <img src=\"modelica://IDEAS/Images/equations/equation-1pDREAb7.png\"/> the heat flux through the lumped resistance and <img src=\"modelica://IDEAS/Images/equations/equation-XYf3O3hw.png\"/> is the total thermal resistance of the lumped resistance and where <img src=\"modelica://IDEAS/Images/equations/equation-dgS5sGAN.png\"/> are internal thermal source.</p>
</html>"));
        end MonoLayerOpaque;

        model MultiLayerOpaque "multiple material layers in series"

          parameter Modelica.SIunits.Area A "total multilayer area";
          parameter Modelica.SIunits.Angle inc "inclination";
          parameter Integer nLay(min=1) "number of layers";
          parameter IDEAS.Buildings.Data.Interfaces.Material[nLay]  mats
          "array of layer materials";
          parameter Integer locGain(min=1) "location of the internal gain";

          parameter Modelica.SIunits.Temperature[nLay] TStart = ones(nLay)*289.15
          "Start temperature for each of the layers";

          IDEAS.Buildings.Components.BaseClasses.MonoLayerOpaque[nLay] nMat(
            each final A=A,
            each final inc=inc,
            final TStart = TStart,
            final mat=mats) "layers";

          final parameter Real R=sum(nMat.R)
          "total specific thermal resistance";

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_gain
          "port for gains by embedded active layers"
            annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start=289.15))
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b(T(start=289.15))
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Modelica.Blocks.Interfaces.RealOutput iEpsLw_b
          "output of the interior emissivity for radiative heat losses"
            annotation (Placement(transformation(extent={{90,70},{110,90}})));
          Modelica.Blocks.Interfaces.RealOutput iEpsSw_b
          "output of the interior emissivity for radiative heat losses"
            annotation (Placement(transformation(extent={{90,30},{110,50}})));
          Modelica.Blocks.Interfaces.RealOutput iEpsLw_a
          "output of the interior emissivity for radiative heat losses"
            annotation (Placement(transformation(extent={{-90,70},{-110,90}})));
          Modelica.Blocks.Interfaces.RealOutput iEpsSw_a
          "output of the interior emissivity for radiative heat losses"
            annotation (Placement(transformation(extent={{-90,30},{-110,50}})));
          Modelica.Blocks.Interfaces.RealOutput area=A
          "output of the interior emissivity for radiative heat losses"   annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=-90,
                origin={0,100})));
        equation
          connect(port_a, nMat[1].port_a);

          for j in 1:nLay - 1 loop
            connect(nMat[j].port_b, nMat[j + 1].port_a);
          end for;

          connect(nMat[locGain].port_b, port_gain);
          connect(port_b, nMat[nLay].port_b);

          iEpsLw_a = mats[1].epsLw;
          iEpsSw_a = mats[1].epsSw;
          iEpsLw_b = mats[nLay].epsLw;
          iEpsSw_b = mats[nLay].epsSw;

          annotation (
            Diagram(graphics),
            Icon(graphics={
                Rectangle(
                  extent={{-90,80},{20,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Text(
                  extent={{-150,113},{150,73}},
                  textString="%name",
                  lineColor={0,0,255}),
                Rectangle(
                  extent={{20,80},{40,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Forward,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{40,80},{80,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Line(
                  points={{20,80},{20,-80}},
                  pattern=LinePattern.None,
                  smooth=Smooth.None),
                Line(
                  points={{40,80},{40,-80}},
                  pattern=LinePattern.None,
                  smooth=Smooth.None),
                Ellipse(
                  extent={{-40,-42},{40,38}},
                  lineColor={127,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-39,40},{39,-40}},
                  lineColor={127,0,0},
                  fontName="Calibri",
                  origin={0,-1},
                  rotation=90,
                  textString="S")}),
            Documentation(info="<html>
<p>For the purpose of dynamic building simulation, the partial differential equation of the continuous time and space model of heat transport through a solid is most often simplified into ordinary differential equations with a finite number of parameters representing only one-dimensional heat transport through a construction layer. Within this context, the wall is modeled with lumped elements, i.e. a model where temperatures and heat fluxes are determined from a system composed of a sequence of discrete resistances and capacitances R_{n+1}, C_{n}. The number of capacitive elements $n$ used in modeling the transient thermal response of the wall denotes the order of the lumped capacitance model.</p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-pqp0E04K.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-I7KXJhSH.png\"/> is the added energy to the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-B0HPmGTu.png\"/> is the temperature of the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-t7aqbnLB.png\"/> is the thermal capacity of the lumped capacity equal to<img src=\"modelica://IDEAS/Images/equations/equation-JieDs0oi.png\"/> for which rho denotes the density and <img src=\"modelica://IDEAS/Images/equations/equation-ml5CM4zK.png\"/> is the specific heat capacity of the material and <img src=\"modelica://IDEAS/Images/equations/equation-hOGNA6h5.png\"/> the equivalent thickness of the lumped element, where <img src=\"modelica://IDEAS/Images/equations/equation-1pDREAb7.png\"/> the heat flux through the lumped resistance and <img src=\"modelica://IDEAS/Images/equations/equation-XYf3O3hw.png\"/> is the total thermal resistance of the lumped resistance and where <img src=\"modelica://IDEAS/Images/equations/equation-dgS5sGAN.png\"/> are internal thermal source.</p>
</html>"));
        end MultiLayerOpaque;

        model InteriorConvection "interior surface convection"

          parameter Modelica.SIunits.Area A "surface area";
          parameter Modelica.SIunits.Angle inc "inclination";

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start=289.15))
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b(T(start=289.15))
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
          Real hcon;

      protected
          Modelica.SIunits.TemperatureDifference dT;
          final parameter Boolean Ceiling=abs(sin(inc)) < 10E-5 and cos(inc) > 0
          "true if ceiling";
          final parameter Boolean Floor=abs(sin(inc)) < 10E-5 and cos(inc) < 0
          "true if floor";

        equation
          if Ceiling then
            port_a.Q_flow = if noEvent(dT > 0) then A*2.72*abs(dT)^1.13 else -A*2.27*
              abs(dT)^1.24;
          elseif Floor then
            port_a.Q_flow = if noEvent(dT > 0) then A*2.27*abs(dT)^1.24 else -A*2.72*
              abs(dT)^1.13;
          else
            port_a.Q_flow = A*sign(dT)*2.07*abs(dT)^1.23;
          end if;

          port_a.Q_flow + port_b.Q_flow = 0 "no heat is stored";
          dT = port_a.T - port_b.T;
          hcon = port_a.Q_flow/dT;

          annotation (Icon(graphics={
                Rectangle(
                  extent={{-90,80},{-60,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Line(points={{-60,20},{76,20}}, color={191,0,0}),
                Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
                Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
                Line(points={{56,30},{76,20}}, color={191,0,0}),
                Line(points={{56,10},{76,20}}, color={191,0,0}),
                Line(points={{56,-10},{76,-20}}, color={191,0,0}),
                Line(points={{56,-30},{76,-20}}, color={191,0,0}),
                Line(points={{6,80},{6,-80}}, color={0,127,255}),
                Line(points={{40,80},{40,-80}}, color={0,127,255}),
                Line(points={{76,80},{76,-80}}, color={0,127,255}),
                Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
                Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
                Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
                Line(points={{6,-80},{16,-60}}, color={0,127,255}),
                Line(points={{40,-80},{30,-60}}, color={0,127,255}),
                Line(points={{40,-80},{50,-60}}, color={0,127,255}),
                Line(points={{76,-80},{66,-60}}, color={0,127,255}),
                Line(points={{76,-80},{86,-60}}, color={0,127,255}),
                Text(
                  extent={{-150,-90},{150,-130}},
                  textString="%name",
                  lineColor={0,0,255}),
                Line(
                  points={{-60,80},{-60,-80}},
                  color={0,0,0},
                  thickness=0.5)}), Documentation(info="<html>
<p>The interior natural convective heat transfer coefficient <img src=\"modelica://IDEAS/Images/equations/equation-eZGZlJrg.png\"/> is computed for each interior surface as </p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-KNBSKUDK.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-W5kvS3SS.png\"/> is the characteristic length of the surface, <img src=\"modelica://IDEAS/Images/equations/equation-jhC1rqax.png\"/> is the indoor air temperature and <img src=\"modelica://IDEAS/Images/equations/equation-sbXAgHuQ.png\"/> are correlation coefficients. These parameters {<img src=\"modelica://IDEAS/Images/equations/equation-nHmmePq5.png\"/>,<img src=\"modelica://IDEAS/Images/equations/equation-zJZmNUzp.png\"/>,<img src=\"modelica://IDEAS/Images/equations/equation-7nwXbcLp.png\"/>} are identical to {1.823,-0.121,0.293} for vertical surfaces <a href=\"IDEAS.Buildings.UsersGuide.References\">[Khalifa 2001]</a>, {2.175,-0.076,0.308} for horizontal surfaces wherefore the heat flux is in the same direction as the buoyancy force <a href=\"IDEAS.Buildings.UsersGuide.References\">[Khalifa 2001]</a>, and {2.72,-,0.13} for horizontal surfaces wherefore the heat flux is in the opposite direction as the buoyancy force <a href=\"IDEAS.Buildings.UsersGuide.References\">[Awbi 1999]</a>. The interior natural convective heat transfer coefficient is only described as function of the temperature difference. Similar to the thermal model for heat transfer through a wall, a thermal circuit formulation for the direct radiant exchange between surfaces can be derived <a href=\"IDEAS.Buildings.UsersGuide.References\">[ Buchberg 1955, Oppenheim 1956]</a>.</p>
</html>"));
        end InteriorConvection;

        model ExteriorConvection "exterior surface convection"

          parameter Modelica.SIunits.Area A "surface area";

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start=289.15))
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          outer IDEAS.SimInfoManager sim "Simulation information manager"
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

          Real hcon "equivalent surface conductance";

        equation
          if noEvent(sim.Va <= 5) then
            hcon = 4.0*sim.Va + 5.6;
          else
            hcon = 7.1*abs(sim.Va)^(0.78);
          end if;

          port_a.Q_flow = hcon*A*(port_a.T - sim.Te);

          annotation (Icon(graphics={
                Rectangle(
                  extent={{-90,80},{-60,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Line(points={{-60,20},{76,20}}, color={191,0,0}),
                Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
                Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
                Line(points={{56,30},{76,20}}, color={191,0,0}),
                Line(points={{56,10},{76,20}}, color={191,0,0}),
                Line(points={{56,-10},{76,-20}}, color={191,0,0}),
                Line(points={{56,-30},{76,-20}}, color={191,0,0}),
                Line(points={{6,80},{6,-80}}, color={0,127,255}),
                Line(points={{40,80},{40,-80}}, color={0,127,255}),
                Line(points={{76,80},{76,-80}}, color={0,127,255}),
                Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
                Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
                Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
                Line(points={{6,-80},{16,-60}}, color={0,127,255}),
                Line(points={{40,-80},{30,-60}}, color={0,127,255}),
                Line(points={{40,-80},{50,-60}}, color={0,127,255}),
                Line(points={{76,-80},{66,-60}}, color={0,127,255}),
                Line(points={{76,-80},{86,-60}}, color={0,127,255}),
                Text(
                  extent={{-150,-90},{150,-130}},
                  textString="%name",
                  lineColor={0,0,255}),
                Line(
                  points={{-60,80},{-60,-80}},
                  color={0,0,0},
                  thickness=0.5)}), Documentation(info="<html>
<p>The exterior convective heat flow is computed as </p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-dlroqBUD.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-pvb42RGk.png\"/> is the surface area, <img src=\"modelica://IDEAS/Images/equations/equation-EFr6uClx.png\"/> is the dry-bulb exterior air temperature, <img src=\"modelica://IDEAS/Images/equations/equation-9BU57cj4.png\"/> is the surface temperature and <img src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/> is the wind speed in the undisturbed flow at 10 meter above the ground and where the stated correlation is valid for a <img src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/> range of [0.15,7.5] meter per second <a href=\"IDEAS.Buildings.UsersGuide.References\">[Defraeye 2011]</a>. The <img src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/>-dependent term denoting the exterior convective heat transfer coefficient <img src=\"modelica://IDEAS/Images/equations/equation-W7Ft8vaa.png\"/> is determined as <img src=\"modelica://IDEAS/Images/equations/equation-aZcbMNkz.png\"/> in order to take into account buoyancy effects at low wind speeds <a href=\"IDEAS.Buildings.UsersGuide.References\">[Jurges 1924]</a>.</p>
</html>"));
        end ExteriorConvection;

        model ExteriorSolarAbsorption
        "shortwave radiation absorption on an exterior surface"

          parameter Modelica.SIunits.Area A "surface area";

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start=289.15))
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Interfaces.RealInput solDir
          "direct solar illuminance on surface se"
            annotation (Placement(transformation(extent={{120,40},{80,80}})));
          Modelica.Blocks.Interfaces.RealInput solDif
          "diffuse solar illuminance on surface s"
            annotation (Placement(transformation(extent={{120,0},{80,40}})));
          Modelica.Blocks.Interfaces.RealInput epsSw
          "shortwave emissivity of the surface"
            annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
        equation
          port_a.Q_flow = -(solDir + solDif)*epsSw;

          annotation (Icon(graphics={
                Rectangle(
                  extent={{-90,80},{-60,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Line(
                  points={{-60,80},{-60,-80}},
                  color={0,0,0},
                  thickness=0.5),
                Line(points={{-40,10},{40,10}}, color={191,0,0}),
                Line(points={{-40,10},{-30,16}}, color={191,0,0}),
                Line(points={{-40,10},{-30,4}}, color={191,0,0}),
                Line(points={{-40,-10},{40,-10}}, color={191,0,0}),
                Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
                Line(points={{-40,-30},{-30,-24}}, color={191,0,0}),
                Line(points={{-40,-30},{-30,-36}}, color={191,0,0}),
                Line(points={{-40,30},{40,30}}, color={191,0,0}),
                Line(points={{-40,30},{-30,36}}, color={191,0,0}),
                Line(points={{-40,30},{-30,24}},color={191,0,0}),
                Line(points={{-40,-10},{-30,-4}},color={191,0,0}),
                Line(points={{-40,-10},{-30,-16}}, color={191,0,0})}), Documentation(
                info="<html>
<p>Transmitted shortwave solar radiation is distributed over all surfaces in the zone in a prescribed scale. This scale is an input value which may be dependent on the shape of the zone and the location of the windows, but literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption.</p>
</html>"));
        end ExteriorSolarAbsorption;

        model ExteriorHeatRadidation
        "longwave radiative heat exchange of an exterior surface with the environment"

          parameter Modelica.SIunits.Area A "surface area";
          parameter Modelica.SIunits.Angle inc "inclination";

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start=289.15))
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
          outer IDEAS.SimInfoManager sim "Simulation information manager"
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

      protected
          Real Fse=(1 - cos(inc))/2
          "radiant-interchange configuration factor between surface and environment";
          Real Fssky=(1 + cos(inc))/2
          "radiant-interchange configuration factor between surface and sky";
          Modelica.SIunits.Temperature Tenv
          "Radiative temperature of the total environment";

      public
          Modelica.Blocks.Interfaces.RealInput epsLw
          "shortwave emissivity of the surface"
            annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
        equation

          Tenv = (Fssky*sim.Tsky^4 + (1 - Fssky)*sim.Te^4)^0.25;
          port_a.Q_flow = A*Modelica.Constants.sigma*epsLw*(port_a.T - Tenv)*(port_a.T
             + Tenv)*(port_a.T^2 + Tenv^2);

          annotation (Icon(graphics={
                Line(points={{-40,10},{40,10}}, color={191,0,0}),
                Line(points={{-40,10},{-30,16}}, color={191,0,0}),
                Line(points={{-40,10},{-30,4}}, color={191,0,0}),
                Line(points={{-40,-10},{40,-10}}, color={191,0,0}),
                Line(points={{30,-16},{40,-10}}, color={191,0,0}),
                Line(points={{30,-4},{40,-10}}, color={191,0,0}),
                Line(points={{-40,-30},{40,-30}}, color={191,0,0}),
                Line(points={{-40,-30},{-30,-24}}, color={191,0,0}),
                Line(points={{-40,-30},{-30,-36}}, color={191,0,0}),
                Line(points={{-40,30},{40,30}}, color={191,0,0}),
                Line(points={{30,24},{40,30}}, color={191,0,0}),
                Line(points={{30,36},{40,30}}, color={191,0,0}),
                Rectangle(
                  extent={{-90,80},{-60,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Line(
                  points={{-60,80},{-60,-80}},
                  color={0,0,0},
                  thickness=0.5),
                Rectangle(
                  extent={{90,80},{60,-80}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward,
                  pattern=LinePattern.None),
                Line(
                  points={{60,80},{60,-80}},
                  color={0,0,0},
                  thickness=0.5)}), Documentation(info="<html>
<p>Longwave radiation between the surface and environment <img src=\"modelica://IDEAS/Images/equations/equation-AMjoTx5S.png\"/> is determined as</p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-nt0agyic.png\"/></p>
<p>as derived from the Stefan-Boltzmann law wherefore <img src=\"modelica://IDEAS/Images/equations/equation-C6ZFvd5P.png\"/> the Stefan-Boltzmann constant <a href=\"IDEAS.Buildings.UsersGuide.References\">[Mohr 2008]</a>, <img src=\"modelica://IDEAS/Images/equations/equation-sLNH0zgx.png\"/> the longwave emissivity of the exterior surface, <img src=\"modelica://IDEAS/Images/equations/equation-Q5X4Yht9.png\"/> the radiant-interchange configuration factor between the surface and sky <a href=\"IDEAS.Buildings.UsersGuide.References\">[Hamilton 1952]</a>, and the surface and the environment respectively and <img src=\"modelica://IDEAS/Images/equations/equation-k2V39u5g.png\"/> and <img src=\"modelica://IDEAS/Images/equations/equation-GuSnzLxW.png\"/> are the exterior surface and sky temperature respectively. Shortwave solar irradiation absorbed by the exterior surface is determined as </p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-cISf3Itz.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-IKuIUMef.png\"/> is the shortwave absorption of the surface and <img src=\"modelica://IDEAS/Images/equations/equation-Vuo4fgcb.png\"/> the total irradiation on the depicted surface. </p>
</html>"));
        end ExteriorHeatRadidation;
      end BaseClasses;
    end Components;

    package Data "Data for transient thermal building simulation"
      extends Modelica.Icons.MaterialPropertiesPackage;

      package Insulation "Library of thermal insulation materials"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record Rockwool = IDEAS.Buildings.Data.Interfaces.Insulation (
            final k=0.036,
            final c=840,
            final rho=110,
            final epsLw=0.8,
            final epsSw=0.8) "Rockwool";
      end Insulation;

      package Materials "Library of construction materials"
          extends Modelica.Icons.MaterialPropertiesPackage;

        record BrickMe =  IDEAS.Buildings.Data.Interfaces.Material (
            k=0.75,
            c=840,
            rho=1400,
            epsLw=0.88,
            epsSw=0.55) "Medium masonry for exterior applications ";

        record BrickMi =  IDEAS.Buildings.Data.Interfaces.Material (
            k=0.54,
            c=840,
            rho=1400,
            epsLw=0.88,
            epsSw=0.55) "Medium masonry for interior applications ";

        record Gypsum = IDEAS.Buildings.Data.Interfaces.Material (
            k=0.6,
            c=840,
            rho=975,
            epsLw=0.85,
            epsSw=0.65) "Gypsum plaster for finishing";
      end Materials;

      package Constructions "Library of building envelope constructions"
        extends Modelica.Icons.MaterialPropertiesPackage;

        model CavityWall
        "Example - Classic cavity wall construction with fully-filled cavity"

          extends IDEAS.Buildings.Data.Interfaces.Construction(
            nLay=4,
            locGain=2,
            final mats={Materials.BrickMe(d=0.08),insulationType,Materials.BrickMi(d=0.14),Materials.Gypsum(d=0.015)});

        end CavityWall;
      end Constructions;

      package Interfaces "Building data interfaces"
        extends Modelica.Icons.InterfacesPackage;

        record Material "Properties of building materials"

        extends Modelica.Icons.MaterialProperty;

          parameter Modelica.SIunits.Length d = 0 "Layer thickness";
          parameter Modelica.SIunits.ThermalConductivity k
          "Thermal conductivity";
          parameter Modelica.SIunits.SpecificHeatCapacity c
          "Specific thermal capacity";
          parameter Modelica.SIunits.Density rho "Density";
          parameter Modelica.SIunits.Emissivity epsLw = 0.85
          "Longwave emisivity";
          parameter Modelica.SIunits.Emissivity epsSw = 0.85
          "Shortwave emissivity";
          parameter Boolean gas = false "Boolean wether the material is a gas";
          parameter Real mhu(unit="m2/s") = 0
          "Viscosity, i.e. if the material is a fluid";
          final parameter Real R = d/k;

          parameter Modelica.SIunits.Emissivity epsLw_a = 0.84
          "Longwave emisivity";
          parameter Modelica.SIunits.Emissivity epsLw_b = 0.84
          "Longwave emisivity";

          final parameter Modelica.SIunits.ThermalDiffusivity alpha = k/(c*rho)
          "Thermal diffusivity";
          final parameter Integer nStaRef = 3
          "Number of states of a reference case, ie. 20 cm dense concrete";
          final parameter Real piRef = 224
          "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete";
          final parameter Real piLay = d/sqrt(alpha)
          "d/sqrt(mat.alpha) of the depicted layer";
          final parameter Integer nSta(min=1) = max(1, integer(ceil(nStaRef*piLay/piRef)))
          "Actual number of state variables in material";

          annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">General description</font></h4></p>
<p><h5>Goal</h5></p>
<p>The <code>Material.mo</code> partial describes the material data required for building construction modelling.</p>
<p><h5>Assumptions and limitations</h5></p>
<p><ol>
<li>Current number of states in the material layer is determined by a reference number of states in a 20cm concrete slab.</li>
</ol></p>
<p><h4><font color=\"#008000\">Validation </font></h4></p>
<p>No validation required.</p>
</html>"));
        end Material;

        record Insulation

          extends IDEAS.Buildings.Data.Interfaces.Material;

        end Insulation;

        model Construction

        extends Modelica.Icons.MaterialProperty;

          parameter Integer nLay(min=1)
          "Number of layers of the construction, including gaps";
          parameter Integer locGain(min=1) = 1
          "Location of possible embedded system";
          replaceable parameter IDEAS.Buildings.Data.Interfaces.Insulation insulationType(final d=insulationTickness) constrainedby
          IDEAS.Buildings.Data.Interfaces.Insulation
          "Type of thermal insulation";
          parameter IDEAS.Buildings.Data.Interfaces.Material[nLay] mats
          "Array of materials";
          parameter Modelica.SIunits.Length insulationTickness = 0
          "Thermal insulation thickness";

          annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">General description</font></h4></p>
<p><h5>Goal</h5></p>
<p>The <code>Construction.mo</code> partial describes the material data required for building construction modelling.</p>
<p><h4><font color=\"#008000\">Validation </font></h4></p>
<p>No validation required.</p>
</html>"));
        end Construction;
      end Interfaces;
    end Data;
  end Buildings;

  package Occupants "Building occupant models"
    extends Modelica.Icons.Package;

    package Extern
      extends Modelica.Icons.Package;

      package Interfaces
        extends Modelica.Icons.InterfacesPackage;

        model Occ_Files "Dummy file reader for occupant model"
          parameter Integer nOcc = 1 "Number of occupant data sets to be read" annotation(Dialog(group = "Building occupants"));
          parameter String filPres = "User_zeros.txt"
          "Filename for occupancy presence"                                             annotation(Dialog(group = "Building occupants"));
          parameter String filQCon = "User_zeros.txt"
          "Filename for occupancy-driven convective gains"                                             annotation(Dialog(group = "Building occupants"));
          parameter String filQRad = "User_zeros.txt"
          "Filename for occupancy-driven radiative gains"                                             annotation(Dialog(group = "Building occupants"));
          parameter String filP = "User_zeros.txt"
          "Filename for occupancy-driven active power load"                                          annotation(Dialog(group = "Building occupants"));
          parameter String filQ = "User_zeros.txt"
          "Filename for occupancy-driven reactive power load"                                          annotation(Dialog(group = "Building occupants"));
          parameter String filDHW = "User_zeros.txt"
          "Filename for occupancy-driven domestic hot water redrawal"                                            annotation(Dialog(group = "Building occupants"));
        end Occ_Files;
      end Interfaces;
    end Extern;
  end Occupants;

  package BaseClasses "Base classes for IDEAS"
    extends Modelica.Icons.BasesPackage;

    package Math "General mathematical stuff"
      extends Modelica.Icons.Package;

      function MaxSmooth

      input Real u1 "first argument for maximum";
      input Real u2 "second argument for maximum";
      input Real delta "width of the transition interval";
      output Real y "smooth maximum result";

      algorithm
      y := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(pos=  u1, neg=  u2, x=  u1-u2, deltax=  delta);

      end MaxSmooth;

      function MinSmooth

      input Real u1 "first argument for maximum";
      input Real u2 "second argument for maximum";
      input Real delta "width of the transition interval";
      output Real y "smooth maximum result";

      algorithm
      y := Modelica.Media.Air.MoistAir.Utilities.spliceFunction(pos=  u1, neg=  u2, x=  u2-u1, deltax=  delta);

      end MinSmooth;
    end Math;
  end BaseClasses;
  annotation (uses(Modelica(version="3.2")),               Icon(graphics),
  version="2",
  conversion(noneFromVersion="", noneFromVersion="1"),
    Documentation(info="<html>
<p>Licensed by KU Leuven and 3E under the Modelica License 2 </p>
<p>Copyright &copy; 2013-2023, KU Leuven and 3E. </p>
<p>&nbsp; </p>
<p><i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>;</i>  <i>it can be redistributed and/or modified under the terms of the Modelica License 2. </i></p>
<p><i>For license conditions (including the disclaimer of warranty) see <a href=\"UrlBlockedError.aspx\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\">https://www.modelica.org/licenses/ModelicaLicense2</a>.</i> </p>
</html>"));

  model TEST

    inner SimInfoManager sim
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Buildings.Components.OuterWall outerWall(
      redeclare final parameter IDEAS.Buildings.Data.Constructions.CavityWall constructionType,
      redeclare final parameter IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
      final AWall=1,
      final insulationThickness=0.05,
      final inc=1.5707963267949,
      final azi=1.5707963267949)
      annotation (Placement(transformation(extent={{-76,40},{-66,60}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
      annotation (Placement(transformation(extent={{-18,38},{-38,58}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=294.15)
      annotation (Placement(transformation(extent={{-18,6},{-38,26}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=0)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-74,8})));
  equation
    connect(outerWall.surfCon_a, fixedTemperature.port) annotation (Line(
        points={{-66,47},{-52,47},{-52,48},{-38,48}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(outerWall.surfRad_a, fixedTemperature1.port) annotation (Line(
        points={{-66,44},{-52,44},{-52,16},{-38,16}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(fixedHeatFlow.port, outerWall.port_emb) annotation (Line(
        points={{-74,18},{-72,18},{-72,40},{-71,40}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end TEST;
end IDEAS;
model IDEAS_TEST
 extends IDEAS.TEST;
  annotation(experiment(
    StopTime=1,
    __Dymola_NumberOfIntervals=500,
    Tolerance=0.0001,
    __Dymola_Algorithm="dassl"),uses(IDEAS(version="2")));
end IDEAS_TEST;
