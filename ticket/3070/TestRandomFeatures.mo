within ;
package TestRandomFeatures
  package Version1
    "Generator can be selected globally + distribution can be selected locally but only with ONE random number)"
    package Blocks
      package Examples
        extends Modelica.Icons.ExamplesPackage;

        package Noise
          extends Modelica.Icons.ExamplesPackage;
          model Test1
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version1.Blocks.Noise.GlobalSeed globalSeed(useGlobalSeed=true,
                enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version1.Blocks.Noise.EventBasedNoise eventBasedNoise(
              samplePeriod=0.01, redeclare function distribution =
                  TestRandomFeatures.Version1.Math.Random.Distributions.uniform
                  (                                                              y_max=
                      5, y_min=-1))
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
          equation

            annotation (experiment(StopTime=2));
          end Test1;
        end Noise;
      end Examples;

      package Noise
        model GlobalSeed
          "Defines a global seed value and provides an impure random number generator"

        // Provide a flag to globally disable noise
        public
          parameter Boolean enableNoise = true
            "= true, if noise generators shall be enabled; = false, if a constant substitute value shall be used"
            annotation(choices(checkBox=true));

        // The global seed value
        public
          parameter Boolean useGlobalSeed = true
            "= true, use fixed global initial seed; = false, choose a random seed by system time and process id"
            annotation(choices(checkBox=true));
          parameter Integer globalSeed = 67867967
            "Global initial seed for random number generator (if useGlobalSeed = true)"
              annotation(Dialog(enable=useGlobalSeed));
          final parameter Integer seed = if useGlobalSeed then globalSeed else 2*globalSeed;

        // The global number generator
        public
          replaceable package Generator =
              Version1.Math.Random.Generators.WhichmannHill constrainedby
            Version1.Math.Random.Interfaces.PartialGenerator
            "The random number generator to be used in the model"
            annotation(choicesAllMatching=true, Dialog(tab="Advanced"));

          annotation (
           defaultComponentName="globalSeed",
            defaultComponentPrefixes="inner",
            missingInnerMessage="
Your model is using an outer \"globalSeed\" component but
an inner \"globalSeed\" component is not defined and therefore
a default inner \"globalSeed\" component is introduced by the tool.
To change the default setting, drag Noise.GlobalSeed
into your model and specify the seed.
",        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                                Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255}),
                Line(points={{-27,27},{-27,-33},{-17,-33},{-17,-15},{-7,-15},{-7,-43},{3,
                      -43},{3,39},{9,39},{9,53},{15,53},{15,-3},{25,-3},{25,9},{31,9},{31,
                      -21},{41,-21},{41,51},{51,51},{51,17},{59,17},{59,-49},{69,-49}},
                    color={215,215,215}),
                Line(points={{-73,-15},{-59,-15},{-59,1},{-51,1},{-51,-47},{-43,-47},{-43,
                      -25},{-35,-25},{-35,59},{-27,59},{-27,27}},      color={215,215,215}),
                Text(visible=useGlobalSeed,
                  extent={{-90,8},{88,-18}},
                  lineColor={255,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="%globalSeed")}),
            Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>",         info="<html>
<p>Inner/Outer Model for Global Seeding.</p>
<p>This model enables the modeler to define a global seed value for random generators.</p>
<p>The seed value can then be used (i.e. combined with a local seed value) at local pseudo-random signal generators. If so, then a switch of the global seed changes all pseudo-random signals.</p>
<p>Remark: Some pseudo-random number generators demand for larger seed values (array of integers). In this case the large seed is automatically generated out of this single integer seed value.</p>
</html>"));
        end GlobalSeed;

        block EventBasedNoise
          extends Modelica.Blocks.Interfaces.SO;

          parameter Boolean useGlobalSeed = true
            "= true: global seed influences random numbers; = false: global seed is ignored"
            annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization"));
          parameter Integer localSeed = 237
            "The local seed for initializing the random number generator"
            annotation(Dialog(tab="Advanced",group = "Initialization"));
          parameter Modelica.SIunits.Time startTime = 0.0
            "Start time for sampling the raw random numbers"
            annotation(Dialog(tab="Advanced", group="Initialization"));
          parameter Modelica.SIunits.Time samplePeriod(start=0.01)
            "Period for sampling the raw random numbers";
          replaceable function distribution =
             TestRandomFeatures.Version1.Math.Random.Distributions.uniform constrainedby
            TestRandomFeatures.Version1.Math.Random.Interfaces.partialDistribution
            "Choice of distributions of the random values"
            annotation(choicesAllMatching=true);
          parameter Boolean enableNoise = true
            "=true: y = noise if globalSeed.enableNoise=true; otherwise: y = y_off"
            annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Enable/Disable"));
          parameter Real y_off = 0.0 "Output value if noise disabled"
            annotation(Dialog(tab="Advanced",group = "Enable/Disable"));
        protected
          parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
            "The global seed, which is atually used";
          parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise;
          outer GlobalSeed globalSeed;
          constant Integer nState = globalSeed.Generator.nState;
          Integer state[nState];
          Real r "Uniform random number";
        initial equation
          pre(state) = globalSeed.Generator.initialState(localSeed, actualGlobalSeed);
        equation
          when {initial(), generateNoise and sample(startTime, samplePeriod)} then
            (r,state) = globalSeed.Generator.random(pre(state));
            y = if generateNoise then distribution(r) else y_off;
          end when;
        end EventBasedNoise;
      end Noise;
    end Blocks;

    package Math
      package Random
        package Generators
          encapsulated package WhichmannHill
            "Wichmann-Hill generator (a variant of a multiplicative congruential algorithm)"
            import TestRandomFeatures = TestRandomFeatures.Version1;
            extends TestRandomFeatures.Math.Random.Interfaces.PartialGenerator(final nState=3);

            redeclare function extends initialState
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function extends random
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            uniformRandom := rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end random;
          end WhichmannHill;
        end Generators;

        package Distributions
          function uniform "Uniform distribution in a band y_min ... y_max"
            extends Version1.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max= 1 "Upper limit of band"
            annotation (Dialog);
          algorithm
            //assert(uniformRandom >= 0.0 and uniformRandom <= 1.0, "uniformRandom is wrong");
            // Transform limits of distribution
            random := uniformRandom*(y_max - y_min) + y_min;
          end uniform;
        end Distributions;

        package Interfaces
          partial package PartialGenerator
            constant Integer nState=1
              "The dimension of the internal state vector";

            replaceable partial function initialState
              "Return the initial internal states for the random number generator"
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[nState] state "The generated initial states";
            end initialState;

            replaceable partial function random
              "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
              extends Modelica.Icons.Function;
              input Integer[nState] stateIn
                "The internal states for the random number generator";
              output Real uniformRandom
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[nState] stateOut
                "The new internal states of the random number generator";
            end random;

          end PartialGenerator;

          partial function partialDistribution
            extends Modelica.Icons.Function;
            input Real uniformRandom
              "Uniform random number in the range 0 < uniformRandom <= 1";
            output Real random
              "A random number according to the desired distribution";
          end partialDistribution;
        end Interfaces;
      end Random;
    end Math;
    annotation ();
  end Version1;

  package Version2
    "Generator can be selected globally + distribution can be selected locally with no restrictions on random calls"
    package Blocks
      package Examples
        extends Modelica.Icons.ExamplesPackage;

        package Noise
          extends Modelica.Icons.ExamplesPackage;
          model Test1 "Noise between -1 .. 5"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version2.Blocks.Noise.GlobalSeed globalSeed(
              redeclare package Generator =
                  TestRandomFeatures.Version2.Math.Random.Generators.WhichmannHill,
              useAutomaticSeed=false,
              enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version2.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01, redeclare function distribution =
                  TestRandomFeatures.Version2.Math.Random.Distributions.uniformBand
                  ( y_min=-1, y_max=5),
              enableNoise=true)
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test1;

          model Test2 "Noise between 10 .. 16"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version2.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true,
              redeclare package Generator =
                  TestRandomFeatures.Version2.Math.Random.Generators.WhichmannHill)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version2.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01,
              enableNoise=true,
              redeclare function distribution =
                  TestRandomFeatures.Version2.Math.Random.Distributions.uniformBand2
                  ( y_min=-1, y_max=5))
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test2;

          model Test3 "Noise between 10 .. 22"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version2.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true,
              redeclare package Generator =
                  TestRandomFeatures.Version2.Math.Random.Generators.WhichmannHill2)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version2.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01,
              enableNoise=true,
              redeclare function distribution =
                  TestRandomFeatures.Version2.Math.Random.Distributions.uniformBand2
                  ( y_min=-1, y_max=5))
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test3;
        end Noise;
      end Examples;

      package Noise
        model GlobalSeed
          "Defines a global seed value and provides an impure random number generator"
          import TestRandomFeatures.Version2.Math.Random;

          parameter Boolean enableNoise = true
            "= true, if noise blocks generate noise as output; = false, if they generate a constant output"
            annotation(choices(checkBox=true));
          parameter Boolean useAutomaticSeed = false
            "= true, choose a seed by system time and process id; = false, use fixedSeed"
            annotation(choices(checkBox=true));
          parameter Integer fixedSeed = 67867967
            "Fixed global seed for random number generators (if useAutomaticSeed = false)"
              annotation(Dialog(enable=not useAutomaticSeed));
          final parameter Integer seed = if useAutomaticSeed then 2*fixedSeed else fixedSeed;

        public
          replaceable package Generator = Random.Generators.WhichmannHill constrainedby
            Random.Interfaces.PartialGenerator
            "The uniform random number generator to be used in the model"
            annotation(choicesAllMatching=true, Dialog(tab="Advanced"));

          annotation (
           defaultComponentName="globalSeed",
            defaultComponentPrefixes="inner",
            missingInnerMessage="
Your model is using an outer \"globalSeed\" component but
an inner \"globalSeed\" component is not defined and therefore
a default inner \"globalSeed\" component is introduced by the tool.
To change the default setting, drag Noise.GlobalSeed
into your model and specify the seed.
",        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                 graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                                Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255}),
                Line(visible=  enableNoise,
                     points={{-73,-15},{-59,-15},{-59,1},{-51,1},{-51,-47},{-43,-47},{-43,
                      -25},{-35,-25},{-35,59},{-27,59},{-27,27},{-27,27},{-27,-33},{-17,-33},{-17,-15},{-7,-15},{-7,-43},{3,
                      -43},{3,39},{9,39},{9,53},{15,53},{15,-3},{25,-3},{25,9},{31,9},{31,
                      -21},{41,-21},{41,51},{51,51},{51,17},{59,17},{59,-49},{69,-49}},
                    color={215,215,215}),
                Text(visible=enableNoise and not useAutomaticSeed,
                  extent={{-90,8},{88,-18}},
                  lineColor={255,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="%fixedSeed"),
                Line(visible=  not enableNoise,
                  points={{-80,-4},{84,-4}},
                  color={215,215,215},
                  smooth=Smooth.None)}),
            Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>",         info="<html>
