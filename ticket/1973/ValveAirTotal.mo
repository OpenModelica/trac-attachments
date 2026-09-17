within ;
package Modelica "Modelica Standard Library (Version 3.2)"
extends Modelica.Icons.Package;

  package Blocks
    "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

    package Continuous
      "Library of continuous control blocks with internal states"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.Package;

      block Filter
        "Continuous low pass, high pass, band pass or band stop IIR-filter of type CriticalDamping, Bessel, Butterworth or ChebyshevI"
        import Modelica.Blocks.Continuous.Internal;

        extends Modelica.Blocks.Interfaces.SISO;

        parameter Modelica.Blocks.Types.AnalogFilter analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping
          "Analog filter characteristics (CriticalDamping/Bessel/Butterworth/ChebyshevI)";
        parameter Modelica.Blocks.Types.FilterType filterType=Modelica.Blocks.Types.FilterType.LowPass
          "Type of filter (LowPass/HighPass/BandPass/BandStop)";
        parameter Integer order(min=1) = 2 "Order of filter";
        parameter Modelica.SIunits.Frequency f_cut "Cut-off frequency";
        parameter Real gain=1.0
          "Gain (= amplitude of frequency response at zero frequency)";
        parameter Real A_ripple(unit="dB") = 0.5
          "Pass band ripple for Chebyshev filter (otherwise not used); > 0 required"
          annotation(Dialog(enable=analogFilter==Modelica.Blocks.Types.AnalogFilter.ChebyshevI));
        parameter Modelica.SIunits.Frequency f_min=0
          "Band of band pass/stop filter is f_min (A=-3db*gain) .. f_cut (A=-3db*gain)"
          annotation(Dialog(enable=filterType == Modelica.Blocks.Types.FilterType.BandPass or
                                   filterType == Modelica.Blocks.Types.FilterType.BandStop));
        parameter Boolean normalized=true
          "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";
        parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.SteadyState
          "Type of initialization (no init/steady state/initial state/initial output)"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        final parameter Integer nx = if filterType == Modelica.Blocks.Types.FilterType.LowPass or
                                        filterType == Modelica.Blocks.Types.FilterType.HighPass then
                                        order else 2*order;
        parameter Real x_start[nx] = zeros(nx)
          "Initial or guess values of states"
          annotation(Dialog(tab="Advanced"));
        parameter Real y_start = 0 "Initial value of output"
          annotation(Dialog(tab="Advanced"));
        parameter Real u_nominal = 1.0
          "Nominal value of input (used for scaling the states)"
        annotation(Dialog(tab="Advanced"));
        Modelica.Blocks.Interfaces.RealOutput x[nx] "Filter states";

      protected
        parameter Integer ncr = if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                                   order else mod(order,2);
        parameter Integer nc0 = if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                                   0 else integer(order/2);
        parameter Integer na = if filterType == Modelica.Blocks.Types.FilterType.BandPass or
                                  filterType == Modelica.Blocks.Types.FilterType.BandStop then order else
                               if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                                  0 else integer(order/2);
        parameter Integer nr = if filterType == Modelica.Blocks.Types.FilterType.BandPass or
                                  filterType == Modelica.Blocks.Types.FilterType.BandStop then 0 else
                               if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
                                  order else mod(order,2);

        // Coefficients of prototype base filter (low pass filter with w_cut = 1 rad/s)
        parameter Real cr[ncr](each fixed=false);
        parameter Real c0[nc0](each fixed=false);
        parameter Real c1[nc0](each fixed=false);

        // Coefficients for differential equations.
        parameter Real r[nr](each fixed=false);
        parameter Real a[na](each fixed=false);
        parameter Real b[na](each fixed=false);
        parameter Real ku[na](each fixed=false);
        parameter Real k1[if filterType == Modelica.Blocks.Types.FilterType.LowPass then 0 else na](
                       each fixed = false);
        parameter Real k2[if filterType == Modelica.Blocks.Types.FilterType.LowPass then 0 else na](
                       each fixed = false);

        // Auxiliary variables
        Real uu[na+nr+1];

      initial equation
         if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
            cr = Internal.Filter.base.CriticalDamping(order, normalized);
         elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.Bessel then
            (cr,c0,c1) = Internal.Filter.base.Bessel(order, normalized);
         elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.Butterworth then
            (cr,c0,c1) = Internal.Filter.base.Butterworth(order, normalized);
         elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.ChebyshevI then
            (cr,c0,c1) = Internal.Filter.base.ChebyshevI(order, A_ripple, normalized);
         end if;

         if filterType == Modelica.Blocks.Types.FilterType.LowPass then
            (r,a,b,ku) = Internal.Filter.roots.lowPass(cr,c0,c1,f_cut);
         elseif filterType == Modelica.Blocks.Types.FilterType.HighPass then
            (r,a,b,ku,k1,k2) = Internal.Filter.roots.highPass(cr,c0,c1,f_cut);
         elseif filterType == Modelica.Blocks.Types.FilterType.BandPass then
            (a,b,ku,k1,k2) = Internal.Filter.roots.bandPass(cr,c0,c1,f_min,f_cut);
         elseif filterType == Modelica.Blocks.Types.FilterType.BandStop then
            (a,b,ku,k1,k2) = Internal.Filter.roots.bandStop(cr,c0,c1,f_min,f_cut);
         end if;

         if init == Modelica.Blocks.Types.Init.InitialState then
            x = x_start;
         elseif init == Modelica.Blocks.Types.Init.SteadyState then
            der(x) = zeros(nx);
         elseif init == Modelica.Blocks.Types.Init.InitialOutput then
            y = y_start;
            if nx > 1 then
               der(x[1:nx-1]) = zeros(nx-1);
            end if;
         end if;

      equation
         assert(u_nominal > 0, "u_nominal > 0 required");
         assert(filterType == Modelica.Blocks.Types.FilterType.LowPass or
                filterType == Modelica.Blocks.Types.FilterType.HighPass or
                f_min > 0, "f_min > 0 required for band pass and band stop filter");
         assert(A_ripple > 0, "A_ripple > 0 required");
         assert(f_cut > 0, "f_cut > 0  required");

         /* All filters have the same basic differential equations:
        Real poles:
           der(x) = r*x - r*u
        Complex conjugate poles:
           der(x1) = a*x1 - b*x2 + ku*u;
           der(x2) = b*x1 + a*x2;
   */
         uu[1] = u/u_nominal;
         for i in 1:nr loop
            der(x[i]) = r[i]*(x[i] - uu[i]);
         end for;
         for i in 1:na loop
            der(x[nr+2*i-1]) = a[i]*x[nr+2*i-1] - b[i]*x[nr+2*i] + ku[i]*uu[nr+i];
            der(x[nr+2*i])   = b[i]*x[nr+2*i-1] + a[i]*x[nr+2*i];
         end for;

         // The output equation is different for the different filter types
         if filterType == Modelica.Blocks.Types.FilterType.LowPass then
            /* Low pass filter
           Real poles             :  y = x
           Complex conjugate poles:  y = x2
      */
            for i in 1:nr loop
               uu[i+1] = x[i];
            end for;
            for i in 1:na loop
               uu[nr+i+1] = x[nr+2*i];
            end for;

         elseif filterType == Modelica.Blocks.Types.FilterType.HighPass then
            /* High pass filter
           Real poles             :  y = -x + u;
           Complex conjugate poles:  y = k1*x1 + k2*x2 + u;
      */
            for i in 1:nr loop
               uu[i+1] = -x[i] + uu[i];
            end for;
            for i in 1:na loop
               uu[nr+i+1] = k1[i]*x[nr+2*i-1] + k2[i]*x[nr+2*i] + uu[nr+i];
            end for;

         elseif filterType == Modelica.Blocks.Types.FilterType.BandPass then
            /* Band pass filter
           Complex conjugate poles:  y = k1*x1 + k2*x2;
      */
            for i in 1:na loop
               uu[nr+i+1] = k1[i]*x[nr+2*i-1] + k2[i]*x[nr+2*i];
            end for;

         elseif filterType == Modelica.Blocks.Types.FilterType.BandStop then
            /* Band pass filter
           Complex conjugate poles:  y = k1*x1 + k2*x2 + u;
      */
            for i in 1:na loop
               uu[nr+i+1] = k1[i]*x[nr+2*i-1] + k2[i]*x[nr+2*i] + uu[nr+i];
            end for;

         else
            assert(false, "filterType (= " + String(filterType) + ") is unknown");
            uu = zeros(na+nr+1);
         end if;

         y = (gain*u_nominal)*uu[nr+na+1];

        annotation (
          Window(
            x=0.27,
            y=0.1,
            width=0.57,
            height=0.75),
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Line(points={{-80,80},{-80,-88}}, color={192,192,192}),
              Polygon(
                points={{-80,92},{-88,70},{-72,70},{-80,90},{-80,92}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-78},{82,-78}}, color={192,192,192}),
              Polygon(
                points={{90,-78},{68,-70},{68,-86},{90,-78}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-66,90},{88,52}},
                lineColor={192,192,192},
                textString="%order"),
              Text(
                extent={{-138,-110},{162,-140}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                textString="f_cut=%f_cut"),
              Line(points={{22,10},{14,18},{6,22},{-12,28},{-80,28}}, color={0,0,127}),
              Rectangle(
                extent={{-80,-78},{22,10}},
                lineColor={160,160,164},
                fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
              Line(points={{22,10},{30,-2},{36,-20},{40,-32},{44,-58},{46,-78}})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
          Documentation(info="<html>

<p>
This blocks models various types of filters:
</p>

<blockquote>
<b>low pass, high pass, band pass, and band stop filters</b>
</blockquote>

<p>
using various filter characteristics:
</p>

<blockquote>
<b>CriticalDamping, Bessel, Butterworth, Chebyshev Type I filters</b>
</blockquote>

<p>
By default, a filter block is initialized in <b>steady-state</b>, in order to
avoid unwanted osciallations at the beginning. In special cases, it might be
useful to select one of the other initialization options under tab
\"Advanced\".
</p>

<p>
Typical frequency responses for the 4 supported low pass filter types
are shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/LowPassOrder4Filters.png\">
</blockquote>

<p>
The step responses of the same low pass filters are shown in the next figure,
starting from a steady state initial filter with initial input = 0.2:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/LowPassOrder4FiltersStepResponse.png\">
</blockquote>

<p>
Obviously, the frequency responses give a somewhat wrong impression
of the filter characteristics: Although Butterworth and Chebyshev
filters have a significantly steeper magnitude as the
CriticalDamping and Bessel filters, the step responses of
the latter ones are much better. This means for example, that
a CriticalDamping or a Bessel filter should be selected,
if a filter is mainly used to make a non-linear inverse model
realizable.
</p>

<p>
Typical frequency responses for the 4 supported high pass filter types
are shown in the next figure:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/HighPassOrder4Filters.png\">
</blockquote>

<p>
The corresponding step responses of these high pass filters are
shown in the next figure:
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/HighPassOrder4FiltersStepResponse.png\">
</blockquote>

<p>
All filters are available in <b>normalized</b> (default) and non-normalized form.
In the normalized form, the amplitude of the filter transfer function
at the cut-off frequency f_cut is -3 dB (= 10^(-3/20) = 0.70794..).
Note, when comparing the filters of this function with other software systems,
the setting of \"normalized\" has to be selected appropriately. For example, the signal processing
toolbox of Matlab provides the filters in non-normalized form and
therefore a comparision makes only sense, if normalized = <b>false</b>
is set. A normalized filter is usually better suited for applications,
since filters of different orders are \"comparable\",
whereas non-normalized filters usually require to adapt the
cut-off frequency, when the order of the filter is changed.
See a comparision of \"normalized\" and \"non-normalized\" filters at hand of
CriticalDamping filters of order 1,2,3:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/CriticalDampingNormalized.png\">
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/CriticalDampingNonNormalized.png\">
</p>

<h4>Implementation</h4>

<p>
The filters are implemented in the following, reliable way:
</p>

<ol>
<li> A prototype low pass filter with a cut-off angular frequency of 1 rad/s is constructed
     from the desired analogFilter and the desired normalization.</li>

<li> This prototype low pass filter is transformed to the desired filterType and the
     desired cut-off frequency f_cut using a transformation on the Laplace variable \"s\".</li>

<li> The resulting first and second order transfer functions are implemented in
     state space form, using the \"eigen value\" representation of a transfer function:
     <pre>

  // second order block with eigen values: a +/- jb
  <b>der</b>(x1) = a*x1 - b*x2 + (a^2 + b^2)/b*u;
  <b>der</b>(x2) = b*x1 + a*x2;
       y  = x2;
     </pre>
     The dc-gain from the input to the output of this block is one and the selected
     states are in the order of the input (if \"u\" is in the order of \"one\", then the
     states are also in the order of \"one\"). In the \"Advanced\" tab, a \"nominal\" value for
     the input \"u\" can be given. If appropriately selected, the states are in the order of \"one\" and
     then step-size control is always appropriate.</li>
</ol>

<h4>References</h4>

<dl>
<dt>Tietze U., and Schenk C. (2002):</dt>
<dd> <b>Halbleiter-Schaltungstechnik</b>.
     Springer Verlag, 12. Auflage, pp. 815-852.</dd>
</dl>

</html>
",     revisions="<html>
<dl>
  <dt><b>Main Author:</b></dt>
  <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>,
      DLR Oberpfaffenhofen.</dd>
  </dt>
</dl>

<h4>Acknowledgement</h4>

<p>
The development of this block was partially funded by BMBF within the
     <a href=\"http://www.eurosyslib.com/\">ITEA2 EUROSYSLIB</a>
      project.
</p>

</html>"));
      end Filter;

      package Internal
        "Internal utility functions and blocks that should not be directly utilized by the user"
          extends Modelica.Icons.Package;

        package Filter
          "Internal utility functions for filters that should not be directly used"
            extends Modelica.Icons.Package;

          package base
            "Prototype low pass filters with cut-off frequency of 1 rad/s (other filters are derived by transformation from these base filters)"
              extends Modelica.Icons.Package;

          function CriticalDamping
              "Return base filter coefficients of CriticalDamping filter (= low pass filter with w_cut = 1 rad/s)"

            input Integer order(min=1) "Order of filter";
            input Boolean normalized=true
                "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

            output Real cr[order] "Coefficients of real poles";
            protected
            Real alpha=1.0 "Frequency correction factor";
            Real alpha2 "= alpha*alpha";
            Real den1[order]
                "[p] coefficients of denominator first order polynomials (a*p + 1)";
            Real den2[0,2]
                "[p^2, p] coefficients of denominator second order polynomials (b*p^2 + a*p + 1)";
            Real c0[0] "Coefficients of s^0 term if conjugate complex pole";
            Real c1[0] "Coefficients of s^1 term if conjugate complex pole";
          algorithm
            if normalized then
               // alpha := sqrt(2^(1/order) - 1);
               alpha := sqrt(10^(3/10/order)-1);
            else
               alpha := 1.0;
            end if;

            for i in 1:order loop
               den1[i] := alpha;
            end for;

            // Determine polynomials with highest power of s equal to one
              (cr,c0,c1) :=
                Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
                den1, den2);

            annotation (Documentation(info="<html>

</html> "));
          end CriticalDamping;

          function Bessel
              "Return base filter coefficients of Bessel filter (= low pass filter with w_cut = 1 rad/s)"

            input Integer order(min=1) "Order of filter";
            input Boolean normalized=true
                "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

            output Real cr[mod(order, 2)] "Coefficient of real pole";
            output Real c0[integer(order/2)]
                "Coefficients of s^0 term if conjugate complex pole";
            output Real c1[integer(order/2)]
                "Coefficients of s^1 term if conjugate complex pole";
            protected
            Integer n_den2=size(c0, 1);
            Real alpha=1.0 "Frequency correction factor";
            Real alpha2 "= alpha*alpha";
            Real den1[size(cr,1)]
                "[p] coefficients of denominator first order polynomials (a*p + 1)";
            Real den2[n_den2,2]
                "[p^2, p] coefficients of denominator second order polynomials (b*p^2 + a*p + 1)";
          algorithm
              (den1,den2,alpha) :=
                Modelica.Blocks.Continuous.Internal.Filter.Utilities.BesselBaseCoefficients(
                order);
            if not normalized then
               alpha2 := alpha*alpha;
               for i in 1:n_den2 loop
                 den2[i, 1] := den2[i, 1]*alpha2;
                 den2[i, 2] := den2[i, 2]*alpha;
               end for;
               if size(cr,1) == 1 then
                 den1[1] := den1[1]*alpha;
               end if;
               end if;

            // Determine polynomials with highest power of s equal to one
              (cr,c0,c1) :=
                Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
                den1, den2);

            annotation (Documentation(info="<html>

</html> "));
          end Bessel;

          function Butterworth
              "Return base filter coefficients of Butterwort filter (= low pass filter with w_cut = 1 rad/s)"

            input Integer order(min=1) "Order of filter";
            input Boolean normalized=true
                "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

            output Real cr[mod(order, 2)] "Coefficient of real pole";
            output Real c0[integer(order/2)]
                "Coefficients of s^0 term if conjugate complex pole";
            output Real c1[integer(order/2)]
                "Coefficients of s^1 term if conjugate complex pole";
            protected
            Integer n_den2=size(c0, 1);
            Real alpha=1.0 "Frequency correction factor";
            Real alpha2 "= alpha*alpha";
            Real den1[size(cr,1)]
                "[p] coefficients of denominator first order polynomials (a*p + 1)";
            Real den2[n_den2,2]
                "[p^2, p] coefficients of denominator second order polynomials (b*p^2 + a*p + 1)";
            constant Real pi=Modelica.Constants.pi;
          algorithm
            for i in 1:n_den2 loop
              den2[i, 1] := 1.0;
              den2[i, 2] := -2*Modelica.Math.cos(pi*(0.5 + (i - 0.5)/order));
            end for;
            if size(cr,1) == 1 then
              den1[1] := 1.0;
            end if;

            /* Transformation of filter transfer function with "new(p) = alpha*p"
     in order that the filter transfer function has an amplitude of
     -3 db at the cutoff frequency
  */
            /*
    if normalized then
      alpha := Internal.normalizationFactor(den1, den2);
      alpha2 := alpha*alpha;
      for i in 1:n_den2 loop
        den2[i, 1] := den2[i, 1]*alpha2;
        den2[i, 2] := den2[i, 2]*alpha;
      end for;
      if size(cr,1) == 1 then
        den1[1] := den1[1]*alpha;
      end if;
    end if;
  */

            // Determine polynomials with highest power of s equal to one
              (cr,c0,c1) :=
                Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
                den1, den2);

            annotation (Documentation(info="<html>

</html> "));
          end Butterworth;

          function ChebyshevI
              "Return base filter coefficients of Chebyshev I filter (= low pass filter with w_cut = 1 rad/s)"
              import Modelica.Math.*;

            input Integer order(min=1) "Order of filter";
            input Real A_ripple = 0.5 "Pass band ripple in [dB]";
            input Boolean normalized=true
                "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

            output Real cr[mod(order, 2)] "Coefficient of real pole";
            output Real c0[integer(order/2)]
                "Coefficients of s^0 term if conjugate complex pole";
            output Real c1[integer(order/2)]
                "Coefficients of s^1 term if conjugate complex pole";
            protected
            Real epsilon;
            Real fac;
            Integer n_den2=size(c0, 1);
            Real alpha=1.0 "Frequency correction factor";
            Real alpha2 "= alpha*alpha";
            Real den1[size(cr,1)]
                "[p] coefficients of denominator first order polynomials (a*p + 1)";
            Real den2[n_den2,2]
                "[p^2, p] coefficients of denominator second order polynomials (b*p^2 + a*p + 1)";
            constant Real pi=Modelica.Constants.pi;
          algorithm
              epsilon := sqrt(10^(A_ripple/10) - 1);
              fac := asinh(1/epsilon)/order;

              if size(cr,1) == 0 then
                 for i in 1:n_den2 loop
                    den2[i,1] :=1/(cosh(fac)^2 - cos((2*i - 1)*pi/(2*order))^2);
                    den2[i,2] :=2*den2[i, 1]*sinh(fac)*cos((2*i - 1)*pi/(2*order));
                 end for;
              else
                 den1[1] := 1/sinh(fac);
                 for i in 1:n_den2 loop
                    den2[i,1] :=1/(cosh(fac)^2 - cos(i*pi/order)^2);
                    den2[i,2] :=2*den2[i, 1]*sinh(fac)*cos(i*pi/order);
                 end for;
              end if;

              /* Transformation of filter transfer function with "new(p) = alpha*p"
       in order that the filter transfer function has an amplitude of
       -3 db at the cutoff frequency
    */
              if normalized then
                alpha :=
                  Modelica.Blocks.Continuous.Internal.Filter.Utilities.normalizationFactor(
                  den1, den2);
                alpha2 := alpha*alpha;
                for i in 1:n_den2 loop
                  den2[i, 1] := den2[i, 1]*alpha2;
                  den2[i, 2] := den2[i, 2]*alpha;
                end for;
                if size(cr,1) == 1 then
                  den1[1] := den1[1]*alpha;
                end if;
              end if;

            // Determine polynomials with highest power of s equal to one
              (cr,c0,c1) :=
                Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
                den1, den2);

            annotation (Documentation(info="<html>

</html> "));
          end ChebyshevI;
          end base;

          package coefficients "Filter coefficients"
              extends Modelica.Icons.Package;

          function lowPass
              "Return low pass filter coefficients at given cut-off frequency"

            input Real cr_in[:] "Coefficients of real poles";
            input Real c0_in[:]
                "Coefficients of s^0 term if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";
            input Modelica.SIunits.Frequency f_cut "Cut-off frequency";

            output Real cr[size(cr_in,1)] "Coefficient of real pole";
            output Real c0[size(c0_in,1)]
                "Coefficients of s^0 term if conjugate complex pole";
            output Real c1[size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";

            protected
            constant Real pi=Modelica.Constants.pi;
            Modelica.SIunits.AngularVelocity w_cut=2*pi*f_cut
                "Cut-off angular frequency";
            Real w_cut2=w_cut*w_cut;

          algorithm
            assert(f_cut > 0, "Cut-off frequency f_cut must be positive");

            /* Change filter coefficients according to transformation new(s) = s/w_cut
     s + cr           -> (s/w) + cr              = (s + w*cr)/w
     s^2 + c1*s + c0  -> (s/w)^2 + c1*(s/w) + c0 = (s^2 + (c1*w)*s + (c0*w^2))/w^2
  */
            cr := w_cut*cr_in;
            c1 := w_cut*c1_in;
            c0 := w_cut2*c0_in;

            annotation (Documentation(info="<html>

</html> "));
          end lowPass;

          function highPass
              "Return high pass filter coefficients at given cut-off frequency"

            input Real cr_in[:] "Coefficients of real poles";
            input Real c0_in[:]
                "Coefficients of s^0 term if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";
            input Modelica.SIunits.Frequency f_cut "Cut-off frequency";

            output Real cr[size(cr_in,1)] "Coefficient of real pole";
            output Real c0[size(c0_in,1)]
                "Coefficients of s^0 term if conjugate complex pole";
            output Real c1[size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";

            protected
            constant Real pi=Modelica.Constants.pi;
            Modelica.SIunits.AngularVelocity w_cut=2*pi*f_cut
                "Cut-off angular frequency";
            Real w_cut2=w_cut*w_cut;

          algorithm
            assert(f_cut > 0, "Cut-off frequency f_cut must be positive");

            /* Change filter coefficients according to transformation: new(s) = 1/s
        1/(s + cr)          -> 1/(1/s + cr)                = (1/cr)*s / (s + (1/cr))
        1/(s^2 + c1*s + c0) -> 1/((1/s)^2 + c1*(1/s) + c0) = (1/c0)*s^2 / (s^2 + (c1/c0)*s + 1/c0)

     Check whether transformed roots are also conjugate complex:
        c0 - c1^2/4 > 0  -> (1/c0) - (c1/c0)^2 / 4
                            = (c0 - c1^2/4) / c0^2 > 0
        It is therefore guaranteed that the roots remain conjugate complex

     Change filter coefficients according to transformation new(s) = s/w_cut
        s + 1/cr                -> (s/w) + 1/cr                   = (s + w/cr)/w
        s^2 + (c1/c0)*s + 1/c0  -> (s/w)^2 + (c1/c0)*(s/w) + 1/c0 = (s^2 + (w*c1/c0)*s + (w^2/c0))/w^2
  */
            for i in 1:size(cr_in,1) loop
               cr[i] := w_cut/cr_in[i];
            end for;

            for i in 1:size(c0_in,1) loop
               c0[i] := w_cut2/c0_in[i];
               c1[i] := w_cut*c1_in[i]/c0_in[i];
            end for;

            annotation (Documentation(info="<html>

</html> "));
          end highPass;

          function bandPass
              "Return band pass filter coefficients at given cut-off frequency"

            input Real cr_in[:] "Coefficients of real poles";
            input Real c0_in[:]
                "Coefficients of s^0 term if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";
            input Modelica.SIunits.Frequency f_min
                "Band of band pass filter is f_min (A=-3db) .. f_max (A=-3db)";
            input Modelica.SIunits.Frequency f_max "Upper band frequency";

            output Real cr[0] "Coefficient of real pole";
            output Real c0[size(cr_in,1) + 2*size(c0_in,1)]
                "Coefficients of s^0 term if conjugate complex pole";
            output Real c1[size(cr_in,1) + 2*size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";
            output Real cn "Numerator coefficient of the PT2 terms";
            protected
            constant Real pi=Modelica.Constants.pi;
            Modelica.SIunits.Frequency f0 = sqrt(f_min*f_max);
            Modelica.SIunits.AngularVelocity w_cut=2*pi*f0
                "Cut-off angular frequency";
            Modelica.SIunits.AngularVelocity w_band = (f_max - f_min) / f0;
            Real w_cut2=w_cut*w_cut;
            Real c;
            Real alpha;
            Integer j;
          algorithm
            assert(f_min > 0 and f_min < f_max, "Band frequencies f_min and f_max are wrong");

              /* The band pass filter is derived from the low pass filter by
       the transformation new(s) = (s + 1/s)/w   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )

       1/(s + cr)         -> 1/(s/w + 1/s/w) + cr)
                             = w*s / (s^2 + cr*w*s + 1)

       1/(s^2 + c1*s + c0) -> 1/( (s+1/s)^2/w^2 + c1*(s + 1/s)/w + c0 )
                              = 1 / ( s^2 + 1/s^2 + 2)/w^2 + (s + 1/s)*c1/w + c0 )
                              = w^2*s^2 / (s^4 + 2*s^2 + 1 + (s^3 + s)*c1*w + c0*w^2*s^2)
                              = w^2*s^2 / (s^4 + c1*w*s^3 + (2+c0*w^2)*s^2 + c1*w*s + 1)

                              Assume the following description with PT2:
                              = w^2*s^2 /( (s^2 + s*(c/alpha) + 1/alpha^2)*
                                           (s^2 + s*(c*alpha) + alpha^2) )
                              = w^2*s^2 / ( s^4 + c*(alpha + 1/alpha)*s^3
                                                + (alpha^2 + 1/alpha^2 + c^2)*s^2
                                                + c*(alpha + 1/alpha)*s + 1 )

                              and therefore:
                                c*(alpha + 1/alpha) = c1*w       -> c = c1*w / (alpha + 1/alpha)
                                                                      = c1*w*alpha/(1+alpha^2)
                                alpha^2 + 1/alpha^2 + c^2 = 2+c0*w^2 -> equation to determine alpha
                                alpha^4 + 1 + c1^2*w^2*alpha^4/(1+alpha^2)^2 = (2+c0*w^2)*alpha^2
                                or z = alpha^2
                                z^2 + c^1^2*w^2*z^2/(1+z)^2 - (2+c0*w^2)*z + 1 = 0

     Check whether roots remain conjugate complex
        c0 - (c1/2)^2 > 0:    1/alpha^2 - (c/alpha)^2/4
                              = 1/alpha^2*(1 - c^2/4)    -> not possible to figure this out

     Afterwards, change filter coefficients according to transformation new(s) = s/w_cut
        w_band*s/(s^2 + c1*s + c0)  -> w_band*(s/w)/((s/w)^2 + c1*(s/w) + c0 =
                                       (w_band/w)*s/(s^2 + (c1*w)*s + (c0*w^2))/w^2) =
                                       (w_band*w)*s/(s^2 + (c1*w)*s + (c0*w^2))
    */
              for i in 1:size(cr_in,1) loop
                 c1[i] := w_cut*cr_in[i]*w_band;
                 c0[i] := w_cut2;
              end for;

              for i in 1:size(c1_in,1) loop
                alpha :=
                  Modelica.Blocks.Continuous.Internal.Filter.Utilities.bandPassAlpha(
                        c1_in[i],
                        c0_in[i],
                        w_band);
                 c       := c1_in[i]*w_band / (alpha + 1/alpha);
                 j       := size(cr_in,1) + 2*i - 1;
                 c1[j]   := w_cut*c/alpha;
                 c1[j+1] := w_cut*c*alpha;
                 c0[j]   := w_cut2/alpha^2;
                 c0[j+1] := w_cut2*alpha^2;
              end for;

              cn :=w_band*w_cut;

            annotation (Documentation(info="<html>

</html> "));
          end bandPass;

          function bandStop
              "Return band stop filter coefficients at given cut-off frequency"

            input Real cr_in[:] "Coefficients of real poles";
            input Real c0_in[:]
                "Coefficients of s^0 term if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";
            input Modelica.SIunits.Frequency f_min
                "Band of band stop filter is f_min (A=-3db) .. f_max (A=-3db)";
            input Modelica.SIunits.Frequency f_max "Upper band frequency";

            output Real cr[0] "Coefficient of real pole";
            output Real c0[size(cr_in,1) + 2*size(c0_in,1)]
                "Coefficients of s^0 term if conjugate complex pole";
            output Real c1[size(cr_in,1) + 2*size(c0_in,1)]
                "Coefficients of s^1 term if conjugate complex pole";
            protected
            constant Real pi=Modelica.Constants.pi;
            Modelica.SIunits.Frequency f0 = sqrt(f_min*f_max);
            Modelica.SIunits.AngularVelocity w_cut=2*pi*f0
                "Cut-off angular frequency";
            Modelica.SIunits.AngularVelocity w_band = (f_max - f_min) / f0;
            Real w_cut2=w_cut*w_cut;
            Real c;
            Real ww;
            Real alpha;
            Integer j;
          algorithm
            assert(f_min > 0 and f_min < f_max, "Band frequencies f_min and f_max are wrong");

              /* The band pass filter is derived from the low pass filter by
       the transformation new(s) = (s + 1/s)/w   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )

       1/(s + cr)         -> 1/(s/w + 1/s/w) + cr)
                             = w*s / (s^2 + cr*w*s + 1)

       1/(s^2 + c1*s + c0) -> 1/( (s+1/s)^2/w^2 + c1*(s + 1/s)/w + c0 )
                              = 1 / ( s^2 + 1/s^2 + 2)/w^2 + (s + 1/s)*c1/w + c0 )
                              = w^2*s^2 / (s^4 + 2*s^2 + 1 + (s^3 + s)*c1*w + c0*w^2*s^2)
                              = w^2*s^2 / (s^4 + c1*w*s^3 + (2+c0*w^2)*s^2 + c1*w*s + 1)

                              Assume the following description with PT2:
                              = w^2*s^2 /( (s^2 + s*(c/alpha) + 1/alpha^2)*
                                           (s^2 + s*(c*alpha) + alpha^2) )
                              = w^2*s^2 / ( s^4 + c*(alpha + 1/alpha)*s^3
                                                + (alpha^2 + 1/alpha^2 + c^2)*s^2
                                                + c*(alpha + 1/alpha)*s + 1 )

                              and therefore:
                                c*(alpha + 1/alpha) = c1*w       -> c = c1*w / (alpha + 1/alpha)
                                                                      = c1*w*alpha/(1+alpha^2)
                                alpha^2 + 1/alpha^2 + c^2 = 2+c0*w^2 -> equation to determine alpha
                                alpha^4 + 1 + c1^2*w^2*alpha^4/(1+alpha^2)^2 = (2+c0*w^2)*alpha^2
                                or z = alpha^2
                                z^2 + c^1^2*w^2*z^2/(1+z)^2 - (2+c0*w^2)*z + 1 = 0

       The band stop filter is derived from the low pass filter by
       the transformation new(s) = w/( (s + 1/s) )   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )

       cr/(s + cr)         -> 1/( w/(s + 1/s) ) + cr)
                              = (s^2 + 1) / (s^2 + (w/cr)*s + 1)

       c0/(s^2 + c1*s + c0) -> c0/( w^2/(s + 1/s)^2 + c1*w/(s + 1/s) + c0 )
                               = c0*(s^2 + 1)^2 / (s^4 + c1*w*s^3/c0 + (2+w^2/b)*s^2 + c1*w*s/c0 + 1)

                               Assume the following description with PT2:
                               = c0*(s^2 + 1)^2 / ( (s^2 + s*(c/alpha) + 1/alpha^2)*
                                                    (s^2 + s*(c*alpha) + alpha^2) )
                               = c0*(s^2 + 1)^2 / (  s^4 + c*(alpha + 1/alpha)*s^3
                                                         + (alpha^2 + 1/alpha^2 + c^2)*s^2
                                                         + c*(alpha + 1/alpha)*p + 1 )

                            and therefore:
                              c*(alpha + 1/alpha) = c1*w/b         -> c = c1*w/(c0*(alpha + 1/alpha))
                              alpha^2 + 1/alpha^2 + c^2 = 2+w^2/c0 -> equation to determine alpha
                              alpha^4 + 1 + (c1*w/c0*alpha^2)^2/(1+alpha^2)^2 = (2+w^2/c0)*alpha^2
                              or z = alpha^2
                              z^2 + (c1*w/c0*z)^2/(1+z)^2 - (2+w^2/c0)*z + 1 = 0

                            same as:  ww = w/c0
                              z^2 + (c1*ww*z)^2/(1+z)^2 - (2+c0*ww)*z + 1 = 0  -> same equation as for BandPass

     Afterwards, change filter coefficients according to transformation new(s) = s/w_cut
        c0*(s^2+1)(s^2 + c1*s + c0)  -> c0*((s/w)^2 + 1) / ((s/w)^2 + c1*(s/w) + c0 =
                                        c0/w^2*(s^2 + w^2) / (s^2 + (c1*w)*s + (c0*w^2))/w^2) =
                                        (s^2 + c0*w^2) / (s^2 + (c1*w)*s + (c0*w^2))
    */
              for i in 1:size(cr_in,1) loop
                 c1[i] := w_cut*w_band/cr_in[i];
                 c0[i] := w_cut2;
              end for;

              for i in 1:size(c1_in,1) loop
                 ww      := w_band/c0_in[i];
                alpha :=
                  Modelica.Blocks.Continuous.Internal.Filter.Utilities.bandPassAlpha(
                        c1_in[i],
                        c0_in[i],
                        ww);
                 c       := c1_in[i]*ww / (alpha + 1/alpha);
                 j       := size(cr_in,1) + 2*i - 1;
                 c1[j]   := w_cut*c/alpha;
                 c1[j+1] := w_cut*c*alpha;
                 c0[j]   := w_cut2/alpha^2;
                 c0[j+1] := w_cut2*alpha^2;
              end for;

            annotation (Documentation(info="<html>

</html> "));
          end bandStop;
          end coefficients;

          package roots
            "Filter roots and gain as needed for block implementations"
              extends Modelica.Icons.Package;

          function lowPass
              "Return low pass filter roots as needed for block for given cut-off frequency"

            input Real cr_in[:] "Coefficients of real poles of base filter";
            input Real c0_in[:]
                "Coefficients of s^0 term of base filter if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term of base filter if conjugate complex pole";
            input Modelica.SIunits.Frequency f_cut "Cut-off frequency";

            output Real r[size(cr_in,1)] "Real eigenvalues";
            output Real a[size(c0_in,1)]
                "Real parts of complex conjugate eigenvalues";
            output Real b[size(c0_in,1)]
                "Imaginary parts of complex conjugate eigenvalues";
            output Real ku[size(c0_in,1)] "Input gain";
            protected
            Real c0[size(c0_in,1)];
            Real c1[size(c0_in,1)];
            Real cr[size(cr_in,1)];
          algorithm
            // Get coefficients of low pass filter at f_cut
            (cr, c0, c1) :=coefficients.lowPass(cr_in, c0_in, c1_in, f_cut);

            // Transform coefficients in to root
            for i in 1:size(cr_in,1) loop
              r[i] :=-cr[i];
            end for;

            for i in 1:size(c0_in,1) loop
              a [i] :=-c1[i]/2;
              b [i] :=sqrt(c0[i] - a[i]*a[i]);
              ku[i] :=c0[i]/b[i];
            end for;

            annotation (Documentation(info="<html>

<p>
The goal is to implement the filter in the following form:
</p>

<pre>
  // real pole:
   der(x) = r*x - r*u
       y  = x

  // complex conjugate poles:
  der(x1) = a*x1 - b*x2 + ku*u;
  der(x2) = b*x1 + a*x2;
       y  = x2;

            ku = (a^2 + b^2)/b
</pre>
<p>
This representation has the following transfer function:
</p>
<pre>
// real pole:
    s*y = r*y - r*u
  or
    (s-r)*y = -r*u
  or
    y = -r/(s-r)*u

  comparing coefficients with
    y = cr/(s + cr)*u  ->  r = -cr      // r is the real eigenvalue

// complex conjugate poles
    s*x2 =  a*x2 + b*x1
    s*x1 = -b*x2 + a*x1 + ku*u
  or
    (s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
    (s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                                   ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
  or
    x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
    x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
       = b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
    y  = x2

  comparing coefficients with
    y = c0/(s^2 + c1*s + c0)*u  ->  a  = -c1/2
                                    b  = sqrt(c0 - a^2)
                                    ku = c0/b
                                       = (a^2 + b^2)/b

  comparing with eigenvalue representation:
    (s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
  shows that:
    a: real part of eigenvalue
    b: imaginary part of eigenvalue

  time -> infinity:
    y(s=0) = x2(s=0) = 1
             x1(s=0) = -ku*a/(a^2 + b^2)*u
                     = -(a/b)*u
</pre>

</html> "));
          end lowPass;

          function highPass
              "Return high pass filter roots as needed for block for given cut-off frequency"

            input Real cr_in[:] "Coefficients of real poles of base filter";
            input Real c0_in[:]
                "Coefficients of s^0 term of base filter if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term of base filter if conjugate complex pole";
            input Modelica.SIunits.Frequency f_cut "Cut-off frequency";

            output Real r[size(cr_in,1)] "Real eigenvalues";
            output Real a[size(c0_in,1)]
                "Real parts of complex conjugate eigenvalues";
            output Real b[size(c0_in,1)]
                "Imaginary parts of complex conjugate eigenvalues";
            output Real ku[size(c0_in,1)] "Gains of input terms";
            output Real k1[size(c0_in,1)] "Gains of y = k1*x1 + k2*x + u";
            output Real k2[size(c0_in,1)] "Gains of y = k1*x1 + k2*x + u";
            protected
            Real c0[size(c0_in,1)];
            Real c1[size(c0_in,1)];
            Real cr[size(cr_in,1)];
            Real ba2;
          algorithm
            // Get coefficients of high pass filter at f_cut
            (cr, c0, c1) :=coefficients.highPass(cr_in, c0_in, c1_in, f_cut);

            // Transform coefficients in to roots
            for i in 1:size(cr_in,1) loop
              r[i] :=-cr[i];
            end for;

            for i in 1:size(c0_in,1) loop
              a[i]  := -c1[i]/2;
              b[i]  := sqrt(c0[i] - a[i]*a[i]);
              ku[i] := c0[i]/b[i];
              k1[i] := 2*a[i]/ku[i];
              ba2   := (b[i]/a[i])^2;
              k2[i] := (1-ba2)/(1+ba2);
            end for;

            annotation (Documentation(info="<html>

<p>
The goal is to implement the filter in the following form:
</p>

<pre>
  // real pole:
   der(x) = r*x - r*u
       y  = -x + u

  // complex conjugate poles:
  der(x1) = a*x1 - b*x2 + ku*u;
  der(x2) = b*x1 + a*x2;
       y  = k1*x1 + k2*x2 + u;

            ku = (a^2 + b^2)/b
            k1 = 2*a/ku
            k2 = (a^2 - b^2) / (b*ku)
               = (a^2 - b^2) / (a^2 + b^2)
               = (1 - (b/a)^2) / (1 + (b/a)^2)

</pre>
<p>
This representation has the following transfer function:
</p>
<pre>
// real pole:
    s*x = r*x - r*u
  or
    (s-r)*x = -r*u   -> x = -r/(s-r)*u
  or
    y = r/(s-r)*u + (s-r)/(s-r)*u
      = (r+s-r)/(s-r)*u
      = s/(s-r)*u

  comparing coefficients with
    y = s/(s + cr)*u  ->  r = -cr      // r is the real eigenvalue

// complex conjugate poles
    s*x2 =  a*x2 + b*x1
    s*x1 = -b*x2 + a*x1 + ku*u
  or
    (s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
    (s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                                   ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
  or
    x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
    x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
       = b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
    y  = k1*x1 + k2*x2 + u
       = (k1*ku*(s-a) + k2*b*ku +  s^2 - 2*a*s + a^2 + b^2) /
         (s^2 - 2*a*s + a^2 + b^2)*u
       = (s^2 + (k1*ku - 2*a)*s + k2*b*ku - k1*ku*a + a^2 + b^2) /
         (s^2 - 2*a*s + a^2 + b^2)*u
       = (s^2 + (2*a-2*a)*s + a^2 - b^2 - 2*a^2 + a^2 + b^2) /
         (s^2 - 2*a*s + a^2 + b^2)*u
       = s^2 / (s^2 - 2*a*s + a^2 + b^2)*u

  comparing coefficients with
    y = s^2/(s^2 + c1*s + c0)*u  ->  a = -c1/2
                                     b = sqrt(c0 - a^2)

  comparing with eigenvalue representation:
    (s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
  shows that:
    a: real part of eigenvalue
    b: imaginary part of eigenvalue
</pre>

</html> "));
          end highPass;

          function bandPass
              "Return band pass filter roots as needed for block for given cut-off frequency"
            input Real cr_in[:] "Coefficients of real poles of base filter";
            input Real c0_in[:]
                "Coefficients of s^0 term of base filter if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term of base filter if conjugate complex pole";
            input Modelica.SIunits.Frequency f_min
                "Band of band pass filter is f_min (A=-3db) .. f_max (A=-3db)";
            input Modelica.SIunits.Frequency f_max "Upper band frequency";

            output Real a[size(cr_in,1) + 2*size(c0_in,1)]
                "Real parts of complex conjugate eigenvalues";
            output Real b[size(cr_in,1) + 2*size(c0_in,1)]
                "Imaginary parts of complex conjugate eigenvalues";
            output Real ku[size(cr_in,1) + 2*size(c0_in,1)]
                "Gains of input terms";
            output Real k1[size(cr_in,1) + 2*size(c0_in,1)]
                "Gains of y = k1*x1 + k2*x";
            output Real k2[size(cr_in,1) + 2*size(c0_in,1)]
                "Gains of y = k1*x1 + k2*x";
            protected
            Real cr[0];
            Real c0[size(a,1)];
            Real c1[size(a,1)];
            Real cn;
            Real bb;
          algorithm
            // Get coefficients of band pass filter at f_cut
            (cr, c0, c1, cn) :=coefficients.bandPass(cr_in, c0_in, c1_in, f_min, f_max);

            // Transform coefficients in to roots
            for i in 1:size(a,1) loop
              a[i]  := -c1[i]/2;
              bb    := c0[i] - a[i]*a[i];
              assert(bb >= 0, "\nNot possible to use band pass filter, since transformation results in\n"+
                              "system that does not have conjugate complex poles.\n" +
                              "Try to use another analog filter for the band pass.\n");
              b[i]  := sqrt(bb);
              ku[i] := c0[i]/b[i];
              k1[i] := cn/ku[i];
              k2[i] := cn*a[i]/(b[i]*ku[i]);
            end for;

            annotation (Documentation(info="<html>

<p>
The goal is to implement the filter in the following form:
</p>

<pre>
  // complex conjugate poles:
  der(x1) = a*x1 - b*x2 + ku*u;
  der(x2) = b*x1 + a*x2;
       y  = k1*x1 + k2*x2;

            ku = (a^2 + b^2)/b
            k1 = cn/ku
            k2 = cn*a/(b*ku)
</pre>
<p>
This representation has the following transfer function:
</p>
<pre>
// complex conjugate poles
    s*x2 =  a*x2 + b*x1
    s*x1 = -b*x2 + a*x1 + ku*u
  or
    (s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
    (s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                                   ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
  or
    x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
    x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
       = b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
    y  = k1*x1 + k2*x2
       = (k1*ku*(s-a) + k2*b*ku) / (s^2 - 2*a*s + a^2 + b^2)*u
       = (k1*ku*s + k2*b*ku - k1*ku*a) / (s^2 - 2*a*s + a^2 + b^2)*u
       = (cn*s + cn*a - cn*a) / (s^2 - 2*a*s + a^2 + b^2)*u
       = cn*s / (s^2 - 2*a*s + a^2 + b^2)*u

  comparing coefficients with
    y = cn*s / (s^2 + c1*s + c0)*u  ->  a = -c1/2
                                        b = sqrt(c0 - a^2)

  comparing with eigenvalue representation:
    (s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
  shows that:
    a: real part of eigenvalue
    b: imaginary part of eigenvalue
</pre>

</html> "));
          end bandPass;

          function bandStop
              "Return band stop filter roots as needed for block for given cut-off frequency"

            input Real cr_in[:] "Coefficients of real poles of base filter";
            input Real c0_in[:]
                "Coefficients of s^0 term of base filter if conjugate complex pole";
            input Real c1_in[size(c0_in,1)]
                "Coefficients of s^1 term of base filter if conjugate complex pole";
            input Modelica.SIunits.Frequency f_min
                "Band of band stop filter is f_min (A=-3db) .. f_max (A=-3db)";
            input Modelica.SIunits.Frequency f_max "Upper band frequency";

            output Real a[size(cr_in,1) + 2*size(c0_in,1)]
                "Real parts of complex conjugate eigenvalues";
            output Real b[size(cr_in,1) + 2*size(c0_in,1)]
                "Imaginary parts of complex conjugate eigenvalues";
            output Real ku[size(cr_in,1) + 2*size(c0_in,1)]
                "Gains of input terms";
            output Real k1[size(cr_in,1) + 2*size(c0_in,1)]
                "Gains of y = k1*x1 + k2*x";
            output Real k2[size(cr_in,1) + 2*size(c0_in,1)]
                "Gains of y = k1*x1 + k2*x";
            protected
            Real cr[0];
            Real c0[size(a,1)];
            Real c1[size(a,1)];
            Real cn;
            Real bb;
          algorithm
            // Get coefficients of band stop filter at f_cut
            (cr, c0, c1) :=coefficients.bandStop(cr_in, c0_in, c1_in, f_min, f_max);

            // Transform coefficients in to roots
            for i in 1:size(a,1) loop
              a[i]  := -c1[i]/2;
              bb    := c0[i] - a[i]*a[i];
              assert(bb >= 0, "\nNot possible to use band stop filter, since transformation results in\n"+
                              "system that does not have conjugate complex poles.\n" +
                              "Try to use another analog filter for the band stop filter.\n");
              b[i]  := sqrt(bb);
              ku[i] := c0[i]/b[i];
              k1[i] := 2*a[i]/ku[i];
              k2[i] := (c0[i] + a[i]^2 - b[i]^2)/(b[i]*ku[i]);
            end for;

            annotation (Documentation(info="<html>

<p>
The goal is to implement the filter in the following form:
</p>

<pre>
  // complex conjugate poles:
  der(x1) = a*x1 - b*x2 + ku*u;
  der(x2) = b*x1 + a*x2;
       y  = k1*x1 + k2*x2 + u;

            ku = (a^2 + b^2)/b
            k1 = 2*a/ku
            k2 = (c0 + a^2 - b^2)/(b*ku)
</pre>
<p>
This representation has the following transfer function:
</p>
<pre>
// complex conjugate poles
    s*x2 =  a*x2 + b*x1
    s*x1 = -b*x2 + a*x1 + ku*u
  or
    (s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
    (s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                                   ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
  or
    x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
    x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
       = b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
    y  = k1*x1 + k2*x2 + u
       = (k1*ku*(s-a) + k2*b*ku + s^2 - 2*a*s + a^2 + b^2) / (s^2 - 2*a*s + a^2 + b^2)*u
       = (s^2 + (k1*ku-2*a)*s + k2*b*ku - k1*ku*a + a^2 + b^2) / (s^2 - 2*a*s + a^2 + b^2)*u
       = (s^2 + c0 + a^2 - b^2 - 2*a^2 + a^2 + b^2) / (s^2 - 2*a*s + a^2 + b^2)*u
       = (s^2 + c0) / (s^2 - 2*a*s + a^2 + b^2)*u

  comparing coefficients with
    y = (s^2 + c0) / (s^2 + c1*s + c0)*u  ->  a = -c1/2
                                              b = sqrt(c0 - a^2)

  comparing with eigenvalue representation:
    (s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
  shows that:
    a: real part of eigenvalue
    b: imaginary part of eigenvalue
</pre>

</html> "));
          end bandStop;
          end roots;

          package Utilities "Utility functions for filter computations"
              extends Modelica.Icons.Package;

            function BesselBaseCoefficients
              "Return coefficients of normalized low pass Bessel filter (= gain at cut-off frequency 1 rad/s is decreased 3dB"

              import Modelica.Utilities.Streams;
              input Integer order "Order of filter in the range 1..41";
              output Real c1[mod(order, 2)]
                "[p] coefficients of Bessel denominator polynomials (a*p + 1)";
              output Real c2[integer(order/2),2]
                "[p^2, p] coefficients of Bessel denominator polynomials (b2*p^2 + b1*p + 1)";
              output Real alpha "Normalization factor";
            algorithm
              if order == 1 then
                alpha := 1.002377293007601;
                c1[1] := 0.9976283451109835;
              elseif order == 2 then
                alpha := 0.7356641785819585;
                c2[1, 1] := 0.6159132201783791;
                c2[1, 2] := 1.359315879600889;
              elseif order == 3 then
                alpha := 0.5704770156982642;
                c1[1] := 0.7548574865985343;
                c2[1, 1] := 0.4756958028827457;
                c2[1, 2] := 0.9980615136104388;
              elseif order == 4 then
                alpha := 0.4737978580281427;
                c2[1, 1] := 0.4873729247240677;
                c2[1, 2] := 1.337564170455762;
                c2[2, 1] := 0.3877724315741958;
                c2[2, 2] := 0.7730405590839861;
              elseif order == 5 then
                alpha := 0.4126226974763408;
                c1[1] := 0.6645723262620757;
                c2[1, 1] := 0.4115231900614016;
                c2[1, 2] := 1.138349926728708;
                c2[2, 1] := 0.3234938702877912;
                c2[2, 2] := 0.6205992985771313;
              elseif order == 6 then
                alpha := 0.3705098000736233;
                c2[1, 1] := 0.3874508649098960;
                c2[1, 2] := 1.219740879520741;
                c2[2, 1] := 0.3493298843155746;
                c2[2, 2] := 0.9670265529381365;
                c2[3, 1] := 0.2747419229514599;
                c2[3, 2] := 0.5122165075105700;
              elseif order == 7 then
                alpha := 0.3393452623586350;
                c1[1] := 0.5927147125821412;
                c2[1, 1] := 0.3383379423919174;
                c2[1, 2] := 1.092630816438030;
                c2[2, 1] := 0.3001025788696046;
                c2[2, 2] := 0.8289928256598656;
                c2[3, 1] := 0.2372867471539579;
                c2[3, 2] := 0.4325128641920154;
              elseif order == 8 then
                alpha := 0.3150267393795002;
                c2[1, 1] := 0.3151115975207653;
                c2[1, 2] := 1.109403015460190;
                c2[2, 1] := 0.2969344839572762;
                c2[2, 2] := 0.9737455812222699;
                c2[3, 1] := 0.2612545921889538;
                c2[3, 2] := 0.7190394712068573;
                c2[4, 1] := 0.2080523342974281;
                c2[4, 2] := 0.3721456473047434;
              elseif order == 9 then
                alpha := 0.2953310177184124;
                c1[1] := 0.5377196679501422;
                c2[1, 1] := 0.2824689124281034;
                c2[1, 2] := 1.022646191567475;
                c2[2, 1] := 0.2626824161383468;
                c2[2, 2] := 0.8695626454762596;
                c2[3, 1] := 0.2302781917677917;
                c2[3, 2] := 0.6309047553448520;
                c2[4, 1] := 0.1847991729757028;
                c2[4, 2] := 0.3251978031287202;
              elseif order == 10 then
                alpha := 0.2789426890619463;
                c2[1, 1] := 0.2640769908255582;
                c2[1, 2] := 1.019788132875305;
                c2[2, 1] := 0.2540802639216947;
                c2[2, 2] := 0.9377020417760623;
                c2[3, 1] := 0.2343577229427963;
                c2[3, 2] := 0.7802229808216112;
                c2[4, 1] := 0.2052193139338624;
                c2[4, 2] := 0.5594176813008133;
                c2[5, 1] := 0.1659546953748916;
                c2[5, 2] := 0.2878349616233292;
              elseif order == 11 then
                alpha := 0.2650227766037203;
                c1[1] := 0.4950265498954191;
                c2[1, 1] := 0.2411858478546218;
                c2[1, 2] := 0.9567800996387417;
                c2[2, 1] := 0.2296849355380925;
                c2[2, 2] := 0.8592523717113126;
                c2[3, 1] := 0.2107851705677406;
                c2[3, 2] := 0.7040216048898129;
                c2[4, 1] := 0.1846461385164021;
                c2[4, 2] := 0.5006729207276717;
                c2[5, 1] := 0.1504217970817433;
                c2[5, 2] := 0.2575070491320295;
              elseif order == 12 then
                alpha := 0.2530051198547209;
                c2[1, 1] := 0.2268294941204543;
                c2[1, 2] := 0.9473116570034053;
                c2[2, 1] := 0.2207657387793729;
                c2[2, 2] := 0.8933728946287606;
                c2[3, 1] := 0.2087600700376653;
                c2[3, 2] := 0.7886236252756229;
                c2[4, 1] := 0.1909959101492760;
                c2[4, 2] := 0.6389263649257017;
                c2[5, 1] := 0.1675208146048472;
                c2[5, 2] := 0.4517847275162215;
                c2[6, 1] := 0.1374257286372761;
                c2[6, 2] := 0.2324699157474680;
              elseif order == 13 then
                alpha := 0.2424910397561007;
                c1[1] := 0.4608848369928040;
                c2[1, 1] := 0.2099813050274780;
                c2[1, 2] := 0.8992478823790660;
                c2[2, 1] := 0.2027250423101359;
                c2[2, 2] := 0.8328117484224146;
                c2[3, 1] := 0.1907635894058731;
                c2[3, 2] := 0.7257379204691213;
                c2[4, 1] := 0.1742280397887686;
                c2[4, 2] := 0.5830640944868014;
                c2[5, 1] := 0.1530858190490478;
                c2[5, 2] := 0.4106192089751885;
                c2[6, 1] := 0.1264090712880446;
                c2[6, 2] := 0.2114980230156001;
              elseif order == 14 then
                alpha := 0.2331902368695848;
                c2[1, 1] := 0.1986162311411235;
                c2[1, 2] := 0.8876961808055535;
                c2[2, 1] := 0.1946683341271615;
                c2[2, 2] := 0.8500754229171967;
                c2[3, 1] := 0.1868331332895056;
                c2[3, 2] := 0.7764629313723603;
                c2[4, 1] := 0.1752118757862992;
                c2[4, 2] := 0.6699720402924552;
                c2[5, 1] := 0.1598906457908402;
                c2[5, 2] := 0.5348446712848934;
                c2[6, 1] := 0.1407810153019944;
                c2[6, 2] := 0.3755841316563539;
                c2[7, 1] := 0.1169627966707339;
                c2[7, 2] := 0.1937088226304455;
              elseif order == 15 then
                alpha := 0.2248854870552422;
                c1[1] := 0.4328492272335646;
                c2[1, 1] := 0.1857292591004588;
                c2[1, 2] := 0.8496337061962563;
                c2[2, 1] := 0.1808644178280136;
                c2[2, 2] := 0.8020517898136011;
                c2[3, 1] := 0.1728264404199081;
                c2[3, 2] := 0.7247449729331105;
                c2[4, 1] := 0.1616970125901954;
                c2[4, 2] := 0.6205369315943097;
                c2[5, 1] := 0.1475257264578426;
                c2[5, 2] := 0.4929612162355906;
                c2[6, 1] := 0.1301861023357119;
                c2[6, 2] := 0.3454770708040735;
                c2[7, 1] := 0.1087810777120188;
                c2[7, 2] := 0.1784526655428406;
              elseif order == 16 then
                alpha := 0.2174105053474761;
                c2[1, 1] := 0.1765637967473151;
                c2[1, 2] := 0.8377453068635511;
                c2[2, 1] := 0.1738525357503125;
                c2[2, 2] := 0.8102988957433199;
                c2[3, 1] := 0.1684627004613343;
                c2[3, 2] := 0.7563265923413258;
                c2[4, 1] := 0.1604519074815815;
                c2[4, 2] := 0.6776082294687619;
                c2[5, 1] := 0.1498828607802206;
                c2[5, 2] := 0.5766417034027680;
                c2[6, 1] := 0.1367764717792823;
                c2[6, 2] := 0.4563528264410489;
                c2[7, 1] := 0.1209810465419295;
                c2[7, 2] := 0.3193782657322374;
                c2[8, 1] := 0.1016312648007554;
                c2[8, 2] := 0.1652419227369036;
              elseif order == 17 then
                alpha := 0.2106355148193306;
                c1[1] := 0.4093223608497299;
                c2[1, 1] := 0.1664014345826274;
                c2[1, 2] := 0.8067173752345952;
                c2[2, 1] := 0.1629839591538256;
                c2[2, 2] := 0.7712924931447541;
                c2[3, 1] := 0.1573277802512491;
                c2[3, 2] := 0.7134213666303411;
                c2[4, 1] := 0.1494828185148637;
                c2[4, 2] := 0.6347841731714884;
                c2[5, 1] := 0.1394948812681826;
                c2[5, 2] := 0.5375594414619047;
                c2[6, 1] := 0.1273627583380806;
                c2[6, 2] := 0.4241608926375478;
                c2[7, 1] := 0.1129187258461290;
                c2[7, 2] := 0.2965752009703245;
                c2[8, 1] := 0.9533357359908857e-1;
                c2[8, 2] := 0.1537041700889585;
              elseif order == 18 then
                alpha := 0.2044575288651841;
                c2[1, 1] := 0.1588768571976356;
                c2[1, 2] := 0.7951914263212913;
                c2[2, 1] := 0.1569357024981854;
                c2[2, 2] := 0.7744529690772538;
                c2[3, 1] := 0.1530722206358810;
                c2[3, 2] := 0.7335304425992080;
                c2[4, 1] := 0.1473206710524167;
                c2[4, 2] := 0.6735038935387268;
                c2[5, 1] := 0.1397225420331520;
                c2[5, 2] := 0.5959151542621590;
                c2[6, 1] := 0.1303092459809849;
                c2[6, 2] := 0.5026483447894845;
                c2[7, 1] := 0.1190627367060072;
                c2[7, 2] := 0.3956893824587150;
                c2[8, 1] := 0.1058058030798994;
                c2[8, 2] := 0.2765091830730650;
                c2[9, 1] := 0.8974708108800873e-1;
                c2[9, 2] := 0.1435505288284833;
              elseif order == 19 then
                alpha := 0.1987936248083529;
                c1[1] := 0.3892259966869526;
                c2[1, 1] := 0.1506640012172225;
                c2[1, 2] := 0.7693121733774260;
                c2[2, 1] := 0.1481728062796673;
                c2[2, 2] := 0.7421133586741549;
                c2[3, 1] := 0.1440444668388838;
                c2[3, 2] := 0.6975075386214800;
                c2[4, 1] := 0.1383101628540374;
                c2[4, 2] := 0.6365464378910025;
                c2[5, 1] := 0.1310032283190998;
                c2[5, 2] := 0.5606211948462122;
                c2[6, 1] := 0.1221431166405330;
                c2[6, 2] := 0.4713530424221445;
                c2[7, 1] := 0.1116991161103884;
                c2[7, 2] := 0.3703717538617073;
                c2[8, 1] := 0.9948917351196349e-1;
                c2[8, 2] := 0.2587371155559744;
                c2[9, 1] := 0.8475989238107367e-1;
                c2[9, 2] := 0.1345537894555993;
              elseif order == 20 then
                alpha := 0.1935761760416219;
                c2[1, 1] := 0.1443871348337404;
                c2[1, 2] := 0.7584165598446141;
                c2[2, 1] := 0.1429501891353184;
                c2[2, 2] := 0.7423000962318863;
                c2[3, 1] := 0.1400877384920004;
                c2[3, 2] := 0.7104185332215555;
                c2[4, 1] := 0.1358210369491446;
                c2[4, 2] := 0.6634599783272630;
                c2[5, 1] := 0.1301773703034290;
                c2[5, 2] := 0.6024175491895959;
                c2[6, 1] := 0.1231826501439148;
                c2[6, 2] := 0.5285332736326852;
                c2[7, 1] := 0.1148465498575254;
                c2[7, 2] := 0.4431977385498628;
                c2[8, 1] := 0.1051289462376788;
                c2[8, 2] := 0.3477444062821162;
                c2[9, 1] := 0.9384622797485121e-1;
                c2[9, 2] := 0.2429038300327729;
                c2[10, 1] := 0.8028211612831444e-1;
                c2[10, 2] := 0.1265329974009533;
              elseif order == 21 then
                alpha := 0.1887494014766075;
                c1[1] := 0.3718070668941645;
                c2[1, 1] := 0.1376151928386445;
                c2[1, 2] := 0.7364290859445481;
                c2[2, 1] := 0.1357438914390695;
                c2[2, 2] := 0.7150167318935022;
                c2[3, 1] := 0.1326398453462415;
                c2[3, 2] := 0.6798001808470175;
                c2[4, 1] := 0.1283231214897678;
                c2[4, 2] := 0.6314663440439816;
                c2[5, 1] := 0.1228169159777534;
                c2[5, 2] := 0.5709353626166905;
                c2[6, 1] := 0.1161406100773184;
                c2[6, 2] := 0.4993087153571335;
                c2[7, 1] := 0.1082959649233524;
                c2[7, 2] := 0.4177766148584385;
                c2[8, 1] := 0.9923596957485723e-1;
                c2[8, 2] := 0.3274257287232124;
                c2[9, 1] := 0.8877776108724853e-1;
                c2[9, 2] := 0.2287218166767916;
                c2[10, 1] := 0.7624076527736326e-1;
                c2[10, 2] := 0.1193423971506988;
              elseif order == 22 then
                alpha := 0.1842668221199706;
                c2[1, 1] := 0.1323053462701543;
                c2[1, 2] := 0.7262446126765204;
                c2[2, 1] := 0.1312121721769772;
                c2[2, 2] := 0.7134286088450949;
                c2[3, 1] := 0.1290330911166814;
                c2[3, 2] := 0.6880287870435514;
                c2[4, 1] := 0.1257817990372067;
                c2[4, 2] := 0.6505015800059301;
                c2[5, 1] := 0.1214765261983008;
                c2[5, 2] := 0.6015107185211451;
                c2[6, 1] := 0.1161365140967959;
                c2[6, 2] := 0.5418983553698413;
                c2[7, 1] := 0.1097755171533100;
                c2[7, 2] := 0.4726370779831614;
                c2[8, 1] := 0.1023889478519956;
                c2[8, 2] := 0.3947439506537486;
                c2[9, 1] := 0.9392485861253800e-1;
                c2[9, 2] := 0.3090996703083202;
                c2[10, 1] := 0.8420273775456455e-1;
                c2[10, 2] := 0.2159561978556017;
                c2[11, 1] := 0.7257600023938262e-1;
                c2[11, 2] := 0.1128633732721116;
              elseif order == 23 then
                alpha := 0.1800893554453722;
                c1[1] := 0.3565232673929280;
                c2[1, 1] := 0.1266275171652706;
                c2[1, 2] := 0.7072778066734162;
                c2[2, 1] := 0.1251865227648538;
                c2[2, 2] := 0.6900676345785905;
                c2[3, 1] := 0.1227944815236645;
                c2[3, 2] := 0.6617011100576023;
                c2[4, 1] := 0.1194647013077667;
                c2[4, 2] := 0.6226432315773119;
                c2[5, 1] := 0.1152132989252356;
                c2[5, 2] := 0.5735222810625359;
                c2[6, 1] := 0.1100558598478487;
                c2[6, 2] := 0.5151027978024605;
                c2[7, 1] := 0.1040013558214886;
                c2[7, 2] := 0.4482410942032739;
                c2[8, 1] := 0.9704014176512626e-1;
                c2[8, 2] := 0.3738049984631116;
                c2[9, 1] := 0.8911683905758054e-1;
                c2[9, 2] := 0.2925028692588410;
                c2[10, 1] := 0.8005438265072295e-1;
                c2[10, 2] := 0.2044134600278901;
                c2[11, 1] := 0.6923832296800832e-1;
                c2[11, 2] := 0.1069984887283394;
              elseif order == 24 then
                alpha := 0.1761838665838427;
                c2[1, 1] := 0.1220804912720132;
                c2[1, 2] := 0.6978026874156063;
                c2[2, 1] := 0.1212296762358897;
                c2[2, 2] := 0.6874139794926736;
                c2[3, 1] := 0.1195328372961027;
                c2[3, 2] := 0.6667954259551859;
                c2[4, 1] := 0.1169990987333593;
                c2[4, 2] := 0.6362602049901176;
                c2[5, 1] := 0.1136409040480130;
                c2[5, 2] := 0.5962662188435553;
                c2[6, 1] := 0.1094722001757955;
                c2[6, 2] := 0.5474001634109253;
                c2[7, 1] := 0.1045052832229087;
                c2[7, 2] := 0.4903523180249535;
                c2[8, 1] := 0.9874509806025907e-1;
                c2[8, 2] := 0.4258751523524645;
                c2[9, 1] := 0.9217799943472177e-1;
                c2[9, 2] := 0.3547079765396403;
                c2[10, 1] := 0.8474633796250476e-1;
                c2[10, 2] := 0.2774145482392767;
                c2[11, 1] := 0.7627722381240495e-1;
                c2[11, 2] := 0.1939329108084139;
                c2[12, 1] := 0.6618645465422745e-1;
                c2[12, 2] := 0.1016670147947242;
              elseif order == 25 then
                alpha := 0.1725220521949266;
                c1[1] := 0.3429735385896000;
                c2[1, 1] := 0.1172525033170618;
                c2[1, 2] := 0.6812327932576614;
                c2[2, 1] := 0.1161194585333535;
                c2[2, 2] := 0.6671566071153211;
                c2[3, 1] := 0.1142375145794466;
                c2[3, 2] := 0.6439167855053158;
                c2[4, 1] := 0.1116157454252308;
                c2[4, 2] := 0.6118378416180135;
                c2[5, 1] := 0.1082654809459177;
                c2[5, 2] := 0.5713609763370088;
                c2[6, 1] := 0.1041985674230918;
                c2[6, 2] := 0.5230289949762722;
                c2[7, 1] := 0.9942439308123559e-1;
                c2[7, 2] := 0.4674627926041906;
                c2[8, 1] := 0.9394453593830893e-1;
                c2[8, 2] := 0.4053226688298811;
                c2[9, 1] := 0.8774221237222533e-1;
                c2[9, 2] := 0.3372372276379071;
                c2[10, 1] := 0.8075839512216483e-1;
                c2[10, 2] := 0.2636485508005428;
                c2[11, 1] := 0.7282483286646764e-1;
                c2[11, 2] := 0.1843801345273085;
                c2[12, 1] := 0.6338571166846652e-1;
                c2[12, 2] := 0.9680153764737715e-1;
              elseif order == 26 then
                alpha := 0.1690795702796737;
                c2[1, 1] := 0.1133168695796030;
                c2[1, 2] := 0.6724297955493932;
                c2[2, 1] := 0.1126417845769961;
                c2[2, 2] := 0.6638709519790540;
                c2[3, 1] := 0.1112948749545606;
                c2[3, 2] := 0.6468652038763624;
                c2[4, 1] := 0.1092823986944244;
                c2[4, 2] := 0.6216337070799265;
                c2[5, 1] := 0.1066130386697976;
                c2[5, 2] := 0.5885011413992190;
                c2[6, 1] := 0.1032969057045413;
                c2[6, 2] := 0.5478864278297548;
                c2[7, 1] := 0.9934388184210715e-1;
                c2[7, 2] := 0.5002885306054287;
                c2[8, 1] := 0.9476081523436283e-1;
                c2[8, 2] := 0.4462644847551711;
                c2[9, 1] := 0.8954648464575577e-1;
                c2[9, 2] := 0.3863930785049522;
                c2[10, 1] := 0.8368166847159917e-1;
                c2[10, 2] := 0.3212074592527143;
                c2[11, 1] := 0.7710664731701103e-1;
                c2[11, 2] := 0.2510470347119383;
                c2[12, 1] := 0.6965807988411425e-1;
                c2[12, 2] := 0.1756419294111342;
                c2[13, 1] := 0.6080674930548766e-1;
                c2[13, 2] := 0.9234535279274277e-1;
              elseif order == 27 then
                alpha := 0.1658353543067995;
                c1[1] := 0.3308543720638957;
                c2[1, 1] := 0.1091618578712746;
                c2[1, 2] := 0.6577977071169651;
                c2[2, 1] := 0.1082549561495043;
                c2[2, 2] := 0.6461121666520275;
                c2[3, 1] := 0.1067479247890451;
                c2[3, 2] := 0.6267937760991321;
                c2[4, 1] := 0.1046471079537577;
                c2[4, 2] := 0.6000750116745808;
                c2[5, 1] := 0.1019605976654259;
                c2[5, 2] := 0.5662734183049320;
                c2[6, 1] := 0.9869726954433709e-1;
                c2[6, 2] := 0.5257827234948534;
                c2[7, 1] := 0.9486520934132483e-1;
                c2[7, 2] := 0.4790595019077763;
                c2[8, 1] := 0.9046906518775348e-1;
                c2[8, 2] := 0.4266025862147336;
                c2[9, 1] := 0.8550529998276152e-1;
                c2[9, 2] := 0.3689188223512328;
                c2[10, 1] := 0.7995282239306020e-1;
                c2[10, 2] := 0.3064589322702932;
                c2[11, 1] := 0.7375174596252882e-1;
                c2[11, 2] := 0.2394754504667310;
                c2[12, 1] := 0.6674377263329041e-1;
                c2[12, 2] := 0.1676223546666024;
                c2[13, 1] := 0.5842458027529246e-1;
                c2[13, 2] := 0.8825044329219431e-1;
              elseif order == 28 then
                alpha := 0.1627710671942929;
                c2[1, 1] := 0.1057232656113488;
                c2[1, 2] := 0.6496161226860832;
                c2[2, 1] := 0.1051786825724864;
                c2[2, 2] := 0.6424661279909941;
                c2[3, 1] := 0.1040917964935006;
                c2[3, 2] := 0.6282470268918791;
                c2[4, 1] := 0.1024670101953951;
                c2[4, 2] := 0.6071189030701136;
                c2[5, 1] := 0.1003105109519892;
                c2[5, 2] := 0.5793175191747016;
                c2[6, 1] := 0.9762969425430802e-1;
                c2[6, 2] := 0.5451486608855443;
                c2[7, 1] := 0.9443223803058400e-1;
                c2[7, 2] := 0.5049796971628137;
                c2[8, 1] := 0.9072460982036488e-1;
                c2[8, 2] := 0.4592270546572523;
                c2[9, 1] := 0.8650956423253280e-1;
                c2[9, 2] := 0.4083368605952977;
                c2[10, 1] := 0.8178165740374893e-1;
                c2[10, 2] := 0.3527525188880655;
                c2[11, 1] := 0.7651838885868020e-1;
                c2[11, 2] := 0.2928534570013572;
                c2[12, 1] := 0.7066010532447490e-1;
                c2[12, 2] := 0.2288185204390681;
                c2[13, 1] := 0.6405358596145789e-1;
                c2[13, 2] := 0.1602396172588190;
                c2[14, 1] := 0.5621780070227172e-1;
                c2[14, 2] := 0.8447589564915071e-1;
              elseif order == 29 then
                alpha := 0.1598706626277596;
                c1[1] := 0.3199314513011623;
                c2[1, 1] := 0.1021101032532951;
                c2[1, 2] := 0.6365758882240111;
                c2[2, 1] := 0.1013729819392774;
                c2[2, 2] := 0.6267495975736321;
                c2[3, 1] := 0.1001476175660628;
                c2[3, 2] := 0.6104876178266819;
                c2[4, 1] := 0.9843854640428316e-1;
                c2[4, 2] := 0.5879603139195113;
                c2[5, 1] := 0.9625164534591696e-1;
                c2[5, 2] := 0.5594012291050210;
                c2[6, 1] := 0.9359356960417668e-1;
                c2[6, 2] := 0.5251016150410664;
                c2[7, 1] := 0.9047086748649986e-1;
                c2[7, 2] := 0.4854024475590397;
                c2[8, 1] := 0.8688856407189167e-1;
                c2[8, 2] := 0.4406826457109709;
                c2[9, 1] := 0.8284779224069856e-1;
                c2[9, 2] := 0.3913408089298914;
                c2[10, 1] := 0.7834154620997181e-1;
                c2[10, 2] := 0.3377643999400627;
                c2[11, 1] := 0.7334628941928766e-1;
                c2[11, 2] := 0.2802710651919946;
                c2[12, 1] := 0.6780290487362146e-1;
                c2[12, 2] := 0.2189770008083379;
                c2[13, 1] := 0.6156321231528423e-1;
                c2[13, 2] := 0.1534235999306070;
                c2[14, 1] := 0.5416797446761512e-1;
                c2[14, 2] := 0.8098664736760292e-1;
              elseif order == 30 then
                alpha := 0.1571200296252450;
                c2[1, 1] := 0.9908074847842124e-1;
                c2[1, 2] := 0.6289618807831557;
                c2[2, 1] := 0.9863509708328196e-1;
                c2[2, 2] := 0.6229164525571278;
                c2[3, 1] := 0.9774542692037148e-1;
                c2[3, 2] := 0.6108853364240036;
                c2[4, 1] := 0.9641490581986484e-1;
                c2[4, 2] := 0.5929869253412513;
                c2[5, 1] := 0.9464802912225441e-1;
                c2[5, 2] := 0.5693960175547550;
                c2[6, 1] := 0.9245027206218041e-1;
                c2[6, 2] := 0.5403402396359503;
                c2[7, 1] := 0.8982754584112941e-1;
                c2[7, 2] := 0.5060948065875106;
                c2[8, 1] := 0.8678535291732599e-1;
                c2[8, 2] := 0.4669749797983789;
                c2[9, 1] := 0.8332744242052199e-1;
                c2[9, 2] := 0.4233249626334694;
                c2[10, 1] := 0.7945356393775309e-1;
                c2[10, 2] := 0.3755006094498054;
                c2[11, 1] := 0.7515543969833788e-1;
                c2[11, 2] := 0.3238400339292700;
                c2[12, 1] := 0.7040879901685638e-1;
                c2[12, 2] := 0.2686072427439079;
                c2[13, 1] := 0.6515528854010540e-1;
                c2[13, 2] := 0.2098650589782619;
                c2[14, 1] := 0.5925168237177876e-1;
                c2[14, 2] := 0.1471138832654873;
                c2[15, 1] := 0.5225913954211672e-1;
                c2[15, 2] := 0.7775248839507864e-1;
              elseif order == 31 then
                alpha := 0.1545067022920929;
                c1[1] := 0.3100206996451866;
                c2[1, 1] := 0.9591020358831668e-1;
                c2[1, 2] := 0.6172474793293396;
                c2[2, 1] := 0.9530301275601203e-1;
                c2[2, 2] := 0.6088916323460413;
                c2[3, 1] := 0.9429332655402368e-1;
                c2[3, 2] := 0.5950511595503025;
                c2[4, 1] := 0.9288445429894548e-1;
                c2[4, 2] := 0.5758534119053522;
                c2[5, 1] := 0.9108073420087422e-1;
                c2[5, 2] := 0.5514734636081183;
                c2[6, 1] := 0.8888719137536870e-1;
                c2[6, 2] := 0.5221306199481831;
                c2[7, 1] := 0.8630901440239650e-1;
                c2[7, 2] := 0.4880834248148061;
                c2[8, 1] := 0.8335074993373294e-1;
                c2[8, 2] := 0.4496225358496770;
                c2[9, 1] := 0.8001502494376102e-1;
                c2[9, 2] := 0.4070602306679052;
                c2[10, 1] := 0.7630041338037624e-1;
                c2[10, 2] := 0.3607139804818122;
                c2[11, 1] := 0.7219760885744920e-1;
                c2[11, 2] := 0.3108783301229550;
                c2[12, 1] := 0.6768185077153345e-1;
                c2[12, 2] := 0.2577706252514497;
                c2[13, 1] := 0.6269571766328638e-1;
                c2[13, 2] := 0.2014081375889921;
                c2[14, 1] := 0.5710081766945065e-1;
                c2[14, 2] := 0.1412581515841926;
                c2[15, 1] := 0.5047740914807019e-1;
                c2[15, 2] := 0.7474725873250158e-1;
              elseif order == 32 then
                alpha := 0.1520196210848210;
                c2[1, 1] := 0.9322163554339406e-1;
                c2[1, 2] := 0.6101488690506050;
                c2[2, 1] := 0.9285233997694042e-1;
                c2[2, 2] := 0.6049832320721264;
                c2[3, 1] := 0.9211494244473163e-1;
                c2[3, 2] := 0.5946969295569034;
                c2[4, 1] := 0.9101176786042449e-1;
                c2[4, 2] := 0.5793791854364477;
                c2[5, 1] := 0.8954614071360517e-1;
                c2[5, 2] := 0.5591619969234026;
                c2[6, 1] := 0.8772216763680164e-1;
                c2[6, 2] := 0.5342177994699602;
                c2[7, 1] := 0.8554440426912734e-1;
                c2[7, 2] := 0.5047560942986598;
                c2[8, 1] := 0.8301735302045588e-1;
                c2[8, 2] := 0.4710187048140929;
                c2[9, 1] := 0.8014469519188161e-1;
                c2[9, 2] := 0.4332730387207936;
                c2[10, 1] := 0.7692807528893225e-1;
                c2[10, 2] := 0.3918021436411035;
                c2[11, 1] := 0.7336507157284898e-1;
                c2[11, 2] := 0.3468890521471250;
                c2[12, 1] := 0.6944555312763458e-1;
                c2[12, 2] := 0.2987898029050460;
                c2[13, 1] := 0.6514446669420571e-1;
                c2[13, 2] := 0.2476810747407199;
                c2[14, 1] := 0.6040544477732702e-1;
                c2[14, 2] := 0.1935412053397663;
                c2[15, 1] := 0.5509478650672775e-1;
                c2[15, 2] := 0.1358108994174911;
                c2[16, 1] := 0.4881064725720192e-1;
                c2[16, 2] := 0.7194819894416505e-1;
              elseif order == 33 then
                alpha := 0.1496489351138032;
                c1[1] := 0.3009752799176432;
                c2[1, 1] := 0.9041725460994505e-1;
                c2[1, 2] := 0.5995521047364046;
                c2[2, 1] := 0.8991117804113002e-1;
                c2[2, 2] := 0.5923764112099496;
                c2[3, 1] := 0.8906941547422532e-1;
                c2[3, 2] := 0.5804822013853129;
                c2[4, 1] := 0.8789442491445575e-1;
                c2[4, 2] := 0.5639663528946501;
                c2[5, 1] := 0.8638945831033775e-1;
                c2[5, 2] := 0.5429623519607796;
                c2[6, 1] := 0.8455834602616358e-1;
                c2[6, 2] := 0.5176379938389326;
                c2[7, 1] := 0.8240517431382334e-1;
                c2[7, 2] := 0.4881921474066189;
                c2[8, 1] := 0.7993380417355076e-1;
                c2[8, 2] := 0.4548502528082586;
                c2[9, 1] := 0.7714713890732801e-1;
                c2[9, 2] := 0.4178579388038483;
                c2[10, 1] := 0.7404596598181127e-1;
                c2[10, 2] := 0.3774715722484659;
                c2[11, 1] := 0.7062702339160462e-1;
                c2[11, 2] := 0.3339432938810453;
                c2[12, 1] := 0.6687952672391507e-1;
                c2[12, 2] := 0.2874950693388235;
                c2[13, 1] := 0.6277828912909767e-1;
                c2[13, 2] := 0.2382680702894708;
                c2[14, 1] := 0.5826808305383988e-1;
                c2[14, 2] := 0.1862073169968455;
                c2[15, 1] := 0.5321974125363517e-1;
                c2[15, 2] := 0.1307323751236313;
                c2[16, 1] := 0.4724820282032780e-1;
                c2[16, 2] := 0.6933542082177094e-1;
              elseif order == 34 then
                alpha := 0.1473858373968463;
                c2[1, 1] := 0.8801537152275983e-1;
                c2[1, 2] := 0.5929204288972172;
                c2[2, 1] := 0.8770594341007476e-1;
                c2[2, 2] := 0.5884653382247518;
                c2[3, 1] := 0.8708797598072095e-1;
                c2[3, 2] := 0.5795895850253119;
                c2[4, 1] := 0.8616320590689187e-1;
                c2[4, 2] := 0.5663615383647170;
                c2[5, 1] := 0.8493413175570858e-1;
                c2[5, 2] := 0.5488825092350877;
                c2[6, 1] := 0.8340387368687513e-1;
                c2[6, 2] := 0.5272851839324592;
                c2[7, 1] := 0.8157596213131521e-1;
                c2[7, 2] := 0.5017313864372913;
                c2[8, 1] := 0.7945402670834270e-1;
                c2[8, 2] := 0.4724089864574216;
                c2[9, 1] := 0.7704133559556429e-1;
                c2[9, 2] := 0.4395276256463053;
                c2[10, 1] := 0.7434009635219704e-1;
                c2[10, 2] := 0.4033126590648964;
                c2[11, 1] := 0.7135035113853376e-1;
                c2[11, 2] := 0.3639961488919042;
                c2[12, 1] := 0.6806813160738834e-1;
                c2[12, 2] := 0.3218025212900124;
                c2[13, 1] := 0.6448214312000864e-1;
                c2[13, 2] := 0.2769235521088158;
                c2[14, 1] := 0.6056719318430530e-1;
                c2[14, 2] := 0.2294693573271038;
                c2[15, 1] := 0.5626925196925040e-1;
                c2[15, 2] := 0.1793564218840015;
                c2[16, 1] := 0.5146352031547277e-1;
                c2[16, 2] := 0.1259877129326412;
                c2[17, 1] := 0.4578069074410591e-1;
                c2[17, 2] := 0.6689147319568768e-1;
              elseif order == 35 then
                alpha := 0.1452224267615486;
                c1[1] := 0.2926764667564367;
                c2[1, 1] := 0.8551731299267280e-1;
                c2[1, 2] := 0.5832758214629523;
                c2[2, 1] := 0.8509109732853060e-1;
                c2[2, 2] := 0.5770596582643844;
                c2[3, 1] := 0.8438201446671953e-1;
                c2[3, 2] := 0.5667497616665494;
                c2[4, 1] := 0.8339191981579831e-1;
                c2[4, 2] := 0.5524209816238369;
                c2[5, 1] := 0.8212328610083385e-1;
                c2[5, 2] := 0.5341766459916322;
                c2[6, 1] := 0.8057906332198853e-1;
                c2[6, 2] := 0.5121470053512750;
                c2[7, 1] := 0.7876247299954955e-1;
                c2[7, 2] := 0.4864870722254752;
                c2[8, 1] := 0.7667670879950268e-1;
                c2[8, 2] := 0.4573736721705665;
                c2[9, 1] := 0.7432449556218945e-1;
                c2[9, 2] := 0.4250013835198991;
                c2[10, 1] := 0.7170742126011575e-1;
                c2[10, 2] := 0.3895767735915445;
                c2[11, 1] := 0.6882488171701314e-1;
                c2[11, 2] := 0.3513097926737368;
                c2[12, 1] := 0.6567231746957568e-1;
                c2[12, 2] := 0.3103999917596611;
                c2[13, 1] := 0.6223804362223595e-1;
                c2[13, 2] := 0.2670123611280899;
                c2[14, 1] := 0.5849696460782910e-1;
                c2[14, 2] := 0.2212298104867592;
                c2[15, 1] := 0.5439628409499822e-1;
                c2[15, 2] := 0.1729443731341637;
                c2[16, 1] := 0.4981540179136920e-1;
                c2[16, 2] := 0.1215462157134930;
                c2[17, 1] := 0.4439981033536435e-1;
                c2[17, 2] := 0.6460098363520967e-1;
              elseif order == 36 then
                alpha := 0.1431515914458580;
                c2[1, 1] := 0.8335881847130301e-1;
                c2[1, 2] := 0.5770670512160201;
                c2[2, 1] := 0.8309698922852212e-1;
                c2[2, 2] := 0.5731929100172432;
                c2[3, 1] := 0.8257400347039723e-1;
                c2[3, 2] := 0.5654713811993058;
                c2[4, 1] := 0.8179117911600136e-1;
                c2[4, 2] := 0.5539556343603020;
                c2[5, 1] := 0.8075042173126963e-1;
                c2[5, 2] := 0.5387245649546684;
                c2[6, 1] := 0.7945413151258206e-1;
                c2[6, 2] := 0.5198817177723069;
                c2[7, 1] := 0.7790506514288866e-1;
                c2[7, 2] := 0.4975537629595409;
                c2[8, 1] := 0.7610613635339480e-1;
                c2[8, 2] := 0.4718884193866789;
                c2[9, 1] := 0.7406012816626425e-1;
                c2[9, 2] := 0.4430516443136726;
                c2[10, 1] := 0.7176927060205631e-1;
                c2[10, 2] := 0.4112237708115829;
                c2[11, 1] := 0.6923460172504251e-1;
                c2[11, 2] := 0.3765940116389730;
                c2[12, 1] := 0.6645495833489556e-1;
                c2[12, 2] := 0.3393522147815403;
                c2[13, 1] := 0.6342528888937094e-1;
                c2[13, 2] := 0.2996755899575573;
                c2[14, 1] := 0.6013361864949449e-1;
                c2[14, 2] := 0.2577053294053830;
                c2[15, 1] := 0.5655503081322404e-1;
                c2[15, 2] := 0.2135004731531631;
                c2[16, 1] := 0.5263798119559069e-1;
                c2[16, 2] := 0.1669320999865636;
                c2[17, 1] := 0.4826589873626196e-1;
                c2[17, 2] := 0.1173807590715484;
                c2[18, 1] := 0.4309819397289806e-1;
                c2[18, 2] := 0.6245036108880222e-1;
              elseif order == 37 then
                alpha := 0.1411669104782917;
                c1[1] := 0.2850271036215707;
                c2[1, 1] := 0.8111958235023328e-1;
                c2[1, 2] := 0.5682412610563970;
                c2[2, 1] := 0.8075727567979578e-1;
                c2[2, 2] := 0.5628142923227016;
                c2[3, 1] := 0.8015440554413301e-1;
                c2[3, 2] := 0.5538087696879930;
                c2[4, 1] := 0.7931239302677386e-1;
                c2[4, 2] := 0.5412833323304460;
                c2[5, 1] := 0.7823314328639347e-1;
                c2[5, 2] := 0.5253190555393968;
                c2[6, 1] := 0.7691895211595101e-1;
                c2[6, 2] := 0.5060183741977191;
                c2[7, 1] := 0.7537237072011853e-1;
                c2[7, 2] := 0.4835036020049034;
                c2[8, 1] := 0.7359601294804538e-1;
                c2[8, 2] := 0.4579149413954837;
                c2[9, 1] := 0.7159227884849299e-1;
                c2[9, 2] := 0.4294078049978829;
                c2[10, 1] := 0.6936295002846032e-1;
                c2[10, 2] := 0.3981491350382047;
                c2[11, 1] := 0.6690857785828917e-1;
                c2[11, 2] := 0.3643121502867948;
                c2[12, 1] := 0.6422751692085542e-1;
                c2[12, 2] := 0.3280684291406284;
                c2[13, 1] := 0.6131430866206096e-1;
                c2[13, 2] := 0.2895750997170303;
                c2[14, 1] := 0.5815677249570920e-1;
                c2[14, 2] := 0.2489521814805720;
                c2[15, 1] := 0.5473023527947980e-1;
                c2[15, 2] := 0.2062377435955363;
                c2[16, 1] := 0.5098441033167034e-1;
                c2[16, 2] := 0.1612849131645336;
                c2[17, 1] := 0.4680658811093562e-1;
                c2[17, 2] := 0.1134672937045305;
                c2[18, 1] := 0.4186928031694695e-1;
                c2[18, 2] := 0.6042754777339966e-1;
              elseif order == 38 then
                alpha := 0.1392625697140030;
                c2[1, 1] := 0.7916943373658329e-1;
                c2[1, 2] := 0.5624158631591745;
                c2[2, 1] := 0.7894592250257840e-1;
                c2[2, 2] := 0.5590219398777304;
                c2[3, 1] := 0.7849941672384930e-1;
                c2[3, 2] := 0.5522551628416841;
                c2[4, 1] := 0.7783093084875645e-1;
                c2[4, 2] := 0.5421574325808380;
                c2[5, 1] := 0.7694193770482690e-1;
                c2[5, 2] := 0.5287909941093643;
                c2[6, 1] := 0.7583430534712885e-1;
                c2[6, 2] := 0.5122376814029880;
                c2[7, 1] := 0.7451020436122948e-1;
                c2[7, 2] := 0.4925978555548549;
                c2[8, 1] := 0.7297197617673508e-1;
                c2[8, 2] := 0.4699889739625235;
                c2[9, 1] := 0.7122194706992953e-1;
                c2[9, 2] := 0.4445436860615774;
                c2[10, 1] := 0.6926216260386816e-1;
                c2[10, 2] := 0.4164072786327193;
                c2[11, 1] := 0.6709399961255503e-1;
                c2[11, 2] := 0.3857341621868851;
                c2[12, 1] := 0.6471757977022456e-1;
                c2[12, 2] := 0.3526828388476838;
                c2[13, 1] := 0.6213084287116965e-1;
                c2[13, 2] := 0.3174082831364342;
                c2[14, 1] := 0.5932799638550641e-1;
                c2[14, 2] := 0.2800495563550299;
                c2[15, 1] := 0.5629672408524944e-1;
                c2[15, 2] := 0.2407078154782509;
                c2[16, 1] := 0.5301264751544952e-1;
                c2[16, 2] := 0.1994026830553859;
                c2[17, 1] := 0.4942673259817896e-1;
                c2[17, 2] := 0.1559719194038917;
                c2[18, 1] := 0.4542996716979947e-1;
                c2[18, 2] := 0.1097844277878470;
                c2[19, 1] := 0.4070720755433961e-1;
                c2[19, 2] := 0.5852181110523043e-1;
              elseif order == 39 then
                alpha := 0.1374332900196804;
                c1[1] := 0.2779468246419593;
                c2[1, 1] := 0.7715084161825772e-1;
                c2[1, 2] := 0.5543001331300056;
                c2[2, 1] := 0.7684028301163326e-1;
                c2[2, 2] := 0.5495289890712267;
                c2[3, 1] := 0.7632343924866024e-1;
                c2[3, 2] := 0.5416083298429741;
                c2[4, 1] := 0.7560141319808483e-1;
                c2[4, 2] := 0.5305846713929198;
                c2[5, 1] := 0.7467569064745969e-1;
                c2[5, 2] := 0.5165224112570647;
                c2[6, 1] := 0.7354807648551346e-1;
                c2[6, 2] := 0.4995030679271456;
                c2[7, 1] := 0.7222060351121389e-1;
                c2[7, 2] := 0.4796242430956156;
                c2[8, 1] := 0.7069540462458585e-1;
                c2[8, 2] := 0.4569982440368368;
                c2[9, 1] := 0.6897453353492381e-1;
                c2[9, 2] := 0.4317502624832354;
                c2[10, 1] := 0.6705970959388781e-1;
                c2[10, 2] := 0.4040159353969854;
                c2[11, 1] := 0.6495194541066725e-1;
                c2[11, 2] := 0.3739379843169939;
                c2[12, 1] := 0.6265098412417610e-1;
                c2[12, 2] := 0.3416613843816217;
                c2[13, 1] := 0.6015440984955930e-1;
                c2[13, 2] := 0.3073260166338746;
                c2[14, 1] := 0.5745615876877304e-1;
                c2[14, 2] := 0.2710546723961181;
                c2[15, 1] := 0.5454383762391338e-1;
                c2[15, 2] := 0.2329316824061170;
                c2[16, 1] := 0.5139340231935751e-1;
                c2[16, 2] := 0.1929604256043231;
                c2[17, 1] := 0.4795705862458131e-1;
                c2[17, 2] := 0.1509655259246037;
                c2[18, 1] := 0.4412933231935506e-1;
                c2[18, 2] := 0.1063130748962878;
                c2[19, 1] := 0.3960672309405603e-1;
                c2[19, 2] := 0.5672356837211527e-1;
              elseif order == 40 then
                alpha := 0.1356742655825434;
                c2[1, 1] := 0.7538038374294594e-1;
                c2[1, 2] := 0.5488228264329617;
                c2[2, 1] := 0.7518806529402738e-1;
                c2[2, 2] := 0.5458297722483311;
                c2[3, 1] := 0.7480383050347119e-1;
                c2[3, 2] := 0.5398604576730540;
                c2[4, 1] := 0.7422847031965465e-1;
                c2[4, 2] := 0.5309482987446206;
                c2[5, 1] := 0.7346313704205006e-1;
                c2[5, 2] := 0.5191429845322307;
                c2[6, 1] := 0.7250930053201402e-1;
                c2[6, 2] := 0.5045099368431007;
                c2[7, 1] := 0.7136868456879621e-1;
                c2[7, 2] := 0.4871295553902607;
                c2[8, 1] := 0.7004317764946634e-1;
                c2[8, 2] := 0.4670962098860498;
                c2[9, 1] := 0.6853470921527828e-1;
                c2[9, 2] := 0.4445169164956202;
                c2[10, 1] := 0.6684507689945471e-1;
                c2[10, 2] := 0.4195095960479698;
                c2[11, 1] := 0.6497570123412630e-1;
                c2[11, 2] := 0.3922007419030645;
                c2[12, 1] := 0.6292726794917847e-1;
                c2[12, 2] := 0.3627221993494397;
                c2[13, 1] := 0.6069918741663154e-1;
                c2[13, 2] := 0.3312065181294388;
                c2[14, 1] := 0.5828873983769410e-1;
                c2[14, 2] := 0.2977798532686911;
                c2[15, 1] := 0.5568964389813015e-1;
                c2[15, 2] := 0.2625503293999835;
                c2[16, 1] := 0.5288947816690705e-1;
                c2[16, 2] := 0.2255872486520188;
                c2[17, 1] := 0.4986456327645859e-1;
                c2[17, 2] := 0.1868796731919594;
                c2[18, 1] := 0.4656832613054458e-1;
                c2[18, 2] := 0.1462410193532463;
                c2[19, 1] := 0.4289867647614935e-1;
                c2[19, 2] := 0.1030361558710747;
                c2[20, 1] := 0.3856310684054106e-1;
                c2[20, 2] := 0.5502423832293889e-1;
              elseif order == 41 then
                alpha := 0.1339811106984253;
                c1[1] := 0.2713685065531391;
                c2[1, 1] := 0.7355140275160984e-1;
                c2[1, 2] := 0.5413274778282860;
                c2[2, 1] := 0.7328319082267173e-1;
                c2[2, 2] := 0.5371064088294270;
                c2[3, 1] := 0.7283676160772547e-1;
                c2[3, 2] := 0.5300963437270770;
                c2[4, 1] := 0.7221298133014343e-1;
                c2[4, 2] := 0.5203345998371490;
                c2[5, 1] := 0.7141302173623395e-1;
                c2[5, 2] := 0.5078728971879841;
                c2[6, 1] := 0.7043831559982149e-1;
                c2[6, 2] := 0.4927768111819803;
                c2[7, 1] := 0.6929049381827268e-1;
                c2[7, 2] := 0.4751250308594139;
                c2[8, 1] := 0.6797129849758392e-1;
                c2[8, 2] := 0.4550083840638406;
                c2[9, 1] := 0.6648246325101609e-1;
                c2[9, 2] := 0.4325285673076087;
                c2[10, 1] := 0.6482554675958526e-1;
                c2[10, 2] := 0.4077964789091151;
                c2[11, 1] := 0.6300169683004558e-1;
                c2[11, 2] := 0.3809299858742483;
                c2[12, 1] := 0.6101130648543355e-1;
                c2[12, 2] := 0.3520508315700898;
                c2[13, 1] := 0.5885349417435808e-1;
                c2[13, 2] := 0.3212801560701271;
                c2[14, 1] := 0.5652528148656809e-1;
                c2[14, 2] := 0.2887316252774887;
                c2[15, 1] := 0.5402021575818373e-1;
                c2[15, 2] := 0.2545001287790888;
                c2[16, 1] := 0.5132588802608274e-1;
                c2[16, 2] := 0.2186415296842951;
                c2[17, 1] := 0.4841900639702602e-1;
                c2[17, 2] := 0.1811322622296060;
                c2[18, 1] := 0.4525419574485134e-1;
                c2[18, 2] := 0.1417762065404688;
                c2[19, 1] := 0.4173260173087802e-1;
                c2[19, 2] := 0.9993834530966510e-1;
                c2[20, 1] := 0.3757210572966463e-1;
                c2[20, 2] := 0.5341611499960143e-1;
              else
                Streams.error("Input argument order (= " + String(order) +
                  ") of Bessel filter is not in the range 1..41");
              end if;

              annotation (Documentation(info="<html> The transfer function H(p) of a <i>n</i> 'th order Bessel filter is given by

<blockquote><pre>
         Bn(0)
 H(p) = -------
         Bn(p)
 </pre>
</blockquote> with the denominator polynomial

<blockquote><pre>
          n             n  (2n - k)!       p^k
 Bn(p) = sum c_k*p^k = sum ----------- * -------   (1)
         k=0           k=0 (n - k)!k!    2^(n-k)
</pre></blockquote>

and the numerator

<blockquote><pre>
               (2n)!     1
Bn(0) = c_0 = ------- * ---- .                     (2)
                n!      2^n
 </pre></blockquote>

Although the coefficients c_k are integer numbers, it is not advisable to use the
polynomials in an unfactorized form because the coefficients are fast growing with order
n (c_0 is approximately 0.3e24 and 0.8e59 for order n=20 and order n=40
respectively).<br>

Therefore, the polynomial Bn(p) is factorized to first and second order polynomials with
real coefficients corresponding to zeros and poles representation that is used in this library.
<p>
The function returns the coefficients which resulted from factorization of the normalized transfer function

<blockquote><pre>
H'(p') = H(p),  p' = p/w0
</pre></blockquote>
as well as
<blockquote><pre>
alpha = 1/w0
</pre></blockquote>
the reciprocal of the cut of frequency w0 where the gain of the transfer function is
decreased 3dB.<p>

Both, coefficients and cut off frequency were calculated symbolically and were eventually evaluated
with high precision calculation. The results were stored in this function as real
numbers.<p>

<br><br><b>Calculation of normalized Bessel filter coefficients</b><br><br>

Equation <blockquote><pre>
   abs(H(j*w0)) = abs(Bn(0)/Bn(j*w0)) = 10^(-3/20)
 </pre></blockquote>
which must be fulfilled for cut off frequency w = w0 leads to
<blockquote><pre>
   [Re(Bn(j*w0))]^2 + [Im(Bn(j*w0))]^2 - (Bn(0)^2)*10^(3/10) = 0
</pre></blockquote>
which has exactly one real solution w0 for each order n. This solutions of w0 are
calculated symbolically first and evaluated by using high precise values of the
coefficients c_k calculated by following (1) and (2). <br>

With w0, the coefficients of the factorized polynomial can be computed by calculating the
zeros of the denominator polynomial

<blockquote><pre>
         n
 Bn(p) = sum w0^k*c_k*(p/w0)^k
         k=0
</pre></blockquote>

of the normalized transfer function H'(p'). There exist n/2 of conjugate complex
pairs of zeros (beta +-j*gamma) if n is even and one additional real zero (alpha) if n is
odd. Finally, the coefficients a, b1_k, b2_k of the polynomials

<blockquote><pre> a*p + 1,  n is odd </pre></blockquote> and

<blockquote><pre> b2_k*p^2 + b1_k*p + 1,   k = 1,... div(n,2) </pre></blockquote>

results from <blockquote><pre> a = -1/alpha </pre></blockquote> and
<blockquote><pre> b2_k = 1/(beta_k^2 + gamma_k^2) b1_k = -2*beta_k/(beta_k^2 + gamma_k^2)
</pre></blockquote>
</p>

</html>
"));
            end BesselBaseCoefficients;

            function toHighestPowerOne
              "Transform filter to form with highest power of s equal 1"

              input Real den1[:]
                "[s] coefficients of polynomials (den1[i]*s + 1)";
              input Real den2[:,2]
                "[s^2, s] coefficients of polynomials (den2[i,1]*s^2 + den2[i,2]*s + 1)";
              output Real cr[size(den1, 1)]
                "[s^0] coefficients of polynomials cr[i]*(s+1/cr[i])";
              output Real c0[size(den2, 1)]
                "[s^0] coefficients of polynomials (s^2 + (den2[i,2]/den2[i,1])*s + (1/den2[i,1]))";
              output Real c1[size(den2, 1)]
                "[s^1] coefficients of polynomials (s^2 + (den2[i,2]/den2[i,1])*s + (1/den2[i,1]))";
            algorithm
              for i in 1:size(den1, 1) loop
                cr[i] := 1/den1[i];
              end for;

              for i in 1:size(den2, 1) loop
                c1[i] := den2[i, 2]/den2[i, 1];
                c0[i] := 1/den2[i, 1];
              end for;
            end toHighestPowerOne;

            function normalizationFactor
              "Compute correction factor of low pass filter such that amplitude at cut-off frequency is -3db (=10^(-3/20) = 0.70794...)"
              import Modelica;
              import Modelica.Utilities.Streams;

              input Real c1[:]
                "[p] coefficients of denominator polynomials (c1[i}*p + 1)";
              input Real c2[:,2]
                "[p^2, p] coefficients of denominator polynomials (c2[i,1]*p^2 + c2[i,2]*p + 1)";
              output Real alpha "Correction factor (replace p by alpha*p)";
            protected
              Real alpha_min;
              Real alpha_max;

              function normalizationResidue
                "Residue of correction factor computation"
                input Real c1[:]
                  "[p] coefficients of denominator polynomials (c1[i]*p + 1)";
                input Real c2[:,2]
                  "[p^2, p] coefficients of denominator polynomials (c2[i,1]*p^2 + c2[i,2]*p + 1)";
                input Real alpha;
                output Real residue;
              protected
                constant Real beta= 10^(-3/20)
                  "Amplitude of -3db required, i.e., -3db = 20*log(beta)";
                Real cc1;
                Real cc2;
                Real p;
                Real alpha2=alpha*alpha;
                Real alpha4=alpha2*alpha2;
                Real A2=1.0;
              algorithm
                assert(size(c1,1) <= 1, "Internal error 2 (should not occur)");
                if size(c1, 1) == 1 then
                  cc1 := c1[1]*c1[1];
                  p := 1 + cc1*alpha2;
                  A2 := A2*p;
                end if;
                for i in 1:size(c2, 1) loop
                  cc1 := c2[i, 2]*c2[i, 2] - 2*c2[i, 1];
                  cc2 := c2[i, 1]*c2[i, 1];
                  p := 1 + cc1*alpha2 + cc2*alpha4;
                  A2 := A2*p;
                end for;
                residue := 1/sqrt(A2) - beta;
              end normalizationResidue;

              function findInterval "Find interval for the root"
                input Real c1[:]
                  "[p] coefficients of denominator polynomials (a*p + 1)";
                input Real c2[:,2]
                  "[p^2, p] coefficients of denominator polynomials (b*p^2 + a*p + 1)";
                output Real alpha_min;
                output Real alpha_max;
              protected
                Real alpha = 1.0;
                Real residue;
              algorithm
                alpha_min :=0;
                residue := normalizationResidue(c1, c2, alpha);
                if residue < 0 then
                   alpha_max :=alpha;
                else
                   while residue >= 0 loop
                      alpha := 1.1*alpha;
                      residue := normalizationResidue(c1, c2, alpha);
                   end while;
                   alpha_max :=alpha;
                end if;
              end findInterval;

            function solveOneNonlinearEquation
                "Solve f(u) = 0; f(u_min) and f(u_max) must have different signs"
                import Modelica.Utilities.Streams.error;

              input Real c1[:]
                  "[p] coefficients of denominator polynomials (c1[i]*p + 1)";
              input Real c2[:,2]
                  "[p^2, p] coefficients of denominator polynomials (c2[i,1]*p^2 + c2[i,2]*p + 1)";
              input Real u_min "Lower bound of search intervall";
              input Real u_max "Upper bound of search intervall";
              input Real tolerance=100*Modelica.Constants.eps
                  "Relative tolerance of solution u";
              output Real u "Value of independent variable so that f(u) = 0";

              protected
              constant Real eps=Modelica.Constants.eps "machine epsilon";
              Real a=u_min "Current best minimum interval value";
              Real b=u_max "Current best maximum interval value";
              Real c "Intermediate point a <= c <= b";
              Real d;
              Real e "b - a";
              Real m;
              Real s;
              Real p;
              Real q;
              Real r;
              Real tol;
              Real fa "= f(a)";
              Real fb "= f(b)";
              Real fc;
              Boolean found=false;
            algorithm
              // Check that f(u_min) and f(u_max) have different sign
              fa := normalizationResidue(c1,c2,u_min);
              fb := normalizationResidue(c1,c2,u_max);
              fc := fb;
              if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
                error(
                  "The arguments u_min and u_max to solveOneNonlinearEquation(..)\n" +
                  "do not bracket the root of the single non-linear equation:\n" +
                  "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max)
                   + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" +
                  "  fb = f(u_max) = " + String(fb) + "\n" +
                  "fa and fb must have opposite sign which is not the case");
              end if;

              // Initialize variables
              c := a;
              fc := fa;
              e := b - a;
              d := e;

              // Search loop
              while not found loop
                if abs(fc) < abs(fb) then
                  a := b;
                  b := c;
                  c := a;
                  fa := fb;
                  fb := fc;
                  fc := fa;
                end if;

                tol := 2*eps*abs(b) + tolerance;
                m := (c - b)/2;

                if abs(m) <= tol or fb == 0.0 then
                  // root found (interval is small enough)
                  found := true;
                  u := b;
                else
                  // Determine if a bisection is needed
                  if abs(e) < tol or abs(fa) <= abs(fb) then
                    e := m;
                    d := e;
                  else
                    s := fb/fa;
                    if a == c then
                      // linear interpolation
                      p := 2*m*s;
                      q := 1 - s;
                    else
                      // inverse quadratic interpolation
                      q := fa/fc;
                      r := fb/fc;
                      p := s*(2*m*q*(q - r) - (b - a)*(r - 1));
                      q := (q - 1)*(r - 1)*(s - 1);
                    end if;

                    if p > 0 then
                      q := -q;
                    else
                      p := -p;
                    end if;

                    s := e;
                    e := d;
                    if 2*p < 3*m*q - abs(tol*q) and p < abs(0.5*s*q) then
                      // interpolation successful
                      d := p/q;
                    else
                      // use bi-section
                      e := m;
                      d := e;
                    end if;
                  end if;

                  // Best guess value is defined as "a"
                  a := b;
                  fa := fb;
                  b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
                  fb := normalizationResidue(c1,c2,b);

                  if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
                    // initialize variables
                    c := a;
                    fc := fa;
                    e := b - a;
                    d := e;
                  end if;
                end if;
              end while;

              annotation (Documentation(info="<html>

<p>
This function determines the solution of <b>one non-linear algebraic equation</b> \"y=f(u)\"
in <b>one unknown</b> \"u\" in a reliable way. It is one of the best numerical
algorithms for this purpose. As input, the nonlinear function f(u)
has to be given, as well as an interval u_min, u_max that
contains the solution, i.e., \"f(u_min)\" and \"f(u_max)\" must
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

</html>"));
            end solveOneNonlinearEquation;

            algorithm
               // Find interval for alpha
               (alpha_min, alpha_max) :=findInterval(c1, c2);

               // Compute alpha, so that abs(G(p)) = -3db
               alpha :=solveOneNonlinearEquation(
                c1,
                c2,
                alpha_min,
                alpha_max);
            end normalizationFactor;

            encapsulated function bandPassAlpha "Return alpha for band pass"
              import Modelica;
               input Real a "Coefficient of s^1";
               input Real b "Coefficient of s^0";
               input Modelica.SIunits.AngularVelocity w
                "Bandwidth angular frequency";
               output Real alpha "Alpha factor to build up band pass";

            protected
              Real alpha_min;
              Real alpha_max;
              Real z_min;
              Real z_max;
              Real z;

              function residue "Residue of non-linear equation"
                input Real a;
                input Real b;
                input Real w;
                input Real z;
                output Real res;
              algorithm
                res := z^2 + (a*w*z/(1+z))^2 - (2+b*w^2)*z + 1;
              end residue;

            function solveOneNonlinearEquation
                "Solve f(u) = 0; f(u_min) and f(u_max) must have different signs"
                import Modelica.Utilities.Streams.error;

              input Real aa;
              input Real bb;
              input Real ww;
              input Real u_min "Lower bound of search intervall";
              input Real u_max "Upper bound of search intervall";
              input Real tolerance=100*Modelica.Constants.eps
                  "Relative tolerance of solution u";
              output Real u "Value of independent variable so that f(u) = 0";

              protected
              constant Real eps=Modelica.Constants.eps "machine epsilon";
              Real a=u_min "Current best minimum interval value";
              Real b=u_max "Current best maximum interval value";
              Real c "Intermediate point a <= c <= b";
              Real d;
              Real e "b - a";
              Real m;
              Real s;
              Real p;
              Real q;
              Real r;
              Real tol;
              Real fa "= f(a)";
              Real fb "= f(b)";
              Real fc;
              Boolean found=false;
            algorithm
              // Check that f(u_min) and f(u_max) have different sign
              fa := residue(aa,bb,ww,u_min);
              fb := residue(aa,bb,ww,u_max);
              fc := fb;
              if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
                error(
                  "The arguments u_min and u_max to solveOneNonlinearEquation(..)\n" +
                  "do not bracket the root of the single non-linear equation:\n" +
                  "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max)
                   + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" +
                  "  fb = f(u_max) = " + String(fb) + "\n" +
                  "fa and fb must have opposite sign which is not the case");
              end if;

              // Initialize variables
              c := a;
              fc := fa;
              e := b - a;
              d := e;

              // Search loop
              while not found loop
                if abs(fc) < abs(fb) then
                  a := b;
                  b := c;
                  c := a;
                  fa := fb;
                  fb := fc;
                  fc := fa;
                end if;

                tol := 2*eps*abs(b) + tolerance;
                m := (c - b)/2;

                if abs(m) <= tol or fb == 0.0 then
                  // root found (interval is small enough)
                  found := true;
                  u := b;
                else
                  // Determine if a bisection is needed
                  if abs(e) < tol or abs(fa) <= abs(fb) then
                    e := m;
                    d := e;
                  else
                    s := fb/fa;
                    if a == c then
                      // linear interpolation
                      p := 2*m*s;
                      q := 1 - s;
                    else
                      // inverse quadratic interpolation
                      q := fa/fc;
                      r := fb/fc;
                      p := s*(2*m*q*(q - r) - (b - a)*(r - 1));
                      q := (q - 1)*(r - 1)*(s - 1);
                    end if;

                    if p > 0 then
                      q := -q;
                    else
                      p := -p;
                    end if;

                    s := e;
                    e := d;
                    if 2*p < 3*m*q - abs(tol*q) and p < abs(0.5*s*q) then
                      // interpolation successful
                      d := p/q;
                    else
                      // use bi-section
                      e := m;
                      d := e;
                    end if;
                  end if;

                  // Best guess value is defined as "a"
                  a := b;
                  fa := fb;
                  b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
                  fb := residue(aa,bb,ww,b);

                  if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
                    // initialize variables
                    c := a;
                    fc := fa;
                    e := b - a;
                    d := e;
                  end if;
                end if;
              end while;

              annotation (Documentation(info="<html>

<p>
This function determines the solution of <b>one non-linear algebraic equation</b> \"y=f(u)\"
in <b>one unknown</b> \"u\" in a reliable way. It is one of the best numerical
algorithms for this purpose. As input, the nonlinear function f(u)
has to be given, as well as an interval u_min, u_max that
contains the solution, i.e., \"f(u_min)\" and \"f(u_max)\" must
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

</html>"));
            end solveOneNonlinearEquation;

            algorithm
              assert( a^2/4 - b <= 0,  "Band pass transformation cannot be computed");
              z :=solveOneNonlinearEquation(a, b, w, 0, 1);
              alpha := sqrt(z);

              annotation (Documentation(info="<html>
<p>
A band pass with bandwidth \"w\" is determined from a low pass
</p>

<pre>
  1/(p^2 + a*p + b)
</pre>

<p>
with the transformation
</p>

<pre>
  new(p) = (p + 1/p)/w
</pre>

<p>
This results in the following derivation:
</p>

<pre>
  1/(p^2 + a*p + b) -> 1/( (p+1/p)^2/w^2 + a*(p + 1/p)/w + b )
                     = 1 / ( p^2 + 1/p^2 + 2)/w^2 + (p + 1/p)*a/w + b )
                     = w^2*p^2 / (p^4 + 2*p^2 + 1 + (p^3 + p)a*w + b*w^2*p^2)
                     = w^2*p^2 / (p^4 + a*w*p^3 + (2+b*w^2)*p^2 + a*w*p + 1)
</pre>

<p>
This 4th order transfer function shall be split in to two transfer functions of order 2 each
for numerical reasons. With the following formulation, the fourth order
polynomial can be represented (with the unknowns \"c\" and \"alpha\"):
</p>

<pre>
  g(p) = w^2*p^2 / ( (p*alpha)^2 + c*(p*alpha) + 1) * (p/alpha)^2 + c*(p/alpha) + 1)
       = w^2*p^2 / ( p^4 + c*(alpha + 1/alpha)*p^3 + (alpha^2 + 1/alpha^2 + c^2)*p^2
                                                   + c*(alpha + 1/alpha)*p + 1 )
</pre>

<p>
Comparison of coefficients:
</p>

<pre>
  c*(alpha + 1/alpha) = a*w           -> c = a*w / (alpha + 1/alpha)
  alpha^2 + 1/alpha^2 + c^2 = 2+b*w^2 -> equation to determine alpha

  alpha^4 + 1 + a^2*w^2*alpha^4/(1+alpha^2)^2 = (2+b*w^2)*alpha^2
    or z = alpha^2
  z^2 + a^2*w^2*z^2/(1+z)^2 - (2+b*w^2)*z + 1 = 0
</pre>

<p>
Therefore the last equation has to be solved for \"z\" (basically, this means to compute
a real zero of a fourth order polynomal):
</p>

<pre>
   solve: 0 = f(z)  = z^2 + a^2*w^2*z^2/(1+z)^2 - (2+b*w^2)*z + 1  for \"z\"
              f(0)  = 1  &gt; 0
              f(1)  = 1 + a^2*w^2/4 - (2+b*w^2) + 1
                    = (a^2/4 - b)*w^2  &lt; 0
                    // since b - a^2/4 > 0 requirement for complex conjugate poles
   -> 0 &lt; z &lt; 1
</pre>

<p>
This function computes the solution of this equation and returns \"alpha = sqrt(z)\";
</p>

</html>"));
            end bandPassAlpha;
          end Utilities;
        end Filter;
      end Internal;
      annotation (
        Documentation(info="<html>
<p>
This package contains basic <b>continuous</b> input/output blocks
described by differential equations.
</p>

<p>
All blocks of this package can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>

  <tr><td valign=\"top\"><b>Init.NoInit</b></td>
      <td valign=\"top\">no initialization (start values are used as guess values with fixed=false)</td></tr>

  <tr><td valign=\"top\"><b>Init.SteadyState</b></td>
      <td valign=\"top\">steady state initialization (derivatives of states are zero)</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialState</b></td>
      <td valign=\"top\">Initialization with initial states</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialOutput</b></td>
      <td valign=\"top\">Initialization with initial outputs (and steady state of the states if possibles)</td></tr>
</table>

<p>
For backward compatibility reasons the default of all blocks is
<b>Init.NoInit</b>, with the exception of Integrator and LimIntegrator
where the default is <b>Init.InitialState</b> (this was the initialization
defined in version 2.2 of the Modelica standard library).
</p>

<p>
In many cases, the most useful initial condition is
<b>Init.SteadyState</b> because initial transients are then no longer
present. The drawback is that in combination with a non-linear
plant, non-linear algebraic equations occur that might be
difficult to solve if appropriate guess values for the
iteration variables are not provided (i.e., start values with fixed=false).
However, it is often already useful to just initialize
the linear blocks from the Continuous blocks library in SteadyState.
This is uncritical, because only linear algebraic equations occur.
If Init.NoInit is set, then the start values for the states are
interpreted as <b>guess</b> values and are propagated to the
states with fixed=<b>false</b>.
</p>

<p>
Note, initialization with Init.SteadyState is usually difficult
for a block that contains an integrator
(Integrator, LimIntegrator, PI, PID, LimPID).
This is due to the basic equation of an integrator:
</p>

<pre>
  <b>initial equation</b>
     <b>der</b>(y) = 0;   // Init.SteadyState
  <b>equation</b>
     <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation leads to the condition that the input to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is always defined by
Init.InitialState or Init.SteadyState initializtion.
</p>

<p>
In such a case, <b>Init.NoInit</b> has to be selected for the integrator
and an additional initial equation has to be added to the system
to which the integrator is connected. E.g., useful initial conditions
for a 1-dim. rotational inertia controlled by a PI controller are that
<b>angle</b>, <b>speed</b>, and <b>acceleration</b> of the inertia are zero.
</p>

</html>
"));
    end Continuous;

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

        partial block SO "Single Output continuous control block"
          extends BlockIcon;

          RealOutput y "Connector of Real output signal"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
          annotation (
            Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics),
          Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"));

        end SO;

        partial block SISO
        "Single Input Single Output continuous control block"
          extends BlockIcon;

          RealInput u "Connector of Real input signal"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
                rotation=0)));
          RealOutput y "Connector of Real output signal"
            annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));
          annotation (
          Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
        end SISO;

        partial block SignalSource "Base class for continuous signal source"
          extends SO;
          parameter Real offset=0 "Offset of output signal y";
          parameter SIunits.Time startTime=0
          "Output y = offset for time < startTime";
        annotation (Documentation(info="<html>
<p>
Basic block for Real sources of package Blocks.Sources.
This component has one continuous Real output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
        end SignalSource;
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

          block Step "Generate step signal of type Real"
            parameter Real height=1 "Height of step";
            extends Interfaces.SignalSource;

          equation
            y = offset + (if time < startTime then 0 else height);
            annotation (
              Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, color={0,0,0}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="startTime=%startTime")}),
              Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={
              Polygon(
                points={{-80,90},{-86,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(
                points={{-80,-18},{0,-18},{0,50},{80,50}},
                color={0,0,255},
                thickness=0.5),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-64},{68,-76},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{70,-80},{94,-100}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-21,-72},{25,-90}},
                lineColor={0,0,0},
                textString="startTime"),
              Line(points={{0,-17},{0,-71}}, color={95,95,95}),
              Text(
                extent={{-68,-36},{-22,-54}},
                lineColor={0,0,0},
                textString="offset"),
              Line(points={{-13,50},{-13,-17}}, color={95,95,95}),
              Polygon(
                points={{2,50},{-19,50},{2,50}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-13,50},{-16,37},{-9,37},{-13,50}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-68,26},{-22,8}},
                lineColor={0,0,0},
                textString="height"),
              Polygon(
                points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-13,-18},{-13,-70}}, color={95,95,95}),
              Polygon(
                points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-72,100},{-31,80}},
                lineColor={0,0,0},
                textString="y")}),
          Documentation(info="<html>
<p>
The Real output y is a step signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Step.png\">
</p>

</html>"));
          end Step;
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

    package Types
      "Library of constants and types with choices, especially to build menus"
      extends Modelica.Icons.Package;

      type Init = enumeration(
          NoInit
            "No initialization (start values are used as guess values with fixed=false)",

          SteadyState
            "Steady state initialization (derivatives of states are zero)",
          InitialState "Initialization with initial states",
          InitialOutput
            "Initialization with initial outputs (and steady state of the states if possibles)")
        "Enumeration defining initialization of a block"
          annotation (Evaluate=true);

    type AnalogFilter = enumeration(
          CriticalDamping "Filter with critical damping",
          Bessel "Bessel filter",
          Butterworth "Butterworth filter",
          ChebyshevI "Chebyshev I filter")
        "Enumeration defining the method of filtering"
          annotation (Evaluate=true);

    type FilterType = enumeration(
          LowPass "Low pass filter",
          HighPass "High pass filter",
          BandPass "Band pass filter",
          BandStop "Band stop / notch filter")
        "Enumeration of analog filter types (low, high, band pass or band stop filter"
        annotation (Evaluate=true);
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

  package Fluid
    "Library of 1-dim. thermo-fluid flow models using the Modelica.Media media description"
    extends Modelica.Icons.Package;
    import SI = Modelica.SIunits;

    model System
      "System properties and default values (ambient, flow direction, initialization)"

      package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium model for default start values"
          annotation (choicesAllMatching = true);
      parameter Modelica.SIunits.AbsolutePressure p_ambient=101325
        "Default ambient pressure"
        annotation(Dialog(group="Environment"));
      parameter Modelica.SIunits.Temperature T_ambient=293.15
        "Default ambient temperature"
        annotation(Dialog(group="Environment"));
      parameter Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
        "Constant gravity acceleration"
        annotation(Dialog(group="Environment"));

      // Assumptions
      parameter Boolean allowFlowReversal = true
        "= false to restrict to design flow direction (port_a -> port_b)"
        annotation(Dialog(tab="Assumptions"), Evaluate=true);
      parameter Modelica.Fluid.Types.Dynamics energyDynamics=
        Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
        "Default formulation of energy balances"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      parameter Modelica.Fluid.Types.Dynamics massDynamics=
        energyDynamics "Default formulation of mass balances"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      final parameter Modelica.Fluid.Types.Dynamics substanceDynamics=
        massDynamics "Default formulation of substance balances"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      final parameter Modelica.Fluid.Types.Dynamics traceDynamics=
        massDynamics "Default formulation of trace substance balances"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
      parameter Modelica.Fluid.Types.Dynamics momentumDynamics=
        Modelica.Fluid.Types.Dynamics.SteadyState
        "Default formulation of momentum balances, if options available"
        annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

      // Initialization
      parameter Modelica.SIunits.MassFlowRate m_flow_start = 0
        "Default start value for mass flow rates"
        annotation(Dialog(tab = "Initialization"));
      parameter Modelica.SIunits.AbsolutePressure p_start = p_ambient
        "Default start value for pressures"
        annotation(Dialog(tab = "Initialization"));
      parameter Modelica.SIunits.Temperature T_start = T_ambient
        "Default start value for temperatures"
        annotation(Dialog(tab = "Initialization"));

      // Advanced
      parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 0.01
        "Default small laminar mass flow rate for regularization of zero flow"
        annotation(Dialog(tab = "Advanced"));
      parameter Modelica.SIunits.AbsolutePressure dp_small(min=0) = 1
        "Default small pressure drop for regularization of laminar and zero flow"
        annotation(Dialog(tab="Advanced"));

      annotation (
        defaultComponentName="system",
        defaultComponentPrefixes="inner",
        missingInnerMessage="
Your model is using an outer \"system\" component but
an inner \"system\" component is not defined.
For simulation drag Modelica.Fluid.System into your model
to specify system properties. The default System setting
is used for the current simulation.
",      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{-86,-30},{82,-30}}, color={0,0,0}),
            Line(points={{-82,-68},{-52,-30}}, color={0,0,0}),
            Line(points={{-48,-68},{-18,-30}}, color={0,0,0}),
            Line(points={{-14,-68},{16,-30}}, color={0,0,0}),
            Line(points={{22,-68},{52,-30}}, color={0,0,0}),
            Line(points={{74,84},{74,14}}, color={0,0,0}),
            Polygon(
              points={{60,14},{88,14},{74,-18},{60,14}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{16,20},{60,-18}},
              lineColor={0,0,0},
              textString="g"),
            Text(
              extent={{-90,82},{74,50}},
              lineColor={0,0,0},
              textString="defaults"),
            Line(
              points={{-82,14},{-42,-20},{2,30}},
              color={0,0,0},
              thickness=0.5),
            Ellipse(
              extent={{-10,40},{12,18}},
              pattern=LinePattern.None,
              lineColor={0,0,0},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}),
                graphics),
        Documentation(info="<html>
<p>
 A system component is needed in each fluid model to provide system-wide settings, such as ambient conditions and overall modeling assumptions.
 The system settings are propagated to the fluid models using the inner/outer mechanism.
</p>
<p>
 A model should never directly use system parameters.
 Instead a local parameter should be declared, which uses the global setting as default.
 The only exception currently made is the gravity system.g.
</p>
</html>"));

    end System;

    package Valves "Components for the regulation and control of fluid flow"
        extends Modelica.Icons.VariantsPackage;

      model ValveCompressible
        "Valve for compressible fluids, accounts for choked flow conditions"
        extends BaseClasses.PartialValve;
        import Modelica.Fluid.Types.CvTypes;
        parameter Medium.AbsolutePressure p_nominal "Nominal inlet pressure"
        annotation(Dialog(group="Nominal operating point"));
        parameter Real Fxt_full=0.5 "Fk*xt critical ratio at full opening";
        replaceable function xtCharacteristic =
            Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.one
          constrainedby
          Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
          "Critical ratio characteristic";
        Real Fxt;
        Real x "Pressure drop ratio";
        Real xs "Saturated pressure drop ratio";
        Real Y "Compressibility factor";
        Medium.AbsolutePressure p "Inlet pressure";
      protected
        parameter Real Fxt_nominal(fixed=false) "Nominal Fxt";
        parameter Real x_nominal(fixed=false) "Nominal pressure drop ratio";
        parameter Real xs_nominal(fixed=false)
          "Nominal saturated pressure drop ratio";
        parameter Real Y_nominal(fixed=false) "Nominal compressibility factor";

      initial equation
        if CvData == CvTypes.OpPoint then
          // Determination of Av by the nominal operating point conditions
          Fxt_nominal = Fxt_full*xtCharacteristic(opening_nominal);
          x_nominal = dp_nominal/p_nominal;
          xs_nominal = smooth(0, if x_nominal > Fxt_nominal then Fxt_nominal else x_nominal);
          Y_nominal = 1 - abs(xs_nominal)/(3*Fxt_nominal);
          m_flow_nominal = valveCharacteristic(opening_nominal)*Av*Y_nominal*sqrt(rho_nominal)*Utilities.regRoot(p_nominal*xs_nominal, dp_small);
        else
          // Dummy values
          Fxt_nominal = 0;
          x_nominal = 0;
          xs_nominal = 0;
          Y_nominal = 0;
        end if;

      equation
        p = noEvent(if dp>=0 then port_a.p else port_b.p);
        Fxt = Fxt_full*xtCharacteristic(opening_actual);
        x = dp/p;
        xs = smooth(0, if x < -Fxt then -Fxt else if x > Fxt then Fxt else x);
        Y = 1 - abs(xs)/(3*Fxt);
        // m_flow = valveCharacteristic(opening)*Av*Y*sqrt(d)*sqrt(p*xs);
        if checkValve then
          m_flow = valveCharacteristic(opening_actual)*Av*Y*sqrt(Medium.density(state_a))*
            (if xs>=0 then Utilities.regRoot(p*xs, dp_small) else 0);
        elseif not allowFlowReversal then
          m_flow = valveCharacteristic(opening_actual)*Av*sqrt(Medium.density(state_a))*
                        Utilities.regRoot(p*xs, dp_small);
        else
          m_flow = valveCharacteristic(opening_actual)*Av*Y*
            smooth(0, Utilities.regRoot(p*xs, dp_small)*(if xs>=0 then sqrt(Medium.density(state_a)) else sqrt(Medium.density(state_b))));
      /*
    m_flow = valveCharacteristic(opening)*Av*Y*
                  Modelica.Fluid.Utilities.regRoot2(p*xs, dp_small, Medium.density(state_a), Medium.density(state_b));
*/
        end if;

        annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
             graphics),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}),
                graphics),
        Documentation(info="<HTML>
<p>Valve model according to the IEC 534/ISA S.75 standards for valve sizing, compressible fluid, no phase change, also covering choked-flow conditions.</p>

<p>
The parameters of this model are explained in detail in
<a href=\"modelica://Modelica.Fluid.Valves.BaseClasses.PartialValve\">PartialValve</a>
(the base model for valves).
</p>

<p>This model can be used with gases and vapours, with arbitrary pressure ratio between inlet and outlet.</p>

<p>The product Fk*xt is given by the parameter <code>Fxt_full</code>, and is assumed constant by default. The relative change (per unit) of the xt coefficient with the valve opening can be specified by replacing the <code>xtCharacteristic</code> function.
<p>If <code>checkValve</code> is false, the valve supports reverse flow, with a symmetric flow characteric curve. Otherwise, reverse flow is stopped (check valve behaviour).</p>

<p>
The treatment of parameters <b>Kv</b> and <b>Cv</b> is
explained in detail in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a>.
</p>

</HTML>", revisions="<html>
<ul>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));
      end ValveCompressible;

      package BaseClasses
        "Base classes used in the Valves package (only of interest to build new component models)"
        extends Modelica.Icons.BasesPackage;

        partial model PartialValve "Base model for valves"

          import Modelica.Fluid.Types.CvTypes;
          extends Modelica.Fluid.Interfaces.PartialTwoPortTransport(
            dp_start = dp_nominal,
            m_flow_start = m_flow_nominal,
            m_flow_small = system.m_flow_small);

          parameter Modelica.Fluid.Types.CvTypes CvData=Modelica.Fluid.Types.CvTypes.OpPoint
            "Selection of flow coefficient"
           annotation(Dialog(group = "Flow Coefficient"));
          parameter SI.Area Av(
            fixed=if CvData == Modelica.Fluid.Types.CvTypes.Av then true else false,
            start=m_flow_nominal/(sqrt(rho_nominal*dp_nominal))*valveCharacteristic(
                opening_nominal)) "Av (metric) flow coefficient"
           annotation(Dialog(group = "Flow Coefficient",
                             enable = (CvData==Modelica.Fluid.Types.CvTypes.Av)));
          parameter Real Kv = 0 "Kv (metric) flow coefficient [m3/h]"
          annotation(Dialog(group = "Flow Coefficient",
                            enable = (CvData==Modelica.Fluid.Types.CvTypes.Kv)));
          parameter Real Cv = 0 "Cv (US) flow coefficient [USG/min]"
          annotation(Dialog(group = "Flow Coefficient",
                            enable = (CvData==Modelica.Fluid.Types.CvTypes.Cv)));
          parameter SI.Pressure dp_nominal "Nominal pressure drop"
          annotation(Dialog(group="Nominal operating point"));
          parameter Medium.MassFlowRate m_flow_nominal "Nominal mass flowrate"
          annotation(Dialog(group="Nominal operating point"));
          parameter Medium.Density rho_nominal=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
            "Nominal inlet density"
          annotation(Dialog(group="Nominal operating point",
                            enable = (CvData==Modelica.Fluid.Types.CvTypes.OpPoint)));
          parameter Real opening_nominal(min=0,max=1)=1 "Nominal opening"
          annotation(Dialog(group="Nominal operating point",
                            enable = (CvData==Modelica.Fluid.Types.CvTypes.OpPoint)));

          parameter Boolean filteredOpening=false
            "= true, if opening is filtered with a 2nd order CriticalDamping filter"
            annotation(Dialog(group="Filtered opening"),choices(__Dymola_checkBox=true));
          parameter Modelica.SIunits.Time riseTime=1
            "Rise time of the filter (time to reach 99.6 % of an opening step)"
            annotation(Dialog(group="Filtered opening",enable=filteredOpening));
          parameter Real leakageOpening(min=0,max=1)=1e-3
            "The opening signal is limited by leakageOpening (to improve the numerics)"
            annotation(Dialog(group="Filtered opening",enable=filteredOpening));
          parameter Boolean checkValve=false "Reverse flow stopped"
            annotation(Dialog(tab="Assumptions"));

          replaceable function valveCharacteristic =
              Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.linear
            constrainedby
            Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
            "Inherent flow characteristic"
            annotation(choicesAllMatching=true);

          parameter SI.Pressure dp_small=system.dp_small
            "Regularisation of zero flow"                 annotation(Dialog(tab="Advanced"));

          constant SI.Area Kv2Av = 27.7e-6 "Conversion factor";
          constant SI.Area Cv2Av = 24.0e-6 "Conversion factor";

          Modelica.Blocks.Interfaces.RealInput opening(min=0, max=1)
            "Valve position in the range 0..1"
                                           annotation (Placement(transformation(
                origin={0,90},
                extent={{-20,-20},{20,20}},
                rotation=270), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={0,80})));

          Modelica.Blocks.Interfaces.RealOutput opening_filtered if filteredOpening
            "Filtered valve position in the range 0..1"
            annotation (Placement(transformation(extent={{60,40},{80,60}}),
                iconTransformation(extent={{60,50},{80,70}})));

          Modelica.Blocks.Continuous.Filter filter(order=2, f_cut=5/(2*Modelica.Constants.pi
                *riseTime)) if filteredOpening
            annotation (Placement(transformation(extent={{34,44},{48,58}})));

        protected
          Modelica.Blocks.Interfaces.RealOutput opening_actual
            annotation (Placement(transformation(extent={{60,10},{80,30}})));

        block MinLimiter "Limit the signal above a threshold"
         parameter Real uMin=0 "Lower limit of input signal";
          extends Modelica.Blocks.Interfaces.SISO;

        equation
          y = smooth(0, noEvent( if u < uMin then uMin else u));
          annotation (
            Documentation(info="<HTML>
<p>
The block passes its input signal as output signal
as long as the input is above uMin. If this is not the case, 
y=uMin is passed as output.
</p>
</HTML>
"),         Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(points={{0,-90},{0,68}}, color={192,192,192}),
            Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{68,0}}, color={192,192,192}),
            Polygon(
              points={{90,0},{68,-8},{68,8},{90,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-70},{-50,-70},{50,70},{64,90}}, color={0,0,0}),
            Text(
              extent={{-150,-150},{150,-110}},
              lineColor={0,0,0},
                    textString="uMin=%uMin"),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
            Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Line(points={{0,-60},{0,50}}, color={192,192,192}),
            Polygon(
              points={{0,60},{-5,50},{5,50},{0,60}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-60,0},{50,0}}, color={192,192,192}),
            Polygon(
              points={{60,0},{50,-5},{50,5},{60,0}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}, color={0,0,0}),
            Text(
              extent={{46,-6},{68,-18}},
              lineColor={128,128,128},
              textString="u"),
            Text(
              extent={{-30,70},{-5,50}},
              lineColor={128,128,128},
              textString="y"),
            Text(
              extent={{-58,-54},{-28,-42}},
              lineColor={128,128,128},
              textString="uMin"),
            Text(
              extent={{26,40},{66,56}},
              lineColor={128,128,128},
              textString="uMax")}),
            uses(Modelica(version="3.2")));
        end MinLimiter;

          MinLimiter minLimiter(uMin=leakageOpening)
            annotation (Placement(transformation(extent={{10,44},{24,58}})));
        initial equation
          if CvData == CvTypes.Kv then
            Av = Kv*Kv2Av "Unit conversion";
          elseif CvData == CvTypes.Cv then
            Av = Cv*Cv2Av "Unit conversion";
          end if;

        equation
          // Isenthalpic state transformation (no storage and no loss of energy)
          port_a.h_outflow = inStream(port_b.h_outflow);
          port_b.h_outflow = inStream(port_a.h_outflow);

          connect(filter.y, opening_filtered) annotation (Line(
              points={{48.7,51},{60,51},{60,50},{70,50}},
              color={0,0,127},
              smooth=Smooth.None));

          if filteredOpening then
             connect(filter.y, opening_actual);
          else
             connect(opening, opening_actual);
          end if;

          connect(minLimiter.y, filter.u) annotation (Line(
              points={{24.7,51},{32.6,51}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(minLimiter.u, opening) annotation (Line(
              points={{8.6,51},{0,51},{0,90}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Line(points={{0,52},{0,0}}, color={0,0,0}),
                Rectangle(
                  extent={{-20,60},{20,52}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{
                      -100,0}}, {{-100,50*opening_actual},{-100,50*opening_actual},{100,-50*
                      opening},{100,50*opening_actual},{0,0},{-100,-50*opening_actual},{-100,50*
                      opening}}),
                  fillColor={0,255,0},
                  lineColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
                      50}}, lineColor={0,0,0}),
                Ellipse(visible=filteredOpening,
                  extent={{-40,94},{40,14}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(visible=filteredOpening,
                  points={{-20,25},{-20,63},{0,41},{20,63},{20,25}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=0.5),
                Line(visible=filteredOpening,
                  points={{40,60},{60,60}},
                  color={0,0,127},
                  smooth=Smooth.None)}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics),
            Documentation(info="<HTML>
<p>This is the base model for the <code>ValveIncompressible</code>, <code>ValveVaporizing</code>, and <code>ValveCompressible</code> valve models. The model is based on the IEC 534 / ISA S.75 standards for valve sizing.</p>
<p>The model optionally supports reverse flow conditions (assuming symmetrical behaviour) or check valve operation, and has been suitably regularized, compared to the equations in the standard, in order to avoid numerical singularities around zero pressure drop operating conditions.</p>
<p>The model assumes adiabatic operation (no heat losses to the ambient); changes in kinetic energy
from inlet to outlet are neglected in the energy balance.</p>
<p><b>Modelling options</b></p>
<p>The following options are available to specify the valve flow coefficient in fully open conditions:
<ul><li><code>CvData = Modelica.Fluid.Types.CvTypes.Av</code>: the flow coefficient is given by the metric <code>Av</code> coefficient (m^2).
<li><code>CvData = Modelica.Fluid.Types.CvTypes.Kv</code>: the flow coefficient is given by the metric <code>Kv</code> coefficient (m^3/h).
<li><code>CvData = Modelica.Fluid.Types.CvTypes.Cv</code>: the flow coefficient is given by the US <code>Cv</code> coefficient (USG/min).
<li><code>CvData = Modelica.Fluid.Types.CvTypes.OpPoint</code>: the flow is computed from the nominal operating point specified by <code>p_nominal</code>, <code>dp_nominal</code>, <code>m_flow_nominal</code>, <code>rho_nominal</code>, <code>opening_nominal</code>.
</ul>
<p>The nominal pressure drop <code>dp_nominal</code> must always be specified; to avoid numerical singularities, the flow characteristic is modified for pressure drops less than <code>b*dp_nominal</code> (the default value is 1% of the nominal pressure drop). Increase this parameter if numerical problems occur in valves with very low pressure drops.
<p>If <code>checkValve</code> is true, then the flow is stopped when the outlet pressure is higher than the inlet pressure; otherwise, reverse flow takes place. Use this option only when neede, as it increases the numerical complexity of the problem.
<p>The valve opening characteristic <code>valveCharacteristic</code>, linear by default, can be replaced by any user-defined function. Quadratic and equal percentage with customizable rangeability are already provided by the library. The characteristics for constant port_a.p and port_b.p pressures with continuously changing opening are shown in the next two figures:
</p>

<blockquote>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/ValveCharacteristics1a.png\">
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/ValveCharacteristics1b.png\">
</p>
</blockquote>

<p>
The treatment of parameters <b>Kv</b> and <b>Cv</b> is
explained in detail in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">User's Guide</a>.
</p>

<p>
With the optional parameter \"filteredOpening\", the opening can be filtered with a 
<b>second order, criticalDamping</b> filter so that the
opening demand is delayed by parameter \"riseTime\". The filtered opening is then available
via the output signal \"opening_filtered\" and is used to control the valve equations.
This approach approximates the driving device of a valve. The \"riseTime\" parameter 
is used to compute the cut-off frequency of the filter by the equation: f_cut = 5/(2*pi*riseTime). 
It defines the time that is needed until opening_filtered reaches 99.6 % of
a step input of opening. The icon of a valve changes in the following way 
(left image: filteredOpening=false, right image: filteredOpening=true):
</p>

<blockquote>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/FilteredValveIcon.png\">
</p>
</blockquote>

<p>
If \"filteredOpening = <b>true</b>\", the input signal \"opening\" is limited
by parameter <b>leackageOpening</b>, i.e., if \"opening\" becomes smaller as
\"leakageOpening\", then \"leakageOpening\" is used instead of \"opening\" as input
for the filter. The reason is that \"opening=0\" might structurally change the equations of the
fluid network leading to a singularity. If a small leakage flow is introduced
(which is often anyway present in reality), the singularity might be avoided.
</p>

<p>
In the next figure, \"opening\" and \"filtered_opening\" are shown in the case that
filteredOpening = <b>true</b>, riseTime = 1 s, and leackageOpening = 0.02.
</p>

<blockquote>
<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Components/ValveFilteredOpening.png\">
</p>
</blockquote>

</HTML>",     revisions="<html>
<ul>
<li><i>Sept. 5, 2010</i>
    by <a href=\"mailto:martin.otter@dlr.de\">Martin Otter</a>:<br>
    Optional filtering of opening introduced, based on a proposal
    from Mike Barth (Universitaet der Bundeswehr Hamburg) +
    Documentation improved.</li>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted from the ThermoPower library.</li>
</ul>
</html>"));
        end PartialValve;

      package ValveCharacteristics "Functions for valve characteristics"
        extends Modelica.Icons.VariantsPackage;

        partial function baseFun "Base class for valve characteristics"
          extends Modelica.Icons.Function;
          input Real pos(min=0, max=1)
              "Opening position (0: closed, 1: fully open)";
          output Real rc "Relative flow coefficient (per unit)";
          annotation (Documentation(info="<html>
<p>
This is a partial function that defines the interface of valve
characteristics. The function returns \"rc = valveCharacteristic\" as function of the
opening \"pos\" (in the range 0..1):
</p>

<blockquote><pre>
    dp = (zeta_TOT/2) * rho * velocity^2
m_flow =    sqrt(2/zeta_TOT) * Av * sqrt(rho * dp)
m_flow = valveCharacteristic * Av * sqrt(rho * dp)
m_flow =                  rc * Av * sqrt(rho * dp)
</pre></blockquote>

</html>"));
        end baseFun;

        function linear "Linear characteristic"
          extends baseFun;
        algorithm
          rc := pos;
        end linear;

        function one "Constant characteristic"
          extends baseFun;
        algorithm
          rc := 1;
        end one;
      end ValveCharacteristics;
      end BaseClasses;
      annotation (Documentation(info="<html>

</html>"));
    end Valves;

    package Sources "Define fixed or prescribed boundary conditions"
      extends Modelica.Icons.SourcesPackage;

      model FixedBoundary "Boundary source component"
        import Modelica.Media.Interfaces.PartialMedium.Choices.IndependentVariables;
        extends Sources.BaseClasses.PartialSource;
        parameter Boolean use_p=true "select p or d"
          annotation (Evaluate = true,
                      Dialog(group = "Boundary pressure or Boundary density"));
        parameter Medium.AbsolutePressure p=Medium.p_default
          "Boundary pressure"
          annotation (Dialog(group = "Boundary pressure or Boundary density",
                             enable = use_p));
        parameter Medium.Density d=Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default)
          "Boundary density"
          annotation (Dialog(group = "Boundary pressure or Boundary density",
                             enable=not use_p));
        parameter Boolean use_T=true "select T or h"
          annotation (Evaluate = true,
                      Dialog(group = "Boundary temperature or Boundary specific enthalpy"));
        parameter Medium.Temperature T=Medium.T_default "Boundary temperature"
          annotation (Dialog(group = "Boundary temperature or Boundary specific enthalpy",
                             enable = use_T));
        parameter Medium.SpecificEnthalpy h=Medium.h_default
          "Boundary specific enthalpy"
          annotation (Dialog(group="Boundary temperature or Boundary specific enthalpy",
                      enable = not use_T));
        parameter Medium.MassFraction X[Medium.nX](
             quantity=Medium.substanceNames)=Medium.X_default
          "Boundary mass fractions m_i/m"
          annotation (Dialog(group = "Only for multi-substance flow", enable=Medium.nXi > 0));

        parameter Medium.ExtraProperty C[Medium.nC](
             quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
          "Boundary trace substances"
          annotation (Dialog(group = "Only for trace-substance flow", enable=Medium.nC > 0));
      protected
        Medium.ThermodynamicState state;
      equation
        Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
                                              Medium.singleState, use_p, X,
                                              "FixedBoundary");
        if use_p or Medium.singleState then
           // p given
           if use_T then
              // p,T,X given
              state = Medium.setState_pTX(p, T, X);
           else
              // p,h,X given
              state = Medium.setState_phX(p, h, X);
           end if;

           if Medium.ThermoStates == IndependentVariables.dTX then
              medium.d = Medium.density(state);
           else
              medium.p = Medium.pressure(state);
           end if;

           if Medium.ThermoStates == IndependentVariables.ph or
              Medium.ThermoStates == IndependentVariables.phX then
              medium.h = Medium.specificEnthalpy(state);
           else
              medium.T = Medium.temperature(state);
           end if;

        else
           // d given
           if use_T then
              // d,T,X given
              state = Medium.setState_dTX(d, T, X);

              if Medium.ThermoStates == IndependentVariables.dTX then
                 medium.d = Medium.density(state);
              else
                 medium.p = Medium.pressure(state);
              end if;

              if Medium.ThermoStates == IndependentVariables.ph or
                 Medium.ThermoStates == IndependentVariables.phX then
                 medium.h = Medium.specificEnthalpy(state);
              else
                 medium.T = Medium.temperature(state);
              end if;

           else
              // d,h,X given
              medium.d = d;
              medium.h = h;
              state = Medium.setState_dTX(d,T,X);
           end if;
        end if;

        medium.Xi = X[1:Medium.nXi];

        ports.C_outflow = fill(C, nPorts);
        annotation (defaultComponentName="boundary",
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={0,127,255}), Text(
                extent={{-150,110},{150,150}},
                textString="%name",
                lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Model <b>FixedBoundary</b> defines constant values for boundary conditions:
</p>
<ul>
<li> Boundary pressure or boundary density.</li>
<li> Boundary temperature or boundary specific enthalpy.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>
Note, that boundary temperature, density, specific enthalpy,
mass fractions and trace substances have only an effect if the mass flow
is from the Boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>"));
      end FixedBoundary;

      package BaseClasses
        "Base classes used in the Sources package (only of interest to build new component models)"
        extends Modelica.Icons.BasesPackage;

      partial model PartialSource
          "Partial component source with one fluid connector"
          import Modelica.Constants;

        parameter Integer nPorts=0 "Number of ports" annotation(Dialog(connectorSizing=true));

        replaceable package Medium =
            Modelica.Media.Interfaces.PartialMedium
            "Medium model within the source"
           annotation (choicesAllMatching=true);

        Medium.BaseProperties medium "Medium in the source";

        Interfaces.FluidPorts_b ports[nPorts](
                           redeclare each package Medium = Medium,
                           m_flow(each max=if flowDirection==Types.PortFlowDirection.Leaving then 0 else
                                           +Constants.inf,
                                  each min=if flowDirection==Types.PortFlowDirection.Entering then 0 else
                                           -Constants.inf))
          annotation (Placement(transformation(extent={{90,40},{110,-40}})));
        protected
        parameter Types.PortFlowDirection flowDirection=
                         Types.PortFlowDirection.Bidirectional
            "Allowed flow direction"             annotation(Evaluate=true, Dialog(tab="Advanced"));
      equation
        // Only one connection allowed to a port to avoid unwanted ideal mixing
        for i in 1:nPorts loop
          assert(cardinality(ports[i]) <= 1,"
each ports[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");

           ports[i].p          = medium.p;
           ports[i].h_outflow  = medium.h;
           ports[i].Xi_outflow = medium.Xi;
        end for;

        annotation (defaultComponentName="boundary", Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= ports.p) is identical to the
     pressure in the volume.</li>
<li> The outflow enthalpy rate (= port.h_outflow) and the composition of the
     substances (= port.Xi_outflow) are identical to the respective values in the volume.</li>
</ul>
</html>"),       Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                    -100},{100,100}}),
                               graphics),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics));
      end PartialSource;
      end BaseClasses;
      annotation (Documentation(info="<html>
<p>
Package <b>Sources</b> contains generic sources for fluid connectors
to define fixed or prescribed ambient conditions.
</p>
</html>"));
    end Sources;

    package Interfaces
      "Interfaces for steady state and unsteady, mixed-phase, multi-substance, incompressible and compressible flow"
      extends Modelica.Icons.InterfacesPackage;

      connector FluidPort
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model" annotation (choicesAllMatching=true);

        flow Medium.MassFlowRate m_flow
          "Mass flow rate from the connection point into the component";
        Medium.AbsolutePressure p
          "Thermodynamic pressure in the connection point";
        stream Medium.SpecificEnthalpy h_outflow
          "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
        stream Medium.MassFraction Xi_outflow[Medium.nXi]
          "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
        stream Medium.ExtraProperty C_outflow[Medium.nC]
          "Properties c_i/m close to the connection point if m_flow < 0";
      end FluidPort;

      connector FluidPort_a "Generic fluid connector at design inlet"
        extends FluidPort;
        annotation (defaultComponentName="port_a",
                    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                extent={{-40,40},{40,-40}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
                  textString="%name")}),
             Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid), Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid)}));
      end FluidPort_a;

      connector FluidPort_b "Generic fluid connector at design outlet"
        extends FluidPort;
        annotation (defaultComponentName="port_b",
                    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-40,40},{40,-40}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,30},{30,-30}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(extent={{-150,110},{150,50}}, textString="%name")}),
             Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,127,255},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end FluidPort_b;

      connector FluidPorts_b
        "Fluid connector with outlined, large icon to be used for vectors of FluidPorts (vector dimensions must be added after dragging)"
        extends FluidPort;
        annotation (defaultComponentName="ports_b",
                    Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-50,-200},{50,200}},
              grid={1,1},
              initialScale=0.2), graphics={
              Text(extent={{-75,130},{75,100}}, textString="%name"),
              Rectangle(
                extent={{-25,100},{25,-100}},
                lineColor={0,0,0}),
              Ellipse(
                extent={{-25,90},{25,40}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-25,25},{25,-25}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-25,-40},{25,-90}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-15,-50},{15,-80}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-15,15},{15,-15}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-15,50},{15,80}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
             Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-50,-200},{50,200}},
              grid={1,1},
              initialScale=0.2), graphics={
              Rectangle(
                extent={{-50,200},{50,-200}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-50,180},{50,80}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-50,50},{50,-50}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-50,-80},{50,-180}},
                lineColor={0,0,0},
                fillColor={0,127,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,30},{30,-30}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,100},{30,160}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-30,-100},{30,-160}},
                lineColor={0,127,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}));
      end FluidPorts_b;

      partial model PartialTwoPort "Partial component with two ports"
        import Modelica.Constants;
        outer Modelica.Fluid.System system "System wide properties";

        replaceable package Medium =
            Modelica.Media.Interfaces.PartialMedium "Medium in the component"
            annotation (choicesAllMatching = true);

        parameter Boolean allowFlowReversal = system.allowFlowReversal
          "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
          annotation(Dialog(tab="Assumptions"), Evaluate=true);

        Modelica.Fluid.Interfaces.FluidPort_a port_a(
                                      redeclare package Medium = Medium,
                           m_flow(min=if allowFlowReversal then -Constants.inf else 0))
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
                  rotation=0)));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(
                                      redeclare package Medium = Medium,
                           m_flow(max=if allowFlowReversal then +Constants.inf else 0))
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=
                   0), iconTransformation(extent={{110,-10},{90,10}})));
        // Model structure, e.g., used for visualization
      protected
        parameter Boolean port_a_exposesState = false
          "= true if port_a exposes the state of a fluid volume";
        parameter Boolean port_b_exposesState = false
          "= true if port_b.p exposes the state of a fluid volume";
        parameter Boolean showDesignFlowDirection = true
          "= false to hide the arrow in the model icon";

        annotation (
          Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics),
          Documentation(info="<html>
<p>
This partial model defines an interface for components with two ports.
The treatment of the design flow direction and of flow reversal are predefined based on the parameter <code><b>allowFlowReversal</b></code>.
The component may transport fluid and may have internal storage for a given fluid <code><b>Medium</b></code>.
</p>
<p>
An extending model providing direct access to internal storage of mass or energy through port_a or port_b
should redefine the protected parameters <code><b>port_a_exposesState</b></code> and <code><b>port_b_exposesState</b></code> appropriately.
This will be visualized at the port icons, in order to improve the understanding of fluid model diagrams.
</p>
</html>"),Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
              Polygon(
                points={{20,-70},{60,-85},{20,-100},{20,-70}},
                lineColor={0,128,255},
                smooth=Smooth.None,
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid,
                visible=showDesignFlowDirection),
              Polygon(
                points={{20,-75},{50,-85},{20,-95},{20,-75}},
                lineColor={255,255,255},
                smooth=Smooth.None,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                visible=allowFlowReversal),
              Line(
                points={{55,-85},{-60,-85}},
                color={0,128,255},
                smooth=Smooth.None,
                visible=showDesignFlowDirection),
              Text(
                extent={{-149,-114},{151,-154}},
                lineColor={0,0,255},
                textString="%name"),
              Ellipse(
                extent={{-110,26},{-90,-24}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                visible=port_a_exposesState),
              Ellipse(
                extent={{90,25},{110,-25}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid,
                visible=port_b_exposesState)}));
      end PartialTwoPort;

    partial model PartialTwoPortTransport
        "Partial element transporting fluid between two ports without storage of mass or energy"

      extends PartialTwoPort(
        final port_a_exposesState=false,
        final port_b_exposesState=false);

      // Advanced
      parameter Medium.AbsolutePressure dp_start = 0.01*system.p_start
          "Guess value of dp = port_a.p - port_b.p"
        annotation(Dialog(tab = "Advanced"));
      parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
          "Guess value of m_flow = port_a.m_flow"
        annotation(Dialog(tab = "Advanced"));
      parameter Medium.MassFlowRate m_flow_small = system.m_flow_small
          "Small mass flow rate for regularization of zero flow"
        annotation(Dialog(tab = "Advanced"));

      // Diagnostics
      parameter Boolean show_T = true
          "= true, if temperatures at port_a and port_b are computed"
        annotation(Dialog(tab="Advanced",group="Diagnostics"));
      parameter Boolean show_V_flow = true
          "= true, if volume flow rate at inflowing port is computed"
        annotation(Dialog(tab="Advanced",group="Diagnostics"));

      // Variables
      Medium.MassFlowRate m_flow(
         min=if allowFlowReversal then -Modelica.Constants.inf else 0,
         start = m_flow_start) "Mass flow rate in design flow direction";
      Modelica.SIunits.Pressure dp(start=dp_start)
          "Pressure difference between port_a and port_b (= port_a.p - port_b.p)";

      Modelica.SIunits.VolumeFlowRate V_flow=
          m_flow/Modelica.Fluid.Utilities.regStep(m_flow,
                      Medium.density(state_a),
                      Medium.density(state_b),
                      m_flow_small) if show_V_flow
          "Volume flow rate at inflowing port (positive when flow from port_a to port_b)";

      Medium.Temperature port_a_T=
          Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                      Medium.temperature(state_a),
                      Medium.temperature(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow)),
                      m_flow_small) if show_T
          "Temperature close to port_a, if show_T = true";
      Medium.Temperature port_b_T=
          Modelica.Fluid.Utilities.regStep(port_b.m_flow,
                      Medium.temperature(state_b),
                      Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow)),
                      m_flow_small) if show_T
          "Temperature close to port_b, if show_T = true";
      protected
      Medium.ThermodynamicState state_a
          "state for medium inflowing through port_a";
      Medium.ThermodynamicState state_b
          "state for medium inflowing through port_b";
    equation
      // medium states
      state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
      state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

      // Pressure drop in design flow direction
      dp = port_a.p - port_b.p;

      // Design direction of mass flow rate
      m_flow = port_a.m_flow;
      assert(m_flow > -m_flow_small or allowFlowReversal, "Reverting flow occurs even though allowFlowReversal is false");

      // Mass balance (no storage)
      port_a.m_flow + port_b.m_flow = 0;

      // Transport of substances
      port_a.Xi_outflow = inStream(port_b.Xi_outflow);
      port_b.Xi_outflow = inStream(port_a.Xi_outflow);

      port_a.C_outflow = inStream(port_b.C_outflow);
      port_b.C_outflow = inStream(port_a.C_outflow);

      annotation (
        Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics),
        Documentation(info="<html>
<p>
This component transports fluid between its two ports, without storing mass or energy.
Energy may be exchanged with the environment though, e.g., in the form of work.
<code>PartialTwoPortTransport</code> is intended as base class for devices like orifices, valves and simple fluid machines.
<p>
Three equations need to be added by an extending class using this component:
</p>
<ul>
<li>the momentum balance specifying the relationship between the pressure drop <code>dp</code> and the mass flow rate <code>m_flow</code></li>,
<li><code>port_b.h_outflow</code> for flow in design direction, and</li>
<li><code>port_a.h_outflow</code> for flow in reverse direction.</li>
</ul>
</html>"),
        Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1})));
    end PartialTwoPortTransport;
      annotation (Documentation(info="<html>

</html>",     revisions="<html>
<ul>
<li><i>June 9th, 2008</i>
       by Michael Sielemann: Introduced stream keyword after decision at 57th Design Meeting (Lund).</li>
<li><i>May 30, 2007</i>
       by Christoph Richter: moved everything back to its original position in Modelica.Fluid.</li>
<li><i>Apr. 20, 2007</i>
       by Christoph Richter: moved parts of the original package from Modelica.Fluid
       to the development branch of Modelica 2.2.2.</li>
<li><i>Nov. 2, 2005</i>
       by Francesco Casella: restructured after 45th Design Meeting.</li>
<li><i>Nov. 20-21, 2002</i>
       by Hilding Elmqvist, Mike Tiller, Allan Watson, John Batteh, Chuck Newman,
       Jonas Eborn: Improved at the 32nd Modelica Design Meeting.
<li><i>Nov. 11, 2002</i>
       by Hilding Elmqvist, Martin Otter: improved version.</li>
<li><i>Nov. 6, 2002</i>
       by Hilding Elmqvist: first version.</li>
<li><i>Aug. 11, 2002</i>
       by Martin Otter: Improved according to discussion with Hilding
       Elmqvist and Hubertus Tummescheit.<br>
       The PortVicinity model is manually
       expanded in the base models.<br>
       The Volume used for components is renamed
       PartialComponentVolume.<br>
       A new volume model \"Fluid.Components.PortVolume\"
       introduced that has the medium properties of the port to which it is
       connected.<br>
       Fluid.Interfaces.PartialTwoPortTransport is a component
       for elementary two port transport elements, whereas PartialTwoPort
       is a component for a container component.</li>
</li>
</ul>
</html>"));
    end Interfaces;

    package Types "Common types for fluid models"
      extends Modelica.Icons.Package;

      type Dynamics = enumeration(
          DynamicFreeInitial
            "DynamicFreeInitial -- Dynamic balance, Initial guess value",
          FixedInitial "FixedInitial -- Dynamic balance, Initial value fixed",
          SteadyStateInitial
            "SteadyStateInitial -- Dynamic balance, Steady state initial with guess value",

          SteadyState
            "SteadyState -- Steady state balance, Initial guess value")
        "Enumeration to define definition of balance equations"
      annotation (Documentation(info="<html>
<p>
Enumeration to define the formulation of balance equations
(to be selected via choices menu):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Dynamics.</b></th><th><b>Meaning</b></th></tr>
<tr><td>DynamicFreeInitial</td><td>Dynamic balance, Initial guess value</td></tr>

<tr><td>FixedInitial</td><td>Dynamic balance, Initial value fixed</td></tr>

<tr><td>SteadyStateInitial</td><td>Dynamic balance, Steady state initial with guess value</td></tr>

<tr><td>SteadyState</td><td>Steady state balance, Initial guess value</td></tr>
</table>

<p>
The enumeration \"Dynamics\" is used for the mass, energy and momentum balance equations
respectively. The exact meaning for the three balance equations is stated in the following
tables:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td colspan=\"3\"><b>Mass balance</b> </td>
<tr><td><b>Dynamics.</b></td>
    <td><b>Balance equation</b></td>
    <td><b>Initial condition</b></td></tr>

<tr><td> DynamicFreeInitial</td>
    <td> no restrictions </td>
    <td> no initial conditions </td></tr>

<tr><td> FixedInitial</td>
    <td> no restrictions </td>
    <td> <b>if</b> Medium.singleState <b>then</b> <br>
         &nbsp;&nbsp;no initial condition<br>
         <b>else</b> p=p_start </td></tr>

<tr><td> SteadyStateInitial</td>
    <td> no restrictions </td>
    <td> <b>if</b> Medium.singleState <b>then</b> <br>
         &nbsp;&nbsp;no initial condition<br>
         <b>else</b> <b>der</b>(p)=0 </td></tr>

<tr><td> SteadyState</td>
    <td> <b>der</b>(m)=0  </td>
    <td> no initial conditions </td></tr>
</table>

&nbsp;<br>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td colspan=\"3\"><b>Energy balance</b> </td>
<tr><td><b>Dynamics.</b></td>
    <td><b>Balance equation</b></td>
    <td><b>Initial condition</b></td></tr>

<tr><td> DynamicFreeInitial</td>
    <td> no restrictions </td>
    <td> no initial conditions </td></tr>

<tr><td> FixedInitial</td>
    <td> no restrictions </td>
    <td> T=T_start or h=h_start </td></tr>

<tr><td> SteadyStateInitial</td>
    <td> no restrictions </td>
    <td> <b>der</b>(T)=0 or <b>der</b>(h)=0 </td></tr>

<tr><td> SteadyState</td>
    <td> <b>der</b>(U)=0  </td>
    <td> no initial conditions </td></tr>
</table>

&nbsp;<br>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td colspan=\"3\"><b>Momentum balance</b> </td>
<tr><td><b>Dynamics.</b></td>
    <td><b>Balance equation</b></td>
    <td><b>Initial condition</b></td></tr>

<tr><td> DynamicFreeInitial</td>
    <td> no restrictions </td>
    <td> no initial conditions </td></tr>

<tr><td> FixedInitial</td>
    <td> no restrictions </td>
    <td> m_flow = m_flow_start </td></tr>

<tr><td> SteadyStateInitial</td>
    <td> no restrictions </td>
    <td> <b>der</b>(m_flow)=0 </td></tr>

<tr><td> SteadyState</td>
    <td> <b>der</b>(m_flow)=0 </td>
    <td> no initial conditions </td></tr>
</table>

<p>
In the tables above, the equations are given for one-substance fluids. For multiple-substance
fluids and for trace substances, equivalent equations hold.
</p>

<p>
Medium.singleState is a medium property and defines whether the medium is only
described by one state (+ the mass fractions in case of a multi-substance fluid). In such
a case one initial condition less must be provided. For example, incompressible
media have Medium.singleState = <b>true</b>.
</p>

</html>"));

      type CvTypes = enumeration(
          Av "Av (metric) flow coefficient",
          Kv "Kv (metric) flow coefficient",
          Cv "Cv (US) flow coefficient",
          OpPoint "Av defined by operating point")
        "Enumeration to define the choice of valve flow coefficient" annotation (
          Documentation(info="<html>

<p>
Enumeration to define the choice of valve flow coefficient
(to be selected via choices menu):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>CvTypes.</b></th>
    <th><b>Meaning</b></th></tr>

<tr><td>Av</td>
    <td>Av (metric) flow coefficient</td></tr>

<tr><td>Kv</td>
    <td>Kv (metric) flow coefficient</td></tr>

<tr><td>Cv</td>
    <td>Cv (US) flow coefficient</td></tr>

<tr><td>OpPoint</td>
    <td>Av defined by operating point</td></tr>

</table>

<p>
The details of the coefficients are explained in the
<a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.ValveCharacteristics\">
   User's Guide </a>.
</p>

</html>"));

      type PortFlowDirection = enumeration(
          Entering "Fluid flow is only entering",
          Leaving "Fluid flow is only leaving",
          Bidirectional
            "No restrictions on fluid flow (flow reversal possible)")
        "Enumeration to define whether flow reversal is allowed" annotation (
          Documentation(info="<html>

<p>
Enumeration to define the assumptions on the model for the
direction of fluid flow at a port (to be selected via choices menu):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>PortFlowDirection.</b></th>
    <th><b>Meaning</b></th></tr>

<tr><td>Entering</td>
    <td>Fluid flow is only entering the port from the outside</td></tr>

<tr><td>Leaving</td>
    <td>Fluid flow is only leaving the port to the outside</td></tr>

<tr><td>Bidirectional</td>
    <td>No restrictions on fluid flow (flow reversal possible)</td></tr>
</table>

<p>
The default is \"PortFlowDirection.Bidirectional\". If you are completely sure that
the flow is only in one direction, then the other settings may
make the simulation of your model faster.
</p>

</html>"));
      annotation (preferedView="info",
                  Documentation(info="<html>

</html>"));
    end Types;

    package Utilities
      "Utility models to construct fluid components (should not be used directly) "
      extends Modelica.Icons.Package;

      function checkBoundary "Check whether boundary definition is correct"
        extends Modelica.Icons.Function;
        input String mediumName;
        input String substanceNames[:] "Names of substances";
        input Boolean singleState;
        input Boolean define_p;
        input Real X_boundary[:];
        input String modelName = "??? boundary ???";
      protected
        Integer nX = size(X_boundary,1);
        String X_str;
      algorithm
        assert(not singleState or singleState and define_p, "
Wrong value of parameter define_p (= false) in model \""       + modelName + "\":
The selected medium \""     + mediumName + "\" has Medium.singleState=true.
Therefore, an boundary density cannot be defined and
define_p = true is required.
");

        for i in 1:nX loop
          assert(X_boundary[i] >= 0.0, "
Wrong boundary mass fractions in medium \""
      + mediumName + "\" in model \"" + modelName + "\":
The boundary value X_boundary("   + String(i) + ") = " + String(
            X_boundary[i]) + "
is negative. It must be positive.
");
        end for;

        if nX > 0 and abs(sum(X_boundary) - 1.0) > 1.e-10 then
           X_str :="";
           for i in 1:nX loop
              X_str :=X_str + "   X_boundary[" + String(i) + "] = " + String(X_boundary[
              i]) + " \"" + substanceNames[i] + "\"\n";
           end for;
           Modelica.Utilities.Streams.error(
              "The boundary mass fractions in medium \"" + mediumName + "\" in model \"" + modelName + "\"\n" +
              "do not sum up to 1. Instead, sum(X_boundary) = " + String(sum(X_boundary)) + ":\n"
              + X_str);
        end if;
      end checkBoundary;

      function regRoot
        "Anti-symmetric square root approximation with finite derivative in the origin"
        extends Modelica.Icons.Function;
        input Real x;
        input Real delta=0.01
          "Range of significant deviation from sqrt(abs(x))*sgn(x)";
        output Real y;
      algorithm
        y := x/(x*x+delta*delta)^0.25;

        annotation(derivative(zeroDerivative=delta)=Utilities.regRoot_der,
          Documentation(info="<html>
This function approximates sqrt(abs(x))*sgn(x), such that the derivative is finite and smooth in x=0.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = regRoot(x)</td><td>y ~= sqrt(abs(x))*sgn(x)</td><td>abs(x) &gt;&gt;delta</td></tr>
<tr><td>y = regRoot(x)</td><td>y ~= x/sqrt(delta)</td><td>abs(x) &lt;&lt; delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between sqrt(x) and regRoot(x) is 16% around x=0.01, 0.25% around x=0.1 and 0.0025% around x=1.
</p>
</html>",   revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"),        Documentation(info="<html>
This function approximates sqrt(x)*sign(x), such that the derivative is finite and smooth in x=0.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= sqrt(abs(x))*sign(x)</td><td>abs(x) &gt;&gt;delta</td></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= x/delta</td><td>abs(x) &lt;&lt; delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between sqrt(x) and sqrtReg(x) is 0.5% around x=0.1 and 0.005% around x=1.
</p>
</html>",   revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
      end regRoot;

      function regRoot_der "Derivative of regRoot"
        extends Modelica.Icons.Function;
        input Real x;
        input Real delta=0.01 "Range of significant deviation from sqrt(x)";
        input Real dx "Derivative of x";
        output Real dy;
      algorithm
        dy := dx*0.5*(x*x+2*delta*delta)/((x*x+delta*delta)^1.25);

      annotation (Documentation(info="<html>
</html>",   revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
      end regRoot_der;

      function regStep
        "Approximation of a general step, such that the characteristic is continuous and differentiable"
        extends Modelica.Icons.Function;
        input Real x "Abscissa value";
        input Real y1 "Ordinate value for x > 0";
        input Real y2 "Ordinate value for x < 0";
        input Real x_small(min=0) = 1e-5
          "Approximation of step for -x_small <= x <= x_small; x_small >= 0 required";
        output Real y
          "Ordinate value to approximate y = if x > 0 then y1 else y2";
      algorithm
        y := smooth(1, if x >  x_small then y1 else
                       if x < -x_small then y2 else
                       if x_small > 0 then (x/x_small)*((x/x_small)^2 - 3)*(y2-y1)/4 + (y1+y2)/2 else (y1+y2)/2);
        annotation(Documentation(revisions="<html>
<ul>
<li><i>April 29, 2008</i>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implemented.</li>
<li><i>August 12, 2008</i>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>",       info="<html>
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
</html>"));
      end regStep;
      annotation (Documentation(info="<html>

</html>"));
    end Utilities;
  annotation (
    preferedView="info",
    __Dymola_classOrder={"UsersGuide","Examples","System","Vessels","Pipes","Machines","Valves",
        "Fittings", "Sources", "Sensors", "Interfaces", "Types", "Utilities", "Icons", "*"},
    Documentation(info="<html>
<p>
Library <b>Modelica.Fluid</b> is a <b>free</b> Modelica package providing components for
<b>1-dimensional thermo-fluid flow</b> in networks of vessels, pipes, fluid machines, valves and fittings.
A unique feature is that the component equations and the media models
as well as pressure loss and heat transfer correlations are decoupled from each other.
All components are implemented such that they can be used for
media from the Modelica.Media library. This means especially that an
incompressible or compressible medium, a single or a multiple
substance medium with one or more phases might be used.
</p>

<p>
In the next figure, several features of the library are demonstrated with
a simple heating system with a closed flow cycle. By just changing one configuration parameter in the system object the equations are changed between steady-state and dynamic simulation with fixed or steady-state initial conditions.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/UsersGuide/HeatingSystem.png\" border=1>

<p>
With respect to previous versions, the design
of the connectors has been changed in a non-backward compatible way,
using the recently developed concept
of stream connectors that results in much more reliable simulations
(see also <a href=\"modelica://Modelica/Resources/Documentation/Fluid/Stream-Connectors-Overview-Rationale.pdf\">Stream-Connectors-Overview-Rationale.pdf</a>).
This extension was included in Modelica 3.1.
As of Jan. 2009, the stream concept is supported in Dymola 7.1.
It is recommended to use Dymola 7.2 (available since Feb. 2009), or a later Dymola version,
since this version supports a new annotation to connect very
conveniently to vectors of connectors.
Other tool vendors will support the stream concept as well.
</p>

<p>
The following parts are useful, when newly starting with this library:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Fluid.UsersGuide\">Modelica.Fluid.UsersGuide</a>.</li>
<li> <a href=\"modelica://Modelica.Fluid.UsersGuide.ReleaseNotes\">Modelica.Fluid.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"modelica://Modelica.Fluid.Examples\">Modelica.Fluid.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 2002-2010, ABB, DLR, Dassault Syst&egrave;mes AB, Modelon, TU Braunschweig, TU Hamburg-Harburg, Politecnico di Milano.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"));
  end Fluid;

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

    partial package PartialSimpleIdealGasMedium
        "Medium model of Ideal gas with constant cp and cv. All other quantities, e.g., transport properties, are constant."

      extends Interfaces.PartialPureSubstance(
           ThermoStates = Choices.IndependentVariables.pT,
           final singleState=false);

      import SI = Modelica.SIunits;
      constant SpecificHeatCapacity cp_const
          "Constant specific heat capacity at constant pressure";
      constant SpecificHeatCapacity cv_const= cp_const - R_gas
          "Constant specific heat capacity at constant volume";
      constant SpecificHeatCapacity R_gas "medium specific gas constant";
      constant MolarMass MM_const "Molar mass";
      constant DynamicViscosity eta_const "Constant dynamic viscosity";
      constant ThermalConductivity lambda_const "Constant thermal conductivity";
      constant Temperature T_min "Minimum temperature valid for medium model";
      constant Temperature T_max "Maximum temperature valid for medium model";
      constant Temperature T0= reference_T "Zero enthalpy temperature";

      redeclare record extends ThermodynamicState
          "Thermodynamic state of ideal gas"
        AbsolutePressure p "Absolute pressure of medium";
        Temperature T "Temperature of medium";
      end ThermodynamicState;

      redeclare record extends FluidConstants "fluid constants"
      end FluidConstants;

      redeclare replaceable model extends BaseProperties(
        T(stateSelect=if preferredMediumStates then StateSelect.prefer else
                           StateSelect.default),
        p(stateSelect=if preferredMediumStates then StateSelect.prefer else
                           StateSelect.default)) "Base properties of ideal gas"
      equation
            assert(T >= T_min and T <= T_max, "
Temperature T (= "       + String(T) + " K) is not
in the allowed range ("       + String(T_min) + " K <= T <= " + String(T_max)
               + " K)
required from medium model \""       + mediumName + "\".
");
        h = specificEnthalpy_pTX(p,T,X);
        u = h-R*T;
        R = R_gas;
        d = p/(R*T);
        MM = MM_const;
        state.T = T;
        state.p = p;
            annotation (Documentation(info="<HTML>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
</p>
</HTML>"));
      end BaseProperties;

      redeclare function setState_pTX
          "Return thermodynamic state from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      algorithm
        state := ThermodynamicState(p=p,T=T);
      end setState_pTX;

      redeclare function setState_phX
          "Return thermodynamic state from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      algorithm
        state := ThermodynamicState(p=p,T=T0+h/cp_const);
      end setState_phX;

      redeclare replaceable function setState_psX
          "Return thermodynamic state from p, s, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      algorithm
        state := ThermodynamicState(p=p,T=Modelica.Math.exp(s/cp_const + Modelica.Math.log(reference_T))
                                    + R_gas*Modelica.Math.log(p/reference_p));
      end setState_psX;

      redeclare function setState_dTX
          "Return thermodynamic state from d, T, and X or Xi"
        extends Modelica.Icons.Function;
        input Density d "density";
        input Temperature T "Temperature";
        input MassFraction X[:]=reference_X "Mass fractions";
        output ThermodynamicState state "thermodynamic state record";
      algorithm
        state := ThermodynamicState(p=d*R_gas*T,T=T);
      end setState_dTX;

          redeclare function extends setSmoothState
          "Return thermodynamic state so that it smoothly approximates: if x > 0 then state_a else state_b"
          algorithm
            state := ThermodynamicState(p=Media.Common.smoothStep(x, state_a.p, state_b.p, x_small),
                                        T=Media.Common.smoothStep(x, state_a.T, state_b.T, x_small));
          end setSmoothState;

      redeclare function extends pressure "Return pressure of ideal gas"

      algorithm
        p := state.p;
      end pressure;

      redeclare function extends temperature "Return temperature of ideal gas"

      algorithm
        T := state.T;
      end temperature;

      redeclare function extends density "Return density of ideal gas"
      algorithm
        d := state.p/(R_gas*state.T);
      end density;

      redeclare function extends specificEnthalpy "Return specific enthalpy"
          extends Modelica.Icons.Function;
      algorithm
        h := cp_const*(state.T-T0);
      end specificEnthalpy;

      redeclare function extends specificInternalEnergy
          "Return specific internal energy"
        extends Modelica.Icons.Function;
      algorithm
        // u := (cp_const-R_gas)*(state.T-T0);
        u := cp_const*(state.T-T0) - R_gas*state.T;
      end specificInternalEnergy;

      redeclare function extends specificEntropy "Return specific entropy"
          extends Modelica.Icons.Function;
      algorithm
        s := cp_const*Modelica.Math.log(state.T/T0) - R_gas*Modelica.Math.log(state.p/reference_p);
      end specificEntropy;

      redeclare function extends specificGibbsEnergy
          "Return specific Gibbs energy"
        extends Modelica.Icons.Function;
      algorithm
        g := cp_const*(state.T-T0) - state.T*specificEntropy(state);
      end specificGibbsEnergy;

      redeclare function extends specificHelmholtzEnergy
          "Return specific Helmholtz energy"
        extends Modelica.Icons.Function;
      algorithm
        f := (cp_const-R_gas)*(state.T-T0) - state.T*specificEntropy(state);
      end specificHelmholtzEnergy;

      redeclare function extends dynamicViscosity "Return dynamic viscosity"

      algorithm
        eta := eta_const;
      end dynamicViscosity;

      redeclare function extends thermalConductivity
          "Return thermal conductivity"

      algorithm
        lambda := lambda_const;
      end thermalConductivity;

      redeclare function extends specificHeatCapacityCp
          "Return specific heat capacity at constant pressure"

      algorithm
        cp := cp_const;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv
          "Return specific heat capacity at constant volume"

      algorithm
        cv := cv_const;
      end specificHeatCapacityCv;

      redeclare function extends isentropicExponent
          "Return isentropic exponent"

      algorithm
        gamma := cp_const/cv_const;
      end isentropicExponent;

      redeclare function extends velocityOfSound "Return velocity of sound "

      algorithm
        a := sqrt(cp_const/cv_const*R_gas*state.T);
      end velocityOfSound;

      redeclare function specificEnthalpy_pTX
          "Return specific enthalpy from p, T, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input MassFraction X[nX] "Mass fractions";
        output SpecificEnthalpy h "Specific enthalpy at p, T, X";
      algorithm
        h := cp_const*(T-T0);
      end specificEnthalpy_pTX;

      redeclare function temperature_phX
          "Return temperature from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[nX] "Mass fractions";
        output Temperature T "Temperature";
      algorithm
        T := h/cp_const + T0;
      end temperature_phX;

      redeclare function density_phX "Return density from p, h, and X or Xi"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input MassFraction X[nX] "Mass fractions";
        output Density d "density";
      algorithm
        d := density(setState_phX(p,h,X));
      end density_phX;

      redeclare function extends isentropicEnthalpy
          "Return isentropic enthalpy"
      algorithm
        /*  s = cp_const*log(refState.T/T0) - R_gas*log(refState.p/reference_p)
          = cp_const*log(state.T/T0) - R_gas*log(p_downstream/reference_p)

        log(state.T) = log(refState.T) +
                       (R_gas/cp_const)*(log(p_downstream/reference_p) - log(refState.p/reference_p))
                     = log(refState.T) + (R_gas/cp_const)*log(p_downstream/refState.p)
                     = log(refState.T) + log( (p_downstream/refState.p)^(R_gas/cp_const) )
                     = log( refState.T*(p_downstream/refState.p)^(R_gas/cp_const) )
        state.T = refstate.T*(p_downstream/refstate.p)^(R_gas/cp_const)
    */
        h_is := cp_const*(refState.T*(p_downstream/refState.p)^(R_gas/cp_const) - T0);
      end isentropicEnthalpy;

      redeclare function extends isobaricExpansionCoefficient
          "Returns overall the isobaric expansion coefficient beta"
      algorithm
        /* beta = 1/v * der(v,T), with v = 1/d, at constant pressure p:
       v = R*T/p
       der(v,T) = R/p
       beta = p/(R*T)*R/p
            = 1/T
    */

        beta := 1/state.T;
      end isobaricExpansionCoefficient;

      redeclare function extends isothermalCompressibility
          "Returns overall the isothermal compressibility factor"
      algorithm
        /* kappa = - 1/v * der(v,p), with v = 1/d at constant temperature T.
       v = R*T/p
       der(v,T) = -R*T/p^2
       kappa = p/(R*T)*R*T/p^2
             = 1/p
    */
        kappa := 1/state.p;
      end isothermalCompressibility;

      redeclare function extends density_derp_T
          "Returns the partial derivative of density with respect to pressure at constant temperature"
      algorithm
        /*  d = p/(R*T)
        ddpT = 1/(R*T)
    */
        ddpT := 1/(R_gas*state.T);
      end density_derp_T;

      redeclare function extends density_derT_p
          "Returns the partial derivative of density with respect to temperature at constant pressure"
      algorithm
        /*  d = p/(R*T)
        ddpT = -p/(R*T^2)
    */
        ddTp := -state.p/(R_gas*state.T*state.T);
      end density_derT_p;

      redeclare function extends density_derX
          "Returns the partial derivative of density with respect to mass fractions at constant pressure and temperature"
      algorithm
        dddX := fill(0,nX);
      end density_derX;

      redeclare function extends molarMass
          "Returns the molar mass of the medium"
      algorithm
        MM := MM_const;
      end molarMass;
    end PartialSimpleIdealGasMedium;
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

      package SimpleAir "Air: Simple dry air model (0..100 degC)"

        extends Interfaces.PartialSimpleIdealGasMedium(
           mediumName="SimpleAir",
           cp_const=1005.45,
           MM_const=0.0289651159,
           R_gas=Constants.R/0.0289651159,
           eta_const=1.82e-5,
           lambda_const=0.026,
           T_min=Cv.from_degC(0),
           T_max=Cv.from_degC(100));

        import SI = Modelica.SIunits;
        import Cv = Modelica.SIunits.Conversions;
        import Modelica.Constants;

        constant FluidConstants[nS] fluidConstants=
          FluidConstants(iupacName={"simple air"},
                         casRegistryNumber={"not a real substance"},
                         chemicalFormula={"N2, O2"},
                         structureFormula={"N2, O2"},
                         molarMass=Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM)
          "constant data for the fluid";

        annotation (Documentation(info="<html>
                              <h4>Simple Ideal gas air model for low temperatures</h4>
                              <p>This model demonstrats how to use the PartialSimpleIdealGas base class to build a
                              simple ideal gas model with a limited temperature validity range.</p>
                              </html>"));
      end SimpleAir;
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

        package SingleGasesData
          "Ideal gas data based on the NASA Glenn coefficients"
          extends Modelica.Icons.Package;

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

  package Math
    "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

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

  function asinh "Inverse of sinh (area hyperbolic sine)"
    extends Modelica.Math.baseIcon2;
    input Real u;
    output Real y;

  algorithm
    y :=Modelica.Math.log(u + sqrt(u*u + 1));
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
          Line(points={{-80,-80},{-56.7,-68.4},{-39.8,-56.8},{-26.9,-44.7},{-17.3,
                -32.4},{-9.25,-19},{9.25,19},{17.3,32.4},{26.9,44.7},{39.8,56.8},
                {56.7,68.4},{80,80}}, color={0,0,0}),
          Text(
            extent={{-90,80},{-6,26}},
            lineColor={192,192,192},
            textString="asinh")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,0},{84,0}}, color={95,95,95}),
          Polygon(
            points={{98,0},{82,6},{82,-6},{98,0}},
            lineColor={95,95,95},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,-80},{-56.7,-68.4},{-39.8,-56.8},{-26.9,-44.7},{-17.3,-32.4},
                {-9.25,-19},{9.25,19},{17.3,32.4},{26.9,44.7},{39.8,56.8},{56.7,
                68.4},{80,80}},
            color={0,0,255},
            thickness=0.5),
          Text(
            extent={{-31,72},{-11,88}},
            textString="2.31",
            lineColor={0,0,255}),
          Text(
            extent={{-35,-88},{-15,-72}},
            textString="-2.31",
            lineColor={0,0,255}),
          Text(
            extent={{72,-13},{92,-33}},
            textString="5",
            lineColor={0,0,255}),
          Text(
            extent={{-96,21},{-76,1}},
            textString="-5",
            lineColor={0,0,255}),
          Text(
            extent={{80,22},{100,2}},
            lineColor={95,95,95},
            textString="u"),
          Line(
            points={{0,80},{88,80}},
            color={175,175,175},
            smooth=Smooth.None),
          Line(
            points={{80,86},{80,-12}},
            color={175,175,175},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
The function returns the area hyperbolic sine of its
input argument u. This inverse of sinh(..) is unique
and there is no restriction on the input argument u of
asinh(u) (-&infin; &lt; u &lt; &infin;):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asinh.png\">
</p>
</html>"));
  end asinh;

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

    final constant Real inf=1.e+60
      "Biggest Real number such that inf and -inf are representable on the machine";

    final constant SI.Acceleration g_n=9.80665
      "Standard acceleration of gravity on earth";

    final constant Real R(final unit="J/(mol.K)") = 8.314472
      "Molar gas constant";

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

    partial package VariantsPackage "Icon for package containing variants"
    //extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),       graphics={Rectangle(
              extent={{-80,100},{100,-80}},
              lineColor={0,0,0},
              fillColor={215,230,240},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-100,80},{80,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-80,-20},{-20,-80}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,-20},{60,-80}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{0,60},{60,0}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-80,60},{-20,0}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
                                Documentation(info="<html>
<p>This icon shall be used for a package/library that contains several variants of one components.</p>
</html>"));
    end VariantsPackage;

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

    type Area = Real (final quantity="Area", final unit="m2");

    type Time = Real (final quantity="Time", final unit="s");

    type AngularVelocity = Real (
        final quantity="AngularVelocity",
        final unit="rad/s");

    type Velocity = Real (final quantity="Velocity", final unit="m/s");

    type Acceleration = Real (final quantity="Acceleration", final unit="m/s2");

    type Frequency = Real (final quantity="Frequency", final unit="Hz");

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

    type EnthalpyFlowRate = Real (final quantity="EnthalpyFlowRate", final unit=
            "W");

    type MassFlowRate = Real (quantity="MassFlowRate", final unit="kg/s");

    type VolumeFlowRate = Real (final quantity="VolumeFlowRate", final unit=
            "m3/s");

    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0,
        start = 288.15,
        displayUnit="degC")
      "Absolute temperature (use type TemperatureDifference for relative temperatures)"
                                                                                                        annotation(__Dymola_absoluteValue=true);

    type Temperature = ThermodynamicTemperature;

    type Compressibility = Real (final quantity="Compressibility", final unit=
            "1/Pa");

    type IsothermalCompressibility = Compressibility;

    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit=
               "W/(m.K)");

    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");

    type RatioOfSpecificHeatCapacities = Real (final quantity=
            "RatioOfSpecificHeatCapacities", final unit="1");

    type SpecificEntropy = Real (final quantity="SpecificEntropy", final unit=
            "J/(kg.K)");

    type SpecificEnergy = Real (final quantity="SpecificEnergy", final unit=
            "J/kg");

    type SpecificEnthalpy = SpecificEnergy;

    type DerDensityByEnthalpy = Real (final unit="kg.s2/m5");

    type DerDensityByPressure = Real (final unit="s2/m2");

    type DerDensityByTemperature = Real (final unit="kg/(m3.K)");

    type DerEnthalpyByPressure = Real (final unit="J.m.s2/kg2");

    type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol",min=0);

    type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol", min=0);

    type MassFraction = Real (final quantity="MassFraction", final unit="1");

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


package TestPolimi

  package Fluid

    model ValveAir "Flow source, pressure sink and simple fluid"

      Modelica.Fluid.Sources.FixedBoundary sink(
        nPorts=1,
        redeclare package Medium = Modelica.Media.Air.SimpleAir,
        p=100000,
        T=303.15) annotation (Placement(transformation(extent={{42,-30},{22,-10}})));
      inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
          allowFlowReversal=false)
        annotation (Placement(transformation(extent={{60,80},{80,100}})));
      Modelica.Fluid.Valves.ValveCompressible valve(
        redeclare package Medium = Modelica.Media.Air.SimpleAir,
        m_flow_nominal=0.01,
        CvData=Modelica.Fluid.Types.CvTypes.Cv,
        Cv=1.4,
        dp_nominal=100000,
        p_nominal=200000)
        annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
      Modelica.Blocks.Sources.Step step(
        height=-0.1,
        offset=1,
        startTime=2)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Fluid.Sources.FixedBoundary source(
        nPorts=1,
        redeclare package Medium = Modelica.Media.Air.SimpleAir,
        p=200000,
        T=303.15) annotation (Placement(transformation(extent={{-56,-30},{-36,-10}})));
    equation
      connect(valve.port_b, sink.ports[1]) annotation (Line(
          points={{10,-20},{22,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(step.y, valve.opening) annotation (Line(
          points={{-19,30},{0,30},{0,-12}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(source.ports[1], valve.port_a) annotation (Line(
          points={{-36,-20},{-10,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=4),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics),
        __Dymola_experimentSetupOutput);
    end ValveAir;
  end Fluid;
annotation (uses(Modelica(version="3.2")));
end TestPolimi;

model TestPolimi_Fluid_ValveAir
 extends TestPolimi.Fluid.ValveAir;
  annotation(experiment(StopTime=4));
end TestPolimi_Fluid_ValveAir;
