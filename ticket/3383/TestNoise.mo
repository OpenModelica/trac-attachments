within ;
package TestNoise

  model ExampleModel

    GenericNoise genericNoise(samplePeriod=0.1)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    inner GlobalSeedWithoutC globalSeed
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ExampleModel;

  model GlobalSeedWithoutC
    "Defines global settings for the blocks of sublibrary Noise, especially a global seed value is defined"
    parameter Boolean enableNoise = true
      "= true, if noise blocks generate noise as output; = false, if they generate a constant output"
      annotation(choices(checkBox=true));
    parameter Boolean useAutomaticSeed = false
      "= true, choose a seed by system time and process id; = false, use fixedSeed"
      annotation(choices(checkBox=true));
    parameter Integer fixedSeed = 67867967
      "Fixed global seed for random number generators (if useAutomaticSeed = false)"
        annotation(Dialog(enable=not useAutomaticSeed));
    final parameter Integer seed = if useAutomaticSeed then
                                      TestNoise.Utilities.automaticGlobalSeed()
                                    else fixedSeed "Actually used global seed";

    function random = TestNoise.Utilities.impureRandom(final id=id_impure)
      "Impure random number generator function";
    function randomInteger =
        TestNoise.Utilities.impureRandomInteger(final id=id_impure)
      "Impure Integer random number generator function";

  protected
    parameter Integer id_impure = TestNoise.Utilities.initializeImpureRandom(seed);

    annotation (
      defaultComponentName="globalSeed",
      defaultComponentPrefixes="inner",
      missingInnerMessage="
Your model is using an outer \"globalSeed\" component but
an inner \"globalSeed\" component is not defined and therefore
a default inner \"globalSeed\" component is introduced by the tool.
To change the default setting, drag Noise.GlobalSeed
into your model and specify the seed.
",  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
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
            extent={{-90,-4},{88,-30}},
            lineColor={255,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="%fixedSeed"),
          Line(visible = not enableNoise,
            points={{-80,-4},{84,-4}},
            color={215,215,215}),
          Text(visible=enableNoise and not useAutomaticSeed,
            extent={{-84,34},{94,8}},
            lineColor={255,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="fixedSeed =")}),
      Documentation(revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>",   info="<html>
<p>
When using one of the blocks of sublibrary <a href=\"modelica://Modelica_Noise.Blocks.Noise\">Noise</a>,
on the same or a higher hierarchical level, Noise.GlobalSeed
must be dragged resulting in a declaration
</p>

<pre>
   <b>inner</b> Modelica_Noise.Blocks.Noise.GlobalSeed globalSeed;
</pre>

<p>
The GlobalSeed block provides global options for all Noise blocks of the same or a lower
hierarchical level. The following options can be selected:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Icon</th>
    <th>Description</th></tr>

<tr><td> <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/GlobalSeed_FixedSeed.png\"> </td>
    <td> <b>useAutomaticSeed=false</b> (= default):<br>
         A fixed global seed is defined with Integer parameter fixedSeed. The value of fixedSeed
         is displayed in the icon. By default all Noise blocks use fixedSeed for initialization of their
         pseudo random number generators, in combination with a local seed defined for every instance
         separately. Therefore, whenever a simulation is performed with the
         same fixedSeed exactly the same noise is generated in all instances of the Noise
         blocks (provided the settings of these blocks are not changed as well).<br>
         This option can be used (a) to design a control system (e.g. by parameter optimization) and keep the same
         noise for all simulations, or (b) perform Monte Carlo Simulations where
         fixedSeed is changed from the environment for every simulation, in order to
         produce different noise at every simulation run.</td></tr>

<tr><td> <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/GlobalSeed_AutomaticSeed.png\"> </td>
    <td> <b>useAutomaticSeed=true</b>:<br>
         An automatic global seed is computed by using the ID of the process in which the
         simulation takes place and the current local time. As a result, the global seed
         is changed automatically for every new simulation, including parallelized
         simulation runs. This option can be used to perform Monte Carlo Simulations
         with minimal effort (just performinng many simulation runs) where
         every simulation run uses a different noise.</td></tr>


<tr><td> <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/GlobalSeed_NoNoise.png\"> </td>
    <td> <b>enableNoise=false</b>:<br>
         The noise in all Noise instances is switched off and the blocks output a constant
         signal all the time (usually zero). This option is useful, if a model shall be
         tested without noise and the noise shall be quickly turned off or on.</td></tr>
</table>
</p></blockquote>

<p>
Additionally, the globalSeed instance provides the following impure functions
</p>

<ul>
<li> <b>random</b>():<br>
     This function uses the <a href=\"modelica://Modelica_Noise.Math.Random.Generators.Xorshift1024star\">xorshift1024*</a>
     pseudo random number generator to produce random numbers in the range 0 &lt; random numbers &le; 1.
     It is initialized with the global seed defined in globalSeed
     (so either with parameter fixedSeed, or automatically computed by process ID and local time).
     Since random() is an impure function, it should only be called in a when-clause (so at an event).</li>
<li> <b>randomInteger</b>(imin=1,imax=Modelica.Constants.Integer_inf):<br>
     This function uses the random() pseudo random number generator and maps the returned random value
     into the Integer range imin ... imax. By default, imin=1 and imax=Modelica.Constants.Integer_inf.
     Since randomInteger() is an impure function, it should only be called in a when-clause
     (so at an event).</li>
</ul>

<p>
Note, the usage of this block is demonstrated with examples
<a href=\"modelica://Modelica_Noise.Blocks.Examples.NoiseExamples.AutomaticSeed\">AutomaticSeed</a> and
<a href=\"modelica://Modelica_Noise.Blocks.Examples.NoiseExamples.ImpureGenerator\">ImpureGenerator</a>.
</p>

<p>
Remark: The \"xorshift1024\" pseudo-random number generator has an internal state of 33 Integers.
This state is initialized in the following way: The pseudo-random number generator
<a href=\"modelica://Modelica_Noise.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>
is used to compute these 33 Integers. This random number generator has a state of 2 Integers which
is initialized with the global and local seed integers. Afterwards, random values are produced
with this random number generator and utilized as values for the internal state of
the Xorshift1024star random number generator.
</p>
</html>"));
  end GlobalSeedWithoutC;


  block GenericNoise "Noise generator for arbitrary distributions"
    import generator = TestNoise.Generator;

    extends Modelica.Blocks.Interfaces.SO;

    // Main dialog menu
    parameter Modelica.SIunits.Time samplePeriod(start=0.01)
      "Period for sampling the raw random numbers"
      annotation(Dialog(enable=enableNoise));
    parameter Real y_min=0 "Lower limit of y";
    parameter Real y_max=1 "Upper limit of y";
  /*
  replaceable partial function distribution =
    Modelica_Noise.Math.Distributions.Interfaces.partialQuantile 
    "Random number distribution"
    annotation(choicesAllMatching=true, Dialog(enable=enableNoise));
*/

    // Advanced dialog menu: Noise generation
    parameter Boolean enableNoise = true
      "=true: y = noise, otherwise y = y_off"
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group="Noise generation"));
    parameter Real y_off = 0.0
      "y = y_off if enableNoise=false (or time<startTime, see below)"
      annotation(Dialog(tab="Advanced",group="Noise generation"));

    // Advanced dialog menu: Initialization
    parameter Boolean useGlobalSeed = true
      "= true: use global seed, otherwise ignore it"
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
    parameter Boolean useAutomaticLocalSeed = true
      "= true: use automatic local seed, otherwise use fixedLocalSeed"
      annotation(choices(checkBox=true),Dialog(tab="Advanced",group = "Initialization",enable=enableNoise));
    parameter Integer fixedLocalSeed = 1 "Local seed (any Integer number)"
      annotation(Dialog(tab="Advanced",group = "Initialization",enable=enableNoise and not useAutomaticLocalSeed));
    parameter Modelica.SIunits.Time startTime = 0.0
      "Start time for sampling the raw random numbers"
      annotation(Dialog(tab="Advanced", group="Initialization",enable=enableNoise));

    // Advanced dialog menu: Random number properties
  /*  
  replaceable package generator =
      Modelica_Noise.Math.Random.Generators.Xorshift128plus constrainedby 
    Modelica_Noise.Math.Random.Interfaces.PartialGenerator 
    "Random number generator"
    annotation(choicesAllMatching=true, Dialog(tab="Advanced",group="Random number generator",enable=enableNoise));
*/

    discrete Integer localSeed "The actual localSeed";

  protected
    outer TestNoise.GlobalSeedWithoutC globalSeed
      "Definition of global seed via inner/outer";
    parameter Integer actualGlobalSeed = if useGlobalSeed then globalSeed.seed else 0
      "The global seed, which is atually used";
    parameter Boolean generateNoise = enableNoise and globalSeed.enableNoise
      "= true if noise shall be generated, otherwise no noise";

    // Declare state and random number variables
    Integer state[4] "Internal state of random number generator";
    discrete Real r "Random number according to the desired distribution";
    discrete Real r_raw "Uniform random number in the range (0,1]";

  initial equation
     pre(state) = generator.initialState(localSeed, actualGlobalSeed);
     r_raw = generator.random(pre(state));
     r = r_raw;

  equation
    when initial() then
      localSeed = if useAutomaticLocalSeed then globalSeed.randomInteger() else fixedLocalSeed;
    end when;

    // Draw random number at sample times
    when generateNoise and sample(startTime, samplePeriod) then
      (r_raw, state) = generator.random(pre(state));
      r  = r_raw;
    end when;

    // Generate noise if requested
    y = if not generateNoise or time < startTime then y_off else r;

      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
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
                53},{49,19},{57,19},{57,-47},{67,-47}}),
          Text(visible=enableNoise,
            extent={{-150,-110},{150,-150}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            textString="%samplePeriod s"),
          Line(visible=not enableNoise,
            points={{-76,56},{72,56}}),
          Text(visible=not enableNoise,
            extent={{-75,50},{95,10}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            textString="%y_off"),
          Text(visible=enableNoise and not useAutomaticLocalSeed,
            extent={{-98,-55},{98,-95}},
            lineColor={238,46,47},
            textString="%fixedLocalSeed")}),
      Documentation(info="<html>
<p>
A summary of the properties of the noise blocks is provided
in the documentation of package
<a href=\"modelica://Modelica_Noise.Blocks.Noise\">Blocks.Noise</a>.
This GenericNoise block generates reproducible, random noise at its output.
By default, two or more instances produce different, uncorrelated noise at the same time instant.
The block can only be used if on the same or a higher hierarchical level,
model <a href=\"modelica://Modelica_Noise.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
is dragged to provide global settings for all instances.
</p>


<h4>Parameters that need to be defined</h4>

<p>
When using this block, at a minimum the following parameters must be defined:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Parameter</th>
    <th>Description</th></tr>

<tr><td> samplePeriod </td>
    <td> Random values are drawn periodically at the sample rate in [s]
         defined with this parameter (time events are generated at the sample instants).
         Between sample instants, the output y is kept constant.</td></tr>

<tr><td> distribution </td>
    <td> Defines the random number distribution to map the drawn random numbers
         from the range 0.0 ... 1.0, to the desired range and distribution.
         Basically, <b>distribution</b> is a replaceable function that
         provides the quantile (= inverse cumulative distribution function)
         of a random distribution. For simulation models
         <a href=\"modelica://Modelica_Noise.Math.Distributions\">truncated distributions</a>
         are of special interest, because the returned random values are guaranteed
         to be in a defined band y_min ... y_max. Often used distributions are:
         <ul>
         <li> <a href=\"modelica://Modelica_Noise.Math.Distributions.Uniform\">Uniform distribution</a>:
              The random values are mapped <b>uniformly</b> to the band
              y_min ... y_max.</li>
         <li> <a href=\"modelica://Modelica_Noise.Math.Distributions.TruncatedNormal\">Truncated normal distribution</a>:
              The random values have a <b>normal</b> distribution that
              is truncated to y_min ... y_max. Measurement noise has often this distribution form.
              By default, the standard parameters of the truncated normal distribution are derived from
              y_min ... y_max: mean value = (y_max + y_min)/2, standard deviation
              = (y_max - y_min)/6 (= 99.7 % of the non-truncated normal distribution are
              within y_min ... y_max).</li>
         </ul>
         </td></tr>
</table>
</p></blockquote>

<p>
As a simple demonstration, see example <a href=\"modelica://Modelica_Noise.Blocks.Examples.NoiseExamples.GenericNoise\">Blocks.Examples.NoiseExamples.GenericNoise</a>.
In the next diagram, a simulation result is shown for samplePeriod=0.02 s and uniform distribution with
y_min=-1, y_max=3:
</p>
<p><blockquote>
<img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Examples/NoiseExamples/GenericNoise.png\">
</blockquote>
</p>

<h4>Advanced tab: General settings</h4>
<p>
In the <b>Advanced</b> tab of the parameter menu, further options can be set
as shown in the next table:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Parameter</th>
    <th>Description</th></tr>

<tr><td> enableNoise </td>
    <td> = true, if noise is generated at the output of the block (this is the default).<br>
         = false, if noise generation is switched off and the constant value
         y_off is provided as output.</td></tr>
<tr><td> y_off </td>
    <td> If enableNoise = false, the output of the block instance has the
         value y_off. Default is y_off = 0.0.
         Furthermore, if enableNoise = true and time&lt;startTime, the output of the block is also
         y_off (see description of parameter startTime below).</td></tr>
</table>
</p></blockquote>



<h4>Advanced tab: Initialization</h4>

<p>
For every block instance, the internally used pseudo random number generator
has its own state. This state must be properly initialized, depending on
the desired situation. For this purpose the following parameters can be defined:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Parameter</th>
    <th>Description</th></tr>

<tr><td> useGlobalSeed </td>
    <td> = true, if the seed (= Integer number) defined in the \"inner GlobalSeed globalSeed\"
         component is used for the initialization of the random number generator used in this
         instance of block GenericNoise.
         Therefore, whenever the globalSeed defines a different number, the noise at every
         instance is changing. This is the default setting and therefore the globalSeed component
         defines whether every new simulation run shall provide the same noise
         (e.g. for a parameter optimization of controller parameters), or
         whether every new simulation run shall provide different noise
         (e.g. for a Monte Carlo simulation).<br>
         = false, if the seed defined by globalSeed is ignored. For example, if
         aerodynamic turbulence is modelled with a noise block and this turbulence
         model shall be used for all simulation runs of a Monte Carlo simulation, then
         useGlobalSeed has to be set to false.</td></tr>

<tr><td> useAutomaticLocalSeed </td>
    <td> An Integer number, called local seed, is needed to initalize the random number
         generator for a specific block instance. Instances using the same local seed
         produce exactly the same random number values (so the same noise, if the other settings
         of the instances are the same).<br>
         If <b>useAutomaticLocalSeed = true</b>, the
         local seed is determined automatically from an impure random number generator that
         produces Integer random values (= calling function globalSeed.randomInteger()).
         This is the default.
         Note, this means that the noise might change if function randomInteger() is called
         more or less often in the overall model (e.g. because an additional noise block is
         introduced or removed). It is planned to change the automatic local seed function
         in a future version of package Modelica, once Modelica Language 3.3 language elements
         can be used (by using a hash value of the instance name of the model that is
         inquired with the Modelica Language 3.3 function getInstanceName()).<br>
         If <b>useAutomaticLocalSeed = false</b>, the local seed is defined
         explicitly by parameter fixedLocalSeed. It is then guaranteed that the generated noise
         remains always the same (provided the other parameter values are the same).</td></tr>

<tr><td> fixedLocalSeed </td>
    <td> If useAutomaticLocalSeed = false, the local seed to be used.
         fixedLocalSeed can be any Integer number (including zero or a negative number).
         The initialization algorithm produces a meaningful initial state of the random
         number generator from fixedLocalSeed and (if useAutomaticGlobalSeed=true) from globalSeed even for
         bad seeds such as 0 or 1, so the subsequently drawing of random numbers produce always statistically
         meaningful numbers.</td></tr>

<tr><td> startTime </td>
    <td> The time instant at which noise shall be generated at the output y. The default
         startTime = 0.
         For time&lt;startTime, y = y_off. In some cases it is meaningful to simulate
         a certain duration until an approximate steady-state is reached. In such a case
         startTime should be set to a time instant after this duration.</td></tr>
</table>
</p></blockquote>

<h4>Advanced tab: Random number generator</h4>
<p>
The (pseudo) random number generator to be used is defined here.
The default is random number generator algorithm \"xorshift128+\".
This random number generator has a period of 2^128,
has an internal state of 4 Integer elements, and has
excellent statistical properties.
If the default algorithm is not desired, the
following parameter can be set:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Parameter</th>
    <th>Description</th></tr>

<tr><td> generator </td>
    <td> Defines the pseudo random number generator to be used. This is
         a replaceable package. Meaningful random number generators are provided in
         package <a href=\"modelica://Modelica_Noise.Math.Random.Generators\">Math.Random.Generators</a>.
         Properties of the various generators are described in the package
         description of the Generators package.</td></tr>
</table>
</p></blockquote>
</html>",   revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>"));
  end GenericNoise;

  package Utilities

    function impureRandomInteger
      "Impure random number generator for integer values (with hidden state vector)"
      input Integer id
        "Identification number from initializeImpureRandom(..) function (is needed for correct sorting)";
      input Integer imin = 1 "Minimum integer to generate";
      input Integer imax = Modelica.Constants.Integer_inf
        "Maximum integer to generate";
      output Integer y
        "A random number with a uniform distribution on the interval [imin,imax]";
    protected
      Real r "Impure Real random number";
    algorithm
      r := id/(id+1);
      y  := integer(r*imax) + integer((1-r)*imin);
      y  := min(imax, max(imin, y));

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
r = <b>impureRandomInteger</b>(id, imin=1, imax=Modelica.Constants.Integer_inf);
</pre></blockquote>