<p>Inner/Outer Model for Global Seeding.</p>
<p>This model enables the modeler to define a global seed value for random generators.</p>
<p>The seed value can then be used (i.e. combined with a local seed value) at local pseudo-random signal generators. If so, then a switch of the global seed changes all pseudo-random signals.</p>
<p>Remark: Some pseudo-random number generators demand for larger seed values (array of integers). In this case the large seed is automatically generated out of this single integer seed value.</p>
</html>"));
        end GlobalSeed;

        block EventBasedNoise
          import TestRandomFeatures.Version2.Math.Random;
          extends Modelica.Blocks.Interfaces.SO;

          parameter Boolean enableNoise = true
            "=true: y = noise, otherwise y = y_off"
            annotation(choices(checkBox=true),Dialog(tab="Advanced"));
          parameter Real y_off = 0.0 "Output value if enableNoise=false"
            annotation(Dialog(tab="Advanced",enable=not enableNoise));

          parameter Boolean useGlobalSeed = true
            "= true: global seed influences random numbers, otherwise global seed is ignored"
            annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Integer localSeed = 237
            "The local seed for initializing the random number generator"
            annotation(Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time startTime = 0.0
            "Start time for sampling the raw random numbers"
            annotation(Dialog(tab="Advanced", group="Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time samplePeriod(start=0.01)
            "Period for sampling the raw random numbers"
            annotation(Dialog(enable=enableNoise));
          replaceable function distribution = Random.Distributions.uniformBand
                               constrainedby
            Random.Interfaces.partialDistribution
            "Random number generator with a specific distribution"
            annotation(choicesAllMatching=true, Dialog(enable=enableNoise));
        protected
          parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
            "The global seed, which is atually used";
          parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise;
          outer GlobalSeed globalSeed;
          constant Integer nState = globalSeed.Generator.nState;
          Integer state[nState];
          Real r "Random number according to the desired distribution";
        initial equation
          pre(state) = globalSeed.Generator.initialState(localSeed, actualGlobalSeed);
        equation
          when {initial(), generateNoise and sample(startTime, samplePeriod)} then
            (r,state) = distribution(stateIn=pre(state),uniformRandom=globalSeed.Generator.uniformRandom);
            y = if generateNoise then r else y_off;
          end when;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Polygon(
                  points={{-76,90},{-84,68},{-68,68},{-76,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
                Line(points={{-86,0},{72,0}}, color={192,192,192}),
                Polygon(
                  points={{94,0},{72,8},{72,-8},{94,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(visible=  enableNoise,
                   points={{-75,-13},{-61,-13},{-61,3},{-53,3},{-53,-45},{-45,-45},{-45,
                      -23},{-37,-23},{-37,61},{-29,61},{-29,29},{-29,29},{-29,-31},{-19,
                      -31},{-19,-13},{-9,-13},{-9,-41},{1,-41},{1,41},{7,41},{7,55},{13,
                      55},{13,-1},{23,-1},{23,11},{29,11},{29,-19},{39,-19},{39,53},{49,
                      53},{49,19},{57,19},{57,-47},{67,-47}},
                    color={0,0,0}),
                Text(visible=enableNoise,
                  extent={{-150,-110},{150,-150}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%samplePeriod s"),
                Line(visible=not enableNoise,
                  points={{-76,56},{72,56}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Text(visible=not enableNoise,
                  extent={{-75,50},{95,10}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%y_off")}));
        end EventBasedNoise;
      end Noise;
    end Blocks;

    package Math
      package Random
        package Generators
          package WhichmannHill
            "Wichmann-Hill generator (a variant of a multiplicative congruential algorithm)"
            extends
              TestRandomFeatures.Version2.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill;

          package WhichmannHill2
            "Wichmann-Hill generator (variant2; multiplied by 2)"
            extends
              TestRandomFeatures.Version2.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom "Multiplied random by 2"
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := 2*rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill2;
        end Generators;

        package Distributions
          function uniformBand "Uniform distribution in a band"
            extends
              TestRandomFeatures.Version2.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := r*(y_max - y_min) + y_min;
          end uniformBand;

          function uniformBand2
            "Variant 2: Uniform distribution in a band (added offset of 10)"
            extends
              TestRandomFeatures.Version2.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := 10 + r*(y_max - y_min) + y_min;
          end uniformBand2;
        end Distributions;

        package Interfaces
          partial package PartialGenerator
            "Interfaces of a uniform random number generator"
            constant Integer nState=1
              "The dimension of the internal state vector";

            replaceable partial function initialState
              "Return the initial internal states for the uniform random number generator"
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[:] state "The generated initial states";
            end initialState;

            replaceable partial function uniformRandom
              "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
              extends
                TestRandomFeatures.Version2.Math.Random.Interfaces.partialUniformRandom;
            end uniformRandom;

          end PartialGenerator;

          partial function partialUniformRandom
            "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
            extends Modelica.Icons.Function;
            input Integer[:] stateIn
              "The internal states for the random number generator";
            output Real result
              "A random number with a uniform distribution on the interval (0,1]";
            output Integer[size(stateIn,1)] stateOut
              "The new internal states of the random number generator";
          end partialUniformRandom;

          partial function partialDistribution
            "Return a random number according to a specific distribution"
            import TestRandomFeatures.Version2.Math.Random;
            extends Modelica.Icons.Function;
            input Integer[:] stateIn
              "The internal states for the random number generator";
            input Random.Interfaces.partialUniformRandom uniformRandom
              "The uniform random number generator to be used in this funcion";
            output Real result
              "A random number according to the desired distribution";
            output Integer[size(stateIn,1)] stateOut
              "The new internal states of the random number generator";
          end partialDistribution;
        end Interfaces;
      end Random;
    end Math;
    annotation ();
  end Version2;

  package Version3
    "Generator is fixed (cannot be selected) + distribution can be selected locally with no restrictions on random calls (and uniformRandom function s passed as argument)"
    package Blocks
      package Examples
        extends Modelica.Icons.ExamplesPackage;

        package Noise
          extends Modelica.Icons.ExamplesPackage;
          model Test1 "Noise between -1 .. 5"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version3.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version3.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01, redeclare function distribution =
                  TestRandomFeatures.Version3.Math.Random.Distributions.uniformBand
                  ( y_min=-1, y_max=5),
              enableNoise=true)
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test1;

          model Test2 "Noise between 10 .. 16"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version3.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version3.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01,
              enableNoise=true,
              redeclare function distribution =
                  TestRandomFeatures.Version3.Math.Random.Distributions.uniformBand2
                  ( y_min=-1, y_max=5))
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test2;

        end Noise;
      end Examples;

      package Noise
        model GlobalSeed
          "xxx Defines a global seed value and provides an impure random number generator"
          // import TestRandomFeatures.Version3.Math.Random;

          parameter Boolean enableNoise = true
            "= true, if noise blocks generate noise as output; = false, if they generate a constant output"
            annotation(choices(checkBox=true));
          parameter Boolean useAutomaticSeed = false
            "= true, choose a seed by system time and process id; = false, use fixedSeed"
            annotation(choices(checkBox=true));
          parameter Integer fixedSeed = 67867967
            "Fixed global seed for random number generators (if useAutomaticSeed = false)"
              annotation(Dialog(enable=not useAutomaticSeed));
          final parameter Integer seed = if useAutomaticSeed then 2*fixedSeed else fixedSeed;

          /*
  replaceable package Generator = Random.Generators.WhichmannHill constrainedby
    Random.Interfaces.PartialGenerator
    "The uniform random number generator to be used in the model"
    annotation(choicesAllMatching=true, Dialog(tab="Advanced"));
    */
          annotation (
           defaultComponentName="globalSeed",
            defaultComponentPrefixes="inner",
            missingInnerMessage="
Your model is using an outer \"globalSeed\" component but
an inner \"globalSeed\" component is not defined and therefore
a default inner \"globalSeed\" component is introduced by the tool.
To change the default setting, drag Noise.GlobalSeed
into your model and specify the seed.
",        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                 graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                                Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255}),
                Line(visible=  enableNoise,
                     points={{-73,-15},{-59,-15},{-59,1},{-51,1},{-51,-47},{-43,-47},{-43,
                      -25},{-35,-25},{-35,59},{-27,59},{-27,27},{-27,27},{-27,-33},{-17,-33},{-17,-15},{-7,-15},{-7,-43},{3,
                      -43},{3,39},{9,39},{9,53},{15,53},{15,-3},{25,-3},{25,9},{31,9},{31,
                      -21},{41,-21},{41,51},{51,51},{51,17},{59,17},{59,-49},{69,-49}},
                    color={215,215,215}),
                Text(visible=enableNoise and not useAutomaticSeed,
                  extent={{-90,8},{88,-18}},
                  lineColor={255,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="%fixedSeed"),
                Line(visible=  not enableNoise,
                  points={{-80,-4},{84,-4}},
                  color={215,215,215},
                  smooth=Smooth.None)}),
            Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>",         info="<html>
<p>Inner/Outer Model for Global Seeding.</p>
<p>This model enables the modeler to define a global seed value for random generators.</p>
<p>The seed value can then be used (i.e. combined with a local seed value) at local pseudo-random signal generators. If so, then a switch of the global seed changes all pseudo-random signals.</p>
<p>Remark: Some pseudo-random number generators demand for larger seed values (array of integers). In this case the large seed is automatically generated out of this single integer seed value.</p>
</html>"));
        end GlobalSeed;

        block EventBasedNoise
          import TestRandomFeatures.Version3.Math.Random;
          extends Modelica.Blocks.Interfaces.SO;

          parameter Boolean enableNoise = true
            "=true: y = noise, otherwise y = y_off"
            annotation(choices(checkBox=true),Dialog(tab="Advanced"));
          parameter Real y_off = 0.0 "Output value if enableNoise=false"
            annotation(Dialog(tab="Advanced",enable=not enableNoise));

          parameter Boolean useGlobalSeed = true
            "= true: global seed influences random numbers, otherwise global seed is ignored"
            annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Integer localSeed = 237
            "The local seed for initializing the random number generator"
            annotation(Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time startTime = 0.0
            "Start time for sampling the raw random numbers"
            annotation(Dialog(tab="Advanced", group="Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time samplePeriod(start=0.01)
            "Period for sampling the raw random numbers"
            annotation(Dialog(enable=enableNoise));
          replaceable function distribution = Random.Distributions.uniformBand
                               constrainedby
            Random.Interfaces.partialDistribution
            "Random number generator with a specific distribution"
            annotation(choicesAllMatching=true, Dialog(enable=enableNoise));
        protected
          parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
            "The global seed, which is atually used";
          parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise;
          outer GlobalSeed globalSeed;
          package Generator =
              TestRandomFeatures.Version3.Math.Random.Generators.WhichmannHill;
          constant Integer nState = Generator.nState;
          Integer state[nState];
          Real r "Random number according to the desired distribution";
        initial equation
          pre(state) = Generator.initialState(localSeed, actualGlobalSeed);
        equation
          when {initial(), generateNoise and sample(startTime, samplePeriod)} then
            (r,state) = distribution(stateIn=pre(state),uniformRandom=Generator.uniformRandom);
            y = if generateNoise then r else y_off;
          end when;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Polygon(
                  points={{-76,90},{-84,68},{-68,68},{-76,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
                Line(points={{-86,0},{72,0}}, color={192,192,192}),
                Polygon(
                  points={{94,0},{72,8},{72,-8},{94,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(visible=  enableNoise,
                   points={{-75,-13},{-61,-13},{-61,3},{-53,3},{-53,-45},{-45,-45},{-45,
                      -23},{-37,-23},{-37,61},{-29,61},{-29,29},{-29,29},{-29,-31},{-19,
                      -31},{-19,-13},{-9,-13},{-9,-41},{1,-41},{1,41},{7,41},{7,55},{13,
                      55},{13,-1},{23,-1},{23,11},{29,11},{29,-19},{39,-19},{39,53},{49,
                      53},{49,19},{57,19},{57,-47},{67,-47}},
                    color={0,0,0}),
                Text(visible=enableNoise,
                  extent={{-150,-110},{150,-150}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%samplePeriod s"),
                Line(visible=not enableNoise,
                  points={{-76,56},{72,56}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Text(visible=not enableNoise,
                  extent={{-75,50},{95,10}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%y_off")}));
        end EventBasedNoise;
      end Noise;
    end Blocks;

    package Math
      package Random
        package Generators
          package WhichmannHill
            "Wichmann-Hill generator (a variant of a multiplicative congruential algorithm)"
            extends
              TestRandomFeatures.Version3.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill;

          package WhichmannHill2
            "Wichmann-Hill generator (variant2; multiplied by 2)"
            extends
              TestRandomFeatures.Version3.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom "Multiplied random by 2"
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := 2*rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill2;
        end Generators;

        package Distributions
          function uniformBand "Uniform distribution in a band"
            extends
              TestRandomFeatures.Version3.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := r*(y_max - y_min) + y_min;
          end uniformBand;

          function uniformBand2
            "Variant 2: Uniform distribution in a band (added offset of 10)"
            extends
              TestRandomFeatures.Version3.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := 10 + r*(y_max - y_min) + y_min;
          end uniformBand2;
        end Distributions;

        package Interfaces
          partial package PartialGenerator
            "Interfaces of a uniform random number generator"
            constant Integer nState=1
              "The dimension of the internal state vector";

            replaceable partial function initialState
              "Return the initial internal states for the uniform random number generator"
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[:] state "The generated initial states";
            end initialState;

            replaceable partial function uniformRandom
              "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
              extends
                TestRandomFeatures.Version3.Math.Random.Interfaces.partialUniformRandom;
            end uniformRandom;

          end PartialGenerator;

          partial function partialUniformRandom
            "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
            extends Modelica.Icons.Function;
            input Integer[:] stateIn
              "The internal states for the random number generator";
            output Real result
              "A random number with a uniform distribution on the interval (0,1]";
            output Integer[size(stateIn,1)] stateOut
              "The new internal states of the random number generator";
          end partialUniformRandom;

          partial function partialDistribution
            "Return a random number according to a specific distribution"
            import TestRandomFeatures.Version3.Math.Random;
            extends Modelica.Icons.Function;
            input Integer[:] stateIn
              "The internal states for the random number generator";
            input Random.Interfaces.partialUniformRandom uniformRandom
              "The uniform random number generator to be used in this funcion";
            output Real result
              "A random number according to the desired distribution";
            output Integer[size(stateIn,1)] stateOut
              "The new internal states of the random number generator";
          end partialDistribution;
        end Interfaces;
      end Random;
    end Math;
    annotation ();
  end Version3;

    package Version4
    "Generator is fixed (cannot be selected) + distribution can be selected locally with no restrictions on random calls (and uniformRandom function directly called in function)"

    package Blocks
      package Examples
        extends Modelica.Icons.ExamplesPackage;

        package Noise
          extends Modelica.Icons.ExamplesPackage;
          model Test1 "Noise between -1 .. 5"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version4.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version4.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01, redeclare function distribution =
                  TestRandomFeatures.Version4.Math.Random.Distributions.uniformBand
                  ( y_min=-1, y_max=5),
              enableNoise=true)
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test1;

          model Test2 "Noise between 10 .. 16"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version4.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version4.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01,
              enableNoise=true,
              redeclare function distribution =
                  TestRandomFeatures.Version4.Math.Random.Distributions.uniformBand2
                  ( y_min=-1, y_max=5))
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test2;

        end Noise;
      end Examples;

      package Noise
        model GlobalSeed
          "xxx Defines a global seed value and provides an impure random number generator"
          // import TestRandomFeatures.Version4.Math.Random;

          parameter Boolean enableNoise = true
            "= true, if noise blocks generate noise as output; = false, if they generate a constant output"
            annotation(choices(checkBox=true));
          parameter Boolean useAutomaticSeed = false
            "= true, choose a seed by system time and process id; = false, use fixedSeed"
            annotation(choices(checkBox=true));
          parameter Integer fixedSeed = 67867967
            "Fixed global seed for random number generators (if useAutomaticSeed = false)"
              annotation(Dialog(enable=not useAutomaticSeed));
          final parameter Integer seed = if useAutomaticSeed then 2*fixedSeed else fixedSeed;

          /*
  replaceable package Generator = Random.Generators.WhichmannHill constrainedby
    Random.Interfaces.PartialGenerator
    "The uniform random number generator to be used in the model"
    annotation(choicesAllMatching=true, Dialog(tab="Advanced"));
    */
          annotation (
           defaultComponentName="globalSeed",
            defaultComponentPrefixes="inner",
            missingInnerMessage="
Your model is using an outer \"globalSeed\" component but
an inner \"globalSeed\" component is not defined and therefore
a default inner \"globalSeed\" component is introduced by the tool.
To change the default setting, drag Noise.GlobalSeed
into your model and specify the seed.
",        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                 graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                                Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255}),
                Line(visible=  enableNoise,
                     points={{-73,-15},{-59,-15},{-59,1},{-51,1},{-51,-47},{-43,-47},{-43,
                      -25},{-35,-25},{-35,59},{-27,59},{-27,27},{-27,27},{-27,-33},{-17,-33},{-17,-15},{-7,-15},{-7,-43},{3,
                      -43},{3,39},{9,39},{9,53},{15,53},{15,-3},{25,-3},{25,9},{31,9},{31,
                      -21},{41,-21},{41,51},{51,51},{51,17},{59,17},{59,-49},{69,-49}},
                    color={215,215,215}),
                Text(visible=enableNoise and not useAutomaticSeed,
                  extent={{-90,8},{88,-18}},
                  lineColor={255,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="%fixedSeed"),
                Line(visible=  not enableNoise,
                  points={{-80,-4},{84,-4}},
                  color={215,215,215},
                  smooth=Smooth.None)}),
            Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>",         info="<html>
<p>Inner/Outer Model for Global Seeding.</p>
<p>This model enables the modeler to define a global seed value for random generators.</p>
<p>The seed value can then be used (i.e. combined with a local seed value) at local pseudo-random signal generators. If so, then a switch of the global seed changes all pseudo-random signals.</p>
<p>Remark: Some pseudo-random number generators demand for larger seed values (array of integers). In this case the large seed is automatically generated out of this single integer seed value.</p>
</html>"));
        end GlobalSeed;

        block EventBasedNoise
          import TestRandomFeatures.Version4.Math.Random;
          extends Modelica.Blocks.Interfaces.SO;

          parameter Boolean enableNoise = true
            "=true: y = noise, otherwise y = y_off"
            annotation(choices(checkBox=true),Dialog(tab="Advanced"));
          parameter Real y_off = 0.0 "Output value if enableNoise=false"
            annotation(Dialog(tab="Advanced",enable=not enableNoise));

          parameter Boolean useGlobalSeed = true
            "= true: global seed influences random numbers, otherwise global seed is ignored"
            annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Integer localSeed = 237
            "The local seed for initializing the random number generator"
            annotation(Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time startTime = 0.0
            "Start time for sampling the raw random numbers"
            annotation(Dialog(tab="Advanced", group="Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time samplePeriod(start=0.01)
            "Period for sampling the raw random numbers"
            annotation(Dialog(enable=enableNoise));
          replaceable function distribution = Random.Distributions.uniformBand
                               constrainedby
            Random.Interfaces.partialDistribution
            "Random number generator with a specific distribution"
            annotation(choicesAllMatching=true, Dialog(enable=enableNoise));
        protected
          parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
            "The global seed, which is atually used";
          parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise;
          outer GlobalSeed globalSeed;
          package Generator =
              TestRandomFeatures.Version4.Math.Random.Generators.WhichmannHill;
          constant Integer nState = Generator.nState;
          Integer state[nState];
          Real r "Random number according to the desired distribution";
        initial equation
          pre(state) = Generator.initialState(localSeed, actualGlobalSeed);
        equation
          when {initial(), generateNoise and sample(startTime, samplePeriod)} then
            (r,state) = distribution(stateIn=pre(state));
            y = if generateNoise then r else y_off;
          end when;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Polygon(
                  points={{-76,90},{-84,68},{-68,68},{-76,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
                Line(points={{-86,0},{72,0}}, color={192,192,192}),
                Polygon(
                  points={{94,0},{72,8},{72,-8},{94,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(visible=  enableNoise,
                   points={{-75,-13},{-61,-13},{-61,3},{-53,3},{-53,-45},{-45,-45},{-45,
                      -23},{-37,-23},{-37,61},{-29,61},{-29,29},{-29,29},{-29,-31},{-19,
                      -31},{-19,-13},{-9,-13},{-9,-41},{1,-41},{1,41},{7,41},{7,55},{13,
                      55},{13,-1},{23,-1},{23,11},{29,11},{29,-19},{39,-19},{39,53},{49,
                      53},{49,19},{57,19},{57,-47},{67,-47}},
                    color={0,0,0}),
                Text(visible=enableNoise,
                  extent={{-150,-110},{150,-150}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%samplePeriod s"),
                Line(visible=not enableNoise,
                  points={{-76,56},{72,56}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Text(visible=not enableNoise,
                  extent={{-75,50},{95,10}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%y_off")}));
        end EventBasedNoise;
      end Noise;
    end Blocks;

    package Math
      package Random
        package Generators
          package WhichmannHill
            "Wichmann-Hill generator (a variant of a multiplicative congruential algorithm)"
            extends
              TestRandomFeatures.Version4.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill;

          package WhichmannHill2
            "Wichmann-Hill generator (variant2; multiplied by 2)"
            extends
              TestRandomFeatures.Version4.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom "Multiplied random by 2"
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := 2*rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill2;
        end Generators;

        package Distributions
          function uniformBand "Uniform distribution in a band"
            extends
              TestRandomFeatures.Version4.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
            function uniformRandom =
                TestRandomFeatures.Version4.Math.Random.Generators.WhichmannHill.uniformRandom;
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := r*(y_max - y_min) + y_min;
          end uniformBand;

          function uniformBand2
            "Variant 2: Uniform distribution in a band (added offset of 10)"
            extends
              TestRandomFeatures.Version4.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
            function uniformRandom =
                TestRandomFeatures.Version4.Math.Random.Generators.WhichmannHill.uniformRandom;
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := 10 + r*(y_max - y_min) + y_min;
          end uniformBand2;
        end Distributions;

        package Interfaces
          partial package PartialGenerator
            "Interfaces of a uniform random number generator"
            constant Integer nState=1
              "The dimension of the internal state vector";

            replaceable partial function initialState
              "Return the initial internal states for the uniform random number generator"
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[:] state "The generated initial states";
            end initialState;

            replaceable partial function uniformRandom
              "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
              extends
                TestRandomFeatures.Version4.Math.Random.Interfaces.partialUniformRandom;
            end uniformRandom;

          end PartialGenerator;

          partial function partialUniformRandom
            "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
            extends Modelica.Icons.Function;
            input Integer[:] stateIn
              "The internal states for the random number generator";
            output Real result
              "A random number with a uniform distribution on the interval (0,1]";
            output Integer[size(stateIn,1)] stateOut
              "The new internal states of the random number generator";
          end partialUniformRandom;

          partial function partialDistribution
            "Return a random number according to a specific distribution"
            import TestRandomFeatures.Version4.Math.Random;
            extends Modelica.Icons.Function;
            input Integer[:] stateIn
              "The internal states for the random number generator";
            output Real result
              "A random number according to the desired distribution";
            output Integer[size(stateIn,1)] stateOut
              "The new internal states of the random number generator";
          end partialDistribution;
        end Interfaces;
      end Random;
    end Math;
    end Version4;

    package Version5
    "Generator is fixed (cannot be selected) + distribution can be selected locally with no restrictions on random calls (and uniformRandom function directly called in function with a simplification)"

    package Blocks
      package Examples
        extends Modelica.Icons.ExamplesPackage;

        package Noise
          extends Modelica.Icons.ExamplesPackage;
          model Test1 "Noise between -1 .. 5"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version5.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version5.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01, redeclare function distribution =
                  TestRandomFeatures.Version5.Math.Random.Distributions.uniformBand
                  ( y_min=-1, y_max=5),
              enableNoise=true)
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test1;

          model Test2 "Noise between 10 .. 16"
             extends Modelica.Icons.Example;
            inner TestRandomFeatures.Version5.Blocks.Noise.GlobalSeed globalSeed(
              useAutomaticSeed=false,
              enableNoise=true)
              annotation (Placement(transformation(extent={{20,40},{40,60}})));
            TestRandomFeatures.Version5.Blocks.Noise.EventBasedNoise eventBasedNoise(
                samplePeriod=0.01,
              enableNoise=true,
              redeclare function distribution =
                  TestRandomFeatures.Version5.Math.Random.Distributions.uniformBand2
                  ( y_min=-1, y_max=5))
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
           annotation (experiment(StopTime=2));
          end Test2;

        end Noise;
      end Examples;

      package Noise
        model GlobalSeed
          "xxx Defines a global seed value and provides an impure random number generator"
          // import TestRandomFeatures.Version5.Math.Random;

          parameter Boolean enableNoise = true
            "= true, if noise blocks generate noise as output; = false, if they generate a constant output"
            annotation(choices(checkBox=true));
          parameter Boolean useAutomaticSeed = false
            "= true, choose a seed by system time and process id; = false, use fixedSeed"
            annotation(choices(checkBox=true));
          parameter Integer fixedSeed = 67867967
            "Fixed global seed for random number generators (if useAutomaticSeed = false)"
              annotation(Dialog(enable=not useAutomaticSeed));
          final parameter Integer seed = if useAutomaticSeed then 2*fixedSeed else fixedSeed;

          /*
  replaceable package Generator = Random.Generators.WhichmannHill constrainedby
    Random.Interfaces.PartialGenerator
    "The uniform random number generator to be used in the model"
    annotation(choicesAllMatching=true, Dialog(tab="Advanced"));
    */
          annotation (
           defaultComponentName="globalSeed",
            defaultComponentPrefixes="inner",
            missingInnerMessage="
Your model is using an outer \"globalSeed\" component but
an inner \"globalSeed\" component is not defined and therefore
a default inner \"globalSeed\" component is introduced by the tool.
To change the default setting, drag Noise.GlobalSeed
into your model and specify the seed.
",        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                 graphics={Ellipse(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                                Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255}),
                Line(visible = enableNoise,
                     points={{-73,-15},{-59,-15},{-59,1},{-51,1},{-51,-47},{-43,-47},{-43,
                      -25},{-35,-25},{-35,59},{-27,59},{-27,27},{-27,27},{-27,-33},{-17,-33},{-17,-15},{-7,-15},{-7,-43},{3,
                      -43},{3,39},{9,39},{9,53},{15,53},{15,-3},{25,-3},{25,9},{31,9},{31,
                      -21},{41,-21},{41,51},{51,51},{51,17},{59,17},{59,-49},{69,-49}},
                    color={215,215,215}),
                Text(visible=enableNoise and not useAutomaticSeed,
                  extent={{-90,8},{88,-18}},
                  lineColor={255,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="%fixedSeed"),
                Line(visible = not enableNoise,
                  points={{-80,-4},{84,-4}},
                  color={215,215,215},
                  smooth=Smooth.None)}),
            Documentation(revisions="<html>
<p><img src=\"modelica://Noise/Resources/Images/dlr_logo.png\"/> <b>Developed 2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>",         info="<html>
<p>Inner/Outer Model for Global Seeding.</p>
<p>This model enables the modeler to define a global seed value for random generators.</p>
<p>The seed value can then be used (i.e. combined with a local seed value) at local pseudo-random signal generators. If so, then a switch of the global seed changes all pseudo-random signals.</p>
<p>Remark: Some pseudo-random number generators demand for larger seed values (array of integers). In this case the large seed is automatically generated out of this single integer seed value.</p>
</html>"));
        end GlobalSeed;

        block EventBasedNoise
          import TestRandomFeatures.Version5.Math.Random;
          extends Modelica.Blocks.Interfaces.SO;

          parameter Boolean enableNoise = true
            "=true: y = noise, otherwise y = y_off"
            annotation(choices(checkBox=true),Dialog(tab="Advanced"));
          parameter Real y_off = 0.0 "Output value if enableNoise=false"
            annotation(Dialog(tab="Advanced",enable=not enableNoise));

          parameter Boolean useGlobalSeed = true
            "= true: global seed influences random numbers, otherwise global seed is ignored"
            annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Integer localSeed = 237
            "The local seed for initializing the random number generator"
            annotation(Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time startTime = 0.0
            "Start time for sampling the raw random numbers"
            annotation(Dialog(tab="Advanced", group="Initialization",enable=enableNoise));
          parameter Modelica.SIunits.Time samplePeriod(start=0.01)
            "Period for sampling the raw random numbers"
            annotation(Dialog(enable=enableNoise));
          replaceable function distribution = Random.Distributions.uniformBand
                               constrainedby
            Random.Interfaces.partialDistribution
            "Random number generator with a specific distribution"
            annotation(choicesAllMatching=true, Dialog(enable=enableNoise));
        protected
          parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
            "The global seed, which is atually used";
          parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise;
          outer GlobalSeed globalSeed;
          package Generator =
              TestRandomFeatures.Version5.Math.Random.Generators.WhichmannHill;
          constant Integer nState = Generator.nState;
          Integer state[nState];
          Real r "Random number according to the desired distribution";
        initial equation
          pre(state) = Generator.initialState(localSeed, actualGlobalSeed);
        equation
          when {initial(), generateNoise and sample(startTime, samplePeriod)} then
            (r,state) = distribution(stateIn=pre(state));
            y = if generateNoise then r else y_off;
          end when;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                    {100,100}}), graphics={
                Polygon(
                  points={{-76,90},{-84,68},{-68,68},{-76,90}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
                Line(points={{-86,0},{72,0}}, color={192,192,192}),
                Polygon(
                  points={{94,0},{72,8},{72,-8},{94,0}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(visible = enableNoise,
                   points={{-75,-13},{-61,-13},{-61,3},{-53,3},{-53,-45},{-45,-45},{-45,
                      -23},{-37,-23},{-37,61},{-29,61},{-29,29},{-29,29},{-29,-31},{-19,
                      -31},{-19,-13},{-9,-13},{-9,-41},{1,-41},{1,41},{7,41},{7,55},{13,
                      55},{13,-1},{23,-1},{23,11},{29,11},{29,-19},{39,-19},{39,53},{49,
                      53},{49,19},{57,19},{57,-47},{67,-47}},
                    color={0,0,0}),
                Text(visible=enableNoise,
                  extent={{-150,-110},{150,-150}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%samplePeriod s"),
                Line(visible=not enableNoise,
                  points={{-76,56},{72,56}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Text(visible=not enableNoise,
                  extent={{-75,50},{95,10}},
                  lineColor={0,0,0},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  textString="%y_off")}));
        end EventBasedNoise;
      end Noise;
    end Blocks;

    package Math
      package Random
        package Generators
          package WhichmannHill
            "Wichmann-Hill generator (a variant of a multiplicative congruential algorithm)"
            extends
              TestRandomFeatures.Version5.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill;

          package WhichmannHill2
            "Wichmann-Hill generator (variant2; multiplied by 2)"
            extends
              TestRandomFeatures.Version5.Math.Random.Interfaces.PartialGenerator(
               final nState=3);

            redeclare function initialState
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[3] state "The generated initial states";
            algorithm
               state := {localSeed, globalSeed, 187};
            end initialState;

            redeclare function uniformRandom "Multiplied random by 2"
              extends Modelica.Icons.Function;
              input Integer[3] stateIn
                "The internal states for the uniform random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the uniform random number generator";
            algorithm
            stateOut[1] := rem(abs(171*stateIn[1]), 30269);
            stateOut[2] := rem(abs(172*stateIn[2]), 30307);
            stateOut[3] := rem(abs(170*stateIn[3]), 30323);

            // zero is a poor seed, therfore substitute 1;
            for i in 1:3 loop
              if stateOut[i] == 0 then
                stateOut[i] := 1;
              end if;
            end for;

            result := 2*rem(abs(stateOut[1]/30269.0 + stateOut[2]/30307.0 + stateOut[3]/30323.0), 1.0);

            end uniformRandom;
          end WhichmannHill2;
        end Generators;

        package Distributions
          function uniformBand "Uniform distribution in a band"
            extends
              TestRandomFeatures.Version5.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
            function uniformRandom =
                TestRandomFeatures.Version5.Math.Random.Generators.WhichmannHill.uniformRandom;
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := r*(y_max - y_min) + y_min;
          end uniformBand;

          function uniformBand2
            "Variant 2: Uniform distribution in a band (added offset of 10)"
            extends
              TestRandomFeatures.Version5.Math.Random.Interfaces.partialDistribution;
            input Real y_min=0 "Lower limit of band"
            annotation (Dialog);
            input Real y_max=1 "Upper limit of band"
            annotation (Dialog);
          protected
            Real r "uniform random number";
            function uniformRandom =
                TestRandomFeatures.Version5.Math.Random.Generators.WhichmannHill.uniformRandom;
          algorithm
            // Retrieve uniformly distributed random number
            (r,stateOut) := uniformRandom(stateIn);

            // Transform limits of distribution
            result := 10 + r*(y_max - y_min) + y_min;
          end uniformBand2;
        end Distributions;

        package Interfaces
          partial package PartialGenerator
            "Interfaces of a uniform random number generator"
            constant Integer nState=1
              "The dimension of the internal state vector";

            replaceable partial function initialState
              "Return the initial internal states for the uniform random number generator"
              extends Modelica.Icons.Function;
              input Integer localSeed
                "The local seed to be used for generating initial states";
              input Integer globalSeed
                "The global seed to be combined with the local seed";
              output Integer[:] state "The generated initial states";
            end initialState;

            replaceable partial function uniformRandom
              "Return a random number with a uniform distribution in the range 0.0 < result <= 1.0"
              extends Modelica.Icons.Function;
              input Integer[:] stateIn
                "The internal states for the random number generator";
              output Real result
                "A random number with a uniform distribution on the interval (0,1]";
              output Integer[size(stateIn,1)] stateOut
                "The new internal states of the random number generator";
            end uniformRandom;

          end PartialGenerator;


          partial function partialDistribution
            "Return a random number according to a specific distribution"
            extends Modelica.Icons.Function;
            input Integer[:] stateIn
              "The internal states for the random number generator";
            output Real result
              "A random number according to the desired distribution";
            output Integer[size(stateIn,1)] stateOut
              "The new internal states of the random number generator";
          end partialDistribution;
        end Interfaces;
      end Random;
    end Math;
    end Version5;
  annotation (uses(Modelica(version="3.2.1")));
end TestRandomFeatures;
