package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package ExternalReferences  "Library of functions to access external resources" 
    extends Modelica.Icons.Package;

    function loadResource  "Return the absolute path name of a URI or local file name (in this default implementation URIs are not supported, but only local file names)" 
      extends Modelica.Utilities.Internal.PartialModelicaServices.ExternalReferences.PartialLoadResource;
    algorithm
      fileReference := OpenModelica.Scripting.uriToFilename(uri);
    end loadResource;
  end ExternalReferences;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1.e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1.e+60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  end Machine;
  annotation(Protection(access = Access.hide), version = "3.2.2", versionBuild = 0, versionDate = "2016-01-15", dateModified = "2016-01-15 08:44:41Z"); 
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 3.2.2" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;

    package Continuous  "Library of continuous control blocks with internal states" 
      extends Modelica.Icons.Package;

      block FirstOrder  "First order transfer function block (= 1 pole)" 
        parameter Real k(unit = "1") = 1 "Gain";
        parameter .Modelica.SIunits.Time T(start = 1) "Time Constant";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate = true);
        parameter Real y_start = 0 "Initial or guess value of output (= state)";
        extends .Modelica.Blocks.Interfaces.SISO(y(start = y_start));
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(y) = 0;
        elseif initType == .Modelica.Blocks.Types.Init.InitialState or initType == .Modelica.Blocks.Types.Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(y) = (k * u - y) / T;
      end FirstOrder;

      block TransferFunction  "Linear transfer function" 
        extends .Modelica.Blocks.Interfaces.SISO;
        parameter Real[:] b = {1} "Numerator coefficients of transfer function (e.g., 2*s+3 is specified as {2,3})";
        parameter Real[:] a = {1} "Denominator coefficients of transfer function (e.g., 5*s+6 is specified as {5,6})";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation(Evaluate = true);
        parameter Real[size(a, 1) - 1] x_start = zeros(nx) "Initial or guess values of states";
        parameter Real y_start = 0 "Initial value of output (derivatives of y are zero up to nx-1-th derivative)";
        output Real[size(a, 1) - 1] x(start = x_start) "State of transfer function from controller canonical form";
      protected
        parameter Integer na = size(a, 1) "Size of Denominator of transfer function.";
        parameter Integer nb = size(b, 1) "Size of Numerator of transfer function.";
        parameter Integer nx = size(a, 1) - 1;
        parameter Real[:] bb = vector([zeros(max(0, na - nb), 1); b]);
        parameter Real d = bb[1] / a[1];
        parameter Real a_end = if a[end] > 100 * Modelica.Constants.eps * sqrt(a * a) then a[end] else 1.0;
        Real[size(x, 1)] x_scaled "Scaled vector x";
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(x_scaled) = zeros(nx);
        elseif initType == .Modelica.Blocks.Types.Init.InitialState then
          x_scaled = x_start * a_end;
        elseif initType == .Modelica.Blocks.Types.Init.InitialOutput then
          y = y_start;
          der(x_scaled[2:nx]) = zeros(nx - 1);
        end if;
      equation
        assert(size(b, 1) <= size(a, 1), "Transfer function is not proper");
        if nx == 0 then
          y = d * u;
        else
          der(x_scaled[1]) = ((-a[2:na] * x_scaled) + a_end * u) / a[1];
          der(x_scaled[2:nx]) = x_scaled[1:nx - 1];
          y = (bb[2:na] - d * a[2:na]) * x_scaled / a_end + d * u;
          x = x_scaled / a_end;
        end if;
      end TransferFunction;
    end Continuous;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector";
      connector RealOutput = output Real "'output Real' as connector";
      connector BooleanInput = input Boolean "'input Boolean' as connector";
      connector BooleanOutput = output Boolean "'output Boolean' as connector";

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal";
      end SO;

      partial block SISO  "Single Input Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u "Connector of Real input signal";
        RealOutput y "Connector of Real output signal";
      end SISO;

      partial block SI2SO  "2 Single Input / 1 Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u1 "Connector of Real input signal 1";
        RealInput u2 "Connector of Real input signal 2";
        RealOutput y "Connector of Real output signal";
      end SI2SO;

      partial block SIMO  "Single Input Multiple Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        parameter Integer nout = 1 "Number of outputs";
        RealInput u "Connector of Real input signal";
        RealOutput[nout] y "Connector of Real output signals";
      end SIMO;

      partial block MIMOs  "Multiple Input Multiple Output continuous control block with same number of inputs and outputs" 
        extends Modelica.Blocks.Icons.Block;
        parameter Integer n = 1 "Number of inputs (= number of outputs)";
        RealInput[n] u "Connector of Real input signals";
        RealOutput[n] y "Connector of Real output signals";
      end MIMOs;

      partial block BooleanSISO  "Single Input Single Output control block with signals of type Boolean" 
        extends Modelica.Blocks.Icons.BooleanBlock;
        BooleanInput u "Connector of Boolean input signal";
        BooleanOutput y "Connector of Boolean output signal";
      end BooleanSISO;

      partial block partialBooleanSI2SO  "Partial block with 2 input and 1 output Boolean signal" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.BooleanInput u1 "Connector of first Boolean input signal";
        Blocks.Interfaces.BooleanInput u2 "Connector of second Boolean input signal";
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal";
      end partialBooleanSI2SO;

      partial block partialBooleanThresholdComparison  "Partial block to compare the Real input u with a threshold and provide the result as 1 Boolean output signal" 
        parameter Real threshold = 0 "Comparison with respect to threshold";
        Blocks.Interfaces.RealInput u "Connector of Real input signal";
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal";
      end partialBooleanThresholdComparison;

      partial block BlockIcon  "This icon will be removed in future Modelica versions, use Modelica.Blocks.Icons.Block instead." end BlockIcon;
    end Interfaces;

    package Logical  "Library of components with Boolean input and output signals" 
      extends Modelica.Icons.Package;

      block And  "Logical 'and': y = u1 and u2" 
        extends Blocks.Interfaces.partialBooleanSI2SO;
      equation
        y = u1 and u2;
      end And;

      block GreaterThreshold  "Output y is true, if input u is greater than threshold" 
        extends Blocks.Interfaces.partialBooleanThresholdComparison;
      equation
        y = u > threshold;
      end GreaterThreshold;

      block Switch  "Switch between two Real signals" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.RealInput u1 "Connector of first Real input signal";
        Blocks.Interfaces.BooleanInput u2 "Connector of Boolean input signal";
        Blocks.Interfaces.RealInput u3 "Connector of second Real input signal";
        Blocks.Interfaces.RealOutput y "Connector of Real output signal";
      equation
        y = if u2 then u1 else u3;
      end Switch;

      block Timer  "Timer measuring the time from the time instant where the Boolean input became true" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal";
        Blocks.Interfaces.RealOutput y "Connector of Real output signal";
      protected
        discrete Modelica.SIunits.Time entryTime "Time instant when u became true";
      initial equation
        pre(entryTime) = 0;
      equation
        when u then
          entryTime = time;
        end when;
        y = if u then time - entryTime else 0.0;
      end Timer;
    end Logical;

    package Math  "Library of Real mathematical functions as input/output blocks" 
      extends Modelica.Icons.Package;

      block Gain  "Output the product of a gain value with the input signal" 
        parameter Real k(start = 1, unit = "1") "Gain value multiplied with input signal";
        .Modelica.Blocks.Interfaces.RealInput u "Input signal connector";
        .Modelica.Blocks.Interfaces.RealOutput y "Output signal connector";
      equation
        y = k * u;
      end Gain;

      block Feedback  "Output difference between commanded and feedback input" 
        .Modelica.Blocks.Interfaces.RealInput u1;
        .Modelica.Blocks.Interfaces.RealInput u2;
        .Modelica.Blocks.Interfaces.RealOutput y;
      equation
        y = u1 - u2;
      end Feedback;

      block Add  "Output the sum of the two inputs" 
        extends .Modelica.Blocks.Interfaces.SI2SO;
        parameter Real k1 = +1 "Gain of upper input";
        parameter Real k2 = +1 "Gain of lower input";
      equation
        y = k1 * u1 + k2 * u2;
      end Add;

      block Add3  "Output the sum of the three inputs" 
        extends Modelica.Blocks.Icons.Block;
        parameter Real k1 = +1 "Gain of upper input";
        parameter Real k2 = +1 "Gain of middle input";
        parameter Real k3 = +1 "Gain of lower input";
        .Modelica.Blocks.Interfaces.RealInput u1 "Connector 1 of Real input signals";
        .Modelica.Blocks.Interfaces.RealInput u2 "Connector 2 of Real input signals";
        .Modelica.Blocks.Interfaces.RealInput u3 "Connector 3 of Real input signals";
        .Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signals";
      equation
        y = k1 * u1 + k2 * u2 + k3 * u3;
      end Add3;
    end Math;

    package Nonlinear  "Library of discontinuous or non-differentiable algebraic control blocks" 
      extends Modelica.Icons.Package;

      block Limiter  "Limit the range of a signal" 
        parameter Real uMax(start = 1) "Upper limits of input signals";
        parameter Real uMin = -uMax "Lower limits of input signals";
        parameter Boolean strict = false "= true, if strict limits with noEvent(..)" annotation(Evaluate = true);
        parameter Boolean limitsAtInit = true "Has no longer an effect and is only kept for backwards compatibility (the implementation uses now the homotopy operator)" annotation(Evaluate = true);
        extends .Modelica.Blocks.Interfaces.SISO;
      equation
        assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) + ") < uMin (=" + String(uMin) + ")");
        if strict then
          y = homotopy(actual = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u)), simplified = u);
        else
          y = homotopy(actual = smooth(0, if u > uMax then uMax else if u < uMin then uMin else u), simplified = u);
        end if;
      end Limiter;
    end Nonlinear;

    package Routing  "Library of blocks to combine and extract signals" 
      extends Modelica.Icons.Package;

      model BooleanPassThrough  "Pass a Boolean signal through without modification" 
        extends Modelica.Blocks.Interfaces.BooleanSISO;
      equation
        y = u;
      end BooleanPassThrough;
    end Routing;

    package Sources  "Library of signal source blocks generating Real, Integer and Boolean signals" 
      extends Modelica.Icons.SourcesPackage;

      block RealExpression  "Set output signal to a time varying Real expression" 
        Modelica.Blocks.Interfaces.RealOutput y = 0.0 "Value of Real output";
      end RealExpression;

      block BooleanExpression  "Set output signal to a time varying Boolean expression" 
        Modelica.Blocks.Interfaces.BooleanOutput y = false "Value of Boolean output";
      end BooleanExpression;

      block Constant  "Generate constant signal of type Real" 
        parameter Real k(start = 1) "Constant output value";
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = k;
      end Constant;

      block TimeTable  "Generate a (possibly discontinuous) signal by linear interpolation in a table" 
        parameter Real[:, 2] table = fill(0.0, 0, 2) "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
        parameter Real offset = 0 "Offset of output signal";
        parameter .Modelica.SIunits.Time startTime = 0 "Output = offset for time < startTime";
        parameter Modelica.SIunits.Time timeScale(min = Modelica.Constants.eps) = 1 "Time scale of first table column" annotation(Evaluate = true);
        extends .Modelica.Blocks.Interfaces.SO;
      protected
        Real a "Interpolation coefficients a of actual interval (y=a*x+b)";
        Real b "Interpolation coefficients b of actual interval (y=a*x+b)";
        Integer last(start = 1) "Last used lower grid index";
        discrete .Modelica.SIunits.Time nextEvent(start = 0, fixed = true) "Next event instant";
        discrete Real nextEventScaled(start = 0, fixed = true) "Next scaled event instant";
        Real timeScaled "Scaled time";

        function getInterpolationCoefficients  "Determine interpolation coefficients and next time event" 
          extends Modelica.Icons.Function;
          input Real[:, 2] table "Table for interpolation";
          input Real offset "y-offset";
          input Real startTimeScaled "Scaled time-offset";
          input Real timeScaled "Actual scaled time instant";
          input Integer last "Last used lower grid index";
          input Real TimeEps "Relative epsilon to check for identical time instants";
          output Real a "Interpolation coefficients a (y=a*x + b)";
          output Real b "Interpolation coefficients b (y=a*x + b)";
          output Real nextEventScaled "Next scaled event instant";
          output Integer next "New lower grid index";
        protected
          Integer columns = 2 "Column to be interpolated";
          Integer ncol = 2 "Number of columns to be interpolated";
          Integer nrow = size(table, 1) "Number of table rows";
          Integer next0;
          Real tp;
          Real dt;
        algorithm
          next := last;
          nextEventScaled := timeScaled - TimeEps * abs(timeScaled);
          tp := timeScaled + TimeEps * abs(timeScaled) - startTimeScaled;
          if tp < 0.0 then
            nextEventScaled := startTimeScaled;
            a := 0;
            b := offset;
          elseif nrow < 2 then
            a := 0;
            b := offset + table[1, columns];
          else
            while next < nrow and tp >= table[next, 1] loop
              next := next + 1;
            end while;
            if next < nrow then
              nextEventScaled := startTimeScaled + table[next, 1];
            else
            end if;
            next0 := next - 1;
            dt := table[next, 1] - table[next0, 1];
            if dt <= TimeEps * abs(table[next, 1]) then
              a := 0;
              b := offset + table[next, columns];
            else
              a := (table[next, columns] - table[next0, columns]) / dt;
              b := offset + table[next0, columns] - a * table[next0, 1];
            end if;
          end if;
          b := b - a * startTimeScaled;
        end getInterpolationCoefficients;
      equation
        y = a * timeScaled + b;
      algorithm
        timeScaled := time / timeScale;
        when {time >= pre(nextEvent), initial()} then
          (a, b, nextEventScaled, last) := getInterpolationCoefficients(table, offset, startTime / timeScale, timeScaled, last, 100 * Modelica.Constants.eps);
          nextEvent := nextEventScaled * timeScale;
        end when;
      end TimeTable;
    end Sources;

    package Tables  "Library of blocks to interpolate in one and two-dimensional tables" 
      extends Modelica.Icons.Package;

      block CombiTable1D  "Table look-up in one dimension (matrix/file) with n inputs and n outputs" 
        extends Modelica.Blocks.Interfaces.MIMOs(final n = size(columns, 1));
        parameter Boolean tableOnFile = false "= true, if table is defined on file or in function usertab";
        parameter Real[:, :] table = fill(0.0, 0, 2) "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
        parameter String tableName = "NoName" "Table name on file or in function usertab (see docu)";
        parameter String fileName = "NoName" "File where matrix is stored";
        parameter Boolean verboseRead = true "= true, if info message that file is loading is to be printed";
        parameter Integer[:] columns = 2:size(table, 2) "Columns of table to be interpolated";
        parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of table interpolation";
      protected
        Modelica.Blocks.Types.ExternalCombiTable1D tableID = Modelica.Blocks.Types.ExternalCombiTable1D(if tableOnFile then tableName else "NoName", if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", table, columns, smoothness) "External table object";
        parameter Real tableOnFileRead(fixed = false) "= 1, if table was successfully read from file";

        function readTableData  "Read table data from ASCII text or MATLAB MAT-file" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Boolean forceRead = false "= true: Force reading of table data; = false: Only read, if not yet read.";
          input Boolean verboseRead "= true: Print info message; = false: No info message";
          output Real readSuccess "Table read success";
          external "C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"}, __ModelicaAssociation_Impure = true);
          annotation(__ModelicaAssociation_Impure = true); 
        end readTableData;

        function getTableValue  "Interpolate 1-dim. table defined by matrix" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable "Dummy input to ensure correct sorting of function calls" annotation(__OpenModelica_UnusedVariable = true);
          output Real y;
          external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"}, derivative(noDerivative = tableAvailable) = getDerTableValue);
          annotation(derivative(noDerivative = tableAvailable) = getDerTableValue); 
        end getTableValue;

        function getTableValueNoDer  "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable "Dummy input to ensure correct sorting of function calls" annotation(__OpenModelica_UnusedVariable = true);
          output Real y;
          external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
        end getTableValueNoDer;

        function getDerTableValue  "Derivative of interpolated 1-dim. table defined by matrix" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable "Dummy input to ensure correct sorting of function calls" annotation(__OpenModelica_UnusedVariable = true);
          input Real der_u;
          output Real der_y;
          external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
        end getDerTableValue;
      initial algorithm
        if tableOnFile then
          tableOnFileRead := readTableData(tableID, false, verboseRead);
        else
          tableOnFileRead := 1.;
        end if;
      equation
        if tableOnFile then
          assert(tableName <> "NoName", "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0, "tableOnFile = false and parameter table is an empty matrix");
        end if;
        if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
          for i in 1:n loop
            y[i] = getTableValueNoDer(tableID, i, u[i], tableOnFileRead);
          end for;
        else
          for i in 1:n loop
            y[i] = getTableValue(tableID, i, u[i], tableOnFileRead);
          end for;
        end if;
      end CombiTable1D;

      block CombiTable1Ds  "Table look-up in one dimension (matrix/file) with one input and n outputs" 
        extends Modelica.Blocks.Interfaces.SIMO(final nout = size(columns, 1));
        parameter Boolean tableOnFile = false "= true, if table is defined on file or in function usertab";
        parameter Real[:, :] table = fill(0.0, 0, 2) "Table matrix (grid = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
        parameter String tableName = "NoName" "Table name on file or in function usertab (see docu)";
        parameter String fileName = "NoName" "File where matrix is stored";
        parameter Boolean verboseRead = true "= true, if info message that file is loading is to be printed";
        parameter Integer[:] columns = 2:size(table, 2) "Columns of table to be interpolated";
        parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of table interpolation";
      protected
        Modelica.Blocks.Types.ExternalCombiTable1D tableID = Modelica.Blocks.Types.ExternalCombiTable1D(if tableOnFile then tableName else "NoName", if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName", table, columns, smoothness) "External table object";
        parameter Real tableOnFileRead(fixed = false) "= 1, if table was successfully read from file";

        function readTableData  "Read table data from ASCII text or MATLAB MAT-file" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Boolean forceRead = false "= true: Force reading of table data; = false: Only read, if not yet read.";
          input Boolean verboseRead "= true: Print info message; = false: No info message";
          output Real readSuccess "Table read success";
          external "C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"}, __ModelicaAssociation_Impure = true);
          annotation(__ModelicaAssociation_Impure = true); 
        end readTableData;

        function getTableValue  "Interpolate 1-dim. table defined by matrix" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable "Dummy input to ensure correct sorting of function calls" annotation(__OpenModelica_UnusedVariable = true);
          output Real y;
          external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"}, derivative(noDerivative = tableAvailable) = getDerTableValue);
          annotation(derivative(noDerivative = tableAvailable) = getDerTableValue); 
        end getTableValue;

        function getTableValueNoDer  "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable "Dummy input to ensure correct sorting of function calls" annotation(__OpenModelica_UnusedVariable = true);
          output Real y;
          external "C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
        end getTableValueNoDer;

        function getDerTableValue  "Derivative of interpolated 1-dim. table defined by matrix" 
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable "Dummy input to ensure correct sorting of function calls" annotation(__OpenModelica_UnusedVariable = true);
          input Real der_u;
          output Real der_y;
          external "C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
        end getDerTableValue;
      initial algorithm
        if tableOnFile then
          tableOnFileRead := readTableData(tableID, false, verboseRead);
        else
          tableOnFileRead := 1.;
        end if;
      equation
        if tableOnFile then
          assert(tableName <> "NoName", "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0, "tableOnFile = false and parameter table is an empty matrix");
        end if;
        if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
          for i in 1:nout loop
            y[i] = getTableValueNoDer(tableID, i, u, tableOnFileRead);
          end for;
        else
          for i in 1:nout loop
            y[i] = getTableValue(tableID, i, u, tableOnFileRead);
          end for;
        end if;
      end CombiTable1Ds;
    end Tables;

    package Types  "Library of constants and types with choices, especially to build menus" 
      extends Modelica.Icons.TypesPackage;
      type Smoothness = enumeration(LinearSegments "Table points are linearly interpolated", ContinuousDerivative "Table points are interpolated (by Akima splines) such that the first derivative is continuous", ConstantSegments "Table points are not interpolated, but the value from the previous abscissa point is returned", MonotoneContinuousDerivative1 "Table points are interpolated (by Fritsch-Butland splines) such that the monotonicity is preserved and the first derivative is continuous", MonotoneContinuousDerivative2 "Table points are interpolated (by Steffen splines) such that the monotonicity is preserved and the first derivative is continuous") "Enumeration defining the smoothness of table interpolation";
      type Init = enumeration(NoInit "No initialization (start values are used as guess values with fixed=false)", SteadyState "Steady state initialization (derivatives of states are zero)", InitialState "Initialization with initial states", InitialOutput "Initialization with initial outputs (and steady state of the states if possible)") "Enumeration defining initialization of a block" annotation(Evaluate = true);
      type SimpleController = enumeration(P "P controller", PI "PI controller", PD "PD controller", PID "PID controller") "Enumeration defining P, PI, PD, or PID simple controller type" annotation(Evaluate = true);

      class ExternalCombiTable1D  "External object of 1-dim. table defined by matrix" 
        extends ExternalObject;

        function constructor  "Initialize 1-dim. table defined by matrix" 
          extends Modelica.Icons.Function;
          input String tableName "Table name";
          input String fileName "File name";
          input Real[:, :] table;
          input Integer[:] columns;
          input Modelica.Blocks.Types.Smoothness smoothness;
          output ExternalCombiTable1D externalCombiTable1D;
          external "C" externalCombiTable1D = ModelicaStandardTables_CombiTable1D_init(tableName, fileName, table, size(table, 1), size(table, 2), columns, size(columns, 1), smoothness) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
        end constructor;

        function destructor  "Terminate 1-dim. table defined by matrix" 
          extends Modelica.Icons.Function;
          input ExternalCombiTable1D externalCombiTable1D;
          external "C" ModelicaStandardTables_CombiTable1D_close(externalCombiTable1D) annotation(Library = {"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
        end destructor;
      end ExternalCombiTable1D;
    end Types;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block" end Block;

      partial block BooleanBlock  "Basic graphical layout of Boolean block" end BooleanBlock;

      partial block PartialBooleanBlock  "Basic graphical layout of logical block" end PartialBooleanBlock;
    end Icons;
  end Blocks;

  package Mechanics  "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)" 
    extends Modelica.Icons.Package;

    package Rotational  "Library to model 1-dimensional, rotational mechanical systems" 
      extends Modelica.Icons.Package;

      package Components  "Components for 1D rotational mechanical drive trains" 
        extends Modelica.Icons.Package;

        model Inertia  "1D-rotational component with inertia" 
          Rotational.Interfaces.Flange_a flange_a "Left flange of shaft";
          Rotational.Interfaces.Flange_b flange_b "Right flange of shaft";
          parameter .Modelica.SIunits.Inertia J(min = 0, start = 1) "Moment of inertia";
          parameter StateSelect stateSelect = StateSelect.default "Priority to use phi and w as states" annotation(HideResult = true);
          .Modelica.SIunits.Angle phi(stateSelect = stateSelect) "Absolute rotation angle of component";
          .Modelica.SIunits.AngularVelocity w(stateSelect = stateSelect) "Absolute angular velocity of component (= der(phi))";
          .Modelica.SIunits.AngularAcceleration a "Absolute angular acceleration of component (= der(w))";
        equation
          phi = flange_a.phi;
          phi = flange_b.phi;
          w = der(phi);
          a = der(w);
          J * a = flange_a.tau + flange_b.tau;
        end Inertia;
      end Components;

      package Interfaces  "Connectors and partial models for 1D rotational mechanical components" 
        extends Modelica.Icons.InterfacesPackage;

        connector Flange_a  "One-dimensional rotational flange of a shaft (filled circle icon)" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of flange";
          flow .Modelica.SIunits.Torque tau "Cut torque in the flange";
        end Flange_a;

        connector Flange_b  "One-dimensional rotational flange of a shaft  (non-filled circle icon)" 
          .Modelica.SIunits.Angle phi "Absolute rotation angle of flange";
          flow .Modelica.SIunits.Torque tau "Cut torque in the flange";
        end Flange_b;
      end Interfaces;
    end Rotational;
  end Mechanics;

  package Thermal  "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow" 
    extends Modelica.Icons.Package;

    package HeatTransfer  "Library of 1-dimensional heat transfer with lumped elements" 
      extends Modelica.Icons.Package;

      package Interfaces  "Connectors and partial models" 
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort  "Thermal port for 1-dim. heat transfer" 
          Modelica.SIunits.Temperature T "Port temperature";
          flow Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
        end HeatPort;
      end Interfaces;
    end HeatTransfer;
  end Thermal;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisLeft  "Basic icon for mathematical function with y-axis on left side" end AxisLeft;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center" end AxisCenter;
    end Icons;

    function tan  "Tangent (u shall not be -pi/2, pi/2, 3*pi/2, ...)" 
      extends Modelica.Math.Icons.AxisCenter;
      input .Modelica.SIunits.Angle u;
      output Real y;
      external "builtin" y = tan(u);
    end tan;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function tanh  "Hyperbolic tangent" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = tanh(u);
    end tanh;

    function exp  "Exponential, base e" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;

    function log  "Natural (base e) logarithm (u shall be > 0)" 
      extends Modelica.Math.Icons.AxisLeft;
      input Real u;
      output Real y;
      external "builtin" y = log(u);
    end log;

    function log10  "Base 10 logarithm (u shall be > 0)" 
      extends Modelica.Math.Icons.AxisLeft;
      input Real u;
      output Real y;
      external "builtin" y = log10(u);
    end log10;
  end Math;

  package Utilities  "Library of utility functions dedicated to scripting (operating on files, streams, strings, system)" 
    extends Modelica.Icons.Package;

    package Files  "Functions to work with files and directories" 
      extends Modelica.Icons.FunctionsPackage;

      function loadResource  "Return the absolute path name of a URI or local file name" 
        extends Modelica.Utilities.Internal.PartialModelicaServices.ExternalReferences.PartialLoadResource;
        extends ModelicaServices.ExternalReferences.loadResource;
      end loadResource;
    end Files;

    package Streams  "Read from files and write to files" 
      extends Modelica.Icons.FunctionsPackage;

      function error  "Print error message and cancel all actions" 
        extends Modelica.Icons.Function;
        input String string "String to be printed to error message window";
        external "C" ModelicaError(string) annotation(Library = "ModelicaExternalC");
      end error;
    end Streams;

    package Strings  "Operations on strings" 
      extends Modelica.Icons.FunctionsPackage;

      function length  "Return length of string" 
        extends Modelica.Icons.Function;
        input String string;
        output Integer result "Number of characters of string";
        external "C" result = ModelicaStrings_length(string) annotation(Library = "ModelicaExternalC");
      end length;

      function isEmpty  "Return true if a string is empty (has only white space characters)" 
        extends Modelica.Icons.Function;
        input String string;
        output Boolean result "True, if string is empty";
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

      package Advanced  "Advanced scanning functions" 
        extends Modelica.Icons.FunctionsPackage;

        function skipWhiteSpace  "Scan white space" 
          extends Modelica.Icons.Function;
          input String string;
          input Integer startIndex(min = 1) = 1;
          output Integer nextIndex;
          external "C" nextIndex = ModelicaStrings_skipWhiteSpace(string, startIndex) annotation(Library = "ModelicaExternalC");
        end skipWhiteSpace;
      end Advanced;
    end Strings;

    package Internal  "Internal components that a user should usually not directly utilize" 
      extends Modelica.Icons.InternalPackage;

      partial package PartialModelicaServices  "Interfaces of components requiring a tool specific implementation" 
        extends Modelica.Icons.InternalPackage;

        package ExternalReferences  "Functions to access external resources" 
          extends Modelica.Icons.InternalPackage;

          partial function PartialLoadResource  "Interface for tool specific function to return the absolute path name of a URI or local file name" 
            extends Modelica.Icons.Function;
            input String uri "URI or local file name";
            output String fileReference "Absolute path name of file";
          end PartialLoadResource;
        end ExternalReferences;
      end PartialModelicaServices;
    end Internal;
  end Utilities;

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = ModelicaServices.Machine.small "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = ModelicaServices.Machine.inf "Biggest Real number such that inf and -inf are representable on the machine";
    final constant .Modelica.SIunits.Velocity c = 299792458 "Speed of light in vacuum";
    final constant .Modelica.SIunits.Acceleration g_n = 9.80665 "Standard acceleration of gravity on earth";
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7 "Magnetic constant";
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  "Icon for packages containing sources" 
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package TypesPackage  "Icon for packages containing type definitions" 
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package FunctionsPackage  "Icon for packages containing functions" 
      extends Modelica.Icons.Package;
    end FunctionsPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial package InternalPackage  "Icon for an internal package (indicating that the package should not be directly utilized by user)" end InternalPackage;

    partial function Function  "Icon for functions" end Function;
  end Icons;

  package SIunits  "Library of type and unit definitions based on SI units according to ISO 31-1992" 
    extends Modelica.Icons.Package;

    package Conversions  "Conversion functions to/from non SI units and type definitions of non SI units" 
      extends Modelica.Icons.Package;

      package NonSIunits  "Type definitions of non SI units" 
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use SIunits.TemperatureDifference)" annotation(absoluteValue = true);
      end NonSIunits;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Length = Real(final quantity = "Length", final unit = "m");
    type Area = Real(final quantity = "Area", final unit = "m2");
    type Volume = Real(final quantity = "Volume", final unit = "m3");
    type Time = Real(final quantity = "Time", final unit = "s");
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0);
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2");
    type Inertia = MomentOfInertia;
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar");
    type AbsolutePressure = Pressure(min = 0.0, nominal = 1e5);
    type Stress = Real(final unit = "Pa");
    type ShearModulus = Stress;
    type DynamicViscosity = Real(final quantity = "DynamicViscosity", final unit = "Pa.s", min = 0);
    type SurfaceTension = Real(final quantity = "SurfaceTension", final unit = "N/m");
    type Power = Real(final quantity = "Power", final unit = "W");
    type MassFlowRate = Real(quantity = "MassFlowRate", final unit = "kg/s");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue = true);
    type Temperature = ThermodynamicTemperature;
    type LinearExpansionCoefficient = Real(final quantity = "LinearExpansionCoefficient", final unit = "1/K");
    type Compressibility = Real(final quantity = "Compressibility", final unit = "1/Pa");
    type Heat = Real(final quantity = "Energy", final unit = "J");
    type HeatFlowRate = Real(final quantity = "Power", final unit = "W");
    type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)");
    type CoefficientOfHeatTransfer = Real(final quantity = "CoefficientOfHeatTransfer", final unit = "W/(m2.K)");
    type SpecificHeatCapacity = Real(final quantity = "SpecificHeatCapacity", final unit = "J/(kg.K)");
    type EntropyFlowRate = Real(final quantity = "EntropyFlowRate", final unit = "J/(K.s)");
    type SpecificEntropy = Real(final quantity = "SpecificEntropy", final unit = "J/(kg.K)");
    type InternalEnergy = Heat;
    type Enthalpy = Heat;
    type SpecificEnergy = Real(final quantity = "SpecificEnergy", final unit = "J/kg");
    type SpecificEnthalpy = SpecificEnergy;
    type DerDensityByEnthalpy = Real(final unit = "kg.s2/m5");
    type DerDensityByPressure = Real(final unit = "s2/m2");
    type MolarMass = Real(final quantity = "MolarMass", final unit = "kg/mol", min = 0);
    type MassFraction = Real(final quantity = "MassFraction", final unit = "1", min = 0, max = 1);
    type MoleFraction = Real(final quantity = "MoleFraction", final unit = "1", min = 0, max = 1);
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
    type PrandtlNumber = Real(final quantity = "PrandtlNumber", final unit = "1");
  end SIunits;
  annotation(version = "3.2.2", versionBuild = 3, versionDate = "2016-04-03", dateModified = "2016-04-03 08:44:41Z"); 
end Modelica;

package TILMedia  "TILMedia-Library with thermophysical properties of Fluids and Solids" 
  model Solid  "Solid model with T as independent variable" 
    replaceable model SolidType = TILMedia.SolidTypes.BaseSolid constrainedby TILMedia.SolidTypes.BaseSolid;
    constant .Modelica.SIunits.Density d = solid.d "Density";
    input .Modelica.SIunits.Temperature T "Temperature";
    .Modelica.SIunits.SpecificHeatCapacity cp "Heat capacity";
    .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
  protected
    SolidType solid(final T = T);
  equation
    cp = solid.cp;
    lambda = solid.lambda;
    annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
  end Solid;

  model VLEFluid_ph  "VLE-Fluid model describing super-critical, subcooled, superheated fluid including the vapor liquid equilibrium (p, h and xi as independent variables)" 
    replaceable parameter TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType constrainedby TILMedia.VLEFluidTypes.BaseVLEFluid;
    parameter Boolean stateSelectPreferForInputs = false "=true, StateSelect.prefer is set for input variables" annotation(Evaluate = true);
    parameter Boolean computeTransportProperties = false "=true, if transport properties are calculated";
    parameter Boolean interpolateTransportProperties = true "Interpolate transport properties in vapor dome";
    parameter Boolean computeSurfaceTension = true;
    parameter Boolean computeVLEAdditionalProperties = false "Compute detailed vapor liquid equilibrium properties" annotation(Evaluate = true);
    parameter Boolean computeVLETransportProperties = false "Compute detailed vapor liquid equilibrium transport properties" annotation(Evaluate = true);
    parameter Boolean deactivateTwoPhaseRegion = false "Deactivate calculation of two phase region" annotation(Evaluate = true);
    Modelica.SIunits.Density d "Density";
    input Modelica.SIunits.SpecificEnthalpy h(stateSelect = if stateSelectPreferForInputs then StateSelect.prefer else StateSelect.default) "Specific enthalpy";
    input Modelica.SIunits.AbsolutePressure p(stateSelect = if stateSelectPreferForInputs then StateSelect.prefer else StateSelect.default) "Pressure";
    Modelica.SIunits.SpecificEntropy s "Specific entropy";
    Modelica.SIunits.Temperature T "Temperature";
    input Modelica.SIunits.MassFraction[vleFluidType.nc - 1] xi(each stateSelect = if stateSelectPreferForInputs then StateSelect.prefer else StateSelect.default) = vleFluidType.xi_default "Mass Fraction of Component i";
    .Modelica.SIunits.MoleFraction[vleFluidType.nc - 1] x "Mole fraction";
    .Modelica.SIunits.MolarMass M "Average molar mass";
    .Modelica.SIunits.MassFraction q "Steam mass fraction (quality)";
    .Modelica.SIunits.SpecificHeatCapacity cp "Specific isobaric heat capacity cp";
    .Modelica.SIunits.SpecificHeatCapacity cv "Specific isochoric heat capacity cv";
    .Modelica.SIunits.LinearExpansionCoefficient beta "Isobaric thermal expansion coefficient";
    .Modelica.SIunits.Compressibility kappa "Isothermal compressibility";
    .Modelica.SIunits.Velocity w "Speed of sound";
    .Modelica.SIunits.DerDensityByEnthalpy drhodh_pxi "1st derivative of density wrt specific enthalpy at constant pressure and mass fraction";
    .Modelica.SIunits.DerDensityByPressure drhodp_hxi "1st derivative of density wrt pressure at specific enthalpy and mass fraction";
    TILMedia.Internals.Units.DensityDerMassFraction[vleFluidType.nc - 1] drhodxi_ph "1st derivative of density wrt mass fraction of water at constant pressure and specific enthalpy";
    Real gamma "Heat capacity ratio aka isentropic expansion factor";
    .Modelica.SIunits.MolarMass[vleFluidType.nc] M_i "Molar mass of component i";
    TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer = VLEFluidObjectFunctions.VLEFluidPointer(vleFluidType.concatVLEFluidName, computeFlags, vleFluidType.mixingRatio_propertyCalculation[1:end - 1] / sum(vleFluidType.mixingRatio_propertyCalculation), vleFluidType.nc_propertyCalculation, vleFluidType.nc, redirectorOutput) "Pointer to external medium memory";
    TILMedia.Internals.CriticalDataRecord crit "Critical data record";
    TILMedia.Internals.TransportPropertyRecord transp(eta(min = if computeTransportProperties then 0 else -1)) "Transport property record";
    TILMedia.Internals.VLERecord VLE(final nc = vleFluidType.nc);
    TILMedia.Internals.AdditionalVLERecord VLEAdditional;
    TILMedia.Internals.VLETransportPropertyRecord VLETransp(eta_l(min = if computeVLETransportProperties then 0 else -1), eta_v(min = if computeVLETransportProperties then 0 else -1));
  protected
    constant Real invalidValue = -1;
    final parameter Integer computeFlags = Internals.calcComputeFlags(computeTransportProperties, interpolateTransportProperties, computeSurfaceTension, deactivateTwoPhaseRegion);
    parameter Integer redirectorOutput = Internals.redirectModelicaFormatMessage();
  equation
    M_i = Internals.VLEFluidObjectFunctions.molarMass_nc(vleFluidType.nc, vleFluidPointer);
    (crit.d, crit.h, crit.p, crit.s, crit.T) = Internals.VLEFluidObjectFunctions.cricondenbar_xi(xi, vleFluidPointer);
    M = 1 / sum(cat(1, xi, {1 - sum(xi)}) ./ M_i);
    xi = x .* M_i[1:end - 1] * sum(cat(1, xi, {1 - sum(xi)}) ./ M_i);
    d = Internals.VLEFluidObjectFunctions.density_phxi(p, h, xi, vleFluidPointer);
    s = Internals.VLEFluidObjectFunctions.specificEntropy_phxi(p, h, xi, vleFluidPointer);
    T = Internals.VLEFluidObjectFunctions.temperature_phxi(p, h, xi, vleFluidPointer);
    (q, cp, cv, beta, kappa, drhodp_hxi, drhodh_pxi, drhodxi_ph, w, gamma) = Internals.VLEFluidObjectFunctions.additionalProperties_phxi(p, h, xi, vleFluidPointer);
    if vleFluidType.nc == 1 then
      (VLE.d_l, VLE.h_l, VLE.p_l, VLE.s_l, VLE.T_l, VLE.xi_l, VLE.d_v, VLE.h_v, VLE.p_v, VLE.s_v, VLE.T_v, VLE.xi_v) = Internals.VLEFluidObjectFunctions.VLEProperties_phxi(p, -1, zeros(0), vleFluidPointer);
    else
      (VLE.d_l, VLE.h_l, VLE.p_l, VLE.s_l, VLE.T_l, VLE.xi_l, VLE.d_v, VLE.h_v, VLE.p_v, VLE.s_v, VLE.T_v, VLE.xi_v) = Internals.VLEFluidObjectFunctions.VLEProperties_phxi(p, h, xi, vleFluidPointer);
    end if;
    if computeTransportProperties then
      transp = Internals.VLEFluidObjectFunctions.transportPropertyRecord_phxi(p, h, xi, vleFluidPointer);
    else
      transp = Internals.TransportPropertyRecord(invalidValue, invalidValue, invalidValue, invalidValue);
    end if;
    if computeVLEAdditionalProperties then
      if vleFluidType.nc == 1 then
        (VLEAdditional.cp_l, VLEAdditional.beta_l, VLEAdditional.kappa_l, VLEAdditional.cp_v, VLEAdditional.beta_v, VLEAdditional.kappa_v) = Internals.VLEFluidObjectFunctions.VLEAdditionalProperties_phxi(p, -1, zeros(vleFluidType.nc - 1), vleFluidPointer);
      else
        (VLEAdditional.cp_l, VLEAdditional.beta_l, VLEAdditional.kappa_l, VLEAdditional.cp_v, VLEAdditional.beta_v, VLEAdditional.kappa_v) = Internals.VLEFluidObjectFunctions.VLEAdditionalProperties_phxi(p, h, xi, vleFluidPointer);
      end if;
    else
      VLEAdditional.cp_l = invalidValue;
      VLEAdditional.beta_l = invalidValue;
      VLEAdditional.kappa_l = invalidValue;
      VLEAdditional.cp_v = invalidValue;
      VLEAdditional.beta_v = invalidValue;
      VLEAdditional.kappa_v = invalidValue;
    end if;
    if computeVLETransportProperties then
      if vleFluidType.nc == 1 then
        (VLETransp.Pr_l, VLETransp.Pr_v, VLETransp.lambda_l, VLETransp.lambda_v, VLETransp.eta_l, VLETransp.eta_v) = Internals.VLEFluidObjectFunctions.VLETransportPropertyRecord_phxi(p, -1, zeros(0), vleFluidPointer);
      else
        (VLETransp.Pr_l, VLETransp.Pr_v, VLETransp.lambda_l, VLETransp.lambda_v, VLETransp.eta_l, VLETransp.eta_v) = Internals.VLEFluidObjectFunctions.VLETransportPropertyRecord_phxi(p, h, xi, vleFluidPointer);
      end if;
    else
      VLETransp.Pr_l = invalidValue;
      VLETransp.Pr_v = invalidValue;
      VLETransp.lambda_l = invalidValue;
      VLETransp.lambda_v = invalidValue;
      VLETransp.eta_l = invalidValue;
      VLETransp.eta_v = invalidValue;
    end if;
    annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
  end VLEFluid_ph;

  model VLEFluid_pT  "VLE-Fluid model describing super-critical, subcooled, superheated fluid including the vapor liquid equilibrium (p, T and xi as independent variables)" 
    replaceable parameter TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType constrainedby TILMedia.VLEFluidTypes.BaseVLEFluid;
    parameter Boolean stateSelectPreferForInputs = false "=true, StateSelect.prefer is set for input variables" annotation(Evaluate = true);
    parameter Boolean computeTransportProperties = false "=true, if transport properties are calculated";
    parameter Boolean interpolateTransportProperties = true "Interpolate transport properties in vapor dome";
    parameter Boolean computeSurfaceTension = true;
    parameter Boolean computeVLEAdditionalProperties = false "Compute detailed vapor liquid equilibrium properties" annotation(Evaluate = true);
    parameter Boolean computeVLETransportProperties = false "Compute detailed vapor liquid equilibrium transport properties" annotation(Evaluate = true);
    parameter Boolean deactivateTwoPhaseRegion = false "Deactivate calculation of two phase region" annotation(Evaluate = true);
    Modelica.SIunits.Density d "Density";
    Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
    input Modelica.SIunits.AbsolutePressure p(stateSelect = if stateSelectPreferForInputs then StateSelect.prefer else StateSelect.default) "Pressure";
    Modelica.SIunits.SpecificEntropy s "Specific entropy";
    input Modelica.SIunits.Temperature T(stateSelect = if stateSelectPreferForInputs then StateSelect.prefer else StateSelect.default) "Temperature";
    input Modelica.SIunits.MassFraction[vleFluidType.nc - 1] xi(each stateSelect = if stateSelectPreferForInputs then StateSelect.prefer else StateSelect.default) = vleFluidType.xi_default "Mass Fraction of Component i";
    .Modelica.SIunits.MoleFraction[vleFluidType.nc - 1] x "Mole fraction";
    .Modelica.SIunits.MolarMass M "Average molar mass";
    .Modelica.SIunits.MassFraction q "Steam mass fraction (quality)";
    .Modelica.SIunits.SpecificHeatCapacity cp "Specific isobaric heat capacity cp";
    .Modelica.SIunits.SpecificHeatCapacity cv "Specific isochoric heat capacity cv";
    .Modelica.SIunits.LinearExpansionCoefficient beta "Isobaric thermal expansion coefficient";
    .Modelica.SIunits.Compressibility kappa "Isothermal compressibility";
    .Modelica.SIunits.Velocity w "Speed of sound";
    .Modelica.SIunits.DerDensityByEnthalpy drhodh_pxi "1st derivative of density wrt specific enthalpy at constant pressure and mass fraction";
    .Modelica.SIunits.DerDensityByPressure drhodp_hxi "1st derivative of density wrt pressure at specific enthalpy and mass fraction";
    TILMedia.Internals.Units.DensityDerMassFraction[vleFluidType.nc - 1] drhodxi_ph "1st derivative of density wrt mass fraction of water at constant pressure and specific enthalpy";
    Real gamma "Heat capacity ratio aka isentropic expansion factor";
    .Modelica.SIunits.MolarMass[vleFluidType.nc] M_i "Molar mass of component i";
    TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer = VLEFluidObjectFunctions.VLEFluidPointer(vleFluidType.concatVLEFluidName, computeFlags, vleFluidType.mixingRatio_propertyCalculation[1:end - 1] / sum(vleFluidType.mixingRatio_propertyCalculation), vleFluidType.nc_propertyCalculation, vleFluidType.nc, redirectorOutput) "Pointer to external medium memory";
    TILMedia.Internals.CriticalDataRecord crit "Critical data record";
    TILMedia.Internals.TransportPropertyRecord transp(eta(min = if computeTransportProperties then 0 else -1)) "Transport property record";
    TILMedia.Internals.VLERecord VLE(final nc = vleFluidType.nc);
    TILMedia.Internals.AdditionalVLERecord VLEAdditional;
    TILMedia.Internals.VLETransportPropertyRecord VLETransp(eta_l(min = if computeVLETransportProperties then 0 else -1), eta_v(min = if computeVLETransportProperties then 0 else -1));
  protected
    constant Real invalidValue = -1;
    final parameter Integer computeFlags = Internals.calcComputeFlags(computeTransportProperties, interpolateTransportProperties, computeSurfaceTension, deactivateTwoPhaseRegion);
    parameter Integer redirectorOutput = Internals.redirectModelicaFormatMessage();
  equation
    M_i = Internals.VLEFluidObjectFunctions.molarMass_nc(vleFluidType.nc, vleFluidPointer);
    (crit.d, crit.h, crit.p, crit.s, crit.T) = Internals.VLEFluidObjectFunctions.cricondenbar_xi(xi, vleFluidPointer);
    M = 1 / sum(cat(1, xi, {1 - sum(xi)}) ./ M_i);
    xi = x .* M_i[1:end - 1] * sum(cat(1, xi, {1 - sum(xi)}) ./ M_i);
    d = Internals.VLEFluidObjectFunctions.density_pTxi(p, T, xi, vleFluidPointer);
    h = Internals.VLEFluidObjectFunctions.specificEnthalpy_pTxi(p, T, xi, vleFluidPointer);
    s = Internals.VLEFluidObjectFunctions.specificEntropy_pTxi(p, T, xi, vleFluidPointer);
    (q, cp, cv, beta, kappa, drhodp_hxi, drhodh_pxi, drhodxi_ph, w, gamma) = Internals.VLEFluidObjectFunctions.additionalProperties_phxi(p, h, xi, vleFluidPointer);
    if vleFluidType.nc == 1 then
      (VLE.d_l, VLE.h_l, VLE.p_l, VLE.s_l, VLE.T_l, VLE.xi_l, VLE.d_v, VLE.h_v, VLE.p_v, VLE.s_v, VLE.T_v, VLE.xi_v) = Internals.VLEFluidObjectFunctions.VLEProperties_phxi(p, -1, zeros(0), vleFluidPointer);
    else
      (VLE.d_l, VLE.h_l, VLE.p_l, VLE.s_l, VLE.T_l, VLE.xi_l, VLE.d_v, VLE.h_v, VLE.p_v, VLE.s_v, VLE.T_v, VLE.xi_v) = Internals.VLEFluidObjectFunctions.VLEProperties_phxi(p, h, xi, vleFluidPointer);
    end if;
    if computeTransportProperties then
      transp = Internals.VLEFluidObjectFunctions.transportPropertyRecord_phxi(p, h, xi, vleFluidPointer);
    else
      transp = Internals.TransportPropertyRecord(invalidValue, invalidValue, invalidValue, invalidValue);
    end if;
    if computeVLEAdditionalProperties then
      if vleFluidType.nc == 1 then
        (VLEAdditional.cp_l, VLEAdditional.beta_l, VLEAdditional.kappa_l, VLEAdditional.cp_v, VLEAdditional.beta_v, VLEAdditional.kappa_v) = Internals.VLEFluidObjectFunctions.VLEAdditionalProperties_phxi(p, -1, zeros(vleFluidType.nc - 1), vleFluidPointer);
      else
        (VLEAdditional.cp_l, VLEAdditional.beta_l, VLEAdditional.kappa_l, VLEAdditional.cp_v, VLEAdditional.beta_v, VLEAdditional.kappa_v) = Internals.VLEFluidObjectFunctions.VLEAdditionalProperties_phxi(p, h, xi, vleFluidPointer);
      end if;
    else
      VLEAdditional.cp_l = invalidValue;
      VLEAdditional.beta_l = invalidValue;
      VLEAdditional.kappa_l = invalidValue;
      VLEAdditional.cp_v = invalidValue;
      VLEAdditional.beta_v = invalidValue;
      VLEAdditional.kappa_v = invalidValue;
    end if;
    if computeVLETransportProperties then
      if vleFluidType.nc == 1 then
        (VLETransp.Pr_l, VLETransp.Pr_v, VLETransp.lambda_l, VLETransp.lambda_v, VLETransp.eta_l, VLETransp.eta_v) = Internals.VLEFluidObjectFunctions.VLETransportPropertyRecord_phxi(p, -1, zeros(0), vleFluidPointer);
      else
        (VLETransp.Pr_l, VLETransp.Pr_v, VLETransp.lambda_l, VLETransp.lambda_v, VLETransp.eta_l, VLETransp.eta_v) = Internals.VLEFluidObjectFunctions.VLETransportPropertyRecord_phxi(p, h, xi, vleFluidPointer);
      end if;
    else
      VLETransp.Pr_l = invalidValue;
      VLETransp.Pr_v = invalidValue;
      VLETransp.lambda_l = invalidValue;
      VLETransp.lambda_v = invalidValue;
      VLETransp.eta_l = invalidValue;
      VLETransp.eta_v = invalidValue;
    end if;
    annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
  end VLEFluid_pT;

  package GasTypes  "Gases and Gas Vapor mixtures, that can be used or composed in TILMedia" 
    extends TILMedia.Internals.ClassTypes.ModelPackage;

    record BaseGas  "Base record for gas definitions" 
      extends Internals.ClassTypes.Record;
      constant Boolean fixedMixingRatio "Treat medium as pseudo pure in Modelica if it is a mixture" annotation(HideResult = true);
      constant Integer nc_propertyCalculation(min = 1) "Number of components for fluid property calculations" annotation(HideResult = true);
      final constant Integer nc = if fixedMixingRatio then 1 else nc_propertyCalculation "Number of components in Modelica models" annotation(Evaluate = true, HideResult = true);
      constant Internals.GasName[nc_propertyCalculation] gasNames "Array of gas names e.g. {\"gasName\"} for pure component";
      constant Real[nc_propertyCalculation] mixingRatio_propertyCalculation "Mixing ratio for fluid property calculation (={1} for pure components)" annotation(HideResult = true);
      constant Real[nc] defaultMixingRatio = if fixedMixingRatio then {1} else mixingRatio_propertyCalculation "Default composition for models in Modelica (={1} for pure components)" annotation(HideResult = true);
      constant Real[nc - 1] xi_default = defaultMixingRatio[1:end - 1] / sum(defaultMixingRatio) "Default mass fractions" annotation(HideResult = true);
      constant Integer condensingIndex "Index of condensing component (=0, if no condensation is desired)" annotation(HideResult = true);
      constant String concatGasName = TILMedia.Internals.concatNames(gasNames);
      constant Integer ID = 0 "ID is used to map the selected Gas to the sim.cumulatedGasMass array item" annotation(HideResult = true);
    end BaseGas;

    record FlueGasTILMedia  "Flue gas TILMedia (Ash,CO,CO2,SO2,N2,O2,NO,H2O,NH3,Ar)" 
      extends TILMedia.GasTypes.BaseGas(final fixedMixingRatio = false, final nc_propertyCalculation = 10, final gasNames = {"TILMedia.Ash", "TILMediaXTR.Carbon_Monoxide", "TILMediaXTR.Carbon_Dioxide", "TILMediaXTR.Sulfur_Dioxide", "TILMediaXTR.Nitrogen", "TILMediaXTR.Oxygen", "TILMediaXTR.Nitrous_Oxide", "TILMediaXTR.Water", "TILMediaXTR.Ammonia", "TILMediaXTR.Argon"}, final condensingIndex = 8, final mixingRatio_propertyCalculation = {0.001, 0.001, 0.001, 0.001, 1, 0.001, 0.001, 0.001, 0.001, 0.001});
    end FlueGasTILMedia;

    record MoistAirMixture  "Moist air gas mixture with a condensing component" 
      extends TILMedia.GasTypes.BaseGas(final fixedMixingRatio = false, final nc_propertyCalculation = 10, final gasNames = {"TILMedia.Ash", "TILMediaXTR.Carbon_Monoxide", "TILMediaXTR.Carbon_Dioxide", "TILMediaXTR.Sulfur_Dioxide", "TILMediaXTR.Nitrogen", "TILMediaXTR.Oxygen", "TILMediaXTR.Nitrous_Oxide", "TILMediaXTR.Water", "TILMediaXTR.Ammonia", "TILMediaXTR.Argon"}, final condensingIndex = 8, final mixingRatio_propertyCalculation = {0.0, 0.0, 0.00058, 0.0, 0.75419, 0.23135, 0.0, 0.001, 0.0, 0.01288});
    end MoistAirMixture;
  end GasTypes;

  package SolidTypes  "Solid types that can be used in TILMedia" 
    extends TILMedia.Internals.ClassTypes.ModelPackage;

    partial model BaseSolid  "Base model for solid definitions" 
      constant .Modelica.SIunits.SpecificHeatCapacity cp_nominal "Specific heat capacity at standard reference point";
      constant .Modelica.SIunits.ThermalConductivity lambda_nominal "Thermal conductivity at standard reference point";
      constant Real nu_nominal "Poisson's ratio at standard reference point";
      constant ClaRa.Basics.Units.ElasticityModule E_nominal "Elasticity module of steel at standard reference point";
      constant ClaRa.Basics.Units.HeatExpansionRateLinear beta_nominal "Linear heat expansion coefficient at standard reference point";
      constant .Modelica.SIunits.ShearModulus G_nominal "Shear modulus at standard reference point";
      constant .Modelica.SIunits.Density d "Density";
      input .Modelica.SIunits.Temperature T "Temperature";
      .Modelica.SIunits.SpecificHeatCapacity cp "Heat capacity";
      .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
      Real nu "Poisson's ratio";
      ClaRa.Basics.Units.ElasticityModule E "Elasticity module of steel";
      ClaRa.Basics.Units.HeatExpansionRateLinear beta "Linear heat expansion coefficient";
      ClaRa.Basics.Units.ShearModulus G "Shear modulus";
    end BaseSolid;

    model TILMedia_Aluminum  "TILMedia.Aluminum" 
      extends TILMedia.SolidTypes.BaseSolid(final d = 2700.0, final cp_nominal = 920.0, final lambda_nominal = 215.0, final nu_nominal = -1, final E_nominal = -1, final G_nominal = -1, final beta_nominal = -1);
    equation
      cp = cp_nominal;
      lambda = lambda_nominal;
      nu = nu_nominal;
      E = E_nominal;
      G = G_nominal;
      beta = beta_nominal;
    end TILMedia_Aluminum;

    model TILMedia_Steel  "TILMedia.Steel" 
      extends TILMedia.SolidTypes.BaseSolid(final d = 7800.0, final cp_nominal = 490.0, final lambda_nominal = 40.0, final nu_nominal = -1, final E_nominal = -1, final G_nominal = -1, final beta_nominal = -1);
    equation
      cp = cp_nominal;
      lambda = lambda_nominal;
      nu = nu_nominal;
      E = E_nominal;
      G = G_nominal;
      beta = beta_nominal;
    end TILMedia_Steel;

    model InsulationOrstechLSP_H_const  "Orstech Insulation" 
      extends TILMedia.SolidTypes.BaseSolid(final d = 100.0, final cp_nominal = 800.0, final lambda_nominal = 0.1, final nu_nominal = -1, final E_nominal = -1, final G_nominal = -1, final beta_nominal = -1);
    equation
      cp = cp_nominal;
      lambda = lambda_nominal;
      nu = nu_nominal;
      E = E_nominal;
      G = G_nominal;
      beta = beta_nominal;
    end InsulationOrstechLSP_H_const;
  end SolidTypes;

  package VLEFluidFunctions  "Package for calculation of VLEFluid properties with a functional call" 
    extends TILMedia.Internals.ClassTypes.ModelPackage;

    function density_phxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.Density d "Density";
    algorithm
      d := TILMedia.Internals.VLEFluidFunctions.density_phxi(p, h, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end density_phxi;

    function specificEntropy_phxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
    algorithm
      s := TILMedia.Internals.VLEFluidFunctions.specificEntropy_phxi(p, h, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end specificEntropy_phxi;

    function specificIsobaricHeatCapacity_phxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.SpecificHeatCapacity cp "Specific isobaric heat capacity cp";
    algorithm
      cp := TILMedia.Internals.VLEFluidFunctions.specificIsobaricHeatCapacity_phxi(p, h, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end specificIsobaricHeatCapacity_phxi;

    function thermalConductivity_phxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
    algorithm
      lambda := TILMedia.Internals.VLEFluidFunctions.thermalConductivity_phxi(p, h, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end thermalConductivity_phxi;

    function dynamicViscosity_phxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.DynamicViscosity eta "Dynamic viscosity";
    algorithm
      eta := TILMedia.Internals.VLEFluidFunctions.dynamicViscosity_phxi(p, h, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end dynamicViscosity_phxi;

    function specificEnthalpy_psxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := TILMedia.Internals.VLEFluidFunctions.specificEnthalpy_psxi(p, s, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end specificEnthalpy_psxi;

    function specificEnthalpy_pTxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.Temperature T "Temperature";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
    algorithm
      h := TILMedia.Internals.VLEFluidFunctions.specificEnthalpy_pTxi(p, T, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end specificEnthalpy_pTxi;

    function dewDensity_pxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.Density d_dew "Density at dew point";
    algorithm
      d_dew := TILMedia.Internals.VLEFluidFunctions.dewDensity_pxi(p, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end dewDensity_pxi;

    function bubbleDensity_pxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.Density d_bubble "Density at bubble point";
    algorithm
      d_bubble := TILMedia.Internals.VLEFluidFunctions.bubbleDensity_pxi(p, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end bubbleDensity_pxi;

    function dewSpecificEnthalpy_pxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.SpecificEnthalpy h_dew "Specific enthalpy at dew point";
    algorithm
      h_dew := TILMedia.Internals.VLEFluidFunctions.dewSpecificEnthalpy_pxi(p, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end dewSpecificEnthalpy_pxi;

    function bubbleSpecificEnthalpy_pxi  
      input TILMedia.VLEFluidTypes.BaseVLEFluid vleFluidType "VLEFluid type" annotation(choicesAllMatching = true);
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.MassFraction[:] xi = zeros(vleFluidType.nc - 1) "Mass fractions of the first nc-1 components";
      output .Modelica.SIunits.SpecificEnthalpy h_bubble "Specific enthalpy at bubble point";
    algorithm
      h_bubble := TILMedia.Internals.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(p, xi, vleFluidType.concatVLEFluidName, vleFluidType.nc + TILMedia.Internals.redirectModelicaFormatMessage());
      annotation(Inline = true); 
    end bubbleSpecificEnthalpy_pxi;
  end VLEFluidFunctions;

  package VLEFluidObjectFunctions  "Package for calculation of VLEFLuid properties with a functional call, referencing existing external objects for highspeed evaluation" 
    extends TILMedia.Internals.ClassTypes.ModelPackage;

    class VLEFluidPointer  
      extends ExternalObject;

      function constructor  "get memory" 
        input String vleFluidName;
        input Integer flags;
        input Real[:] xi;
        input Integer nc_propertyCalculation;
        input Integer nc;
        input Integer redirectorDummy;
        output VLEFluidPointer vleFluidPointer;
        external "C" vleFluidPointer = TILMedia_VLEFluid_createExternalObject(vleFluidName, flags, xi, nc_propertyCalculation, nc) annotation(__iti_dllNoExport = true, Include = "void* TILMedia_VLEFluid_createExternalObject(const char*, int, double*, int, int);", Library = "TILMedia130ClaRa");
      end constructor;

      function destructor  "free memory" 
        input VLEFluidPointer vleFluidPointer;
        external "C" TILMedia_VLEFluid_destroyExternalObject(vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_destroyExternalObject(void*);", Library = "TILMedia130ClaRa");
      end destructor;
    end VLEFluidPointer;

    function density_phxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.Density d "Density";
      external "C" d = TILMedia_VLEFluidObjectFunctions_density_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_density_phxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end density_phxi;

    function specificEntropy_phxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
      external "C" s = TILMedia_VLEFluidObjectFunctions_specificEntropy_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_specificEntropy_phxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end specificEntropy_phxi;

    function temperature_phxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.Temperature T "Temperature";
      external "C" T = TILMedia_VLEFluidObjectFunctions_temperature_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_temperature_phxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end temperature_phxi;

    function steamMassFraction_phxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.MassFraction q "Vapor quality (steam mass fraction)";
      external "C" q = TILMedia_VLEFluidObjectFunctions_steamMassFraction_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_steamMassFraction_phxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end steamMassFraction_phxi;

    function specificIsobaricHeatCapacity_phxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.SpecificHeatCapacity cp "Specific isobaric heat capacity cp";
      external "C" cp = TILMedia_VLEFluidObjectFunctions_specificIsobaricHeatCapacity_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_specificIsobaricHeatCapacity_phxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end specificIsobaricHeatCapacity_phxi;

    function thermalConductivity_phxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
      external "C" lambda = TILMedia_VLEFluidObjectFunctions_thermalConductivity_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_thermalConductivity_phxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end thermalConductivity_phxi;

    function dynamicViscosity_phxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.DynamicViscosity eta "Dynamic viscosity";
      external "C" eta = TILMedia_VLEFluidObjectFunctions_dynamicViscosity_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_dynamicViscosity_phxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end dynamicViscosity_phxi;

    function specificEnthalpy_psxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      external "C" h = TILMedia_VLEFluidObjectFunctions_specificEnthalpy_psxi(p, s, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_specificEnthalpy_psxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end specificEnthalpy_psxi;

    function specificEnthalpy_pTxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.Temperature T "Temperature";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
      external "C" h = TILMedia_VLEFluidObjectFunctions_specificEnthalpy_pTxi(p, T, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_specificEnthalpy_pTxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end specificEnthalpy_pTxi;

    function specificEntropy_pTxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.Temperature T "Temperature";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
      external "C" s = TILMedia_VLEFluidObjectFunctions_specificEntropy_pTxi(p, T, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_specificEntropy_pTxi(double, double, double*,void*);", Library = "TILMedia130ClaRa");
    end specificEntropy_pTxi;

    function bubblePressure_Txi  
      input .Modelica.SIunits.Temperature T "Temperature";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.AbsolutePressure p_bubble "Pressure at bubble point";
      external "C" p_bubble = TILMedia_VLEFluidObjectFunctions_bubblePressure_Txi(T, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_bubblePressure_Txi(double, double*,void*);", Library = "TILMedia130ClaRa");
    end bubblePressure_Txi;

    function dewSpecificEnthalpy_pxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.SpecificEnthalpy h_dew "Specific enthalpy at dew point";
      external "C" h_dew = TILMedia_VLEFluidObjectFunctions_dewSpecificEnthalpy_pxi(p, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_dewSpecificEnthalpy_pxi(double, double*,void*);", Library = "TILMedia130ClaRa");
    end dewSpecificEnthalpy_pxi;

    function bubbleSpecificEnthalpy_pxi  
      input .Modelica.SIunits.AbsolutePressure p "Pressure";
      input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
      input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
      output .Modelica.SIunits.SpecificEnthalpy h_bubble "Specific enthalpy at bubble point";
      external "C" h_bubble = TILMedia_VLEFluidObjectFunctions_bubbleSpecificEnthalpy_pxi(p, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidObjectFunctions_bubbleSpecificEnthalpy_pxi(double, double*,void*);", Library = "TILMedia130ClaRa");
    end bubbleSpecificEnthalpy_pxi;
  end VLEFluidObjectFunctions;

  package VLEFluidTypes  "VLEFluids and VLEFluid mixtures, that can be used or composed in TILMedia" 
    extends TILMedia.Internals.ClassTypes.ModelPackage;

    record BaseVLEFluid  "Base record for VLE Fluid definitions" 
      extends Internals.ClassTypes.Record;
      constant Boolean fixedMixingRatio "Treat medium as pseudo pure in Modelica if it is a mixture" annotation(HideResult = true);
      constant Integer nc_propertyCalculation(min = 1) "Number of components for fluid property calculations" annotation(HideResult = true);
      final constant Integer nc = if fixedMixingRatio then 1 else nc_propertyCalculation "Number of components in Modelica models" annotation(Evaluate = true, HideResult = true);
      constant Internals.VLEFluidName[nc_propertyCalculation] vleFluidNames "Array of VLEFluid names e.g. {\"vleFluidName\"} for pure component";
      constant String concatVLEFluidName = TILMedia.Internals.concatNames(vleFluidNames);
      constant Real[nc_propertyCalculation] mixingRatio_propertyCalculation "Mixing ratio for fluid property calculation (={1} for pure components)" annotation(HideResult = true);
      constant Real[nc] defaultMixingRatio = if fixedMixingRatio then {1} else mixingRatio_propertyCalculation "Default composition for models in Modelica (={1} for pure components)" annotation(HideResult = true);
      constant Real[nc - 1] xi_default = defaultMixingRatio[1:end - 1] / sum(defaultMixingRatio) "Default mass fractions" annotation(HideResult = true);
      constant Integer ID = 0 "ID is used to map the selected VLEFluid to the sim.cumulatedVLEFluidMass array item" annotation(HideResult = true);
    end BaseVLEFluid;

    record TILMedia_InterpolatedWater  "Water, IAPWS1995, Linear Interpolation, table based calculation (TLK Implementation)" 
      extends TILMedia.VLEFluidTypes.BaseVLEFluid(final fixedMixingRatio = true, final nc_propertyCalculation = 1, final vleFluidNames = {""}, final mixingRatio_propertyCalculation = {1}, final concatVLEFluidName = "Interpolation.LoadLinear(filename=\"" + Modelica.Utilities.Files.loadResource("Modelica://TILMedia/Resources/Water.dat") + "\")");
    end TILMedia_InterpolatedWater;

    record TILMedia_SplineWater  "Water, IAPWS1995, Bicubic Spline Interpolation, table based calculation (TLK Implementation)" 
      extends TILMedia.VLEFluidTypes.BaseVLEFluid(final fixedMixingRatio = true, final nc_propertyCalculation = 1, final vleFluidNames = {"Interpolation.LoadSpline(filename=\"" + Modelica.Utilities.Files.loadResource("Modelica://TILMedia/Resources/Water_Spline.dat") + "\")"}, final mixingRatio_propertyCalculation = {1});
    end TILMedia_SplineWater;
  end VLEFluidTypes;

  package Internals  "Internal functions" 
    package ClassTypes  "Icon definitions" 
      partial class ModelPackage  end ModelPackage;

      partial record Record  "Partial Record" end Record;
    end ClassTypes;

    package VLEFluidObjectFunctions  
      extends TILMedia.Internals.ClassTypes.ModelPackage;

      function additionalProperties_phxi  
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output Modelica.SIunits.MassFraction x "Steam mass fraction";
        output Modelica.SIunits.SpecificHeatCapacity cp "Specific heat capacity cp";
        output Modelica.SIunits.SpecificHeatCapacity cv "Specific heat capacity cv";
        output Modelica.SIunits.LinearExpansionCoefficient beta "Isobaric expansion coefficient";
        output Modelica.SIunits.Compressibility kappa "Isothermal compressibility";
        output TILMedia.Internals.Units.DensityDerPressure drhodp "Derivative of density wrt pressure";
        output TILMedia.Internals.Units.DensityDerSpecificEnthalpy drhodh "Derivative of density wrt specific enthalpy";
        output Real[size(xi, 1)] drhodxi "Derivative of density wrt mass fraction";
        output Modelica.SIunits.Velocity a "Speed of sound";
        output Real gamma "Heat capacity ratio";
        external "C" TILMedia_VLEFluid_additionalProperties_phxi(p, h, xi, vleFluidPointer, x, cp, cv, beta, kappa, drhodp, drhodh, drhodxi, a, gamma) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_additionalProperties_phxi(double, double, double*, void*, double*, double*, double*, double*, double*, double*, double*, double*, double*, double*);", Library = "TILMedia130ClaRa", Impure = false, deriXvative = der_additionalProperties_phxi);
        annotation(Impure = false, deriXvative = der_additionalProperties_phxi); 
      end additionalProperties_phxi;

      function transportPropertyRecord_phxi  
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output TILMedia.Internals.TransportPropertyRecord transp "Transport property record";
        external "C" TILMedia_VLEFluid_transportProperties_phxi(p, h, xi, vleFluidPointer, transp.Pr, transp.lambda, transp.eta, transp.sigma) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_transportProperties_phxi(double, double, double*, void*, double*, double*, double*, double*);", Library = "TILMedia130ClaRa", Impure = false, derivXative = der_transportPropertyRecord_phxi);
        annotation(Impure = false, derivXative = der_transportPropertyRecord_phxi); 
      end transportPropertyRecord_phxi;

      function VLETransportPropertyRecord_phxi  
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output Modelica.SIunits.PrandtlNumber Pr_l "Prandtl number";
        output Modelica.SIunits.PrandtlNumber Pr_v "Prandtl number";
        output Modelica.SIunits.ThermalConductivity lambda_l "Thermal conductivity";
        output Modelica.SIunits.ThermalConductivity lambda_v "Thermal conductivity";
        output Modelica.SIunits.DynamicViscosity eta_l "Dynamic viscosity";
        output Modelica.SIunits.DynamicViscosity eta_v "Dynamic viscosity";
        external "C" TILMedia_VLEFluid_VLETransportProperties_phxi(p, h, xi, vleFluidPointer, Pr_l, Pr_v, lambda_l, lambda_v, eta_l, eta_v) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_VLETransportProperties_phxi(double, double, double*, void*, double*, double*, double*, double*, double*, double*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end VLETransportPropertyRecord_phxi;

      function VLEAdditionalProperties_phxi  
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output Modelica.SIunits.SpecificHeatCapacity cp_l "Specific heat capacity cp";
        output Modelica.SIunits.LinearExpansionCoefficient beta_l "Isobaric expansion coefficient";
        output Modelica.SIunits.Compressibility kappa_l "Isothermal compressibility";
        output Modelica.SIunits.SpecificHeatCapacity cp_v "Specific heat capacity cp";
        output Modelica.SIunits.LinearExpansionCoefficient beta_v "Isobaric expansion coefficient";
        output Modelica.SIunits.Compressibility kappa_v "Isothermal compressibility";
        external "C" TILMedia_VLEFluid_VLEAdditionalProperties_phxi(p, h, xi, vleFluidPointer, cp_l, beta_l, kappa_l, cp_v, beta_v, kappa_v) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_VLEAdditionalProperties_phxi(double, double, double*, void*,double*, double*, double*, double*, double*, double*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end VLEAdditionalProperties_phxi;

      function VLEProperties_phxi  
        input Modelica.SIunits.AbsolutePressure p "Pressure";
        input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output Modelica.SIunits.Density d_l "Density";
        output Modelica.SIunits.SpecificEnthalpy h_l "Specific enthalpy";
        output Modelica.SIunits.AbsolutePressure p_l "Pressure";
        output Modelica.SIunits.SpecificEntropy s_l "Specific entropy";
        output Modelica.SIunits.Temperature T_l "Temperature";
        output Modelica.SIunits.MassFraction[size(xi, 1)] xi_l "Mass fractions";
        output Modelica.SIunits.Density d_v "Density";
        output Modelica.SIunits.SpecificEnthalpy h_v "Specific enthalpy";
        output Modelica.SIunits.AbsolutePressure p_v "Pressure";
        output Modelica.SIunits.SpecificEntropy s_v "Specific entropy";
        output Modelica.SIunits.Temperature T_v "Temperature";
        output Modelica.SIunits.MassFraction[size(xi, 1)] xi_v "Mass fractions";
        external "C" TILMedia_VLEFluid_VLEProperties_phxi(p, h, xi, vleFluidPointer, d_l, h_l, p_l, s_l, T_l, xi_l, d_v, h_v, p_v, s_v, T_v, xi_v) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_VLEProperties_phxi(double, double, double*, void*, double*, double*, double*, double*, double*, double*,
      		double*, double*, double*, double*, double*, double*);", Library = "TILMedia130ClaRa", Impure = false, deXrivative = der_VLEProperties_phxi);
        annotation(Impure = false, deXrivative = der_VLEProperties_phxi); 
      end VLEProperties_phxi;

      function molarMass_nc  
        input Integer nc "Number of components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output .Modelica.SIunits.MolarMass[nc] mm_i "Molar mass";
        external "C" TILMedia_VLEFluid_Cached_molarMass(vleFluidPointer, mm_i) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_Cached_molarMass(void*,double*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end molarMass_nc;

      function specificEnthalpy_pTxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output .Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy";
        external "C" h = TILMedia_VLEFluid_Cached_specificEnthalpy_pTxi(p, T, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_specificEnthalpy_pTxi(double, double, double*, void*);", Library = "TILMedia130ClaRa", derivative = der_specificEnthalpy_pTxi, inverse(T = temperature_phxi(p, h, xi, vleFluidPointer)), Impure = false);
        annotation(derivative = der_specificEnthalpy_pTxi, inverse(T = temperature_phxi(p, h, xi, vleFluidPointer)), Impure = false); 
      end specificEnthalpy_pTxi;

      function density_pTxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output .Modelica.SIunits.Density d "Density";
        external "C" d = TILMedia_VLEFluid_Cached_density_pTxi(p, T, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_density_pTxi(double, double, double*, void*);", Library = "TILMedia130ClaRa", derivative = der_density_pTxi);
        annotation(derivative = der_density_pTxi); 
      end density_pTxi;

      function specificEntropy_pTxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output .Modelica.SIunits.SpecificEntropy s "Specific Entropy";
        external "C" s = TILMedia_VLEFluid_Cached_specificEntropy_pTxi(p, T, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_specificEntropy_pTxi(double, double, double*, void*);", Library = "TILMedia130ClaRa", derivative = der_specificEntropy_pTxi, inverse(T = temperature_psxi(p, s, xi, vleFluidPointer)), Impure = false);
        annotation(derivative = der_specificEntropy_pTxi, inverse(T = temperature_psxi(p, s, xi, vleFluidPointer)), Impure = false); 
      end specificEntropy_pTxi;

      function density_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output .Modelica.SIunits.Density d "Density";
        external "C" d = TILMedia_VLEFluid_Cached_density_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_density_phxi(double, double, double*, void*);", Library = "TILMedia130ClaRa", derivative = der_density_phxi, Impure = false);
        annotation(derivative = der_density_phxi, Impure = false); 
      end density_phxi;

      function specificEntropy_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output .Modelica.SIunits.SpecificEntropy s "Specific Entropy";
        external "C" s = TILMedia_VLEFluid_Cached_specificEntropy_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_specificEntropy_phxi(double, double, double*, void*);", Library = "TILMedia130ClaRa", derivative = der_specificEntropy_phxi, inverse(h = specificEnthalpy_psxi(p, s, xi, vleFluidPointer)), Impure = false);
        annotation(derivative = der_specificEntropy_phxi, inverse(h = specificEnthalpy_psxi(p, s, xi, vleFluidPointer)), Impure = false); 
      end specificEntropy_phxi;

      function temperature_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output .Modelica.SIunits.Temperature T "Temperature";
        external "C" T = TILMedia_VLEFluid_Cached_temperature_phxi(p, h, xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_temperature_phxi(double, double, double*, void*);", Library = "TILMedia130ClaRa", derivative = der_temperature_phxi, inverse(h = specificEnthalpy_pTxi(p, T, xi, vleFluidPointer)), Impure = false);
        annotation(derivative = der_temperature_phxi, inverse(h = specificEnthalpy_pTxi(p, T, xi, vleFluidPointer)), Impure = false); 
      end temperature_phxi;

      function der_specificEnthalpy_pTxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        input Real der_p "Derivative of Pressure";
        input Real der_T "Derivative of Temperature";
        input Real[:] der_xi "Derivative of Mass fractions of the first nc-1 components";
        output Real der_h "Derivative of Specific Enthalpy";
        external "C" der_h = TILMedia_VLEFluid_Cached_der_specificEnthalpy_pTxi(p, T, xi, der_p, der_T, der_xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_der_specificEnthalpy_pTxi(double, double, double*, double, double, double*, void*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end der_specificEnthalpy_pTxi;

      function der_density_pTxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        input Real der_p "Derivative of Pressure";
        input Real der_T "Derivative of Temperature";
        input Real[:] der_xi "Derivative of Mass fractions of the first nc-1 components";
        output Real der_d "Derivative of Density";
        external "C" der_d = TILMedia_VLEFluid_Cached_der_density_pTxi(p, T, xi, der_p, der_T, der_xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_der_density_pTxi(double, double, double*, double, double, double*, void*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end der_density_pTxi;

      function der_specificEntropy_pTxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.Temperature T "Temperature";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        input Real der_p "Derivative of Pressure";
        input Real der_T "Derivative of Temperature";
        input Real[:] der_xi "Derivative of Mass fractions of the first nc-1 components";
        output Real der_s "Derivative of Specific Entropy";
        external "C" der_s = TILMedia_VLEFluid_Cached_der_specificEntropy_pTxi(p, T, xi, der_p, der_T, der_xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_der_specificEntropy_pTxi(double, double, double*, double, double, double*, void*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end der_specificEntropy_pTxi;

      function der_density_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        input Real der_p "Derivative of Pressure";
        input Real der_h "Derivative of Specific Enthalpy";
        input Real[:] der_xi "Derivative of Mass fractions of the first nc-1 components";
        output Real der_d "Derivative of Density";
        external "C" der_d = TILMedia_VLEFluid_Cached_der_density_phxi(p, h, xi, der_p, der_h, der_xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_der_density_phxi(double, double, double*, double, double, double*, void*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end der_density_phxi;

      function der_specificEntropy_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        input Real der_p "Derivative of Pressure";
        input Real der_h "Derivative of Specific Enthalpy";
        input Real[:] der_xi "Derivative of Mass fractions of the first nc-1 components";
        output Real der_s "Derivative of Specific Entropy";
        external "C" der_s = TILMedia_VLEFluid_Cached_der_specificEntropy_phxi(p, h, xi, der_p, der_h, der_xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_der_specificEntropy_phxi(double, double, double*, double, double, double*, void*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end der_specificEntropy_phxi;

      function der_temperature_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy";
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        input Real der_p "Derivative of Pressure";
        input Real der_h "Derivative of Specific Enthalpy";
        input Real[:] der_xi "Derivative of Mass fractions of the first nc-1 components";
        output Real der_T "Derivative of Temperature";
        external "C" der_T = TILMedia_VLEFluid_Cached_der_temperature_phxi(p, h, xi, der_p, der_h, der_xi, vleFluidPointer) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluid_Cached_der_temperature_phxi(double, double, double*, double, double, double*, void*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end der_temperature_phxi;

      function cricondenbar_xi  
        input Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointer;
        output Real d;
        output Real h;
        output Real p;
        output Real s;
        output Real T;
        external "C" TILMedia_VLEFluid_cricondenbar_xi(xi, vleFluidPointer, d, h, p, s, T) annotation(__iti_dllNoExport = true, Include = "void TILMedia_VLEFluid_cricondenbar_xi(double*, void*, double*, double*, double*, double*, double*);", Library = "TILMedia130ClaRa", Impure = false);
        annotation(Impure = false); 
      end cricondenbar_xi;
    end VLEFluidObjectFunctions;

    package VLEFluidFunctions  
      extends TILMedia.Internals.ClassTypes.ModelPackage;

      function density_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.Density d "Density";
        external "C" d = TILMedia_VLEFluidFunctions_density_phxi(p, h, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_density_phxi(double, double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end density_phxi;

      function specificEntropy_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        external "C" s = TILMedia_VLEFluidFunctions_specificEntropy_phxi(p, h, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_specificEntropy_phxi(double, double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end specificEntropy_phxi;

      function specificIsobaricHeatCapacity_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.SpecificHeatCapacity cp "Specific isobaric heat capacity cp";
        external "C" cp = TILMedia_VLEFluidFunctions_specificIsobaricHeatCapacity_phxi(p, h, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_specificIsobaricHeatCapacity_phxi(double, double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end specificIsobaricHeatCapacity_phxi;

      function thermalConductivity_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
        external "C" lambda = TILMedia_VLEFluidFunctions_thermalConductivity_phxi(p, h, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_thermalConductivity_phxi(double, double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end thermalConductivity_phxi;

      function dynamicViscosity_phxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.DynamicViscosity eta "Dynamic viscosity";
        external "C" eta = TILMedia_VLEFluidFunctions_dynamicViscosity_phxi(p, h, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_dynamicViscosity_phxi(double, double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end dynamicViscosity_phxi;

      function specificEnthalpy_psxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.SpecificEntropy s "Specific entropy";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        external "C" h = TILMedia_VLEFluidFunctions_specificEnthalpy_psxi(p, s, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_specificEnthalpy_psxi(double, double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end specificEnthalpy_psxi;

      function specificEnthalpy_pTxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.Temperature T "Temperature";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
        external "C" h = TILMedia_VLEFluidFunctions_specificEnthalpy_pTxi(p, T, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_specificEnthalpy_pTxi(double, double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end specificEnthalpy_pTxi;

      function dewDensity_pxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.Density d_dew "Density at dew point";
        external "C" d_dew = TILMedia_VLEFluidFunctions_dewDensity_pxi(p, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_dewDensity_pxi(double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end dewDensity_pxi;

      function bubbleDensity_pxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.Density d_bubble "Density at bubble point";
        external "C" d_bubble = TILMedia_VLEFluidFunctions_bubbleDensity_pxi(p, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_bubbleDensity_pxi(double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end bubbleDensity_pxi;

      function dewSpecificEnthalpy_pxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.SpecificEnthalpy h_dew "Specific enthalpy at dew point";
        external "C" h_dew = TILMedia_VLEFluidFunctions_dewSpecificEnthalpy_pxi(p, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_dewSpecificEnthalpy_pxi(double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end dewSpecificEnthalpy_pxi;

      function bubbleSpecificEnthalpy_pxi  
        input .Modelica.SIunits.AbsolutePressure p "Pressure";
        input .Modelica.SIunits.MassFraction[:] xi "Mass fractions of the first nc-1 components";
        input TILMedia.Internals.VLEFluidName vleFluidName "VLEFluid name";
        input Integer nc "Number of components";
        output .Modelica.SIunits.SpecificEnthalpy h_bubble "Specific enthalpy at bubble point";
        external "C" h_bubble = TILMedia_VLEFluidFunctions_bubbleSpecificEnthalpy_pxi(p, xi, vleFluidName, nc) annotation(__iti_dllNoExport = true, Include = "double TILMedia_VLEFluidFunctions_bubbleSpecificEnthalpy_pxi(double, double*,const char*, int);", Library = "TILMedia130ClaRa");
      end bubbleSpecificEnthalpy_pxi;
    end VLEFluidFunctions;

    package Units  "Unit definitions" 
      extends TILMedia.Internals.ClassTypes.ModelPackage;
      type DensityDerPressure = Real(final unit = "kg/(N.m)");
      type DensityDerSpecificEnthalpy = Real(final unit = "kg2/(m3.J)");
      type DensityDerMassFraction = Real(final unit = "kg/(m3)");
    end Units;

    type GasName  "Gas name" 
      extends String;
      annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
    end GasName;

    type VLEFluidName  "VLE Fluid name" 
      extends String;
      annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
    end VLEFluidName;

    record CriticalDataRecord  "Critical data record" 
      extends TILMedia.Internals.ClassTypes.Record;
      Modelica.SIunits.Density d "Critical density";
      Modelica.SIunits.SpecificEnthalpy h "Critical specific enthalpy";
      Modelica.SIunits.AbsolutePressure p "Critical pressure";
      Modelica.SIunits.SpecificEntropy s "Critical specific entropy";
      Modelica.SIunits.Temperature T "Critical temperature";
      annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
    end CriticalDataRecord;

    record VLERecord  "VLE property record" 
      extends TILMedia.Internals.ClassTypes.Record;
      .Modelica.SIunits.Density d_l "Density of liquid phase";
      .Modelica.SIunits.Density d_v "Density of vapour phase";
      .Modelica.SIunits.SpecificEnthalpy h_l "Specific enthalpy of liquid phase";
      .Modelica.SIunits.SpecificEnthalpy h_v "Specific enthalpy of vapour phase";
      .Modelica.SIunits.AbsolutePressure p_l "Pressure of liquid phase";
      .Modelica.SIunits.AbsolutePressure p_v "Pressure of vapour phase";
      .Modelica.SIunits.SpecificEntropy s_l "Specific entropy of liquid phase";
      .Modelica.SIunits.SpecificEntropy s_v "Specific entropy of vapour phase";
      .Modelica.SIunits.Temperature T_l "Temperature of liquid phase";
      .Modelica.SIunits.Temperature T_v "Temperature of vapour phase";
      .Modelica.SIunits.MassFraction[nc - 1] xi_l "Mass fraction of liquid phase";
      .Modelica.SIunits.MassFraction[nc - 1] xi_v "Mass fraction of vapour phase";
      parameter Integer nc;
      annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
    end VLERecord;

    record AdditionalVLERecord  "Additional VLE property record" 
      extends TILMedia.Internals.ClassTypes.Record;
      Modelica.SIunits.SpecificHeatCapacity cp_l "Specific heat capacity cp of liquid phase";
      Modelica.SIunits.SpecificHeatCapacity cp_v "Specific heat capacity cp of vapour phase";
      Modelica.SIunits.LinearExpansionCoefficient beta_l "Isobaric expansion coefficient of liquid phase";
      Modelica.SIunits.LinearExpansionCoefficient beta_v "Isobaric expansion coefficient of vapour phase";
      Modelica.SIunits.Compressibility kappa_l "Isothermal compressibility of liquid phase";
      Modelica.SIunits.Compressibility kappa_v "Isothermal compressibility of vapour phase";
      annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
    end AdditionalVLERecord;

    record VLETransportPropertyRecord  "Transport property record" 
      extends TILMedia.Internals.ClassTypes.Record;
      .Modelica.SIunits.PrandtlNumber Pr_l "Prandtl number of liquid phase";
      .Modelica.SIunits.PrandtlNumber Pr_v "Prandtl number of vapour phase";
      .Modelica.SIunits.ThermalConductivity lambda_l "Thermal conductivity of liquid phase";
      .Modelica.SIunits.ThermalConductivity lambda_v "Thermal conductivity of vapour phase";
      .Modelica.SIunits.DynamicViscosity eta_l(min = -1) "Dynamic viscosity of liquid phase";
      .Modelica.SIunits.DynamicViscosity eta_v(min = -1) "Dynamic viscosity of vapour phase";
      annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
    end VLETransportPropertyRecord;

    record TransportPropertyRecord  "Transport property record" 
      extends TILMedia.Internals.ClassTypes.Record;
      Modelica.SIunits.PrandtlNumber Pr "Prandtl number";
      Modelica.SIunits.ThermalConductivity lambda "Thermal conductivity";
      Modelica.SIunits.DynamicViscosity eta(min = -1) "Dynamic viscosity";
      Modelica.SIunits.SurfaceTension sigma "Surface tension";
      annotation(__Dymola_Protection(allowDuplicate = true, showDiagram = true, showText = true)); 
    end TransportPropertyRecord;

    function calcComputeFlags  
      input Boolean computeTransportProperties;
      input Boolean interpolateTransportProperties;
      input Boolean computeSurfaceTension;
      input Boolean deactivateTwoPhaseRegion;
      output Integer flags;
    algorithm
      flags := array(1, 2, 4, 8) * array(if computeTransportProperties then 1 else 0, if interpolateTransportProperties then 1 else 0, if computeSurfaceTension then 1 else 0, if deactivateTwoPhaseRegion then 1 else 0);
      annotation(Inline = true); 
    end calcComputeFlags;

    function redirectModelicaFormatMessage  
      input Real y = 0;
      output Integer x;
      external "C" x = TILMedia_redirectModelicaFormatMessage_wrapper() annotation(__iti_dllNoExport = true, Library = "TILMedia130ClaRa", Include = "
    /* uncomment for source code version
    #define TILMEDIA_REAL_TIME
    #define TILMEDIA_STATIC_LIBRARY
    #include \"TILMediaTotal.c\"
    */
    #ifndef TILMEDIAMODELICAFORMATMESSAGE
    #define TILMEDIAMODELICAFORMATMESSAGE
    #if defined(DYMOLA_STATIC) || (defined(ITI_CRT_INCLUDE) && !defined(ITI_COMP_SIM))
    int TILMedia_redirectModelicaFormatMessage(void* _str);
    int TILMedia_redirectModelicaFormatError(void* _str);
    int TILMedia_redirectDymolaErrorFunction(void* _str);
    #if defined(DYMOLA_STATIC)
    #ifndef _WIN32
    #define __stdcall
    #endif
    double __stdcall TILMedia_DymosimErrorLevWrapper(const char* message, int level) {
        return DymosimErrorLev(message, level);
    }
    #endif
    int TILMedia_redirectModelicaFormatMessage_wrapper(void) {
        TILMedia_redirectModelicaFormatMessage((void*)ModelicaFormatMessage);
        TILMedia_redirectModelicaFormatError((void*)ModelicaFormatError);
    #if defined(DYMOLA_STATIC)
        TILMedia_redirectDymolaErrorFunction((void*)TILMedia_DymosimErrorLevWrapper);
    #endif
        return 0;
    }
    #endif
    #endif
      ");
    end redirectModelicaFormatMessage;

    function concatNames  
      input String[:] names;
      output String concatName;
    algorithm
      concatName := "";
      if size(names, 1) > 0 then
        concatName := names[1];
      else
      end if;
      for i in 2:size(names, 1) loop
        concatName := concatName + "|" + names[i];
      end for;
    end concatNames;
  end Internals;
  annotation(preferedView = "info", version = "1.3.0 ClaRa", __Dymola_Protection(nestedAllowDuplicate = false, nestedShowDiagram = false, nestedShowText = false, showVariables = true, showDiagnostics = true, showStatistics = true, showFlat = true)); 
end TILMedia;

package ClaRa  "Simulation of Clausius-Rankine Cycles" 
  extends ClaRa.Basics.Icons.PackageIcons.ClaRab100;

  package Examples  "Examples to illustrate the functionality of the library" 
    extends ClaRa.Basics.Icons.PackageIcons.Examplesb100;

    model SteamCycle_01  "A closed steam cycle with a simple boiler model including single reheat, feedwater tank, LP and HP preheaters" 
      extends ClaRa.Basics.Icons.PackageIcons.ExecutableRegressiong100;
      ClaRa.Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_HP1(p_nom = NOM.Turbine_HP.p_in, m_flow_nom = NOM.Turbine_HP.m_flow, Pi = NOM.Turbine_HP.p_out / NOM.Turbine_HP.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_HP.p_in, NOM.Turbine_HP.h_in), allowFlowReversal = true, redeclare model Efficiency = ClaRa.Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.efficiency_Turb_HP; 1, NOM.efficiency_Turb_HP]), p_in_start = INIT.Turbine_HP.p_in, p_out_start = INIT.Turbine_HP.p_out, useMechanicalPort = true, eta_mech = NOM.Turbine_HP.efficiency);
      
      ClaRa.SubSystems.Boiler.SteamGenerator_L3 steamGenerator(p_LS_start = INIT.boiler.p_LS_out, p_RH_start = INIT.boiler.p_RS_out, p_LS_nom = NOM.boiler.p_LS_out, p_RH_nom = NOM.boiler.p_RS_out, h_LS_nom = NOM.boiler.h_LS_out, h_RH_nom = NOM.boiler.h_RS_out, h_LS_start = INIT.boiler.h_LS_out, h_RH_start = INIT.boiler.h_RS_out, Delta_p_nomHP = NOM.Delta_p_LS_nom, Delta_p_nomIP = NOM.Delta_p_RS_nom, Q_flow_F_nom = NOM.boiler.Q_flow, CL_yF_QF_ = [0.4207, 0.8341; 0.6246, 0.8195; 0.8171, 0.8049; 1, NOM.boiler.m_flow_feed * (NOM.boiler.h_LS_out - NOM.boiler.h_LS_in) / NOM.boiler.Q_flow], m_flow_nomLS = NOM.boiler.m_flow_LS_nom, Tau_dead = 100, Tau_bal = 50, volume_tot_HP = 300, volume_tot_IP = 100, CL_Delta_pHP_mLS_ = NOM.CharLine_Delta_p_HP_mLS_, CL_Delta_pIP_mLS_ = NOM.CharLine_Delta_p_IP_mRS_, CL_etaF_QF_ = [0, 0.9; 1, 0.95], initOption_IP = 0, initOption_HP = 0);
      ClaRa.Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_IP1(allowFlowReversal = true, redeclare model Efficiency = ClaRa.Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.Turbine_IP1.efficiency; 1, NOM.Turbine_IP1.efficiency]), p_in_start = INIT.Turbine_IP1.p_in, p_out_start = INIT.Turbine_IP1.p_out, p_nom = NOM.Turbine_IP1.p_in, m_flow_nom = NOM.Turbine_IP1.m_flow, Pi = NOM.Turbine_IP1.p_out / NOM.Turbine_IP1.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_IP1.p_in, NOM.Turbine_IP1.h_in), useMechanicalPort = true, eta_mech = NOM.Turbine_IP1.efficiency);
      ClaRa.Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_LP4(allowFlowReversal = true, redeclare model Efficiency = ClaRa.Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.Turbine_LP4.efficiency; 1, NOM.Turbine_LP4.efficiency]), p_in_start = INIT.Turbine_LP4.p_in, p_out_start = INIT.Turbine_LP4.p_out, useMechanicalPort = true, p_nom = NOM.Turbine_LP4.p_in, m_flow_nom = NOM.Turbine_LP4.m_flow, Pi = NOM.Turbine_LP4.p_out / NOM.Turbine_LP4.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_LP4.p_in, NOM.Turbine_LP4.h_in), eta_mech = NOM.Turbine_LP4.efficiency);
      ClaRa.Components.TurboMachines.Pumps.PumpVLE_L1_simple Pump_FW(eta_mech = NOM.efficiency_Pump_cond);
      ClaRa.Visualisation.Quadruple quadruple(decimalSpaces(p = 3));
      ClaRa.Visualisation.Quadruple quadruple1;
      ClaRa.Visualisation.Quadruple quadruple2;
      ClaRa.Visualisation.Quadruple quadruple3;
      ClaRa.Visualisation.Quadruple quadruple4;
      Components.HeatExchangers.HEXvle2vle_L3_2ph_BU_simple condenser(height = 5, width = 5, redeclare model PressureLossShell = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3(Delta_p_nom = {100, 100, 100}), z_in_shell = 4.9, z_out_shell = 0.1, level_rel_start = 0.5 / 6, m_flow_nom_shell = NOM.condenser.m_flow_in, p_nom_shell = NOM.condenser.p_condenser, p_start_shell = INIT.condenser.p_condenser, initOptionShell = 204, levelOutput = true, z_in_aux1 = 4.9, z_in_aux2 = 4.9, height_hotwell = 2, width_hotwell = 1, length_hotwell = 10, diameter_i = 0.008, diameter_o = 0.01, m_flow_nom_tubes = 10000, p_nom_tubes = 2e5, h_start_tubes = 85e3, p_start_tubes = 2e5, redeclare model HeatTransferTubes = Basics.ControlVolumes.Fundamentals.HeatTransport.VLE_HT.NusseltPipe1ph_L2, length = 12, redeclare model HeatTransfer_Shell = Basics.ControlVolumes.Fundamentals.HeatTransport.VLE_HT.Constant_L3_ypsDependent(alpha_nom = {3000, 12000}), N_tubes = 15000);
      ClaRa.Visualisation.Quadruple quadruple5(decimalSpaces(p = 2));
      Components.MechanicalSeparation.FeedWaterTank_L3 feedWaterTank(level_rel_start = 0.5, diameter = 5, orientation = ClaRa.Basics.Choices.GeometryOrientation.horizontal, p_start(displayUnit = "bar") = INIT.feedwatertank.p_FWT, z_tapping = 4.5, z_vent = 4.5, z_condensate = 4.5, redeclare model PressureLoss = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3(Delta_p_nom = {1000, 1000, 1000}), m_flow_cond_nom = NOM.feedwatertank.m_flow_cond, p_nom = NOM.feedwatertank.p_FWT, h_nom = NOM.feedwatertank.h_cond_in, m_flow_heat_nom = NOM.feedwatertank.m_flow_tap1 + NOM.feedwatertank.m_flow_tap2, initOption = 204, T_wall_start = ones(feedWaterTank.wall.N_rad) * (120 + 273.15), showLevel = true, length = 12, z_aux = 1, equalPressures = false, absorbInflow = 0.6);
      ClaRa.Components.TurboMachines.Pumps.PumpVLE_L1_simple Pump_cond(showExpertSummary = true, eta_mech = 0.9, inlet(m_flow(start = NOM.Pump_cond.summary.inlet.m_flow)));
      ClaRa.Components.Utilities.Blocks.LimPID PI_Pump_cond(sign = -1, y_ref = 1e6, Tau_d = 30, controllerType = Modelica.Blocks.Types.SimpleController.PI, y_max = NOM.Pump_cond.P_pump * 10, y_min = NOM.Pump_cond.P_pump / 200, y_start = INIT.Pump_cond.P_pump, k = 10, Tau_i = 100, initOption = 796);
      ClaRa.Visualisation.Quadruple quadruple6;
      ClaRa.Components.VolumesValvesFittings.Valves.ValveVLE_L1 valve_IP1(checkValve = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(Delta_p_nom = NOM.valve_IP1.Delta_p, m_flow_nom = NOM.valve_IP1.m_flow));
      ClaRa.Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_LP1(p_nom = NOM.Turbine_LP1.p_in, m_flow_nom = NOM.Turbine_LP1.m_flow, Pi = NOM.Turbine_LP1.p_out / NOM.Turbine_LP1.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_LP1.p_in, NOM.Turbine_LP1.h_in), allowFlowReversal = true, redeclare model Efficiency = ClaRa.Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.Turbine_LP1.efficiency; 1, NOM.Turbine_LP1.efficiency]), p_in_start = INIT.Turbine_LP1.p_in, p_out_start = INIT.Turbine_LP1.p_out, useMechanicalPort = true, eta_mech = NOM.Turbine_LP1.efficiency);
      ClaRa.Visualisation.Quadruple quadruple7;
      ClaRa.Components.VolumesValvesFittings.Fittings.SplitVLE_L2_Y join_LP1(p_nom = INIT.Turbine_LP1.p_out, h_nom = INIT.Turbine_LP1.h_out, h_start = INIT.Turbine_LP1.h_out, p_start = INIT.Turbine_LP1.p_out, volume = 0.1, initOption = 0, m_flow_out_nom = {NOM.Turbine_LP1.summary.outlet.m_flow, NOM.preheater_LP2.summary.inlet_tap.m_flow});
      ClaRa.Components.TurboMachines.Pumps.PumpVLE_L1_simple Pump_preheater_LP1(eta_mech = 0.9, inlet(m_flow(start = NOM.pump_preheater_LP1.summary.inlet.m_flow)));
      ClaRa.Components.VolumesValvesFittings.Valves.ValveVLE_L1 valve_IP2(checkValve = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.QuadraticNominalPoint(m_flow_nom = NOM.valve_IP2.m_flow, rho_in_nom = 2.4, Delta_p_nom = NOM.valve_IP2.Delta_p));
      ClaRa.Components.VolumesValvesFittings.Fittings.SplitVLE_L2_Y join_HP(volume = 0.1, p_start = INIT.Turbine_HP.p_out, p_nom = NOM.Turbine_HP.p_out, h_nom = NOM.Turbine_HP.h_out, h_start = INIT.Turbine_HP.h_out, showExpertSummary = true, m_flow_out_nom = {NOM.join_HP.m_flow_2, NOM.join_HP.m_flow_3}, initOption = 0);
      ClaRa.Components.HeatExchangers.HEXvle2vle_L3_2ph_CH_simple preheater_HP(redeclare replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Steel, m_flow_nom_shell = NOM.preheater_HP.m_flow_tap, p_nom_shell = NOM.preheater_HP.p_tap, h_nom_shell = NOM.preheater_HP.h_tap_out, m_flow_nom_tubes = NOM.preheater_HP.m_flow_cond, h_nom_tubes = NOM.preheater_HP.h_cond_out, h_start_tubes = INIT.preheater_HP.h_cond_out, N_passes = 1, z_in_tubes = 0.1, z_out_tubes = 0.1, Q_flow_nom = 2e8, z_out_shell = 0.1, length = 15, z_in_shell = preheater_HP.length, p_start_shell = INIT.preheater_HP.p_tap, diameter = 2.6, showExpertSummary = true, Tau_cond = 0.3, Tau_evap = 0.03, alpha_ph = 50000, redeclare model HeatTransferTubes = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2(alpha_nom = 3500), p_nom_tubes = NOM.preheater_HP.p_cond, p_start_tubes(displayUnit = "bar") = INIT.preheater_HP.p_cond, redeclare model PressureLossShell = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3(Delta_p_nom = {1000, 1000, 1000}), redeclare model PressureLossTubes = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L2(Delta_p_nom = 10), initOptionTubes = 0, initOptionShell = 204, initOptionWall = 1, levelOutput = true, T_w_start = ones(3) * (273.15 + 200), redeclare model HeatTransfer_Shell = Basics.ControlVolumes.Fundamentals.HeatTransport.VLE_HT.Constant_L3_ypsDependent(alpha_nom = {1650, 10000}), diameter_i = 0.02, diameter_o = 0.028, N_tubes = 2000);
      ClaRa.Components.VolumesValvesFittings.Valves.ValveVLE_L1 valve_HP(openingInputIsActive = false, showExpertSummary = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.QuadraticNominalPoint(Delta_p_nom = NOM.valve_HP.Delta_p_nom, m_flow_nom = NOM.valve_HP.m_flow, rho_in_nom = 25));
      ClaRa.Components.VolumesValvesFittings.Valves.ValveVLE_L1 valveControl_preheater_HP(openingInputIsActive = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.QuadraticNominalPoint(m_flow_nom = NOM.valve2_HP.m_flow, rho_in_nom = 800, Delta_p_nom = NOM.valve2_HP.Delta_p * 0.01));
      ClaRa.Visualisation.StatePoint_phTs statePoint;
      ClaRa.Components.HeatExchangers.HEXvle2vle_L3_2ph_CH_simple preheater_LP1(redeclare replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Steel, m_flow_nom_shell = NOM.preheater_LP1.m_flow_tap, p_nom_shell = NOM.preheater_LP1.p_tap, h_nom_shell = NOM.preheater_LP1.h_tap_out, m_flow_nom_tubes = NOM.preheater_LP1.m_flow_cond, h_nom_tubes = NOM.preheater_LP1.h_cond_out, h_start_tubes = INIT.preheater_LP1.h_cond_out, p_start_shell = INIT.preheater_LP1.p_tap, N_passes = 1, Q_flow_nom = 2e8, z_in_shell = preheater_LP1.length, z_in_tubes = preheater_LP1.diameter / 2, z_out_tubes = preheater_LP1.diameter / 2, z_out_shell = 0.1, redeclare model HeatTransferTubes = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2(PL_alpha = [0, 0.55; 0.5, 0.65; 0.7, 0.72; 0.8, 0.77; 1, 1], alpha_nom = 3000), redeclare model PressureLossTubes = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L2(Delta_p_nom = 1000), Tau_cond = 0.3, Tau_evap = 0.03, redeclare model HeatTransfer_Shell = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3(alpha_nom = {1500, 8000}), redeclare model PressureLossShell = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3(Delta_p_nom = {100, 100, 100}), p_nom_tubes = NOM.preheater_LP1.p_cond, p_start_tubes(displayUnit = "bar") = INIT.preheater_LP1.p_cond, initOptionTubes = 0, initOptionShell = 204, initOptionWall = 1, levelOutput = true, length = 10, diameter = 3, diameter_i = 0.05, diameter_o = 0.052, level_rel_start = 0.1, T_w_start = {350, 400, 440}, N_tubes = 1000);
      Modelica.Blocks.Sources.RealExpression setPoint_preheater_HP(y = 0.5);
      Components.Utilities.Blocks.LimPID PI_valveControl_preheater_HP(controllerType = Modelica.Blocks.Types.SimpleController.PI, y_max = 1, y_min = 0.01, Tau_i = 10, y_start = 0.2, k = 2, initOption = 796);
      Modelica.Blocks.Continuous.FirstOrder measurement(initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.1, T = 10);
      StaticCycles.Check.StaticCycleExamples.InitSteamCycle_01 INIT(P_target_ = 1, p_condenser = NOM.p_condenser, preheater_HP_p_tap = NOM.preheater_HP_p_tap, preheater_HP_m_flow_tap = NOM.preheater_HP_m_flow_tap, preheater_LP1_p_tap = NOM.preheater_LP1_p_tap, preheater_LP1_m_flow_tap = NOM.preheater_LP1_m_flow_tap, p_FWT = NOM.p_FWT, valve_LP1_Delta_p_nom = NOM.valve_LP1_Delta_p_nom, valve_LP2_Delta_p_nom = NOM.valve_LP2_Delta_p_nom, T_LS_nom = NOM.T_LS_nom, T_RS_nom = NOM.T_RS_nom, p_LS_out_nom = NOM.p_LS_out_nom, p_RS_out_nom = NOM.p_RS_out_nom, Delta_p_LS_nom = NOM.Delta_p_LS_nom, Delta_p_RS_nom = NOM.Delta_p_RS_nom, CharLine_Delta_p_HP_mLS_ = NOM.CharLine_Delta_p_HP_mLS_, CharLine_Delta_p_IP_mRS_ = NOM.CharLine_Delta_p_IP_mRS_, efficiency_Pump_cond = NOM.efficiency_Pump_cond, efficiency_Pump_preheater_LP1 = NOM.efficiency_Pump_preheater_LP1, efficiency_Pump_FW = NOM.efficiency_Pump_FW, efficiency_Turb_HP = NOM.efficiency_Turb_HP, efficiency_Turb_LP1 = NOM.efficiency_Turb_LP1, efficiency_Turb_LP2 = NOM.efficiency_Turb_LP2, m_flow_nom = NOM.m_flow_nom, IP3_pressure(displayUnit = "kPa"), efficiency_Turb_IP1 = NOM.efficiency_Turb_IP1, efficiency_Turb_IP2 = NOM.efficiency_Turb_IP2, efficiency_Turb_IP3 = NOM.efficiency_Turb_IP3, efficiency_Turb_LP3 = NOM.efficiency_Turb_LP3, efficiency_Turb_LP4 = NOM.efficiency_Turb_LP4, valve_HP_Delta_p_nom = NOM.valve_HP_Delta_p_nom);
      ClaRa.Components.VolumesValvesFittings.Valves.ValveVLE_L1 valvePreFeedWaterTank(Tau = 1e-3, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(Delta_p_nom = NOM.valvePreFeedWaterTank.Delta_p_nom, m_flow_nom = NOM.valvePreFeedWaterTank.m_flow));
      ClaRa.Components.VolumesValvesFittings.Fittings.JoinVLE_L2_Y join_LP_main(volume = 0.2, m_flow_in_nom = {NOM.join_LP_main.m_flow_1, NOM.join_LP_main.m_flow_2}, p_nom = NOM.join_LP_main.p, h_nom = NOM.join_LP_main.h3, h_start = INIT.join_LP_main.h3, p_start = INIT.join_LP_main.p, initOption = 0, redeclare model PressureLossOut = Components.VolumesValvesFittings.Fittings.Fundamentals.Linear(m_flow_nom = 420));
      ClaRa.Components.Utilities.Blocks.LimPID PI_preheater1(sign = -1, Tau_d = 30, y_max = NOM.pump_preheater_LP1.P_pump * 1.5, y_min = NOM.pump_preheater_LP1.P_pump / 100, y_ref = 1e5, y_start = INIT.pump_preheater_LP1.P_pump, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 200, Tau_i = 200, initOption = 796);
      ClaRa.Visualisation.Quadruple quadruple8;
      ClaRa.Visualisation.Quadruple quadruple9;
      ClaRa.Visualisation.Quadruple quadruple10;
      ClaRa.Visualisation.Quadruple quadruple11;
      ClaRa.Visualisation.Quadruple quadruple12;
      ClaRa.Visualisation.Quadruple quadruple13;
      ClaRa.Visualisation.Quadruple quadruple14;
      Modelica.Blocks.Math.Gain Nominal_PowerFeedwaterPump1(k = NOM.Pump_FW.P_pump);
      ClaRa.Visualisation.DynDisplay valveControl_preheater_HP_display(unit = "p.u.", decimalSpaces = 1, varname = "valveControl_preheater_HP", x1 = valveControl_preheater_HP.summary.outline.opening_);
      ClaRa.Visualisation.DynDisplay electricalPower(decimalSpaces = 2, varname = "electrical Power", x1 = simpleGenerator.summary.P_el / 1e6, unit = "MW");
      StaticCycles.Check.StaticCycleExamples.InitSteamCycle_01 NOM(final P_target_ = 1, Delta_p_RS_nom = 4.91e5, efficiency_Pump_cond = 0.9, efficiency_Pump_FW = 0.9, efficiency_Turb_HP = 1, efficiency_Turb_IP1 = 1, efficiency_Turb_IP2 = 1, efficiency_Turb_IP3 = 1, efficiency_Turb_LP1 = 1, efficiency_Turb_LP2 = 1, efficiency_Turb_LP3 = 1, efficiency_Turb_LP4 = 1, efficiency_Pump_preheater_LP1 = 0.9, efficiency_Pump_preheater_LP3 = 0.9, preheater_HP_p_tap = 46e5);
      inner SimCenter simCenter(contributeToCycleSummary = true, redeclare TILMedia.VLEFluidTypes.TILMedia_InterpolatedWater fluid1, showExpertSummary = true);
      Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_IP3(allowFlowReversal = true, redeclare model Efficiency = Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.Turbine_IP1.efficiency; 1, NOM.Turbine_IP1.efficiency]), p_in_start = INIT.Turbine_IP1.p_in, p_out_start = INIT.Turbine_IP1.p_out, useMechanicalPort = true, p_nom = NOM.Turbine_IP3.p_in, m_flow_nom = NOM.Turbine_IP3.m_flow, Pi = NOM.Turbine_IP3.p_out / NOM.Turbine_IP3.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_IP3.p_in, NOM.Turbine_IP3.h_in), eta_mech = NOM.Turbine_IP3.efficiency);
      Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_IP2(allowFlowReversal = true, redeclare model Efficiency = Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.Turbine_IP1.efficiency; 1, NOM.Turbine_IP1.efficiency]), p_in_start = INIT.Turbine_IP1.p_in, p_out_start = INIT.Turbine_IP1.p_out, useMechanicalPort = true, p_nom = NOM.Turbine_IP2.p_in, m_flow_nom = NOM.Turbine_IP2.m_flow, Pi = NOM.Turbine_IP2.p_out / NOM.Turbine_IP2.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_IP2.p_in, NOM.Turbine_IP2.h_in), eta_mech = NOM.Turbine_IP2.efficiency);
      Components.VolumesValvesFittings.Fittings.SplitVLE_L2_Y split_IP2(volume = 0.1, initOption = 0, p_nom = NOM.Turbine_IP2.p_out, h_nom = NOM.Turbine_IP2.h_out, m_flow_out_nom = {NOM.Turbine_IP2.summary.outlet.m_flow, NOM.feedwatertank.m_flow_tap2}, h_start = INIT.Turbine_IP2.h_out, p_start = INIT.Turbine_IP2.p_out);
      Components.VolumesValvesFittings.Fittings.SplitVLE_L2_Y join_IP3(volume = 0.1, initOption = 0, p_nom = NOM.Turbine_IP3.p_out, h_nom = NOM.Turbine_IP3.h_out, m_flow_out_nom = {NOM.Turbine_IP3.summary.outlet.m_flow, NOM.preheater_LP1.summary.inlet_tap.m_flow}, h_start = INIT.Turbine_IP3.h_out, p_start = INIT.Turbine_IP3.p_out);
      Visualisation.Quadruple quadruple15;
      Visualisation.Quadruple quadruple16;
      Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_LP3(allowFlowReversal = true, redeclare model Efficiency = Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.Turbine_LP1.efficiency; 1, NOM.Turbine_LP1.efficiency]), p_in_start = INIT.Turbine_LP1.p_in, p_out_start = INIT.Turbine_LP1.p_out, useMechanicalPort = true, p_nom = NOM.Turbine_LP3.p_in, m_flow_nom = NOM.Turbine_LP3.m_flow, Pi = NOM.Turbine_LP3.p_out / NOM.Turbine_LP3.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_LP3.p_in, NOM.Turbine_LP3.h_in), eta_mech = NOM.Turbine_LP3.efficiency);
      Components.TurboMachines.Turbines.SteamTurbineVLE_L1 Turbine_LP2(allowFlowReversal = true, redeclare model Efficiency = Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow(eta_mflow = [0.0, NOM.Turbine_LP1.efficiency; 1, NOM.Turbine_LP1.efficiency]), p_in_start = INIT.Turbine_LP1.p_in, p_out_start = INIT.Turbine_LP1.p_out, useMechanicalPort = true, p_nom = NOM.Turbine_LP2.p_in, m_flow_nom = NOM.Turbine_LP2.m_flow, Pi = NOM.Turbine_LP2.p_out / NOM.Turbine_LP2.p_in, rho_nom = TILMedia.VLEFluidFunctions.density_phxi(simCenter.fluid1, NOM.Turbine_LP2.p_in, NOM.Turbine_LP2.h_in), eta_mech = NOM.Turbine_LP2.efficiency);
      Components.VolumesValvesFittings.Fittings.SplitVLE_L2_Y join_LP2(volume = 0.1, initOption = 0, p_nom = INIT.Turbine_LP2.p_out, h_nom = INIT.Turbine_LP2.h_out, m_flow_out_nom = {NOM.Turbine_LP2.summary.outlet.m_flow, NOM.preheater_LP3.summary.inlet_tap.m_flow}, h_start = INIT.Turbine_LP2.h_out, p_start = INIT.Turbine_LP2.p_out);
      Components.VolumesValvesFittings.Fittings.SplitVLE_L2_Y split_LP3(volume = 0.1, initOption = 0, p_nom = INIT.Turbine_LP3.p_out, h_nom = INIT.Turbine_LP3.h_out, h_start = INIT.Turbine_LP3.h_out, p_start = INIT.Turbine_LP3.p_out, m_flow_out_nom = {NOM.Turbine_LP2.summary.outlet.m_flow, NOM.preheater_LP4.summary.inlet_tap.m_flow});
      Components.VolumesValvesFittings.Valves.ValveVLE_L1 valve_LP1(checkValve = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(Delta_p_nom = NOM.valve_LP1.Delta_p, m_flow_nom = NOM.valve_LP1.m_flow));
      Components.HeatExchangers.HEXvle2vle_L3_2ph_CH_simple preheater_LP2(redeclare replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Steel, N_passes = 1, Q_flow_nom = 2e8, z_out_shell = 0.1, redeclare model HeatTransferTubes = Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2(PL_alpha = [0, 0.55; 0.5, 0.65; 0.7, 0.72; 0.8, 0.77; 1, 1], alpha_nom = 3000), redeclare model PressureLossTubes = Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L2(Delta_p_nom = 1000), Tau_cond = 0.3, Tau_evap = 0.03, redeclare model HeatTransfer_Shell = Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3(alpha_nom = {1500, 8000}), redeclare model PressureLossShell = Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3(Delta_p_nom = {100, 100, 100}), initOptionTubes = 0, initOptionShell = 204, initOptionWall = 1, levelOutput = true, length = 10, diameter = 2, z_in_shell = preheater_LP2.length, m_flow_nom_shell = NOM.preheater_LP2.m_flow_tap, p_nom_shell = NOM.preheater_LP2.p_tap, h_nom_shell = NOM.preheater_LP2.h_tap_out, p_start_shell = INIT.preheater_LP2.p_tap, diameter_i = 0.05, diameter_o = 0.052, N_tubes = 1000, z_in_tubes = preheater_LP2.diameter / 2, z_out_tubes = preheater_LP2.diameter / 2, m_flow_nom_tubes = NOM.preheater_LP2.m_flow_cond, p_nom_tubes = NOM.preheater_LP2.p_cond, h_nom_tubes = NOM.preheater_LP2.h_cond_out, h_start_tubes = INIT.preheater_LP2.h_cond_out, p_start_tubes(displayUnit = "bar") = INIT.preheater_LP2.p_cond, level_rel_start = 0.1, T_w_start = {320, 340, 360});
      Components.HeatExchangers.HEXvle2vle_L3_2ph_CU_simple preheater_LP3(redeclare replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Steel, Q_flow_nom = 2e8, z_out_shell = 0.1, redeclare model HeatTransferTubes = Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2(PL_alpha = [0, 0.55; 0.5, 0.65; 0.7, 0.72; 0.8, 0.77; 1, 1], alpha_nom = 3000), redeclare model PressureLossTubes = Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L2(Delta_p_nom = 1000), T_w_start = {300, 320, 340}, Tau_cond = 0.3, Tau_evap = 0.03, redeclare model HeatTransfer_Shell = Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3(alpha_nom = {1500, 8000}), redeclare model PressureLossShell = Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3(Delta_p_nom = {100, 100, 100}), initOptionTubes = 0, initOptionShell = 204, initOptionWall = 1, levelOutput = true, length = 10, diameter = 2, z_in_shell = preheater_LP3.length, m_flow_nom_shell = NOM.preheater_LP3.m_flow_tap, p_nom_shell = NOM.preheater_LP3.p_tap, h_nom_shell = NOM.preheater_LP3.h_tap_out, p_start_shell = INIT.preheater_LP3.p_tap, diameter_i = 0.05, diameter_o = 0.052, m_flow_nom_tubes = NOM.preheater_LP3.m_flow_cond, p_nom_tubes = NOM.preheater_LP3.p_cond, h_nom_tubes = NOM.preheater_LP3.h_cond_out, h_start_tubes = INIT.preheater_LP3.h_cond_out, p_start_tubes(displayUnit = "bar") = INIT.preheater_LP3.p_cond, level_rel_start = 0.2, equalPressures = true, N_passes = 2, N_tubes = 500, z_in_tubes = 0.1, z_out_tubes = 0.1);
      Components.HeatExchangers.HEXvle2vle_L3_2ph_CU_simple preheater_LP4(redeclare replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Steel, Q_flow_nom = 2e8, z_out_shell = 0.1, redeclare model HeatTransferTubes = Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2(PL_alpha = [0, 0.55; 0.5, 0.65; 0.7, 0.72; 0.8, 0.77; 1, 1], alpha_nom = 3000), redeclare model PressureLossTubes = Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L2(Delta_p_nom = 1000), T_w_start = {300, 320, 340}, Tau_cond = 0.3, Tau_evap = 0.03, redeclare model HeatTransfer_Shell = Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3(alpha_nom = {1500, 8000}), redeclare model PressureLossShell = Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3(Delta_p_nom = {100, 100, 100}), initOptionTubes = 0, initOptionShell = 204, initOptionWall = 1, levelOutput = true, length = 10, diameter = 2, z_in_shell = preheater_LP4.length, m_flow_nom_shell = NOM.preheater_LP4.m_flow_tap, p_nom_shell = NOM.preheater_LP4.p_tap, h_nom_shell = NOM.preheater_LP4.h_tap_out, diameter_i = 0.05, diameter_o = 0.052, m_flow_nom_tubes = NOM.preheater_LP4.m_flow_cond, p_nom_tubes = NOM.preheater_LP4.p_cond, h_nom_tubes = NOM.preheater_LP4.h_cond_out, h_start_tubes = INIT.preheater_LP4.h_cond_out, p_start_tubes(displayUnit = "bar") = INIT.preheater_LP4.p_cond, level_rel_start = 0.1, N_passes = 2, z_in_tubes = 0.1, z_out_tubes = 0.1, N_tubes = 600, p_start_shell = INIT.preheater_LP4.p_tap);
      Components.TurboMachines.Pumps.PumpVLE_L1_simple Pump_preheater_LP3(showExpertSummary = true, eta_mech = 0.9, inlet(m_flow(start = NOM.pump_preheater_LP3.summary.inlet.m_flow)), outlet(p(start = NOM.pump_preheater_LP3.summary.outlet.p)));
      Components.VolumesValvesFittings.Valves.ValveVLE_L1 valve_afterPumpLP3(redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(m_flow_nom = 30, Delta_p_nom = 1000));
      Components.VolumesValvesFittings.Valves.ValveVLE_L1 valveControl_preheater_LP2(checkValve = true, openingInputIsActive = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(CL_valve = [0, 0; 1, 1], m_flow_nom = 25, Delta_p_nom = 0.2e5));
      Components.VolumesValvesFittings.Fittings.JoinVLE_L2_Y join_preheater_LP3(volume = 0.1, initOption = 0, p_nom = NOM.join_preheater_LP3.summary.outlet.p, h_nom = NOM.join_preheater_LP3.summary.outlet.h, h_start = INIT.join_preheater_LP3.summary.outlet.h, p_start = INIT.join_preheater_LP3.summary.outlet.p, redeclare model PressureLossIn1 = Components.VolumesValvesFittings.Fittings.Fundamentals.Linear(m_flow_nom = NOM.m_flow_nom, dp_nom = 10));
      Components.VolumesValvesFittings.Valves.ValveVLE_L1 valveControl_preheater_LP4(checkValve = true, openingInputIsActive = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(m_flow_nom = 8, CL_valve = [0, 0; 1, 1], Delta_p_nom = 0.06e5));
      Components.VolumesValvesFittings.Valves.ValveVLE_L1 valve_LP2(checkValve = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(Delta_p_nom = NOM.valve_LP2.Delta_p, m_flow_nom = NOM.valve_LP2.m_flow));
      Components.VolumesValvesFittings.Valves.ValveVLE_L1 valve_LP3(checkValve = true, redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(Delta_p_nom = NOM.valve_LP3.Delta_p, m_flow_nom = NOM.valve_LP3.m_flow));
      Components.BoundaryConditions.BoundaryVLE_Txim_flow boundaryVLE_Txim_flow(T_const = 273.15 + 15, m_flow_const = 25000);
      Components.BoundaryConditions.BoundaryVLE_phxi boundaryVLE_phxi(p_const = 2e5);
      Components.Utilities.Blocks.LimPID PID_preheaterLP4(sign = -1, u_ref = 0.1, y_ref = 1, y_max = 1, y_start = 1, controllerType = Modelica.Blocks.Types.SimpleController.PI, Tau_in = 0.8, Tau_out = 0.8, y_min = 0, Tau_i = 15, t_activation = 5, k = 0.2, initOption = 796);
      Modelica.Blocks.Sources.RealExpression setPoint_preheaterLP4(y = 0.1);
      Components.Utilities.Blocks.LimPID PID_preheaterLP3(u_ref = 0.2, Tau_in = 0.8, Tau_out = 0.8, sign = -1, t_activation = 2, use_activateInput = false, y_ref = 150000, y_inactive = 150000, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 1, y_min = 2000, y_max = 10e6, y_start = INIT.pump_preheater_LP3.P_pump, Tau_i = 30, initOption = 796);
      Modelica.Blocks.Sources.RealExpression setPoint_preheaterLP3(y = 0.1);
      Components.Utilities.Blocks.LimPID PID_NDVW3(Tau_in = 0.8, Tau_out = 0.8, sign = -1, controllerType = Modelica.Blocks.Types.SimpleController.PI, u_ref = 0.1, y_ref = 1, y_max = 1, y_min = 0, y_start = 1, k = 0.5, Tau_i = 20, initOption = 796);
      Modelica.Blocks.Sources.RealExpression setPoint_preheaterLP2(y = 0.1);
      Modelica.Blocks.Sources.RealExpression setPoint_preheaterLP1(y = 0.1);
      Modelica.Blocks.Sources.RealExpression setPoint_condenser(y = 0.5 / 6);
      Visualisation.Quadruple quadruple17;
      Visualisation.Quadruple quadruple18;
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 2000, phi(start = 0));
      Components.Electrical.SimpleGenerator simpleGenerator(hasInertia = true);
      Components.BoundaryConditions.BoundaryElectricFrequency boundaryElectricFrequency;
      Visualisation.Quadruple quadruple19;
      Visualisation.Quadruple quadruple20;
      Visualisation.Quadruple quadruple21;
      Visualisation.DynamicBar fillingLevel_preheater_LP1(u_set = 0.1, u_high = 0.2, u_low = 0.05, provideInputConnectors = true);
      Visualisation.DynamicBar fillingLevel_preheater_LP2(u_set = 0.1, u_high = 0.2, u_low = 0.05, provideInputConnectors = true);
      Visualisation.DynamicBar fillingLevel_preheater_LP3(u_set = 0.1, u_high = 0.2, u_low = 0.05, provideInputConnectors = true);
      Visualisation.DynamicBar fillingLevel_preheater_LP4(u_set = 0.1, u_high = 0.2, u_low = 0.05, provideInputConnectors = true);
      Visualisation.DynamicBar fillingLevel_condenser(u_set = 0.5 / 6, u_high = 0.5 / 3, u_low = 0.5 / 12, provideInputConnectors = true);
      Visualisation.DynamicBar fillingLevel_preheater_HP(provideInputConnectors = true, u_set = 0.5, u_high = 0.6, u_low = 0.4);
      Visualisation.DynDisplay valveControl_preheater_LP4_display(unit = "p.u.", decimalSpaces = 1, varname = "valveControl_preheater_LP4", x1 = valveControl_preheater_LP4.summary.outline.opening_);
      Visualisation.DynDisplay valveControl_preheater_LP2_display2(unit = "p.u.", decimalSpaces = 1, varname = "valveControl_preheater_LP2", x1 = valveControl_preheater_LP2.summary.outline.opening_);
      ClaRa.Visualisation.Quadruple quadruple22;
      ClaRa.Visualisation.Quadruple quadruple23;
      ClaRa.Visualisation.Quadruple quadruple24;
      Modelica.Blocks.Sources.TimeTable PTarget(table = [0, 1; 500, 1; 510, 0.7; 1400, 0.7; 1410, 1; 2300, 1; 2310, 0.7; 3200, 0.7; 3210, 1; 5000, 1]);
      Components.VolumesValvesFittings.Pipes.PipeFlowVLE_L4_Simple downComer_feedWaterTank(m_flow_nom = NOM.downComer_feedWaterTank.summary.outlet.m_flow, p_nom = ones(downComer_feedWaterTank.geo.N_cv) * NOM.downComer_feedWaterTank.summary.outlet.p, h_nom = ones(downComer_feedWaterTank.geo.N_cv) * NOM.downComer_feedWaterTank.summary.outlet.h, length = downComer_feedWaterTank.z_in - downComer_feedWaterTank.z_out, diameter_i = 0.2, h_start = ones(downComer_feedWaterTank.geo.N_cv) * INIT.downComer_feedWaterTank.summary.inlet.h, z_in = NOM.downComer_z_in, z_out = NOM.downComer_z_out, p_start = linspace(INIT.downComer_feedWaterTank.summary.inlet.p, INIT.downComer_feedWaterTank.summary.outlet.p, downComer_feedWaterTank.geo.N_cv), frictionAtInlet = true);
      Visualisation.Quadruple quadruple25;
      Components.VolumesValvesFittings.Valves.ValveVLE_L1 valveControl_preheater_LP1(redeclare model PressureLoss = Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint(CL_valve = [0, 0; 1, 1], Delta_p_nom = 1000, m_flow_nom = 25000));
    equation
      connect(steamGenerator.reheat_out, Turbine_IP1.inlet);
      connect(Pump_FW.outlet, preheater_HP.In2);
      connect(preheater_HP.Out2, steamGenerator.feedwater);
      connect(valve_HP.outlet, preheater_HP.In1);
      connect(preheater_HP.Out2, statePoint.port);
      connect(preheater_LP1.In1, valve_IP2.outlet);
      connect(preheater_LP1.Out1, Pump_preheater_LP1.inlet);
      connect(PI_valveControl_preheater_HP.y, valveControl_preheater_HP.opening_in);
      connect(measurement.y, PI_Pump_cond.u_m);
      connect(join_LP1.inlet, Turbine_LP1.outlet);
      connect(join_HP.inlet, Turbine_HP1.outlet);
      connect(join_HP.outlet1, steamGenerator.reheat_in);
      connect(join_HP.outlet2, valve_HP.inlet);
      connect(valvePreFeedWaterTank.inlet, preheater_LP1.Out2);
      connect(valvePreFeedWaterTank.outlet, join_LP_main.inlet1);
      connect(PI_Pump_cond.y, Pump_cond.P_drive);
      connect(PI_preheater1.y, Pump_preheater_LP1.P_drive);
      connect(steamGenerator.eye_LS, quadruple2.eye);
      connect(steamGenerator.eye_RH, quadruple1.eye);
      connect(Turbine_HP1.eye, quadruple4.eye);
      connect(Turbine_IP1.eye, quadruple3.eye);
      connect(Turbine_LP1.eye, quadruple7.eye);
      connect(Turbine_LP4.eye, quadruple.eye);
      connect(quadruple6.eye, feedWaterTank.eye);
      connect(quadruple8.eye, valve_IP1.eye);
      connect(quadruple9.eye, valve_IP2.eye);
      connect(valve_HP.eye, quadruple11.eye);
      connect(quadruple12.eye, valveControl_preheater_HP.eye);
      connect(quadruple13.eye, Pump_cond.eye);
      connect(quadruple14.eye, Pump_preheater_LP1.eye);
      connect(preheater_HP.Out1, valveControl_preheater_HP.inlet);
      connect(Nominal_PowerFeedwaterPump1.y, Pump_FW.P_drive);
      connect(Pump_preheater_LP1.outlet, join_LP_main.inlet2);
      connect(join_LP_main.outlet, feedWaterTank.condensate);
      connect(Turbine_IP2.outlet, split_IP2.inlet);
      connect(split_IP2.outlet1, Turbine_IP3.inlet);
      connect(Turbine_IP3.outlet, join_IP3.inlet);
      connect(Turbine_IP2.eye, quadruple15.eye);
      connect(Turbine_IP3.eye, quadruple16.eye);
      connect(split_IP2.outlet2, valve_IP1.inlet);
      connect(join_IP3.outlet1, Turbine_LP1.inlet);
      connect(Turbine_LP2.outlet, join_LP2.inlet);
      connect(join_LP2.outlet1, Turbine_LP3.inlet);
      connect(split_LP3.outlet1, Turbine_LP4.inlet);
      connect(Turbine_LP3.outlet, split_LP3.inlet);
      connect(preheater_LP2.Out2, preheater_LP1.In2);
      connect(preheater_LP2.In1, valve_LP1.outlet);
      connect(preheater_LP2.Out1, valveControl_preheater_LP2.inlet);
      connect(valveControl_preheater_LP2.outlet, preheater_LP3.aux1);
      connect(join_preheater_LP3.outlet, preheater_LP2.In2);
      connect(join_preheater_LP3.inlet1, preheater_LP3.Out2);
      connect(preheater_LP3.Out1, Pump_preheater_LP3.inlet);
      connect(Pump_preheater_LP3.outlet, valve_afterPumpLP3.inlet);
      connect(valve_afterPumpLP3.outlet, join_preheater_LP3.inlet2);
      connect(preheater_LP4.Out2, preheater_LP3.In2);
      connect(join_IP3.outlet2, valve_IP2.inlet);
      connect(join_LP1.outlet2, valve_LP1.inlet);
      connect(join_LP2.outlet2, valve_LP2.inlet);
      connect(split_LP3.outlet2, valve_LP3.inlet);
      connect(valve_LP2.outlet, preheater_LP3.In1);
      connect(valve_LP3.outlet, preheater_LP4.In1);
      connect(Turbine_LP4.outlet, condenser.In1);
      connect(condenser.eye1, quadruple5.eye);
      connect(boundaryVLE_Txim_flow.steam_a, condenser.In2);
      connect(Pump_cond.outlet, preheater_LP4.In2);
      connect(preheater_LP4.Out1, valveControl_preheater_LP4.inlet);
      connect(valveControl_preheater_LP4.outlet, condenser.aux1);
      connect(condenser.Out1, Pump_cond.inlet);
      connect(preheater_LP4.level, PID_preheaterLP4.u_m);
      connect(setPoint_preheaterLP4.y, PID_preheaterLP4.u_s);
      connect(PID_preheaterLP4.y, valveControl_preheater_LP4.opening_in);
      connect(preheater_LP3.level, PID_preheaterLP3.u_m);
      connect(PID_preheaterLP3.y, Pump_preheater_LP3.P_drive);
      connect(setPoint_preheaterLP3.y, PID_preheaterLP3.u_s);
      connect(PID_NDVW3.y, valveControl_preheater_LP2.opening_in);
      connect(preheater_LP2.level, PID_NDVW3.u_m);
      connect(setPoint_preheaterLP2.y, PID_NDVW3.u_s);
      connect(preheater_LP1.level, PI_preheater1.u_m);
      connect(setPoint_preheaterLP1.y, PI_preheater1.u_s);
      connect(condenser.level, measurement.u);
      connect(setPoint_condenser.y, PI_Pump_cond.u_s);
      connect(Turbine_LP3.eye, quadruple18.eye);
      connect(Turbine_LP2.eye, quadruple17.eye);
      connect(Turbine_HP1.shaft_b, Turbine_IP1.shaft_a);
      connect(Turbine_IP1.shaft_b, Turbine_IP2.shaft_a);
      connect(Turbine_IP2.shaft_b, Turbine_IP3.shaft_a);
      connect(Turbine_IP3.shaft_b, Turbine_LP1.shaft_a);
      connect(Turbine_LP1.shaft_b, Turbine_LP2.shaft_a);
      connect(Turbine_LP2.shaft_b, Turbine_LP3.shaft_a);
      connect(Turbine_LP3.shaft_b, Turbine_LP4.shaft_a);
      connect(Turbine_LP4.shaft_b, inertia.flange_a);
      connect(inertia.flange_b, simpleGenerator.shaft);
      connect(simpleGenerator.powerConnection, boundaryElectricFrequency.electricPortIn);
      connect(valve_LP1.eye, quadruple19.eye);
      connect(valve_LP2.eye, quadruple20.eye);
      connect(valve_LP3.eye, quadruple21.eye);
      connect(preheater_HP.level, PI_valveControl_preheater_HP.u_s);
      connect(setPoint_preheater_HP.y, PI_valveControl_preheater_HP.u_m);
      connect(preheater_LP1.level, fillingLevel_preheater_LP1.u_in);
      connect(preheater_LP2.level, fillingLevel_preheater_LP2.u_in);
      connect(preheater_LP3.level, fillingLevel_preheater_LP3.u_in);
      connect(preheater_LP4.level, fillingLevel_preheater_LP4.u_in);
      connect(condenser.level, fillingLevel_condenser.u_in);
      connect(preheater_HP.level, fillingLevel_preheater_HP.u_in);
      connect(Turbine_IP1.outlet, Turbine_IP2.inlet);
      connect(join_LP1.outlet1, Turbine_LP2.inlet);
      connect(preheater_LP1.eye2, quadruple10.eye);
      connect(preheater_LP2.eye2, quadruple22.eye);
      connect(preheater_LP3.eye2, quadruple23.eye);
      connect(preheater_LP4.eye2, quadruple24.eye);
      connect(PTarget.y, steamGenerator.QF_setl_);
      connect(PTarget.y, Nominal_PowerFeedwaterPump1.u);
      connect(steamGenerator.livesteam, Turbine_HP1.inlet);
      connect(downComer_feedWaterTank.outlet, Pump_FW.inlet);
      connect(feedWaterTank.feedwater, downComer_feedWaterTank.inlet);
      connect(preheater_HP.eye2, quadruple25.eye);
      connect(valve_IP1.outlet, feedWaterTank.heatingSteam);
      connect(valveControl_preheater_HP.outlet, feedWaterTank.aux);
      connect(valveControl_preheater_LP1.outlet, boundaryVLE_phxi.steam_a);
      connect(condenser.Out2, valveControl_preheater_LP1.inlet);
      annotation(experiment(StopTime = 5000, __Dymola_NumberOfIntervals = 5000, Tolerance = 1e-05, __Dymola_Algorithm = "Dassl"), __Dymola_experimentSetupOutput(equidistant = false)); 
    end SteamCycle_01;
  end Examples;

  package Basics  "Fundamental classes like functions and records" 
    extends ClaRa.Basics.Icons.PackageIcons.Basics100;

    package Records  
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;

      model FlangeVLE  "A summary of flange flow properties" 
        extends Icons.RecordIcon;
        parameter Boolean showExpertSummary = false;
        input Units.MassFlowRate m_flow "Mass flow rate";
        input Units.Temperature T "Temperature";
        input Units.Pressure p "Pressure";
        input Units.EnthalpyMassSpecific h "Specific enthalpy";
        input Units.EntropyMassSpecific s if showExpertSummary "Specific entropy";
        input Units.MassFraction steamQuality if showExpertSummary "Steam quality";
        input Units.Power H_flow if showExpertSummary "Enthalpy flow rate";
        input Units.DensityMassSpecific rho if showExpertSummary "Density";
      end FlangeVLE;

      model FluidVLE_L2  "A record for basic VLE fluid data from L2-type models" 
        extends Icons.RecordIcon;
        parameter Boolean showExpertSummary = false;
        input Units.Mass mass "System mass";
        input Units.Temperature T "System temperature";
        input Units.Temperature T_sat if showExpertSummary "System saturation temperature";
        input Units.Pressure p "System pressure";
        input Units.EnthalpyMassSpecific h "System specific enthalpy";
        input Units.EnthalpyMassSpecific h_bub if showExpertSummary "Bubble specific enthalpy";
        input Units.EnthalpyMassSpecific h_dew if showExpertSummary "Dew specific enthalpy";
        input Units.EntropyMassSpecific s if showExpertSummary "System specific entropy";
        input Units.MassFraction steamQuality if showExpertSummary "Steam quality";
        input Modelica.SIunits.Enthalpy H if showExpertSummary "System enthalpy";
        input Units.DensityMassSpecific rho if showExpertSummary "Density";
      end FluidVLE_L2;

      model FluidVLE_L34  "A record for basic VLE fluid data from L3 and L4-type models" 
        extends Icons.RecordIcon;
        parameter Boolean showExpertSummary = false;
        parameter Integer N_cv "Number of zones or nodes";
        input Units.Mass[N_cv] mass "System mass";
        input Units.Temperature[N_cv] T "System temperature";
        input Units.Temperature[N_cv] T_sat if showExpertSummary "System saturation temperature";
        input Units.Pressure[N_cv] p "System pressure";
        input Units.EnthalpyMassSpecific[N_cv] h "System specific enthalpy";
        input Units.EnthalpyMassSpecific[N_cv] h_bub if showExpertSummary "Bubble specific enthalpy";
        input Units.EnthalpyMassSpecific[N_cv] h_dew if showExpertSummary "Dew specific enthalpy";
        input Units.EntropyMassSpecific[N_cv] s if showExpertSummary "System specific entropy";
        input Units.MassFraction[N_cv] steamQuality if showExpertSummary;
        input Modelica.SIunits.Enthalpy[N_cv] H if showExpertSummary "System enthalpy";
        input Units.DensityMassSpecific[N_cv] rho if showExpertSummary;
      end FluidVLE_L34;

      record IComBase_L2  "Basic internal communication record" 
        extends ClaRa.Basics.Icons.IComIcon;
        .ClaRa.Basics.Units.Pressure p_in "Inlet pressure";
        .ClaRa.Basics.Units.Temperature T_in "Inlet Temperature";
        .ClaRa.Basics.Units.MassFlowRate m_flow_in "Inlet mass flow";
        .ClaRa.Basics.Units.Pressure p_out "Outlet pressure";
        .ClaRa.Basics.Units.Temperature T_out "Outlet Temperature";
        .ClaRa.Basics.Units.MassFlowRate m_flow_out "Outlet mass flow";
        .ClaRa.Basics.Units.Temperature T_bulk "Bulk Temperature";
        .ClaRa.Basics.Units.Pressure p_bulk "Outlet pressure";
        parameter .ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal pressure";
        parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 10 "Nominal mass flow";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_nom = 1e4 "Nominal enthalpy";
        parameter .ClaRa.Basics.Units.MassFraction[:] xi_nom = {1} "Nominal mass fraction";
        annotation(defaultComponentPrefixes = "inner"); 
      end IComBase_L2;

      record IComVLE_L2  "Basic internal communication record for heat transfer" 
        extends ClaRa.Basics.Records.IComBase_L2;
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid mediumModel "Used medium model";
        TILMedia.VLEFluidObjectFunctions.VLEFluidPointer fluidPointer_bulk "Pointer to bulk gas object";
        .ClaRa.Basics.Units.EnthalpyMassSpecific h_bulk "Inlet enthalpy";
        .ClaRa.Basics.Units.MassFraction[mediumModel.nc - 1] xi_bulk "Inlet medium composition";
        .ClaRa.Basics.Units.Mass mass "||Mass of system|";
        TILMedia.VLEFluidObjectFunctions.VLEFluidPointer fluidPointer_in "Pointer to inlet gas object";
        .ClaRa.Basics.Units.EnthalpyMassSpecific h_in "Inlet enthalpy";
        .ClaRa.Basics.Units.MassFraction[mediumModel.nc - 1] xi_in "Inlet medium composition";
        TILMedia.VLEFluidObjectFunctions.VLEFluidPointer fluidPointer_out "Pointer to outlet gas object";
        .ClaRa.Basics.Units.EnthalpyMassSpecific h_out "Outlet enthalpy";
        .ClaRa.Basics.Units.MassFraction[mediumModel.nc - 1] xi_out "Outlet medium composition";
        annotation(defaultComponentPrefixes = "inner"); 
      end IComVLE_L2;

      record IComBase_L3  
        extends ClaRa.Basics.Icons.IComIcon;
        parameter Integer N_cv = 2 "Number of zones";
        parameter Integer N_inlet = 1 "Number of inlet ports";
        parameter Integer N_outlet = 1 "Number of outlet ports";
        .ClaRa.Basics.Units.Pressure[N_inlet] p_in "|Inlet||Inlet pressure";
        .ClaRa.Basics.Units.Temperature[N_inlet] T_in "|Inlet||Inlet Temperature";
        .ClaRa.Basics.Units.MassFlowRate[N_inlet] m_flow_in "|Inlet||Inlet mass flow";
        .ClaRa.Basics.Units.Pressure[N_outlet] p_out "|Outlet||Outlet pressure";
        .ClaRa.Basics.Units.Temperature[N_outlet] T_out "|Outlet||Outlet Temperature";
        .ClaRa.Basics.Units.MassFlowRate[N_outlet] m_flow_out "|Outlet||Outlet mass flow";
        .ClaRa.Basics.Units.Temperature[N_cv] T "|System||Bulk Temperature";
        .ClaRa.Basics.Units.Pressure[N_cv] p "|System||Outlet pressure";
        parameter .ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal pressure";
        parameter .ClaRa.Basics.Units.PressureDifference Delta_p_nom = 1e4 "Nominal pressure";
        parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 1 "Nominal mass flow";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_nom = 1e4 "Nominal enthalpy";
        parameter .ClaRa.Basics.Units.MassFraction[:] xi_nom = {1} "Nominal mass fraction";
        annotation(defaultComponentPrefixes = "inner"); 
      end IComBase_L3;

      record IComVLE_L3  
        extends IComBase_L3;
        TILMedia.VLEFluidTypes.BaseVLEFluid mediumModel "Used medium model";
        TILMedia.VLEFluidObjectFunctions.VLEFluidPointer[N_inlet] fluidPointer_in "|Inlet||Fluid pointer of inlet ports";
        TILMedia.VLEFluidObjectFunctions.VLEFluidPointer[N_outlet] fluidPointer_out "|Outlet||Fluid pointer of outlet ports";
        ClaRa.Basics.Units.EnthalpyMassSpecific[N_cv] h "|System||Specific enthalpy of liquid and vapour zone";
        .ClaRa.Basics.Units.MassFraction[N_cv, mediumModel.nc - 1] xi "Medium composition";
        TILMedia.VLEFluidObjectFunctions.VLEFluidPointer[N_cv] fluidPointer "|System||Fluid pointer of outlet ports";
        ClaRa.Basics.Units.Volume[N_cv] volume "|System||Volume of liquid and vapour zone";
        .ClaRa.Basics.Units.EnthalpyMassSpecific[N_inlet] h_in "|Inlet||Fluid pointer of inlet ports";
        .ClaRa.Basics.Units.EnthalpyMassSpecific[N_outlet] h_out "|Outlet||Fluid pointer of outlet ports";
        .ClaRa.Basics.Units.MassFraction[N_inlet, mediumModel.nc - 1] xi_in "|Inlet||Inlet medium composition";
        .ClaRa.Basics.Units.MassFraction[N_outlet, mediumModel.nc - 1] xi_out "|Outlet||Outlet medium composition";
      end IComVLE_L3;

      record IComVLE_L3_NPort  
        extends IComVLE_L3;
      end IComVLE_L3_NPort;

      record IComVLE_L3_OnePort  
        extends IComVLE_L3(final N_inlet = 1, final N_outlet = 1);
      end IComVLE_L3_OnePort;

      model StaCyFlangeVLE  "A summary of flange flow properties for StaCy components" 
        extends Icons.RecordIcon;
        parameter Units.MassFlowRate m_flow "Mass flow rate";
        parameter Units.Pressure p "Pressure";
        parameter Units.EnthalpyMassSpecific h "Specific enthalpy";
      end StaCyFlangeVLE;
    end Records;

    package Functions  
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;

      function Stepsmoother  "Continouus interpolation for x " 
        extends ClaRa.Basics.Icons.Function;
        input Real func "input for that result = 1";
        input Real nofunc "input for that result = 0";
        input Real x "input for interpolation";
        output Real result;
      protected
        Real m = Modelica.Constants.pi / (func - nofunc);
        Real b = (-Modelica.Constants.pi / 2) - m * nofunc;
        Real r_1 = tan(m * x + b);
      algorithm
        result := if x >= 0.999 * (func - nofunc) + nofunc and func > nofunc or x <= 0.999 * (func - nofunc) + nofunc and nofunc > func then 1 else if x <= 0.001 * (func - nofunc) + nofunc and func > nofunc or x >= 0.001 * (func - nofunc) + nofunc and nofunc > func then 0 else (0.5 * (exp(r_1) - exp(-r_1)) / (0.5 * (exp(r_1) + exp(-r_1))) + 1) / 2;
        annotation(derivative = Stepsmoother_der, Window(x = 0.01, y = 0.09, width = 0.66, height = 0.6)); 
      end Stepsmoother;

      function Stepsmoother_der  "Time derivative of continouus interpolation for x" 
        extends ClaRa.Basics.Icons.Function;
        input Real func "input for that result = 1";
        input Real nofunc "input for that result = 0";
        input Real x "input for interpolation";
        input Real dfunc "derivative of func";
        input Real dnofunc "derivative of nofunc";
        input Real dx "derivative of x";
        output Real dresult;
      protected
        Real m = Modelica.Constants.pi / (func - nofunc);
        Real b = (-Modelica.Constants.pi / 2) - m * nofunc;
      algorithm
        dresult := if x >= 0.999 * (func - nofunc) + nofunc and func > nofunc or x <= 0.999 * (func - nofunc) + nofunc and nofunc > func or x <= 0.001 * (func - nofunc) + nofunc and func > nofunc or x >= 0.001 * (func - nofunc) + nofunc and nofunc > func then 0 else (1 - Modelica.Math.tanh(Modelica.Math.tan(m * x + b)) ^ 2) * (1 + Modelica.Math.tan(m * x + b) ^ 2) * m * (dx - dnofunc + m / Modelica.Constants.pi * (dnofunc - dfunc) * (x - nofunc)) / 2;
        annotation(Window(x = 0.01, y = 0.09, width = 0.66, height = 0.6)); 
      end Stepsmoother_der;

      function ThermoRoot  "Numerical square root function" 
        extends ClaRa.Basics.Icons.Function;
        input Real x "Input for square root calculation";
        input Real deltax "Interpolation region";
        output Real y;
      protected
        Real C3;
        Real C1;
        Real deltax2;
        Real adeltax;
        Real sqrtdeltax;
      algorithm
        adeltax := abs(deltax);
        if x > adeltax then
          y := sqrt(x);
        elseif x < (-adeltax) then
          y := -sqrt(-x);
        elseif abs(x) <= 0.0 then
          y := 0.0;
        else
          deltax2 := adeltax * adeltax;
          sqrtdeltax := sqrt(adeltax);
          C3 := -0.25 / (sqrtdeltax * deltax2);
          C1 := 0.5 / sqrtdeltax - 3.0 * C3 * deltax2;
          y := (C1 + C3 * x * x) * x;
        end if;
        annotation(derivative = ThermoRoot_der); 
      end ThermoRoot;

      function ThermoRoot_der  "Derivative of square root function with linear interpolation near 0" 
        extends ClaRa.Basics.Icons.Function;
        input Real x;
        input Real deltax;
        input Real dx;
        input Real ddeltax;
        output Real dy;
      protected
        Real C3;
        Real C1;
        Real deltax2;
        Real adeltax;
        Real sqrtdeltax;
      algorithm
        adeltax := abs(deltax);
        if x > adeltax then
          dy := dx / (2 * sqrt(x));
        elseif x < (-adeltax) then
          dy := dx / (2 * sqrt(-x));
        elseif abs(x) <= 0.0 then
          dy := 0.0;
        else
          deltax2 := adeltax * adeltax;
          sqrtdeltax := sqrt(adeltax);
          C3 := -0.25 / (sqrtdeltax * deltax2);
          C1 := 0.5 / sqrtdeltax - 3.0 * C3 * deltax2;
          dy := dx * (C1 + 3 * C3 * x * x);
        end if;
      end ThermoRoot_der;

      function GenerateGrid  "Generate grid discretization from scale functions" 
        extends ClaRa.Basics.Icons.Function;
        input Real[:] SizeFunc "array determining number and kind of different stretchings to be applied";
        input Real L "length in discretization direction";
        input Integer N "number of cells in grid";
        output Real[N] dx "resulting grid";
      protected
        Integer N_sub "number of regions into which the grid shall be subdivided";
        Integer[N] N_cv_sub = zeros(N);
        Integer offset "Offset for discretization interval used in computation of dx[N] by going through the subdivisions";
        Real remainder "Auxilliary variable: normalised remainder";
        Real normalConst "Auxilliary variable: normalising constant";
      algorithm
        assert(L > 0, "Length of discretisation interval must be greater than zero!");
        N_sub := size(SizeFunc, 1);
        remainder := 0;
        if N_sub == 1 then
          N_cv_sub[N_sub] := N;
        else
          for i in 1:N_sub - 1 loop
            remainder := remainder + rem(N, N_sub) / N_sub;
            if remainder > 0.5 then
              N_cv_sub[i] := div(N, N_sub) + 1;
              remainder := remainder - 1;
            else
              N_cv_sub[i] := div(N, N_sub);
            end if;
          end for;
          N_cv_sub[N_sub] := N;
          for i in 1:N_sub - 1 loop
            N_cv_sub[N_sub] := N_cv_sub[N_sub] - N_cv_sub[i];
          end for;
        end if;
        offset := 0;
        for i in 1:N_sub loop
          normalConst := 0;
          for k in 1:N_cv_sub[i] loop
            normalConst := normalConst + k ^ abs(SizeFunc[i]);
          end for;
          if SizeFunc[i] >= 0 then
            for j in 1:N_cv_sub[i] loop
              dx[offset + j] := L / N_sub * j ^ SizeFunc[i] / normalConst;
            end for;
          else
            for j in 1:N_cv_sub[i] loop
              dx[offset + j] := L / N_sub * (N_cv_sub[i] + 1 - j) ^ (-SizeFunc[i]) / normalConst;
            end for;
          end if;
          offset := offset + N_cv_sub[i];
        end for;
      end GenerateGrid;

      function SmoothZeroTransition  "Ensure a smooth transition from y(x<0) to y(x>0) with linear behaviour around x=0" 
        extends ClaRa.Basics.Icons.Function;
        input Real posValue "Value for x > eps";
        input Real negValue "Value for x < -eps";
        input Real x "Input for evaluation";
        input Real eps = 1e-4 "Linearisation between -eps and +eps";
        output Real result "Output of evaluation";
      algorithm
        result := .ClaRa.Basics.Functions.Stepsmoother(eps, -eps, x) * posValue + .ClaRa.Basics.Functions.Stepsmoother(-eps, eps, x) * negValue;
      end SmoothZeroTransition;

      function maxAbs  "Returns signed maximum of the absolute input values" 
        extends ClaRa.Basics.Icons.Function;
        input Real x1 "Real input 1";
        input Real x2 "Real input 2";
        input Real eps = 1e-6 "Linearisation region";
        output Real maxOfx1x2 "Output";
      algorithm
        maxOfx1x2 := .ClaRa.Basics.Functions.SmoothZeroTransition(x1, x2, abs(x1) - abs(x2), eps);
      end maxAbs;

      function minAbs  "Returns signed minimum of the absolute input values" 
        extends ClaRa.Basics.Icons.Function;
        input Real x1 "Real input 1";
        input Real x2 "Real input 2";
        input Real eps = 1e-6 "Linearisation region";
        output Real minOfx1x2 "Output";
      algorithm
        minOfx1x2 := .ClaRa.Basics.Functions.SmoothZeroTransition(x2, x1, abs(x1) - abs(x2), eps);
      end minAbs;

      function pressureInterpolation  "Finds pressure values in discretised volumes" 
        extends ClaRa.Basics.Icons.Function;
        input ClaRa.Basics.Units.Pressure p_inlet "Pressure at inlet";
        input ClaRa.Basics.Units.Pressure p_outlet "Pressure at outlet";
        input ClaRa.Basics.Units.Length[:] Delta_x "Discretisation scheme";
        input Boolean frictionAtInlet "True if pressure loss between first cell and inlet shall be considered";
        input Boolean frictionAtOutlet "True if pressure loss between last cell and outlet shall be considered";
        output Real[size(Delta_x, 1)] p_i "Pressure in discrete Volumes i";
      protected
        Integer N_cv = size(Delta_x, 1) "Number of discrete volumes in original discretisation scheme";
        ClaRa.Basics.Units.Length[N_cv + 1] Delta_x_internal "Internal discretisation scheme";
        ClaRa.Basics.Units.Pressure[N_cv + 1] p_i_internal "Pressures in internal discrete volumes i";
        ClaRa.Basics.Units.Length[N_cv + 1] x_i_internal "Absolute internal grid points";
      algorithm
        Delta_x_internal[1] := Delta_x[1] / 2;
        for i in 2:N_cv loop
          Delta_x_internal[i] := Delta_x[i - 1] / 2 + Delta_x[i] / 2;
        end for;
        Delta_x_internal[end] := Delta_x[end] / 2;
        for i in 1:N_cv + 1 loop
          x_i_internal[i] := sum(Delta_x_internal[1:i]);
        end for;
        if frictionAtInlet and frictionAtOutlet then
          p_i_internal := ClaRa.Basics.Functions.vectorInterpolation(x_i_internal, 0, p_inlet, x_i_internal[end], p_outlet);
        elseif not frictionAtInlet and frictionAtOutlet then
          p_i_internal := ClaRa.Basics.Functions.vectorInterpolation(x_i_internal, x_i_internal[1], p_inlet, x_i_internal[end], p_outlet);
        elseif frictionAtInlet and not frictionAtOutlet then
          p_i_internal := ClaRa.Basics.Functions.vectorInterpolation(x_i_internal, 0, p_inlet, x_i_internal[end - 1], p_outlet);
        else
          p_i_internal := ClaRa.Basics.Functions.vectorInterpolation(x_i_internal, x_i_internal[1], p_inlet, x_i_internal[end - 1], p_outlet);
        end if;
        p_i := p_i_internal[1:end - 1];
      end pressureInterpolation;

      function vectorInterpolation  "Linear inter-/extrapolation of function values (x_i | f_i) between (x_1 | f_1) and (x_n | f_n)" 
        extends ClaRa.Basics.Icons.Function;
        input Real[:] x_i "Grid points to calculate function values for";
        input Real x_1 "First grid point";
        input Real f_1 "Function value for first grid point";
        input Real x_n "Last grid point";
        input Real f_n "Function value for last grid point";
        output Real[size(x_i, 1)] f_i "Returned function values";
      protected
        Integer N_cv = size(x_i, 1) "Number of grid points";
        Real dfdx = (f_n - f_1) / max(x_n - x_1, Modelica.Constants.eps) "Function slope";
        Real[N_cv] dx_i = x_i - ones(N_cv) * x_1 "Relative grid points";
        Real[N_cv, N_cv] identity_dfdx = identity(N_cv) * dfdx "Identity matrix of slope";
      algorithm
        f_i := identity_dfdx * dx_i + ones(N_cv) * f_1;
      end vectorInterpolation;
    end Functions;

    package Interfaces  
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;

      connector FluidPortIn  
        TILMedia.VLEFluidTypes.BaseVLEFluid Medium "Medium model";
        flow Modelica.SIunits.MassFlowRate m_flow "Mass flow rate from the connection point into the component";
        Modelica.SIunits.AbsolutePressure p "Thermodynamic pressure in the connection point";
        stream Modelica.SIunits.SpecificEnthalpy h_outflow "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
        stream Modelica.SIunits.MassFraction[Medium.nc - 1] xi_outflow "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
      end FluidPortIn;

      connector FluidPortOut  
        extends ClaRa.Basics.Interfaces.FluidPortIn;
      end FluidPortOut;

      connector HeatPort_a  
        extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
      end HeatPort_a;

      connector HeatPort_b  
        extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
      end HeatPort_b;

      model Connected2SimCenter  
        input Modelica.SIunits.Power powerIn = 1e-3;
        input Modelica.SIunits.Power powerOut = 0;
        input Modelica.SIunits.Power powerAux = 0;
        outer SimCenter simCenter;
        ClaRa.Basics.Interfaces.CycleSumModel cycleSumModel;
      equation
        cycleSumModel.cycleSumPort.power_in = powerIn;
        cycleSumModel.cycleSumPort.power_out = powerOut;
        cycleSumModel.cycleSumPort.power_aux = powerAux;
        connect(simCenter.cycleSumPort, cycleSumModel.cycleSumPort);
      end Connected2SimCenter;

      model CycleSumModel  
        ClaRa.Basics.Interfaces.CycleSumPort cycleSumPort;
      end CycleSumModel;

      connector CycleSumPort  
        flow .ClaRa.Basics.Units.Power power_in;
        flow .ClaRa.Basics.Units.Power power_out;
        flow .ClaRa.Basics.Units.Power power_aux;
      end CycleSumPort;

      expandable connector EyeIn  "Signal bus featuring pressure, specific enthalpy, temperature, specific entropy and mass flow rate" 
        input Real p "Pressure in bar" annotation(HideResult = false);
        input Real h "Specific enthalpy in kJ/kg" annotation(HideResult = false);
        input Real m_flow "Mass flow rate in kg/s" annotation(HideResult = false);
        input .ClaRa.Basics.Units.Temperature_DegC T "Tempearture in degC" annotation(HideResult = false);
        input Real s "Specific entropy in kJ/kgK" annotation(HideResult = false);
      end EyeIn;

      expandable connector EyeOut  "Signal bus featuring pressure, specific enthalpy,temperature, specific entropy andmass flow rate" 
        output Real p "Pressure in bar";
        output Real h "Specific enthalpy in kJ/kg" annotation(HideResult = false);
        output Real m_flow "Mass flow rate in kg/s" annotation(HideResult = false);
        output .ClaRa.Basics.Units.Temperature_DegC T "Tempearture in degC" annotation(HideResult = false);
        output Real s "Specific entropy in kJ/kgK" annotation(HideResult = false);
      end EyeOut;

      model DataInterfaceVector  
        parameter Integer N_sets = 0 "Number of data sets to be provided (if showData=true)";
        ClaRa.Basics.Interfaces.EyeOut[N_sets] eye;
      end DataInterfaceVector;

      connector ElectricPortIn  
        flow .ClaRa.Basics.Units.Power P "Active power";
        .ClaRa.Basics.Units.Frequency f "Frequency";
      end ElectricPortIn;

      connector ElectricPortOut  
        extends Basics.Interfaces.ElectricPortIn;
      end ElectricPortOut;
    end Interfaces;

    package Icons  
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;

      package PackageIcons  
        extends ClaRa.Basics.Icons.PackageIcons.Basics60;

        partial class Basics100  end Basics100;

        partial class Basics80  end Basics80;

        partial class Basics60  end Basics60;

        partial class Basics50  end Basics50;

        partial class Components100  end Components100;

        partial class Components80  end Components80;

        partial class Components60  end Components60;

        partial class Components50  end Components50;

        partial class CycleInit100  end CycleInit100;

        partial class CycleInit80  end CycleInit80;

        partial class CycleInitb80  end CycleInitb80;

        partial class Examplesb100  end Examplesb100;

        partial class Subsystems100  end Subsystems100;

        partial class Subsystems80  end Subsystems80;

        partial class Visualisation100  end Visualisation100;

        model ExecutableRegressiong100  end ExecutableRegressiong100;

        package ClaRab100  end ClaRab100;
      end PackageIcons;

      model HEX04  end HEX04;

      model HEX05  end HEX05;

      model Boiler  "An icon for a boiler model - phisical units" end Boiler;

      model Pump  end Pump;

      model SimpleTurbine  end SimpleTurbine;

      model FeedwaterTank  end FeedwaterTank;

      model Pipe_L4  end Pipe_L4;

      model Tpipe  end Tpipe;

      model Tpipe2  end Tpipe2;

      model Volume  end Volume;

      model Volume2Zones  end Volume2Zones;

      model Volume_L4  end Volume_L4;

      model FlowSink  end FlowSink;

      model FlowSource  end FlowSource;

      model WallThick  end WallThick;

      model WallThinLarge  end WallThinLarge;

      model Adapter5_fw  end Adapter5_fw;

      model Delta_p  end Delta_p;

      model Alpha  end Alpha;

      model Efficiency  end Efficiency;

      record RecordIcon  end RecordIcon;

      model Init  end Init;

      model ComplexityLevel  "Displays the complexity level inside model icon " 
        String complexity = "??";
      end ComplexityLevel;

      record IComIcon  end IComIcon;

      model IdealPhases  end IdealPhases;

      model IdealMixing  end IdealMixing;

      model RealPhases  end RealPhases;

      model RealSeparation  end RealSeparation;

      model MecahnicalEquilibriumIcon  end MecahnicalEquilibriumIcon;

      function Function  end Function;
    end Icons;

    package Choices  
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;
      type GeometryOrientation = enumeration(vertical "Vertical orientation", horizontal "Horizontal orientation") "orientation of the geometry";
    end Choices;

    package Media  "Media data (properties of air, water, steam, ...)" 
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;

      package FuelTypes  
        extends ClaRa.Basics.Icons.PackageIcons.Basics60;

        record BaseFuel  "Chose fuel below:" 
          extends ClaRa.Basics.Media.FuelTypes.EmptyFuel;
          extends ClaRa.Basics.Icons.RecordIcon;
          constant Integer N_c = 5 "Number of components";
          constant Integer N_e = 5 "Number of elements";
          parameter Real[N_c] C_LHV = {1, 1, 1, 1, 1} "Coefficients for LHV calculation";
          parameter Real[N_c] C_cp = {1, 1, 1, 1, 1} "Coefficients for cp calculation";
          constant Real[N_c] C_rho = {1, 1, 1, 1, 1} "Coefficients for rho calculation";
          constant Integer waterIndex "Index of water in composition";
          constant Integer ashIndex "Index of ash in composition";
          constant ClaRa.Basics.Units.MassFraction[N_c - 1] defaultComposition "Elemental compostion of combustible, e.g. {C,H,O,N,S, H2O, ash}";
          parameter ClaRa.Basics.Units.MassFraction[:, :] xi_e_waf "water and ash free elementary composition of the two pure fuels";
          constant ClaRa.Basics.Units.Temperature T_ref = 273.15 "Reference temperature";
        end BaseFuel;

        record Fuel_refvalues_v1  "{fuel_waf, ash, h2o } |  former 'Coal_v1'  | C,H,O,N,S,Ash,H2O" 
          extends ClaRa.Basics.Media.FuelTypes.BaseFuel(N_c = 3, N_e = 7, C_LHV = {30769230.769230768, 0, -2500e3}, C_rho = {500, 7000, 1000}, C_cp = {1266.67, 1000, 4190}, waterIndex = 3, ashIndex = 2, defaultComposition = {0.975, 0.025}, xi_e_waf = {{0.8205128205128206, 0.05128205128205129, 0.05128205128205129, 0.05128205128205129}}, T_ref = 273.15);
        end Fuel_refvalues_v1;

        partial record EmptyFuel  "Allows support of obsolete fuel definition applied in version <= 1.2.2" end EmptyFuel;
      end FuelTypes;

      package Slag  
        extends ClaRa.Basics.Icons.PackageIcons.Basics60;

        record Slag_v1  
          extends ClaRa.Basics.Media.Slag.PartialSlag(cp = 800);
        end Slag_v1;

        record PartialSlag  "Base class for solid type media definition" 
          constant Modelica.SIunits.SpecificHeatCapacity cp;
        end PartialSlag;
      end Slag;
    end Media;

    package Units  
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;
      type AbsolutePressure = Real(final quantity = "PressureDifference", final unit = "Pa", displayUnit = "Pa", nominal = 1e5, min = 0);
      type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
      type Area = Real(final quantity = "Area", final unit = "m2", displayUnit = "m2", nominal = 1, min = 0);
      type CoefficientOfHeatTransfer = Real(final quantity = "CoefficientOfHeatTransfer", final unit = "W/(m2.K)", displayUnit = "W/(m2.K)", nominal = 1, min = 0);
      type DensityMassSpecific = Real(final quantity = "DensityVolumeSpecific", final unit = "kg/m3", displayUnit = "kg/m3", nominal = 1000, min = 0);
      type DynamicViscosity = Real(final quantity = "DynamicViscosity", final unit = "Pa.s", min = 0);
      type ElasticityModule = Real(final quantity = "ElasticityModule", final unit = "Pa", displayUnit = "Pa", nominal = 1e11);
      type Energy = Real(final quantity = "Energy", final unit = "J", displayUnit = "J", nominal = 1e3, min = 0);
      type Enthalpy = Real(final quantity = "Enthalpy", final unit = "J", displayUnit = "J", nominal = 1e5, min = 0);
      type EnthalpyFlowRate = Real(final quantity = "EnthalpyFlowRate", final unit = "W", displayUnit = "W", nominal = 1e5);
      type EnthalpyMassSpecific = Real(final quantity = "MassSpecificEnthalpy", final unit = "J/kg", displayUnit = "J/kg", nominal = 1e3);
      type EntropyMassSpecific = Real(final quantity = "MassSpecificEntropy", final unit = "J/(kg.K)", displayUnit = "J/(kg.K)", nominal = 1e3, min = 0);
      type Force = Real(final quantity = "Force", final unit = "N", displayUnit = "N", nominal = 1);
      type Frequency = Real(final quantity = "Frequency", final unit = "1/s", displayUnit = "1/min", nominal = 1000);
      type HeatCapacityMassSpecific = Real(final quantity = "SpecificHeatCapacity", final unit = "J/(kg.K)", displayUnit = "J/(kg.K)", nominal = 1e3);
      type HeatExpansionRateLinear = Real(final quantity = "HeatExpansionRateLinear", final unit = "1/K", displayUnit = "1/K", nominal = 1e-6);
      type HeatFlowRate = Real(final quantity = "Power", final unit = "W", displayUnit = "W", nominal = 1e5);
      type InternalEnergy = Energy;
      type Length = Real(final quantity = "Length", final unit = "m", displayUnit = "m", nominal = 1);
      type Mass = Real(final quantity = "Mass", final unit = "kg", displayUnit = "kg", nominal = 1, min = 0);
      type MassFlowRate = Real(final quantity = "MassFlowRate", final unit = "kg/s", displayUnit = "kg/s", nominal = 1);
      type MassFraction = Real(final quantity = "MassFraction", final unit = "kg/kg", displayUnit = "kg/kg", nominal = 1, min = 0);
      type Momentum = Real(final quantity = "Momentum", final unit = "kg.m/s", displayUnit = "kg.m/s", nominal = 1);
      type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2");
      type NusseltNumber = Real(final quantity = "NusseltNumber", final unit = "1", displayUnit = "1");
      type Power = Real(final quantity = "Power", final unit = "W", displayUnit = "W", nominal = 1e5);
      type PrandtlNumber = Real(final quantity = "PrandtlNumber", final unit = "1", displayUnit = "1");
      type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "Pa", nominal = 1e5, min = 0);
      type PressureDifference = Real(final quantity = "PressureDifference", final unit = "Pa", displayUnit = "Pa", nominal = 0);
      type RelativeHumidity = Real(final quantity = "RelativeHumidity", final unit = "1", displayUnit = "1", nominal = 0, min = 0);
      type RPM = Real(final quantity = "RotationsPerMinute", final unit = "1/min", displayUnit = "rpm", nominal = 0);
      type ReynoldsNumber = Real(final quantity = "ReynoldsNumber", final unit = "1", displayUnit = "1");
      type ShearModulus = Real(final quantity = "ShearModulus", final unit = "Pa", displayUnit = "Pa", nominal = 1e11);
      type ThermalConductivity = Real(final quantity = "ThermalConductivity", final unit = "W/(m.K)");
      type Temperature = Real(final quantity = "Temperature", final unit = "K", min = 0, displayUnit = "K") "Absolute thermodynamic temperature";
      type TemperatureDifference = Real(final quantity = "TemperatureDifference", final unit = "K", start = 0, displayUnit = "K") "Temperature diference";
      type Temperature_DegC = Real(final quantity = "Temperature", final unit = "degC", displayUnit = "degC", min = -273.15, start = 20) "Temperature in degree Celsius";
      type Time = Real(final quantity = "Time", final unit = "s", displayUnit = "s", nominal = 1);
      type Velocity = Real(final quantity = "Velocity", final unit = "m/s", displayUnit = "m/s", nominal = 1);
      type Volume = Real(final quantity = "Volume", final unit = "m3", displayUnit = "m3", nominal = 1, min = 0);
      type VolumeFlowRate = Real(final quantity = "VolumeFlowRate", final unit = "m3/s", displayUnit = "m3/s", nominal = 1);
      type VolumeMassSpecific = Real(final quantity = "MassSpecificVolume", final unit = "m3/kg", displayUnit = "m3/kg", nominal = 1 / 1000, min = 0);
    end Units;

    package ControlVolumes  "Basic models for control volumes" 
      extends ClaRa.Basics.Icons.PackageIcons.Basics80;

      package FluidVolumes  "Contains fundamental first principle models" 
        extends ClaRa.Basics.Icons.PackageIcons.Basics60;

        model VolumeVLE_2  "A lumped control volume for vapour/liquid equilibrium" 
          extends .ClaRa.Basics.Icons.Volume;
          extends .ClaRa.Basics.Icons.ComplexityLevel(complexity = "L2");
          outer .ClaRa.SimCenter simCenter;

          model Outline  
            extends .ClaRa.Basics.Icons.RecordIcon;
            parameter Boolean showExpertSummary = false;
            input .ClaRa.Basics.Units.Volume volume_tot "Total volume";
            input .ClaRa.Basics.Units.Area A_heat "Heat transfer area";
            input .ClaRa.Basics.Units.HeatFlowRate Q_flow_tot "Total heat flow rate";
            input .ClaRa.Basics.Units.PressureDifference Delta_p "Pressure difference p_in - p_out";
          end Outline;

          model Summary  
            extends .ClaRa.Basics.Icons.RecordIcon;
            Outline outline;
            .ClaRa.Basics.Records.FlangeVLE inlet;
            .ClaRa.Basics.Records.FlangeVLE outlet;
            .ClaRa.Basics.Records.FluidVLE_L2 fluid;
          end Summary;

          inner parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
          replaceable model HeatTransfer = .ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.IdealHeatTransfer_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseVLE;
          replaceable model PhaseBorder = .ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.IdeallyStirred constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.IdealPhases;
          replaceable model PressureLoss = .ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.NoFriction_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L2;
          replaceable model Geometry = .ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry;
          inner parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
          inner parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 10 "Nominal mass flow rates at inlet";
          inner parameter .ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal pressure";
          inner parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_nom = 1e5 "Nominal specific enthalpy";
          inner parameter .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_nom = medium.xi_default "Nominal mass fraction";
          parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_start = 1e5 "Start value of system specific enthalpy";
          parameter .ClaRa.Basics.Units.Pressure p_start = 1e5 "Start value of system pressure";
          parameter .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_start = medium.xi_default "Start value for mass fraction";
          inner parameter Integer initOption = 0 "Type of initialisation";
          parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
          parameter Integer heatSurfaceAlloc = 1 "Heat transfer area to be considered";
        protected
          parameter .ClaRa.Basics.Units.DensityMassSpecific rho_nom = TILMedia.VLEFluidFunctions.density_phxi(medium, p_nom, h_nom) "Nominal density";
          .ClaRa.Basics.Units.EnthalpyMassSpecific h_out "Outlet spec. enthalpy";
          .ClaRa.Basics.Units.EnthalpyMassSpecific h_in "Inlet spec. enthalpy";
          .ClaRa.Basics.Units.EnthalpyMassSpecific h(start = h_start) "spec. enthalpy state";
          .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_out "Outlet composition";
          .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_in "Inlet composition";
          .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi(start = xi_start) "Composition state";
          Real drhodt "Time derivative of density";
        public
          .ClaRa.Basics.Units.Mass mass "Total system mass";
          inner .ClaRa.Basics.Units.Pressure p(start = p_start, stateSelect = StateSelect.prefer) "System pressure";
          .ClaRa.Basics.Interfaces.FluidPortIn inlet(Medium = medium) "Inlet port";
          .ClaRa.Basics.Interfaces.FluidPortOut outlet(Medium = medium) "Outlet port";
          .ClaRa.Basics.Interfaces.HeatPort_a heat;
          Summary summary(inlet(showExpertSummary = showExpertSummary, m_flow = inlet.m_flow, T = fluidIn.T, p = inlet.p, h = fluidIn.h, s = fluidIn.s, steamQuality = fluidIn.q, H_flow = fluidIn.h * inlet.m_flow, rho = fluidIn.d), fluid(showExpertSummary = showExpertSummary, mass = mass, p = p, h = h, T = bulk.T, s = bulk.s, steamQuality = bulk.q, H = h * mass, rho = bulk.d, T_sat = bulk.VLE.T_l, h_dew = bulk.VLE.h_v, h_bub = bulk.VLE.h_l), outlet(showExpertSummary = showExpertSummary, m_flow = -outlet.m_flow, T = fluidOut.T, p = outlet.p, h = fluidOut.h, s = fluidOut.s, steamQuality = fluidOut.q, H_flow = -fluidOut.h * outlet.m_flow, rho = fluidOut.d), outline(volume_tot = geo.volume, A_heat = geo.A_heat[heatSurfaceAlloc], Delta_p = inlet.p - outlet.p, Q_flow_tot = heat.Q_flow));
          TILMedia.VLEFluid_ph fluidIn(vleFluidType = medium, final p = inlet.p, final h = h_in, computeTransportProperties = true, computeVLETransportProperties = true, computeVLEAdditionalProperties = true, xi = xi_in);
          TILMedia.VLEFluid_ph fluidOut(vleFluidType = medium, p = outlet.p, h = h_out, computeTransportProperties = true, computeVLETransportProperties = true, computeVLEAdditionalProperties = true, xi = xi_out);
        protected
          inner TILMedia.VLEFluid_ph bulk(vleFluidType = medium, p = p, h = h, computeVLEAdditionalProperties = true, computeVLETransportProperties = true, computeTransportProperties = true, xi = xi);
        public
          HeatTransfer heattransfer(final heatSurfaceAlloc = heatSurfaceAlloc);
          inner Geometry geo;
          PhaseBorder phaseBorder;
          PressureLoss pressureLoss;
        protected
          inner .ClaRa.Basics.Records.IComVLE_L2 iCom(mass = mass, h_in = h_in, h_out = h_out, p_in = inlet.p, p_out = outlet.p, m_flow_in = inlet.m_flow, m_flow_out = outlet.m_flow, h_nom = h_nom, T_in = fluidIn.T, T_out = fluidOut.T, p_nom = p_nom, m_flow_nom = m_flow_nom, xi_in = fluidIn.xi, xi_out = fluidOut.xi, T_bulk = bulk.T, mediumModel = medium, p_bulk = bulk.p, h_bulk = bulk.h, xi_bulk = bulk.xi, fluidPointer_bulk = bulk.vleFluidPointer, fluidPointer_in = fluidIn.vleFluidPointer, fluidPointer_out = fluidOut.vleFluidPointer, xi_nom = xi_nom) "Internal communication record";
        initial equation
          if initOption == 1 then
            der(h) = 0;
            der(p) = 0;
            der(xi) = zeros(medium.nc - 1);
          elseif initOption == 201 then
            der(p) = 0;
          elseif initOption == 202 then
            der(h) = 0;
          elseif initOption == 0 then
          elseif initOption == 204 and phaseBorder.modelType == "IdeallySeparated" then
            phaseBorder.level_rel = phaseBorder.level_rel_start;
          elseif initOption == 205 and phaseBorder.modelType == "IdeallySeparated" then
            phaseBorder.level_rel = phaseBorder.level_rel_start;
            der(iCom.p_bulk) = 0;
          else
            assert(false, "Unsupported initial condition in " + getInstanceName());
          end if;
        equation
          connect(heattransfer.heat, heat);
          assert(geo.volume > 0, "The system volume must be greater than zero!");
          assert(geo.A_heat[heatSurfaceAlloc] >= 0, "The area of heat transfer must be greater than zero!");
          mass = if useHomotopy then geo.volume * homotopy(bulk.d, rho_nom) else geo.volume * bulk.d;
          drhodt * geo.volume = inlet.m_flow + outlet.m_flow "Mass balance";
          drhodt = der(p) * bulk.drhodp_hxi + der(h) * bulk.drhodh_pxi + sum(der(xi) * bulk.drhodxi_ph) "calculating drhodt from state variables";
          der(h) = if useHomotopy then homotopy(inlet.m_flow * h_in + outlet.m_flow * h_out + geo.volume * der(p) + heat.Q_flow - h * geo.volume * drhodt, m_flow_nom * h_in - m_flow_nom * h_out + geo.volume * der(p) + heat.Q_flow - h * geo.volume * drhodt) / mass else (inlet.m_flow * h_in + outlet.m_flow * h_out + geo.volume * der(p) + heat.Q_flow - h * geo.volume * drhodt) / mass "Energy balance";
          der(xi) = if useHomotopy then homotopy(inlet.m_flow * xi_in + outlet.m_flow * xi_out - xi * geo.volume * drhodt, m_flow_nom * xi_in - m_flow_nom * xi_out - xi * geo.volume * drhodt) / mass else (inlet.m_flow * xi_in + outlet.m_flow * xi_out - xi * geo.volume * drhodt) / mass "Species balance without chemical reactions";
          inlet.h_outflow = phaseBorder.h_inflow;
          outlet.h_outflow = phaseBorder.h_outflow;
          h_in = if useHomotopy then homotopy(noEvent(actualStream(inlet.h_outflow)), inStream(inlet.h_outflow)) else noEvent(actualStream(inlet.h_outflow));
          h_out = if useHomotopy then homotopy(noEvent(actualStream(outlet.h_outflow)), outlet.h_outflow) else noEvent(actualStream(outlet.h_outflow));
          xi_in = if useHomotopy then homotopy(noEvent(actualStream(inlet.xi_outflow)), inStream(inlet.xi_outflow)) else noEvent(actualStream(inlet.xi_outflow));
          xi_out = if useHomotopy then homotopy(noEvent(actualStream(outlet.xi_outflow)), outlet.xi_outflow) else noEvent(actualStream(outlet.xi_outflow));
          inlet.p = p + pressureLoss.Delta_p + phaseBorder.Delta_p_geo_in;
          outlet.p = p + phaseBorder.Delta_p_geo_out "The friction term is lumped at the inlet side to avoid direct coupling of two flow models, this avoids aniteration of mass flow rates in some application cases";
          inlet.xi_outflow = xi;
          outlet.xi_outflow = xi;
        end VolumeVLE_2;

        model VolumeVLE_L3_TwoZonesNPort  "A volume element balancing liquid and vapour phase with n inlet and outlet ports" 
          extends .ClaRa.Basics.Icons.Volume2Zones;
          extends .ClaRa.Basics.Icons.ComplexityLevel(complexity = "L3");
          outer .ClaRa.SimCenter simCenter;

          model Outline  
            extends .ClaRa.Basics.Icons.RecordIcon;
            parameter Boolean showExpertSummary = false;
            input .ClaRa.Basics.Units.Volume volume_tot "Total volume";
            input .ClaRa.Basics.Units.Area A_heat_tot "Heat transfer area";
            input .ClaRa.Basics.Units.Volume[2] volume if showExpertSummary "Volume of liquid and steam volume";
            input .ClaRa.Basics.Units.Area[2] A_heat if showExpertSummary "Heat transfer area";
            input .ClaRa.Basics.Units.Length level_abs "Absolue filling level";
            input Real level_rel "relative filling level";
            input .ClaRa.Basics.Units.Mass fluidMass "Total fluid mass";
            input .ClaRa.Basics.Units.Enthalpy H_tot if showExpertSummary "Systems's enthalpy";
            input .ClaRa.Basics.Units.HeatFlowRate Q_flow_tot "Total heat flow rate";
            input .ClaRa.Basics.Units.HeatFlowRate[2] Q_flow if showExpertSummary "Zonal heat flow rate";
            input .ClaRa.Basics.Units.PressureDifference Delta_p "Pressure difference p_in - p_out";
          end Outline;

          model Summary  
            extends .ClaRa.Basics.Icons.RecordIcon;
            Outline outline;
            parameter Integer N_inlet = 1;
            parameter Integer N_outlet = 1;
            .ClaRa.Basics.Records.FlangeVLE[N_inlet] inlet;
            .ClaRa.Basics.Records.FlangeVLE[N_outlet] outlet;
            .ClaRa.Basics.Records.FluidVLE_L34 fluid;
          end Summary;

          inner parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
          replaceable model HeatTransfer = .ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseVLE_L3;
          replaceable model PhaseBorder = .ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.RealSeparated constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.RealPhases;
          replaceable model PressureLoss = .ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L3;
          replaceable model Geometry = .ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry;
          parameter .ClaRa.Basics.Units.Time Tau_cond = 0.03 "Time constant of condensation";
          parameter .ClaRa.Basics.Units.Time Tau_evap = Tau_cond "Time constant of evaporation";
          parameter .ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_ph = 50000 "HTC of the phase border";
          parameter .ClaRa.Basics.Units.Area A_heat_ph = geo.A_hor * 100 "Heat transfer area at phase border";
          parameter Real exp_HT_phases = 0 "Exponent for volume dependency on inter phase HT";
          parameter Boolean equalPressures = true "True if pressure in liquid and vapour phase is equal";
          inner parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
          inner parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 10 "Nominal mass flow rates at inlet";
          inner parameter .ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal pressure";
          final parameter .ClaRa.Basics.Units.DensityMassSpecific rho_liq_nom = TILMedia.VLEFluidFunctions.bubbleDensity_pxi(medium, p_nom) "Nominal density";
          final parameter .ClaRa.Basics.Units.DensityMassSpecific rho_vap_nom = TILMedia.VLEFluidFunctions.dewDensity_pxi(medium, p_nom) "Nominal density";
          parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_liq_start = (-10) + TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium, p_start) "Start value of sytsem specific enthalpy";
          parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_vap_start = (+10) + TILMedia.VLEFluidFunctions.dewSpecificEnthalpy_pxi(medium, p_start) "Start value of sytsem specific enthalpy";
          parameter .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_liq_start = medium.xi_default "Initial composition of liquid phase";
          parameter .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_vap_start = medium.xi_default "Initial composition of vapour phase";
          parameter .ClaRa.Basics.Units.Pressure p_start = 1e5 "Start value of sytsem pressure";
          parameter Real level_rel_start = 0.5 "Start value for relative filling level";
          inner parameter Integer initOption = 211 "Type of initialisation";
          parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
          parameter Integer heatSurfaceAlloc = 1 "Heat transfer area to be considered";
          inner .ClaRa.Basics.Units.EnthalpyMassSpecific h_liq(start = h_liq_start) "Specific enthalpy of liquid phase";
          inner .ClaRa.Basics.Units.EnthalpyMassSpecific h_vap(start = h_vap_start) "Specific enthalpy of vapour phase";
          .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_liq(start = xi_liq_start) "Species mass fraction in liquid phase";
          .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_vap(start = xi_vap_start) "Species mass fraction in vapour phase";
          Real drho_liqdt(unit = "kg/(m3.s)") "Time derivative of liquid density";
          Real drho_vapdt(unit = "kg/(m3.s)") "Time derivative of vapour density";
          .ClaRa.Basics.Units.Volume volume_liq(start = phaseBorder.level_rel_start * geo.volume) "Liquid volume";
          .ClaRa.Basics.Units.Volume volume_vap(start = (1 - phaseBorder.level_rel_start) * geo.volume) "Vapour volume";
          .ClaRa.Basics.Units.MassFlowRate m_flow_cond "Condensing mass flow";
          .ClaRa.Basics.Units.MassFlowRate m_flow_evap "Evaporating mass flow";
          .ClaRa.Basics.Units.HeatFlowRate Q_flow_phases "Heat flow between phases";
          .ClaRa.Basics.Units.HeatFlowRate[2] Q_flow;
          .ClaRa.Basics.Units.Mass mass_liq "Liquid mass";
          .ClaRa.Basics.Units.Mass mass_vap "Vapour mass";
          .ClaRa.Basics.Units.Pressure p_liq(start = p_start) "Liquid pressure";
          .ClaRa.Basics.Units.Pressure p_vap(start = p_start, each stateSelect = StateSelect.prefer) "Vapour pressure";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_inlet] H_flow_inliq "Enthalpy flow rate passing from inlet to liquid zone and vice versa";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_inlet] H_flow_invap "Enthalpy flow rate passing from inlet to vapour zone and vice versa";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_outlet] H_flow_outliq "Enthalpy flow rate passing from inlet to liquid zone and vice versa";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_outlet] H_flow_outvap "Enthalpy flow rate passing from outlet to vapour zone and vice versa";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_inlet, medium.nc - 1] Xi_flow_inliq "Mass flow rate passing from inlet to liquid zone and vice versa";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_inlet, medium.nc - 1] Xi_flow_invap "Enthalpy flow rate passing from inlet to vapour zone and vice versa";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_outlet, medium.nc - 1] Xi_flow_outliq "Enthalpy flow rate passing from inlet to liquid zone and vice versa";
          .ClaRa.Basics.Units.EnthalpyFlowRate[geo.N_outlet, medium.nc - 1] Xi_flow_outvap "Enthalpy flow rate passing from outlet to vapour zone and vice versa";
        protected
          .ClaRa.Basics.Units.Pressure p_bottom "Pressure at volume bottom";
          Real level_abs_ "Additional state for decoupling large nonlinear system of equation if equal pressures == false";
        public
          .ClaRa.Basics.Interfaces.FluidPortIn[geo.N_inlet] inlet(each Medium = medium) "Inlet port";
          .ClaRa.Basics.Interfaces.FluidPortOut[geo.N_outlet] outlet(each Medium = medium) "Outlet port";
          .ClaRa.Basics.Interfaces.HeatPort_a[2] heat;
          TILMedia.VLEFluid_ph[geo.N_inlet] fluidIn(each vleFluidType = medium, final p = inlet.p, final h = {if useHomotopy then homotopy(noEvent(actualStream(inlet[i].h_outflow)), inStream(inlet[i].h_outflow)) else noEvent(actualStream(inlet[i].h_outflow)) for i in 1:geo.N_inlet}, xi = {if useHomotopy then homotopy(noEvent(actualStream(inlet[i].xi_outflow)), inStream(inlet[i].xi_outflow)) else noEvent(actualStream(inlet[i].xi_outflow)) for i in 1:geo.N_inlet});
          TILMedia.VLEFluid_ph[geo.N_outlet] fluidOut(each vleFluidType = medium, final p = outlet.p, final h = {if useHomotopy then homotopy(noEvent(actualStream(outlet[i].h_outflow)), outlet[i].h_outflow) else noEvent(actualStream(outlet[i].h_outflow)) for i in 1:geo.N_outlet}, xi = {if useHomotopy then homotopy(noEvent(actualStream(outlet[i].xi_outflow)), outlet[i].xi_outflow) else noEvent(actualStream(outlet[i].xi_outflow)) for i in 1:geo.N_outlet});
          HeatTransfer heattransfer(final heatSurfaceAlloc = heatSurfaceAlloc);
          inner Geometry geo;
          PhaseBorder phaseBorder(level_rel_start = level_rel_start);
          PressureLoss pressureLoss;
          Summary summary(final N_inlet = geo.N_inlet, final N_outlet = geo.N_outlet, inlet(each showExpertSummary = showExpertSummary, m_flow = inlet.m_flow, T = fluidIn.T, p = inlet.p, h = fluidIn.h, s = fluidIn.s, steamQuality = fluidIn.q, H_flow = fluidIn.h .* inlet.m_flow, rho = fluidIn.d), outlet(each showExpertSummary = showExpertSummary, m_flow = -outlet.m_flow, T = fluidOut.T, p = outlet.p, h = fluidOut.h, s = fluidOut.s, steamQuality = fluidOut.q, H_flow = -fluidOut.h .* outlet.m_flow, rho = fluidOut.d), fluid(showExpertSummary = showExpertSummary, mass = {mass_liq, mass_vap}, p = {p_liq, p_vap}, h = iCom.h, h_bub = {liq.VLE.h_l, vap.VLE.h_l}, h_dew = {liq.VLE.h_v, vap.VLE.h_v}, T = iCom.T, T_sat = {liq.VLE.T_l, vap.VLE.T_l}, s = {liq.s, vap.s}, steamQuality = {liq.q, vap.q}, H = iCom.h .* {mass_liq, mass_vap}, rho = {liq.d, vap.d}, final N_cv = 2), outline(showExpertSummary = showExpertSummary, volume_tot = geo.volume, volume = {volume_liq, volume_vap}, A_heat = geo.A_heat[heatSurfaceAlloc] * {volume_liq, volume_vap} / geo.volume, A_heat_tot = geo.A_heat[heatSurfaceAlloc], level_abs = phaseBorder.level_abs, level_rel = phaseBorder.level_rel, Delta_p = inlet[1].p - outlet[1].p, fluidMass = mass_vap + mass_liq, H_tot = h_liq * mass_liq + h_vap * mass_vap, Q_flow_tot = sum(heat.Q_flow), Q_flow = heattransfer.heat.Q_flow));
        protected
          inner TILMedia.VLEFluid_ph vap(vleFluidType = medium, p = p_vap, h = h_vap, computeTransportProperties = true, computeVLETransportProperties = true, xi = xi_vap);
          inner TILMedia.VLEFluid_ph liq(vleFluidType = medium, h = h_liq, computeTransportProperties = true, computeVLETransportProperties = true, p = p_liq, xi = xi_liq);
          inner .ClaRa.Basics.Records.IComVLE_L3_NPort iCom(p_in = inlet.p, p_out = outlet.p, h = {h_liq, h_vap}, T_in = fluidIn.T, T_out = fluidOut.T, N_cv = 2, m_flow_nom = m_flow_nom, N_inlet = geo.N_inlet, N_outlet = geo.N_outlet, volume = {volume_liq, volume_vap}, m_flow_in = inlet.m_flow, T = {liq.T, vap.T}, p = {p_liq, p_vap}, m_flow_out = outlet.m_flow, fluidPointer_in = fluidIn.vleFluidPointer, fluidPointer_out = fluidOut.vleFluidPointer, fluidPointer = {liq.vleFluidPointer, vap.vleFluidPointer}, h_in = fluidIn.h, h_out = fluidOut.h, xi_in = fluidIn.xi, xi_out = fluidOut.xi, mediumModel = medium, xi = {liq.xi, vap.xi}) "Internal communication record";
        initial equation
          if initOption == 209 then
            der(h_liq) = 0;
            der(h_vap) = 0;
            der(p_vap) = 0;
            der(volume_vap) = 0;
          elseif initOption == 201 then
            der(p_vap) = 0;
          elseif initOption == 202 then
            der(h_liq) = 0;
            der(h_vap) = 0;
          elseif initOption == 204 then
            phaseBorder.level_rel = phaseBorder.level_rel_start;
          elseif initOption == 0 then
          elseif initOption == 211 then
            phaseBorder.level_rel = phaseBorder.level_rel_start;
            h_liq = h_liq_start;
            h_vap = h_vap_start;
            p_vap = p_start;
          else
            assert(false, "Unknown initialisation option in " + getInstanceName());
          end if;
          if not equalPressures then
            level_abs_ = phaseBorder.level_abs;
          end if;
        equation
          connect(heattransfer.heat, heat);
          assert(geo.volume > 0, "The system volume must be greater than zero!");
          assert(geo.A_heat[heatSurfaceAlloc] >= 0, "The area of heat transfer must be greater than zero!");
          mass_liq = if useHomotopy then homotopy(volume_liq * liq.d, volume_liq * rho_liq_nom) else volume_liq * liq.d;
          mass_vap = if useHomotopy then homotopy(volume_vap * vap.d, volume_vap * rho_vap_nom) else volume_vap * vap.d;
          drho_liqdt = der(p_liq) * liq.drhodp_hxi + der(h_liq) * liq.drhodh_pxi + sum(der(xi_liq) * liq.drhodxi_ph);
          drho_vapdt = der(p_vap) * vap.drhodp_hxi + der(h_vap) * vap.drhodh_pxi + sum(der(xi_vap) * vap.drhodxi_ph);
          volume_liq = geo.volume - volume_vap;
          p_bottom = p_vap + phaseBorder.level_abs * liq.d * Modelica.Constants.g_n;
          if equalPressures then
            p_liq = p_vap;
            level_abs_ = -1;
          else
            p_liq = p_vap + level_abs_ * liq.d * Modelica.Constants.g_n / 2;
            der(level_abs_) = (phaseBorder.level_abs - level_abs_) / 0.001;
          end if;
          drho_liqdt * volume_liq = (+liq.d * der(volume_vap)) + sum(phaseBorder.m_flow_inliq) + sum(phaseBorder.m_flow_outliq) + m_flow_cond - m_flow_evap "Liquid mass balance";
          drho_vapdt * volume_vap = (-vap.d * der(volume_vap)) + sum(phaseBorder.m_flow_invap) + sum(phaseBorder.m_flow_outvap) - m_flow_cond + m_flow_evap "Liquid mass balance";
          for i in 1:medium.nc - 1 loop
            der(xi_liq[i]) = if noEvent(mass_liq > 1e-6) then (sum(Xi_flow_inliq[:, i]) + sum(Xi_flow_outliq[:, i]) + m_flow_cond .* liq.VLE.xi_l[i] - m_flow_evap .* liq.VLE.xi_v[i] - liq.xi[i] * (drho_liqdt * volume_liq - liq.d * der(volume_vap))) ./ mass_liq else der(xi_vap[i]);
            der(xi_vap[i]) = if noEvent(mass_vap > 1e-6) then (sum(Xi_flow_invap[:, i]) + sum(Xi_flow_outvap[:, i]) - m_flow_cond .* vap.VLE.xi_l[i] + m_flow_evap .* vap.VLE.xi_v[i] - vap.xi[i] .* (drho_vapdt * volume_vap + vap.d .* der(volume_vap))) ./ mass_vap else der(xi_liq[i]);
          end for;
          der(h_liq) = if noEvent(mass_liq > 1e-6) then (sum(H_flow_inliq) + sum(H_flow_outliq) + m_flow_cond * vap.VLE.h_l - m_flow_evap * vap.VLE.h_v + volume_liq * der(p_liq) + p_liq * der(volume_liq) - h_liq * volume_liq * drho_liqdt - liq.d * h_liq * der(volume_liq) + Q_flow_phases + Q_flow[1]) / mass_liq else der(h_vap);
          der(h_vap) = if noEvent(mass_vap > 1e-6) then (sum(H_flow_invap) + sum(H_flow_outvap) - m_flow_cond * vap.VLE.h_l + m_flow_evap * vap.VLE.h_v + volume_vap * der(p_vap) + p_vap * der(volume_vap) - h_vap * volume_vap * drho_vapdt - vap.d * h_vap * der(volume_vap) - Q_flow_phases + Q_flow[2]) / mass_vap else der(h_liq);
          Q_flow_phases = noEvent(alpha_ph * A_heat_ph * max(1e-3, min((1e-6 + iCom.volume[1]) / (1e-6 + iCom.volume[2]), (1e-6 + iCom.volume[2]) / (1e-6 + iCom.volume[1]))) ^ exp_HT_phases * (iCom.T[2] - iCom.T[1]));
          Q_flow[1] = if noEvent(mass_vap > 1e-6) then heattransfer.heat[1].Q_flow else sum(heattransfer.heat.Q_flow);
          Q_flow[2] = if noEvent(mass_liq > 1e-6) then heattransfer.heat[2].Q_flow else sum(heattransfer.heat.Q_flow);
          m_flow_cond = .ClaRa.Basics.Functions.Stepsmoother(1e-1, 1e-3, mass_vap * (1 - vap.q)) * .ClaRa.Basics.Functions.Stepsmoother(-10, +10, h_vap - vap.VLE.h_v) * (1 - noEvent(max(0, min(1, vap.q)))) * max(0, mass_vap) / Tau_cond;
          m_flow_evap = .ClaRa.Basics.Functions.Stepsmoother(1e-1, 1e-3, mass_liq * liq.q) * .ClaRa.Basics.Functions.Stepsmoother(-10, +10, liq.VLE.h_l - h_liq) * noEvent(max(0, min(1, liq.q))) * mass_liq / Tau_evap;
          inlet.h_outflow = {(phaseBorder.zoneAlloc_in[i] - 1) * iCom.h[2] + (2 - phaseBorder.zoneAlloc_in[i]) * iCom.h[1] for i in 1:geo.N_inlet};
          outlet.h_outflow = {(phaseBorder.zoneAlloc_out[i] - 1) * iCom.h[2] + (2 - phaseBorder.zoneAlloc_out[i]) * iCom.h[1] for i in 1:geo.N_outlet};
          inlet.xi_outflow = {(phaseBorder.zoneAlloc_in[i] - 1) * iCom.xi[2, :] + (2 - phaseBorder.zoneAlloc_in[i]) * iCom.xi[1, :] for i in 1:geo.N_inlet};
          outlet.xi_outflow = {(phaseBorder.zoneAlloc_out[i] - 1) * iCom.xi[2, :] + (2 - phaseBorder.zoneAlloc_out[i]) * iCom.xi[1, :] for i in 1:geo.N_outlet};
          for i in 1:geo.N_inlet loop
            H_flow_inliq[i] = phaseBorder.H_flow_inliq[i];
            H_flow_invap[i] = phaseBorder.H_flow_invap[i];
            Xi_flow_inliq[i, :] = phaseBorder.m_flow_inliq[i] * fluidIn[i].xi;
            Xi_flow_invap[i, :] = phaseBorder.m_flow_invap[i] * fluidIn[i].xi;
          end for;
          for i in 1:geo.N_outlet loop
            H_flow_outliq[i] = phaseBorder.H_flow_outliq[i];
            H_flow_outvap[i] = phaseBorder.H_flow_outvap[i];
            Xi_flow_outliq[i, :] = phaseBorder.m_flow_outliq[i] * fluidOut[i].xi;
            Xi_flow_outvap[i, :] = phaseBorder.m_flow_outvap[i] * fluidOut[i].xi;
          end for;
          for i in 1:geo.N_inlet loop
            inlet[i].p = p_vap + pressureLoss.Delta_p[i] + phaseBorder.Delta_p_geo_in[i];
          end for;
          for i in 1:geo.N_outlet loop
            outlet[i].p = p_vap + phaseBorder.Delta_p_geo_out[i] "The friction term is lumped at the inlet side to avoid direct coupling of two flow models, this avoids an iteration of mass flow rates in some application cases";
          end for;
        end VolumeVLE_L3_TwoZonesNPort;

        model VolumeVLE_L4  "A 1D tube-shaped control volume considering one-phase and two-phase heat transfer in a straight pipe with static momentum balance and simple energy balance." 
          extends ClaRa.Basics.Icons.Volume_L4;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L4");
          outer ClaRa.SimCenter simCenter;

          model Outline  
            extends ClaRa.Basics.Icons.RecordIcon;
            parameter Boolean showExpertSummary;
            input Basics.Units.Volume volume_tot "Total volume of system";
            parameter Integer N_cv "Number of finite volumes";
            input ClaRa.Basics.Units.PressureDifference Delta_p "Pressure difference between outlet and inlet";
            input Basics.Units.Mass mass_tot "Total fluid mass in system mass";
            input Basics.Units.Enthalpy H_tot if showExpertSummary "Total system enthalpy";
            input Basics.Units.HeatFlowRate Q_flow_tot "Heat flow through entire pipe wall";
            input Basics.Units.Mass[N_cv] mass if showExpertSummary "Fluid mass in cells";
            input Basics.Units.Momentum[N_cv + 1] I if showExpertSummary "Momentum of fluid flow volumes through cell borders";
            input Basics.Units.Force[N_cv + 2] I_flow if showExpertSummary "Momentum flow through cell borders";
            input Basics.Units.MassFlowRate[N_cv + 1] m_flow if showExpertSummary "Mass flow through cell borders";
            input Basics.Units.Velocity[N_cv] w if showExpertSummary "Velocity of flow in cells";
          end Outline;

          model Wall_L4  
            extends ClaRa.Basics.Icons.RecordIcon;
            parameter Boolean showExpertSummary;
            parameter Integer N_wall "Number of wall segments";
            input Basics.Units.Temperature[N_wall] T if showExpertSummary "Temperatures of wall segments";
            input Basics.Units.HeatFlowRate[N_wall] Q_flow if showExpertSummary "Heat flows through wall segments";
          end Wall_L4;

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            Outline outline;
            ClaRa.Basics.Records.FlangeVLE inlet;
            ClaRa.Basics.Records.FlangeVLE outlet;
            ClaRa.Basics.Records.FluidVLE_L34 fluid;
            Wall_L4 wall;
          end Summary;

          parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
          inner parameter Boolean frictionAtInlet = false "True if pressure loss between first cell and inlet shall be considered";
          inner parameter Boolean frictionAtOutlet = false "True if pressure loss between last cell and outlet shall be considered";
          replaceable model PressureLoss = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L4 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.PressureLossBaseVLE_L4;
          replaceable model HeatTransfer = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L4 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseVLE_L4;
          replaceable model Geometry = Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry_N_cv constrainedby Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry_N_cv;
          replaceable model MechanicalEquilibrium = ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.Homogeneous_L4 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.MechanicalEquilibrium_L4;
          parameter Basics.Units.Pressure[geo.N_cv] p_nom = ones(geo.N_cv) * 1e5 "Nominal pressure";
          parameter Basics.Units.EnthalpyMassSpecific[geo.N_cv] h_nom = ones(geo.N_cv) * 1e5 "Nominal specific enthalpy for single tube";
          inner parameter Basics.Units.MassFlowRate m_flow_nom = 100 "Nominal mass flow w.r.t. all parallel tubes";
          inner parameter Basics.Units.PressureDifference Delta_p_nom = 1e4 "Nominal pressure loss w.r.t. all parallel tubes";
          final parameter Basics.Units.DensityMassSpecific[geo.N_cv] rho_nom = TILMedia.VLEFluidFunctions.density_phxi(medium, p_nom, h_nom) "Nominal density";
          inner parameter Integer initOption = 0 "Type of initialisation";
          inner parameter Boolean useHomotopy = simCenter.useHomotopy "true, if homotopy method is used during initialisation";
          parameter Basics.Units.EnthalpyMassSpecific[geo.N_cv] h_start = ones(geo.N_cv) * 800e3 "Initial specific enthalpy for single tube";
          parameter Basics.Units.Pressure[geo.N_cv] p_start = ones(geo.N_cv) * 1e5 "Initial pressure";
          parameter Basics.Units.MassFraction[medium.nc - 1] xi_start = zeros(medium.nc - 1) "Initial composition";
        protected
          parameter Basics.Units.Pressure[geo.N_cv] p_start_internal = if size(p_start, 1) == 2 then linspace(p_start[1], p_start[2], geo.N_cv) else p_start "Internal p_start array which allows the user to either state p_inlet, p_outlet if p_start has length 2, otherwise the user can specify an individual pressure profile for initialisation";
        public
          parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if an extended summary shall be shown, else false";
          parameter Boolean showData = false "True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
          Summary summary(outline(showExpertSummary = showExpertSummary, N_cv = geo.N_cv, volume_tot = sum(geo.volume), Delta_p = inlet.p - outlet.p, mass_tot = sum(mass), H_tot = sum(h .* mass), Q_flow_tot = sum(heat.Q_flow), mass = mass, I = geo.Delta_x_FM .* m_flow, I_flow = cat(1, {w_inlet * abs(w_inlet) * fluidInlet.d * geo.A_cross[1]}, {w[i] * abs(w[i]) * fluid[i].d * geo.A_cross[i] for i in 1:geo.N_cv}, {w_outlet * abs(w_outlet) * fluidOutlet.d * geo.A_cross[geo.N_cv]}), m_flow = m_flow, w = w), inlet(showExpertSummary = showExpertSummary, m_flow = inlet.m_flow, T = fluidInlet.T, p = fluidInlet.p, h = fluidInlet.h, s = fluidInlet.s, steamQuality = fluidInlet.q, H_flow = H_flow[1], rho = fluidInlet.d), outlet(showExpertSummary = showExpertSummary, m_flow = -outlet.m_flow, T = fluidOutlet.T, p = fluidOutlet.p, h = fluidOutlet.h, s = fluidOutlet.s, steamQuality = fluidOutlet.q, H_flow = H_flow[geo.N_cv + 1], rho = fluidOutlet.d), fluid(showExpertSummary = showExpertSummary, N_cv = geo.N_cv, mass = mass, T = fluid.T, T_sat = fluid.VLE.T_l, p = p, h = h, h_bub = fluid.VLE.h_l, h_dew = fluid.VLE.h_v, s = fluid.s, steamQuality = fluid.q, H = mass .* h, rho = fluid.d), wall(showExpertSummary = showExpertSummary, N_wall = geo.N_cv, T = heat.T, Q_flow = heat.Q_flow));
        protected
          Basics.Units.EnthalpyMassSpecific[geo.N_cv] h(start = h_start, each stateSelect = StateSelect.prefer) "Cell enthalpy";
          Basics.Units.Pressure[geo.N_cv] p(start = p_start_internal) "Cell pressure";
          Basics.Units.PressureDifference[geo.N_cv + 1] Delta_p_fric "Pressure difference due to friction";
          Basics.Units.PressureDifference[geo.N_cv + 1] Delta_p_grav "pressure drop due to gravity";
          Basics.Units.Mass[geo.N_cv] mass "Mass of fluid in cells";
          Basics.Units.Mass[geo.N_cv + 1] mass_FM = cat(1, {mass[1] / 2}, {(mass[i] + mass[i - 1]) / 2 for i in 2:geo.N_cv}, {mass[geo.N_cv] / 2}) "Mass of fluid in flow cells";
          Real[geo.N_cv] drhodt;
          Basics.Units.MassFraction[geo.N_cv] steamQuality "Steam fraction";
          Basics.Units.MassFraction steamQuality_inlet "Steam fraction";
          Basics.Units.MassFraction steamQuality_outlet "Steam fraction";
          Modelica.SIunits.MassFraction[geo.N_cv, medium.nc - 1] xi "Mass fraction";
          Real[geo.N_cv + 1, medium.nc - 1] Xi_flow "Mass flow rate of fraction";
          Modelica.SIunits.MassFraction[medium.nc - 1] xi_inlet "Inlet mass fraction of component";
          Modelica.SIunits.MassFraction[medium.nc - 1] xi_outlet "Outlet mass fraction of component";
          Basics.Units.Power[geo.N_cv + 1] H_flow "Enthalpy flow rate at cell borders";
          Basics.Units.MassFlowRate[geo.N_cv + 1] m_flow(start = ones(geo.N_cv + 1) * m_flow_nom, nominal = ones(geo.N_cv + 1) * m_flow_nom);
          Basics.Units.Velocity[geo.N_cv] w "flow velocities within cells of energy model == flow velocities across cell borders of flow model ";
          Basics.Units.Velocity w_inlet "flow velocity at inlet";
          Basics.Units.Velocity w_outlet "flow velocity at outlet";
        public
          ClaRa.Basics.Interfaces.FluidPortIn inlet(Medium = medium) "Inlet port";
          ClaRa.Basics.Interfaces.FluidPortOut outlet(Medium = medium) "Outlet port";
          ClaRa.Basics.Interfaces.HeatPort_a[geo.N_cv] heat;
          PressureLoss pressureLoss "Pressure loss model";
          HeatTransfer heatTransfer(A_heat = geo.A_heat_CF[:, 1]) "heat transfer model";
          inner Geometry geo;
          MechanicalEquilibrium mechanicalEquilibrium(final h_start = h_start) "Mechanical equilibrium model";
        protected
          inner TILMedia.VLEFluid_ph[geo.N_cv] fluid(p = p, h = h, each vleFluidType = medium, each computeTransportProperties = true, xi = xi);
          inner TILMedia.VLEFluid_ph fluidInlet(p = inlet.p, vleFluidType = medium, h = noEvent(actualStream(inlet.h_outflow)), computeTransportProperties = true, xi = xi_inlet);
          inner TILMedia.VLEFluid_ph fluidOutlet(p = outlet.p, vleFluidType = medium, h = noEvent(actualStream(outlet.h_outflow)), computeTransportProperties = true, xi = xi_outlet);
          inner Basics.Records.IComVLE_L3_OnePort iCom(mediumModel = medium, N_cv = geo.N_cv, xi = xi, volume = geo.volume, p_in = {inlet.p}, T_in = {fluidInlet.T}, m_flow_in = {inlet.m_flow}, h_in = {fluidInlet.h}, xi_in = {fluidInlet.xi}, p_out = {outlet.p}, T_out = {fluidOutlet.T}, m_flow_out = {outlet.m_flow}, h_out = {fluidOutlet.h}, xi_out = {fluidOutlet.xi}, p_nom = p_nom[1], Delta_p_nom = Delta_p_nom, m_flow_nom = m_flow_nom, h_nom = h_nom[1], T = fluid.T, p = p, h = h, fluidPointer_in = {fluidInlet.vleFluidPointer}, fluidPointer_out = {fluidOutlet.vleFluidPointer}, fluidPointer = fluid.vleFluidPointer);
        initial equation
          if initOption == 208 then
            der(h) = zeros(geo.N_cv);
            der(p) = zeros(geo.N_cv);
          elseif initOption == 201 then
            der(p) = zeros(geo.N_cv);
          elseif initOption == 202 then
            der(h) = zeros(geo.N_cv);
          elseif initOption == 0 then
          else
            assert(false, "Unknown init option in " + getInstanceName());
          end if;
          for i in 1:geo.N_cv loop
            xi[i, :] = xi_start[1:end];
          end for;
        equation
          connect(heat, heatTransfer.heat);
          w_inlet = inlet.m_flow / (geo.A_cross_FM[1] * fluidInlet.d);
          w_outlet = -outlet.m_flow / (geo.A_cross_FM[geo.N_cv + 1] * fluidOutlet.d);
          steamQuality_inlet = fluidInlet.q;
          steamQuality_outlet = fluidOutlet.q;
          for i in 1:geo.N_cv loop
            w[i] = (m_flow[i] + m_flow[i + 1]) / (2 * fluid[i].d * geo.A_cross[i]);
            steamQuality[i] = fluid[i].q;
          end for;
          m_flow[1] = inlet.m_flow;
          m_flow = pressureLoss.m_flow;
          m_flow[geo.N_cv + 1] = -outlet.m_flow;
          heatTransfer.m_flow = m_flow;
          mechanicalEquilibrium.m_flow = m_flow;
          Delta_p_fric = pressureLoss.Delta_p;
          if geo.N_cv == 1 then
            if not frictionAtInlet and not frictionAtOutlet then
              Delta_p_grav[1] = 0;
              Delta_p_grav[2] = 0;
            elseif not frictionAtInlet and frictionAtOutlet then
              Delta_p_grav[1] = 0;
              Delta_p_grav[2] = fluid[1].d * .Modelica.Constants.g_n * (geo.z_out - geo.z_in);
            elseif frictionAtInlet and not frictionAtOutlet then
              Delta_p_grav[1] = fluid[1].d * .Modelica.Constants.g_n * (geo.z_out - geo.z_in);
              Delta_p_grav[2] = 0;
            else
              Delta_p_grav[1] = fluid[1].d * .Modelica.Constants.g_n * (geo.z[1] - geo.z_in);
              Delta_p_grav[2] = fluid[1].d * .Modelica.Constants.g_n * (geo.z_out - geo.z[1]);
            end if;
          elseif geo.N_cv == 2 then
            if not frictionAtInlet and not frictionAtOutlet then
              Delta_p_grav[1] = 0;
              Delta_p_grav[2] = fluid[2].d * .Modelica.Constants.g_n * (geo.z_out - geo.z_in);
              Delta_p_grav[3] = 0;
            elseif not frictionAtInlet and frictionAtOutlet then
              Delta_p_grav[1] = 0;
              Delta_p_grav[2] = (fluid[1].d * geo.Delta_x[1] + fluid[2].d * geo.Delta_x[2] / 2) / (geo.Delta_x[2] / 2 + geo.Delta_x[1]) * .Modelica.Constants.g_n * (geo.z[2] - geo.z_in);
              Delta_p_grav[3] = fluid[2].d * .Modelica.Constants.g_n * (geo.z_out - geo.z[2]);
            elseif frictionAtInlet and not frictionAtOutlet then
              Delta_p_grav[1] = fluid[1].d * .Modelica.Constants.g_n * (geo.z[1] - geo.z_in);
              Delta_p_grav[2] = (fluid[2].d * geo.Delta_x[2] + fluid[1].d * geo.Delta_x[1] / 2) / (geo.Delta_x[1] / 2 + geo.Delta_x[2]) * .Modelica.Constants.g_n * (geo.z_out - geo.z[1]);
              Delta_p_grav[3] = 0;
            else
              Delta_p_grav[1] = fluid[1].d * .Modelica.Constants.g_n * (geo.z[1] - geo.z_in);
              Delta_p_grav[2] = (fluid[1].d * geo.Delta_x[1] + fluid[2].d * geo.Delta_x[2]) / (geo.Delta_x[2] + geo.Delta_x[1]) * .Modelica.Constants.g_n * (geo.z[2] - geo.z[1]);
              Delta_p_grav[3] = fluid[2].d * .Modelica.Constants.g_n * (geo.z_out - geo.z[2]);
            end if;
          else
            for i in 3:geo.N_cv - 1 loop
              Delta_p_grav[i] = (fluid[i].d * geo.Delta_x[i] + fluid[i - 1].d * geo.Delta_x[i - 1]) / (geo.Delta_x[i - 1] + geo.Delta_x[i]) * .Modelica.Constants.g_n * (geo.z[i] - geo.z[i - 1]);
            end for;
            if frictionAtInlet then
              Delta_p_grav[1] = fluid[1].d * .Modelica.Constants.g_n * (geo.z[1] - geo.z_in);
              Delta_p_grav[2] = (fluid[1].d * geo.Delta_x[1] + fluid[2].d * geo.Delta_x[2]) / (geo.Delta_x[2] + geo.Delta_x[1]) * .Modelica.Constants.g_n * (geo.z[2] - geo.z[1]);
            else
              Delta_p_grav[1] = 0;
              Delta_p_grav[2] = (fluid[1].d * geo.Delta_x[1] + fluid[2].d * geo.Delta_x[2] / 2) / (geo.Delta_x[2] / 2 + geo.Delta_x[1]) * .Modelica.Constants.g_n * (geo.z[2] - geo.z_in);
            end if;
            if frictionAtOutlet then
              Delta_p_grav[geo.N_cv + 1] = fluid[geo.N_cv].d * .Modelica.Constants.g_n * (geo.z_out - geo.z[geo.N_cv]);
              Delta_p_grav[geo.N_cv] = (fluid[geo.N_cv - 1].d * geo.Delta_x[geo.N_cv - 1] + fluid[geo.N_cv].d * geo.Delta_x[geo.N_cv]) / (geo.Delta_x[geo.N_cv - 1] + geo.Delta_x[geo.N_cv]) * .Modelica.Constants.g_n * (geo.z[geo.N_cv] - geo.z[geo.N_cv - 1]);
            else
              Delta_p_grav[geo.N_cv + 1] = 0;
              Delta_p_grav[geo.N_cv] = (fluid[geo.N_cv - 1].d * geo.Delta_x[geo.N_cv - 1] / 2 + fluid[geo.N_cv].d * geo.Delta_x[geo.N_cv]) / (geo.Delta_x[geo.N_cv - 1] / 2 + geo.Delta_x[geo.N_cv]) * .Modelica.Constants.g_n * (geo.z_out - geo.z[geo.N_cv - 1]);
            end if;
          end if;
          for i in 2:geo.N_cv loop
            H_flow[i] = if useHomotopy then homotopy(semiLinear(m_flow[i], mechanicalEquilibrium.h[i - 1], mechanicalEquilibrium.h[i]), mechanicalEquilibrium.h[i - 1] * m_flow_nom) else semiLinear(m_flow[i], mechanicalEquilibrium.h[i - 1], mechanicalEquilibrium.h[i]);
          end for;
          H_flow[1] = if useHomotopy then homotopy(semiLinear(m_flow[1], inStream(inlet.h_outflow), mechanicalEquilibrium.h[1]), inStream(inlet.h_outflow) * m_flow_nom) else semiLinear(m_flow[1], inStream(inlet.h_outflow), mechanicalEquilibrium.h[1]);
          H_flow[geo.N_cv + 1] = if useHomotopy then homotopy(semiLinear(m_flow[geo.N_cv + 1], mechanicalEquilibrium.h[geo.N_cv], inStream(outlet.h_outflow)), mechanicalEquilibrium.h[geo.N_cv] * m_flow_nom) else semiLinear(m_flow[geo.N_cv + 1], mechanicalEquilibrium.h[geo.N_cv], inStream(outlet.h_outflow));
          mass = if useHomotopy then homotopy(geo.volume .* mechanicalEquilibrium.rho_mix, geo.volume .* rho_nom) else geo.volume .* mechanicalEquilibrium.rho_mix;
          for i in 1:geo.N_cv loop
            der(h[i]) = (H_flow[i] - H_flow[i + 1] + heat[i].Q_flow + der(p[i]) * geo.volume[i] - h[i] * geo.volume[i] * drhodt[i]) / mass[i];
            der(xi[i, :]) = 1 / mass[i] * (Xi_flow[i, :] - m_flow[i] * xi[i, :] - (Xi_flow[i + 1, :] - m_flow[i + 1] * xi[i, :])) "Component mass balance";
            drhodt[i] * geo.volume[i] = m_flow[i] - m_flow[i + 1] "Mass balance";
            fluid[i].drhodp_hxi * der(p[i]) = drhodt[i] - der(h[i]) * fluid[i].drhodh_pxi - sum({fluid[i].drhodxi_ph[j] * der(xi[i, j]) for j in 1:medium.nc - 1}) "Calculate pressure from enthalpy and density derivative";
          end for;
          for i in 2:geo.N_cv loop
            0 = if useHomotopy then homotopy(p[i - 1] - p[i] - Delta_p_fric[i] - Delta_p_grav[i], p[i - 1] - p[i] - Delta_p_fric[i] - Delta_p_grav[i]) else p[i - 1] - p[i] - Delta_p_fric[i] - Delta_p_grav[i];
          end for;
          0 = if useHomotopy then homotopy(inlet.p - p[1] - Delta_p_fric[1] - Delta_p_grav[1], inlet.p - p[1] - Delta_p_fric[1] - Delta_p_grav[1]) else inlet.p - p[1] - Delta_p_fric[1] - Delta_p_grav[1];
          0 = if useHomotopy then homotopy(p[geo.N_cv] - outlet.p - Delta_p_fric[geo.N_cv + 1] - Delta_p_grav[geo.N_cv + 1], p[geo.N_cv] - outlet.p - Delta_p_fric[geo.N_cv + 1] - Delta_p_grav[geo.N_cv + 1]) else p[geo.N_cv] - outlet.p - Delta_p_fric[geo.N_cv + 1] - Delta_p_grav[geo.N_cv + 1];
          inlet.h_outflow = mechanicalEquilibrium.h[1];
          outlet.h_outflow = mechanicalEquilibrium.h[geo.N_cv];
          for i in 2:geo.N_cv loop
            Xi_flow[i, :] = if useHomotopy then homotopy(semiLinear(m_flow[i], xi[i - 1, :], xi[i, :]), xi[i - 1, :] * m_flow_nom) else semiLinear(m_flow[i], xi[i - 1, :], xi[i, :]);
          end for;
          Xi_flow[1, :] = if useHomotopy then homotopy(semiLinear(m_flow[1], fluidInlet.xi[:], xi[1, :]), fluidInlet.xi[:] * m_flow_nom) else semiLinear(m_flow[1], fluidInlet.xi[:], xi[1, :]);
          Xi_flow[geo.N_cv + 1, :] = if useHomotopy then homotopy(semiLinear(m_flow[geo.N_cv + 1], xi[geo.N_cv, :], fluidOutlet.xi[:]), xi[geo.N_cv, :] * m_flow_nom) else semiLinear(m_flow[geo.N_cv + 1], xi[geo.N_cv, :], fluidOutlet.xi[:]);
          inlet.xi_outflow[:] = xi[1, :];
          outlet.xi_outflow[:] = xi[geo.N_cv, :];
          xi_inlet = noEvent(actualStream(inlet.xi_outflow));
          xi_outlet = noEvent(actualStream(outlet.xi_outflow));
        end VolumeVLE_L4;
      end FluidVolumes;

      package SolidVolumes  "Elements for modeling heat conduction and storage" 
        extends ClaRa.Basics.Icons.PackageIcons.Basics60;

        model CylindricalThinWall_L4  "A thin cylindric wall with axial discretisation" 
          extends ClaRa.Basics.Icons.WallThinLarge;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L4");
          replaceable model Material = TILMedia.SolidTypes.TILMedia_Aluminum constrainedby TILMedia.SolidTypes.BaseSolid;
          input Real CF_lambda = 1 "Time-dependent correction factor for thermal conductivity";
          parameter Integer N_ax = 3 "Number of axial elements";
          parameter Modelica.SIunits.Length[N_ax] Delta_x = ClaRa.Basics.Functions.GenerateGrid({0}, length, N_ax) "Discretisation scheme";
          parameter Units.Length diameter_o "Outer diameter";
          parameter Units.Length diameter_i "Inner diameter";
          parameter Units.Length length "Length of cylinder";
          parameter Integer N_tubes = 1 "Number of tubes in parallel";
          parameter Units.Temperature[N_ax] T_start = ones(N_ax) * 293.15 "Start values of wall temperature";
          inner parameter Integer initOption = 0 "Type of initialisation";
          parameter Integer stateLocation = 2 "Location of states";
          parameter String suppressChattering = "True" "Enable to suppress possible chattering";
          final parameter Units.Mass mass_nominal = sum(solid.d .* Modelica.Constants.pi / 4 * (diameter_o ^ 2 - diameter_i ^ 2) * Delta_x * N_tubes) "Mass of wall (deprecated)";
          final parameter Units.Mass mass = sum(solid.d .* Modelica.Constants.pi / 4 * (diameter_o ^ 2 - diameter_i ^ 2) * Delta_x * N_tubes) "Mass of wall";
        protected
          final parameter Units.HeatFlowRate Q_flow_nom = 1;
          constant Real Q_flow_eps = 1e-9;
        public
          Units.Temperature[N_ax] T(start = T_start, each nominal = 500) "Axial temperatures";
        protected
          Units.HeatFlowRate[N_ax] Delta_Q_flow(each nominal = 1e5);
          Units.InternalEnergy[N_ax] U(each nominal = 4e6);
        public
          ClaRa.Basics.Interfaces.HeatPort_a[N_ax] outerPhase(T(start = T_start)) "outer side of the cylinder";
          TILMedia.Solid[N_ax] solid(T(start = T_start) = T, redeclare each replaceable model SolidType = Material);
          ClaRa.Basics.Interfaces.HeatPort_b[N_ax] innerPhase(T(start = T_start)) "Inner sider of the cylinder";

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            input ClaRa.Basics.Units.Length diameter_o "Outer diameter";
            input ClaRa.Basics.Units.Length diameter_i "Inner diameter";
            input Units.Length length "Length of cylinder";
            input Integer N_tubes "Number of tubes in parallel";
            input ClaRa.Basics.Units.Mass mass "Wall mass";
            parameter Integer N_ax "Number of axial elements";
            input ClaRa.Basics.Units.InternalEnergy[N_ax] U "Inner energy of wall";
            input Units.Temperature[N_ax] T_i "Inner phase temperature";
            input Units.Temperature[N_ax] T_o "Outer phase temperature";
            input ClaRa.Basics.Units.Temperature[N_ax] T "Wall temperature";
            input Real[N_ax] lambda "Heat conductivity";
            input Units.HeatFlowRate[N_ax] Q_flow_i "Heat flow rate to inner phase";
            input Units.HeatFlowRate[N_ax] Q_flow_o "Heat flow rate to outer phase";
            input Units.HeatCapacityMassSpecific[N_ax] cp "Specific heat capacity";
            input Units.DensityMassSpecific[N_ax] d "Material density";
          end Summary;

          Summary summary(diameter_o = diameter_o, diameter_i = diameter_i, length = length, N_tubes = N_tubes, mass = mass, N_ax = N_ax, U = U, T_i = innerPhase.T, T_o = outerPhase.T, T = T, lambda = solid.lambda, Q_flow_i = innerPhase.Q_flow, Q_flow_o = outerPhase.Q_flow, cp = solid.cp, d = solid.d);
        initial equation
          if initOption == 1 then
            der(U) = zeros(N_ax);
          elseif initOption == 203 then
            der(T) = zeros(N_ax);
          elseif initOption == 0 then
            T = T_start;
          else
            assert(initOption == 0, "Invalid init option");
          end if;
        equation
          assert(diameter_o > diameter_i, "The outer diameter has to be greater then the inner diameter!");
          for i in 1:N_ax loop
            U[i] = T[i] * solid[i].d * (Modelica.Constants.pi / 4 * (diameter_o ^ 2 - diameter_i ^ 2) * Delta_x[i] * N_tubes) * solid[i].cp;
            if suppressChattering == "True" then
              der(U[i]) = Delta_Q_flow[i] * Q_flow_nom;
              Delta_Q_flow[i] = noEvent(if abs(innerPhase[i].Q_flow + outerPhase[i].Q_flow) > Q_flow_eps then innerPhase[i].Q_flow + outerPhase[i].Q_flow else 0) / Q_flow_nom;
            else
              der(U[i]) = Delta_Q_flow[i];
              Delta_Q_flow[i] = innerPhase[i].Q_flow + outerPhase[i].Q_flow;
            end if;
            if stateLocation == 1 then
              outerPhase[i].T = outerPhase[i].Q_flow .* log(diameter_o / diameter_i) / (2 * Delta_x[i] * N_tubes * solid[i].lambda * CF_lambda * Modelica.Constants.pi) + T[i];
              innerPhase[i].T = T[i];
            elseif stateLocation == 2 then
              innerPhase[i].Q_flow = solid[i].lambda * CF_lambda * (2 * Modelica.Constants.pi * Delta_x[i] * N_tubes) / log((diameter_o + diameter_i) / (2 * diameter_i)) * (innerPhase[i].T - T[i]);
              outerPhase[i].Q_flow = solid[i].lambda * CF_lambda * (2 * Modelica.Constants.pi * Delta_x[i] * N_tubes) / log(2 * diameter_o / (diameter_o + diameter_i)) * (outerPhase[i].T - T[i]);
            else
              outerPhase[i].T = T[i];
              innerPhase[i].T = innerPhase[i].Q_flow .* log(diameter_o / diameter_i) / (2 * Delta_x[i] * N_tubes * solid[i].lambda * CF_lambda * Modelica.Constants.pi) + T[i];
            end if;
          end for;
        end CylindricalThinWall_L4;

        model CylindricalThickWall_L4  "A thick cylindric wall with radial discretisation" 
          extends ClaRa.Basics.Icons.WallThick;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L4");
          replaceable model Material = TILMedia.SolidTypes.TILMedia_Aluminum constrainedby TILMedia.SolidTypes.BaseSolid;
          input Real CF_lambda = 1 "Time-dependent correction factor for thermal conductivity";
        protected
          parameter Integer N_A_heat = N_rad * 2 "Number of surfaces used in order to model heat flow";
        public
          parameter Integer N_rad = 1 "Number of radial elements";
          parameter Real sizefunc = 0 "Stretching of the volume elements (+1: inner elements are smaller)";
          parameter .Modelica.SIunits.Length diameter_o "Outer diameter";
          parameter .Modelica.SIunits.Length diameter_i "Inner diameter";
          parameter .Modelica.SIunits.Length length "Length of cylinder";
          parameter Integer N_tubes = 1 "Number of tubes in parallel";
          parameter Units.Mass mass_struc = 0 "Mass of inner structure elements, additional to the tubes itself";
          parameter .Modelica.SIunits.Temperature[N_rad] T_start = ones(N_rad) * 293.15 "Start values of wall temperature inner --> outer";
          inner parameter Integer initOption = 0 "Type of initialisation";
          final parameter .Modelica.SIunits.Mass mass_nominal = solid[N_rad].d * Modelica.Constants.pi / 4 * (diameter_o ^ 2 - diameter_i ^ 2) * length * N_tubes "Wall mass (deprecated)";
          final parameter .Modelica.SIunits.Mass mass = mass_struc + solid[N_rad].d * Modelica.Constants.pi / 4 * (diameter_o ^ 2 - diameter_i ^ 2) * length * N_tubes "Wall mass";
          .Modelica.SIunits.Length[N_rad] Delta_radius "Thicknes of the volume elements";
          .Modelica.SIunits.Length[N_rad + 1] radius "Radii of the heat transfer areas";
          .Modelica.SIunits.Temperature[N_rad] T(start = T_start, each nominal = 300) "Solid material temperature";
          .Modelica.SIunits.InternalEnergy[N_rad] U "Internal energy";
          .Modelica.SIunits.HeatFlowRate[N_rad + 1] Q_flow "Heat flow through material";
          .Modelica.SIunits.Area[N_A_heat] A_heat;
          .Modelica.SIunits.Length[N_A_heat] radius_m;
          .Modelica.SIunits.Length[N_rad + 2] radius_v "Radial position of the volume elements";
          Real[N_rad + 1] Tdr "Integral(Tdr)";
          .Modelica.SIunits.Temperature T_mean "Mean temperature";
          ClaRa.Basics.Interfaces.HeatPort_a outerPhase "outer side of the cylinder";
          TILMedia.Solid[N_rad] solid(T = T, redeclare each model SolidType = Material);
          ClaRa.Basics.Interfaces.HeatPort_b innerPhase "Inner sider of the cylinder";

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            parameter Integer N_rad "Number of radial elements";
            parameter Integer N_A_heat "Number of surfaces used in order to model heat flow";
            input .Modelica.SIunits.Length diameter_o "Outer diameter";
            input .Modelica.SIunits.Length diameter_i "Inner diameter";
            input .Modelica.SIunits.Length length "Length of cylinder";
            input Integer N_tubes "Number of tubes in parallel";
            input .Modelica.SIunits.Length[N_rad] Delta_radius "Thicknes of the volume elements";
            input .Modelica.SIunits.Length[N_rad + 1] radius "Radii of the heat transfer areas";
            input .Modelica.SIunits.Temperature[N_rad] T "Solid material temperature";
            input .Modelica.SIunits.InternalEnergy[N_rad] U "Internal energy";
            input .Modelica.SIunits.HeatFlowRate[N_rad + 1] Q_flow "Heat flow through material";
            input .Modelica.SIunits.Area[N_A_heat] A_heat;
            input .Modelica.SIunits.Length[N_A_heat] radius_m;
            input .Modelica.SIunits.Length[N_rad + 2] radius_v "Radial position of the volume elements";
            input .Modelica.SIunits.Mass mass;
            input Units.HeatCapacityMassSpecific[N_rad] cp "Specific heat capacity";
            input Units.DensityMassSpecific[N_rad] d "Material density";
          end Summary;

          Summary summary(N_rad = N_rad, N_A_heat = N_A_heat, diameter_o = diameter_o, diameter_i = diameter_i, length = length, N_tubes = N_tubes, Delta_radius = Delta_radius, radius = radius, T = T, U = U, Q_flow = Q_flow, A_heat = A_heat, radius_m = radius_m, radius_v = radius_v, mass = mass, cp = solid.cp, d = solid.d);
        initial equation
          if initOption == 1 then
            der(U) = zeros(N_rad);
          elseif initOption == 203 then
            der(T) = zeros(N_rad);
          elseif initOption == 0 then
            T = T_start;
          else
            assert(initOption == 0, "Invalid init option");
          end if;
        equation
          if sizefunc >= 0 then
            Delta_radius = {(diameter_o - diameter_i) / 2 * i ^ sizefunc for i in 1:N_rad} / sum({i ^ sizefunc for i in 1:N_rad});
          else
            Delta_radius = {(diameter_o - diameter_i) / 2 * (N_rad + 1 - i) ^ (-sizefunc) for i in 1:N_rad} / sum({i ^ (-sizefunc) for i in 1:N_rad});
          end if;
          assert(diameter_o > diameter_i, "Outer diameter of tubes must be greater than inner diameter");
          radius[1] = diameter_i / 2;
          for i in 2:N_rad + 1 loop
            radius[i] = radius[i - 1] + Delta_radius[i - 1];
          end for;
          radius_v[1] = radius[1];
          radius_v[N_rad + 2] = diameter_o / 2;
          for i in 2:N_rad + 1 loop
            radius_v[i] = radius[i - 1] + Delta_radius[i - 1] / 2;
          end for;
          for i in 1:N_A_heat loop
            A_heat[i] = radius_m[i] * 2 * Modelica.Constants.pi * length * N_tubes;
          end for;
          for i in 1:N_rad loop
            U[i] = (mass_struc / N_rad * solid[i].cp + solid[i].cp * solid[i].d * Modelica.Constants.pi * (radius[i + 1] ^ 2 - radius[i] ^ 2) * length * N_tubes) * T[i];
            der(U[i]) = Q_flow[i] - Q_flow[i + 1];
          end for;
          innerPhase.Q_flow = Q_flow[1];
          outerPhase.Q_flow = -Q_flow[N_rad + 1];
          for i in 2:N_rad loop
            Tdr[i] = radius_v[i + 1] * T[i] - radius_v[i] * T[i - 1] - (T[i] - T[i - 1]) * (radius_v[i + 1] - radius_v[i]) / log(radius_v[i + 1] / radius_v[i]);
          end for;
          Tdr[1] = radius_v[2] * T[1] - radius_v[1] * innerPhase.T - (T[1] - innerPhase.T) * (radius_v[2] - radius_v[1]) / log(radius_v[2] / radius_v[1]);
          Tdr[N_rad + 1] = radius_v[N_rad + 2] * outerPhase.T - radius_v[N_rad + 1] * T[N_rad] - (outerPhase.T - T[N_rad]) * (radius_v[N_rad + 2] - radius_v[N_rad + 1]) / log(radius_v[N_rad + 2] / radius_v[N_rad + 1]);
          T_mean = sum(Tdr) / ((diameter_o - diameter_i) / 2);
          for i in 1:N_rad loop
            radius_m[2 * i - 1] = (radius_v[i + 1] - radius[i]) / Modelica.Math.log(radius_v[i + 1] / radius[i]);
            radius_m[2 * i] = (radius[i + 1] - radius_v[i + 1]) / Modelica.Math.log(radius[i + 1] / radius_v[i + 1]);
          end for;
          Q_flow[1] = solid[1].lambda * CF_lambda * 2 / Delta_radius[1] * A_heat[1] * (innerPhase.T - T[1]);
          Q_flow[N_rad + 1] = solid[N_rad].lambda * CF_lambda * 2 / Delta_radius[N_rad] * A_heat[2 * N_rad] * (T[N_rad] - outerPhase.T);
          for i in 2:N_rad loop
            Q_flow[i] = 2 * (solid[i].lambda * CF_lambda * A_heat[2 * i - 1] * solid[i - 1].lambda * CF_lambda * A_heat[2 * i - 2]) / (solid[i - 1].lambda * CF_lambda * Delta_radius[i] * A_heat[2 * i - 2] + solid[i].lambda * CF_lambda * Delta_radius[i - 1] * A_heat[2 * i - 1]) * (T[i - 1] - T[i]);
          end for;
        end CylindricalThickWall_L4;
      end SolidVolumes;

      package Fundamentals  "Replaceable models for control volumes" 
        extends ClaRa.Basics.Icons.PackageIcons.Basics60;

        package Geometry  "Replaceable models for geometry definition" 
          extends ClaRa.Basics.Icons.PackageIcons.Basics50;

          partial model BlockShape  "Partial model for block-shaped geometry definitions" end BlockShape;

          partial model TubeType  "Partial model for definition of tube-type replaceable models" end TubeType;

          partial model ShellWithTubes  "geometry definition for a shell with tubes inside" end ShellWithTubes;

          model GenericGeometry  "All shapes || Base class" 
            parameter Units.Volume volume(min = Modelica.Constants.eps) = 1 "Volume of the component";
            parameter Integer N_heat = 2 "No. of heat transfer areas";
            parameter Units.Area[N_heat] A_heat(each min = Modelica.Constants.eps) = ones(N_heat) "Heat transfer area: /1/ dedicated to lateral surface";
            final parameter Units.Area[N_heat] A_heat_CF(each min = Modelica.Constants.eps) = {A_heat[i] * CF_geo[i] for i in 1:N_heat} "Corrected heat transfer area: /1/ dedicated to lateral surface";
            parameter Real[N_heat] CF_geo(each min = Modelica.Constants.eps) = ones(N_heat) "Correction factor for heat transfer area: /1/ dedicated to lateral surface";
            parameter Units.Area A_cross(min = Modelica.Constants.eps) = 1 "Cross section for mass flow";
            parameter Units.Area A_front(min = Modelica.Constants.eps) = 1 "Frontal area";
            parameter Units.Area A_hor = 1 "Nominal horizonal area";
            parameter Integer N_inlet = 1 "Number of inlet ports";
            parameter Integer N_outlet = 1 "Number of outlet ports";
            parameter Units.Length[N_inlet] z_in = ones(N_inlet) "Height of inlet ports";
            parameter Units.Length[N_outlet] z_out = ones(N_outlet) "Height of outlet ports";
            parameter Units.Length height_fill = 1 "Fillable height of component";
            parameter Real[:, 2] shape = [0, 1; 1, 1] "Shape factor, i.e. A_horitontal=A_hor*interp(shape, relLevel)";
          end GenericGeometry;

          model GenericGeometry_N_cv  "Dicretized geometry base class|| All shapes" 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.TubeType;
            parameter Units.Volume[N_cv] volume(min = ones(N_cv) * Modelica.Constants.eps) = ones(N_cv) "Volume of the control volume";
            parameter Integer N_heat = 2 "No. of heat transfer areas";
            parameter Real[N_heat] CF_geo(each min = Modelica.Constants.eps) = ones(N_heat) "Correction factor for heat transfer area: /1/ dedicated to lateral surface";
            parameter Units.Area[N_cv, N_heat] A_heat(each min = Modelica.Constants.eps) = ones(N_cv, N_heat) "Heat transfer area: /1/ dedicated to lateral surface";
            final parameter Units.Area[N_cv, N_heat] A_heat_CF(each min = Modelica.Constants.eps) = {{A_heat[j, i] * CF_geo[i] for i in 1:N_heat} for j in 1:N_cv} "Corrected heat transfer area: /1/ dedicated to lateral surface";
            final parameter Units.Area[N_heat] A_heat_tot = {sum(A_heat[:, i]) for i in 1:N_heat} "Total Heat transfer area: /1/ dedicated to lateral surface";
            parameter Units.Area[N_cv] A_cross(min = ones(N_cv) * Modelica.Constants.eps) = ones(N_cv) * 1 "Cross section for mass flow";
            final parameter Units.Area[N_cv + 1] A_cross_FM(min = ones(N_cv + 1) * Modelica.Constants.eps) = cat(1, {A_cross[1]}, {(A_cross[i] + A_cross[i + 1]) / 2 for i in 1:N_cv - 1}, {A_cross[N_cv]}) "Cross section for mass flow";
            parameter Units.Length z_in = 0 "Height of inlet ports";
            parameter Units.Length z_out = 0 "Height of outlet ports";
            parameter Basics.Units.Length[N_cv] z = fill(1, N_cv) "Height of center of cells";
            parameter ClaRa.Basics.Units.Length[N_cv] Delta_z_in = {sum(Delta_x[1:i]) - Delta_x[i] / 2 for i in 1:N_cv} "Length from inlet to center of cells";
            parameter Units.Length[N_cv] diameter_hyd = ones(N_cv) "Hydraulic diameter of the component";
            parameter Integer N_cv = 3 "Number of control volumes";
            parameter Units.Length[N_cv] Delta_x = fill(1, N_cv) "Discretisation scheme";
            parameter Units.Length[N_cv + 1] Delta_x_FM = cat(1, {Delta_x[1] / 2}, {(Delta_x[i - 1] + Delta_x[i]) / 2 for i in 2:N_cv}, {Delta_x[N_cv] / 2}) "Discretisation scheme (Flow model)";
            final parameter Units.Volume[N_cv + 1] volume_FM = cat(1, {volume[1] / 2}, {volume[i - 1] * Delta_x[i - 1] / 2 / Delta_x_FM[i] + volume[i] * Delta_x[i] / 2 / Delta_x_FM[i] for i in 2:N_cv}, {volume[N_cv] / 2});
          end GenericGeometry_N_cv;

          model HollowBlockWithTubesAndHotwell  "Block shape || Shell with tubes || Hotwell" 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.BlockShape;
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.ShellWithTubes;
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry(final volume = if flowOrientation == ClaRa.Basics.Choices.GeometryOrientation.horizontal then if parallelTubes then width * height * length - N_tubes * N_passes * Modelica.Constants.pi / 4 * diameter_t ^ 2 * length + height_hotwell * width_hotwell * length_hotwell else width * height * length - N_tubes * N_passes * Modelica.Constants.pi / 4 * diameter_t ^ 2 * width + height_hotwell * width_hotwell * length_hotwell else if parallelTubes then width * height * length - Modelica.Constants.pi / 4 * diameter_t ^ 2 * height * N_tubes * N_passes + height_hotwell * width_hotwell * length_hotwell else width * height * length - Modelica.Constants.pi / 4 * diameter_t ^ 2 * length * N_tubes * N_passes + height_hotwell * width_hotwell * length_hotwell, final N_heat = 2, final A_heat = {if flowOrientation == ClaRa.Basics.Choices.GeometryOrientation.vertical then if parallelTubes then 2 * (width + length) * height + 2 * height_hotwell * (length_hotwell + width_hotwell) + length * width else 2 * (width + length) * height - 2 * N_tubes * Modelica.Constants.pi * diameter_t ^ 2 / 4 + 2 * height_hotwell * (length_hotwell + width_hotwell) + length * width else if parallelTubes then 2 * (width + height) * length + 2 * height_hotwell * (length_hotwell + width_hotwell) else 2 * (width + height) * length - 2 * N_tubes * Modelica.Constants.pi * diameter_t ^ 2 / 4 + 2 * height_hotwell * (length_hotwell + width_hotwell), if flowOrientation == ClaRa.Basics.Choices.GeometryOrientation.horizontal then if parallelTubes then N_tubes * N_passes * Modelica.Constants.pi * diameter_t * length else N_tubes * N_passes * Modelica.Constants.pi * diameter_t * width else if parallelTubes then Modelica.Constants.pi * diameter_t * height * N_tubes * N_passes else Modelica.Constants.pi * diameter_t * length * N_tubes * N_passes}, final A_cross = if parallelTubes then A_front - Modelica.Constants.pi / 4 * diameter_t ^ 2 * N_tubes * N_passes else A_front * psi, final A_front = if flowOrientation == ClaRa.Basics.Choices.GeometryOrientation.horizontal then height * width else width * length, final A_hor = width_hotwell * length_hotwell, final height_fill = height_hotwell + height, final shape = {{height_fill / 20 * (i - 1) / height_fill, if height_fill / 20 * (i - 1) < height_hotwell then 1 else (height_hotwell * length_hotwell * width_hotwell + (height_fill / 20 * (i - 1) - height_hotwell) * length * width * interior) / (height_fill / 20 * (i - 1)) / A_hor} for i in 1:20});
            parameter Units.Length height = 1 "Height of the component; Fixed flow direction in case of vertical flow orientation";
            parameter Units.Length width = 1 "Width of the component";
            parameter Units.Length length = 1 "|Essential Geometry Definition|Length of the component; Fixed flow direction in case of horizontal flow orientation";
            parameter ClaRa.Basics.Choices.GeometryOrientation flowOrientation = ClaRa.Basics.Choices.GeometryOrientation.horizontal "Orientation of shell side flow";
            final parameter Real interior = (volume - height_hotwell * width_hotwell * length_hotwell) / (width * height * length) "Void fraction in the shell";
            parameter ClaRa.Basics.Units.Length height_hotwell = 1 "|Hotwell Definition|Height of the hotwell";
            parameter ClaRa.Basics.Units.Length width_hotwell = 1 "|Hotwell Definition|Width of the hotwell";
            parameter ClaRa.Basics.Units.Length length_hotwell = 1 "|Hotwell Definition|Length of the hotwell";
            parameter Units.Length diameter_t = 0.1 "Outer diameter of internal tubes";
            parameter Integer N_tubes = 1 "Number of internal tubes for one pass";
            parameter Integer N_passes = 1 "Number of passes of the internal tubes";
            parameter Boolean parallelTubes = false "True, if tubes are parallel to shell flow flowOrientation, else false";
            parameter Modelica.SIunits.Length Delta_z_par = 2 * diameter_t "Horizontal distance between tubes (center to center)";
            parameter Modelica.SIunits.Length Delta_z_ort = 2 * diameter_t "Vertical distance between tubes (center to center)";
            final parameter Real a = Delta_z_ort / diameter_t "Lateral alignment ratio";
            final parameter Real b = Delta_z_par / diameter_t "Vertical alignment ratio";
            final parameter Real psi = if b >= 1 then 1 - Modelica.Constants.pi / 4 / a else 1 - Modelica.Constants.pi / 4 / a / b "Void ratio";
            parameter Boolean staggeredAlignment = true "True, if the tubes are aligned staggeredly, false otherwise";
            parameter Integer N_rows(min = N_passes, max = N_tubes) = integer(ceil(sqrt(N_tubes)) * N_passes) "Number of pipe rows in flow direction";
          equation
            for i in 1:N_inlet loop
              assert(if height_fill <> (-1) then z_in[i] <= height_fill else true, "Position of inlet flange no. " + String(i) + "(" + String(z_in[i], significantDigits = 3) + " m) must be below max. fill height of " + String(height_fill, significantDigits = 3) + " m in component " + getInstanceName() + ".");
            end for;
            for i in 1:N_outlet loop
              assert(if height_fill <> (-1) then z_out[i] <= height_fill else true, "Position of outlet flange no. " + String(i) + "(" + String(z_out[i], significantDigits = 3) + " m) must be below max. fill height of " + String(height_fill, significantDigits = 3) + " m in component " + getInstanceName() + ".");
            end for;
            for i in 1:N_inlet loop
              assert(z_in[i] >= 0, "Position of inlet flange no. " + String(i) + "(" + String(z_in[i], significantDigits = 3) + " m) must be positive in component " + getInstanceName() + ".");
            end for;
            for i in 1:N_outlet loop
              assert(z_out[i] >= 0, "Position of outlet flange no. " + String(i) + "(" + String(z_out[i], significantDigits = 3) + " m) must be positive in component " + getInstanceName() + ".");
            end for;
            assert(A_cross > 0, "The cross section of the shell side must be > 0 but is " + String(A_cross, significantDigits = 3) + " in instance" + getInstanceName() + ".");
            assert(volume > 0, "The volume of the shell side must be > 0 but is " + String(volume, significantDigits = 3) + " in instance" + getInstanceName() + ".");
          end HollowBlockWithTubesAndHotwell;

          model HollowCylinderWithTubes  "Cylindric shape || Shell with tubes" 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.ShellWithTubes;
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry(final volume = .Modelica.Constants.pi / 4 * diameter ^ 2 * length - N_tubes * N_passes * .Modelica.Constants.pi / 4 * diameter_t ^ 2 * length_tubes, final N_heat = 2, final A_heat = {.Modelica.Constants.pi * diameter * length + 2 * diameter ^ 2 / 4 * .Modelica.Constants.pi, .Modelica.Constants.pi * diameter_t * N_tubes * N_passes * length_tubes}, final A_cross = if parallelTubes then A_front - N_passes * N_tubes * .Modelica.Constants.pi / 4 * diameter_t ^ 2 else psi * A_front, final A_front = if N_baffle > 0 then diameter * length / (N_baffle + 1) else if flowOrientation == orientation then .Modelica.Constants.pi / 4 * diameter ^ 2 else diameter * length, final A_hor = if orientation == ClaRa.Basics.Choices.GeometryOrientation.horizontal then diameter * length * interior else .Modelica.Constants.pi / 4 * diameter ^ 2 * interior, final height_fill = if orientation == ClaRa.Basics.Choices.GeometryOrientation.horizontal then diameter else length, final shape = if orientation == ClaRa.Basics.Choices.GeometryOrientation.vertical then [0, 1; 1, 1] else [0.0005, 0.02981; 0.0245, 0.20716; 0.1245, 0.45248; 0.2245, 0.58733; 0.3245, 0.68065; 0.4245, 0.74791; 0.5245, 0.7954; 0.6245, 0.8261; 0.7245, 0.84114; 0.8245, 0.84015; 0.9245, 0.82031; 1, 0.7854]);
            parameter ClaRa.Basics.Choices.GeometryOrientation orientation = ClaRa.Basics.Choices.GeometryOrientation.horizontal "Orientation of the component";
            parameter ClaRa.Basics.Choices.GeometryOrientation flowOrientation = ClaRa.Basics.Choices.GeometryOrientation.vertical "Orientation of the mass flow";
            parameter Units.Length diameter = 1 "Diameter of the component";
            parameter Units.Length length = 1 "Length of the component";
            parameter Units.Length diameter_t = 0.1 "Outer diameter of internal tubes";
            parameter Units.Length length_tubes = 1 "Length of the internal tubes (single pass)";
            parameter Integer N_tubes = 1 "Number of internal tubes";
            parameter Integer N_passes = 1 "Number of passes of the internal tubes";
            parameter Boolean parallelTubes = false "True, if tubes are parallel to main flow orientation, else false";
            parameter Integer N_baffle = 0 "Number of baffles on shell side";
            final parameter Real interior(min = 1e-6, max = 1) = volume / (.Modelica.Constants.pi / 4 * diameter ^ 2 * length) "Volume fraction of interior equipment";
            parameter Modelica.SIunits.Length Delta_z_ort = 2 * diameter_t "Distance between tubes orthogonal to flow direction (center to center)";
            parameter Modelica.SIunits.Length Delta_z_par = 2 * diameter_t "Distance between tubes parallel to flow direction (center to center)";
            final parameter Real a = Delta_z_ort / diameter_t "Lateral alignment ratio";
            final parameter Real b = Delta_z_par / diameter_t "Vertical alignment ratio";
            final parameter Real psi = if b >= 1 then 1 - Modelica.Constants.pi / 4 / a else 1 - Modelica.Constants.pi / 4 / a / b "Void ratio";
            parameter Boolean staggeredAlignment = true "True, if the tubes are aligned staggeredly, false otherwise";
            parameter Integer N_rows(min = N_passes, max = N_tubes) = integer(ceil(sqrt(N_tubes)) * N_passes) "Number of pipe rows in flow direction (minimum = N_passes)";
          equation
            for i in 1:N_inlet loop
              assert(if height_fill <> (-1) then z_in[i] <= height_fill else true, "Position of inlet flange no. " + String(i) + "(" + String(z_in[i], significantDigits = 3) + " m) must be below max. fill height of " + String(height_fill, significantDigits = 3) + " m in component " + getInstanceName() + ".");
            end for;
            for i in 1:N_outlet loop
              assert(if height_fill <> (-1) then z_out[i] <= height_fill else true, "Position of outlet flange no. " + String(i) + "(" + String(z_out[i], significantDigits = 3) + " m) must be below max. fill height of " + String(height_fill, significantDigits = 3) + " m in component " + getInstanceName() + ".");
            end for;
            for i in 1:N_inlet loop
              assert(z_in[i] >= 0, "Position of inlet flange no. " + String(i) + "(" + String(z_in[i], significantDigits = 3) + " m) must be positive in component " + getInstanceName() + ".");
            end for;
            for i in 1:N_outlet loop
              assert(z_out[i] >= 0, "Position of outlet flange no. " + String(i) + "(" + String(z_out[i], significantDigits = 3) + " m) must be positive in component " + getInstanceName() + ".");
            end for;
            assert(A_cross > 0, "The cross section of the shell side must be > 0 but is " + String(A_cross, significantDigits = 3) + " in instance" + getInstanceName() + ".");
            assert(volume > 0, "The volume of the shell side must be > 0 but is " + String(volume, significantDigits = 3) + " in instance" + getInstanceName() + ".");
          end HollowCylinderWithTubes;

          model PipeGeometry  "Pipe bundle || Tube type " 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.TubeType;
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry(final volume = .Modelica.Constants.pi / 4 * diameter ^ 2 * N_passes * N_tubes * length, final N_heat = 1, final A_heat = {.Modelica.Constants.pi * diameter * N_tubes * N_passes * length}, final A_cross = .Modelica.Constants.pi / 4 * diameter ^ 2 * N_tubes, final A_front = A_cross, final A_hor = 1e-6, final shape = [0, 1; 1, 1], final height_fill = -1, final N_inlet = 1, final N_outlet = 1);
            parameter Units.Length diameter = 1 "Diameter of the component";
            parameter Units.Length diameter_hyd = diameter "Hydraulic diameter of the component";
            parameter Units.Length length = 1 "Length of the component (one pass)";
            parameter Integer N_tubes = 1 "Number of tubes in parallel";
            parameter Integer N_passes = 1 "Number of passes of the tubes";
          equation
            assert(A_cross > 0, "The cross section of the shell side must be > 0 but is " + String(A_cross, significantDigits = 3) + " in instance" + getInstanceName() + ".");
            assert(volume > 0, "The volume of the shell side must be > 0 but is " + String(volume, significantDigits = 3) + " in instance" + getInstanceName() + ".");
          end PipeGeometry;

          model PipeGeometry_N_cv  "Discretized pipe bundle || Tube type " 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.TubeType;
            extends ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry_N_cv(final volume = Modelica.Constants.pi / 4 * diameter ^ 2 * Delta_x * N_tubes, final A_heat = [N_tubes * Modelica.Constants.pi * diameter * Delta_x], final A_cross = ones(N_cv) * Modelica.Constants.pi * diameter ^ 2 / 4 * N_tubes, final N_heat = 1, final diameter_hyd = fill(diameter, N_cv), Delta_x = ClaRa.Basics.Functions.GenerateGrid({0}, length * N_passes, N_cv), final z = cat(1, {(z_out - z_in) / (length * N_passes) * Delta_x[1] / 2 + z_in}, {(z_out - z_in) / (length * N_passes) * (sum(Delta_x[k] for k in 1:i - 1) + Delta_x[i] / 2) + z_in for i in 2:N_cv}), final Delta_z_in = {sum(Delta_x[1:i]) - Delta_x[i] / 2 for i in 1:N_cv});
            parameter Units.Length length = 1 "Length of the component (one pass)";
            parameter Units.Length diameter = 1 "Diameter of the component";
            parameter Integer N_tubes = 1 "Number of tubes in parallel";
            parameter Integer N_passes = 1 "Number of passes of the tubes";
          end PipeGeometry_N_cv;
        end Geometry;

        package HeatTransport  
          extends ClaRa.Basics.Icons.PackageIcons.Basics50;

          partial model HeatTransferBaseGas  "Partial heat transfer model for Gas-type models" end HeatTransferBaseGas;

          partial model HeatTransferBaseVLE  "Partial heat transfer model for VLE-type models" end HeatTransferBaseVLE;

          partial model HeatTransferBaseGas_L3  "Partial heat transfer model for Gas-type models" end HeatTransferBaseGas_L3;

          partial model HeatTransferBaseVLE_L3  "Partial heat transfer model for VLE-type models" end HeatTransferBaseVLE_L3;

          partial model HeatTransferBaseGas_L4  "Partial heat transfer model for VLE-type models" end HeatTransferBaseGas_L4;

          partial model HeatTransferBaseVLE_L4  "Partial heat transfer model for VLE-type models" end HeatTransferBaseVLE_L4;

          partial model TubeType_L2  "Partial heat transfer model for tube-type models" end TubeType_L2;

          partial model ShellType_L2  "Partial heat transfer model for shell-type models" end ShellType_L2;

          partial model TubeType_L3  "Partial heat transfer model for tube-type models" end TubeType_L3;

          partial model ShellType_L3  "Partial heat transfer model for shell-type models" end ShellType_L3;

          package Generic_HT  "Heat transfer models for arbitrary geometries and media" 
            extends Icons.PackageIcons.Basics50;

            partial model HeatTransfer_L2  " L2 || HT-BaseClass" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseGas;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseVLE;
              extends ClaRa.Basics.Icons.Alpha;
              outer parameter Boolean useHomotopy;
              ClaRa.Basics.Interfaces.HeatPort_a heat;
            end HeatTransfer_L2;

            model IdealHeatTransfer_L2  "All Geo || L2 || Ideal Heat Transfer" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.HeatTransfer_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.ShellType_L2;
              outer ClaRa.Basics.Records.IComBase_L2 iCom;
              parameter Integer heatSurfaceAlloc = 2 "To be considered heat transfer area" annotation(dialog(enable = false, tab = "Expert Setting"));
            equation
              heat.T = iCom.T_bulk;
            end IdealHeatTransfer_L2;

            model CharLine_L2  "All Geo || L2 || HTC || Characteristic Line" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.HeatTransfer_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.ShellType_L2;
              outer ClaRa.Basics.Records.IComBase_L2 iCom;
              outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry geo;
              parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_nom = 10 "Constant heat transfer coefficient";
              parameter Integer heatSurfaceAlloc = 2 "To be considered heat transfer area" annotation(dialog(enable = false, tab = "Expert Setting"));
              parameter Real[:, 2] PL_alpha = {{0, 0.2}, {0.5, 0.6}, {0.7, 0.72}, {1, 1}} "Correction factor for heat transfer in part load";
              input Real CF_fouling = 1 "Scaling factor accounting for the fouling of the wall";
              parameter String temperatureDifference = "Logarithmic mean - smoothed" "Temperature Difference";
              Units.Temperature Delta_T_wi "Temperature difference between wall and fluid inlet temperature";
              Units.Temperature Delta_T_wo "Temperature difference between wall and fluid outlet temperature";
              Units.Temperature Delta_T_mean "Mean temperature difference used for heat transfer calculation";
              Units.Temperature Delta_T_U "Upper temperature difference";
              Units.Temperature Delta_T_L "Lower temperature difference";
              Modelica.SIunits.CoefficientOfHeatTransfer alpha "Heat transfer coefficient used for heat transfer calculation";
            protected
              Modelica.Blocks.Tables.CombiTable1Ds CF_flow(table = PL_alpha);
            equation
              Delta_T_wi = heat.T - iCom.T_in;
              Delta_T_wo = heat.T - iCom.T_out;
              Delta_T_U = ClaRa.Basics.Functions.maxAbs(Delta_T_wi, Delta_T_wo, 0.1);
              Delta_T_L = ClaRa.Basics.Functions.minAbs(Delta_T_wi, Delta_T_wo, 0.1);
              if temperatureDifference == "Logarithmic mean" then
                Delta_T_mean = noEvent(if floor(abs(Delta_T_wo) * 1 / .Modelica.Constants.eps) <= 1 or floor(abs(Delta_T_wi) * 1 / .Modelica.Constants.eps) <= 1 then 0 elseif heat.T < iCom.T_out and heat.T > iCom.T_in or heat.T > iCom.T_out and heat.T < iCom.T_in then 0
                 elseif floor(abs(Delta_T_wo - Delta_T_wi) * 1 / .Modelica.Constants.eps) < 1 then Delta_T_wi else (Delta_T_U - Delta_T_L) / log(Delta_T_U / Delta_T_L));
              elseif temperatureDifference == "Logarithmic mean - smoothed" then
                Delta_T_mean = .ClaRa.Basics.Functions.Stepsmoother(0.1, .Modelica.Constants.eps, abs(Delta_T_L)) * .ClaRa.Basics.Functions.Stepsmoother(0.01, .Modelica.Constants.eps, Delta_T_U * Delta_T_L) * .ClaRa.Basics.Functions.SmoothZeroTransition((Delta_T_U - Delta_T_L) / log(abs(Delta_T_U) / (abs(Delta_T_L) + 1e-9)), Delta_T_wi, Delta_T_U - Delta_T_L - 0.01, 0.001);
              elseif temperatureDifference == "Arithmetic mean" then
                Delta_T_mean = heat.T - (iCom.T_in + iCom.T_out) / 2;
              elseif temperatureDifference == "Inlet" then
                Delta_T_mean = heat.T - iCom.T_in;
              elseif temperatureDifference == "Outlet" then
                Delta_T_mean = heat.T - iCom.T_out;
              else
                Delta_T_mean = -1;
                assert(true, "Unknown temperature difference option in HT model");
              end if;
              CF_flow.u = noEvent(max(1e-3, abs(iCom.m_flow_in)) / iCom.m_flow_nom);
              alpha = CF_flow.y[1] * alpha_nom * CF_fouling;
              heat.Q_flow = alpha * geo.A_heat_CF[heatSurfaceAlloc] * Delta_T_mean;
            end CharLine_L2;

            partial model HeatTransfer_L3  "L3 || HT-BaseClass" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseGas_L3;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseVLE_L3;
              extends ClaRa.Basics.Icons.Alpha;
              outer ClaRa.Basics.Records.IComBase_L3 iCom;
              outer parameter Boolean useHomotopy;
              ClaRa.Basics.Interfaces.HeatPort_a[iCom.N_cv] heat;
              parameter String temperatureDifference = "Zonal temperatures" "Temperature Difference";
              .ClaRa.Basics.Units.Temperature[iCom.N_cv] Delta_T_mean "Mean temperature difference between wall and fluid";
            equation
              if temperatureDifference == "Zonal temperatures" then
                for i in 1:iCom.N_cv loop
                  Delta_T_mean[i] = heat[i].T - iCom.T[i];
                end for;
              else
                Delta_T_mean = fill(0, iCom.N_cv);
                assert(false, "unknown option for temperature difference");
              end if;
            end HeatTransfer_L3;

            model Constant_L3  "All geo || L3 || Constant HT" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.HeatTransfer_L3;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L3;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.ShellType_L3;
              outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry geo;
              parameter Modelica.SIunits.CoefficientOfHeatTransfer[iCom.N_cv] alpha_nom = ones(iCom.N_cv) * 10 "Constant heat transfer coefficient || [1]:= liq | [2]:= vap ";
              parameter Integer heatSurfaceAlloc = 2 "To be considered heat transfer area" annotation(dialog(enable = false, tab = "Expert Setting"));
              Units.HeatFlowRate Q_flow_tot "Sum of zonal heat flows";
              Modelica.SIunits.CoefficientOfHeatTransfer[iCom.N_cv] alpha;
            equation
              heat.Q_flow = alpha .* geo.A_heat_CF[heatSurfaceAlloc] .* (heat.T - iCom.T);
              Q_flow_tot = sum(heat.Q_flow);
              alpha = alpha_nom;
            end Constant_L3;

            partial model HeatTransfer_L4  "Medium independent || HT Base Class" 
              extends ClaRa.Basics.Icons.Alpha;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseVLE_L4;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseGas_L4;
              outer ClaRa.Basics.Records.IComBase_L3 iCom;
              outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry_N_cv geo;
              outer parameter Boolean useHomotopy;
              parameter Modelica.SIunits.Area[iCom.N_cv] A_heat = ones(iCom.N_cv) "Area of heat transfer";
              Modelica.SIunits.MassFlowRate[iCom.N_cv + 1] m_flow "Mass flow rate";
              Modelica.SIunits.Temperature[iCom.N_cv] T_mean;
              ClaRa.Basics.Interfaces.HeatPort_a[iCom.N_cv] heat;
            end HeatTransfer_L4;

            model CharLine_L4  "Medium independent || Characteristic Line" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.HeatTransfer_L4;
              parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_nom = 10 "Constant heat transfer coefficient";
              parameter Real[:, 2] PL_alpha = {{0, 0.2}, {0.5, 0.6}, {0.7, 0.72}, {1, 1}} "Correction factor for heat transfer in part load";
              Modelica.SIunits.CoefficientOfHeatTransfer[iCom.N_cv] alpha annotation(HideResult = false);
              parameter String temperatureDifference = "Outlet" "Temperature Difference";
              Units.Temperature[iCom.N_cv] Delta_T_wi "Temperature difference between wall and fluid inlet temperature";
              Units.Temperature[iCom.N_cv] Delta_T_wo "Temperature difference between wall and fluid outlet temperature";
              Units.Temperature[iCom.N_cv] Delta_T_mean "Mean temperature difference used for heat transfer calculation";
              Units.Temperature[iCom.N_cv] Delta_T_u "Upper temperature difference";
              Units.Temperature[iCom.N_cv] Delta_T_l "Lower temperature difference";
            protected
              Real[iCom.N_cv] alpha_corr_u;
              ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table_block(table = PL_alpha, columns = fill(2, iCom.N_cv));
            equation
              if temperatureDifference == "Logarithmic mean" then
                if m_flow[1] > 0 then
                  for i in 2:iCom.N_cv loop
                    Delta_T_wi[i] = heat[i].T - iCom.T[i - 1];
                    Delta_T_wo[i] = heat[i].T - iCom.T[i];
                    Delta_T_mean[i] = noEvent(if abs(Delta_T_wo[i]) <= 1e-6 or abs(Delta_T_wi[i]) <= 1e-6 then 0 elseif heat[i].T < iCom.T[i] and heat[i].T > iCom.T[i - 1] or heat[i].T > iCom.T[i] and heat[i].T < iCom.T[i - 1] then 0
                     elseif abs(Delta_T_wo[i] - Delta_T_wi[i]) <= .Modelica.Constants.eps then Delta_T_wi[i] else (Delta_T_u[i] - Delta_T_l[i]) / log(Delta_T_u[i] / Delta_T_l[i]));
                  end for;
                  Delta_T_wi[1] = heat[1].T - iCom.T_in[1];
                  Delta_T_wo[1] = heat[1].T - iCom.T[1];
                  Delta_T_mean[1] = noEvent(if abs(Delta_T_wo[1]) <= 1e-6 or abs(Delta_T_wi[1]) <= 1e-6 then 0 elseif heat[1].T < iCom.T[1] and heat[1].T > iCom.T_in[1] or heat[1].T > iCom.T[1] and heat[1].T < iCom.T_in[1] then 0
                   elseif abs(Delta_T_wo[1] - Delta_T_wi[1]) <= .Modelica.Constants.eps then Delta_T_wi[1] else (Delta_T_u[1] - Delta_T_l[1]) / log(Delta_T_u[1] / Delta_T_l[1]));
                else
                  for i in 1:iCom.N_cv - 1 loop
                    Delta_T_wi[i] = heat[i].T - iCom.T[i + 1];
                    Delta_T_wo[i] = heat[i].T - iCom.T[i];
                    Delta_T_mean[i] = noEvent(if abs(Delta_T_wo[i]) <= 1e-6 or abs(Delta_T_wi[i]) <= 1e-6 then 0 elseif heat[i].T < iCom.T[i] and heat[i].T > iCom.T[i + 1] or heat[i].T > iCom.T[i] and heat[i].T < iCom.T[i + 1] then 0
                     elseif abs(Delta_T_wo[i] - Delta_T_wi[i]) <= .Modelica.Constants.eps then Delta_T_wi[i] else (Delta_T_u[i] - Delta_T_l[i]) / log(Delta_T_u[i] / Delta_T_l[i]));
                  end for;
                  Delta_T_wi[iCom.N_cv] = heat[iCom.N_cv].T - iCom.T_out[1];
                  Delta_T_wo[iCom.N_cv] = heat[iCom.N_cv].T - iCom.T[iCom.N_cv];
                  Delta_T_mean[iCom.N_cv] = noEvent(if abs(Delta_T_wo[iCom.N_cv]) <= 1e-6 or abs(Delta_T_wi[iCom.N_cv]) <= 1e-6 then 0 elseif heat[iCom.N_cv].T < iCom.T[iCom.N_cv] and heat[iCom.N_cv].T > iCom.T_out[1] or heat[iCom.N_cv].T > iCom.T[iCom.N_cv] and heat[iCom.N_cv].T < iCom.T_out[1] then 0
                   elseif abs(Delta_T_wo[iCom.N_cv] - Delta_T_wi[iCom.N_cv]) <= .Modelica.Constants.eps then Delta_T_wi[iCom.N_cv] else (Delta_T_u[iCom.N_cv] - Delta_T_l[iCom.N_cv]) / log(Delta_T_u[iCom.N_cv] / Delta_T_l[iCom.N_cv]));
                end if;
                for i in 1:iCom.N_cv loop
                  Delta_T_u[i] = max(Delta_T_wi[i], Delta_T_wo[i]);
                  Delta_T_l[i] = min(Delta_T_wi[i], Delta_T_wo[i]);
                end for;
              elseif temperatureDifference == "Outlet" then
                for i in 1:iCom.N_cv loop
                  Delta_T_mean[i] = heat[i].T - T_mean[i];
                  Delta_T_wi[i] = heat[i].T - T_mean[i];
                  Delta_T_wo[i] = heat[i].T - T_mean[i];
                  Delta_T_u[i] = heat[i].T - T_mean[i];
                  Delta_T_l[i] = heat[i].T - T_mean[i];
                end for;
              else
                for i in 1:iCom.N_cv loop
                  Delta_T_mean[i] = -1;
                end for;
                assert(true, "Unknown temperature difference option in HT model");
              end if;
              T_mean = iCom.T;
              heat.Q_flow = alpha .* A_heat .* Delta_T_mean;
              for i in 1:iCom.N_cv loop
                alpha_corr_u[i] = noEvent(max(1e-3, abs(m_flow[i])) / iCom.m_flow_nom);
                table_block.u[i] = alpha_corr_u[i];
                alpha[i] = table_block.y[i] * alpha_nom;
              end for;
            end CharLine_L4;
          end Generic_HT;

          package VLE_HT  "Heat transfer models with media in a vapour-liquid equilibrium" 
            extends Icons.PackageIcons.Basics50;

            partial model HeatTransfer_L2  " L2 || HT-BaseClass" 
              extends ClaRa.Basics.Icons.Alpha;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.HeatTransferBaseVLE;
              outer ClaRa.Basics.Records.IComVLE_L2 iCom;
              outer parameter Boolean useHomotopy;
              parameter String temperatureDifference = "Logarithmic mean - smoothed" "Temperature Difference";
              Units.Temperature Delta_T_wi "Temperature difference between wall and fluid inlet temperature";
              Units.Temperature Delta_T_wo "Temperature difference between wall and fluid outlet temperature";
              Units.Temperature Delta_T_mean "Mean temperature difference used for heat transfer calculation";
              Units.Temperature Delta_T_U "Upper temperature difference";
              Units.Temperature Delta_T_L "Lower temperature difference";
              ClaRa.Basics.Interfaces.HeatPort_a heat;
            equation
              Delta_T_wi = heat.T - iCom.T_in;
              Delta_T_wo = heat.T - iCom.T_out;
              Delta_T_U = ClaRa.Basics.Functions.maxAbs(Delta_T_wi, Delta_T_wo, 0.1);
              Delta_T_L = ClaRa.Basics.Functions.minAbs(Delta_T_wi, Delta_T_wo, 0.1);
              if temperatureDifference == "Logarithmic mean" then
                Delta_T_mean = noEvent(if floor(abs(Delta_T_wo) * 1 / .Modelica.Constants.eps) <= 1 or floor(abs(Delta_T_wi) * 1 / .Modelica.Constants.eps) <= 1 then 0 elseif heat.T < iCom.T_out and heat.T > iCom.T_in or heat.T > iCom.T_out and heat.T < iCom.T_in then 0
                 elseif floor(abs(Delta_T_wo - Delta_T_wi) * 1 / .Modelica.Constants.eps) < 1 then Delta_T_wi else (Delta_T_U - Delta_T_L) / log(Delta_T_U / Delta_T_L));
              elseif temperatureDifference == "Logarithmic mean - smoothed" then
                Delta_T_mean = if useHomotopy then homotopy(.ClaRa.Basics.Functions.Stepsmoother(0.1, .Modelica.Constants.eps, abs(Delta_T_L)) * .ClaRa.Basics.Functions.Stepsmoother(0.01, .Modelica.Constants.eps, Delta_T_U * Delta_T_L) * .ClaRa.Basics.Functions.SmoothZeroTransition((Delta_T_U - Delta_T_L) / log(abs(Delta_T_U) / (abs(Delta_T_L) + 1e-9)), Delta_T_wi, Delta_T_U - Delta_T_L - 0.01, 0.001), heat.T - iCom.T_out) else .ClaRa.Basics.Functions.Stepsmoother(0.1, .Modelica.Constants.eps, abs(Delta_T_L)) * .ClaRa.Basics.Functions.Stepsmoother(0.01, .Modelica.Constants.eps, Delta_T_U * Delta_T_L) * .ClaRa.Basics.Functions.SmoothZeroTransition((Delta_T_U - Delta_T_L) / log(abs(Delta_T_U) / (abs(Delta_T_L) + 1e-9)), Delta_T_wi, Delta_T_U - Delta_T_L - 0.01, 0.001);
              elseif temperatureDifference == "Arithmetic mean" then
                Delta_T_mean = heat.T - (iCom.T_in + iCom.T_out) / 2;
              elseif temperatureDifference == "Inlet" then
                Delta_T_mean = heat.T - iCom.T_in;
              else
                Delta_T_mean = heat.T - iCom.T_out;
              end if;
            end HeatTransfer_L2;

            model NusseltPipe1ph_L2  "Pipe Geo || L2 || HTC || Nusselt || 1ph" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.VLE_HT.HeatTransfer_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L2;
              outer ClaRa.SimCenter simCenter;
              outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.PipeGeometry geo;
              parameter Integer boundary = 1 "Choice of heat transfer boundary condition, relevant for laminar flow heat transfer";
              parameter Integer correlation = 2 "Cprrelation type";
              parameter Real CF_alpha_tubes = 1 "Correction factor due to fouling";
              parameter Integer heatSurfaceAlloc = 1 "To be considered heat transfer area" annotation(dialog(enable = false, tab = "Expert Setting"));
              ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha "Heat transfer coefficient used for heat trasnfer calculation";
              ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_lam "Heat transfer coefficient - laminar part";
              ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_turb "Heat transfer coefficient - turbolent part";
              Real failureStatus "0== boundary conditions fulfilled | 1== failure >> check if still meaningfull results";
              ClaRa.Basics.Units.MassFlowRate m_flow "Mass flow rate";
              ClaRa.Basics.Units.Velocity velocity "Mean velocity";
              ClaRa.Basics.Units.ReynoldsNumber Re "Reynolds number";
              ClaRa.Basics.Units.PrandtlNumber Pr "Prandtl number";
            protected
              constant ClaRa.Basics.Units.ReynoldsNumber laminar = 2200 "Maximum Reynolds number for laminar regime";
              constant ClaRa.Basics.Units.ReynoldsNumber turbulent = 1e4 "Minimum Reynolds number for turbulent regime";
              constant Real MIN = Modelica.Constants.eps "Limiter";
              parameter ClaRa.Basics.Units.NusseltNumber Nu0 = if boundary == 1 or boundary == 3 then 0.7 else if boundary == 2 or boundary == 4 then 0.6 else 0 "Help variable for mean Nusselt number";
              parameter ClaRa.Basics.Units.NusseltNumber Nu1 = if boundary == 1 or boundary == 3 then 3.66 else if boundary == 2 or boundary == 4 then 4.364 else 0 "Help variable for mean Nusselt number";
              ClaRa.Basics.Units.NusseltNumber Nu2 "Help variable for mean Nusselt number";
              ClaRa.Basics.Units.NusseltNumber Nu3 "Help variable for mean Nusselt number";
              ClaRa.Basics.Units.NusseltNumber Nu_lam "Mean Nusselt number";
              ClaRa.Basics.Units.ThermalConductivity lambda;
              ClaRa.Basics.Units.DensityMassSpecific rho;
              ClaRa.Basics.Units.DynamicViscosity eta;
              ClaRa.Basics.Units.HeatCapacityMassSpecific cp;
              Real zeta "Pressure loss coefficient";
              final parameter ClaRa.Basics.Units.HeatCapacityMassSpecific cp_nom = .TILMedia.VLEFluidFunctions.specificIsobaricHeatCapacity_phxi(iCom.mediumModel, iCom.p_nom, iCom.h_nom, iCom.xi_nom);
              final parameter ClaRa.Basics.Units.DynamicViscosity eta_nom = .TILMedia.VLEFluidFunctions.dynamicViscosity_phxi(iCom.mediumModel, iCom.p_nom, iCom.h_nom, iCom.xi_nom);
              final parameter ClaRa.Basics.Units.ThermalConductivity lambda_nom = .TILMedia.VLEFluidFunctions.thermalConductivity_phxi(iCom.mediumModel, iCom.p_nom, iCom.h_nom, iCom.xi_nom);
              final parameter ClaRa.Basics.Units.DensityMassSpecific rho_nom = .TILMedia.VLEFluidFunctions.density_phxi(iCom.mediumModel, iCom.p_nom, iCom.h_nom, iCom.xi_nom);
              final parameter ClaRa.Basics.Units.Velocity velocity_nom = abs(iCom.m_flow_nom) / max(MIN, rho_nom * geo.A_cross);
              final parameter ClaRa.Basics.Units.ReynoldsNumber Re_nom = rho_nom * velocity_nom * geo.diameter_hyd / max(MIN, eta_nom) "Reynolds number";
              final parameter ClaRa.Basics.Units.PrandtlNumber Pr_nom = abs(eta_nom * cp_nom / max(MIN, lambda_nom)) "Prandtl number";
              final parameter ClaRa.Basics.Units.NusseltNumber Nu2_nom = if boundary == 1 or boundary == 3 then 1.615 * (Re_nom * Pr_nom * geo.diameter_hyd / geo.length * geo.N_passes) ^ (1 / 3) else if boundary == 2 or boundary == 4 then 1.953 * (Re_nom * Pr_nom * geo.diameter_hyd / geo.length * geo.N_passes) ^ (1 / 3) else 0 "Help variable for mean Nusselt number";
              final parameter ClaRa.Basics.Units.NusseltNumber Nu3_nom = if boundary == 3 then (2 / (1 + 22 * Pr_nom)) ^ (1 / 6) * (Re_nom * Pr_nom * geo.diameter_hyd / geo.length * geo.N_passes) ^ 0.5 else if boundary == 4 then 0.924 * Pr_nom ^ (1 / 3) * (Re_nom * geo.diameter_hyd / geo.length * geo.N_passes) ^ (1 / 2) else 0 "Help variable for mean Nusselt number";
              final parameter ClaRa.Basics.Units.NusseltNumber Nu_lam_nom = (Nu1 ^ 3 + Nu0 ^ 3 + (Nu2_nom - Nu0) ^ 3 + Nu3_nom ^ 3) ^ (1 / 3) "Mean Nusselt number";
              final parameter ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_lam_nom = Nu_lam_nom * lambda_nom / max(MIN, geo.diameter_hyd);
              final parameter Real zeta_nom = abs(1 / max(MIN, 1.8 * Modelica.Math.log10(abs(Re_nom)) - 1.5) ^ 2) "Pressure loss coefficient";
              final parameter ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_turb_nom = if correlation == 2 then abs(lambda_nom / geo.diameter_hyd) * 0.023 * Re_nom ^ 0.8 * Pr_nom ^ (1 / 3) else if correlation == 1 then abs(lambda_nom / geo.diameter_hyd) * (abs(zeta_nom) / 8) * abs(Re_nom) * abs(Pr_nom) / (1 + 12.7 * (abs(zeta_nom) / 8) ^ 0.5 * (abs(Pr_nom) ^ (2 / 3) - 1)) * (1 + (geo.diameter_hyd / geo.length * geo.N_passes) ^ (2 / 3)) else 0;
            public
              final parameter ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_nom = CF_alpha_tubes * (.ClaRa.Basics.Functions.Stepsmoother(laminar, turbulent, Re_nom) * alpha_lam_nom + .ClaRa.Basics.Functions.Stepsmoother(turbulent, laminar, Re_nom) * alpha_turb_nom) "Nominal HTC (used for homotopy)";
            equation
              lambda = .TILMedia.VLEFluidObjectFunctions.thermalConductivity_phxi(iCom.p_out, iCom.h_out, iCom.xi_out[:], iCom.fluidPointer_out);
              rho = .TILMedia.VLEFluidObjectFunctions.density_phxi(iCom.p_out, iCom.h_out, iCom.xi_out[:], iCom.fluidPointer_out);
              eta = .TILMedia.VLEFluidObjectFunctions.dynamicViscosity_phxi(iCom.p_out, iCom.h_out, iCom.xi_out[:], iCom.fluidPointer_out);
              cp = .TILMedia.VLEFluidObjectFunctions.specificIsobaricHeatCapacity_phxi(iCom.p_out, iCom.h_out, iCom.xi_out[:], iCom.fluidPointer_out);
              m_flow = noEvent(max(0.0000001, abs(iCom.m_flow_in))) "Mass flow rate (sum of all N_tubes)";
              velocity = abs(m_flow) ./ max(MIN, rho * geo.A_cross) "Mean velocity";
              Re = rho * velocity * geo.diameter_hyd / max(MIN, eta) "Reynolds number";
              Pr = abs(eta * cp / max(MIN, lambda)) "Prandtl number";
              Nu2 = if boundary == 1 or boundary == 3 then 1.615 * (Re * Pr * geo.diameter_hyd / geo.length * geo.N_passes) ^ (1 / 3) else if boundary == 2 or boundary == 4 then 1.953 * (Re .* Pr * geo.diameter_hyd / geo.length * geo.N_passes) ^ (1 / 3) else 0 "Help variable for mean Nusselt number";
              Nu3 = if boundary == 3 then (2 / (1 + 22 * Pr)) ^ (1 / 6) * (Re * Pr * geo.diameter_hyd / geo.length * geo.N_passes) ^ 0.5 else if boundary == 4 then 0.924 * Pr ^ (1 / 3) * (Re * geo.diameter_hyd / geo.length * geo.N_passes) ^ (1 / 2) else 0 "Help variable for mean Nusselt number";
              Nu_lam = (Nu1 ^ 3 + Nu0 ^ 3 + (Nu2 - Nu0) ^ 3 + Nu3 .^ 3) ^ (1 / 3) "Mean Nusselt number";
              alpha_lam = Nu_lam * lambda / max(MIN, geo.diameter_hyd);
              zeta = abs(1 / max(MIN, 1.8 * Modelica.Math.log10(abs(Re)) - 1.5) ^ 2) "Pressure loss coefficient";
              alpha_turb = if correlation == 2 then abs(lambda / geo.diameter_hyd) * 0.023 * Re ^ 0.8 * Pr ^ (1 / 3) else if correlation == 1 then abs(lambda / geo.diameter_hyd) * (abs(zeta) / 8) * abs(Re) * abs(Pr) / (1 + 12.7 * (abs(zeta) / 8) ^ 0.5 * (abs(Pr) ^ (2 / 3) - 1)) * (1 + (geo.diameter_hyd / geo.length * geo.N_passes) ^ (2 / 3)) else 0;
              alpha = if useHomotopy then homotopy(CF_alpha_tubes * (.ClaRa.Basics.Functions.Stepsmoother(laminar, turbulent, Re) * alpha_lam + .ClaRa.Basics.Functions.Stepsmoother(turbulent, laminar, Re) * alpha_turb), alpha_nom) else CF_alpha_tubes * (.ClaRa.Basics.Functions.Stepsmoother(laminar, turbulent, Re) * alpha_lam + .ClaRa.Basics.Functions.Stepsmoother(turbulent, laminar, Re) * alpha_turb);
              if noEvent(Re > 1e6) then
                failureStatus = 1;
              else
                if noEvent(Pr < 0.6 or Pr > 1e3) then
                  failureStatus = 1;
                else
                  if noEvent(geo.diameter_hyd / max(MIN, geo.length * geo.N_passes) > 1) then
                    failureStatus = 1;
                  else
                    failureStatus = 0;
                  end if;
                end if;
              end if;
              heat.Q_flow = alpha * geo.A_heat_CF[heatSurfaceAlloc] * Delta_T_mean "Index 1 for shell surface";
            end NusseltPipe1ph_L2;

            model Constant_L3_ypsDependent  "All geo || L3 || HTC || depending on volume fraction || 2ph" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.HeatTransfer_L3;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L3;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.ShellType_L3;
              outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry geo;
              parameter Modelica.SIunits.CoefficientOfHeatTransfer[iCom.N_cv] alpha_nom = ones(iCom.N_cv) * 10 "Constant heat transfer coefficient || [1]:= liq | [2]:= vap ";
              parameter Integer heatSurfaceAlloc = 2 "To be considered heat transfer area" annotation(dialog(enable = false, tab = "Expert Setting"));
              Units.HeatFlowRate Q_flow_tot "Sum of zonal heat flows";
              Modelica.SIunits.CoefficientOfHeatTransfer[iCom.N_cv] alpha;
            equation
              heat.Q_flow = alpha .* geo.A_heat_CF[heatSurfaceAlloc] .* iCom.volume ./ geo.volume .* (heat.T - iCom.T);
              Q_flow_tot = sum(heat.Q_flow);
              alpha = alpha_nom;
            end Constant_L3_ypsDependent;
          end VLE_HT;
        end HeatTransport;

        package SpacialDistribution  "Replaceable models for spacial distribution aspects ( phase separation, phase slip)" 
          extends ClaRa.Basics.Icons.PackageIcons.Basics50;

          partial model IdealPhases  "The phases are in ideal thermodynamic equilibrium" 
            outer ClaRa.Basics.Records.IComVLE_L2 iCom;
            outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry geo;
            extends ClaRa.Basics.Icons.IdealPhases;
            ClaRa.Basics.Units.EnthalpyMassSpecific h_inflow;
            ClaRa.Basics.Units.EnthalpyMassSpecific h_outflow;
            ClaRa.Basics.Units.PressureDifference Delta_p_geo_in;
            ClaRa.Basics.Units.PressureDifference Delta_p_geo_out;
            Units.Length level_abs "Absolute filling absLevel";
            Real level_rel(start = level_rel_start) "Relative filling absLevel";
            parameter Real level_rel_start = 0.5 "Start value for relative filling Level";
            parameter String modelType;
          end IdealPhases;

          model IdeallyStirred  "Volume is ideally stirred" 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.IdealPhases(final level_rel_start = 0, final modelType = "IdeallyStirred");
            extends ClaRa.Basics.Icons.IdealMixing;
            parameter String position_Delta_p_geo = "inlet" "Position of geostatic pressure difference";
            parameter Boolean provideDensityDerivative = true "True if density derivative shall be provided";
          protected
            ClaRa.Basics.Units.DensityMassSpecific rho "Density used for geostatic pressure loss calculation";
          equation
            h_inflow = iCom.h_bulk;
            h_outflow = iCom.h_bulk;
            if provideDensityDerivative then
              rho = TILMedia.Internals.VLEFluidObjectFunctions.density_phxi(iCom.p_bulk, iCom.h_bulk, iCom.xi_bulk, iCom.fluidPointer_bulk);
            else
              rho = TILMedia.VLEFluidObjectFunctions.density_phxi(iCom.p_bulk, iCom.h_bulk, iCom.xi_bulk, iCom.fluidPointer_bulk);
            end if;
            if position_Delta_p_geo == "mid" then
              Delta_p_geo_in = (geo.z_out[1] - geo.z_in[1]) / 2 * Modelica.Constants.g_n * TILMedia.VLEFluidObjectFunctions.density_phxi(iCom.p_bulk, iCom.h_bulk, iCom.xi_bulk, iCom.fluidPointer_bulk);
              Delta_p_geo_out = -Delta_p_geo_in;
            elseif position_Delta_p_geo == "inlet" then
              Delta_p_geo_in = (geo.z_out[1] - geo.z_in[1]) * Modelica.Constants.g_n * TILMedia.VLEFluidObjectFunctions.density_phxi(iCom.p_bulk, iCom.h_bulk, iCom.xi_bulk, iCom.fluidPointer_bulk);
              Delta_p_geo_out = 0;
            else
              Delta_p_geo_in = -1;
              Delta_p_geo_out = -1;
              assert(false, "Unknown option for positioning of geostatic pressure difference in phaseBorder model of type 'IdeallySeparated'!");
            end if;
            level_abs = 0;
            level_rel = 0;
          end IdeallyStirred;

          partial model RealPhases  "The phases are NOT in ideal thermodynamic equilibrium" 
            extends ClaRa.Basics.Icons.RealPhases;
            parameter Real level_rel_start = 0.5 "Start value for relative filling level (set by applying control volume)";
            outer parameter Boolean useHomotopy "True, if homotopy method is used during initialisation";
            outer ClaRa.Basics.Records.IComVLE_L3_NPort iCom "Internal communication record";
            outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry geo "Geometry record";
            .ClaRa.Basics.Units.Pressure[geo.N_inlet] Delta_p_geo_in "Geodetic pressure difference to inlets";
            .ClaRa.Basics.Units.Pressure[geo.N_outlet] Delta_p_geo_out "Geodetic pressure difference to outlets";
            .ClaRa.Basics.Units.MassFraction[geo.N_inlet] zoneAlloc_in "Allocation of inlet mass flows to zones |1:liq|2:vap|";
            .ClaRa.Basics.Units.MassFraction[geo.N_outlet] zoneAlloc_out "Allocation of outlet mass flows to zones |1:liq|2:vap|";
            .ClaRa.Basics.Units.Length level_abs "Absolute filling absLevel";
            Real level_rel(start = level_rel_start) "Relative filling absLevel";
            ClaRa.Basics.Units.MassFlowRate[geo.N_inlet] m_flow_inliq "Mass flow passing from inlet to zone 1 and vice versa";
            ClaRa.Basics.Units.MassFlowRate[geo.N_inlet] m_flow_invap "Mass flow passing from inlet to zone 2 and vice versa";
            ClaRa.Basics.Units.MassFlowRate[geo.N_outlet] m_flow_outliq "Mass flow passing from outlet to zone 1 and vice versa";
            ClaRa.Basics.Units.MassFlowRate[geo.N_outlet] m_flow_outvap "Mass flow passing from outlet to zone 2 and vice versa";
            ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_inlet] H_flow_inliq "Enthalpy flow passing from inlet to zone 1 and vice versa";
            ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_inlet] H_flow_invap "Enthalpy flow passing from inlet to zone 2 and vice versa";
            ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_outlet] H_flow_outliq "Enthalpy flow passing from outlet to zone 1 and vice versa";
            ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_outlet] H_flow_outvap "Enthalpy flow passing from outlet to zone 2 and vice versa";
          end RealPhases;

          model RealSeparated  "Separation | Real | outlet states depending on filling Level | All geometries" 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.RealPhases;
            extends ClaRa.Basics.Icons.RealSeparation;
            parameter .ClaRa.Basics.Units.Length radius_flange = 0.05 "Flange radius";
            parameter Real absorbInflow(min = 0, max = 1) = 1 "absorption of incoming mass flow to the zones 1: perfect in the allocated zone, 0: perfect according to steam quality";
            parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of table interpolation";
            final parameter .ClaRa.Basics.Units.Length[geo.N_inlet] z_max_in = {min(geo.z_in[i] + radius_flange, geo.height_fill) for i in 1:geo.N_inlet} "Upper edges of inlet flanges";
            final parameter .ClaRa.Basics.Units.Length[geo.N_inlet] z_min_in = {max(1e-3, geo.z_in[i] - radius_flange) for i in 1:geo.N_inlet} "Lower edges of inlet flanges";
            final parameter .ClaRa.Basics.Units.Length[geo.N_outlet] z_max_out = {min(geo.z_out[i] + radius_flange, geo.height_fill) for i in 1:geo.N_outlet} "Upper edges of outlet flanges";
            final parameter .ClaRa.Basics.Units.Length[geo.N_outlet] z_min_out = {max(1e-3, geo.z_out[i] - radius_flange) for i in 1:geo.N_outlet} "Lower edges of outlet flanges";
            .ClaRa.Basics.Units.DensityMassSpecific[iCom.N_cv] rho "Zonal density";
            .ClaRa.Basics.Units.MassFraction[geo.N_inlet] steamQuality_in "Inlet steam quality";
            .ClaRa.Basics.Units.MassFraction[geo.N_outlet] steamQuality_out "Outlet steam quality";
            .ClaRa.Basics.Units.Area A_hor_act "Actual horizontal surface size";
          protected
            constant .ClaRa.Basics.Units.Length level_abs_min = 1e-6 "Min. absolute level";
            ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table(table = geo.shape, columns = {2}, smoothness = smoothness) "Shape table for level calculation";
            .ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_inlet] h_bubin "Inlet bubble spec. enthalpy";
            .ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_outlet] h_bubout "Outlet bubble spec. enthalpy";
            .ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_inlet] h_dewin "Inlet dew spec. enthalpy";
            .ClaRa.Basics.Units.EnthalpyMassSpecific[geo.N_outlet] h_dewout "Outlet dew spec. enthalpy";
          equation
            A_hor_act = geo.A_hor * table.y[1];
            table.u[1] = level_rel;
            level_abs = min(geo.height_fill, max(level_abs_min, iCom.volume[1] / A_hor_act));
            level_rel = level_abs / geo.height_fill;
            m_flow_inliq = {semiLinear(iCom.m_flow_in[i], absorbInflow * (2 - zoneAlloc_in[i]) + (1 - absorbInflow) * (1 - steamQuality_in[i]), 2 - zoneAlloc_in[i]) for i in 1:geo.N_inlet};
            m_flow_invap = {semiLinear(iCom.m_flow_in[i], absorbInflow * (zoneAlloc_in[i] - 1) + (1 - absorbInflow) * steamQuality_in[i], zoneAlloc_in[i] - 1) for i in 1:geo.N_inlet};
            m_flow_outliq = {semiLinear(iCom.m_flow_out[i], absorbInflow * (2 - zoneAlloc_out[i]) + (1 - absorbInflow) * (1 - steamQuality_out[i]), 2 - zoneAlloc_out[i]) for i in 1:geo.N_outlet};
            m_flow_outvap = {semiLinear(iCom.m_flow_out[i], absorbInflow * (zoneAlloc_out[i] - 1) + (1 - absorbInflow) * steamQuality_out[i], zoneAlloc_out[i] - 1) for i in 1:geo.N_outlet};
            H_flow_inliq = {.ClaRa.Basics.Functions.SmoothZeroTransition(absorbInflow * (2 - zoneAlloc_in[i]) * iCom.m_flow_in[i] * iCom.h_in[i] + (1 - absorbInflow) * (1 - steamQuality_in[i]) * iCom.m_flow_in[i] * min(h_bubin[i], iCom.h_in[i]), (2 - zoneAlloc_in[i]) * iCom.m_flow_in[i] * iCom.h[1], iCom.m_flow_in[i], 1e-4) for i in 1:geo.N_inlet};
            H_flow_invap = {.ClaRa.Basics.Functions.SmoothZeroTransition(absorbInflow * (zoneAlloc_in[i] - 1) * iCom.m_flow_in[i] * iCom.h_in[i] + (1 - absorbInflow) * steamQuality_in[i] * iCom.m_flow_in[i] * max(h_dewin[i], iCom.h_in[i]), (zoneAlloc_in[i] - 1) * iCom.m_flow_in[i] * iCom.h[2], iCom.m_flow_in[i], 1e-4) for i in 1:geo.N_inlet};
            H_flow_outliq = {.ClaRa.Basics.Functions.SmoothZeroTransition(absorbInflow * (2 - zoneAlloc_out[i]) * iCom.m_flow_out[i] * iCom.h_out[i] + (1 - absorbInflow) * (1 - steamQuality_out[i]) * iCom.m_flow_out[i] * min(h_bubout[i], iCom.h_out[i]), (2 - zoneAlloc_out[i]) * iCom.m_flow_out[i] * iCom.h[1], iCom.m_flow_out[i], 1e-4) for i in 1:geo.N_outlet};
            H_flow_outvap = {.ClaRa.Basics.Functions.SmoothZeroTransition(absorbInflow * (zoneAlloc_out[i] - 1) * iCom.m_flow_out[i] * iCom.h_out[i] + (1 - absorbInflow) * steamQuality_out[i] * iCom.m_flow_out[i] * max(h_dewout[i], iCom.h_out[i]), (zoneAlloc_out[i] - 1) * iCom.m_flow_out[i] * iCom.h[2], iCom.m_flow_out[i], 1e-4) for i in 1:geo.N_outlet};
            rho = {TILMedia.VLEFluidObjectFunctions.density_phxi(iCom.p[i], iCom.h[i], iCom.xi[i, :], iCom.fluidPointer[i]) for i in 1:iCom.N_cv};
            steamQuality_in = {TILMedia.VLEFluidObjectFunctions.steamMassFraction_phxi(iCom.p_in[i], iCom.h_in[i], iCom.xi_in[i, :], iCom.fluidPointer_in[i]) for i in 1:iCom.N_inlet};
            steamQuality_out = {TILMedia.VLEFluidObjectFunctions.steamMassFraction_phxi(iCom.p_out[i], iCom.h_out[i], iCom.xi_out[i, :], iCom.fluidPointer_out[i]) for i in 1:iCom.N_outlet};
            h_bubin = {TILMedia.VLEFluidObjectFunctions.bubbleSpecificEnthalpy_pxi(iCom.p_in[i], iCom.xi_in[i, :], iCom.fluidPointer_in[i]) for i in 1:iCom.N_inlet};
            h_dewin = {TILMedia.VLEFluidObjectFunctions.dewSpecificEnthalpy_pxi(iCom.p_in[i], iCom.xi_in[i, :], iCom.fluidPointer_in[i]) for i in 1:iCom.N_inlet};
            h_bubout = {TILMedia.VLEFluidObjectFunctions.bubbleSpecificEnthalpy_pxi(iCom.p_out[i], iCom.xi_out[i, :], iCom.fluidPointer_out[i]) for i in 1:iCom.N_outlet};
            h_dewout = {TILMedia.VLEFluidObjectFunctions.dewSpecificEnthalpy_pxi(iCom.p_out[i], iCom.xi_out[i, :], iCom.fluidPointer_out[i]) for i in 1:iCom.N_outlet};
            for i in 1:iCom.N_outlet loop
              zoneAlloc_out[i] = .ClaRa.Basics.Functions.Stepsmoother(z_min_out[i], z_max_out[i], level_abs) + 1;
            end for;
            for i in 1:iCom.N_inlet loop
              zoneAlloc_in[i] = .ClaRa.Basics.Functions.Stepsmoother(z_min_in[i], z_max_in[i], level_abs) + 1;
            end for;
            Delta_p_geo_in = {(level_abs - geo.z_in[i]) * Modelica.Constants.g_n * noEvent(if level_abs > geo.z_in[i] then rho[1] else rho[2]) for i in 1:geo.N_inlet};
            Delta_p_geo_out = {(level_abs - geo.z_out[i]) * Modelica.Constants.g_n * noEvent(if level_abs > geo.z_out[i] then rho[1] else rho[2]) for i in 1:geo.N_outlet};
          end RealSeparated;

          partial model MechanicalEquilibrium_L4  
            extends ClaRa.Basics.Icons.MecahnicalEquilibriumIcon;
            outer ClaRa.Basics.Records.IComVLE_L3 iCom;
            outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry_N_cv geo;
            Basics.Units.MassFlowRate[iCom.N_cv + 1] m_flow;
            parameter Basics.Units.EnthalpyMassSpecific[geo.N_cv] h_start "Start values for enthalpy";
          end MechanicalEquilibrium_L4;

          model Homogeneous_L4  "Both phases are in mechanical equilibrium" 
            extends ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.MechanicalEquilibrium_L4;
            Basics.Units.DensityMassSpecific[geo.N_cv] rho_mix "Mixture density";
            Real[geo.N_cv] S "Slip between phases";
            Basics.Units.EnthalpyMassSpecific[geo.N_cv] h(start = h_start) "Slip model enthalpy";
            Basics.Units.Velocity[iCom.N_cv] w_gu "Mean drift velocity";
          equation
            for i in 1:geo.N_cv loop
              rho_mix[i] = .TILMedia.VLEFluidObjectFunctions.density_phxi(iCom.p[i], iCom.h[i], iCom.xi[i, :], iCom.fluidPointer[i]);
              S[i] = 1;
              h[i] = iCom.h[i];
              w_gu[i] = 0;
            end for;
          end Homogeneous_L4;
        end SpacialDistribution;

        package PressureLoss  
          extends ClaRa.Basics.Icons.PackageIcons.Basics50;

          partial model PressureLossBaseGas_L2  end PressureLossBaseGas_L2;

          partial model PressureLossBaseVLE_L2  end PressureLossBaseVLE_L2;

          partial model PressureLossBaseGas_L4  end PressureLossBaseGas_L4;

          partial model PressureLossBaseVLE_L4  end PressureLossBaseVLE_L4;

          partial model TubeType_L2  "Partial heat transfer model for tube-type models - level of detail L2" end TubeType_L2;

          partial model ShellType_L2  "Partial heat transfer model for shell-type models - level of detail L2" end ShellType_L2;

          package Generic_PL  "Pressure loss models for arbitrary geometries and media" 
            extends Icons.PackageIcons.Basics50;

            partial model PressureLoss_L2  
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.PressureLossBaseVLE_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.PressureLossBaseGas_L2;
              extends ClaRa.Basics.Icons.Delta_p;
              .ClaRa.Basics.Units.Pressure Delta_p(start = 0);
              outer parameter Boolean useHomotopy;
            end PressureLoss_L2;

            model NoFriction_L2  "All geo || No pressure loss due to friction" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.TubeType_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.ShellType_L2;
            equation
              Delta_p = 0;
            end NoFriction_L2;

            model LinearPressureLoss_L2  "All geo || Linear pressure loss || Nominal pressure difference" 
              outer ClaRa.Basics.Records.IComBase_L2 iCom;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.TubeType_L2;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.ShellType_L2;
              parameter .ClaRa.Basics.Units.Pressure Delta_p_nom = 1000 "Nominal pressure loss";
            equation
              Delta_p = Delta_p_nom / iCom.m_flow_nom * iCom.m_flow_in;
            end LinearPressureLoss_L2;

            model PressureLoss_L3  "Generic pressure loss models for type L3 models" 
              extends ClaRa.Basics.Icons.Delta_p;
              outer ClaRa.Basics.Records.IComBase_L3 iCom;
              ClaRa.Basics.Units.PressureDifference[iCom.N_inlet] Delta_p(start = ones(iCom.N_inlet)) "Pressure difference du to friction";
            end PressureLoss_L3;

            model LinearParallelZones_L3  "All geo | L3 | linear | parallel zones | nominal point" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L3;
              parameter .ClaRa.Basics.Units.Pressure[iCom.N_inlet] Delta_p_nom = ones(iCom.N_inlet) * 1000 "Nominal ressure loss";
              parameter Real CF_backflow = 1 "Enhancement factor for reverse flow pressure loss";
            equation
              iCom.m_flow_in = {semiLinear(Delta_p[i] / Delta_p_nom[i], 1, CF_backflow) * iCom.m_flow_nom for i in 1:iCom.N_inlet};
            end LinearParallelZones_L3;

            partial model PressureLoss_L4  "VLE || PL Base Class" 
              extends ClaRa.Basics.Icons.Delta_p;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.PressureLossBaseVLE_L4;
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.PressureLossBaseGas_L4;
              outer parameter Boolean frictionAtInlet;
              outer parameter Boolean frictionAtOutlet;
              outer ClaRa.Basics.Records.IComBase_L3 iCom;
              outer ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry_N_cv geo;
              outer parameter Boolean useHomotopy;
              final parameter Basics.Units.MassFlowRate m_flow_nom = iCom.m_flow_nom "Nominal mass flow rate";
              final parameter Basics.Units.PressureDifference Delta_p_nom = iCom.Delta_p_nom "Nominal pressure loss wrt. all parallel tubes";
              Basics.Units.PressureDifference[iCom.N_cv + 1] Delta_p "Pressure difference";
              Basics.Units.MassFlowRate[iCom.N_cv + 1] m_flow;
            end PressureLoss_L4;

            model LinearPressureLoss_L4  "Medium independent || Linear PL with const. PL coeff" 
              extends ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L4;
              final parameter ClaRa.Basics.Units.Length length = sum(geo.Delta_x);
            equation
              if not frictionAtInlet and not frictionAtOutlet then
                for i in 2:iCom.N_cv loop
                  m_flow[i] = m_flow_nom * Delta_p[i] / Delta_p_nom ./ (geo.Delta_x_FM[i] / (length - geo.Delta_x_FM[1] - geo.Delta_x_FM[iCom.N_cv + 1]));
                end for;
                Delta_p[1] = 0;
                Delta_p[iCom.N_cv + 1] = 0;
              elseif not frictionAtInlet and frictionAtOutlet then
                for i in 2:iCom.N_cv + 1 loop
                  m_flow[i] = m_flow_nom * Delta_p[i] / Delta_p_nom ./ (geo.Delta_x_FM[i] / (length - geo.Delta_x_FM[1]));
                end for;
                Delta_p[1] = 0;
              elseif frictionAtInlet and not frictionAtOutlet then
                for i in 1:iCom.N_cv loop
                  m_flow[i] = m_flow_nom * Delta_p[i] / Delta_p_nom ./ (geo.Delta_x_FM[i] / (length - geo.Delta_x_FM[iCom.N_cv + 1]));
                end for;
                Delta_p[iCom.N_cv + 1] = 0;
              else
                for i in 1:iCom.N_cv + 1 loop
                  m_flow[i] = m_flow_nom * Delta_p[i] / Delta_p_nom ./ (geo.Delta_x_FM[i] / length);
                end for;
              end if;
            end LinearPressureLoss_L4;
          end Generic_PL;
        end PressureLoss;
      end Fundamentals;
    end ControlVolumes;
  end Basics;

  package Components  "Containing general description of pumps, heat exchangers,..." 
    extends ClaRa.Basics.Icons.PackageIcons.Components100;

    package BoundaryConditions  "Boundary Conditions for Components" 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      model BoundaryVLE_Txim_flow  "A boundary defining temperature, composition and mass flow" 
        extends ClaRa.Basics.Icons.FlowSource;
        ClaRa.Basics.Interfaces.Connected2SimCenter connected2SimCenter(powerIn = if massFlowIsLoss then 0 else max(0, -steam_a.m_flow * actualStream(steam_a.h_outflow)), powerOut = if massFlowIsLoss then 0 else max(0, steam_a.m_flow * actualStream(steam_a.h_outflow)), powerAux = 0) if contributeToCycleSummary;
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium to be used";
        parameter Boolean variable_m_flow = false "True, if mass flow defined by variable input";
        parameter Boolean variable_T = false "True, if temperature defined by variable input";
        parameter Boolean variable_xi = false "True, if composition defined by variable input";
        parameter .ClaRa.Basics.Units.MassFlowRate m_flow_const = 0 "Constant mass flow rate";
        parameter .ClaRa.Basics.Units.Temperature T_const = 293.15 "Constant temperature of source";
        parameter .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_const = zeros(medium.nc - 1) "Constant composition";
        parameter .ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal flange pressure";
        parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 0 "Nominal flange mass flow (zero refers to ideal boundary)";
        outer ClaRa.SimCenter simCenter;
        parameter Boolean showData = true "|Summary and Visualisation||True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
        parameter Boolean contributeToCycleSummary = simCenter.contributeToCycleSummary "True if component shall contribute to automatic efficiency calculation";
        parameter Boolean massFlowIsLoss = true "True if mass flow is a loss (not a process product)";
      protected
        .ClaRa.Basics.Units.MassFlowRate m_flow_in;
        .ClaRa.Basics.Units.Temperature T_in;
        .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_in;
      public
        ClaRa.Basics.Interfaces.FluidPortIn steam_a(Medium = medium);
        Modelica.Blocks.Interfaces.RealInput m_flow = m_flow_in if variable_m_flow "Variable mass flow rate";
        Modelica.Blocks.Interfaces.RealInput T = T_in if variable_T "Variable temperature";
        Modelica.Blocks.Interfaces.RealInput[medium.nc - 1] xi = xi_in if variable_xi "Variable composition";
        Basics.Interfaces.EyeOut eye if showData;
      protected
        TILMedia.VLEFluid_pT fluidOut(vleFluidType = medium, p = steam_a.p, T = T_in, xi = xi_in);
        Basics.Interfaces.EyeIn[1] eye_int;
      equation
        if not variable_m_flow then
          m_flow_in = m_flow_const;
        end if;
        if not variable_T then
          T_in = T_const;
        end if;
        if not variable_xi then
          xi_in = xi_const;
        end if;
        steam_a.h_outflow = fluidOut.h;
        if m_flow_nom > 0 then
          steam_a.m_flow = (-m_flow_in) - m_flow_nom / p_nom * (p_nom - steam_a.p);
        else
          steam_a.m_flow = -m_flow_in;
        end if;
        steam_a.xi_outflow = xi_in;
        eye_int[1].m_flow = -steam_a.m_flow;
        eye_int[1].T = fluidOut.T - 273.15;
        eye_int[1].s = fluidOut.s / 1e3;
        eye_int[1].p = steam_a.p / 1e5;
        eye_int[1].h = fluidOut.h / 1e3;
        connect(eye, eye_int[1]);
      end BoundaryVLE_Txim_flow;

      model BoundaryVLE_phxi  "A boundary defining pressure, enthalpy and composition" 
        extends ClaRa.Basics.Icons.FlowSink;
        ClaRa.Basics.Interfaces.Connected2SimCenter connected2SimCenter(powerIn = if massFlowIsLoss then 0 else max(0, -steam_a.m_flow * actualStream(steam_a.h_outflow)), powerOut = if massFlowIsLoss then 0 else max(0, steam_a.m_flow * actualStream(steam_a.h_outflow)), powerAux = 0) if contributeToCycleSummary;
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium to be used";
        parameter Boolean showData = true "|Summary and Visualisation||True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
        parameter Boolean contributeToCycleSummary = simCenter.contributeToCycleSummary "True if component shall contribute to automatic efficiency calculation";
        parameter Boolean massFlowIsLoss = true "True if mass flow is a loss (not a process product)";
        parameter Boolean variable_p = false "True, if pressure defined by variable input";
        parameter Boolean variable_h = false "True, if spc. enthalpy defined by variable input";
        parameter Boolean variable_xi = false "True, if composition defined by variable input";
        parameter .ClaRa.Basics.Units.Pressure p_const = 0 "Constant pressure";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_const = 1e5 "Constant specific enthalpy of source";
        parameter .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_const = zeros(medium.nc - 1) "Constant composition";
        parameter .ClaRa.Basics.Units.Pressure Delta_p = 0 "Flange pressure drop at nominal mass flow (zero refers to ideal boundary)";
        parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 1 "Nominal flange mass flow ";
        outer ClaRa.SimCenter simCenter;
      protected
        .ClaRa.Basics.Units.Pressure p_in;
        .ClaRa.Basics.Units.EnthalpyMassSpecific h_in;
        .ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_in;
        TILMedia.VLEFluid_ph fluidOut(vleFluidType = medium, p = steam_a.p, h = noEvent(actualStream(steam_a.h_outflow)), xi = xi_in);
      public
        ClaRa.Basics.Interfaces.FluidPortIn steam_a(Medium = medium);
        Modelica.Blocks.Interfaces.RealInput p = p_in if variable_p "Variable mass flow rate";
        Modelica.Blocks.Interfaces.RealInput h = h_in if variable_h "Variable specific enthalpy";
        Modelica.Blocks.Interfaces.RealInput[medium.nc - 1] xi = xi_in if variable_xi "Variable composition";
        Basics.Interfaces.EyeOut eye if showData;
      protected
        Basics.Interfaces.EyeIn[1] eye_int;
      equation
        if not variable_p then
          p_in = p_const;
        end if;
        if not variable_h then
          h_in = h_const;
        end if;
        if not variable_xi then
          xi_in = xi_const;
        end if;
        steam_a.h_outflow = h_in;
        if Delta_p > 0 then
          steam_a.p = p_in + Delta_p / m_flow_nom * steam_a.m_flow;
        else
          steam_a.p = p_in;
        end if;
        steam_a.xi_outflow = xi_in;
        eye_int[1].m_flow = -steam_a.m_flow;
        eye_int[1].T = fluidOut.T - 273.15;
        eye_int[1].s = fluidOut.s / 1e3;
        eye_int[1].p = steam_a.p / 1e5;
        eye_int[1].h = fluidOut.h / 1e3;
        connect(eye, eye_int[1]);
      end BoundaryVLE_phxi;

      model PrescribedHeatFlow  "Prescribed heat flow boundary condition 1D" 
        parameter Modelica.SIunits.Length length "Length of cylinder";
        parameter Integer N_axial = 3 "Number of axial elements";
        parameter Modelica.SIunits.Length[N_axial] Delta_x = ClaRa.Basics.Functions.GenerateGrid({1, -1}, length, N_axial) "Discretisation scheme";
        Modelica.Blocks.Interfaces.RealInput Q_flow;
        ClaRa.Basics.Interfaces.HeatPort_b[N_axial] port;
      equation
        port.Q_flow = -Q_flow .* Delta_x / sum(Delta_x);
      end PrescribedHeatFlow;

      model BoundaryElectricFrequency  
        extends ClaRa.Basics.Icons.FlowSink;
        parameter Boolean variable_f = false "True, if frequency defined by variable input";
        parameter ClaRa.Basics.Units.Frequency f_const = 50 "Constant frequency";
      protected
        ClaRa.Basics.Units.Frequency f_in;
      public
        outer ClaRa.SimCenter simCenter;
        Basics.Interfaces.ElectricPortIn electricPortIn;
        Modelica.Blocks.Interfaces.RealInput f = f_in if variable_f "Variable fequency";
      equation
        if not variable_f then
          f_in = f_const;
        end if;
        electricPortIn.f = f_in;
      end BoundaryElectricFrequency;
    end BoundaryConditions;

    package TurboMachines  "Pumps, Fans, Compressore, Turbines" 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      package Pumps  
        extends ClaRa.Basics.Icons.PackageIcons.Components60;

        package Fundamentals  
          extends ClaRa.Basics.Icons.PackageIcons.Components50;

          model Outline  
            extends ClaRa.Basics.Icons.RecordIcon;
            input .ClaRa.Basics.Units.VolumeFlowRate V_flow "Volume flow rate";
            input .ClaRa.Basics.Units.PressureDifference Delta_p "Pressure difference";
            input .ClaRa.Basics.Units.Length head "Head";
            input .ClaRa.Basics.Units.Length NPSHa "Net positive suction head available";
            input Real eta_hyd "Hydraulic efficiency";
            input Real eta_mech "Mechanic efficiency";
            input .ClaRa.Basics.Units.Power P_fluid "Hydraulic power";
          end Outline;

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            Fundamentals.Outline outline;
            ClaRa.Basics.Records.FlangeVLE inlet;
            ClaRa.Basics.Records.FlangeVLE outlet;
          end Summary;

          partial model Pump_Base  "Base class for pumps" 
            extends ClaRa.Basics.Icons.Pump;
            parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component" annotation(choicesAllMatching = true);
            parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
            parameter Boolean showData = true "True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
            parameter Boolean contributeToCycleSummary = simCenter.contributeToCycleSummary "True if component shall contribute to automatic efficiency calculation";
            .ClaRa.Basics.Units.Pressure Delta_p "Pressure difference between pressure side and suction side";
            .ClaRa.Basics.Units.VolumeFlowRate V_flow "Volume flow rate";
            .ClaRa.Basics.Units.Power P_fluid "Power to the fluid";
            outer ClaRa.SimCenter simCenter;
            ClaRa.Basics.Interfaces.FluidPortIn inlet(Medium = medium);
            ClaRa.Basics.Interfaces.FluidPortOut outlet(Medium = medium);
          protected
            TILMedia.VLEFluid_ph fluidIn(vleFluidType = medium, p = inlet.p, h = homotopy(noEvent(actualStream(inlet.h_outflow)), inStream(inlet.h_outflow)));
            TILMedia.VLEFluid_ph fluidOut(vleFluidType = medium, p = outlet.p, h = homotopy(noEvent(actualStream(outlet.h_outflow)), outlet.h_outflow));
          public
            Basics.Interfaces.EyeOut eye if showData;
          protected
            Basics.Interfaces.EyeIn[1] eye_int;
          equation
            eye_int[1].m_flow = -outlet.m_flow;
            eye_int[1].T = fluidOut.T - 273.15;
            eye_int[1].s = fluidOut.s / 1e3;
            eye_int[1].p = outlet.p / 1e5;
            eye_int[1].h = fluidOut.h / 1e3;
            connect(eye, eye_int[1]);
          end Pump_Base;
        end Fundamentals;

        model PumpVLE_L1_simple  "A pump for VLE mixtures with a volume flow rate depending on drive power and pressure difference only" 
          extends ClaRa.Components.TurboMachines.Pumps.Fundamentals.Pump_Base;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L1");
          ClaRa.Basics.Interfaces.Connected2SimCenter connected2SimCenter(powerIn = 0, powerOut = inlet.m_flow * (fluidIn.h - fluidOut.h), powerAux = P_drive - inlet.m_flow * (fluidOut.h - fluidIn.h)) if contributeToCycleSummary;
          parameter Real eta_mech = 0.98 "Mechanic efficiency of the drive";
          parameter ClaRa.Basics.Units.Pressure Delta_p_eps = 100 "|Expert Settings| Numerical Robustnes|Small pressure difference for linearisation around zero";
          Modelica.Blocks.Interfaces.RealInput P_drive "Power input of the pump's motor";
          Fundamentals.Summary summary(outline(V_flow = V_flow, P_fluid = P_fluid, Delta_p = Delta_p, head = Delta_p / (fluidIn.d * Modelica.Constants.g_n), NPSHa = (inlet.p - .TILMedia.VLEFluidObjectFunctions.bubblePressure_Txi(fluidIn.T, fluidIn.xi, fluidIn.vleFluidPointer)) / (fluidIn.d * Modelica.Constants.g_n), eta_hyd = 0, eta_mech = eta_mech), inlet(showExpertSummary = showExpertSummary, m_flow = inlet.m_flow, T = fluidIn.T, p = inlet.p, h = fluidIn.h, s = fluidIn.s, steamQuality = fluidIn.q, H_flow = fluidIn.h * inlet.m_flow, rho = fluidIn.d), outlet(showExpertSummary = showExpertSummary, m_flow = -outlet.m_flow, T = fluidOut.T, p = outlet.p, h = fluidOut.h, s = fluidOut.s, steamQuality = fluidOut.q, H_flow = -fluidOut.h * outlet.m_flow, rho = fluidOut.d));
        equation
          P_fluid = P_drive * eta_mech;
          V_flow = P_fluid / (Delta_p + Delta_p_eps);
          inlet.m_flow = V_flow * fluidIn.d;
          inlet.h_outflow = inStream(outlet.h_outflow);
          inlet.m_flow + outlet.m_flow = 0.0 "Mass balance";
          Delta_p = outlet.p - inlet.p "Momentum balance";
          outlet.h_outflow = inStream(inlet.h_outflow) + P_drive * eta_mech / (inlet.m_flow + 1e-6) "Energy balance";
        end PumpVLE_L1_simple;
      end Pumps;

      package Turbines  
        extends ClaRa.Basics.Icons.PackageIcons.Components60;

        partial model SteamTurbine_base  "Base class for steam turbines" 
          extends ClaRa.Basics.Icons.SimpleTurbine;
          parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component" annotation(choicesAllMatching = true);
          ClaRa.Basics.Interfaces.FluidPortIn inlet(Medium = medium);
          ClaRa.Basics.Interfaces.FluidPortOut outlet(Medium = medium);
          outer SimCenter simCenter;
        end SteamTurbine_base;

        model SteamTurbineVLE_L1  "A steam turbine model based on STODOLA's law" 
          extends ClaRa.Components.TurboMachines.Turbines.SteamTurbine_base(inlet(m_flow(start = m_flow_nom)));
          ClaRa.Basics.Interfaces.Connected2SimCenter connected2SimCenter(powerIn = 0, powerOut = inlet.m_flow * (fluidIn.h - fluidOut.h), powerAux = inlet.m_flow * (fluidIn.h - fluidOut.h) + P_t) if contributeToCycleSummary;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L1");
          parameter Boolean useMechanicalPort = false "True, if a mechenical flange should be used";
          parameter Boolean steadyStateTorque = true "True, if steady state mechanical momentum shall be used";
          parameter ClaRa.Basics.Units.RPM rpm_fixed = 3000 "Constant rotational speed of turbine";
          parameter Modelica.SIunits.Inertia J = 10 "Moment of Inertia";
          parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
          parameter Boolean showData = true "True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
          parameter Boolean contributeToCycleSummary = simCenter.contributeToCycleSummary "True if component shall contribute to automatic efficiency calculation";
          parameter Modelica.SIunits.Pressure p_nom = 300e5 "Nominal inlet perssure";
          parameter Modelica.SIunits.MassFlowRate m_flow_nom = 419 "Nominal mass flow rate";
          parameter Real Pi = 5000 / 300e5 "Nominal pressure ratio";
          parameter Modelica.SIunits.Density rho_nom = 10 "Nominal inlet density";
          parameter Modelica.SIunits.Pressure p_in_start = p_nom "Start value for inlet pressure";
          parameter Modelica.SIunits.Pressure p_out_start = p_nom * Pi "Start value for outlet pressure";
          parameter Boolean allowFlowReversal = simCenter.steamCycleAllowFlowReversal "True to allow flow reversal during initialisation" annotation(Evaluate = true);
          parameter Real eta_mech = 0.98 "Mechanical efficiency";
          replaceable model Efficiency = ClaRa.Components.TurboMachines.Fundamentals.TurbineEfficiency.TableMassFlow constrainedby ClaRa.Components.TurboMachines.Fundamentals.TurbineEfficiency.EfficiencyModelBase;
          parameter Boolean chokedFlow = false "With a large number of turbine stages the influence of supercritical flow conditions can be neglected";
          final parameter Real Kt = m_flow_nom * sqrt(p_nom) / (sqrt(p_nom ^ 2 - p_nom ^ 2 * Pi ^ 2) * sqrt(rho_nom)) "Kt coefficient of Stodola's law";
          Modelica.SIunits.SpecificEnthalpy h_is "Isentropic outlet enthalpy";
          Modelica.SIunits.Power P_t "Turbine hydraulic power";
          Modelica.SIunits.Pressure p_in(start = p_in_start);
          Modelica.SIunits.Pressure p_out(start = p_out_start);
          Real eta_is "Isentropic efficiency";
          Modelica.SIunits.EntropyFlowRate S_irr "Entropy production rate";
          Modelica.SIunits.Pressure p_l "Laval pressure";
          ClaRa.Basics.Units.RPM rpm;
          inner Fundamentals.IComTurbine iCom(m_flow_in = inlet.m_flow, m_flow_nom = m_flow_nom, rho_nom = rho_nom, rho_in = fluidIn.d, rpm = rpm, Delta_h_is = fluidIn.h - h_is);

          model Outline  
            extends ClaRa.Basics.Icons.RecordIcon;
            input ClaRa.Basics.Units.PressureDifference Delta_p;
            input ClaRa.Basics.Units.Power P_mech "Mechanical power of steam turbine";
            input Real eta_isen "Isentropic efficiency";
            input Real eta_mech "Mechanic efficiency";
            input ClaRa.Basics.Units.EnthalpyMassSpecific h_isen "Isentropic steam enthalpy at turbine outlet";
            input ClaRa.Basics.Units.RPM rpm "Pump revolutions per minute";
            input ClaRa.Basics.Units.Pressure p_nom if showExpertSummary "Nominal inlet perssure";
            input Real Pi if showExpertSummary "Nominal pressure ratio";
            input ClaRa.Basics.Units.MassFlowRate m_flow_nom if showExpertSummary "Nominal mass flow rate";
            input ClaRa.Basics.Units.DensityMassSpecific rho_nom if showExpertSummary "Nominal inlet density";
            parameter Boolean showExpertSummary;
          end Outline;

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            Outline outline;
            ClaRa.Basics.Records.FlangeVLE inlet;
            ClaRa.Basics.Records.FlangeVLE outlet;
          end Summary;

        protected
          TILMedia.VLEFluidObjectFunctions.VLEFluidPointer ptr_iso = TILMedia.VLEFluidObjectFunctions.VLEFluidPointer(medium.concatVLEFluidName, 0, medium.mixingRatio_propertyCalculation[1:end - 1] / sum(medium.mixingRatio_propertyCalculation), medium.nc_propertyCalculation, medium.nc, TILMedia.Internals.redirectModelicaFormatMessage()) "Pointer to external medium memory for isentropic expansion state";
          ClaRa.Components.TurboMachines.Fundamentals.GetInputsRotary2 getInputsRotary;
          TILMedia.VLEFluid_ph fluidOut(vleFluidType = medium, p = outlet.p, h = outlet.h_outflow);
          TILMedia.VLEFluid_ph fluidIn(vleFluidType = medium, h = inStream(inlet.h_outflow), p = inlet.p, d(start = rho_nom));
        public
          Summary summary(outline(showExpertSummary = showExpertSummary, p_nom = p_nom, m_flow_nom = m_flow_nom, rho_nom = rho_nom, Pi = Pi, Delta_p = p_out - p_in, P_mech = -P_t, eta_isen = eta_is, eta_mech = eta_mech, h_isen = h_is, rpm = rpm), inlet(showExpertSummary = showExpertSummary, m_flow = inlet.m_flow, T = fluidIn.T, p = inlet.p, h = fluidIn.h, s = fluidIn.s, steamQuality = fluidIn.q, H_flow = fluidIn.h * inlet.m_flow, rho = fluidIn.d), outlet(showExpertSummary = showExpertSummary, m_flow = -outlet.m_flow, T = fluidOut.T, p = outlet.p, h = fluidOut.h, s = fluidOut.s, steamQuality = fluidOut.q, H_flow = -fluidOut.h * outlet.m_flow, rho = fluidOut.d));
          Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a if useMechanicalPort;
          Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b if useMechanicalPort;
          ClaRa.Basics.Interfaces.EyeOut eye if showData;
          Efficiency efficiency "Efficiency model";
        protected
          ClaRa.Basics.Interfaces.EyeIn[1] eye_int;
        equation
          rpm = der(getInputsRotary.shaft_a.phi) * 60 / (2 * Modelica.Constants.pi);
          if useMechanicalPort then
            if steadyStateTorque then
              0 = getInputsRotary.shaft_a.tau + getInputsRotary.shaft_b.tau - P_t / der(getInputsRotary.shaft_a.phi) "Mechanical momentum balance";
            else
              J * der(rpm) * 2 * Modelica.Constants.pi / 60 = getInputsRotary.shaft_a.tau + getInputsRotary.shaft_b.tau - P_t / der(getInputsRotary.shaft_a.phi) "Mechanical momentum balance";
            end if;
          else
            rpm = rpm_fixed;
          end if;
          getInputsRotary.shaft_a.phi = getInputsRotary.shaft_b.phi;
          eta_is = efficiency.eta;
          inlet.h_outflow = inStream(outlet.h_outflow);
          outlet.h_outflow = eta_is * (h_is - inStream(inlet.h_outflow)) + inStream(inlet.h_outflow);
          p_in = inlet.p;
          p_out = outlet.p;
          p_l = p_in * (2 / (fluidOut.gamma + 1)) ^ (fluidOut.gamma / (fluidOut.gamma - 1));
          inlet.m_flow = -outlet.m_flow;
          h_is = .TILMedia.VLEFluidObjectFunctions.specificEnthalpy_psxi(fluidOut.p, fluidIn.s, fluidIn.xi, ptr_iso);
          if chokedFlow == false then
            outlet.m_flow = homotopy(-Kt * sqrt(max(1e-5, fluidIn.d * inlet.p)) * ClaRa.Basics.Functions.ThermoRoot(1 - p_out ^ 2 / inlet.p ^ 2, 0.01), -m_flow_nom * inlet.p / p_nom);
          else
            outlet.m_flow = homotopy(-Kt * sqrt(max(1e-5, fluidIn.d * inlet.p)) * ClaRa.Basics.Functions.ThermoRoot(1 - max(p_out ^ 2 / inlet.p ^ 2, p_l ^ 2 / p_in ^ 2), 0.01), -m_flow_nom * inlet.p / p_nom);
          end if;
          P_t = outlet.m_flow * (fluidIn.h - fluidOut.h) * eta_mech;
          outlet.xi_outflow = inStream(inlet.xi_outflow);
          inlet.xi_outflow = inStream(outlet.xi_outflow);
          S_irr = inlet.m_flow * (fluidOut.s - fluidIn.s);
          eye_int[1].m_flow = -outlet.m_flow;
          eye_int[1].T = fluidOut.T - 273.15;
          eye_int[1].s = fluidOut.s / 1e3;
          eye_int[1].p = outlet.p / 1e5;
          eye_int[1].h = fluidOut.h / 1e3;
          connect(eye, eye_int[1]);
          connect(getInputsRotary.shaft_a, shaft_a);
          connect(getInputsRotary.shaft_b, shaft_b);
        end SteamTurbineVLE_L1;
      end Turbines;

      package Fundamentals  
        extends ClaRa.Basics.Icons.PackageIcons.Components60;

        package TurbineEfficiency  "Replaceable models for (steam) turbine efficiency calculation" 
          extends ClaRa.Basics.Icons.PackageIcons.Components60;

          partial model EfficiencyModelBase  
            extends ClaRa.Basics.Icons.Efficiency;
            outer ClaRa.Components.TurboMachines.Fundamentals.IComTurbine iCom;
          end EfficiencyModelBase;

          model TableMassFlow  "Table based | Mass flow rate dependent" 
            extends ClaRa.Components.TurboMachines.Fundamentals.TurbineEfficiency.EfficiencyModelBase;
            parameter Real[:, 2] eta_mflow = [0.0, 0.94; 1, 0.94] "Characteristic line eta = f(m_flow/m_flow_nom)";
            Real eta "Efficiency";
          protected
            Modelica.Blocks.Tables.CombiTable1D HydraulicEfficiency(columns = {2}, table = eta_mflow);
          equation
            eta = HydraulicEfficiency.y[1];
            HydraulicEfficiency.u[1] = iCom.m_flow_in / iCom.m_flow_nom;
          end TableMassFlow;
        end TurbineEfficiency;

        model GetInputsRotary2  "Get enabled inputs and parameters of disabled inputs" 
          extends Modelica.Blocks.Interfaces.BlockIcon;
          Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a;
          Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b;
        end GetInputsRotary2;

        record IComTurbine  
          extends ClaRa.Basics.Icons.IComIcon;
          .ClaRa.Basics.Units.MassFlowRate m_flow_in "Inlet mass flow";
          .ClaRa.Basics.Units.DensityMassSpecific rho_in "Inlet density";
          parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 10 "Nominal mass flow";
          parameter .ClaRa.Basics.Units.DensityMassSpecific rho_nom = 10 "Nominal inlet density";
          .ClaRa.Basics.Units.RPM rpm "Shaft speed";
          .ClaRa.Basics.Units.EnthalpyMassSpecific Delta_h_is "Isentropic enthalpy drop";
        end IComTurbine;
      end Fundamentals;
    end TurboMachines;

    package HeatExchangers  "Heat Exchangers of various shape" 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      model HEXvle2vle_L3_2ph_BU_simple  "VLE 2 VLE | L3 | 2 phase at shell side | Block shape |  U-type | simple HT" 
        extends ClaRa.Basics.Icons.HEX04;
        extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L3");
        outer ClaRa.SimCenter simCenter;

        model Outline  
          extends ClaRa.Basics.Icons.RecordIcon;
          parameter Boolean showExpertSummary = false;
          input ClaRa.Basics.Units.HeatFlowRate Q_flow "Heat flow rate";
          input ClaRa.Basics.Units.TemperatureDifference Delta_T_in "Fluid temperature at inlet T_1_in - T_2_in";
          input ClaRa.Basics.Units.TemperatureDifference Delta_T_out "Fluid temperature at outlet T_1_out - T_2_out";
          input ClaRa.Basics.Units.Length level_abs "Absolute filling level";
          input Real level_rel "relative filling level";
        end Outline;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          Outline outline;
        end Summary;

        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium_shell = simCenter.fluid1 "Medium to be used for shell flow";
        replaceable model HeatTransfer_Shell = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.VLE_HT.Constant_L3_ypsDependent constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.ShellType_L3;
        replaceable model PressureLossShell = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L3;
        parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
        parameter ClaRa.Basics.Units.Length length = 10 "Length of the HEX";
        parameter ClaRa.Basics.Units.Length height = 3 "Height of HEX";
        parameter ClaRa.Basics.Units.Length width = 3 "Width of HEX";
        parameter ClaRa.Basics.Units.Length z_in_shell = length / 2 "Inlet position from bottom";
        parameter ClaRa.Basics.Units.Length z_in_aux1 = length / 2 "Inlet position of auxilliary1 from bottom";
        parameter ClaRa.Basics.Units.Length z_in_aux2 = length / 2 "Inlet position of auxilliary2 from bottom";
        parameter ClaRa.Basics.Units.Length z_out_shell = length / 2 "Outlet position from bottom";
        parameter ClaRa.Basics.Units.Length radius_flange = 0.05 "Flange radius of all flanges";
        parameter ClaRa.Basics.Units.Mass mass_struc = 0 "Mass of inner structure elements, additional to the tubes itself";
        parameter ClaRa.Basics.Units.Length height_hotwell = 1 "Height of the hotwell";
        parameter ClaRa.Basics.Units.Length width_hotwell = 1 "Width of the hotwell";
        parameter ClaRa.Basics.Units.Length length_hotwell = 1 "Length of the hotwell";
        parameter ClaRa.Basics.Units.MassFlowRate m_flow_nom_shell = 10 "Nominal mass flow on shell side";
        parameter ClaRa.Basics.Units.Pressure p_nom_shell = 10 "Nominal pressure on shell side";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_nom_shell = 100e3 "Nominal specific enthalpy on shell side";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_liq_start = (-10) + TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium_shell, p_start_shell) "Start value of liquid specific enthalpy";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_vap_start = (+10) + TILMedia.VLEFluidFunctions.dewSpecificEnthalpy_pxi(medium_shell, p_start_shell) "Start value of vapour specific enthalpy";
        parameter ClaRa.Basics.Units.Pressure p_start_shell = 1e5 "Start value of shell fluid pressure";
        parameter Real level_rel_start = 0.5 "Start value for relative filling Level";
        inner parameter Integer initOptionShell = 211 "Type of initialisation";
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium_tubes = simCenter.fluid1 "Medium to be used for tubes flow";
        replaceable model HeatTransferTubes = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L2;
        replaceable model PressureLossTubes = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.NoFriction_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.TubeType_L2;
        parameter ClaRa.Basics.Units.Length diameter_i = 0.048 "Inner diameter of internal tubes";
        parameter ClaRa.Basics.Units.Length diameter_o = 0.05 "Outer diameter of internal tubes";
        parameter Integer N_tubes = 1000 "Number of tubes";
        parameter Integer N_passes = 1 "Number of passes of the internal tubes";
        parameter ClaRa.Basics.Units.Length z_in_tubes = length / 2 "Inlet position from bottom";
        parameter ClaRa.Basics.Units.Length z_out_tubes = length / 2 "Outlet position from bottom";
        parameter Boolean staggeredAlignment = true "True, if the tubes are aligned staggeredly";
        parameter ClaRa.Basics.Units.Length Delta_z_par = 2 * diameter_o "Distance between tubes parallel to flow direction (center to center)";
        parameter ClaRa.Basics.Units.Length Delta_z_ort = 2 * diameter_o "Distance between tubes orthogonal to flow direction (center to center)";
        parameter Integer N_rows = integer(ceil(sqrt(N_tubes)) * N_passes) "Number of pipe rows in shell flow direction";
        parameter Real CF_geo = 1 "Correction coefficient due to fins etc.";
        parameter ClaRa.Basics.Units.MassFlowRate m_flow_nom_tubes = 10 "Nominal mass flow on tubes side";
        parameter ClaRa.Basics.Units.Pressure p_nom_tubes = 10 "Nominal pressure on side tubes";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_nom_tubes = 10 "Nominal specific enthalpy on tubes side";
        parameter ClaRa.Basics.Units.HeatFlowRate Q_flow_nom = 1e6 "Nominal heat flow rate";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_start_tubes = 1e5 "Start value of tube fluid specific enthalpy";
        parameter ClaRa.Basics.Units.Pressure p_start_tubes = 1e5 "Start value of tube fluid pressure";
        parameter Integer initOptionTubes = 0 "Type of initialisation at tube side";
        replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Aluminum constrainedby TILMedia.SolidTypes.BaseSolid;
        parameter ClaRa.Basics.Units.Temperature[3] T_w_start = ones(3) * 293.15 "Initial wall temperature inner --> outer";
        parameter Integer initOptionWall = 0 "Init option of Tube wall";
        parameter ClaRa.Basics.Units.Time Tau_cond = 0.3 "Time constant of condensation";
        parameter ClaRa.Basics.Units.Time Tau_evap = 0.03 "Time constant of evaporation";
        parameter ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_ph = 50000 "HTC of the phase border";
        parameter ClaRa.Basics.Units.Area A_phaseBorder = shell.geo.A_hor * 100 "Heat transfer area at phase border";
        parameter Real expHT_phases = 0 "Exponent for volume dependency on inter phase HT";
        parameter Real absorbInflow = 1 "Absorption of incoming mass flow to the zones 1: perfect in the allocated zone, 0: perfect according to steam quality";
        parameter Boolean equalPressures = true "True if pressure in liquid and vapour phase is equal";
        parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of level calculation (table based)";
        parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
        parameter Boolean showData = true "True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
        parameter Boolean levelOutput = false "True, if Real level connector shall be addded";
        parameter Boolean outputAbs = false "True, if absolute level is at output";
        ClaRa.Basics.Interfaces.FluidPortIn In2(Medium = medium_tubes);
        ClaRa.Basics.Interfaces.FluidPortOut Out2(Medium = medium_tubes);
        ClaRa.Basics.Interfaces.FluidPortOut Out1(Medium = medium_shell);
        ClaRa.Basics.Interfaces.FluidPortIn In1(Medium = medium_shell);
        ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_2 tubes(medium = medium_tubes, p_nom = p_nom_tubes, h_nom = h_nom_tubes, m_flow_nom = m_flow_nom_tubes, useHomotopy = useHomotopy, h_start = h_start_tubes, p_start = p_start_tubes, redeclare model HeatTransfer = HeatTransferTubes, redeclare model PressureLoss = PressureLossTubes, redeclare model PhaseBorder = ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.IdeallyStirred, showExpertSummary = showExpertSummary, redeclare model Geometry = ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.PipeGeometry(final z_in = {z_in_tubes}, final z_out = {z_out_tubes}, final diameter = diameter_i, final N_tubes = N_tubes, final N_passes = N_passes, final length = length), initOption = initOptionTubes);
        ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_L3_TwoZonesNPort shell(medium = medium_shell, p_nom = p_nom_shell, redeclare model HeatTransfer = HeatTransfer_Shell, redeclare model PressureLoss = PressureLossShell, m_flow_nom = m_flow_nom_shell, useHomotopy = useHomotopy, p_start = p_start_shell, level_rel_start = level_rel_start, Tau_cond = Tau_cond, Tau_evap = Tau_evap, alpha_ph = alpha_ph, h_liq_start = h_liq_start, h_vap_start = h_vap_start, showExpertSummary = showExpertSummary, exp_HT_phases = expHT_phases, A_heat_ph = A_phaseBorder, heatSurfaceAlloc = 2, redeclare model PhaseBorder = ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.RealSeparated(level_rel_start = level_rel_start, radius_flange = radius_flange, absorbInflow = absorbInflow, smoothness = smoothness), equalPressures = equalPressures, initOption = initOptionShell, redeclare model Geometry = ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.HollowBlockWithTubesAndHotwell(final z_out = {z_out_shell}, final length = length, final N_tubes = N_tubes, final staggeredAlignment = staggeredAlignment, final Delta_z_par = Delta_z_par, final Delta_z_ort = Delta_z_ort, final N_passes = N_passes, final diameter_t = diameter_o, final N_inlet = 3, final z_in = {z_in_shell, z_in_aux1, z_in_aux2}, final flowOrientation = ClaRa.Basics.Choices.GeometryOrientation.vertical, final N_rows = N_rows, final parallelTubes = false, final CF_geo = {1, CF_geo}, final height = height, final width = width, final height_hotwell = height_hotwell, final width_hotwell = width_hotwell, final length_hotwell = length_hotwell));
        ClaRa.Basics.ControlVolumes.SolidVolumes.CylindricalThickWall_L4 wall(redeclare replaceable model Material = WallMaterial, N_rad = 3, sizefunc = 1, diameter_o = diameter_o, diameter_i = diameter_i, N_tubes = N_tubes, T_start = T_w_start, length = length * N_passes, initOption = initOptionWall, mass_struc = mass_struc);
        Summary summary(outline(showExpertSummary = showExpertSummary, Q_flow = sum(shell.heat.Q_flow), Delta_T_in = shell.summary.inlet[1].T - tubes.summary.inlet.T, Delta_T_out = shell.summary.outlet[1].T - tubes.summary.outlet.T, level_abs = shell.phaseBorder.level_abs, level_rel = shell.phaseBorder.level_rel));
      protected
        ClaRa.Basics.Interfaces.EyeIn[1] eye_int2;
      public
        ClaRa.Basics.Interfaces.EyeOut eye2 if showData;
      protected
        ClaRa.Basics.Interfaces.EyeIn[1] eye_int1;
      public
        ClaRa.Basics.Interfaces.EyeOut eye1 if showData;
        ClaRa.Basics.Interfaces.FluidPortIn aux1(Medium = medium_shell);
        ClaRa.Basics.Interfaces.FluidPortIn aux2(Medium = medium_shell);
        Modelica.Blocks.Interfaces.RealOutput level = if outputAbs then summary.outline.level_abs else summary.outline.level_rel if levelOutput;
      equation
        assert(diameter_o > diameter_i, "Outer diameter of tubes must be greater than inner diameter");
        connect(tubes.inlet, In2);
        connect(tubes.outlet, Out2);
        eye_int1[1].m_flow = -shell.outlet[1].m_flow;
        eye_int1[1].T = shell.summary.outlet[1].T - 273.15;
        eye_int1[1].s = shell.fluidOut[1].s / 1000;
        eye_int1[1].h = shell.summary.outlet[1].h / 1000;
        eye_int1[1].p = shell.summary.outlet[1].p / 100000;
        eye_int2[1].m_flow = -tubes.outlet.m_flow;
        eye_int2[1].T = tubes.summary.outlet.T - 273.15;
        eye_int2[1].s = tubes.fluidOut.s / 1000;
        eye_int2[1].h = tubes.summary.outlet.h / 1000;
        eye_int2[1].p = tubes.summary.outlet.p / 100000;
        connect(In1, shell.inlet[1]);
        connect(shell.outlet[1], Out1);
        connect(aux1, shell.inlet[2]);
        connect(aux2, shell.inlet[3]);
        connect(shell.heat[1], wall.outerPhase);
        connect(shell.heat[2], wall.outerPhase);
        connect(tubes.heat, wall.innerPhase);
        connect(eye_int2[1], eye2);
        connect(eye_int1[1], eye1);
      end HEXvle2vle_L3_2ph_BU_simple;

      model HEXvle2vle_L3_2ph_CH_simple  "VLE 2 VLE | L3 | 2 phase at shell side | Cylinder shape | Header type | simple HT" 
        extends ClaRa.Basics.Icons.HEX05;
        extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L3");
        outer ClaRa.SimCenter simCenter;

        model Outline  
          extends ClaRa.Basics.Icons.RecordIcon;
          parameter Boolean showExpertSummary = false;
          input Basics.Units.HeatFlowRate Q_flow "Heat flow rate";
          input Basics.Units.TemperatureDifference Delta_T_in "Fluid temperature at inlet T_1_in - T_2_in";
          input Basics.Units.TemperatureDifference Delta_T_out "Fluid temperature at outlet T_1_out - T_2_out";
          input Basics.Units.Length level_abs "Absolute filling level";
          input Real level_rel "relative filling level";
        end Outline;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          Outline outline;
        end Summary;

        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium_shell = simCenter.fluid1 "Medium to be used for shell flow";
        replaceable model HeatTransfer_Shell = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.ShellType_L3;
        replaceable model PressureLossShell = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L3;
        parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
        parameter Basics.Units.Length length = 10 "Length of the HEX";
        parameter Basics.Units.Length diameter = 3 "Diameter of HEX";
        parameter Basics.Units.Length z_in_shell = length / 2 "Inlet position from bottom";
        parameter .ClaRa.Basics.Units.Length z_in_aux1 = length / 2 "Inlet position of auxilliary1 from bottom";
        parameter .ClaRa.Basics.Units.Length z_in_aux2 = length / 2 "Inlet position of auxilliary2 from bottom";
        parameter Basics.Units.Length z_out_shell = length / 2 "Outlet position from bottom";
        parameter Basics.Units.Length radius_flange = 0.05 "Flange radius of all flanges";
        parameter Basics.Units.Mass mass_struc = 0 "Mass of inner structure elements, additional to the tubes itself";
        parameter Basics.Choices.GeometryOrientation orientation = ClaRa.Basics.Choices.GeometryOrientation.vertical "Orientation of the component";
        parameter Basics.Choices.GeometryOrientation flowOrientation = ClaRa.Basics.Choices.GeometryOrientation.vertical "Orientation of the mass flow";
        parameter Basics.Units.MassFlowRate m_flow_nom_shell = 10 "Nominal mass flow on shell side";
        parameter Basics.Units.Pressure p_nom_shell = 10 "Nominal pressure on shell side";
        parameter Basics.Units.EnthalpyMassSpecific h_nom_shell = 100e3 "Nominal specific enthalpy on shell side";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_liq_start = (-10) + TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium_shell, p_start_shell) "Start value of liquid specific enthalpy";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_vap_start = (+10) + TILMedia.VLEFluidFunctions.dewSpecificEnthalpy_pxi(medium_shell, p_start_shell) "Start value of vapour specific enthalpy";
        parameter Basics.Units.Pressure p_start_shell = 1e5 "Start value of shell fluid pressure";
        parameter Real level_rel_start = 0.5 "Start value for relative filling Level";
        inner parameter Integer initOptionShell = 211 "Type of initialisation";
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium_tubes = simCenter.fluid1 "Medium to be used for tubes flow";
        replaceable model HeatTransferTubes = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L2;
        replaceable model PressureLossTubes = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.NoFriction_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.TubeType_L2;
        parameter Basics.Units.Length diameter_i = 0.048 "Inner diameter of internal tubes";
        parameter Basics.Units.Length diameter_o = 0.05 "Outer diameter of internal tubes";
        parameter Basics.Units.Length length_tubes = 10 "Length of the tubes (one pass)";
        parameter Integer N_tubes = 1000 "Number of tubes";
        parameter Integer N_passes = 1 "Number of passes of the internal tubes";
        parameter Boolean parallelTubes = true "True, if tubes are parallel to shell flow orientation";
        parameter Basics.Units.Length z_in_tubes = length / 2 "Inlet position from bottom";
        parameter Basics.Units.Length z_out_tubes = length / 2 "Outlet position from bottom";
        parameter Boolean staggeredAlignment = true "True, if the tubes are aligned staggeredly";
        parameter Basics.Units.Length Delta_z_par = 2 * diameter_o "Distance between tubes parallel to flow direction (center to center)";
        parameter Basics.Units.Length Delta_z_ort = 2 * diameter_o "Distance between tubes orthogonal to flow direction (center to center)";
        parameter Integer N_rows = integer(ceil(sqrt(N_tubes)) * N_passes) "Number of pipe rows in shell flow direction";
        parameter Real CF_geo = 1 "Correction coefficient due to fins etc.";
        parameter Basics.Units.MassFlowRate m_flow_nom_tubes = 10 "Nominal mass flow on tubes side";
        parameter Basics.Units.Pressure p_nom_tubes = 10 "Nominal pressure on side tubes";
        parameter Basics.Units.EnthalpyMassSpecific h_nom_tubes = 10 "Nominal specific enthalpy on tubes side";
        parameter Basics.Units.HeatFlowRate Q_flow_nom = 1e6 "Nominal heat flow rate";
        parameter Basics.Units.EnthalpyMassSpecific h_start_tubes = 1e5 "Start value of tube fluid specific enthalpy";
        parameter Basics.Units.Pressure p_start_tubes = 1e5 "Start value of tube fluid pressure";
        parameter Integer initOptionTubes = 0 "Type of initialisation at tube side";
        replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Aluminum constrainedby TILMedia.SolidTypes.BaseSolid;
        parameter Basics.Units.Temperature[3] T_w_start = ones(3) * 293.15 "Initial wall temperature inner --> outer";
        parameter Integer initOptionWall = 0 "Init option of Tube wall";
        parameter Basics.Units.Time Tau_cond = 0.3 "Time constant of condensation";
        parameter Basics.Units.Time Tau_evap = 0.03 "Time constant of evaporation";
        parameter Basics.Units.CoefficientOfHeatTransfer alpha_ph = 50000 "HTC of the phase border";
        parameter Basics.Units.Area A_phaseBorder = shell.geo.A_hor * 100 "Heat transfer area at phase border";
        parameter Real expHT_phases = 0 "Exponent for volume dependency on inter phase HT";
        parameter Real absorbInflow = 1 "Absorption of incoming mass flow to the zones 1: perfect in the allocated zone, 0: perfect according to steam quality";
        parameter Boolean equalPressures = true "True if pressure in liquid and vapour phase is equal";
        parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of level calculation (table based)";
        parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
        parameter Boolean showData = true "True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
        parameter Boolean levelOutput = false "True, if Real level connector shall be addded";
        parameter Boolean outputAbs = false "True, if absolute level is at output";
        ClaRa.Basics.Interfaces.FluidPortIn In2(Medium = medium_tubes);
        ClaRa.Basics.Interfaces.FluidPortOut Out2(Medium = medium_tubes);
        ClaRa.Basics.Interfaces.FluidPortOut Out1(Medium = medium_shell);
        ClaRa.Basics.Interfaces.FluidPortIn In1(Medium = medium_shell);
        Basics.ControlVolumes.FluidVolumes.VolumeVLE_2 tubes(medium = medium_tubes, p_nom = p_nom_tubes, h_nom = h_nom_tubes, m_flow_nom = m_flow_nom_tubes, useHomotopy = useHomotopy, h_start = h_start_tubes, p_start = p_start_tubes, redeclare model HeatTransfer = HeatTransferTubes, redeclare model PressureLoss = PressureLossTubes, redeclare model PhaseBorder = ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.IdeallyStirred, showExpertSummary = showExpertSummary, redeclare model Geometry = Basics.ControlVolumes.Fundamentals.Geometry.PipeGeometry(final z_in = {z_in_tubes}, final z_out = {z_out_tubes}, final diameter = diameter_i, final N_tubes = N_tubes, final N_passes = N_passes, final length = length_tubes), initOption = initOptionTubes);
        ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_L3_TwoZonesNPort shell(medium = medium_shell, p_nom = p_nom_shell, redeclare model HeatTransfer = HeatTransfer_Shell, redeclare model PressureLoss = PressureLossShell, m_flow_nom = m_flow_nom_shell, useHomotopy = useHomotopy, p_start = p_start_shell, level_rel_start = level_rel_start, Tau_cond = Tau_cond, Tau_evap = Tau_evap, alpha_ph = alpha_ph, h_liq_start = h_liq_start, h_vap_start = h_vap_start, showExpertSummary = showExpertSummary, exp_HT_phases = expHT_phases, A_heat_ph = A_phaseBorder, heatSurfaceAlloc = 2, redeclare model PhaseBorder = Basics.ControlVolumes.Fundamentals.SpacialDistribution.RealSeparated(level_rel_start = level_rel_start, radius_flange = radius_flange, absorbInflow = absorbInflow, smoothness = smoothness), redeclare model Geometry = Basics.ControlVolumes.Fundamentals.Geometry.HollowCylinderWithTubes(final z_out = {z_out_shell}, final length = length, final N_tubes = N_tubes, final staggeredAlignment = staggeredAlignment, final Delta_z_par = Delta_z_par, final Delta_z_ort = Delta_z_ort, final diameter = diameter, final N_passes = N_passes, final length_tubes = length_tubes, final diameter_t = diameter_o, final N_inlet = 3, final z_in = {z_in_shell, z_in_aux1, z_in_aux2}, final orientation = orientation, final flowOrientation = flowOrientation, final N_rows = N_rows, final parallelTubes = parallelTubes, final N_baffle = 0, CF_geo = {1, CF_geo}), equalPressures = equalPressures, initOption = initOptionShell);
        ClaRa.Basics.ControlVolumes.SolidVolumes.CylindricalThickWall_L4 wall(redeclare replaceable model Material = WallMaterial, N_rad = 3, sizefunc = 1, diameter_o = diameter_o, diameter_i = diameter_i, N_tubes = N_tubes, T_start = T_w_start, length = length * N_passes, initOption = initOptionWall, mass_struc = mass_struc);
        Summary summary(outline(showExpertSummary = showExpertSummary, Q_flow = sum(shell.heat.Q_flow), Delta_T_in = shell.summary.inlet[1].T - tubes.summary.inlet.T, Delta_T_out = shell.summary.outlet[1].T - tubes.summary.outlet.T, level_abs = shell.phaseBorder.level_abs, level_rel = shell.phaseBorder.level_rel));
      protected
        Basics.Interfaces.EyeIn[1] eye_int2;
      public
        Basics.Interfaces.EyeOut eye2 if showData;
      protected
        Basics.Interfaces.EyeIn[1] eye_int1;
      public
        Basics.Interfaces.EyeOut eye1 if showData;
        Basics.Interfaces.FluidPortIn aux1(Medium = medium_shell);
        Basics.Interfaces.FluidPortIn aux2(Medium = medium_shell);
        Modelica.Blocks.Interfaces.RealOutput level = if outputAbs then summary.outline.level_abs else summary.outline.level_rel if levelOutput;
      equation
        assert(diameter_o > diameter_i, "Outer diameter of tubes must be greater than inner diameter");
        connect(tubes.inlet, In2);
        connect(tubes.outlet, Out2);
        eye_int1[1].m_flow = -shell.outlet[1].m_flow;
        eye_int1[1].T = shell.summary.outlet[1].T - 273.15;
        eye_int1[1].s = shell.fluidOut[1].s / 1000;
        eye_int1[1].h = shell.summary.outlet[1].h / 1000;
        eye_int1[1].p = shell.summary.outlet[1].p / 100000;
        eye_int2[1].m_flow = -tubes.outlet.m_flow;
        eye_int2[1].T = tubes.summary.outlet.T - 273.15;
        eye_int2[1].s = tubes.fluidOut.s / 1000;
        eye_int2[1].h = tubes.summary.outlet.h / 1000;
        eye_int2[1].p = tubes.summary.outlet.p / 100000;
        connect(In1, shell.inlet[1]);
        connect(shell.outlet[1], Out1);
        connect(aux1, shell.inlet[2]);
        connect(aux2, shell.inlet[3]);
        connect(shell.heat[1], wall.outerPhase);
        connect(shell.heat[2], wall.outerPhase);
        connect(tubes.heat, wall.innerPhase);
        connect(eye_int2[1], eye2);
        connect(eye_int1[1], eye1);
      end HEXvle2vle_L3_2ph_CH_simple;

      model HEXvle2vle_L3_2ph_CU_simple  "VLE 2 VLE | L3 | 2 phase at shell side | Cylinder shape | U-type | simple HT" 
        extends ClaRa.Basics.Icons.HEX04;
        extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L3");
        outer ClaRa.SimCenter simCenter;

        model Outline  
          extends ClaRa.Basics.Icons.RecordIcon;
          parameter Boolean showExpertSummary = false;
          input Basics.Units.HeatFlowRate Q_flow "Heat flow rate";
          input Basics.Units.TemperatureDifference Delta_T_in "Fluid temperature at inlet T_1_in - T_2_in";
          input Basics.Units.TemperatureDifference Delta_T_out "Fluid temperature at outlet T_1_out - T_2_out";
          input Basics.Units.Length level_abs "Absolute filling level";
          input Real level_rel "relative filling level";
        end Outline;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          Outline outline;
        end Summary;

        parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium_shell = simCenter.fluid1 "Medium to be used for shell side";
        replaceable model HeatTransfer_Shell = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.ShellType_L3;
        replaceable model PressureLossShell = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L3;
        parameter Basics.Units.Length length = 10 "Length of the HEX";
        parameter Basics.Units.Length diameter = 3 "Diameter of HEX";
        parameter Basics.Choices.GeometryOrientation orientation = ClaRa.Basics.Choices.GeometryOrientation.vertical "Orientation of the component";
        parameter Basics.Choices.GeometryOrientation flowOrientation = ClaRa.Basics.Choices.GeometryOrientation.vertical "Flow orientation at shell side";
        final parameter Boolean parallelTubes = if orientation == flowOrientation and N_baffle == 0 then true elseif orientation <> flowOrientation and N_baffle == 0 then true else false "True if tues are parallel to shell flow orientation";
        parameter Basics.Units.Length z_in_shell = length / 2 "Inlet position from bottom";
        parameter .ClaRa.Basics.Units.Length z_in_aux1 = length / 2 "Inlet position of auxilliary1 from bottom";
        parameter .ClaRa.Basics.Units.Length z_in_aux2 = length / 2 "Inlet position of auxilliary2 from bottom";
        parameter Basics.Units.Length z_out_shell = length / 2 "Outlet position from bottom";
        parameter .ClaRa.Basics.Units.Length radius_flange = 0.05 "Flange radius";
        parameter Integer N_baffle = 0 "Number of baffles at shell side";
        parameter Basics.Units.Mass mass_struc = 0 "Mass of inner structure elements, additional to the tubes itself";
        parameter Basics.Units.MassFlowRate m_flow_nom_shell = 10 "Nominal mass flow at shell side";
        parameter Basics.Units.Pressure p_nom_shell = 10 "Nominal pressure at shell side";
        parameter Basics.Units.EnthalpyMassSpecific h_nom_shell = 100e3 "Nominal specific enthalpy at shell side";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_liq_start = (-10) + TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium_shell, p_start_shell) "Start value of liquid specific enthalpy";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_vap_start = (+10) + TILMedia.VLEFluidFunctions.dewSpecificEnthalpy_pxi(medium_shell, p_start_shell) "Start value of vapour specific enthalpy";
        parameter Basics.Units.Pressure p_start_shell = 1e5 "Start value of shell fluid pressure";
        parameter Real level_rel_start = 0.5 "Start value for relative filling Level";
        inner parameter Integer initOptionShell = 211 "Type of initialisation";
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium_tubes = simCenter.fluid1 "Medium to be used for tubes";
        replaceable model HeatTransferTubes = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.TubeType_L2;
        replaceable model PressureLossTubes = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.NoFriction_L2 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.TubeType_L2;
        parameter ClaRa.Basics.Units.Length diameter_i = 0.048 "Inner diameter of horizontal tubes";
        parameter ClaRa.Basics.Units.Length diameter_o = 0.05 "Outer diameter of horizontal tubes";
        parameter ClaRa.Basics.Units.Length length_tubes = 10 "Length of the tubes (one pass)";
        parameter Integer N_tubes = 1000 "Number of horizontal tubes";
        parameter Integer N_passes = 1 "Number of passes of the internal tubes";
        parameter ClaRa.Basics.Units.Length z_in_tubes = length / 2 "Inlet position from bottom";
        parameter ClaRa.Basics.Units.Length z_out_tubes = length / 2 "Outlet position from bottom";
        parameter Boolean staggeredAlignment = true "True, if the tubes are aligned staggeredly";
        parameter ClaRa.Basics.Units.Length Delta_z_par = 2 * diameter_o "Distance between tubes parallel to flow direction (center to center)";
        parameter ClaRa.Basics.Units.Length Delta_z_ort = 2 * diameter_o "Distance between tubes orthogonal to flow direction (center to center)";
        parameter Integer N_rows = integer(ceil(sqrt(N_tubes)) * N_passes) "Number of pipe rows in shell flow direction";
        parameter Real CF_geo = 1 "Correction coefficient due to fins etc.";
        parameter ClaRa.Basics.Units.MassFlowRate m_flow_nom_tubes = 10 "Nominal mass flow on tube side";
        parameter ClaRa.Basics.Units.Pressure p_nom_tubes = 10 "Nominal pressure on tube side";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_nom_tubes = 10 "Nominal specific enthalpy on tube side";
        parameter ClaRa.Basics.Units.HeatFlowRate Q_flow_nom = 1e6 "Nominal heat flow rate";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_start_tubes = 1e5 "Start value of tube fluid specific enthalpy";
        parameter ClaRa.Basics.Units.Pressure p_start_tubes = 1e5 "Start value of tube fluid pressure";
        parameter Integer initOptionTubes = 0 "Type of initialisation at tube side";
        replaceable model WallMaterial = TILMedia.SolidTypes.TILMedia_Aluminum constrainedby TILMedia.SolidTypes.BaseSolid;
        parameter ClaRa.Basics.Units.Temperature[3] T_w_start = ones(3) * 293.15 "Initial temperature at outer phase";
        parameter Integer initOptionWall = 0 "Init Option of Wall";
        parameter ClaRa.Basics.Units.Time Tau_cond = 0.3 "Time constant of condensation";
        parameter ClaRa.Basics.Units.Time Tau_evap = 0.03 "Time constant of evaporation";
        parameter ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_ph = 50000 "HTC of the phase border";
        parameter ClaRa.Basics.Units.Area A_phaseBorder = shell.geo.A_hor * 100 "Heat transfer area at phase border";
        parameter Real expHT_phases = 0 "Exponent for volume dependency on inter phase HT";
        parameter Real absorbInflow = 1 "Absorption of incoming mass flow to the zones 1: perfect in the allocated zone, 0: perfect according to steam quality";
        parameter Boolean equalPressures = true "True if pressure in liquid and vapour phase is equal";
        parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of level calculation (table based)";
        parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
        parameter Boolean showData = true "True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
        parameter Boolean levelOutput = false "True, if Real level connector shall be addded";
        parameter Boolean outputAbs = false "True, if absolute level is at output";
        ClaRa.Basics.Interfaces.FluidPortIn In2(Medium = medium_tubes);
        ClaRa.Basics.Interfaces.FluidPortOut Out2(Medium = medium_tubes);
        ClaRa.Basics.Interfaces.FluidPortOut Out1(Medium = medium_shell);
        ClaRa.Basics.Interfaces.FluidPortIn In1(Medium = medium_shell);
        ClaRa.Basics.Interfaces.FluidPortIn aux1(Medium = medium_shell);
        ClaRa.Basics.Interfaces.FluidPortIn aux2(Medium = medium_shell);
        ClaRa.Components.Adapters.Scalar2VectorHeatPort reallocateHeatFlows(N = 2, final equalityMode = "Equal Temperatures");
        ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_2 tubes(final medium = medium_tubes, final p_nom = p_nom_tubes, final h_nom = h_nom_tubes, final m_flow_nom = m_flow_nom_tubes, final useHomotopy = useHomotopy, final h_start = h_start_tubes, final p_start = p_start_tubes, redeclare model PressureLoss = PressureLossTubes, final showExpertSummary = showExpertSummary, redeclare model HeatTransfer = HeatTransferTubes, redeclare model PhaseBorder = Basics.ControlVolumes.Fundamentals.SpacialDistribution.IdeallyStirred, redeclare model Geometry = Basics.ControlVolumes.Fundamentals.Geometry.PipeGeometry(final z_in = {z_in_tubes}, final z_out = {z_out_tubes}, final diameter = diameter_i, final N_tubes = N_tubes, final N_passes = N_passes, final length = length_tubes), initOption = initOptionTubes);
        ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_L3_TwoZonesNPort shell(final medium = medium_shell, final p_nom = p_nom_shell, redeclare model HeatTransfer = HeatTransfer_Shell, redeclare model PressureLoss = PressureLossShell, final m_flow_nom = m_flow_nom_shell, final useHomotopy = useHomotopy, final p_start = p_start_shell, final level_rel_start = level_rel_start, final Tau_cond = Tau_cond, final Tau_evap = Tau_evap, final alpha_ph = alpha_ph, final h_liq_start = h_liq_start, final h_vap_start = h_vap_start, final showExpertSummary = showExpertSummary, final A_heat_ph = A_phaseBorder, final exp_HT_phases = expHT_phases, final heatSurfaceAlloc = 2, redeclare model PhaseBorder = Basics.ControlVolumes.Fundamentals.SpacialDistribution.RealSeparated(level_rel_start = level_rel_start, final radius_flange = radius_flange, final absorbInflow = absorbInflow, final smoothness = smoothness), redeclare model Geometry = Basics.ControlVolumes.Fundamentals.Geometry.HollowCylinderWithTubes(final z_out = {z_out_shell}, final length = length, final N_tubes = N_tubes, final z_in = {z_in_shell, z_in_aux1, z_in_aux2}, final staggeredAlignment = staggeredAlignment, final Delta_z_par = Delta_z_par, final Delta_z_ort = Delta_z_ort, final diameter = diameter, final N_passes = N_passes, final length_tubes = length_tubes, final diameter_t = diameter_o, final N_baffle = N_baffle, final N_rows = N_rows, final N_inlet = 3, final orientation = orientation, final parallelTubes = parallelTubes, final CF_geo = {1, CF_geo}, final flowOrientation = flowOrientation), equalPressures = equalPressures, initOption = initOptionShell);
        ClaRa.Basics.ControlVolumes.SolidVolumes.CylindricalThickWall_L4 wall(redeclare replaceable model Material = WallMaterial, diameter_i = diameter_i, N_tubes = N_tubes, diameter_o = diameter_o, initOption = initOptionWall, length = length_tubes * N_passes, N_rad = 3, sizefunc = 1, T_start = T_w_start, mass_struc = mass_struc) "{shell.heattransfer.alpha[2],shell.heattransfer.alpha[2],shell.heattransfer.alpha[1]}";
        Summary summary(outline(showExpertSummary = showExpertSummary, Q_flow = sum(shell.heat.Q_flow), Delta_T_in = shell.summary.inlet[1].T - tubes.summary.inlet.T, Delta_T_out = shell.summary.outlet[1].T - tubes.summary.outlet.T, level_abs = shell.phaseBorder.level_abs, level_rel = shell.phaseBorder.level_rel));
        ClaRa.Basics.Interfaces.EyeOut eye2 if showData;
        ClaRa.Basics.Interfaces.EyeOut eye1 if showData;
      protected
        ClaRa.Basics.Interfaces.EyeIn[1] eye_int1;
        ClaRa.Basics.Interfaces.EyeIn[1] eye_int2;
      public
        Modelica.Blocks.Interfaces.RealOutput level = if outputAbs then shell.summary.outline.level_abs else shell.summary.outline.level_rel if levelOutput;
      equation
        assert(diameter_o > diameter_i, "Outer diameter of tubes must be greater than inner diameter");
        eye_int1[1].m_flow = -shell.outlet[1].m_flow;
        eye_int1[1].T = shell.summary.outlet[1].T - 273.15;
        eye_int1[1].s = shell.fluidOut[1].s / 1000;
        eye_int1[1].h = shell.summary.outlet[1].h / 1000;
        eye_int1[1].p = shell.summary.outlet[1].p / 100000;
        eye_int2[1].m_flow = -tubes.outlet.m_flow;
        eye_int2[1].T = tubes.summary.outlet.T - 273.15;
        eye_int2[1].s = tubes.fluidOut.s / 1000;
        eye_int2[1].h = tubes.summary.outlet.h / 1000;
        eye_int2[1].p = tubes.summary.outlet.p / 100000;
        connect(tubes.inlet, In2);
        connect(tubes.outlet, Out2);
        connect(eye_int1[1], eye1);
        connect(eye_int2[1], eye2);
        connect(In1, shell.inlet[1]);
        connect(shell.outlet[1], Out1);
        connect(aux1, shell.inlet[2]);
        connect(aux2, shell.inlet[3]);
        connect(wall.innerPhase, tubes.heat);
        connect(reallocateHeatFlows.heatScalar, wall.outerPhase);
        connect(reallocateHeatFlows.heatVector, shell.heat);
      end HEXvle2vle_L3_2ph_CU_simple;
    end HeatExchangers;

    package VolumesValvesFittings  "All kinds of tube-shaped components" 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      package Pipes  "Models for tube-like elements" 
        extends ClaRa.Basics.Icons.PackageIcons.Components60;

        model PipeFlowVLE_L4_Simple  "A 1D tube-shaped control volume considering one-phase and two-phase heat transfer in a straight pipe with static momentum balance and simple energy balance." 
          extends Basics.ControlVolumes.FluidVolumes.VolumeVLE_L4(redeclare model Geometry = ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.PipeGeometry_N_cv(z_in = z_in, z_out = z_out, N_tubes = N_tubes, N_cv = N_cv, diameter = diameter_i, length = length, Delta_x = Delta_x, N_passes = N_passes));
          extends ClaRa.Basics.Icons.Pipe_L4;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L4");
          ClaRa.Basics.Interfaces.Connected2SimCenter connected2SimCenter(powerIn = noEvent(if sum(heat.Q_flow) > 0 then sum(heat.Q_flow) else 0), powerOut = if not heatFlowIsLoss then -sum(heat.Q_flow) else 0, powerAux = 0) if contributeToCycleSummary;
          parameter Basics.Units.Length length = 1 "Length of the pipe (one pass)";
          parameter Basics.Units.Length diameter_i = 0.1 "Inner diameter of the pipe";
          parameter Basics.Units.Length z_in = 0.1 "Height of inlet above ground";
          parameter Basics.Units.Length z_out = 0.1 "Height of outlet above ground";
          parameter Integer N_tubes = 1 "Number Of parallel pipes";
          parameter Integer N_passes = 1 "Number of passes of the tubes";
          parameter Integer N_cv(min = 3) = 3 "Number of finite volumes";
          parameter Basics.Units.Length[N_cv] Delta_x = ClaRa.Basics.Functions.GenerateGrid({0}, length * N_passes, N_cv) "Discretisation scheme";
          parameter Boolean contributeToCycleSummary = simCenter.contributeToCycleSummary "True if component shall contribute to automatic efficiency calculation";
          parameter Boolean heatFlowIsLoss = true "True if negative heat flow is a loss (not a process product)";
        protected
          Basics.Interfaces.EyeIn[1] eye_int;
        public
          Basics.Interfaces.EyeOut eye if showData;
        equation
          assert(abs(z_out - z_in) <= length, "Length of pipe less than vertical height");
          eye_int[1].m_flow = -outlet.m_flow;
          eye_int[1].T = fluidOutlet.T - 273.15;
          eye_int[1].s = fluidOutlet.s / 1e3;
          eye_int[1].p = outlet.p / 1e5;
          eye_int[1].h = noEvent(actualStream(outlet.h_outflow)) / 1e3;
          connect(eye_int[1], eye);
        end PipeFlowVLE_L4_Simple;
      end Pipes;

      package Valves  
        extends ClaRa.Basics.Icons.PackageIcons.Components60;

        package Fundamentals  "valve fundamental models based on the iCom concept" 
          extends ClaRa.Basics.Icons.PackageIcons.Components50;

          partial model GenericPressureLoss  
            extends ClaRa.Basics.Icons.Delta_p;
            parameter Real[:, :] CL_valve = [0, 0; 1, 1] "|Valve Characteristics|Effective apperture as function of valve position in p.u.";
            outer ClaRa.Components.VolumesValvesFittings.Valves.Fundamentals.ICom iCom;
            outer Boolean checkValve;
            outer Boolean useHomotopy;
            .ClaRa.Basics.Units.MassFlowRate m_flow;
            Real aperture_ "Effective apperture";
            Modelica.Blocks.Tables.CombiTable1D ValveCharacteristics(table = CL_valve, columns = {2});
            .ClaRa.Basics.Units.PressureDifference Delta_p "Pressure difference p_in - p_out";
            Real gamma "Heat capacity ratio at actual inlet";
          equation
            ValveCharacteristics.u[1] = noEvent(min(1, max(iCom.opening_, iCom.opening_leak_)));
            aperture_ = noEvent(max(0, ValveCharacteristics.y[1]));
            Delta_p = iCom.p_in - iCom.p_out;
          end GenericPressureLoss;

          model LinearNominalPoint  "Linear|Nominal operation point | subcritical flow" 
            extends ClaRa.Components.VolumesValvesFittings.Valves.Fundamentals.GenericPressureLoss;
            parameter .ClaRa.Basics.Units.PressureDifference Delta_p_nom = 1e5 "|Valve Characteristics|Nominal pressure difference for Kv definition";
            parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 1 "|Valve Characteristics|Nominal mass flow rate";
          equation
            gamma = 2e30 "is not used";
            m_flow = if checkValve then .ClaRa.Basics.Functions.Stepsmoother(50, 0, Delta_p) * aperture_ * m_flow_nom * Delta_p / Delta_p_nom else aperture_ * m_flow_nom * Delta_p / Delta_p_nom;
          end LinearNominalPoint;

          model QuadraticKV  "Quadratic|Kv definition | subcritical flow" 
            extends ClaRa.Components.VolumesValvesFittings.Valves.Fundamentals.GenericPressureLoss;
            parameter Real Kvs(unit = "m3/h") = 1 "|Valve Characteristics|Flow Coefficient at nominal opening (Delta_p_nom = 1e5 Pa, rho_nom=1000 kg/m^3(cold water))";
            Real Kv(unit = "m3/h") "|Valve Characteristics|Flow Coefficient (Delta_p_nom = 1e5 Pa, rho_nom=1000 kg/m^3(cold water))";
            parameter .ClaRa.Basics.Units.Pressure Delta_p_eps = 100 "|Expert Settings||Small pressure difference for linearisation around zero flow";
          equation
            gamma = 2e30 "is not used";
            Kv = aperture_ * Kvs;
            m_flow = if checkValve then .ClaRa.Basics.Functions.Stepsmoother(Delta_p_eps / 10, 0, Delta_p) * Kv / 3600 * iCom.rho_in * ClaRa.Basics.Functions.ThermoRoot(Delta_p / 1e5, Delta_p_eps / 1e5) * sqrt(1000 / iCom.rho_in) else Kv / 3600 * iCom.rho_in * ClaRa.Basics.Functions.ThermoRoot(Delta_p / 1e5, Delta_p_eps / 1e5) * sqrt(1000 / iCom.rho_in);
          end QuadraticKV;

          model QuadraticNominalPoint  "Quadratic|Nominal operation point | subcritical flow" 
            extends ClaRa.Components.VolumesValvesFittings.Valves.Fundamentals.GenericPressureLoss;
            final parameter Real Kvs(unit = "m3/h") = 3600 * m_flow_nom / rho_in_nom * sqrt(rho_in_nom / 1000 * 1e5 / Delta_p_nom) "|Valve Characteristics|Flow Coefficient at nominal opening (Delta_p_nom = 1e5 Pa, rho_nom=1000 kg/m^3(cold water))";
            Real Kv(unit = "m3/h") "|Valve Characteristics|Flow Coefficient (Delta_p_nom = 1e5 Pa, rho_nom=1000 kg/m^3(cold water))";
            parameter .ClaRa.Basics.Units.Pressure Delta_p_eps = 100 "|Expert Settings||Small pressure difference for linearisation around zeor flow";
            parameter .ClaRa.Basics.Units.Pressure Delta_p_nom = 1e5 "|Valve Characteristics|Nominal pressure difference for Kv definition";
            parameter .ClaRa.Basics.Units.DensityMassSpecific rho_in_nom = 1000 "|Valve Characteristics|Nominal density for Kv definition";
            parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 1 "|Valve Characteristics|Nominal mass flow rate";
          equation
            gamma = 2e30 "is not used";
            Kv = aperture_ * Kvs;
            m_flow = if checkValve then .ClaRa.Basics.Functions.Stepsmoother(Delta_p_eps / 10, 0, Delta_p) * Kv / 3600 * iCom.rho_in * ClaRa.Basics.Functions.ThermoRoot(Delta_p / 1e5, Delta_p_eps / 1e5) * sqrt(1000 / max(1e-3, iCom.rho_in)) else Kv / 3600 * iCom.rho_in * ClaRa.Basics.Functions.ThermoRoot(Delta_p / 1e5, Delta_p_eps / 1e5) * sqrt(1000 / max(1e-3, iCom.rho_in));
          end QuadraticNominalPoint;

          record ICom  
            extends ClaRa.Basics.Icons.IComIcon;
            .ClaRa.Basics.Units.Pressure p_in "Inlet pressure";
            .ClaRa.Basics.Units.Pressure p_out "Outlet pressure";
            Real opening_ "Opening of the valve (p.u.)";
            .ClaRa.Basics.Units.DensityMassSpecific rho_in "Inlet density";
            Real gamma_in "Heat capacity ratio at inlet";
            Real gamma_out "Heat capacity ratio at outlet";
            Real opening_leak_;
            .ClaRa.Basics.Units.EnthalpyMassSpecific h_in "Inlet enthalpy";
          end ICom;
        end Fundamentals;

        model ValveVLE_L1  "Valve for VLE fluid flows with replaceable flow models" 
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L1");

          model Outline  
            extends ClaRa.Basics.Icons.RecordIcon;
            parameter Boolean showExpertSummary;
            input .ClaRa.Basics.Units.VolumeFlowRate V_flow "Volume flow rate";
            input .ClaRa.Basics.Units.PressureDifference Delta_p "Pressure difference p_out - p_in";
            input Real PR if showExpertSummary "Pressure ration p_out/p_in";
            input Real PR_crit if showExpertSummary "Critical pressure ratio";
            input Real opening_ "Valve opening in p.u.";
            input Boolean isSuperCritical;
          end Outline;

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            Outline outline;
            ClaRa.Basics.Records.FlangeVLE inlet;
            ClaRa.Basics.Records.FlangeVLE outlet;
          end Summary;

          inner parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
          replaceable model PressureLoss = ClaRa.Components.VolumesValvesFittings.Valves.Fundamentals.QuadraticKV constrainedby ClaRa.Components.VolumesValvesFittings.Valves.Fundamentals.GenericPressureLoss;
          inner parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
          parameter Boolean openingInputIsActive = false "True, if  a variable opening is used";
          parameter Real opening_const_ = 1 "A constant opening: =1: open, =0: closed";
          inner parameter Boolean checkValve = false "True, if valve is check valve" annotation(Evaluate = true);
          parameter Boolean showExpertSummary = simCenter.showExpertSummary "|Summary and Visualisation||True, if expert summary should be applied";
          parameter Boolean showData = true "|Summary and Visualisation||True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
          parameter Boolean useStabilisedMassFlow = false "|Expert Settings|Numerical Robustness|";
          input .ClaRa.Basics.Units.Time Tau = 0.1 "Time Constant of Stabilisation";
          input Real opening_leak_ = 0 "Leakage valve opening in p.u.";
          outer ClaRa.SimCenter simCenter;
        protected
          Real opening_ "Valve opening in p.u.";
          .ClaRa.Basics.Units.MassFlowRate m_flow_ "stabilised mass flow rate";
        public
          Modelica.Blocks.Interfaces.RealInput opening_in = opening_ if openingInputIsActive "=1: completely open, =0: completely closed";
          ClaRa.Basics.Interfaces.FluidPortIn inlet(Medium = medium) "Inlet port";
          ClaRa.Basics.Interfaces.FluidPortOut outlet(Medium = medium) "Outlet port";
        protected
          TILMedia.VLEFluid_ph fluidOut(p = outlet.p, vleFluidType = medium, h = if checkValve == true and opening_leak_ <= 0 or opening_ < opening_leak_ then outlet.h_outflow else noEvent(actualStream(outlet.h_outflow)), xi = if checkValve == true and opening_leak_ <= 0 or opening_ < opening_leak_ then outlet.xi_outflow else noEvent(actualStream(outlet.xi_outflow)));
        public
          PressureLoss pressureLoss;
        protected
          TILMedia.VLEFluid_ph fluidIn(vleFluidType = medium, p = inlet.p, h = if checkValve == true and opening_leak_ <= 0 or opening_ < opening_leak_ then inStream(inlet.h_outflow) else noEvent(actualStream(inlet.h_outflow)), xi = if checkValve == true and opening_leak_ <= 0 or opening_ < opening_leak_ then inStream(inlet.xi_outflow) else noEvent(actualStream(inlet.xi_outflow)));
        public
          Summary summary(outline(showExpertSummary = showExpertSummary, V_flow = inlet.m_flow / iCom.rho_in, Delta_p = pressureLoss.Delta_p, PR = outlet.p / inlet.p, PR_crit = (2 / (pressureLoss.gamma + 1)) ^ (pressureLoss.gamma / (max(1e-3, pressureLoss.gamma) - 1)), isSuperCritical = outlet.p / inlet.p < (2 / (pressureLoss.gamma + 1)) ^ (pressureLoss.gamma / (max(1e-3, pressureLoss.gamma) - 1)), opening_ = iCom.opening_), inlet(showExpertSummary = showExpertSummary, m_flow = inlet.m_flow, T = fluidIn.T, p = inlet.p, h = fluidIn.h, s = fluidIn.s, steamQuality = fluidIn.q, H_flow = fluidIn.h * inlet.m_flow, rho = fluidIn.d), outlet(showExpertSummary = showExpertSummary, m_flow = -outlet.m_flow, T = fluidOut.T, p = outlet.p, h = fluidOut.h, s = fluidOut.s, steamQuality = fluidOut.q, H_flow = -fluidOut.h * outlet.m_flow, rho = fluidOut.d));
        protected
          inner Fundamentals.ICom iCom(p_in = inlet.p, p_out = outlet.p, opening_leak_ = opening_leak_, rho_in(start = 1) = if checkValve == true and opening_leak_ <= 0 or opening_ < opening_leak_ then fluidIn.d else if useHomotopy then homotopy(ClaRa.Basics.Functions.Stepsmoother(10, -10, pressureLoss.Delta_p) * fluidIn.d + ClaRa.Basics.Functions.Stepsmoother(-10, 10, pressureLoss.Delta_p) * fluidOut.d, fluidIn.d) else ClaRa.Basics.Functions.Stepsmoother(10, -10, pressureLoss.Delta_p) * fluidIn.d + ClaRa.Basics.Functions.Stepsmoother(-10, 10, pressureLoss.Delta_p) * fluidOut.d, gamma_in = fluidIn.gamma, gamma_out = fluidOut.gamma, opening_ = opening_, h_in = fluidIn.h) "if (checkValve == true and opening_leak_<=0) or opening_<opening_leak_ then fluidIn.d else (if useHomotopy then homotopy(ClaRa.Basics.Functions.Stepsmoother(1e-5, -1e-5, inlet.m_flow)*fluidIn.d + ClaRa.Basics.Functions.Stepsmoother(-1e-5, 1e-5, inlet.m_flow)*fluidOut.d, fluidIn.d) else ClaRa.Basics.Functions.Stepsmoother(1e-5, -1e-5, inlet.m_flow)*fluidIn.d + ClaRa.Basics.Functions.Stepsmoother(-1e-5, 1e-5, inlet.m_flow)*fluidOut.d)";
        public
          Basics.Interfaces.EyeOut eye if showData;
        protected
          Basics.Interfaces.EyeIn[1] eye_int;
        initial equation
          if useStabilisedMassFlow then
            m_flow_ = pressureLoss.m_flow;
          end if;
        equation
          if not openingInputIsActive then
            opening_ = noEvent(min(1, max(opening_leak_, opening_const_)));
          end if;
          if useStabilisedMassFlow then
            der(m_flow_) = (pressureLoss.m_flow - m_flow_) / Tau;
          else
            m_flow_ = pressureLoss.m_flow;
          end if;
          inlet.h_outflow = inStream(outlet.h_outflow);
          outlet.h_outflow = inStream(inlet.h_outflow);
          inlet.m_flow + outlet.m_flow = 0;
          inlet.m_flow = m_flow_;
          inlet.xi_outflow = inStream(outlet.xi_outflow);
          outlet.xi_outflow = inStream(inlet.xi_outflow);
          eye_int[1].m_flow = -outlet.m_flow;
          eye_int[1].T = fluidOut.T - 273.15;
          eye_int[1].s = fluidOut.s / 1e3;
          eye_int[1].p = outlet.p / 1e5;
          eye_int[1].h = fluidOut.h / 1e3;
          connect(eye, eye_int[1]);
        end ValveVLE_L1;
      end Valves;

      package Fittings  "Bends, T-connectors,..." 
        extends ClaRa.Basics.Icons.PackageIcons.Components60;

        package Fundamentals  
          extends ClaRa.Basics.Icons.PackageIcons.Components50;

          model BaseDp  
            extends ClaRa.Basics.Icons.Delta_p;
          end BaseDp;

          model Linear  
            extends Fundamentals.BaseDp;
            .ClaRa.Basics.Units.Pressure dp;
            .ClaRa.Basics.Units.MassFlowRate m_flow;
            parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 10;
            parameter .ClaRa.Basics.Units.Pressure dp_nom = 1000 "Nominal pressure loss";
          equation
            m_flow = m_flow_nom * dp / dp_nom;
          end Linear;

          model NoFriction  
            extends Fundamentals.BaseDp;
            .ClaRa.Basics.Units.Pressure dp;
            .ClaRa.Basics.Units.MassFlowRate m_flow;
          equation
            dp = 0;
          end NoFriction;
        end Fundamentals;

        model JoinVLE_L2_Y  "A join for two inputs" 
          extends ClaRa.Basics.Icons.Tpipe;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L2");
          outer ClaRa.SimCenter simCenter;

          model Outline  
            extends ClaRa.Basics.Icons.RecordIcon;
            input ClaRa.Basics.Units.Volume volume_tot "Total volume";
          end Outline;

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            Outline outline;
            ClaRa.Basics.Records.FlangeVLE inlet1;
            ClaRa.Basics.Records.FlangeVLE inlet2;
            ClaRa.Basics.Records.FlangeVLE outlet;
            ClaRa.Basics.Records.FluidVLE_L2 fluid;
          end Summary;

          parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
          replaceable model PressureLossIn1 = Fundamentals.NoFriction constrainedby Fundamentals.BaseDp;
          replaceable model PressureLossIn2 = Fundamentals.NoFriction constrainedby Fundamentals.BaseDp;
          replaceable model PressureLossOut = Fundamentals.NoFriction constrainedby Fundamentals.BaseDp;
          parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
          parameter .ClaRa.Basics.Units.Volume volume(min = 1e-6) = 0.1 "System Volume";
          parameter .ClaRa.Basics.Units.MassFlowRate[2] m_flow_in_nom = {10, 10} "Nominal mass flow rates at inlet";
          parameter .ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal pressure";
          parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_nom = 1e5 "Nominal specific enthalpy";
          parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_start = 1e5 "Start value of sytsem specific enthalpy";
          parameter .ClaRa.Basics.Units.Pressure p_start = 1e5 "Start value of sytsem pressure";
          parameter ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_start = medium.xi_default "Start value for mass fraction";
          parameter Integer initOption = 0 "Type of initialisation";
          parameter Boolean showExpertSummary = simCenter.showExpertSummary "|Summary and Visualisation||True, if expert summary should be applied";
          parameter Boolean showData = true "|Summary and Visualisation||True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
          parameter Boolean preciseTwoPhase = true "|Expert Stettings||True, if two-phase transients should be capured precisely";
        protected
          parameter .ClaRa.Basics.Units.DensityMassSpecific rho_nom = TILMedia.VLEFluidFunctions.density_phxi(medium, p_nom, h_nom) "Nominal density";
          .ClaRa.Basics.Units.Power Hdrhodt = if preciseTwoPhase then h * volume * drhodt else 0 "h*volume*drhodt";
          Real[medium.nc - 1] Xidrhodt = if preciseTwoPhase then xi * volume * drhodt else zeros(medium.nc - 1) "h*volume*drhodt";
        public
          .ClaRa.Basics.Units.EnthalpyFlowRate[2] H_flow_in;
          .ClaRa.Basics.Units.EnthalpyFlowRate H_flow_out;
          .ClaRa.Basics.Units.EnthalpyMassSpecific h(start = h_start);
          .ClaRa.Basics.Units.Mass mass "Total system mass";
          Real drhodt;
          .ClaRa.Basics.Units.Pressure p(start = p_start, stateSelect = StateSelect.prefer) "System pressure";
          ClaRa.Basics.Units.MassFlowRate[2, medium.nc - 1] Xi_flow_in "Mass fraction flows at inlet";
          ClaRa.Basics.Units.MassFlowRate[medium.nc - 1] Xi_flow_out "Mass fraction flows at outlet";
          ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi(start = xi_start) "Mass fraction";
          Summary summary(outline(volume_tot = volume), inlet1(showExpertSummary = showExpertSummary, m_flow = inlet1.m_flow, T = fluidIn1.T, p = inlet1.p, h = fluidIn1.h, s = fluidIn1.s, steamQuality = fluidIn1.q, H_flow = fluidIn1.h * inlet1.m_flow, rho = fluidIn1.d), inlet2(showExpertSummary = showExpertSummary, m_flow = inlet2.m_flow, T = fluidIn2.T, p = inlet2.p, h = fluidIn2.h, s = fluidIn2.s, steamQuality = fluidIn2.q, H_flow = fluidIn2.h * inlet2.m_flow, rho = fluidIn2.d), fluid(showExpertSummary = showExpertSummary, mass = mass, p = p, h = h, T = bulk.T, s = bulk.s, steamQuality = bulk.q, H = h * mass, rho = bulk.d, T_sat = bulk.VLE.T_l, h_dew = bulk.VLE.h_v, h_bub = bulk.VLE.h_l), outlet(showExpertSummary = showExpertSummary, m_flow = -outlet.m_flow, T = fluidOut.T, p = outlet.p, h = fluidOut.h, s = fluidOut.s, steamQuality = fluidOut.q, H_flow = -fluidOut.h * outlet.m_flow, rho = fluidOut.d));
          PressureLossIn1 pressureLossIn1;
          PressureLossIn2 pressureLossIn2;
          PressureLossOut pressureLossOut;
          ClaRa.Basics.Interfaces.FluidPortIn inlet1(each Medium = medium) "First inlet port";
          ClaRa.Basics.Interfaces.FluidPortOut outlet(Medium = medium) "Outlet port";
        protected
          TILMedia.VLEFluid_ph bulk(each vleFluidType = medium, p = outlet.p, h = h);
        public
          ClaRa.Basics.Interfaces.EyeOut eye if showData;
        protected
          ClaRa.Basics.Interfaces.EyeIn[1] eye_int;
        public
          ClaRa.Basics.Interfaces.FluidPortIn inlet2(each Medium = medium) "First inlet port";
        protected
          TILMedia.VLEFluid_ph fluidIn1(each vleFluidType = medium, h = noEvent(actualStream(inlet1.h_outflow)), p = inlet1.p);
          TILMedia.VLEFluid_ph fluidIn2(each vleFluidType = medium, h = noEvent(actualStream(inlet2.h_outflow)), p = inlet2.p);
          TILMedia.VLEFluid_ph fluidOut(each vleFluidType = medium, h = noEvent(actualStream(outlet.h_outflow)), p = outlet.p);
        initial equation
          if initOption == 208 then
            der(h) = 0;
            der(p) = 0;
          elseif initOption == 1 then
            der(h) = 0;
            der(p) = 0;
          elseif initOption == 201 then
            der(p) = 0;
          elseif initOption == 202 then
            der(h) = 0;
          elseif initOption == 0 then
          else
            assert(false, "Unknown initialisation type in " + getInstanceName());
          end if;
        equation
          assert(volume > 0, "The system volume must be greater than zero!");
          mass = if useHomotopy then volume * homotopy(bulk.d, rho_nom) else volume * bulk.d;
          drhodt * volume = inlet1.m_flow + inlet2.m_flow + outlet.m_flow "Mass balance";
          drhodt = der(p) * bulk.drhodp_hxi + der(h) * bulk.drhodh_pxi + sum(der(xi) .* bulk.drhodxi_ph);
          der(h) = 1 / mass * (sum(H_flow_in) + H_flow_out + volume * der(p) - Hdrhodt) "Energy balance, decoupled from the mass balance to avoid heavy mass fluctuations during phase change or flow reversal. The term '-h*volume*drhodt' is ommited";
          der(xi) = {(sum(Xi_flow_in[:, i]) + Xi_flow_out[i] - Xidrhodt[i]) / mass for i in 1:medium.nc - 1} "Species balance";
          pressureLossIn1.m_flow = inlet1.m_flow;
          pressureLossIn2.m_flow = inlet2.m_flow;
          pressureLossOut.m_flow = -outlet.m_flow;
          H_flow_in[1] = if useHomotopy then homotopy(actualStream(inlet1.h_outflow) * inlet1.m_flow, inStream(inlet1.h_outflow) * m_flow_in_nom[1]) else actualStream(inlet1.h_outflow) * inlet1.m_flow;
          H_flow_in[2] = if useHomotopy then homotopy(actualStream(inlet2.h_outflow) * inlet2.m_flow, inStream(inlet2.h_outflow) * m_flow_in_nom[2]) else actualStream(inlet2.h_outflow) * inlet2.m_flow;
          Xi_flow_in[1] = if useHomotopy then homotopy(actualStream(inlet1.xi_outflow) * inlet1.m_flow, inStream(inlet1.xi_outflow) * m_flow_in_nom[1]) else actualStream(inlet1.xi_outflow) * inlet1.m_flow;
          Xi_flow_in[2] = if useHomotopy then homotopy(actualStream(inlet2.xi_outflow) * inlet2.m_flow, inStream(inlet2.xi_outflow) * m_flow_in_nom[2]) else actualStream(inlet2.xi_outflow) * inlet2.m_flow;
          inlet1.p = p + pressureLossIn1.dp;
          inlet2.p = p + pressureLossIn2.dp;
          inlet1.h_outflow = h;
          inlet2.h_outflow = h;
          inlet1.xi_outflow = xi;
          inlet2.xi_outflow = xi;
          H_flow_out = if useHomotopy then homotopy(actualStream(outlet.h_outflow) * outlet.m_flow, -h * sum(m_flow_in_nom)) else actualStream(outlet.h_outflow) * outlet.m_flow;
          Xi_flow_out = if useHomotopy then homotopy(actualStream(outlet.xi_outflow) * outlet.m_flow, -xi * sum(m_flow_in_nom)) else actualStream(outlet.xi_outflow) * outlet.m_flow;
          outlet.p = p - pressureLossOut.dp;
          outlet.h_outflow = h;
          outlet.xi_outflow = xi;
          eye_int[1].m_flow = -outlet.m_flow;
          eye_int[1].T = bulk.T - 273.15;
          eye_int[1].s = bulk.s / 1e3;
          eye_int[1].p = bulk.p / 1e5;
          eye_int[1].h = h / 1e3;
          connect(eye, eye_int[1]);
        end JoinVLE_L2_Y;

        model SplitVLE_L2_Y  "A voluminous split for 2 outputs" 
          extends ClaRa.Basics.Interfaces.DataInterfaceVector(final N_sets = 2);
          extends ClaRa.Basics.Icons.Tpipe2;
          extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L2");
          outer ClaRa.SimCenter simCenter;

          model Outline  
            extends ClaRa.Basics.Icons.RecordIcon;
            input ClaRa.Basics.Units.Volume volume_tot "Total volume";
          end Outline;

          model Summary  
            extends ClaRa.Basics.Icons.RecordIcon;
            Outline outline;
            ClaRa.Basics.Records.FlangeVLE inlet;
            ClaRa.Basics.Records.FlangeVLE outlet1;
            ClaRa.Basics.Records.FlangeVLE outlet2;
            ClaRa.Basics.Records.FluidVLE_L2 fluid;
          end Summary;

          parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
          replaceable model PressureLossIn = Fundamentals.NoFriction constrainedby Fundamentals.BaseDp;
          replaceable model PressureLossOut1 = Fundamentals.NoFriction constrainedby Fundamentals.BaseDp;
          replaceable model PressureLossOut2 = Fundamentals.NoFriction constrainedby Fundamentals.BaseDp;
          parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
          parameter .ClaRa.Basics.Units.Volume volume(min = 1e-6) = 0.1 "System Volume";
          parameter .ClaRa.Basics.Units.MassFlowRate[2] m_flow_out_nom = {10, 10} "Nominal mass flow rates at outlet";
          parameter .ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal pressure";
          parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_nom = 1e5 "Nominal specific enthalpy";
          parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_start = 1e5 "Start value of sytsem specific enthalpy";
          parameter .ClaRa.Basics.Units.Pressure p_start = 1e5 "Start value of sytsem pressure";
          parameter ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi_start = medium.xi_default;
          parameter Integer initOption = 0 "Type of initialisation";
          parameter Boolean showExpertSummary = simCenter.showExpertSummary "|Summary and Visualisation||True, if expert summary should be applied";
          parameter Boolean showData = true "|Summary and Visualisation||True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
          parameter Boolean preciseTwoPhase = true "|Expert Stettings||True, if two-phase transients should be capured precisely";
        protected
          parameter .ClaRa.Basics.Units.DensityMassSpecific rho_nom = TILMedia.VLEFluidFunctions.density_phxi(medium, p_nom, h_nom) "Nominal density";
          .ClaRa.Basics.Units.Power Hdrhodt = if preciseTwoPhase then h * volume * drhodt else 0 "h*volume*drhodt";
          Real[medium.nc - 1] Xidrhodt = if preciseTwoPhase then xi * volume * drhodt else zeros(medium.nc - 1) "h*volume*drhodt";
        public
          .ClaRa.Basics.Units.EnthalpyFlowRate H_flow_in;
          .ClaRa.Basics.Units.EnthalpyFlowRate[2] H_flow_out;
          .ClaRa.Basics.Units.EnthalpyMassSpecific h(start = h_start);
          .ClaRa.Basics.Units.Mass mass "Total system mass";
          Real drhodt;
          .ClaRa.Basics.Units.Pressure p(start = p_start, stateSelect = StateSelect.prefer) "System pressure";
          ClaRa.Basics.Units.MassFlowRate[medium.nc - 1] Xi_flow_in "Mass fraction flows at inlet";
          ClaRa.Basics.Units.MassFlowRate[2, medium.nc - 1] Xi_flow_out "Mass fraction flows at outlet";
          ClaRa.Basics.Units.MassFraction[medium.nc - 1] xi(start = xi_start) "Mass fraction";
          Summary summary(outline(volume_tot = volume), inlet(showExpertSummary = showExpertSummary, m_flow = inlet.m_flow, T = fluidIn.T, p = inlet.p, h = fluidIn.h, s = fluidIn.s, steamQuality = fluidIn.q, H_flow = fluidIn.h * inlet.m_flow, rho = fluidIn.d), fluid(showExpertSummary = showExpertSummary, mass = mass, p = p, h = h, T = bulk.T, s = bulk.s, steamQuality = bulk.q, H = h * mass, rho = bulk.d, T_sat = bulk.VLE.T_l, h_dew = bulk.VLE.h_v, h_bub = bulk.VLE.h_l), outlet1(showExpertSummary = showExpertSummary, m_flow = -outlet1.m_flow, T = fluidOut1.T, p = outlet1.p, h = fluidOut1.h, s = fluidOut1.s, steamQuality = fluidOut1.q, H_flow = -fluidOut1.h * outlet1.m_flow, rho = fluidOut1.d), outlet2(showExpertSummary = showExpertSummary, m_flow = -outlet2.m_flow, T = fluidOut2.T, p = outlet2.p, h = fluidOut2.h, s = fluidOut2.s, steamQuality = fluidOut2.q, H_flow = -fluidOut2.h * outlet2.m_flow, rho = fluidOut2.d));
          ClaRa.Basics.Interfaces.FluidPortIn inlet(Medium = medium) "Inlet port";
          ClaRa.Basics.Interfaces.FluidPortOut outlet1(each Medium = medium) "Outlet port";
        protected
          TILMedia.VLEFluid_ph bulk(each vleFluidType = medium, p = p, h = h);
        public
          ClaRa.Basics.Interfaces.FluidPortOut outlet2(each Medium = medium) "Outlet port";
        protected
          TILMedia.VLEFluid_ph fluidOut1(each vleFluidType = medium, h = noEvent(actualStream(outlet1.h_outflow)), p = outlet1.p);
          TILMedia.VLEFluid_ph fluidIn(each vleFluidType = medium, h = noEvent(actualStream(inlet.h_outflow)), p = inlet.p);
          TILMedia.VLEFluid_ph fluidOut2(each vleFluidType = medium, h = noEvent(actualStream(outlet2.h_outflow)), p = outlet2.p);
          PressureLossIn pressureLossIn;
          PressureLossOut1 pressureLossOut1;
          PressureLossOut2 pressureLossOut2;
        initial equation
          if initOption == 208 then
            der(h) = 0;
            der(p) = 0;
          elseif initOption == 201 then
            der(p) = 0;
          elseif initOption == 202 then
            der(h) = 0;
          elseif initOption == 0 then
          else
            assert(false, "Unknown initialisation type in " + getInstanceName());
          end if;
        equation
          assert(volume > 0, "The system volume must be greater than zero!");
          mass = if useHomotopy then volume * homotopy(bulk.d, rho_nom) else volume * bulk.d;
          drhodt * volume = inlet.m_flow + outlet1.m_flow + outlet2.m_flow "Mass balance";
          drhodt = der(p) * bulk.drhodp_hxi + der(h) * bulk.drhodh_pxi + sum(der(xi) .* bulk.drhodxi_ph);
          der(h) = 1 / mass * (sum(H_flow_out) + H_flow_in + volume * der(p) - Hdrhodt) "Energy balance, decoupled from the mass balance to avoid heavy mass fluctuations during phase change or flow reversal. The term '-h*volume*drhodt' is ommited";
          der(xi) = {(sum(Xi_flow_out[:, i]) + Xi_flow_in[i] - Xidrhodt[i]) / mass for i in 1:medium.nc - 1} "Species balance";
          pressureLossIn.m_flow = inlet.m_flow;
          pressureLossOut1.m_flow = -outlet1.m_flow;
          pressureLossOut2.m_flow = -outlet2.m_flow;
          H_flow_out[1] = if useHomotopy then homotopy(noEvent(actualStream(outlet1.h_outflow)) * outlet1.m_flow, -h * m_flow_out_nom[1]) else noEvent(actualStream(outlet1.h_outflow)) * outlet1.m_flow;
          H_flow_out[2] = if useHomotopy then homotopy(noEvent(actualStream(outlet2.h_outflow)) * outlet2.m_flow, -h * m_flow_out_nom[2]) else noEvent(actualStream(outlet2.h_outflow)) * outlet2.m_flow;
          Xi_flow_out[1] = if useHomotopy then homotopy(noEvent(actualStream(outlet1.xi_outflow)) * outlet1.m_flow, -xi * m_flow_out_nom[1]) else noEvent(actualStream(outlet1.xi_outflow)) * outlet1.m_flow;
          Xi_flow_out[2] = if useHomotopy then homotopy(noEvent(actualStream(outlet2.xi_outflow)) * outlet2.m_flow, -xi * m_flow_out_nom[2]) else noEvent(actualStream(outlet2.xi_outflow)) * outlet2.m_flow;
          outlet1.p = p - pressureLossOut1.dp;
          outlet1.h_outflow = h;
          outlet1.xi_outflow = xi;
          outlet2.p = p - pressureLossOut2.dp;
          outlet2.h_outflow = h;
          outlet2.xi_outflow = xi;
          H_flow_in = if useHomotopy then homotopy(noEvent(actualStream(inlet.h_outflow)) * inlet.m_flow, inStream(inlet.h_outflow) * sum(m_flow_out_nom)) else noEvent(actualStream(inlet.h_outflow)) * inlet.m_flow;
          Xi_flow_in = if useHomotopy then homotopy(noEvent(actualStream(inlet.xi_outflow)) * inlet.m_flow, inStream(inlet.xi_outflow) * sum(m_flow_out_nom)) else noEvent(actualStream(inlet.xi_outflow)) * inlet.m_flow;
          inlet.p = p + pressureLossIn.dp;
          inlet.h_outflow = h;
          inlet.xi_outflow = xi;
          for i in 1:2 loop
            eye[i].T = bulk.T - 273.15;
            eye[i].s = bulk.s / 1e3;
            eye[i].p = bulk.p / 1e5;
            eye[i].h = h / 1e3;
          end for;
          eye[1].m_flow = -outlet1.m_flow;
          eye[2].m_flow = -outlet2.m_flow;
        end SplitVLE_L2_Y;
      end Fittings;
    end VolumesValvesFittings;

    package MechanicalSeparation  "Separation processes based on gravity and centrifugal forces" 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      partial model FeedWaterTank_base  "Base class for feedwater tanks" 
        extends ClaRa.Basics.Icons.FeedwaterTank;
        outer ClaRa.SimCenter simCenter;
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        parameter Modelica.SIunits.Length diameter = 1 "Diameter of the component";
        parameter Modelica.SIunits.Length length = 1 "Length of the component";
        parameter Basics.Choices.GeometryOrientation orientation = ClaRa.Basics.Choices.GeometryOrientation.vertical "Orientation of the component";
        parameter Modelica.SIunits.MassFlowRate m_flow_cond_nom "Nominal condensat flow";
        parameter Modelica.SIunits.MassFlowRate m_flow_heat_nom "Nominal heating steam flow";
        parameter Modelica.SIunits.Pressure p_nom = 1e5 "Nominal pressure";
        parameter Modelica.SIunits.SpecificEnthalpy h_nom = 1e5 "Nominal specific enthalpy";
        parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
        parameter Modelica.SIunits.Pressure p_start = 1e5 "Start value of sytsem pressure";
        parameter Real level_rel_start "Initial filling level";
        final parameter ClaRa.Basics.Units.MassFraction steamQuality_start = (1 - level_rel_start) * TILMedia.VLEFluidFunctions.dewDensity_pxi(medium, p_start) / ((1 - level_rel_start) * TILMedia.VLEFluidFunctions.dewDensity_pxi(medium, p_start) + level_rel_start * TILMedia.VLEFluidFunctions.bubbleDensity_pxi(medium, p_start)) "Initial steam quality";
        parameter Boolean showExpertSummary = simCenter.showExpertSummary "True, if expert summary should be applied";
        parameter Boolean showData = true "True, if a data port containing p,T,h,s,m_flow shall be shown";
        parameter Boolean showLevel = false "True, if level shall be visualised";
        parameter Boolean levelOutput = false "True, if Real level connector shall be addded";
        parameter Boolean outputAbs = false "True, if absolute level is at output";
        ClaRa.Basics.Interfaces.FluidPortOut feedwater(Medium = medium) "Feedwater";
        ClaRa.Basics.Interfaces.FluidPortIn heatingSteam(Medium = medium) "Heating steam inlet";
        ClaRa.Basics.Interfaces.FluidPortIn condensate(Medium = medium) "Main condensate inlet";
        ClaRa.Basics.Interfaces.EyeOut eye if showData;
      protected
        ClaRa.Basics.Interfaces.EyeIn[1] eye_int;
      equation
        connect(eye_int[1], eye);
      end FeedWaterTank_base;

      model FeedWaterTank_L3  "Feedwater tank : separated volume approach | level-dependent phase separation" 
        extends ClaRa.Components.MechanicalSeparation.FeedWaterTank_base;
        parameter ClaRa.Basics.Units.Length thickness_wall = 0.005 * diameter "Thickness of the cylinder wall";
        parameter ClaRa.Basics.Units.Length thickness_insulation = 0.02 "Thickness of the insulation";
        replaceable model material = TILMedia.SolidTypes.TILMedia_Steel constrainedby TILMedia.SolidTypes.BaseSolid;
        parameter Boolean includeInsulation = false "True, if insulation is included";
        replaceable model insulationMaterial = TILMedia.SolidTypes.InsulationOrstechLSP_H_const constrainedby TILMedia.SolidTypes.BaseSolid;
        extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L3");
        parameter Modelica.SIunits.Length radius_flange = 0.05 "Flange radius";
        parameter .ClaRa.Basics.Units.Length z_tapping = 0 "position of tapping flange";
        parameter .ClaRa.Basics.Units.Length z_condensate = 0.1 "position of condensate flange";
        parameter .ClaRa.Basics.Units.Length z_aux = 0.1 "position of auxilliary flange";
        parameter .ClaRa.Basics.Units.Length z_feedwater = 0 "position of feedwater flange";
        parameter .ClaRa.Basics.Units.Length z_vent = 0.1 "position of vent flange";
        parameter ClaRa.Basics.Units.Mass mass_struc = 0 "Mass of internal structure addtional to feedwater tank wall";
        parameter .ClaRa.Basics.Units.Time Tau_cond = 10 "Time constant of condensation";
        parameter .ClaRa.Basics.Units.Time Tau_evap = Tau_cond * 1000 "Time constant of evaporation";
        parameter Real absorbInflow = 1 "Absorption of incoming mass flow to the zones 1: perfect in the allocated zone, 0: perfect according to steam quality";
        parameter .ClaRa.Basics.Units.Area A_phaseBorder = volume.geo.A_hor * 100 "Heat transfer area at phase border";
        parameter .ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_ph = 500 "HTC of the phase border";
        parameter Real expHT_phases = 0 "Exponent for volume dependency on inter phase HT";
        parameter Boolean equalPressures = true "True if pressure in liquid and vapour phase is equal";
        parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments "Smoothness of table interpolation for calculation of filling level";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_liq_start = (-10) + TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium, volume.p_start) "Start value of liquid specific enthalpy";
        parameter .ClaRa.Basics.Units.EnthalpyMassSpecific h_vap_start = (+10) + TILMedia.VLEFluidFunctions.dewSpecificEnthalpy_pxi(medium, volume.p_start) "Start value of vapour specific enthalpy";
        parameter Modelica.SIunits.Temperature[wall.N_rad] T_wall_start = ones(wall.N_rad) * 293.15 "Start values of wall temperature inner --> outer";
        parameter Integer initOptionWall = 1 "Initialisation option for wall";
        parameter Integer initOptionInsulation = 0 "Type of initialisation";
        parameter ClaRa.Basics.Units.Temperature T_startInsulation = 293.15 "Start values of wall temperature";
        replaceable model PressureLoss = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearParallelZones_L3 constrainedby ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.PressureLoss_L3;
        replaceable model HeatTransfer = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.Constant_L3(alpha_nom = {3000, 3000}) constrainedby Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.HeatTransfer_L3;
        inner parameter Integer initOption = 211 "Type of initialisation";
        parameter Boolean enableAmbientLosses = false "Include heat losses to environment ";
        input ClaRa.Basics.Units.CoefficientOfHeatTransfer alpha_prescribed = 8 "Prescribed heat transfer coefficient";
        input ClaRa.Basics.Units.Temperature T_amb = simCenter.T_amb "Temperature of surrounding medium";

        model Outline  
          extends ClaRa.Basics.Icons.RecordIcon;
          input Basics.Units.Length level_abs "Absolute filling level";
          input Real level_rel "relative filling level";
          input ClaRa.Basics.Units.HeatFlowRate Q_loss "Heat flow rate from metal wall to insulation/ambient";
        end Outline;

        model Wall  
          extends ClaRa.Basics.Icons.RecordIcon;
          input Basics.Units.Temperature[3] T_wall "Temperatures";
        end Wall;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          Outline outline;
          Wall wall;
          ClaRa.Basics.Records.FlangeVLE condensate;
          ClaRa.Basics.Records.FlangeVLE tapping "heatingSteam (= volume.inlet[1]";
          ClaRa.Basics.Records.FlangeVLE feedwater;
          ClaRa.Basics.Records.FlangeVLE aux;
          ClaRa.Basics.Records.FlangeVLE vent "Vent (= volume.outlet[2])";
        end Summary;

        Summary summary(outline(level_abs = volume.phaseBorder.level_abs, level_rel = volume.phaseBorder.level_rel, Q_loss = wall.outerPhase.Q_flow), wall(T_wall = wall.T), tapping(showExpertSummary = showExpertSummary, m_flow = heatingSteam.m_flow, p = heatingSteam.p, h = noEvent(actualStream(heatingSteam.h_outflow)), T = TILMedia.VLEFluidObjectFunctions.temperature_phxi(heatingSteam.p, noEvent(actualStream(heatingSteam.h_outflow)), noEvent(actualStream(heatingSteam.xi_outflow)), volume.fluidIn[1].vleFluidPointer), s = TILMedia.VLEFluidObjectFunctions.specificEntropy_phxi(heatingSteam.p, noEvent(actualStream(heatingSteam.h_outflow)), noEvent(actualStream(heatingSteam.xi_outflow)), volume.fluidIn[1].vleFluidPointer), steamQuality = TILMedia.VLEFluidObjectFunctions.steamMassFraction_phxi(heatingSteam.p, noEvent(actualStream(heatingSteam.h_outflow)), noEvent(actualStream(heatingSteam.xi_outflow)), volume.fluidIn[1].vleFluidPointer), H_flow = heatingSteam.m_flow * noEvent(actualStream(heatingSteam.h_outflow)), rho = TILMedia.VLEFluidObjectFunctions.density_phxi(heatingSteam.p, noEvent(actualStream(heatingSteam.h_outflow)), noEvent(actualStream(heatingSteam.xi_outflow)), volume.fluidIn[1].vleFluidPointer)), condensate(showExpertSummary = showExpertSummary, m_flow = condensate.m_flow, p = condensate.p, h = noEvent(actualStream(condensate.h_outflow)), T = TILMedia.VLEFluidObjectFunctions.temperature_phxi(condensate.p, noEvent(actualStream(condensate.h_outflow)), noEvent(actualStream(condensate.xi_outflow)), volume.fluidIn[2].vleFluidPointer), s = TILMedia.VLEFluidObjectFunctions.specificEntropy_phxi(condensate.p, noEvent(actualStream(condensate.h_outflow)), noEvent(actualStream(condensate.xi_outflow)), volume.fluidIn[2].vleFluidPointer), steamQuality = TILMedia.VLEFluidObjectFunctions.steamMassFraction_phxi(condensate.p, noEvent(actualStream(condensate.h_outflow)), noEvent(actualStream(condensate.xi_outflow)), volume.fluidIn[2].vleFluidPointer), H_flow = condensate.m_flow * noEvent(actualStream(condensate.h_outflow)), rho = TILMedia.VLEFluidObjectFunctions.density_phxi(condensate.p, noEvent(actualStream(condensate.h_outflow)), noEvent(actualStream(condensate.xi_outflow)), volume.fluidIn[2].vleFluidPointer)), aux(showExpertSummary = showExpertSummary, m_flow = aux.m_flow, p = aux.p, h = noEvent(actualStream(aux.h_outflow)), T = TILMedia.VLEFluidObjectFunctions.temperature_phxi(aux.p, noEvent(actualStream(aux.h_outflow)), noEvent(actualStream(aux.xi_outflow)), volume.fluidIn[3].vleFluidPointer), s = TILMedia.VLEFluidObjectFunctions.specificEntropy_phxi(aux.p, noEvent(actualStream(aux.h_outflow)), noEvent(actualStream(aux.xi_outflow)), volume.fluidIn[3].vleFluidPointer), steamQuality = TILMedia.VLEFluidObjectFunctions.steamMassFraction_phxi(aux.p, noEvent(actualStream(aux.h_outflow)), noEvent(actualStream(aux.xi_outflow)), volume.fluidIn[3].vleFluidPointer), H_flow = aux.m_flow * noEvent(actualStream(aux.h_outflow)), rho = TILMedia.VLEFluidObjectFunctions.density_phxi(aux.p, noEvent(actualStream(aux.h_outflow)), noEvent(actualStream(aux.xi_outflow)), volume.fluidIn[3].vleFluidPointer)), feedwater(showExpertSummary = showExpertSummary, m_flow = -feedwater.m_flow, p = feedwater.p, h = noEvent(actualStream(feedwater.h_outflow)), T = TILMedia.VLEFluidObjectFunctions.temperature_phxi(feedwater.p, noEvent(actualStream(feedwater.h_outflow)), noEvent(actualStream(feedwater.xi_outflow)), volume.fluidIn[1].vleFluidPointer), s = TILMedia.VLEFluidObjectFunctions.specificEntropy_phxi(feedwater.p, noEvent(actualStream(feedwater.h_outflow)), noEvent(actualStream(feedwater.xi_outflow)), volume.fluidIn[1].vleFluidPointer), steamQuality = TILMedia.VLEFluidObjectFunctions.steamMassFraction_phxi(feedwater.p, noEvent(actualStream(feedwater.h_outflow)), noEvent(actualStream(feedwater.xi_outflow)), volume.fluidIn[1].vleFluidPointer), H_flow = -feedwater.m_flow * noEvent(actualStream(feedwater.h_outflow)), rho = TILMedia.VLEFluidObjectFunctions.density_phxi(feedwater.p, noEvent(actualStream(feedwater.h_outflow)), noEvent(actualStream(feedwater.xi_outflow)), volume.fluidIn[1].vleFluidPointer)), vent(showExpertSummary = showExpertSummary, m_flow = -vent.m_flow, p = vent.p, h = volume.fluidOut[2].h, T = volume.fluidOut[2].T, s = volume.fluidOut[2].s, steamQuality = volume.fluidOut[2].q, H_flow = -volume.outlet[2].m_flow * volume.fluidOut[2].h, rho = volume.fluidOut[2].d));
        Basics.ControlVolumes.FluidVolumes.VolumeVLE_L3_TwoZonesNPort volume(medium = medium, redeclare model PressureLoss = PressureLoss, useHomotopy = useHomotopy, m_flow_nom = m_flow_cond_nom + m_flow_heat_nom, p_nom = p_nom, p_start = p_start, level_rel_start = level_rel_start, Tau_cond = Tau_cond, showExpertSummary = showExpertSummary, redeclare model HeatTransfer = HeatTransfer, Tau_evap = Tau_evap, h_liq_start = h_liq_start, h_vap_start = h_vap_start, redeclare model Geometry = ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry(N_heat = 1, A_heat = {Modelica.Constants.pi * diameter * length}, final A_hor = if orientation == ClaRa.Basics.Choices.GeometryOrientation.vertical then Modelica.Constants.pi / 4 * diameter ^ 2 else diameter * length, N_outlet = 2, z_out = {z_feedwater, z_vent}, shape = if orientation == ClaRa.Basics.Choices.GeometryOrientation.vertical then [0, 1; 1, 1] else [0.0005, 0.02981; 0.0245, 0.20716; 0.1245, 0.45248; 0.2245, 0.58733; 0.3245, 0.68065; 0.4245, 0.74791; 0.5245, 0.7954; 0.6245, 0.8261; 0.7245, 0.84114; 0.8245, 0.84015; 0.9245, 0.82031; 1, 0.7854], height_fill = if orientation == ClaRa.Basics.Choices.GeometryOrientation.vertical then length else diameter, volume = Modelica.Constants.pi / 4 * diameter ^ 2 * length, A_cross = if orientation == ClaRa.Basics.Choices.GeometryOrientation.vertical then Modelica.Constants.pi / 4 * diameter ^ 2 else length * diameter, final A_front = if orientation == ClaRa.Basics.Choices.GeometryOrientation.vertical then Modelica.Constants.pi / 4 * diameter ^ 2 else length * diameter, N_inlet = 3, z_in = {z_tapping, z_condensate, z_aux}), redeclare model PhaseBorder = ClaRa.Basics.ControlVolumes.Fundamentals.SpacialDistribution.RealSeparated(level_rel_start = level_rel_start, radius_flange = radius_flange, absorbInflow = absorbInflow, smoothness = smoothness), A_heat_ph = A_phaseBorder, exp_HT_phases = expHT_phases, alpha_ph = alpha_ph, equalPressures = equalPressures, initOption = initOption);
        ClaRa.Basics.ControlVolumes.SolidVolumes.CylindricalThickWall_L4 wall(sizefunc = +1, N_tubes = 1, length = length, N_rad = 3, diameter_i = diameter, redeclare replaceable model Material = material, diameter_o = diameter + 2 * thickness_wall, T_start = T_wall_start, initOption = initOptionWall, mass_struc = mass_struc + 2 * diameter ^ 2 / 4 * Modelica.Constants.pi * thickness_wall * wall.solid[1].d);
        Basics.Interfaces.FluidPortOut vent(Medium = medium);
        Basics.Interfaces.EyeOut eye_sat if showData;
      protected
        Basics.Interfaces.EyeIn[1] eye_int1;
      public
        Basics.Interfaces.FluidPortIn aux(Medium = medium) "Auxilliary inlet";
        Adapters.Scalar2VectorHeatPort scalar2VectorHeatPort(N = 2);
        Modelica.Blocks.Interfaces.RealOutput level = if outputAbs then summary.outline.level_abs else summary.outline.level_rel if levelOutput;
        Basics.ControlVolumes.SolidVolumes.CylindricalThinWall_L4 insulation(redeclare model Material = insulationMaterial, diameter_o = diameter + 2 * thickness_wall + 2 * thickness_insulation, diameter_i = diameter + 2 * thickness_wall, length = length, N_tubes = 1, N_ax = 1, stateLocation = 2, initOption = initOptionInsulation, T_start = T_startInsulation * ones(1)) if includeInsulation;
        BoundaryConditions.PrescribedHeatFlow prescribedHeatFlow(length = length, N_axial = 1, Delta_x = ClaRa.Basics.Functions.GenerateGrid({0}, length, 1)) if enableAmbientLosses == true;
        Modelica.Blocks.Sources.RealExpression heatFlowRatePrescribedAlpha(y = if includeInsulation then -alpha_prescribed * (length * Modelica.Constants.pi * (diameter + 2 * thickness_wall + 2 * thickness_insulation) + Modelica.Constants.pi * (diameter + 2 * thickness_wall + 2 * thickness_insulation) ^ 2 / 4 * 2) * (prescribedHeatFlow.port[1].T - T_amb) else -alpha_prescribed * (length * Modelica.Constants.pi * (diameter + 2 * thickness_wall) + Modelica.Constants.pi * (diameter + 2 * thickness_wall) ^ 2 / 4 * 2) * (prescribedHeatFlow.port[1].T - T_amb)) if enableAmbientLosses == true;
      equation
        eye_int1[1].m_flow = -vent.m_flow;
        eye_int1[1].T = volume.summary.outlet[2].T - 273.15;
        eye_int1[1].s = volume.fluidOut[2].s / 1000;
        eye_int1[1].h = volume.summary.outlet[2].h / 1000;
        eye_int1[1].p = volume.summary.outlet[2].p / 100000;
        eye_int[1].m_flow = -feedwater.m_flow;
        eye_int[1].T = volume.summary.outlet[1].T - 273.15;
        eye_int[1].s = volume.fluidOut[1].s / 1000;
        eye_int[1].h = volume.summary.outlet[1].h / 1000;
        eye_int[1].p = volume.summary.outlet[1].p / 100000;
        connect(volume.inlet[1], heatingSteam);
        connect(volume.inlet[2], condensate);
        connect(volume.outlet[1], feedwater);
        connect(volume.outlet[2], vent);
        connect(eye_int1[1], eye_sat);
        connect(aux, volume.inlet[3]);
        connect(scalar2VectorHeatPort.heatVector, volume.heat);
        connect(scalar2VectorHeatPort.heatScalar, wall.innerPhase);
        if includeInsulation then
          connect(wall.outerPhase, insulation.innerPhase[1]);
          if enableAmbientLosses then
            connect(insulation.outerPhase[1], prescribedHeatFlow.port[1]);
            connect(heatFlowRatePrescribedAlpha.y, prescribedHeatFlow.Q_flow);
          end if;
        else
          if enableAmbientLosses then
            connect(wall.outerPhase, prescribedHeatFlow.port[1]);
            connect(heatFlowRatePrescribedAlpha.y, prescribedHeatFlow.Q_flow);
          end if;
        end if;
      end FeedWaterTank_L3;
    end MechanicalSeparation;

    package Electrical  "Generators, Electric Grids,..." 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      model SimpleGenerator  "A simple active power generator" 
        outer ClaRa.SimCenter simCenter;
        ClaRa.Basics.Interfaces.Connected2SimCenter connected2SimCenter(powerIn = 0, powerOut = 0, powerAux = (1 - eta) * shaft.tau * omega) if contributeToCycleSummary;
        parameter Boolean contributeToCycleSummary = simCenter.contributeToCycleSummary "True if component shall contribute to automatic efficiency calculation";
        parameter Real eta(min = 0) = 0.98 "Conversion efficiency (electrical + mechanical losses)";
        parameter Integer N_pole_pairs(min = 1) = 1 "Number of electrical pole pairs";
        parameter Boolean hasInertia = false "Model accounts for rotational inertia";
        parameter ClaRa.Basics.Units.MomentOfInertia J = 1500 "Moment of inertia";
        parameter ClaRa.Basics.Units.Frequency f_start = 50 "Initial grid frequency";
      protected
        ClaRa.Basics.Units.Energy E_rot "Rotational kinetic energy";
        ClaRa.Basics.Units.AngularVelocity omega "Shaft angular velocity";
        ClaRa.Basics.Units.RPM rpm "Shaft rotational speed";
        ClaRa.Basics.Units.Frequency f(start = f_start) "Electrical frequency";

      public
        record Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Units.Power P_shaft "Shaft power";
          ClaRa.Basics.Units.Power P_el "Electrical power";
          ClaRa.Basics.Units.RPM rpm "Rotational speed of shaft";
          ClaRa.Basics.Units.Frequency f "Electrical frequency";
        end Summary;

        ClaRa.Basics.Interfaces.ElectricPortOut powerConnection "Electric connection";
        Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft "Mechanical shaft";
        Summary summary(P_shaft = shaft.tau * omega, P_el = -powerConnection.P, rpm = rpm, f = f);
      equation
        omega = der(shaft.phi) "Mechanical boundary condition";
        f = N_pole_pairs * omega / (2 * Modelica.Constants.pi) "Electrical frequency";
        rpm = 30 / Modelica.Constants.pi * omega "Rotational speed in rpm";
        powerConnection.f = f "Electrical boundary condition";
        if hasInertia then
          E_rot = 1 / 2 * J * omega ^ 2 "Kinetic energy";
          der(E_rot) = omega * shaft.tau + powerConnection.P / eta "Energy balance";
        else
          E_rot = 0 "Kinetic energy";
          0 = omega * shaft.tau + powerConnection.P / eta "Energy balance";
        end if;
      end SimpleGenerator;
    end Electrical;

    package Adapters  "Adapters to be compatible to ThermoPower and Modelica Fluid" 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      model Scalar2VectorHeatPort  "Connect a scalar heat port with a vectorised heat port" 
        extends ClaRa.Basics.Icons.Adapter5_fw;
        parameter String equalityMode = "Equal Temperatures" "Spacial equality of state or flow variable?";
        parameter Integer N = 3 "Number of axial elements";
        parameter Basics.Units.Length length = 1 "Length of adapter";
        parameter Basics.Units.Length[N] Delta_x = ClaRa.Basics.Functions.GenerateGrid({0}, length, N) "Discretisation scheme";
        parameter Boolean useStabiliserState = false "True, if a stabiliser state shall be used";
        parameter ClaRa.Basics.Units.Time Tau = 1 "Time Constant of Stabiliser State";
        ClaRa.Basics.Interfaces.HeatPort_a heatScalar;
        ClaRa.Basics.Interfaces.HeatPort_b[N] heatVector;
      initial equation
        if equalityMode == "Equal Temperatures" and useStabiliserState == true then
          heatVector.T = ones(N) * heatScalar.T;
        end if;
      equation
        if equalityMode == "Equal Heat Flow Rates" then
          heatScalar.T = sum(heatVector.T .* Delta_x) / sum(Delta_x);
          heatVector.Q_flow = -heatScalar.Q_flow .* Delta_x / sum(Delta_x);
        elseif equalityMode == "Equal Temperatures" then
          heatScalar.Q_flow = -sum(heatVector.Q_flow);
          if useStabiliserState then
            der(heatVector.T) = (ones(N) .* heatScalar.T - heatVector.T) / Tau;
          else
            heatVector.T = ones(N) .* heatScalar.T;
          end if;
        else
          assert(false, "Unknown equalityMode option in scalar2VectorHeatPort");
        end if;
      end Scalar2VectorHeatPort;
    end Adapters;

    package Utilities  "Some nice help for modelling" 
      extends ClaRa.Basics.Icons.PackageIcons.Components80;

      package Blocks  "Some rucial control elements" 
        extends ClaRa.Basics.Icons.PackageIcons.Components60;

        block LimPID  "P, PI, PD, and PID controller with limited output, anti-windup compensation and delayed, smooth activation" 
          output Real controlError = u_s - u_m "Control error (set point - measurement)";
          parameter Modelica.Blocks.Types.SimpleController controllerType = Modelica.Blocks.Types.SimpleController.PID "Type of controller";
          parameter Real sign = 1 "set to 1 if a positive control error leads to a positive control output, else -1";
          parameter Boolean perUnitConversion = true "True, if input and output values should be normalised with respect to reference values";
          parameter Real u_ref = 1 "Reference value for controlled variable";
          parameter Real y_ref = 1 "Reference value for actuated variable";
          parameter Real y_max = 1 "Upper limit of output";
          parameter Real y_min = -y_max "Lower limit of output";
          parameter Real k = 1 "Gain of Proportional block";
          parameter Modelica.SIunits.Time Tau_i(min = Modelica.Constants.small) = 0.5 "1/Ti is gain of integrator block";
          parameter Modelica.SIunits.Time Tau_d(min = 0) = 0.1 "Gain of derivative block";
          parameter Modelica.SIunits.Time Ni(min = 100 * Modelica.Constants.eps) = 0.9 "1/Ni is gain of anti-windup compensation";
          parameter Real Nd = 1 "The smaller Nd, the more ideal the derivative block, setting Nd=0 introduces ideal derivative";
          parameter Boolean use_activateInput = false "Provide Boolean input to switch controller on/off.";
          parameter ClaRa.Basics.Units.Time t_activation = 0.0 "Time when controller is switched on. For use_activateInput==true the controller is switched on if (time>t_activation AND activateController=true).";
          parameter ClaRa.Basics.Units.Time Tau_lag_I = 0.0 "Time lag for activation of integral part AFTER controller is being switched on ";
          parameter Real y_inactive = 1 "Controller output if controller is not active";
          parameter Real Tau_in(min = 0) = 0 "Time constant for input smoothening, Tau_in=0 refers to signal no smoothening";
          parameter Real Tau_out(min = 0) = 0 "time constant for output smoothening, Tau_out=0 refers to signal no smoothening";
          parameter Integer initOption = 501 "Initialisation option";
          parameter Boolean limitsAtInit = true "= false, if limits are ignored during initializiation";
          parameter Real xi_start = 0 "Initial or guess value value for integrator output (= integrator state)";
          parameter Real y_start = 0 "Initial value of output";
          parameter Real Tau_add(min = 0) = 0 "Set to >0 for additional state after add block in controller, if DAE-index reduction fails.";
          parameter Real xd_start = 0 "Initial or guess value for state of derivative block";
        protected
          parameter Boolean with_I = controllerType == Modelica.Blocks.Types.SimpleController.PI or controllerType == Modelica.Blocks.Types.SimpleController.PID annotation(HideResult = true);
          parameter Boolean with_D = controllerType == Modelica.Blocks.Types.SimpleController.PD or controllerType == Modelica.Blocks.Types.SimpleController.PID annotation(HideResult = true);
          Real resetValueP(start = 0, fixed = true) "Input to P part before controller activation";
          Real resetValueID(start = 0, fixed = true) "Output of controller before activation";
          Real resetValueI "";
        public
          Modelica.Blocks.Interfaces.RealInput u_s "Connector of setpoint input signal";
          Modelica.Blocks.Interfaces.RealInput u_m "Connector of measurement input signal";
          Modelica.Blocks.Interfaces.BooleanInput activateInput if use_activateInput "true, if controller is on";
          Modelica.Blocks.Interfaces.RealOutput y "Connector of actuator output signal";
          Modelica.Blocks.Math.Gain P(k = k);
          ClaRa.Components.Utilities.Blocks.Integrator I(y_startInputIsActive = true, Tau_i_const = Tau_i, initOption = if initOption == 798 then 504 else if initOption == 796 then 504 else if initOption == 797 then 504 else if initOption == 795 or initOption == 501 then 501 else if initOption == 502 then 502 else if initOption == 503 then 504 else 0) if with_I;
          ClaRa.Components.Utilities.Blocks.DerivativeClaRa D_approx(k = Tau_d, x_start = xd_start, initOption = if initOption == 798 or initOption == 796 or initOption == 502 or initOption == 503 then 502 else if initOption == 797 then 799 else if initOption == 795 or initOption == 501 then 501 else 0, Tau = Nd) if with_D;
          Modelica.Blocks.Math.Add3 addPID(k1 = 1, k2 = 1, k3 = 1);
          Modelica.Blocks.Math.Add addI if with_I;
          Modelica.Blocks.Math.Gain gainTrack(k = 1 / Ni) if with_I;
          Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = limitsAtInit, uMax = if perUnitConversion then y_max / y_ref else y_max, uMin = if perUnitConversion then y_min / y_ref else y_min);
          Modelica.Blocks.Sources.Constant Dzero(k = 0) if not with_D;
          Modelica.Blocks.Sources.RealExpression Izero(y = resetValueI) if not with_I;
          Modelica.Blocks.Math.Gain toPU(k = if perUnitConversion then sign / u_ref else sign) "convert input values to \"per unit\"";
          Modelica.Blocks.Math.Feedback feedback;
          Modelica.Blocks.Math.Gain fromPU(k = if perUnitConversion then y_ref else 1) "convert output values to \"Real\"";
          Modelica.Blocks.Logical.Switch switch_OnOff_I if with_I;
          Modelica.Blocks.Sources.Constant I_off_zero(k = 0) if with_I;
          Modelica.Blocks.Logical.Switch switch_OnOff;
          Modelica.Blocks.Sources.RealExpression y_unlocked(y = if perUnitConversion then y_inactive / y_ref else y_inactive);
          ClaRa.Components.Utilities.Blocks.FirstOrderClaRa smoothPIDInput(Tau = Tau_in, initOption = if Tau_in > 0 then 1 else 4);
          ClaRa.Components.Utilities.Blocks.FirstOrderClaRa smoothPIDOutput(Tau = Tau_out, initOption = if Tau_out > 0 then 1 else 4);
          Modelica.Blocks.Math.Feedback addSat;
          ClaRa.Components.Utilities.Blocks.FirstOrderClaRa smoothPIDOutput1(Tau = Tau_add, initOption = if Tau_add > 0 then 1 else 4);
          Modelica.Blocks.Sources.RealExpression y_start_I(y = if initOption == 798 or initOption == 797 or initOption == 796 then y_start / y_ref else if perUnitConversion then y_start / y_ref - addPID.u1 - addPID.u2 else y_start - addPID.u1 - addPID.u2);
          Modelica.Blocks.Math.Feedback resetP;
          Modelica.Blocks.Sources.RealExpression y_unlocked1(y = resetValueP);
          Modelica.Blocks.Math.Add resetPD;
          Modelica.Blocks.Sources.RealExpression y_unlocked2(y = resetValueID);
          Modelica.Blocks.Sources.BooleanExpression activate_(y = time >= t_activation);
          Modelica.Blocks.Logical.Timer time_lag_I_activation;
          Modelica.Blocks.Logical.And controllerActive if use_activateInput;
          Modelica.Blocks.Routing.BooleanPassThrough booleanPassThrough if not use_activateInput;
          Modelica.Blocks.Logical.GreaterThreshold I_activation(threshold = Tau_lag_I);
        initial equation
          resetValueI = if with_D then if perUnitConversion then y_start / y_ref - addPID.u1 else y_start - addPID.u1 else 0;
        equation
          assert(y_max >= y_min, "LimPID: Limits must be consistent. However, y_max (=" + String(y_max) + ") < y_min (=" + String(y_min) + ")");
          if initOption == 503 and limitsAtInit and (y_start < y_min or y_start > y_max) then
            Modelica.Utilities.Streams.error("LimPID: Start value y_start (=" + String(y_start) + ") is beyond allowed limits of y_min (=" + String(y_min) + ") and y_max (=" + String(y_max) + ") in instance " + getInstanceName());
          end if;
          when change(switch_OnOff.u2) then
            reinit(resetValueP, pre(toPU.y));
            reinit(resetValueID, y_unlocked.y - addPID.u2 - addPID.u3);
          end when;
          der(resetValueP) = 0;
          der(resetValueID) = 0;
          der(resetValueI) = 0;
          connect(P.y, addPID.u1);
          connect(D_approx.y, addPID.u2);
          connect(toPU.y, D_approx.u);
          connect(gainTrack.y, addI.u2);
          connect(u_s, feedback.u1);
          connect(u_m, feedback.u2);
          connect(switch_OnOff_I.y, I.u);
          connect(I_off_zero.y, switch_OnOff_I.u3);
          connect(toPU.y, addI.u1);
          connect(addI.y, switch_OnOff_I.u1);
          connect(limiter.y, fromPU.u);
          connect(switch_OnOff.u3, y_unlocked.y);
          connect(smoothPIDInput.y, toPU.u);
          connect(fromPU.y, smoothPIDOutput.u);
          connect(smoothPIDOutput.y, y);
          connect(addSat.y, gainTrack.u);
          connect(addPID.u2, Dzero.y);
          connect(Izero.y, addPID.u3);
          connect(switch_OnOff.y, smoothPIDOutput1.u);
          connect(smoothPIDOutput1.y, limiter.u);
          connect(y_unlocked1.y, resetP.u2);
          connect(resetP.y, P.u);
          connect(toPU.y, resetP.u1);
          connect(limiter.y, addSat.u1);
          connect(y_unlocked2.y, resetPD.u2);
          connect(y_start_I.y, I.y_start);
          connect(smoothPIDOutput1.y, addSat.u2);
          connect(feedback.y, smoothPIDInput.u);
          connect(I.y, addPID.u3);
          connect(addPID.y, resetPD.u1);
          connect(resetPD.y, switch_OnOff.u1);
          connect(activateInput, controllerActive.u1);
          connect(activate_.y, controllerActive.u2);
          connect(controllerActive.y, time_lag_I_activation.u);
          connect(controllerActive.y, switch_OnOff.u2);
          connect(time_lag_I_activation.y, I_activation.u);
          connect(activate_.y, booleanPassThrough.u);
          connect(booleanPassThrough.y, switch_OnOff.u2);
          connect(booleanPassThrough.y, time_lag_I_activation.u);
          connect(I_activation.y, switch_OnOff_I.u2);
        end LimPID;

        block Integrator  "Output the integral of the input signal - variable Integrator time constant" 
          extends Modelica.Blocks.Interfaces.SISO(y(start = y_start_const));
          parameter Boolean variable_Tau_i = false "True, if integrator time is set by variable input";
          parameter .ClaRa.Basics.Units.Time Tau_i_const = 1 "Constant integrator time";
          parameter Integer initOption = 501 "Initialisation option";
          parameter Boolean y_startInputIsActive = false "True, if integrator initial output shall be set by variable input";
          parameter Real y_start_const = 0 "Initial or guess value of output (= state)";
          parameter .ClaRa.Basics.Units.Time startTime = 0 "Start time for integration";
        protected
          .ClaRa.Basics.Units.Time Tau_i_in;
          Real y_start_in;
        public
          Modelica.Blocks.Interfaces.RealInput Tau_i = Tau_i_in if variable_Tau_i;
          Modelica.Blocks.Interfaces.RealInput y_start = y_start_in if y_startInputIsActive;
        initial equation
          if initOption == 502 then
            der(y) = 0;
          elseif initOption == 504 or initOption == 799 then
            y = y_start_in;
          elseif initOption == 501 then
          else
            assert(false, "Unknown init option in integrator instance " + getInstanceName());
          end if;
        equation
          if not variable_Tau_i then
            Tau_i_in = Tau_i_const;
          end if;
          if not y_startInputIsActive then
            y_start_in = y_start_const;
          end if;
          der(y) = if time >= startTime then u / Tau_i_in else 0;
        end Integrator;

        block DerivativeClaRa  "Derivative block ( can be adjusted to behave as ideal or approximated)" 
          parameter Real k(unit = "1") = 1 "Gain";
          parameter Modelica.SIunits.Time Tau(min = Modelica.Constants.small) = 0.01 "Time constant (Tau>0 for approxomated derivative; Tau=0 is ideal derivative block)";
          parameter Integer initOption = 501 "Initialisation option";
          parameter Real x_start = 0 "Initial or guess value of state";
          parameter Real y_start = 0 "Initial value of output (= state)";
          extends Modelica.Blocks.Interfaces.SISO(y(start = y_start));
          output Real x(start = x_start) "State of block";
        protected
          parameter Boolean zeroGain = abs(k) < Modelica.Constants.eps;
        initial equation
          if initOption == 502 then
            der(x) = 0;
          elseif initOption == 799 then
            x = x_start;
          elseif initOption == 504 then
            if zeroGain then
              x = u;
            else
              y = y_start;
            end if;
          elseif initOption == 501 then
          else
            assert(false, "Unknown init option in derivative instance " + getInstanceName());
          end if;
        equation
          der(x) = if zeroGain or Tau < Modelica.Constants.eps then 0 else (u - x) / Tau;
          if zeroGain then
            y = 0;
          elseif Tau < Modelica.Constants.eps then
            y = k * der(u);
          else
            y = k / Tau * (u - x);
          end if;
        end DerivativeClaRa;

        block FirstOrderClaRa  "First order transfer function block (= 1 pole, allows Tau = 0)" 
          extends Modelica.Blocks.Interfaces.SISO;
          parameter Modelica.SIunits.Time Tau = 0 "Time Constant, set Tau=0 for no signal smoothing";
          parameter Integer initOption = 1 "Initialisation option";
          parameter Real y_start = 1 "Start value at output";
        protected
          Real y_aux;
        initial equation
          if initOption == 1 then
            y_aux = u;
          elseif initOption == 2 then
            y_aux = y_start;
          elseif initOption == 3 and Tau > 0 then
            der(y_aux) = 0;
          elseif initOption == 4 then
            y_aux = 0;
          else
            assert(false, "Unknown init option in component " + getInstanceName());
          end if;
        equation
          if Tau < Modelica.Constants.eps then
            y = u;
            der(y_aux) = 0;
          else
            der(y_aux) = (u - y_aux) / Tau;
            y = y_aux;
          end if;
        end FirstOrderClaRa;

        model ParameterizableTable1D  "Table look-up in one dimension (matrix/file) with n inputs and n outputs " 
          parameter Boolean tableOnFile = false "true, if table is defined on file or in function usertab";
          parameter Real[:, :] table = fill(0.0, 0, 2) "table matrix (grid = first column; e.g., table=[0,2])";
          parameter String tableName = "NoName" "table name on file or in function usertab (see docu)";
          parameter String fileName = "NoName" "file where matrix is stored";
          parameter Integer[:] columns = 2:size(table, 2) "columns of table to be interpolated";
          parameter Modelica.Blocks.Types.Smoothness smoothness = .Modelica.Blocks.Types.Smoothness.LinearSegments "smoothness of table interpolation";
          extends Modelica.Blocks.Interfaces.MIMOs(final n = size(columns, 1));
        protected
          Integer tableID;

          function tableInit  "Initialize 1-dim. table defined by matrix (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)" 
            input String tableName;
            input String fileName;
            input Real[:, :] table;
            input Modelica.Blocks.Types.Smoothness smoothness;
            output Integer tableID;
            external "C" tableID = ModelicaTables_CombiTable1D_init(tableName, fileName, table, size(table, 1), size(table, 2), smoothness) annotation(Library = "ModelicaExternalC");
          end tableInit;

          function tableIpo  "Interpolate 1-dim. table defined by matrix (for details see: Modelica/Resources/C-Sources/ModelicaTables.h)" 
            input Integer tableID;
            input Integer icol;
            input Real u;
            output Real value;
            external "C" value = ModelicaTables_CombiTable1D_interpolate(tableID, icol, u) annotation(Library = "ModelicaExternalC");
          end tableIpo;
        equation
          if tableOnFile then
            assert(tableName <> "NoName", "tableOnFile = true and no table name given");
          end if;
          if not tableOnFile then
            assert(size(table, 1) > 0 and size(table, 2) > 0, "tableOnFile = false and parameter table is an empty matrix");
          end if;
          for i in 1:n loop
            y[i] = if not tableOnFile and size(table, 1) == 1 then table[1, columns[i]] else tableIpo(tableID, columns[i], u[i]);
          end for;
          when initial() then
            tableID = tableInit(if tableOnFile then tableName else "NoName", if tableOnFile then fileName else "NoName", table, smoothness);
          end when;
        end ParameterizableTable1D;
      end Blocks;
    end Utilities;
  end Components;

  package SubSystems  "Containing Subsystems like Boilers, Amine Washing,..." 
    extends ClaRa.Basics.Icons.PackageIcons.Subsystems100;

    package Boiler  "Steam generators of distinct geometry" 
      extends ClaRa.Basics.Icons.PackageIcons.Subsystems80;

      partial model CoalSupplyBoiler_base  "The coal mills and the boiler" 
        extends ClaRa.Basics.Icons.Boiler;
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component" annotation(choicesAllMatching = true);
        outer SimCenter simCenter;
        ClaRa.Basics.Interfaces.FluidPortOut livesteam(Medium = medium);
        ClaRa.Basics.Interfaces.FluidPortOut reheat_out(Medium = medium);
        Modelica.Blocks.Interfaces.RealInput QF_setl_ "Set value of thermal output in p.u.";
        ClaRa.Basics.Interfaces.FluidPortIn feedwater(Medium = medium);
        ClaRa.Basics.Interfaces.FluidPortIn reheat_in(Medium = medium);
      end CoalSupplyBoiler_base;

      model SteamGenerator_L3  "A steam generation and reaheater model using lumped balance equations for mass and energy and two spray attemperators" 
        extends ClaRa.SubSystems.Boiler.CoalSupplyBoiler_base;
        ClaRa.Basics.Interfaces.Connected2SimCenter connected2SimCenter(powerIn = Q_flow_HP + Q_flow_IP, powerOut = 0, powerAux = Q_flow_F_nom * QF_setl_ - Q_flow_HP - Q_flow_IP) if contributeToCycleSummary;
        extends ClaRa.Basics.Icons.ComplexityLevel(complexity = "L3");
        parameter Modelica.SIunits.Pressure p_LS_nom = 300e5 "Nominal life steam pressure";
        parameter Modelica.SIunits.Pressure p_RH_nom = 40e5 "Nominal reheat pressure";
        parameter Modelica.SIunits.SpecificEnthalpy h_LS_nom = 3000e3 "Nominal life steam specific enthlapy";
        parameter Modelica.SIunits.SpecificEnthalpy h_RH_nom = 3500e3 "Nominal reheat specific enthlapy";
        parameter Modelica.SIunits.Pressure Delta_p_nomHP = 40e5 "Nominal main pressure loss";
        parameter Modelica.SIunits.Pressure Delta_p_nomIP = 4e5 "Nominal reheat pressure loss";
        parameter Modelica.SIunits.MassFlowRate m_flow_nomLS = 419 "Nominal life steam flow rate";
        parameter Modelica.SIunits.HeatFlowRate Q_flow_F_nom = 1340e6 "Nominal firing power";
      protected
        parameter Modelica.SIunits.Density rho_nom_HP = TILMedia.VLEFluidFunctions.density_phxi(medium, p_LS_nom, h_LS_nom) "Nominal density";
        parameter Modelica.SIunits.Density rho_nom_IP = TILMedia.VLEFluidFunctions.density_phxi(medium, p_RH_nom, h_RH_nom) "Nominal density";
      public
        parameter Real[:, :] CL_Delta_pHP_mLS_ = [0, 0; 0.1, 0.01; 0.2, 0.04; 0.3, 0.09; 0.4, 0.16; 0.5, 0.25; 0.6, 0.36; 0.7, 0.49; 0.8, 0.64; 0.9, 0.81; 1, 1] "Characteristic line of pressure drop as function of mass flow rate";
        parameter Real[:, :] CL_Delta_pIP_mLS_ = [0, 0; 0.1, 0.01; 0.2, 0.04; 0.3, 0.09; 0.4, 0.16; 0.5, 0.25; 0.6, 0.36; 0.7, 0.49; 0.8, 0.64; 0.9, 0.81; 1, 1] "Characteristic line of reheat pressure drop as function of mass flow rate";
        parameter Real[:, :] CL_yF_QF_ = [0, 0.9; 1, 0.9] "Characteristic line of relative heat release in life steam as function of rel. firing power";
        parameter Real[:, :] CL_etaF_QF_ = [0, 0.93; 1, 0.94] "Characteristic line of furnace efficiency as function of rel. firing power";
        parameter Modelica.SIunits.Time Tau_dead = 120 "Equivalent dead time of steam generation";
        parameter Modelica.SIunits.Time Tau_bal = 200 "Balancing time of steam generation";
        parameter Boolean useHomotopy = simCenter.useHomotopy "True, if homotopy method is used during initialisation";
        parameter Modelica.SIunits.Pressure p_LS_start = 300e5 "Initial value of life steam pressure";
        parameter Modelica.SIunits.SpecificEnthalpy h_LS_start = 3000e3 "Initial value of life steam specific enthalpy";
        parameter Integer initOption_HP = 0 "Type of initialisation of HP steam generation";
        parameter Modelica.SIunits.Pressure p_RH_start = 40e5 "Initial value of hot reheat pressure";
        parameter Modelica.SIunits.SpecificEnthalpy h_RH_start = 3500e3 "Initial value of hot reheat specifc enthalpy";
        parameter Integer initOption_IP = 0 "Type of initialisation of reheater";
        parameter Modelica.SIunits.Volume volume_tot_HP = 1000 "Total volume of the live steam generator";
        parameter Modelica.SIunits.Volume volume_tot_IP = 1000 "Total volume of the reheater";
        parameter Boolean showExpertSummary = false "|Summary and Visualisation||True, if expert summary should be applied";
        parameter Boolean showData = true "|Summary and Visualisation||True, if a data port containing p,T,h,s,m_flow shall be shown, else false";
        parameter Boolean contributeToCycleSummary = simCenter.contributeToCycleSummary "True if component shall contribute to automatic efficiency calculation";
        outer ClaRa.SimCenter simCenter;
        Modelica.SIunits.SpecificEnthalpy h_IP(start = h_RH_start) "Specific enthalpy before IP injector";
        Modelica.SIunits.Pressure p_IP(start = p_RH_start) "Pressure at hot reheat outlet";
        Modelica.SIunits.Mass mass_IP "Mass in the reheater";
        Real drhodt_IP "Time derivative of reheater mean density";
        Modelica.SIunits.SpecificEnthalpy h_HP(start = h_LS_start) "Specific enthalpy before HP injector";
        Modelica.SIunits.Pressure p_HP(start = p_LS_start) "Live steam pressure";
        Modelica.SIunits.Mass mass_HP "Mass in the HP steam generator";
        Real drhodt_HP "Time dericative of the HP mean density";
        Modelica.SIunits.HeatFlowRate Q_flow_HP "Heat flow rate for HP steam generation";
        Modelica.SIunits.HeatFlowRate Q_flow_IP "Heat flow rate of the reheater";
      protected
        Modelica.SIunits.SpecificEnthalpy h_inHP "Actual spec. enthalpy of the feedwater";
        Modelica.SIunits.SpecificEnthalpy h_outHP "Actual spec. enthalpy of the livesteam";
        Modelica.SIunits.SpecificEnthalpy h_sprayHP "Actual spec. enthalpy of the HP injection";
        Modelica.SIunits.SpecificEnthalpy h_inIP "Actual spec. enthalpy of the cold reheat";
        Modelica.SIunits.SpecificEnthalpy h_outIP "Actual spec. enthalpy of the hot reheat";
        Modelica.SIunits.SpecificEnthalpy h_sprayIP "Actual spec. enthalpy of the IP injection";
        Modelica.SIunits.MassFlowRate m_flow_heatedHP "heated HP mass flow rate i.e. for energy and mass balance";
        Modelica.SIunits.MassFlowRate m_flow_heatedIP "heated IP mass flow rate i.e. for energy and mass balance";
      public
        Modelica.Blocks.Continuous.TransferFunction heatRelease(a = {Tau_bal * Tau_dead, Tau_bal + Tau_dead, 1}, initType = Modelica.Blocks.Types.Init.NoInit) "comprehends the coal supply, the heat release and the steam generation";
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D convert2PressureDrop_HP(columns = {2}, table = CL_Delta_pHP_mLS_, u(start = 1 * ones(size(convert2PressureDrop_HP.columns, 1))));
        TILMedia.VLEFluid_ph liveSteam(vleFluidType = medium, p = p_HP, h = (h_HP * (-m_flow_heatedHP) + HPInjection.m_flow * h_sprayHP) / (-livesteam.m_flow));
        TILMedia.VLEFluid_ph reheatedSteam(vleFluidType = medium, p = p_IP, h = (h_IP * (-m_flow_heatedIP) + IPInjection.m_flow * h_sprayIP) / (-reheat_out.m_flow));
        Modelica.Blocks.Interfaces.RealOutput h_evap "evaporator outlet specific enthalpy";
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D convert2PressureDrop_IP(columns = {2}, table = CL_Delta_pIP_mLS_, u(start = 1 / 6 * ones(size(convert2PressureDrop_IP.columns, 1))));
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D convert2HPFiring(columns = {2}, table = CL_yF_QF_);
        ClaRa.Basics.Interfaces.FluidPortIn IPInjection(Medium = medium) "reheat spray injection";
        ClaRa.Basics.Interfaces.FluidPortIn HPInjection(Medium = medium) "High pressure spray cooler";
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D calculateEfficiency(columns = {2}, table = CL_etaF_QF_);
        Basics.Interfaces.EyeOut eye_LS if showData;
      protected
        Basics.Interfaces.EyeIn[1] eye_intLS;
      public
        Basics.Interfaces.EyeOut eye_RH if showData;
      protected
        Basics.Interfaces.EyeIn[1] eye_intRH;
      initial equation
        heatRelease.y = QF_setl_;
        if initOption_HP == 202 then
          der(h_HP) = 0;
        elseif initOption_HP == 201 then
          der(p_HP) = 0;
        elseif initOption_HP == 208 then
          der(h_HP) = 0;
          der(p_HP) = 0;
        elseif initOption_HP == 0 then
        else
          assert(false, "Unsupported initialisation option for HP section in " + getInstanceName());
        end if;
        if initOption_IP == 202 then
          der(h_IP) = 0;
        elseif initOption_IP == 201 then
          der(p_IP) = 0;
        elseif initOption_IP == 208 then
          der(h_IP) = 0;
          der(p_IP) = 0;
        elseif initOption_IP == 0 then
        else
          assert(false, "Unsupported initialisation option for IP section in " + getInstanceName());
        end if;
      equation
        connect(QF_setl_, heatRelease.u);
        connect(heatRelease.y, convert2HPFiring.u[1]);
        connect(calculateEfficiency.u[1], heatRelease.y);
        connect(eye_LS, eye_intLS[1]);
        connect(eye_RH, eye_intRH[1]);
        h_inHP = if useHomotopy then homotopy(actualStream(feedwater.h_outflow), inStream(feedwater.h_outflow)) else actualStream(feedwater.h_outflow);
        h_outHP = if useHomotopy then homotopy(actualStream(livesteam.h_outflow), h_HP) else actualStream(livesteam.h_outflow);
        h_sprayHP = if useHomotopy then homotopy(actualStream(HPInjection.h_outflow), inStream(HPInjection.h_outflow)) else actualStream(HPInjection.h_outflow);
        h_inIP = if useHomotopy then homotopy(actualStream(reheat_in.h_outflow), inStream(reheat_in.h_outflow)) else actualStream(reheat_in.h_outflow);
        h_outIP = if useHomotopy then homotopy(actualStream(reheat_out.h_outflow), h_IP) else actualStream(reheat_out.h_outflow);
        h_sprayIP = if useHomotopy then homotopy(actualStream(IPInjection.h_outflow), inStream(IPInjection.h_outflow)) else actualStream(IPInjection.h_outflow);
        livesteam.p = p_HP;
        livesteam.h_outflow = liveSteam.h;
        livesteam.xi_outflow = ones(medium.nc - 1);
        HPInjection.p = convert2PressureDrop_HP.y[1] * Delta_p_nomHP * 0.15 + p_HP;
        HPInjection.h_outflow = 2000e3;
        HPInjection.xi_outflow = ones(medium.nc - 1);
        feedwater.p = convert2PressureDrop_HP.y[1] * Delta_p_nomHP + p_HP;
        feedwater.h_outflow = 1330e3;
        feedwater.xi_outflow = ones(medium.nc - 1);
        reheat_out.p = p_IP;
        reheat_out.h_outflow = reheatedSteam.h;
        reheat_out.xi_outflow = ones(medium.nc - 1);
        IPInjection.p = convert2PressureDrop_IP.y[1] * Delta_p_nomIP * 0.5 + p_IP;
        IPInjection.h_outflow = 2000e3;
        IPInjection.xi_outflow = ones(medium.nc - 1);
        reheat_in.p = convert2PressureDrop_IP.y[1] * Delta_p_nomIP + p_IP;
        reheat_in.h_outflow = reheatedSteam.h;
        reheat_in.xi_outflow = ones(medium.nc - 1);
        drhodt_HP = (feedwater.m_flow + m_flow_heatedHP) / volume_tot_HP;
        mass_HP = if useHomotopy then homotopy(liveSteam.d * volume_tot_HP, volume_tot_HP * rho_nom_HP) else liveSteam.d * volume_tot_HP;
        der(h_HP) = if useHomotopy then homotopy((feedwater.m_flow * h_inHP + m_flow_heatedHP * h_HP + Q_flow_HP + der(p_HP) * volume_tot_HP - drhodt_HP * volume_tot_HP * h_HP) / mass_HP, (m_flow_nomLS * h_inHP + m_flow_nomLS * h_HP + Q_flow_HP + der(p_HP) * volume_tot_HP - drhodt_HP * volume_tot_HP * h_HP) / mass_HP) else (feedwater.m_flow * h_inHP + m_flow_heatedHP * h_HP + Q_flow_HP + der(p_HP) * volume_tot_HP - drhodt_HP * volume_tot_HP * h_HP) / mass_HP;
        der(p_HP) * liveSteam.drhodp_hxi = drhodt_HP - liveSteam.drhodh_pxi * der(h_HP);
        m_flow_heatedHP = livesteam.m_flow + HPInjection.m_flow;
        Q_flow_HP = convert2HPFiring.y[1] * calculateEfficiency.y[1] * heatRelease.y * Q_flow_F_nom;
        drhodt_IP = (reheat_in.m_flow + m_flow_heatedIP) / volume_tot_IP;
        mass_IP = if useHomotopy then homotopy(reheatedSteam.d * volume_tot_IP, volume_tot_IP * rho_nom_IP) else reheatedSteam.d * volume_tot_IP;
        der(h_IP) = (reheat_in.m_flow * h_inIP + m_flow_heatedIP * h_IP + Q_flow_IP + der(p_IP) * volume_tot_IP - drhodt_IP * volume_tot_IP * h_IP) / mass_IP;
        der(p_IP) * reheatedSteam.drhodp_hxi = drhodt_IP - reheatedSteam.drhodh_pxi * der(h_IP);
        m_flow_heatedIP = reheat_out.m_flow + IPInjection.m_flow;
        Q_flow_IP = (1 - convert2HPFiring.y[1]) * calculateEfficiency.y[1] * heatRelease.y * Q_flow_F_nom;
        convert2PressureDrop_HP.u[1] = feedwater.m_flow / m_flow_nomLS;
        convert2PressureDrop_IP.u[1] = reheat_in.m_flow / m_flow_nomLS;
        h_evap = liveSteam.VLE.h_v + 50e3;
        eye_intLS[1].p = livesteam.p / 1e5;
        eye_intLS[1].h = livesteam.h_outflow / 1e3;
        eye_intLS[1].m_flow = -livesteam.m_flow;
        eye_intLS[1].T = liveSteam.T - 273.15;
        eye_intLS[1].s = liveSteam.s / 1e3;
        eye_intRH[1].p = reheat_out.p / 1e5;
        eye_intRH[1].h = reheat_out.h_outflow / 1e3;
        eye_intRH[1].m_flow = -reheat_out.m_flow;
        eye_intRH[1].T = reheatedSteam.T - 273.15;
        eye_intRH[1].s = reheatedSteam.s / 1e3;
      end SteamGenerator_L3;
    end Boiler;
  end SubSystems;

  package Visualisation  "Visualisation of State of Process" 
    extends ClaRa.Basics.Icons.PackageIcons.Visualisation100;

    model DynDisplay  "Dynamic Display of one variable" 
      parameter String varname = "Name of the variable";
      parameter Boolean provideConnector = false "If true a real output connector is provided";
      input Real x1 = 1 "Variable value";
      parameter String unit = "C" "Variable unit";
      parameter Integer decimalSpaces = 1 "Accuracy to be displayed";
      parameter Boolean largeFonts = simCenter.largeFonts "True if visualisers shall be displayed as large as posible";
      outer ClaRa.SimCenter simCenter;
      Modelica.Blocks.Interfaces.RealOutput y = u_aux if provideConnector;
      Modelica.Blocks.Interfaces.RealInput u = u_aux if provideConnector;
    protected
      Real u_aux annotation(Hide = false);
    equation
      if not provideConnector then
        u_aux = x1;
      end if;
    end DynDisplay;

    model Quadruple  " Cross-shaped dynamic display of m_flow, p, T, h and m_flow" 
      parameter Integer identifier = 0 "Identifier of the quadruple";
      DecimalSpaces decimalSpaces "Accuracy to be displayed";
      parameter Boolean largeFonts = simCenter.largeFonts "True if visualisers shall be displayed as large as posible";
      Real p = eye.p "Pressure of state";
      Real h = eye.h "Specific enthalpy of state";
      Real s = eye.s "Specific enthalpy of state";
      Real T = eye.T "Temperature of state";
      Real m_flow = eye.m_flow "Mass flow rate";

      record DecimalSpaces  
        extends ClaRa.Basics.Icons.RecordIcon;
        parameter Integer T = 1 "Accuracy to be displayed for temperature";
        parameter Integer m_flow = 1 "Accuracy to be displayed for mass flow";
        parameter Integer h = 1 "Accuracy to be displayed for enthalpy";
        parameter Integer p = 1 "Accuracy to be displayed for pressure";
      end DecimalSpaces;

      outer ClaRa.SimCenter simCenter;
      ClaRa.Basics.Interfaces.EyeIn eye;
    end Quadruple;

    model StatePoint_phTs  "Complete state definition for visualisation in ph, TS, hs-diagrams" 
      outer SimCenter simCenter;
      parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium to be used";
      parameter Integer stateViewerIndex = 0 "Index for StateViewer";
      ClaRa.Basics.Units.Pressure p "Pressure of state";
      ClaRa.Basics.Units.EnthalpyMassSpecific h "Specific enthalpy of state";
      ClaRa.Basics.Units.EntropyMassSpecific s = state.s "Specific enthalpy of state";
      ClaRa.Basics.Units.Temperature T = state.T "Temperature of state";
      ClaRa.Basics.Units.VolumeMassSpecific v = 1 / state.d "Specific volume of state";
      ClaRa.Basics.Interfaces.FluidPortIn port(Medium = medium);
    protected
      TILMedia.VLEFluid_ph state(p = p, h = h, vleFluidType = medium);
    equation
      h = inStream(port.h_outflow);
      p = port.p;
      port.m_flow = 0;
      port.h_outflow = 0;
    end StatePoint_phTs;

    model DynamicBar  
      parameter Real u_max = 1 "Upper boundary for visualised variable";
      parameter Real u_min = 0 "Lower boundary for visualised variable";
      parameter String unit = "" "The input's unit";
      parameter Integer decimalSpaces = 1 "Accuracy to be displayed";
      parameter Boolean provideInputConnectors = false "If true connectors for the inputs are provided";
      parameter Boolean provideLimitsConnectors = false "If true connectors for the limits and set values are provided";
      parameter Boolean provideOutputConnector = false "If true an output connector y is provided";
      input Real u = 0 "Variable to be visualised";
      input Real u_set = 0.5 "Set Value of filling level";
      input Real u_high = 0.6 "High input threshold";
      input Real u_low = 0.4 "Low input threshold";
      Modelica.Blocks.Interfaces.RealInput u_in = u_int if provideInputConnectors;
      Modelica.Blocks.Interfaces.RealInput u_set_in = u_set_int if provideLimitsConnectors;
      Modelica.Blocks.Interfaces.RealInput u_low_in = u_low_int if provideLimitsConnectors;
      Modelica.Blocks.Interfaces.RealInput u_high_in = u_high_int if provideLimitsConnectors;
      Modelica.Blocks.Interfaces.RealOutput y = u_int if provideOutputConnector;
    protected
      Real u_int annotation(Hide = false);
      Real u_set_int annotation(Hide = false);
      Real u_low_int annotation(Hide = false);
      Real u_high_int annotation(Hide = false);
    equation
      assert(u_min < u_low and u_low < u_set and u_set < u_high and u_high < u_max, "The parameters in " + getInstanceName() + " have the following constraints: u_min < u_low < u_set < u_high < u_max.");
      if not provideInputConnectors then
        u_int = u;
      end if;
      if not provideLimitsConnectors then
        u_set_int = u_set;
        u_low_int = u_low;
        u_high_int = u_high;
      end if;
    end DynamicBar;
  end Visualisation;

  package StaticCycles  "Prepare initialisation even more easy!" 
    extends ClaRa.Basics.Icons.PackageIcons.CycleInit100;

    package Check  
      extends ClaRa.Basics.Icons.PackageIcons.CycleInitb80;

      package StaticCycleExamples  "Examples of static cycles" 
        extends Basics.Icons.PackageIcons.CycleInitb80;

        model InitSteamCycle_01  
          extends ClaRa.Basics.Icons.Init;
          outer ClaRa.SimCenter simCenter;
          parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
          parameter .ClaRa.Basics.Units.MassFlowRate m_flow_nom = 420;
          inner parameter Real P_target_ = 1;
          parameter .ClaRa.Basics.Units.Pressure p_condenser = 3800;
          parameter .ClaRa.Basics.Units.Pressure preheater_HP_p_tap = 55.95e5;
          parameter .ClaRa.Basics.Units.MassFlowRate preheater_HP_m_flow_tap = 42.812;
          parameter .ClaRa.Basics.Units.Pressure preheater_LP1_p_tap = 4.5e5;
          parameter .ClaRa.Basics.Units.MassFlowRate preheater_LP1_m_flow_tap = 29;
          parameter .ClaRa.Basics.Units.Pressure preheater_LP2_p_tap = 1e5 - 0.05e5;
          parameter .ClaRa.Basics.Units.MassFlowRate preheater_LP2_m_flow_tap = 17;
          parameter .ClaRa.Basics.Units.Pressure preheater_LP3_p_tap = 0.25e5;
          parameter .ClaRa.Basics.Units.MassFlowRate preheater_LP3_m_flow_tap = 4;
          parameter .ClaRa.Basics.Units.Pressure preheater_LP4_p_tap = 0.1e5 - 0.004e5;
          parameter .ClaRa.Basics.Units.MassFlowRate preheater_LP4_m_flow_tap = 8;
          parameter .ClaRa.Basics.Units.Pressure p_FWT = 12.4e5;
          parameter .ClaRa.Basics.Units.Length downComer_z_in = 0;
          parameter .ClaRa.Basics.Units.Length downComer_z_out = -8;
          parameter .ClaRa.Basics.Units.Pressure downComer_Delta_p_nom = 1e4;
          parameter .ClaRa.Basics.Units.PressureDifference valve_HP_Delta_p_nom = 11e5;
          parameter .ClaRa.Basics.Units.PressureDifference valve_LP1_Delta_p_nom = 0.05e5;
          parameter .ClaRa.Basics.Units.PressureDifference valve_LP2_Delta_p_nom = 0.01e5;
          parameter .ClaRa.Basics.Units.PressureDifference valve_LP3_Delta_p_nom = 0.004e5;
          parameter .ClaRa.Basics.Units.PressureDifference valvePreFeedWaterTank_Delta_p_nom = 0.001e5;
          parameter .ClaRa.Basics.Units.Temperature T_LS_nom = 823;
          parameter .ClaRa.Basics.Units.Temperature T_RS_nom = 833;
          parameter .ClaRa.Basics.Units.Pressure p_LS_out_nom = 262e5;
          parameter .ClaRa.Basics.Units.Pressure p_RS_out_nom = 51e5;
          parameter .ClaRa.Basics.Units.PressureDifference Delta_p_LS_nom = 40e5;
          parameter .ClaRa.Basics.Units.PressureDifference Delta_p_RS_nom = 5e5;
          parameter Real[:, :] CharLine_Delta_p_HP_mLS_ = [0, 0; 0.1, 0.01; 0.2, 0.04; 0.3, 0.09; 0.4, 0.16; 0.5, 0.25; 0.6, 0.36; 0.7, 0.49; 0.8, 0.64; 0.9, 0.81; 1, 1] "Characteristic line of pressure drop as function of mass flow rate";
          parameter Real[:, :] CharLine_Delta_p_IP_mRS_ = [0, 0; 0.1, 0.01; 0.2, 0.04; 0.3, 0.09; 0.4, 0.16; 0.5, 0.25; 0.6, 0.36; 0.7, 0.49; 0.8, 0.64; 0.9, 0.81; 1, 1] "Characteristic line of pressure drop as function of mass flow rate";
          parameter Real efficiency_Pump_cond = 1;
          parameter Real efficiency_Pump_preheater_LP1 = 1;
          parameter Real efficiency_Pump_preheater_LP3 = 1;
          parameter Real efficiency_Pump_FW = 1;
          parameter .ClaRa.Basics.Units.Pressure IP1_pressure = 26e5;
          parameter .ClaRa.Basics.Units.Pressure IP2_pressure = 14e5;
          parameter .ClaRa.Basics.Units.Pressure IP3_pressure = 5e5;
          parameter Real efficiency_Turb_HP = 1;
          parameter Real efficiency_Turb_IP1 = 1;
          parameter Real efficiency_Turb_IP2 = 1;
          parameter Real efficiency_Turb_IP3 = 1;
          parameter Real efficiency_Turb_LP1 = 1;
          parameter Real efficiency_Turb_LP2 = 1;
          parameter Real efficiency_Turb_LP3 = 1;
          parameter Real efficiency_Turb_LP4 = 1;
          HeatExchanger.Condenser condenser(p_condenser = p_condenser);
          Machines.Pump1 Pump_cond(efficiency = efficiency_Pump_cond);
          HeatExchanger.Preheater1 preheater_LP1(p_tap_nom = preheater_LP1_p_tap, m_flow_tap_nom = preheater_LP1_m_flow_tap);
          Machines.Pump1 pump_preheater_LP1(efficiency = efficiency_Pump_preheater_LP1);
          ValvesConnects.Valve_dp_nom3 valvePreFeedWaterTank(Delta_p_nom = valvePreFeedWaterTank_Delta_p_nom);
          Storage.Feedwatertank4 feedwatertank(m_flow_nom = m_flow_nom * P_target_, p_FWT_nom = p_FWT);
          Fittings.Mixer1 join_LP_main;
          Machines.Pump1 Pump_FW(efficiency = efficiency_Pump_FW);
          HeatExchanger.Preheater1 preheater_HP(m_flow_tap_nom = preheater_HP_m_flow_tap, p_tap_nom = preheater_HP_p_tap);
          Furnace.Boiler_simple boiler(T_LS_nom = T_LS_nom, T_RS_nom = T_RS_nom, Delta_p_LS_nom = Delta_p_LS_nom, Delta_p_RS_nom = Delta_p_RS_nom, p_LS_out_nom = p_LS_out_nom, p_RS_out_nom = p_RS_out_nom, CharLine_Delta_p_HP_mLS_ = CharLine_Delta_p_HP_mLS_, CharLine_Delta_p_IP_mRS_ = CharLine_Delta_p_IP_mRS_, m_flow_LS_nom = m_flow_nom, m_flow_RS_nom = m_flow_nom);
          Machines.Turbine Turbine_HP(efficiency = efficiency_Turb_HP);
          Fittings.Split1 join_HP;
          ValvesConnects.Valve_dp_nom1 valve_HP(Delta_p_nom = valve_HP_Delta_p_nom);
          ValvesConnects.Valve_cutPressure1 valve_cut;
          ValvesConnects.Valve_cutPressure1 valve2_HP;
          Machines.Turbine Turbine_IP1(efficiency = efficiency_Turb_IP1);
          Machines.Turbine Turbine_LP1(efficiency = efficiency_Turb_LP1);
          Fittings.Split1 split_LP1;
          ValvesConnects.Valve_cutPressure2 valve_IP1;
          ValvesConnects.Valve_dp_nom1 valve_LP1(Delta_p_nom = valve_LP1_Delta_p_nom);
          Machines.Turbine Turbine_LP4(efficiency = efficiency_Turb_LP4);
          Triple triple;
          Triple triple1;
          Triple triple2;
          Triple triple3;
          Triple triple5;
          Triple triple6(decimalSpaces(p = 2));
          Triple triple7;
          Triple triple8;
          Triple triple9(decimalSpaces(p = 2));
          Triple triple10;
          Triple triple11;
          Triple triple12;
          Triple triple13;
          Triple triple15;
          Triple triple16;
          Triple triple17;
          Triple triple18;
          Triple triple19;
          Triple triple20;
          Machines.Turbine Turbine_IP2(efficiency = efficiency_Turb_IP2);
          Machines.Turbine Turbine_IP3(efficiency = efficiency_Turb_IP3);
          Fittings.Split2 splitIP2(p_nom = IP2_pressure);
          Fittings.Split2 splitIP3(p_nom = IP3_pressure);
          ValvesConnects.PressureAnchor_constFlow1 pressureAnchor_constFlow1_1(p_nom = IP1_pressure);
          Machines.Turbine Turbine_LP3(efficiency = efficiency_Turb_LP3);
          Machines.Turbine Turbine_LP2(efficiency = efficiency_Turb_LP2);
          ValvesConnects.Valve_cutPressure1 valve2;
          Fittings.Mixer3 mixerIP2;
          HeatExchanger.Preheater1 preheater_LP2(p_tap_nom = preheater_LP2_p_tap, m_flow_tap_nom = preheater_LP2_m_flow_tap);
          HeatExchanger.Preheater1 preheater_LP3(p_tap_nom = preheater_LP3_p_tap, m_flow_tap_nom = preheater_LP3_m_flow_tap + preheater_LP2_m_flow_tap);
          HeatExchanger.Preheater1 preheater_LP4(p_tap_nom = preheater_LP4_p_tap, m_flow_tap_nom = preheater_LP4_m_flow_tap);
          ValvesConnects.Valve_cutPressure2 valve_IP2;
          Fittings.Split1 split_LP2;
          Fittings.Split1 split_LP3;
          ValvesConnects.Valve_dp_nom1 valve_LP2(Delta_p_nom = valve_LP2_Delta_p_nom);
          ValvesConnects.Valve_dp_nom1 valve_LP3(Delta_p_nom = valve_LP3_Delta_p_nom);
          Machines.Pump1 pump_preheater_LP3(efficiency = efficiency_Pump_preheater_LP3);
          Fittings.Mixer1 join_preheater_LP3;
          ValvesConnects.Valve_cutPressure1 valve_cutPressureLP4;
          Fittings.Mixer2 mixer_condenser;
          Triple triple4;
          Triple triple14;
          Triple triple21;
          Triple triple22;
          Triple triple23;
          Triple triple24;
          Triple triple25(decimalSpaces(p = 2));
          Triple triple26(decimalSpaces(p = 2));
          Triple triple27;
          Triple triple28;
          Triple triple29;
          Triple triple30;
          Triple triple31(decimalSpaces(p = 2));
          ValvesConnects.Tube2 downComer_feedWaterTank(z_in = downComer_z_in, Delta_p_nom = downComer_Delta_p_nom, z_out = downComer_z_out);
          Triple triple32;
        equation
          connect(pump_preheater_LP1.inlet, preheater_LP1.tap_out);
          connect(pump_preheater_LP1.outlet, join_LP_main.inlet_2);
          connect(join_LP_main.outlet, feedwatertank.cond_in);
          connect(preheater_HP.cond_in, Pump_FW.outlet);
          connect(boiler.liveSteam, Turbine_HP.inlet);
          connect(Turbine_HP.outlet, join_HP.inlet);
          connect(valve_HP.inlet, join_HP.outlet_2);
          connect(valve_HP.outlet, preheater_HP.tap_in);
          connect(valve_cut.inlet, join_HP.outlet_1);
          connect(valve2_HP.inlet, preheater_HP.tap_out);
          connect(Turbine_LP1.outlet, split_LP1.inlet);
          connect(split_LP1.outlet_2, valve_LP1.inlet);
          connect(Turbine_LP4.outlet, condenser.inlet);
          connect(valvePreFeedWaterTank.outlet, join_LP_main.inlet_1);
          connect(preheater_LP1.cond_out, valvePreFeedWaterTank.inlet);
          connect(triple.steamSignal, Turbine_HP.outlet);
          connect(triple1.steamSignal, Turbine_IP1.outlet);
          connect(triple2.steamSignal, boiler.liveSteam);
          connect(triple5.steamSignal, Turbine_LP1.outlet);
          connect(triple6.steamSignal, Turbine_LP4.outlet);
          connect(triple7.steamSignal, valve_LP1.outlet);
          connect(triple10.steamSignal, Pump_FW.inlet);
          connect(triple11.steamSignal, feedwatertank.cond_in);
          connect(triple12.steamSignal, Pump_FW.outlet);
          connect(triple13.steamSignal, preheater_HP.cond_out);
          connect(triple15.steamSignal, join_HP.outlet_2);
          connect(triple16.steamSignal, preheater_HP.tap_out);
          connect(triple17.steamSignal, preheater_LP1.tap_out);
          connect(triple18.steamSignal, preheater_LP1.cond_out);
          connect(triple19.steamSignal, Pump_cond.outlet);
          connect(triple20.steamSignal, valve_IP1.outlet);
          connect(valve_IP1.outlet, feedwatertank.tap_in2);
          connect(valve2_HP.outlet, feedwatertank.tap_in1);
          connect(triple8.steamSignal, valve2_HP.outlet);
          connect(boiler.hotReheat, Turbine_IP1.inlet);
          connect(boiler.hotReheat, triple3.steamSignal);
          connect(valve_cut.outlet, boiler.coldReheat);
          connect(preheater_HP.cond_out, boiler.feedWater);
          connect(Turbine_IP2.outlet, splitIP2.inlet);
          connect(splitIP2.outlet_1, Turbine_IP3.inlet);
          connect(Turbine_IP3.outlet, splitIP3.inlet);
          connect(splitIP2.outlet_2, valve_IP1.inlet);
          connect(Turbine_IP1.outlet, pressureAnchor_constFlow1_1.inlet);
          connect(pressureAnchor_constFlow1_1.outlet, Turbine_IP2.inlet);
          connect(splitIP3.outlet_1, Turbine_LP1.inlet);
          connect(split_LP1.outlet_1, Turbine_LP2.inlet);
          connect(splitIP3.outlet_2, valve_IP2.inlet);
          connect(valve_IP2.outlet, preheater_LP1.tap_in);
          connect(valve_LP1.outlet, preheater_LP2.tap_in);
          connect(preheater_LP2.cond_out, preheater_LP1.cond_in);
          connect(preheater_LP2.tap_out, valve2.inlet);
          connect(valve2.outlet, mixerIP2.inlet_1);
          connect(mixerIP2.outlet, preheater_LP3.tap_in);
          connect(Turbine_LP2.outlet, split_LP2.inlet);
          connect(split_LP2.outlet_1, Turbine_LP3.inlet);
          connect(Turbine_LP3.outlet, split_LP3.inlet);
          connect(split_LP3.outlet_1, Turbine_LP4.inlet);
          connect(split_LP2.outlet_2, valve_LP2.inlet);
          connect(valve_LP2.outlet, mixerIP2.inlet_2);
          connect(split_LP3.outlet_2, valve_LP3.inlet);
          connect(valve_LP3.outlet, preheater_LP4.tap_in);
          connect(Pump_cond.outlet, preheater_LP4.cond_in);
          connect(preheater_LP4.cond_out, preheater_LP3.cond_in);
          connect(preheater_LP3.cond_out, join_preheater_LP3.inlet_1);
          connect(join_preheater_LP3.outlet, preheater_LP2.cond_in);
          connect(preheater_LP3.tap_out, pump_preheater_LP3.inlet);
          connect(pump_preheater_LP3.outlet, join_preheater_LP3.inlet_2);
          connect(condenser.outlet, mixer_condenser.inlet_1);
          connect(mixer_condenser.outlet, Pump_cond.inlet);
          connect(valve_cutPressureLP4.outlet, mixer_condenser.inlet_2);
          connect(preheater_LP4.tap_out, valve_cutPressureLP4.inlet);
          connect(triple4.steamSignal, valve_IP2.outlet);
          connect(preheater_LP2.cond_out, triple14.steamSignal);
          connect(preheater_LP3.cond_out, triple21.steamSignal);
          connect(triple22.steamSignal, valve_LP2.outlet);
          connect(triple23.steamSignal, valve_LP3.outlet);
          connect(triple24.steamSignal, preheater_LP4.cond_out);
          connect(triple25.steamSignal, Turbine_LP3.outlet);
          connect(triple26.steamSignal, Turbine_LP2.outlet);
          connect(triple27.steamSignal, Turbine_IP2.outlet);
          connect(triple28.steamSignal, Turbine_IP3.outlet);
          connect(pump_preheater_LP3.outlet, triple29.steamSignal);
          connect(valve2.outlet, triple30.steamSignal);
          connect(condenser.outlet, triple9.steamSignal);
          connect(valve_cutPressureLP4.outlet, triple31.steamSignal);
          connect(feedwatertank.cond_out, downComer_feedWaterTank.inlet);
          connect(downComer_feedWaterTank.outlet, Pump_FW.inlet);
          connect(valve_cut.outlet, triple32.steamSignal);
        end InitSteamCycle_01;
      end StaticCycleExamples;
    end Check;

    package Fundamentals  
      extends ClaRa.Basics.Icons.PackageIcons.CycleInit80;

      connector SteamSignal_base  "Signal-based steam connector || basic||" 
        ClaRa.Basics.Units.Pressure p;
        ClaRa.Basics.Units.EnthalpyMassSpecific h;
        ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_base;

      connector SteamSignal_blue_a  "Signal-based steam connector" 
        output ClaRa.Basics.Units.Pressure p;
        input ClaRa.Basics.Units.EnthalpyMassSpecific h;
        input ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_blue_a;

      connector SteamSignal_blue_b  "Signal-based steam connector" 
        input ClaRa.Basics.Units.Pressure p;
        output ClaRa.Basics.Units.EnthalpyMassSpecific h;
        output ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_blue_b;

      connector SteamSignal_green_a  "Signal-based steam connector" 
        input ClaRa.Basics.Units.Pressure p;
        input ClaRa.Basics.Units.EnthalpyMassSpecific h;
        input ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_green_a;

      connector SteamSignal_green_b  "Signal-based steam connector" 
        output ClaRa.Basics.Units.Pressure p;
        output ClaRa.Basics.Units.EnthalpyMassSpecific h;
        output ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_green_b;

      connector SteamSignal_red_a  "Signal-based steam connector" 
        output ClaRa.Basics.Units.Pressure p;
        input ClaRa.Basics.Units.EnthalpyMassSpecific h;
        output ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_red_a;

      connector SteamSignal_red_b  "Signal-based steam connector" 
        input ClaRa.Basics.Units.Pressure p;
        output ClaRa.Basics.Units.EnthalpyMassSpecific h;
        input ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_red_b;

      connector SteamSignal_yellow_a  "Signal-based steam connector" 
        input ClaRa.Basics.Units.Pressure p;
        input ClaRa.Basics.Units.EnthalpyMassSpecific h;
        output ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_yellow_a;

      connector SteamSignal_yellow_b  "Signal-based steam connector" 
        output ClaRa.Basics.Units.Pressure p;
        output ClaRa.Basics.Units.EnthalpyMassSpecific h;
        input ClaRa.Basics.Units.MassFlowRate m_flow;
      end SteamSignal_yellow_b;
    end Fundamentals;

    model Triple  "Visualise static cycle results" 
      parameter Integer stacy_id = 0 "Identifier of the static cycle triple";
      DecimalSpaces decimalSpaces "Accuracy to be displayed";
      final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Measured mass flow rate";
      final parameter ClaRa.Basics.Units.Pressure p(fixed = false) "Measured mass flow rate";
      final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h(fixed = false) "Measured mass flow rate";

      record DecimalSpaces  
        parameter Integer m_flow = 1 "Accuracy to be displayed for mass flow";
        parameter Integer h = 1 "Accuracy to be displayed for enthalpy";
        parameter Integer p = 1 "Accuracy to be displayed for pressure";
      end DecimalSpaces;

      Fundamentals.SteamSignal_base steamSignal;
    initial equation
      m_flow = steamSignal.m_flow;
      p = steamSignal.p;
      h = steamSignal.h;
    end Triple;

    package HeatExchanger  "Heat exchangers for the StaticCycles package" 
      extends ClaRa.Basics.Icons.PackageIcons.CycleInit80;

      model Preheater1  "Preheater || bubble state at shell outlet || par.: shell pressure, shell m_flow || cond: blue | blue || tap: red | green" 
        outer ClaRa.SimCenter simCenter;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet_cond;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet_cond;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet_tap;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet_tap;
        end Summary;

        Summary summary(inlet_cond(m_flow = m_flow_cond, h = h_cond_in, p = p_cond), outlet_cond(m_flow = m_flow_cond, h = h_cond_out, p = p_cond), inlet_tap(m_flow = m_flow_tap, h = h_tap_in, p = p_tap), outlet_tap(m_flow = m_flow_tap, h = h_tap_out, p = p_tap_out));
        outer parameter Real P_target_ "Target power in p.u.";
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        parameter ClaRa.Basics.Units.Pressure p_tap_nom "Nominal pressure of heating steam";
        parameter ClaRa.Basics.Units.MassFlowRate m_flow_tap_nom "Nominal mass flow rate of heating steam";
        parameter ClaRa.Basics.Units.EnthalpyMassSpecific Delta_h_tap_out_sc = 0 "Enthalpy difference to bubble enthalpy of tapping outlet enthalpy";
        parameter ClaRa.Basics.Units.Length level_abs = 0 "Filling level in hotwell";
        final parameter ClaRa.Basics.Units.Pressure p_cond(fixed = false);
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_cond(fixed = false) "Mass flow of the condensate";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_tap(fixed = false) "Mass flow of the heating steam";
        final parameter ClaRa.Basics.Units.Pressure p_tap(fixed = false) "Pressure of the heating steam";
        final parameter ClaRa.Basics.Units.Pressure p_tap_out = p_tap + Modelica.Constants.g_n * TILMedia.VLEFluidFunctions.bubbleDensity_pxi(medium, p_tap) * level_abs "Pressure at condensed tapping outlet";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_tap_in(fixed = false) "Spec. enthalpy of tapping";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_cond_in(fixed = false) "Spec. enthalpy of condensate inlet";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_tap_out = TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium, p_tap) - Delta_h_tap_out_sc "Spec. enthalpy at condensed tapping outlet";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_cond_out = m_flow_tap * (h_tap_in - h_tap_out) / m_flow_cond + h_cond_in "Spec. enthalpy at condenate outlet";
        parameter Real[:, 2] CharLine_p_tap_P_target_ = [0, 1; 1, 1] "Characteristic line of p_tap as function of P_target_";
        parameter Real[:, 2] CharLine_m_flow_tap_P_target_ = [0, 1; 1, 1] "Characteristic line of m_flow_tap as function of P_target_";
      protected
        Modelica.Blocks.Tables.CombiTable1D table1(table = CharLine_p_tap_P_target_, u = {P_target_});
        Modelica.Blocks.Tables.CombiTable1D table2(table = CharLine_m_flow_tap_P_target_, u = {P_target_});
        final parameter Boolean isFilled = level_abs > 0 "Reprt: True if vessel is filled";
      public
        Fundamentals.SteamSignal_blue_a cond_in(p = p_cond);
        Fundamentals.SteamSignal_blue_b cond_out(h = h_cond_out, m_flow = m_flow_cond);
        Fundamentals.SteamSignal_red_a tap_in(p = p_tap, m_flow = m_flow_tap);
        Fundamentals.SteamSignal_green_b tap_out(h = h_tap_out, p = p_tap_out, m_flow = m_flow_tap);
      initial equation
        p_tap = p_tap_nom * table1.y[1];
        m_flow_tap = m_flow_tap_nom * table2.y[1];
        h_tap_in = tap_in.h;
        h_cond_in = cond_in.h;
        m_flow_cond = cond_in.m_flow;
        cond_out.p = p_cond;
      end Preheater1;

      model Condenser  "Condenser || par.: pressure, level_abs || blue |green" 
        outer ClaRa.SimCenter simCenter;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet(m_flow = m_flow_in, h = h_in, p = p_in), outlet(m_flow = m_flow_in, h = h_out, p = p_out));
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        parameter ClaRa.Basics.Units.Pressure p_condenser = 4000 "|Fundamental Definitions|Condenser pressure";
        parameter ClaRa.Basics.Units.Length level_abs(min = 0) = 0 "|Fundamental Definitions|Filling level in hotwell";
        final parameter ClaRa.Basics.Units.Pressure p_in = p_condenser "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_out = p_condenser + Modelica.Constants.g_n * TILMedia.VLEFluidFunctions.bubbleDensity_pxi(medium, p_condenser) * level_abs "Outlet pressure";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium, p_condenser) "Outlet enthalpy";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_in(fixed = false) "Inlet mass flow";
      protected
        final parameter Boolean isFilled = level_abs > 0 "Reprt: True if vessel is filled";
      public
        Fundamentals.SteamSignal_blue_a inlet(p = p_condenser);
        Fundamentals.SteamSignal_green_b outlet(h = h_out, p = p_out, m_flow = m_flow_in);
      initial equation
        inlet.m_flow = m_flow_in;
        inlet.h = h_in;
      end Condenser;
    end HeatExchanger;

    package ValvesConnects  "Valves and other (dis)continuous Connects like tubes" 
      extends ClaRa.Basics.Icons.PackageIcons.CycleInit80;

      model Tube2  " Tube || green | green" 
        outer ClaRa.SimCenter simCenter;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p_in), outlet(m_flow = m_flow, h = h_in, p = p_out));
        outer parameter Real P_target_ "Target power in p.u.";
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        parameter ClaRa.Basics.Units.Pressure Delta_p_nom "Nominal pressure loss";
        parameter Real[:, 2] CharLine_Delta_p_fric_P_target_ = [0, 0; 1, 1] "Characteristic line of friction loss as function of mass flow rate";
        parameter ClaRa.Basics.Units.Length z_in = 0.0 "Geodetic height at inlet";
        parameter ClaRa.Basics.Units.Length z_out = 0.0 "Geodetic height at outlet";
        parameter ClaRa.Basics.Units.Length[:] Delta_x = fill(abs(z_in - z_out) / 3, 3) "Discretisation scheme";
        parameter Boolean frictionAtInlet = false "True if pressure loss between first cell and inlet shall be considered";
        parameter Boolean frictionAtOutlet = false "True if pressure loss between last cell and outlet shall be considered";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Mass flow through pipe";
        final parameter ClaRa.Basics.Units.Pressure p_out = p_in - Delta_p_fric - Delta_p_geo "pressure at tube inlet";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "enthalpy at tube inlet";
        constant ClaRa.Basics.Units.MassFraction[:] xi = zeros(medium.nc - 1);
        final parameter ClaRa.Basics.Units.Pressure Delta_p_geo = TILMedia.VLEFluidFunctions.density_phxi(medium, p_in, h_in, xi) * Modelica.Constants.g_n * (z_out - z_in) "Geostatic pressure difference";
        final parameter ClaRa.Basics.Units.Pressure p_in(fixed = false) "Inlet pressure";
        final parameter Integer N_cv = size(Delta_x, 1) "Number of finite volumes";
        final parameter ClaRa.Basics.Units.PressureDifference Delta_p_fric(fixed = false) "Actual friction pressure loss";
        final parameter ClaRa.Basics.Units.Pressure[N_cv] p = Basics.Functions.pressureInterpolation(p_in, p_out, Delta_x, frictionAtInlet, frictionAtOutlet) "Rprt: Discretisised pressure";
      protected
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table(table = CharLine_Delta_p_fric_P_target_, u = {P_target_});
      public
        Fundamentals.SteamSignal_green_a inlet;
        Fundamentals.SteamSignal_green_b outlet(m_flow = m_flow, h = h_in, p = p_out);
      initial equation
        Delta_p_fric = table.y[1] * Delta_p_nom;
        inlet.p = p_in;
        inlet.m_flow = m_flow;
        inlet.h = h_in;
      end Tube2;

      model Valve_dp_nom1  "Valve || par.: dp_nom || red | red" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p_in), outlet(m_flow = m_flow, h = h_out, p = p_out));
        outer parameter Real P_target_ "Target power in p.u.";
        parameter ClaRa.Basics.Units.Pressure Delta_p_nom "Nominal pressure drop";
        parameter Real[:, 2] CharLine_Delta_p_P_target_ = [0, 0; 1, 1] "Pressure drop depending on rel. power in p.u.";
        final parameter ClaRa.Basics.Units.Pressure p_in = p_out + Delta_p "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_out(fixed = false) "Outlet pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Mass flow rate";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = h_in "Outlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.PressureDifference Delta_p(fixed = false) "Actual pressure drop";
      protected
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table1(table = CharLine_Delta_p_P_target_, u = {P_target_});
      public
        Fundamentals.SteamSignal_red_a inlet(p = p_in, m_flow = m_flow);
        Fundamentals.SteamSignal_red_b outlet(h = h_out);
      initial equation
        outlet.p = p_out;
        inlet.h = h_in;
        outlet.m_flow = m_flow;
        Delta_p = table1.y[1] * Delta_p_nom;
      end Valve_dp_nom1;

      model Valve_dp_nom3  "Valve || par.: dp_nom || blue | blue" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p_in), outlet(m_flow = m_flow, h = h_out, p = p_out));
        outer parameter Real P_target_ "Target power in p.u.";
        parameter ClaRa.Basics.Units.PressureDifference Delta_p_nom "Nominal pressure drop";
        parameter Real[:, 2] CharLine_Delta_p_P_target_ = [0, 0; 1, 1] "Pressure drop depending on rel. power in p.u.";
        final parameter ClaRa.Basics.Units.Pressure p_in = p_out + Delta_p "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_out(fixed = false) "Outlet pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Mass flow rate";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = h_in "Outlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.PressureDifference Delta_p(fixed = false) "Actual pressur drop";
      protected
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table1(table = CharLine_Delta_p_P_target_, u = {P_target_});
      public
        Fundamentals.SteamSignal_blue_a inlet(p = p_in);
        Fundamentals.SteamSignal_blue_b outlet(h = h_out, m_flow = m_flow);
      initial equation
        inlet.h = h_in;
        inlet.m_flow = m_flow;
        outlet.p = p_out;
        Delta_p = table1.y[1] * Delta_p_nom;
      end Valve_dp_nom3;

      model Valve_cutPressure1  "Valve || green | blue" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p_in), outlet(m_flow = m_flow, h = h_out, p = p_out));
        final parameter ClaRa.Basics.Units.Pressure p_in(fixed = false) "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_out(fixed = false) "Outlet pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Mass flow rate";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = h_in "Outlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.Pressure Delta_p_nom = p_out - p_in "Nominal pressure drop";
        final parameter ClaRa.Basics.Units.Pressure Delta_p = p_in - p_out "Pressure difference";
        Fundamentals.SteamSignal_green_a inlet;
        Fundamentals.SteamSignal_blue_b outlet(m_flow = m_flow, h = h_out);
      initial equation
        outlet.p = p_out;
        inlet.p = p_in;
        inlet.h = h_in;
        inlet.m_flow = m_flow;
      end Valve_cutPressure1;

      model Valve_cutPressure2  "Valve || yellow | red" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p_in), outlet(m_flow = m_flow, h = h_out, p = p_out));
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Mass flow rate";
        final parameter ClaRa.Basics.Units.Pressure p_in(fixed = false) "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_out(fixed = false) "Outlet pressure";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = h_in "Outlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.Pressure Delta_p = p_in - p_out "Pressure difference";
        Fundamentals.SteamSignal_yellow_a inlet(m_flow = m_flow);
        Fundamentals.SteamSignal_red_b outlet(h = h_out);
      initial equation
        outlet.p = p_out;
        inlet.p = p_in;
        inlet.h = h_in;
        outlet.m_flow = m_flow;
      end Valve_cutPressure2;

      model PressureAnchor_constFlow1  "Pressure fix point || blue | green" 
        parameter ClaRa.Basics.Units.Pressure p_nom "Pressure";

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p), outlet(m_flow = m_flow, h = h_out, p = p));
        parameter Real[:, :] CharLine_p_P_target_ = [0, 1; 1, 1] "Characteristic line of pressure drop as function of mass flow rate";
        final parameter ClaRa.Basics.Units.Pressure p(fixed = false) "Pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Mass flow rate";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = h_in "Outlet spec. enthalpy";
        outer parameter Real P_target_ "Target power in p.u.";
      protected
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table(table = CharLine_p_P_target_, u = {P_target_});
      public
        Fundamentals.SteamSignal_green_b outlet(m_flow = m_flow, h = h_out, p = p);
        Fundamentals.SteamSignal_blue_a inlet(p = p);
      initial equation
        p = table.y[1] * p_nom;
        inlet.h = h_in;
        inlet.m_flow = m_flow;
      end PressureAnchor_constFlow1;
    end ValvesConnects;

    package Machines  "Pumps, turbines and other machines for the StaticCycle package" 
      extends ClaRa.Basics.Icons.PackageIcons.CycleInit80;

      model Turbine  "Turbine || par.: efficiency || green | blue" 
        outer ClaRa.SimCenter simCenter;

        model Outline  
          extends ClaRa.Basics.Icons.RecordIcon;
          parameter Basics.Units.Pressure Delta_p "Pressure difference between outlet and inlet";
          parameter Basics.Units.Power P_turbine "Turbine power";
        end Outline;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
          Outline outline;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p_in), outlet(m_flow = m_flow, h = h_out, p = p_out), outline(Delta_p = Delta_p, P_turbine = P_turbine));
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        parameter Real efficiency = 1 "Hydraulic efficiency";
        final parameter ClaRa.Basics.Units.DensityMassSpecific rho_in = TILMedia.VLEFluidFunctions.density_phxi(medium, p_in, h_in) "Inlet density";
        final parameter ClaRa.Basics.Units.Power P_turbine = ((-h_out) + h_in) * m_flow "Rprt: Turbine power";
        final parameter ClaRa.Basics.Units.Pressure p_in(fixed = false) "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_out(fixed = false) "Outlet pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false, start = 1) "Mass flow rate";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet specific enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = h_in + efficiency * (TILMedia.VLEFluidFunctions.specificEnthalpy_psxi(medium, p_out, TILMedia.VLEFluidFunctions.specificEntropy_phxi(medium, p_in, h_in)) - h_in) "Outlet enthalpy";
        final parameter ClaRa.Basics.Units.PressureDifference Delta_p = p_in - p_out "Rprt: p_in - p_out";
        Fundamentals.SteamSignal_green_a inlet;
        Fundamentals.SteamSignal_blue_b outlet(h = h_out, m_flow = m_flow);
      initial equation
        inlet.m_flow = m_flow;
        inlet.p = p_in;
        inlet.h = h_in;
        outlet.p = p_out;
      end Turbine;

      model Pump1  "Ideal Pump || par.: efficiency || green | blue" 
        outer ClaRa.SimCenter simCenter;

        model Outline  
          extends ClaRa.Basics.Icons.RecordIcon;
          parameter Basics.Units.Pressure Delta_p "Pressure difference between outlet and inlet";
          parameter Basics.Units.Power P_pump "Pump power";
        end Outline;

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
          Outline outline;
        end Summary;

        Summary summary(inlet(m_flow = m_flow, h = h_in, p = p_in), outlet(m_flow = m_flow, h = h_out, p = p_out), outline(Delta_p = Delta_p, P_pump = P_pump));
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        parameter Real efficiency = 1 "Pump efficiency";
        final parameter ClaRa.Basics.Units.DensityMassSpecific rho_in = TILMedia.VLEFluidFunctions.bubbleDensity_pxi(medium, p_in) "Inlet density";
        final parameter ClaRa.Basics.Units.Power P_pump = (p_out - p_in) * m_flow / rho_in / efficiency "Pump power";
        final parameter ClaRa.Basics.Units.Pressure p_in(fixed = false) "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_out(fixed = false) "Outlet pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow(fixed = false) "Mass flow rate";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_in(fixed = false) "Inlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_out = h_in + P_pump / m_flow "Outlet spec. enthalpy";
        final parameter ClaRa.Basics.Units.PressureDifference Delta_p = p_in - p_out "Presssure differerence p_in - p_out";
        Fundamentals.SteamSignal_green_a inlet;
        Fundamentals.SteamSignal_blue_b outlet(m_flow = m_flow, h = h_out);
      initial equation
        inlet.h = h_in;
        inlet.p = p_in;
        inlet.m_flow = m_flow;
        outlet.p = p_out;
      end Pump1;
    end Machines;

    package Fittings  "Joins and splits for the Static Cycle package" 
      extends ClaRa.Basics.Icons.PackageIcons.CycleInit80;

      model Split1  "Split || blue | green | red" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet1;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet2;
        end Summary;

        Summary summary(inlet(m_flow = m_flow_1, h = h1, p = p), outlet1(m_flow = m_flow_2, h = h1, p = p), outlet2(m_flow = m_flow_3, h = h1, p = p));
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_2 = m_flow_1 - m_flow_3 "Mass flow rate of outlet 1";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_3(fixed = false) "Mass flow rate of outlet 2";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h1(fixed = false) "Specific enthalpy at inlet";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_1(fixed = false) "Mass flow rate of inlet";
        final parameter ClaRa.Basics.Units.Pressure p(fixed = false) "Mixer pressure";
        Fundamentals.SteamSignal_blue_a inlet(p = p);
        Fundamentals.SteamSignal_green_b outlet_1(m_flow = m_flow_2, h = h1, p = p);
        Fundamentals.SteamSignal_red_b outlet_2(h = h1);
      initial equation
        inlet.m_flow = m_flow_1;
        inlet.h = h1;
        outlet_2.p = p;
        outlet_2.m_flow = m_flow_3;
      end Split1;

      model Split2  "Split || blue | green | yellow" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet1;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet2;
        end Summary;

        Summary summary(inlet(m_flow = m_flow_1, h = h1, p = p), outlet1(m_flow = m_flow_2, h = h1, p = p), outlet2(m_flow = m_flow_3, h = h1, p = p));
        parameter ClaRa.Basics.Units.Pressure p_nom = 1e5 "Nominal split pressure";
        parameter Real[:, :] CharLine_p_P_target_ = [0, 1; 1, 1] "Characteristic line of pressure drop as function of mass flow rate";
        final parameter ClaRa.Basics.Units.Pressure p(fixed = false) "Split pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_2 = m_flow_1 - m_flow_3 "Mass flow rate of outlet 1";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_3(fixed = false) "Mass flow rate of outlet 2";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h1(fixed = false) "Spec. enthalpy at inlet";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_1(fixed = false) "Mass flow rate of inlet";
        outer parameter Real P_target_;
      protected
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table(table = CharLine_p_P_target_, u = {P_target_});
      public
        Fundamentals.SteamSignal_blue_a inlet(p = p);
        Fundamentals.SteamSignal_green_b outlet_1(m_flow = m_flow_2, h = h1, p = p);
        Fundamentals.SteamSignal_yellow_b outlet_2(h = h1, p = p);
      initial equation
        p = table.y[1] * p_nom;
        inlet.m_flow = m_flow_1;
        inlet.h = h1;
        outlet_2.m_flow = m_flow_3;
      end Split2;

      model Mixer1  "Mixer || blue | blue | blue" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet1;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet2;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet1(m_flow = m_flow_1, h = h1, p = p), inlet2(m_flow = m_flow_2, h = h2, p = p), outlet(m_flow = m_flow_3, h = h3, p = p));
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h1(fixed = false) "Specific enthalpy of flow 1";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h2(fixed = false) "Specific enthalpy of flow 2";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_1(fixed = false, start = 1) "Mass flow rate of flow 1";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_2(fixed = false, start = 1) "Mass flow rate of flow 2";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h3 = (h1 * m_flow_1 + h2 * m_flow_2) / m_flow_3 "Mixer outlet enthalpy";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_3 = m_flow_1 + m_flow_2 "Mixer outlet mass flow rate";
        final parameter ClaRa.Basics.Units.Pressure p(fixed = false) "Mixer pressure";
        Fundamentals.SteamSignal_blue_a inlet_1(p = p);
        Fundamentals.SteamSignal_blue_a inlet_2(p = p);
        Fundamentals.SteamSignal_blue_b outlet(h = h3, m_flow = m_flow_3);
      initial equation
        inlet_1.h = h1;
        inlet_1.m_flow = m_flow_1;
        inlet_2.h = h2;
        inlet_2.m_flow = m_flow_2;
        outlet.p = p;
      end Mixer1;

      model Mixer2  "Mixer || green | blue | green" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet1;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet2;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet1(m_flow = m_flow_1, h = h1, p = p), inlet2(m_flow = m_flow_2, h = h2, p = p), outlet(m_flow = m_flow_3, h = h3, p = p));
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h1(fixed = false) "Specific enthalpy of flow 1";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h2(fixed = false) "Specific enthalpy of flow 2";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_1(fixed = false) "Mass flow rate of flow 1";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_2(fixed = false) "Mass flow rate of flow 2";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h3 = (h1 * m_flow_1 + h2 * m_flow_2) / m_flow_3 "Mixer outlet enthalpy";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_3 = m_flow_1 + m_flow_2 "Mixer outlet mass flow rate";
        final parameter ClaRa.Basics.Units.Pressure p(fixed = false) "Mixer pressure";
        Fundamentals.SteamSignal_green_a inlet_1;
        Fundamentals.SteamSignal_blue_a inlet_2(p = p);
        Fundamentals.SteamSignal_green_b outlet(p = p, h = h3, m_flow = m_flow_3);
      initial equation
        inlet_1.p = p;
        inlet_1.h = h1;
        inlet_1.m_flow = m_flow_1;
        inlet_2.h = h2;
        inlet_2.m_flow = m_flow_2;
      end Mixer2;

      model Mixer3  "Mixer || blue | red | red" 
        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet1;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet2;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet;
        end Summary;

        Summary summary(inlet1(m_flow = m_flow_1, h = h1, p = p), inlet2(m_flow = m_flow_2, h = h2, p = p), outlet(m_flow = m_flow_3, h = h3, p = p));
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h1(fixed = false) "Specific enthalpy of flow 1";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h2(fixed = false) "Specific enthalpy of flow 2";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_1(fixed = false) "Mass flow rate of flow 1";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_2 = m_flow_3 - m_flow_1 "Mass flow rate of flow 2";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h3 = (h1 * m_flow_1 + h2 * m_flow_2) / m_flow_3 "Mixer outlet enthalpy";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_3(fixed = false) "Mixer outlet mass flow rate";
        final parameter ClaRa.Basics.Units.Pressure p(fixed = false) "Mixer pressure";
        Fundamentals.SteamSignal_blue_a inlet_1(p = p);
        Fundamentals.SteamSignal_red_a inlet_2(p = p, m_flow = m_flow_2);
        Fundamentals.SteamSignal_red_b outlet(h = h3);
      initial equation
        inlet_1.h = h1;
        inlet_1.m_flow = m_flow_1;
        inlet_2.h = h2;
        outlet.p = p;
        outlet.m_flow = m_flow_3;
      end Mixer3;
    end Fittings;

    package Storage  "Storage vessels for the Staticcycles package" 
      extends ClaRa.Basics.Icons.PackageIcons.CycleInit80;

      model Feedwatertank4  "Feedwatertank || par.: m_flow_FW, p_FW_nom || blue | blue | red | green" 
        outer parameter Real P_target_ "Target power in p.u.";

        model Summary  
          extends ClaRa.Basics.Icons.RecordIcon;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet_cond;
          ClaRa.Basics.Records.StaCyFlangeVLE outlet_cond;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet_tap1;
          ClaRa.Basics.Records.StaCyFlangeVLE inlet_tap2;
        end Summary;

        Summary summary(inlet_cond(m_flow = m_flow_cond, h = h_cond_in, p = p_FWT), outlet_cond(m_flow = m_flow_FW, h = h_cond_out, p = p_FWT_out), inlet_tap1(m_flow = m_flow_tap1, h = h_tap_in1, p = p_FWT), inlet_tap2(m_flow = m_flow_tap2, h = h_tap_in2, p = p_FWT));
        outer ClaRa.SimCenter simCenter;
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        parameter ClaRa.Basics.Units.Pressure p_FWT_nom "Feed water tank pressure at nominal load";
        parameter ClaRa.Basics.Units.MassFlowRate m_flow_nom "Mass flow rate at nomoinal load";
        parameter ClaRa.Basics.Units.Length level_abs = 0 "Filling level";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_tap_in1(fixed = false, start = 1) "Spec. enthalpy at tapping 1";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_tap_in2(fixed = false, start = 1) "Spec. enthalpy at tapping 1";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_cond_in(fixed = false) "Spec. enthalpy at condensate inlet";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_cond(fixed = false) "Condensate inlet flow";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_tap1(fixed = false) "Tapping 1 inlet flow";
        final parameter ClaRa.Basics.Units.Pressure p_FWT = P_target_ * p_FWT_nom "Feedwater tank pressure at current load";
        final parameter ClaRa.Basics.Units.Pressure p_FWT_out = p_FWT + Modelica.Constants.g_n * level_abs * TILMedia.VLEFluidFunctions.bubbleDensity_pxi(medium, p_FWT) "Feedwater tank condensate outlet pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_tap2 = (h_cond_out * m_flow_FW - h_cond_in * m_flow_cond - m_flow_tap1 * h_tap_in1) / h_tap_in2 "Mass flow of the heating steam";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_FW = P_target_ * m_flow_nom "Mass flow of the condensate";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_cond_out = TILMedia.VLEFluidFunctions.bubbleSpecificEnthalpy_pxi(medium, p_FWT) "Spec. enthalpy at feedwater outlet";
      protected
        final parameter Boolean isFilled = level_abs > 0 "Reprt: True if vessel is filled";
      public
        Fundamentals.SteamSignal_blue_a cond_in(p = p_FWT);
        Fundamentals.SteamSignal_red_a tap_in2(m_flow = m_flow_tap2, p = p_FWT);
        Fundamentals.SteamSignal_green_b cond_out(h = h_cond_out, p = p_FWT_out, m_flow = m_flow_FW);
        Fundamentals.SteamSignal_blue_a tap_in1(p = p_FWT);
      initial equation
        m_flow_cond = cond_in.m_flow;
        m_flow_tap1 = tap_in1.m_flow;
        h_tap_in1 = tap_in1.h;
        h_tap_in2 = tap_in2.h;
        h_cond_in = cond_in.h;
      end Feedwatertank4;
    end Storage;

    package Furnace  
      extends ClaRa.Basics.Icons.PackageIcons.CycleInit80;

      model Boiler_simple  "Boiler || HP: blue |green || IP: blue |green" 
        outer ClaRa.SimCenter simCenter;
        parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium = simCenter.fluid1 "Medium in the component";
        outer parameter Real P_target_ "Target power in p.u.";
        parameter ClaRa.Basics.Units.MassFlowRate m_flow_LS_nom "Live steam flow at nominal load";
        parameter ClaRa.Basics.Units.MassFlowRate m_flow_RS_nom "Reheated steam flow at nominal load";
        parameter ClaRa.Basics.Units.Temperature T_LS_nom "Live steam temperature at nominal load";
        parameter ClaRa.Basics.Units.Temperature T_RS_nom "Reheated steam temperature at nominal load";
        parameter ClaRa.Basics.Units.Pressure Delta_p_LS_nom "Live steam pressure loss at nominal load";
        parameter ClaRa.Basics.Units.Pressure Delta_p_RS_nom "Reheat steam pressure loss at nominal load";
        parameter ClaRa.Basics.Units.Pressure p_LS_out_nom "Live steam pressure at nominal load";
        parameter ClaRa.Basics.Units.Pressure p_RS_out_nom "Reheated steam pressure at nominal load";
        parameter Real[:, 2] CharLine_Delta_p_HP_mLS_ = [0, 0; 0.1, 0.01; 0.2, 0.04; 0.3, 0.09; 0.4, 0.16; 0.5, 0.25; 0.6, 0.36; 0.7, 0.49; 0.8, 0.64; 0.9, 0.81; 1, 1] "Characteristic line of LS pressure drop as function of mass flow rate";
        parameter Real[:, 2] CharLine_Delta_p_IP_mRS_ = [0, 0; 0.1, 0.01; 0.2, 0.04; 0.3, 0.09; 0.4, 0.16; 0.5, 0.25; 0.6, 0.36; 0.7, 0.49; 0.8, 0.64; 0.9, 0.81; 1, 1] "Characteristic line of RS pressure drop as function of mass flow rate";
        final parameter ClaRa.Basics.Units.HeatFlowRate Q_flow = m_flow_feed * (h_LS_out - h_LS_in) + m_flow_cRH * (h_RS_out - h_RS_in) "Rprt: Heating power";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_cRH(fixed = false) "Mass flow rate of cold Re-Heat ";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_LS_in(fixed = false) "Inlet specific enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_RS_in(fixed = false) "Inlet specific enthalpy";
      protected
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table1(table = CharLine_Delta_p_HP_mLS_, u = {m_flow_feed / m_flow_LS_nom});
        ClaRa.Components.Utilities.Blocks.ParameterizableTable1D table2(table = CharLine_Delta_p_IP_mRS_, u = {m_flow_cRH / m_flow_RS_nom});
      public
        final parameter Real Delta_p_LS_(fixed = false) "Rprt: current LS pressure loss";
        final parameter Real Delta_p_RS_(fixed = false) "Rprt: current RS pressure loss";
        final parameter Real Q_flow_LS_ = (h_LS_out - h_LS_in) * m_flow_feed / Q_flow "Rprt: Heat release in life steam at current load";
        final parameter Real Q_flow_RS_ = 1 - Q_flow_LS_ "Rprt: Heat release in reheated steam at current load";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_LS_out = TILMedia.VLEFluidFunctions.specificEnthalpy_pTxi(medium, p_LS_out, T_LS_nom) "Outlet specific enthalpy";
        final parameter ClaRa.Basics.Units.EnthalpyMassSpecific h_RS_out = TILMedia.VLEFluidFunctions.specificEnthalpy_pTxi(medium, p_RS_out, T_RS_nom) "Outlet specific enthalpy";
        final parameter ClaRa.Basics.Units.Pressure p_LS_in = p_LS_out + Delta_p_LS_ * Delta_p_LS_nom "Inlet pressure";
        final parameter ClaRa.Basics.Units.Pressure p_LS_out = P_target_ * p_LS_out_nom "Life steam pressure at current load";
        final parameter ClaRa.Basics.Units.Pressure p_RS_in = p_RS_out + Delta_p_RS_ * Delta_p_RS_nom "Inlet pressure";
        final parameter ClaRa.Basics.Units.MassFlowRate m_flow_feed(fixed = false) "HP inlet mass flow";
        final parameter ClaRa.Basics.Units.Pressure p_RS_out = P_target_ * p_RS_out_nom "Reheated steam pressure at current load";
        ClaRa.StaticCycles.Fundamentals.SteamSignal_green_b hotReheat(h = h_RS_out, p = p_RS_out, m_flow = m_flow_cRH);
        ClaRa.StaticCycles.Fundamentals.SteamSignal_blue_a coldReheat(p = p_RS_in);
        ClaRa.StaticCycles.Fundamentals.SteamSignal_blue_a feedWater(p = p_LS_in);
        ClaRa.StaticCycles.Fundamentals.SteamSignal_green_b liveSteam(h = h_LS_out, p = p_LS_out, m_flow = m_flow_LS_nom * P_target_);
      initial equation
        h_LS_in = feedWater.h;
        h_RS_in = coldReheat.h;
        feedWater.m_flow = m_flow_feed;
        coldReheat.m_flow = m_flow_cRH;
        Delta_p_LS_ = table1.y[1];
        Delta_p_RS_ = table2.y[1];
      end Boiler_simple;
    end Furnace;
  end StaticCycles;

  model SimCenter  
    replaceable parameter TILMedia.VLEFluidTypes.TILMedia_SplineWater fluid1 constrainedby TILMedia.VLEFluidTypes.BaseVLEFluid(final ID = 1);
    replaceable parameter TILMedia.VLEFluidTypes.TILMedia_SplineWater fluid2 constrainedby TILMedia.VLEFluidTypes.BaseVLEFluid(final ID = 2);
    replaceable parameter TILMedia.VLEFluidTypes.TILMedia_SplineWater fluid3 constrainedby TILMedia.VLEFluidTypes.BaseVLEFluid(final ID = 3);
    replaceable parameter TILMedia.GasTypes.MoistAirMixture airModel constrainedby TILMedia.GasTypes.BaseGas;
    replaceable parameter TILMedia.GasTypes.FlueGasTILMedia flueGasModel constrainedby TILMedia.GasTypes.BaseGas;
    replaceable parameter ClaRa.Basics.Media.FuelTypes.Fuel_refvalues_v1 fuelModel1 constrainedby ClaRa.Basics.Media.FuelTypes.EmptyFuel;
    replaceable parameter ClaRa.Basics.Media.FuelTypes.Fuel_refvalues_v1 fuelModel2 constrainedby ClaRa.Basics.Media.FuelTypes.EmptyFuel;
    replaceable parameter ClaRa.Basics.Media.Slag.Slag_v1 slagModel constrainedby ClaRa.Basics.Media.Slag.PartialSlag;
    input ClaRa.Basics.Units.AbsolutePressure p_amb = 1.013e5 "Ambient pressure";
    input ClaRa.Basics.Units.Temperature T_amb = 293.15 "Ambient temperature";
    input ClaRa.Basics.Units.RelativeHumidity rh_amb = 0.2 "Ambient relative humidity (0 < rh < 1)";
    parameter ClaRa.Basics.Units.AbsolutePressure p_amb_start(fixed = false) "Initial ambient pressure (automatically calculated)";
    parameter ClaRa.Basics.Units.Temperature T_amb_start(fixed = false) "Initial ambient temperature (automatically calculated)";
    parameter Boolean showExpertSummary = false "|Summary and Visualisation||True, if expert summary should be applied";
    parameter Boolean largeFonts = false "|Summary and Visualisation||True if visualisers shall be displayed as large as posible";
    parameter Boolean contributeToCycleSummary = false "True if components shall contribute to automatic efficiency calculation";
    parameter Boolean steamCycleAllowFlowReversal = true "Allow flow reversal in steam cycle";
    parameter Boolean useClaRaDelay = true "True for using ClaRa delay implementation / false for built in Modelica delay";
    parameter Real MaxSimTime = 1e4 "Maximum time for simulation, must be set for Modelica delay blocks with variable delay time";
    parameter Boolean useHomotopy = true "True, if homotopy method is used during initialisation" annotation(Evaluate = true);
    ClaRa.Basics.Interfaces.CycleSumPort cycleSumPort "Reference to the volume and mass of the VLE fluid in components" annotation(HideResult = false);
    ClaRa.Basics.Units.EnthalpyMassSpecific h_amb_fluid1 "Ambient enthalpy of VLE fluid 1";
    ClaRa.Basics.Units.EntropyMassSpecific s_amb_fluid1 "Ambient entropy of VLE fluid 1";
    ClaRa.Basics.Units.EnthalpyMassSpecific h_amb_fluid2 "Ambient enthalpy of VLE fluid 2";
    ClaRa.Basics.Units.EntropyMassSpecific s_amb_fluid2 "Ambient entropy of VLE fluid 2";
    ClaRa.Basics.Units.EnthalpyMassSpecific h_amb_fluid3 "Ambient enthalpy of VLE fluid 3";
    ClaRa.Basics.Units.EntropyMassSpecific s_amb_fluid3 "Ambient entropy of VLE fluid 3";
    TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointerAmb_fluid1 = TILMedia.VLEFluidObjectFunctions.VLEFluidPointer(fluid1.concatVLEFluidName, 7, fluid1.xi_default, fluid1.nc_propertyCalculation, fluid1.nc, 0) "Pointer to external medium memory";
    TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointerAmb_fluid2 = TILMedia.VLEFluidObjectFunctions.VLEFluidPointer(fluid2.concatVLEFluidName, 7, fluid2.xi_default, fluid2.nc_propertyCalculation, fluid2.nc, 0) "Pointer to external medium memory";
    TILMedia.VLEFluidObjectFunctions.VLEFluidPointer vleFluidPointerAmb_fluid3 = TILMedia.VLEFluidObjectFunctions.VLEFluidPointer(fluid3.concatVLEFluidName, 7, fluid3.xi_default, fluid3.nc_propertyCalculation, fluid3.nc, 0) "Pointer to external medium memory";

    record summary_clara  
      extends ClaRa.Basics.Icons.RecordIcon;
      Real eta_th "Thermal efficiency";
      Real eta_el "Electrical efficiency";
    end summary_clara;

    summary_clara summary(eta_th = cycleSumPort.power_out / (cycleSumPort.power_in + 1e-6), eta_el = (cycleSumPort.power_out - cycleSumPort.power_aux) / (1e-6 + cycleSumPort.power_in));
  initial equation
    p_amb_start = p_amb;
    T_amb_start = T_amb;
  equation
    h_amb_fluid1 = TILMedia.VLEFluidObjectFunctions.specificEnthalpy_pTxi(p_amb, T_amb, fluid1.xi_default, vleFluidPointerAmb_fluid1);
    s_amb_fluid1 = TILMedia.VLEFluidObjectFunctions.specificEntropy_pTxi(p_amb, T_amb, fluid1.xi_default, vleFluidPointerAmb_fluid1);
    h_amb_fluid2 = TILMedia.VLEFluidObjectFunctions.specificEnthalpy_pTxi(p_amb, T_amb, fluid2.xi_default, vleFluidPointerAmb_fluid2);
    s_amb_fluid2 = TILMedia.VLEFluidObjectFunctions.specificEntropy_pTxi(p_amb, T_amb, fluid2.xi_default, vleFluidPointerAmb_fluid2);
    h_amb_fluid3 = TILMedia.VLEFluidObjectFunctions.specificEnthalpy_pTxi(p_amb, T_amb, fluid3.xi_default, vleFluidPointerAmb_fluid3);
    s_amb_fluid3 = TILMedia.VLEFluidObjectFunctions.specificEntropy_pTxi(p_amb, T_amb, fluid3.xi_default, vleFluidPointerAmb_fluid3);
    annotation(defaultComponentPrefixes = "inner"); 
  end SimCenter;
  annotation(preferedView = "info", version = "1.3.0"); 
end ClaRa;

model SteamCycle_01_total  "A closed steam cycle with a simple boiler model including single reheat, feedwater tank, LP and HP preheaters"
  extends ClaRa.Examples.SteamCycle_01;
 annotation(experiment(StopTime = 5000, __Dymola_NumberOfIntervals = 5000, Tolerance = 1e-05, __Dymola_Algorithm = "Dassl"), __Dymola_experimentSetupOutput(equidistant = false));
end SteamCycle_01_total;
