package Modelica  "Modelica Standard Library - Version 3.2.1 (Build 3)"
  extends Modelica.Icons.Package;

  package Icons  "Library of icons"
    extends Icons.Package;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces"
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial function Function  "Icon for functions" end Function;
  end Icons;
  annotation(version = "3.2.1", versionBuild = 3, versionDate = "2013-08-14", dateModified = "2014-06-27 19:30:00Z");
end Modelica;

package Modelica_Noise  "Modelica_Noise version 1.0-Beta.1 (Library for random numbers and noise signals; planned to be included into the Modelica Standard Library)"
  package Math  "Additions to Math package of MSL"
    package Random  "Library of functions for generating random numbers"
      extends Modelica.Icons.Package;

      package Generators  "Library of functions generating uniform random numbers in the range 0 < random <= 1.0 (with exposed state vectors)"
        extends Modelica.Icons.Package;

        package Xorshift64star  "Random number generator xorshift64*"
          extends Interfaces.PartialGenerator(final nState = 2);

          redeclare function extends initialState  "Returns an initial state for the xorshift64* algorithm"
          protected
            Real r "Random number not used outside the function";
            constant Integer p = 10 "The number of iterations to use";
          algorithm
            if localSeed == 0 and globalSeed == 0 then
              state := {126247697, globalSeed};
            else
              state := {localSeed, globalSeed};
            end if;
            for i in 1:p loop
              (r, state) := random(state);
            end for;
          end initialState;

          redeclare function extends random  "Returns a uniform random number with the xorshift64* algorithm"
            external "C" ModelicaRandom_xorshift64star(stateIn, stateOut, result) annotation(Include = "#include \"ModelicaRandom.c\"");
            annotation(Include = "#include \"ModelicaRandom.c\"");
          end random;
        end Xorshift64star;
      end Generators;

      package Interfaces  "Library of partial packages and functions for the Random package"
        extends Modelica.Icons.InterfacesPackage;

        partial package PartialGenerator  "Interfaces of a uniform random number generator"
          extends Modelica.Icons.Package;
          constant Integer nState = 1 "The dimension of the internal state vector";

          replaceable partial function initialState  "Return the initial internal states for the uniform random number generator"
            extends Modelica.Icons.Function;
            input Integer localSeed "The local seed to be used for generating initial states";
            input Integer globalSeed "The global seed to be combined with the local seed";
            output Integer[nState] state "The generated initial states";
          end initialState;

          replaceable partial function random  "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
            extends Modelica.Icons.Function;
            input Integer[nState] stateIn "The internal states for the random number generator";
            output Real result "A random number with a uniform distribution on the interval (0,1]";
            output Integer[nState] stateOut "The new internal states of the random number generator";
          end random;
        end PartialGenerator;
      end Interfaces;
    end Random;
  end Math;
  annotation(version = "1.0-Beta.1", versionDate = "2015-06-22", versionBuild = 0);
end Modelica_Noise;

function f
  input Integer i[2];
  output Real r;
protected
  Integer io[:]; // : here is the culprit
algorithm
  (r,io) := Modelica_Noise.Math.Random.Generators.Xorshift64star.random(i);
end f;

model M
  constant Real r = f({1,2});
end M;
