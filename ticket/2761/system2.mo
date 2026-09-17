partial package PartialMedium  
  constant Real h_default = specificEnthalpy();

  replaceable partial function specificEnthalpy  
    output Real h;
  end specificEnthalpy;
end PartialMedium;

package Buildings  
  model MixingVolume  
    replaceable package Medium = PartialMedium;
    parameter Real h = Medium.h_default;
  end MixingVolume;

  package Media  
    package MoistAirUnsaturated  
      extends PartialMedium;

      redeclare function extends specificEnthalpy  
      algorithm
        h := Buildings.Media.MoistAirUnsaturated.h_pTX();
      end specificEnthalpy;

      function h_pTX
        output Real x;
      end h_pTX;
    end MoistAirUnsaturated;
  end Media;
end Buildings;

model System2  
  replaceable package MediumA = Buildings.Media.MoistAirUnsaturated;
  Buildings.MixingVolume vol(redeclare package Medium = MediumA);
end System2;
