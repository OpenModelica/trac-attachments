package Modelica  
  extends Modelica.Icons.Package;

  package Icons  
    extends Icons.Package;

    partial package Package  end Package;
  end Icons;

  package SIunits  
    extends Modelica.Icons.Package;
    type Concentration = Real(final quantity = "Concentration", final unit = "mol/m3");
  end SIunits;
end Modelica;

package ModelicaByExample  
  package Components  
    package ChemicalReactions  
      package Examples  
        model ABX_System  
          ABX.Components.Solution solution(C(each fixed = true, start = {1, 1, 0}));
          ABX.Components.'A+B->X' 'A+B->X'(k = 0.1);
          ABX.Components.'A+B<-X' 'A+B<-X'(k = 0.1);
          ABX.Components.'X+B->R+S' 'X+B->R+S'(k = 10);
        equation
          connect('A+B<-X'.mixture, solution.mixture);
          connect('X+B->R+S'.mixture, solution.mixture);
          connect('A+B->X'.mixture, solution.mixture);
        end ABX_System;
      end Examples;

      package ABX  
        type Species = enumeration(A, B, X);

        package Interfaces  
          type ConcentrationRate = Real(final unit = "mol/(m3.s)");

          connector Mixture  
            Modelica.SIunits.Concentration[Species] C;
            flow ConcentrationRate[Species] R;
          end Mixture;

          partial model Reaction  
            parameter Real k;
            Mixture mixture;
          protected
            ConcentrationRate[Species] consumed;
            ConcentrationRate[Species] produced;
            Modelica.SIunits.Concentration[Species] C = mixture.C;
          equation
            consumed = -produced;
            mixture.R = consumed;
          end Reaction;
        end Interfaces;

        package Components  
          model Solution  
            Interfaces.Mixture mixture;
            Modelica.SIunits.Concentration[Species] C = mixture.C;
          equation
            der(mixture.C) = mixture.R;
          end Solution;

          model 'A+B->X'  
            extends Interfaces.Reaction;
          protected
            Interfaces.ConcentrationRate R = k * C[Species.A] * C[Species.B];
          equation
            consumed[Species.A] = R;
            consumed[Species.B] = R;
            produced[Species.X] = R;
          end 'A+B->X';

          model 'A+B<-X'  
            extends Interfaces.Reaction;
          protected
            Interfaces.ConcentrationRate R = k * C[Species.X];
          equation
            produced[Species.A] = R;
            produced[Species.B] = R;
            consumed[Species.X] = R;
          end 'A+B<-X';

          model 'X+B->R+S'  
            extends Interfaces.Reaction;
          protected
            Interfaces.ConcentrationRate R = k * C[Species.B] * C[Species.X];
          equation
            consumed[Species.A] = 0;
            consumed[Species.B] = R;
            consumed[Species.X] = R;
          end 'X+B->R+S';
        end Components;
      end ABX;
    end ChemicalReactions;
  end Components;
end ModelicaByExample;

model TestMe
  extends ModelicaByExample.Components.ChemicalReactions.Examples.ABX_System;
end TestMe;
