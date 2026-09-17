package EncapsulatedError
  encapsulated model MainModel
    import Modelica.Blocks.Sources.Ramp;
    import EncapsulatedError.Functions.myFunction;
    Ramp ramp;
    Real myOutput;
  equation
    myOutput = myFunction(ramp.y);
  end MainModel;
  model MainModelNotEncapsulated
    import Modelica.Blocks.Sources.Ramp;
    import EncapsulatedError.Functions.myFunction;
    Ramp ramp;
    Real myOutput;
  equation
    myOutput = myFunction(ramp.y);
  end MainModelNotEncapsulated;

  encapsulated model MainModelSameLevel
    import Modelica.Blocks.Sources.Ramp;
    import EncapsulatedError.myFunctionSameLevel;
    Ramp ramp;
    Real myOutput;
  equation
    myOutput = myFunctionSameLevel(ramp.y);
  end MainModelSameLevel;

  function myFunctionSameLevel
    input Real u;
    output Real y;
  algorithm
    y := 3 * u;
  end myFunctionSameLevel;
  package Functions
    function myFunction
      input Real u;
      output Real y;
    algorithm
      y := 3 * u;
    end myFunction;
  end Functions;
  annotation(
    uses(Modelica(version = "3.2.2")));
end EncapsulatedError;