<h4>Description</h4>
<p>
Returns an Integer random number in the range imin &le; random &le; imax with the xorshift1024* algorithm,
(the random number in the range 0 ... 1 returned by the xorshift1024* algorithm is mapped to
an Integer number in the range imin ... imax).
The dummy input Integer argument id must be the output argument of a call to function
<a href=\"modelica://Modelica_Noise.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>,
in order that the sorting order is correct (so that impureRandomInteger is always called
after initializeImpureRandom). For every call of impureRandomInteger(id), a different random number
is returned, so the function is impure.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica_Noise.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>,
<a href=\"modelica://Modelica_Noise.Math.Random.Generators\">Random.Generators</a>
</p>
<h4>Note</h4>
<p>This function is impure!</p>
</html>"));
    end impureRandomInteger;

    function initializeImpureRandom
      "Initializes the internal state of the impure random number generator"
      input Integer seed
        "The input seed to initialize the impure random number generator";
      output Integer id
        "Identification number to be passed as input to function impureRandom, in order that sorting is correct";
    algorithm
      id :=seed*3;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
id = <b>initializeImpureRandom</b>(seed);
</pre></blockquote>

<h4>Description</h4>

<p>
Generates a hidden initial state vector for the
<a href=\"modelica://Modelica_Noise.Math.Random.Generators.Xorshift1024star\">Xorshift1024star</a>
random number generator (= xorshift1024* algorithm), from Integer input argument seed. Argument seed
can be given any value (including zero or negative number). The function returns the
dummy Integer number id. This number needs to be passed as input to function
<a href=\"modelica://Modelica_Noise.Math.Random.Utilities.impureRandom\">impureRandom</a>,
in order that the sorting order is correct (so that impureRandom is always called
after initializeImpureRandom). The function stores a reasonable initial state vector
in a C-static memory by using the
<a href=\"modelica://Modelica_Noise.Math.Random.Generators.Xorshift64star\">Xorshift64start</a>
random number generator to fill the internal state vector with 64 bit random numbers.
</p>

