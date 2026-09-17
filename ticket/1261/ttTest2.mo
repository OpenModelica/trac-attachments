package Modelica

  package Blocks
    package Interfaces

      connector RealOutput = output Real "'output Real' as connector";

      partial block SO "Single Output continuous control block"
	RealOutput y "Connector of Real output signal";
      end SO;

      partial block MO "Multiple Output continuous control block"
	parameter Integer nout(min=1) = 1 "Number of outputs";
	RealOutput y[nout] "Connector of Real output signals";
      end MO;


    end Interfaces;

    package Sources

     block TimeTable 
	"Generate a (possibly discontinuous) signal by linear interpolation in a table"

	parameter Real table[:, 2] 
	  "Table matrix (time = first column; e.g. table=[0, 0; 1, 1; 2, 4])";
	parameter Real offset=0 "Offset of output signal";
	parameter SIunits.Time startTime=0 "Output = offset for time < startTime";
	extends Interfaces.SO;
      protected 
	Real a "Interpolation coefficients a of actual interval (y=a*x+b)";
	Real b "Interpolation coefficients b of actual interval (y=a*x+b)";
	Integer last(start=1) "Last used lower grid index";
	SIunits.Time nextEvent(start=0, fixed=true) "Next event instant";

	function getInterpolationCoefficients 
	  "Determine interpolation coefficients and next time event"
	  input Real table[:, 2] "Table for interpolation";
	  input Real offset "y-offset";
	  input Real startTime "time-offset";
	  input Real t "Actual time instant";
	  input Integer last "Last used lower grid index";
	  input Real TimeEps "Relative epsilon to check for identical time instants";
	  output Real a "Interpolation coefficients a (y=a*x + b)";
	  output Real b "Interpolation coefficients b (y=a*x + b)";
	  output Real nextEvent "Next event instant";
	  output Integer next "New lower grid index";
	protected 
	  Integer columns=2 "Column to be interpolated";
	  Integer ncol=2 "Number of columns to be interpolated";
	  Integer nrow=size(table, 1) "Number of table rows";
	  Integer next0;
	  Real tp;
	  Real dt;
	algorithm 
	  next := last;
	  nextEvent := t - TimeEps*abs(t);
	  // in case there are no more time events
	  tp := t + TimeEps*abs(t) - startTime;

	  if tp < 0.0 then
	    // First event not yet reached
	    nextEvent := startTime;
	    a := 0;
	    b := offset;
	  elseif nrow < 2 then
	    // Special action if table has only one row
	    a := 0;
	    b := offset + table[1, columns];
	  else

	    // Find next time event instant. Note, that two consecutive time instants
	    // in the table may be identical due to a discontinuous point.
	    while next < nrow and tp >= table[next, 1] loop
	      next := next + 1;
	    end while;

	    // Define next time event, if last table entry not reached
	    if next < nrow then
	      nextEvent := startTime + table[next, 1];
	    end if;

	    // Determine interpolation coefficients
	    next0 := next - 1;
	    dt := table[next, 1] - table[next0, 1];
	    if dt <= TimeEps*abs(table[next, 1]) then
	      // Interpolation interval is not big enough, use "next" value
	      a := 0;
	      b := offset + table[next, columns];
	    else
	      a := (table[next, columns] - table[next0, columns])/dt;
	      b := offset + table[next0, columns] - a*table[next0, 1];
	    end if;
	  end if;
	  // Take into account startTime "a*(time - startTime) + b"
	  b := b - a*startTime;
	end getInterpolationCoefficients;
      algorithm 
	when {time >= pre(nextEvent),initial()} then
	  (a,b,nextEvent,last) := getInterpolationCoefficients(table, offset,
	    startTime, time, last, 100*Modelica.Constants.eps);
	end when;
      equation 
	y = a*time + b;
      end TimeTable;

      model CombiTimeTable 
	"Table look-up with respect to time and linear/perodic extrapolation methods (data from matrix/file)"

	parameter Boolean tableOnFile=false 
	  "= true, if table is defined on file or in function usertab";
	parameter Real table[:, :] = fill(0.0,0,2) 
	  "Table matrix (time = first column; e.g. table=[0,2])";
	parameter String tableName="NoName" 
	  "Table name on file or in function usertab (see docu)";
	parameter String fileName="NoName" "File where matrix is stored";
	parameter Integer columns[:]=2:size(table, 2) 
	  "Columns of table to be interpolated";
	parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments 
	  "Smoothness of table interpolation";
	parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints 
	  "Extrapolation of data outside the definition range";
	parameter Real offset[:]={0} "Offsets of output signals";
	parameter Modelica.SIunits.Time startTime=0 
	  "Output = offset for time < startTime";
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
	  "Initialize 1-dim. table where first column is time (for details see: Modelica/C-Sources/ModelicaTables.h)"
	  input String tableName;
	  input String fileName;
	  input Real table[ :, :];
	  input Real startTime;
	  input Modelica.Blocks.Types.Smoothness smoothness;
	  input Modelica.Blocks.Types.Extrapolation extrapolation;
	  output Integer tableID;
	external "C" tableID=  ModelicaTables_CombiTimeTable_init(
		       tableName, fileName, table, size(table, 1), size(table, 2),
		       startTime, smoothness, extrapolation);
	  annotation(Library="ModelicaExternalC");
	end tableTimeInit;

	function tableTimeIpo 
	  "Interpolate 1-dim. table where first column is time (for details see: Modelica/C-Sources/ModelicaTables.h)"
	  input Integer tableID;
	  input Integer icol;
	  input Real timeIn;
	  output Real value;
	external "C" value = 
			   ModelicaTables_CombiTimeTable_interpolate(tableID, icol, timeIn);
	  annotation(Library="ModelicaExternalC");
	end tableTimeIpo;

	function tableTimeTmin 
	  "Return minimum time value of 1-dim. table where first column is time (for details see: Modelica/C-Sources/ModelicaTables.h)"
	  input Integer tableID;
	  output Real Tmin "minimum time value in table";
	external "C" Tmin = 
			  ModelicaTables_CombiTimeTable_minimumTime(tableID);
	  annotation(Library="ModelicaExternalC");
	end tableTimeTmin;

	function tableTimeTmax 
	  "Return maximum time value of 1-dim. table where first column is time (for details see: Modelica/C-Sources/ModelicaTables.h)"
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
      end CombiTimeTable;

    end Sources;

    package Types

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

    end Types;

  end Blocks;

  package Constants

    final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";

  end Constants;

  package SIunits

    type Time = Real (final quantity="Time", final unit="s");

  end SIunits;

end Modelica;

model ttTest2

//  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 1,0; 1,10; 2,10; 2,5;
//        3,0; 4,0]);
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 1,0; 1,2; 2,
        2; 2,1; 3,0]);
end ttTest2;
