partial package PartialHelmholtzMedium  
  extends PartialMedium(redeclare record foo = Types.myFluidConstants);

  record HelmholtzDerivs 
  end HelmholtzDerivs;

  constant InputChoice inputChoice;

  function setState_pTX
    HelmholtzDerivs f;
  end setState_pTX;
end PartialHelmholtzMedium;

package Types  
  record myFluidConstants  
  end myFluidConstants;
end Types;

partial package PartialMedium 
end PartialMedium;

partial model PartialTestModel
  replaceable package Medium = PartialMedium;
  parameter Real p_start = Medium.p_default;
end PartialTestModel;

model ButaneTestModel_dT
  extends PartialTestModel(redeclare package Medium = PartialHelmholtzMedium(inputChoice = Medium.foo));
end ButaneTestModel_dT;
