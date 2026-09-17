within ;
model TestMixtureLoop "Test different methods for computing the molecular mass. Two of them (method 1 and 2 computing respectively MM1 and MM2) work properly, while the other two methods (method 3 and 4 computing respectively MM3 and MM4) do not work and simply return the molecular mass of the last species of the array. The method implemented in MixtureGasNasa of the standard library (which computes MM) does not work as well. In the results compare MM, MM1 ... MM4. Summarizing the results:
        1) The expression MM3 = medium.X * array(Medium.data[i].MM for i in 1:Medium.nX) does not work both in the equation section and in a function;
        2) The for loop works in the equation section but not in the function;
        3) The function works properly only when it calls in a loop a second function to which only one element of the array is passed." 
  package Medium = Modelica.Media.IdealGases.MixtureGases.FlueGasSixComponents;
  
  package MolarMassFunctions 
    function molarMass2 
      input Modelica.SIunits.MolarMass[Medium.nX] X;
      output Modelica.SIunits.MolarMass MM2;
    algorithm 
      MM2 := X * array(mm_i(Medium.data[i]) for i in 1:Medium.nX);
      annotation(Inline = true, smoothOrder = 2);
    end molarMass2;
    
    function mm_i 
      input Modelica.Media.IdealGases.Common.DataRecord data;
      output Modelica.SIunits.MolarMass mm;
    algorithm 
      mm := data.MM;
    end mm_i;
    
    function molarMass4 
      input Modelica.SIunits.MassFraction[Medium.nX] X;
      output Modelica.SIunits.MolarMass MM4;
    protected 
      Modelica.SIunits.MolarMass[Medium.nX] mm;
    algorithm 
      for i in 1:Medium.nX loop
        mm[i] := Medium.data[i].MM;
      end for;
      MM4 := X * mm;
      annotation(Inline = true, smoothOrder = 2);
    end molarMass4;
  end MolarMassFunctions;
  
  Medium.BaseProperties medium;
  Modelica.SIunits.MolarMass mm[Medium.nX] "Array of molecular masses";
  Modelica.SIunits.MolarMass MM1 "Molecular Mass";
  Modelica.SIunits.MolarMass MM2 "Molecular Mass";
  Modelica.SIunits.MolarMass MM3 "Molecular Mass";
  Modelica.SIunits.MolarMass MM4 "Molecular Mass";
equation 
  // First method for computing the molecular mass. IT WORKS
  for i in 1:Medium.nX loop
    mm[i] = Medium.data[i].MM;
  end for;
  MM1 = medium.X * mm;
  // End first method
  // Second method for computing the molecular mass. IT WORKS
  MM2 = MolarMassFunctions.molarMass2(medium.X);
  // End second method
  // Third method for computing the molecular mass. IT DOES NOT WORK
  MM3 = medium.X * array(Medium.data[i].MM for i in 1:Medium.nX);
  // End third method
  // Fourth method for computing the molecular mass. IT DOES NOT WORK
  MM4 = MolarMassFunctions.molarMass4(medium.X);
  // End fourth method
  medium.p = 1e5;
  medium.T = 300;
  medium.X[1] = time;
  medium.X[2] = 1 - time;
  medium.X[3:6] = zeros(4);
  annotation(experiment(StartTime = 0.0, StopTime = 1.0), uses(Modelica(version
          ="3.2.1")));
end TestMixtureLoop;
