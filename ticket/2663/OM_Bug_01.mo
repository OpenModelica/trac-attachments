within ;
package OM_Bug_01
  record Data
    parameter Integer i=-1;
    parameter Modelica.Blocks.Types.AnalogFilter Enum[:]={Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
        Modelica.Blocks.Types.AnalogFilter.CriticalDamping};
  end Data;

  record test = OM_Bug_01.Data (i=1, Enum[:]={Modelica.Blocks.Types.AnalogFilter.Bessel,
          Modelica.Blocks.Types.AnalogFilter.Bessel});
  annotation (uses(Modelica(version="3.2.1"), JCI(version="0.3")));
end OM_Bug_01;