<h4>Example</h4>
<blockquote><pre>
  <b>parameter</b> Integer seed;
  Real r;
  <b>function</b> random = impureRandom (<b>final id=id);
<b>protected </b>
  Integer id;
<b>equation</b>
  // Initialize the random number generator
  <b>when</b> initial() <b>then</b>
    id = initializeImpureRandom(seed);
  <b>end when</b>;

  // Use the random number generator
  <b>when</b> sample(0,0.001) <b>then</b>
     r = random();
  <b>end when</b>;
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica_Noise.Math.Random.Utilities.impureRandom\">Utilities.impureRandom</a>,
<a href=\"modelica://Modelica_Noise.Math.Random.Generators\">Random.Generators</a>
</p>
</html>",     revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>"));
    end initializeImpureRandom;

    function automaticGlobalSeed
      "Creates an automatic integer seed from the current time and process id (= impure function)"
      output Integer seed "Automatically generated seed";
    algorithm
      seed :=3893456;

     annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
seed = Utilities.<b>automaticGlobalSeed</b>();
</pre></blockquote>

<h4>Description</h4>
<p>Returns an automatically computed seed (Integer) from:</p>
<ol>
<li> The current localtime by computing the number of milli-seconds up to the current hour</li>
<li> The process id (added to the first part by multiplying it with the prime number 6007).</li>
</ol>
<p>Check that worst case combination can be included in an Integer:</p>
<blockquote>
<p>1000*60*60 = 3.6e6 &LT; 2^31 = 2147483648 (2.1e9)</p>
</blockquote>
<p>
Everything is added to 1, in order to guard against the very unlikely case that the sum is zero.
</p>

