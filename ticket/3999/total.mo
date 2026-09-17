class Model2Unit1 = TestLibrary.Containers.Container1.SubContainer1.Unit1(redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel1 sm1, redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel3 sm3, redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel4 sm4, redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel5 sm5);
class Model2Unit2 = TestLibrary.Containers.Container1.SubContainer1.Unit2(redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel5 sm5);

model Model2Test  
  Model2Unit1 i;
  Model2Unit2 e;
equation
  connect(i.sm5, e.sm5);
end Model2Test;

package TestLibrary  "Test library" 
  package Models  
    package ModelContainer2  
      package Model2  
        encapsulated type States = enumeration(S1, X1, S2, S3, S4, S5, X2, S6, X3, X4, X5, X6, S7, X7, S8, S9, S10);
        encapsulated type Composites = enumeration(C1, C2);
        encapsulated type Species = enumeration(SP1, SP2, SP3, SP4, SP5, SP6, SP7, SP8, SP9, SP10);

        class SubModel1  
          Real[States] states;
          parameter Real S1 = 2.0;
          parameter Real X1 = 150.0;
          parameter Real S2 = 50.0;
          parameter Real S3 = 0.0;
          parameter Real S4 = 25.0;
          parameter Real S5 = 30.0;
          parameter Real X2 = 10.0;
          parameter Real S6 = 0.0;
          parameter Real X3 = 10.0;
          parameter Real X4 = 160.0;
          parameter Real X5 = 20.0;
          parameter Real X6 = 0.0;
          parameter Real S7 = 16.0;
          parameter Real X7 = 50.0;
          parameter Real S8 = 0.005;
          parameter Real S9 = 0.005;
          parameter Real S10 = 0.005;
        equation
          states[States.S1] = S1;
          states[States.X1] = X1;
          states[States.S2] = S2;
          states[States.S3] = S3;
          states[States.S4] = S4;
          states[States.S5] = S5;
          states[States.X2] = X2;
          states[States.S6] = S6;
          states[States.X3] = X3;
          states[States.X4] = X4;
          states[States.X5] = X5;
          states[States.X6] = X6;
          states[States.S7] = S7;
          states[States.X7] = X7;
          states[States.S8] = S8;
          states[States.S9] = S9;
          states[States.S10] = S10;
        end SubModel1;

        class Parameters  
          parameter Real pa1 = 3;
          parameter Real pa2 = 0.03;
          parameter Real pa3 = 0.4;
          parameter Real pa4 = 6;
          parameter Real pa5 = 0.8;
          parameter Real pa6 = 20;
          parameter Real pa7 = 0.62;
          parameter Real pa8 = 0.2;
          parameter Real pa9 = 0.5;
          parameter Real pa10 = 0.05;
          parameter Real pa11 = 0.8;
          parameter Real pa12 = 0.15;
          parameter Real pa13 = 0.08;
          parameter Real pa14 = 0.4;
          parameter Real pa15 = 1;
          parameter Real pa16 = 0.67;
          parameter Real pa17 = 0.08;
          parameter Real pa18 = 0.24;
          parameter Real pa19 = 0.086;
          parameter Real pa20 = 0.06;
          parameter Real pa21 = 2.85714285714;
          parameter Real pa22 = -4.57142857143;
          parameter Real pa23 = -1.71428571429;
          parameter Real pa24 = 0.0714285714286;
          parameter Real pa25 = -0.0714285714286;
          parameter Real pa26 = 1.48;
          parameter Real T = 20.0;
        end Parameters;

        class SubModel3  
          Parameters parameters;
          Real[States] states;
          Real[Composites] composites;
          constant States X1 = States.X1;
          constant States S2 = States.S2;
          constant States S5 = States.S5;
          constant States X2 = States.X2;
          constant States X4 = States.X4;
          constant States X5 = States.X5;
          constant States X6 = States.X6;
          constant Composites C1 = Composites.C1;
          constant Composites C2 = Composites.C2;
        equation
          composites[C1] = states[X1] + states[S2] + states[S5] + states[X2] + states[X4] + states[X5] + states[X6];
          composites[C2] = states[S2] + states[X2] + states[X4] + states[X5];
        end SubModel3;

        class SubModel4  
          Parameters parameters;
          Real[States] states;
          Real[Species] species;
          Real var68;
          Real var74;
          Real var50;
          Real var51;
          Real var69;
          Real var70;
          Real var52;
          Real var53;
          Real var54;
          Real var55;
          Real var56;
          Real var57;
          Real var58;
          Real var59;
          Real var60;
          Real var61;
          Real var72;
          Real var71;
          Real var76;
          Real var75;
          Real var73;
          Real var62;
          constant Species SP1 = Species.SP1;
          constant Species SP2 = Species.SP2;
          constant Species SP3 = Species.SP3;
          constant Species SP4 = Species.SP4;
          constant Species SP5 = Species.SP5;
          constant Species SP6 = Species.SP6;
          constant Species SP7 = Species.SP7;
          constant Species SP8 = Species.SP8;
          constant Species SP9 = Species.SP9;
          constant Species SP10 = Species.SP10;
          constant States S3 = States.S3;
          constant States S4 = States.S4;
          constant States S8 = States.S8;
          constant States S9 = States.S9;
          constant States S10 = States.S10;
          constant Real var63 = 6.867e-15;
          constant Real var65 = -285.84;
          constant Real var66 = -229.994;
          constant Real var67 = -286.93308;
          constant Real var64 = 298.15;
          constant Real R = 8.314;
        equation
          var68 = -log10(species[SP1]);
          species[SP2] = var74 / species[SP1];
          species[SP3] = states[S4] / 14000 * var51 / (species[SP1] + var51);
          species[SP4] = states[S4] / 14000 * species[SP1] / (species[SP1] + var51);
          species[SP5] = states[S3] / 14000;
          species[SP6] = states[S8] * species[SP1] ^ 2 / (species[SP1] ^ 2 + species[SP1] * var69 + var69 * var70);
          species[SP7] = species[SP1] * var69 * states[S8] / (species[SP1] ^ 2 + species[SP1] * var69 + var69 * var70);
          species[SP8] = var70 * var69 * states[S8] / (species[SP1] ^ 2 + species[SP1] * var69 + var69 * var70);
          species[SP9] = states[S9];
          species[SP10] = states[S10];
          var61 = min(var72, 0.3);
          var72 = 0.5 * ((+1) ^ 2 * species[SP1] + (-1) ^ 2 * species[SP2] + 0 ^ 2 * species[SP3] + (+1) ^ 2 * species[SP4] + (-1) ^ 2 * species[SP5] + 0 ^ 2 * species[SP6] + (-1) ^ 2 * species[SP7] + (-2) ^ 2 * species[SP8] + (+1) ^ 2 * species[SP9] + (-1) ^ 2 * species[SP10]);
          var71 = var75 - var76;
          var75 = (+1) * species[SP1] + (+1) * species[SP4] + (+1) * species[SP9];
          var76 = (-1) * species[SP2] + (-1) * species[SP5] + (-1) * species[SP7] + (-2) * species[SP8] + (-1) * species[SP10];
          var76 = var75;
          var55 = 10 ^ (-var58 * 1 ^ 2 * (var61 ^ 0.5 / (1 + 1.5 * var61 ^ 0.5) - 0.3 * var61));
          var56 = 10 ^ (-var58 * 2 ^ 2 * (var61 ^ 0.5 / (1 + 1.5 * var61 ^ 0.5) - 0.3 * var61));
          var57 = 10 ^ (-var58 * 3 ^ 2 * (var61 ^ 0.5 / (1 + 1.5 * var61 ^ 0.5) - 0.3 * var61));
          var58 = 1.82483 * 10 ^ 6 * var59 ^ 0.5 * (var60 * var73) ^ (-1.5);
          var60 = 2727.586 + 0.6224107 * var73 - 466.9151 * log(var73) - 52000.87 / var73;
          var73 = parameters.T + 273.16;
          var59 = 1 - (parameters.T - 3.9863) ^ 2 * (parameters.T + 288.9414) / (508929.2 * (parameters.T + 68.12963)) + 0.011445 * exp(-374.3 / parameters.T);
          var74 = var50 / var55 ^ 2;
          var50 = var63 * exp(var54 / R * (1 / var64 - 1 / var73));
          var54 = var66 + var65 - 2 * var67;
          var69 = var52 / var55 ^ 2;
          var70 = var53 / var56;
          var52 = 10 ^ (-(3404.7 / var73 - 14.8435 + var73 * 0.03279));
          var53 = 10 ^ (-(2902.4 / var73 - 6.498 + var73 * 0.02379));
          var51 = 10 ^ (-(2835.8 / var73 - 0.6322 + 0.00123 * var73));
          var62 = species[SP2] + species[SP3] + species[SP7] + 2 * species[SP8] - species[SP1];
        end SubModel4;

        connector SubModel5  
          flow Real Q;
          Real[States] states;
          Real[Composites] composites;
          Real[Species] species;
        end SubModel5;
      end Model2;
    end ModelContainer2;

    package ModelContainer1  
      package Model1  
        encapsulated type States = enumeration(S1, X1, S2);
        encapsulated type Composites = enumeration(C1, C2);
        encapsulated type Species = enumeration(SP1);

        class SubModel1  "SubModel1" 
          Real[States] states "State variable concentrations";
          parameter Real S2 = 0.0;
          parameter Real S1 = 120.0;
          parameter Real X1 = 40.0;
        equation
          states[States.S2] = S2;
          states[States.S1] = S1;
          states[States.X1] = X1;
        end SubModel1;

        class Parameters  
          parameter Real p1 = 6.0;
          parameter Real p2 = 0.62;
          parameter Real K_S1 = 20.0;
          parameter Real K_S2 = 0.2;
          parameter Real p3 = 0.67;
        end Parameters;

        class SubModel3  
          Parameters parameters;
          Real[States] states;
          Real[Composites] composites;
          constant States S1 = States.S1;
          constant States X1 = States.X1;
          constant Composites C1 = Composites.C1;
          constant Composites C2 = Composites.C2;
        equation
          composites[C1] = states[S1] + states[X1];
          composites[C2] = states[S1] + states[X1];
        end SubModel3;

        class SubModel4  
          Parameters parameters;
          Real[States] states;
          Real[Species] species;
          constant Species SP1 = Species.SP1;
        equation
          species[SP1] = 7.0;
        end SubModel4;

        connector SubModel5  
          flow Real Q;
          Real[States] states "State variable concentrations";
          Real[Composites] composites "Composite variable concentrations";
          Real[Species] species "Ionic species";
        end SubModel5;
      end Model1;
    end ModelContainer1;
  end Models;

  package Containers  
    package Container1  
      package SubContainer1  
        class Unit2  "Unit2" 
          replaceable TestLibrary.Models.ModelContainer1.Model1.SubModel5 sm5;
        end Unit2;

        class Unit1  "Unit1" 
          replaceable TestLibrary.Models.ModelContainer1.Model1.SubModel5 sm5;
          replaceable TestLibrary.Models.ModelContainer1.Model1.SubModel1 sm1;
          replaceable TestLibrary.Models.ModelContainer1.Model1.SubModel3 sm3;
          replaceable TestLibrary.Models.ModelContainer1.Model1.SubModel4 sm4;
          parameter Real Q = 10000;
        equation
          sm3.states = sm1.states;
          sm4.states = sm1.states;
          sm5.Q = -Q;
          sm5.states = sm1.states;
          sm5.composites = sm3.composites;
          sm5.species = sm4.species;
        end Unit1;
      end SubContainer1;
    end Container1;
  end Containers;
end TestLibrary;

model Model2Test_total
  extends Model2Test;
end Model2Test_total;
