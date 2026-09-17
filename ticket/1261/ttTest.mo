package Modelica

  package Blocks
    package Interfaces

      connector RealOutput = output Real "'output Real' as connector";

      partial block SO "Single Output continuous control block"
	RealOutput y "Connector of Real output signal";
      end SO;

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

  end Sources;

  end Blocks;

  package Constants

    final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";

  end Constants;

  package SIunits

    type Time = Real (final quantity="Time", final unit="s");

  end SIunits;

end Modelica;

model ttTest

  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 1,0; 1,10; 2,10; 2,5;
        3,0; 4,0]);
end ttTest;