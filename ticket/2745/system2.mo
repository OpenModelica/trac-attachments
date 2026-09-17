package Modelica  
  package Media  
    package Interfaces  
      partial package PartialMedium  
        constant Real h_default = specificEnthalpy_pTX();

        replaceable partial function specificEnthalpy  
          output Real h;
        end specificEnthalpy;

        replaceable function specificEnthalpy_pTX  
          output Real h;
        algorithm
          h := specificEnthalpy();
        end specificEnthalpy_pTX;
      end PartialMedium;
    end Interfaces;
  end Media;
end Modelica;

package Buildings  
  package Fluid  
    package Interfaces  
      model FourPort  
        replaceable package Medium1 = Modelica.Media.Interfaces.PartialMedium;
        parameter Real h_outflow_a1_start = Medium1.h_default;
      end FourPort;
    end Interfaces;
  end Fluid;

  package Media  
    package GasesPTDecoupled  
      package MoistAirUnsaturated  
        extends Modelica.Media.Interfaces.PartialMedium;

        redeclare function extends specificEnthalpy  
        algorithm
          MoistAirUnsaturated.h_pTX();
        end specificEnthalpy;

        function h_pTX  
        end h_pTX;
      end MoistAirUnsaturated;
    end GasesPTDecoupled;
  end Media;
end Buildings;

model System2  
  replaceable package MediumA = Buildings.Media.GasesPTDecoupled.MoistAirUnsaturated;
  Buildings.Fluid.Interfaces.FourPort hex(redeclare package Medium1 = MediumA);
end System2;