<p>
Note, this is an impure function that returns always a different value, when it is newly called.
This function should be only called once during initialization.
</p>

<h4>Example</h4>
<blockquote><pre>
  <b>parameter</b> Boolean useAutomaticSeed = false;
  <b>parameter</b> Integer fixedSeed = 67867967;
  <b>final parameter</b> Integer seed = <b>if</b> useAutomaticSeed <b>then</b>
                                    Random.Utilities.automaticGlobalSeed()
                                 <b>else</b> fixedSeed;
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica_Noise.Math.Random.Utilities.automaticLocalSeed\">automaticLocalSeed</a>.
</p>
<h4>Note</h4>
<p>This function is impure!</p>
</html>",     revisions="<html>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> June 22, 2015 </td>
    <td valign=\"top\">

<table border=0>
<tr><td valign=\"top\">
         <img src=\"modelica://Modelica_Noise/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</p>
</html>"));
    end automaticGlobalSeed;

    function impureRandom
      "Impure random number generator (with hidden state vector)"
      input Integer id
        "Identification number from initializeImpureRandom(..) function (is needed for correct sorting)";
      output Real y
        "A random number with a uniform distribution on the interval (0,1]";
    algorithm
      y :=id/(id + 1);
    end impureRandom;
  end Utilities;

  package Generator

    function initialState
      input Integer localSeed
        "The local seed to be used for generating initial states";
      input Integer globalSeed
        "The global seed to be combined with the local seed";
      output Integer[4] state "The generated initial states";
    algorithm
      state[1] :=localSeed;
      state[2] :=globalSeed;
      state[3] :=localSeed;
      state[4] :=globalSeed;
    end initialState;

    function random
          input Integer[4] stateIn
        "The internal states for the random number generator";
        output Real result
        "A random number with a uniform distribution on the interval (0,1]";
        output Integer[4] stateOut
        "The new internal states of the random number generator";
    algorithm
      result :=stateIn[1] + stateIn[2] + stateIn[3] + stateIn[4];
      stateOut[1] :=stateIn[2]*stateIn[1];
      stateOut[2] :=stateIn[3]*stateIn[2];
      stateOut[3] :=stateIn[4]*stateIn[3];
      stateOut[4] :=stateIn[1]*stateIn[4];
    end random;
  end Generator;

  annotation (uses(Modelica(version="3.2.1")));
end TestNoise;
