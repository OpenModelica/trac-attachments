within ;
package Test
  import SI = Modelica.SIunits;

  model System
    replaceable model fluid = Fluids.StandardOil constrainedby Fluids.BaseFluid
                                                                                                   "Fluid model" annotation (
    choicesAllMatching = true);
    fluid Oil;
  end System;

  model M
    outer System system;
    final parameter SI.Density rhoOil = system.Oil.density(300) "oil density";

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end M;

  model S
    inner System system(redeclare model fluid =
          Fluids.RealOil);
    M m;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end S;

  package Fluids
    partial model BaseFluid
      extends Modelica.Icons.MaterialProperty;
      partial function baseDensity "Base function for density calculation"
        extends Modelica.Icons.Function;
        input SI.Temperature T "fluid temperature";
        output SI.Density rho "fluid density";
      end baseDensity;
    end BaseFluid;

    model StandardOil
      extends Test.Fluids.BaseFluid;

      function density "function for density calculation"
        extends Test.Fluids.BaseFluid.baseDensity;
      algorithm
        rho := 890;
      end density;
    end StandardOil;

    model RealOil
      extends Test.Fluids.BaseFluid;

      function density "function for density calculation"
        extends Test.Fluids.BaseFluid.baseDensity;
      protected
        final constant SI.Temperature T_vect[:] =           {273.15+40, 273.15+100};
        final constant SI.Density rho_vect[:] =             {880,      885};
      algorithm
        rho := Modelica.Math.Vectors.interpolate(T_vect, rho_vect, T);
      end density;

    end RealOil;
  end Fluids;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(Modelica(version="3.2.2")));
end Test;
