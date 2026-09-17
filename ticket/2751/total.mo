package ModelicaServices  
  extends Modelica.Icons.Package;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15;
    final constant Real small = 1.e-60;
    final constant Real inf = 1.e+60;
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax();
  end Machine;
end ModelicaServices;

package Modelica  
  extends Modelica.Icons.Package;

  package Blocks  
    extends Modelica.Icons.Package;

    package Continuous  
      extends Modelica.Icons.Package;

      block Der  
        extends .Modelica.Blocks.Interfaces.SISO;
      equation
        y = der(u);
      end Der;
    end Continuous;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real;
      connector RealOutput = output Real;

      partial block MO  
        extends Modelica.Blocks.Icons.Block;
        parameter Integer nout(min = 1) = 1;
        RealOutput[nout] y;
      end MO;

      partial block SISO  
        extends Modelica.Blocks.Icons.Block;
        RealInput u;
        RealOutput y;
      end SISO;
    end Interfaces;

    package Sources  
      extends Modelica.Icons.SourcesPackage;

      block CombiTimeTable  
        extends Modelica.Blocks.Interfaces.MO(final nout = max([size(columns, 1); size(offset, 1)]));
        parameter Boolean tableOnFile = false;
        parameter Real[:, :] table = fill(0.0, 0, 2);
        parameter String tableName = "NoName";
        parameter String fileName = "NoName";
        parameter Boolean verboseRead = true;
        parameter Integer[:] columns = 2:size(table, 2);
        parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments;
        parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
        parameter Real[:] offset = {0};
        parameter Modelica.SIunits.Time startTime = 0;
        parameter Modelica.SIunits.Time timeScale(min = Modelica.Constants.eps) = 1 annotation(Evaluate = true);
        final parameter Modelica.SIunits.Time t_min(fixed = false);
        final parameter Modelica.SIunits.Time t_max(fixed = false);
        final parameter Real t_minScaled(fixed = false);
        final parameter Real t_maxScaled(fixed = false);
      protected
        final parameter Real[nout] p_offset = if size(offset, 1) == 1 then ones(nout) * offset[1] else offset;
        Modelica.Blocks.Types.ExternalCombiTimeTable tableID = Modelica.Blocks.Types.ExternalCombiTimeTable(if tableOnFile then tableName else "NoName", if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", table, startTime / timeScale, columns, smoothness, extrapolation);
        discrete Modelica.SIunits.Time nextTimeEvent(start = 0, fixed = true);
        discrete Real nextTimeEventScaled(start = 0, fixed = true);
        parameter Real tableOnFileRead(fixed = false);
        constant Real DBL_MAX = 1.7976931348623158e+308;
        Real timeScaled;

        function readTableData  
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Boolean forceRead = false;
          output Real readSuccess;
          input Boolean verboseRead;
          external "C" readSuccess = ModelicaStandardTables_CombiTimeTable_read(tableID, forceRead, verboseRead) annotation(Library = {"ModelicaStandardTables"});
        end readTableData;

        function getTableValue  
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Integer icol;
          input Modelica.SIunits.Time timeIn;
          discrete input Modelica.SIunits.Time nextTimeEvent;
          discrete input Modelica.SIunits.Time pre_nextTimeEvent;
          input Real tableAvailable annotation(__OpenModelica_UnusedVariable = true);
          output Real y;
          external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) annotation(Library = {"ModelicaStandardTables"}, derivative(noDerivative = nextTimeEvent, noDerivative = pre_nextTimeEvent, noDerivative = tableAvailable) = getDerTableValue);
        end getTableValue;

        function getTableValueNoDer  
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Integer icol;
          input Modelica.SIunits.Time timeIn;
          discrete input Modelica.SIunits.Time nextTimeEvent;
          discrete input Modelica.SIunits.Time pre_nextTimeEvent;
          input Real tableAvailable annotation(__OpenModelica_UnusedVariable = true);
          output Real y;
          external "C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent) annotation(Library = {"ModelicaStandardTables"});
        end getTableValueNoDer;

        function getDerTableValue  
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Integer icol;
          input Modelica.SIunits.Time timeIn;
          discrete input Modelica.SIunits.Time nextTimeEvent;
          discrete input Modelica.SIunits.Time pre_nextTimeEvent;
          input Real tableAvailable annotation(__OpenModelica_UnusedVariable = true);
          input Real der_timeIn;
          output Real der_y;
          external "C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn) annotation(Library = {"ModelicaStandardTables"});
        end getDerTableValue;

        function getTableTimeTmin  
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Real tableAvailable annotation(__OpenModelica_UnusedVariable = true);
          output Modelica.SIunits.Time timeMin;
          external "C" timeMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID) annotation(Library = {"ModelicaStandardTables"});
        end getTableTimeTmin;

        function getTableTimeTmax  
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Real tableAvailable annotation(__OpenModelica_UnusedVariable = true);
          output Modelica.SIunits.Time timeMax;
          external "C" timeMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID) annotation(Library = {"ModelicaStandardTables"});
        end getTableTimeTmax;

        function getNextTimeEvent  
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Modelica.SIunits.Time timeIn;
          input Real tableAvailable annotation(__OpenModelica_UnusedVariable = true);
          output Modelica.SIunits.Time nextTimeEvent;
          external "C" nextTimeEvent = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(tableID, timeIn) annotation(Library = {"ModelicaStandardTables"});
        end getNextTimeEvent;
      initial algorithm
        if tableOnFile then
          tableOnFileRead := readTableData(tableID, false, verboseRead);
        else
          tableOnFileRead := 1.;
        end if;
        t_minScaled := getTableTimeTmin(tableID, tableOnFileRead);
        t_maxScaled := getTableTimeTmax(tableID, tableOnFileRead);
        t_min := t_minScaled * timeScale;
        t_max := t_maxScaled * timeScale;
      equation
        if tableOnFile then
          assert(tableName <> "NoName", "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0, "tableOnFile = false and parameter table is an empty matrix");
        end if;
        timeScaled = time / timeScale;
        when {timeScaled >= pre(nextTimeEventScaled), initial()} then
          nextTimeEventScaled = getNextTimeEvent(tableID, timeScaled, tableOnFileRead);
          if nextTimeEventScaled < DBL_MAX then
            nextTimeEvent = nextTimeEventScaled * timeScale;
          else
            nextTimeEvent = DBL_MAX;
          end if;
        end when;
        if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
          for i in 1:nout loop
            y[i] = p_offset[i] + getTableValueNoDer(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled), tableOnFileRead);
          end for;
        else
          for i in 1:nout loop
            y[i] = p_offset[i] + getTableValue(tableID, i, timeScaled, nextTimeEventScaled, pre(nextTimeEventScaled), tableOnFileRead);
          end for;
        end if;
      end CombiTimeTable;
    end Sources;

    package Types  
      extends Modelica.Icons.TypesPackage;
      type Smoothness = enumeration(LinearSegments, ContinuousDerivative, ConstantSegments);
      type Extrapolation = enumeration(HoldLastPoint, LastTwoPoints, Periodic, NoExtrapolation);

      class ExternalCombiTimeTable  
        extends ExternalObject;

        function constructor  
          extends Modelica.Icons.Function;
          input String tableName;
          input String fileName;
          input Real[:, :] table;
          input Modelica.SIunits.Time startTime;
          input Integer[:] columns;
          input Modelica.Blocks.Types.Smoothness smoothness;
          input Modelica.Blocks.Types.Extrapolation extrapolation;
          output ExternalCombiTimeTable externalCombiTimeTable;
          external "C" externalCombiTimeTable = ModelicaStandardTables_CombiTimeTable_init(tableName, fileName, table, size(table, 1), size(table, 2), startTime, columns, size(columns, 1), smoothness, extrapolation) annotation(Library = {"ModelicaStandardTables"});
        end constructor;

        function destructor  
          extends Modelica.Icons.Function;
          input ExternalCombiTimeTable externalCombiTimeTable;
          external "C" ModelicaStandardTables_CombiTimeTable_close(externalCombiTimeTable) annotation(Library = {"ModelicaStandardTables"});
        end destructor;
      end ExternalCombiTimeTable;
    end Types;

    package Icons  
      extends Modelica.Icons.IconsPackage;

      partial block Block  end Block;
    end Icons;
  end Blocks;

  package Math  
    extends Modelica.Icons.Package;

    package Icons  
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  end AxisCenter;
    end Icons;

    function asin  
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function exp  
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;
  end Math;

  package Utilities  
    extends Modelica.Icons.Package;

    package Strings  
      extends Modelica.Icons.Package;

      function length  
        extends Modelica.Icons.Function;
        input String string;
        output Integer result;
        external "C" result = ModelicaStrings_length(string) annotation(Library = "ModelicaExternalC");
      end length;

      function isEmpty  
        extends Modelica.Icons.Function;
        input String string;
        output Boolean result;
      protected
        Integer nextIndex;
        Integer len;
      algorithm
        nextIndex := Strings.Advanced.skipWhiteSpace(string);
        len := Strings.length(string);
        if len < 1 or nextIndex > len then
          result := true;
        else
          result := false;
        end if;
      end isEmpty;

      package Advanced  
        extends Modelica.Icons.Package;

        function skipWhiteSpace  
          extends Modelica.Icons.Function;
          input String string;
          input Integer startIndex(min = 1) = 1;
          output Integer nextIndex;
          external "C" nextIndex = ModelicaStrings_skipWhiteSpace(string, startIndex) annotation(Library = "ModelicaExternalC");
        end skipWhiteSpace;
      end Advanced;
    end Strings;
  end Utilities;

  package Constants  
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps;
    final constant .Modelica.SIunits.Velocity c = 299792458;
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7;
  end Constants;

  package Icons  
    extends Icons.Package;

    partial package ExamplesPackage  
      extends Modelica.Icons.Package;
    end ExamplesPackage;

    partial model Example  end Example;

    partial package Package  end Package;

    partial package InterfacesPackage  
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package TypesPackage  
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package IconsPackage  
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial function Function  end Function;
  end Icons;

  package SIunits  
    extends Modelica.Icons.Package;

    package Conversions  
      extends Modelica.Icons.Package;

      package NonSIunits  
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC");
      end NonSIunits;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Time = Real(final quantity = "Time", final unit = "s");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
end Modelica;

package ModelicaTest  
  extends Modelica.Icons.Package;

  package Tables  
    extends Modelica.Icons.ExamplesPackage;

    package CombiTimeTable  
      extends Modelica.Icons.ExamplesPackage;

      partial model Test0  
        Modelica.Blocks.Sources.CombiTimeTable t_new;
        Modelica.Blocks.Continuous.Der d_t_new;
      equation
        connect(t_new.y[1], d_t_new.u);
      end Test0;

      model Test15  
        extends Modelica.Icons.Example;
        extends Test0(t_new(table = {{0, 1}, {1, 0}}, startTime = 0.5));
      end Test15;
    end CombiTimeTable;
  end Tables;
end ModelicaTest;

model Test15
  extends ModelicaTest.Tables.CombiTimeTable.Test15;
  annotation(experiment(StartTime = 0, StopTime = 2.5));
end Test15;
