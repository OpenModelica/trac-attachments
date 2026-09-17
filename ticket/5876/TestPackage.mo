package TestPackage

package PartialMedium
  constant Integer NumberOfDroplets;
  constant Integer Ns;
  
  replaceable function molarMasses
    output Real MM[Ns];
  end molarMasses;
end PartialMedium;

package MediumA
  extends PartialMedium(Ns = 2);
  
  redeclare function extends molarMasses
    algorithm
      MM := ones(Ns);
    end molarMasses;
end MediumA; 

package MediumB
  extends PartialMedium(Ns = 3);
  
  redeclare function extends molarMasses
    algorithm
      MM := ones(Ns);
    end molarMasses;
end MediumB; 

model M
  Integer NumberOfDroplets;
  Integer Ns = Medium.Ns;
  replaceable package Medium = MediumA
    constrainedby PartialMedium(final NumberOfDroplets = NumberOfDroplets);
end M;

model S1
  M m(NumberOfDroplets = 5);
end S1;

model S2
  M m(NumberOfDroplets = 6,
      redeclare package Medium = MediumB);
end S2;


end TestPackage;
