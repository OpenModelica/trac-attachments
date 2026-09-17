package Reactor
    // Package for study of nonlinear reactor adapted from Seborg et al.
    // author:     Bernt Lie
    //            University College of Southeast Norway
    //            June 16, 2016
    //
    model ModReactor
        // Reactor model in Ex 2.5 of Seborg et al. (2011), 
        // Process Dynamics and Control
        //
        // author:     Bernt Lie
        //            University College of Southeast Norway
        //            June 16, 2016
        //
        // Parameters
        parameter Real V = 100 "Reactor vessel volume; L";
        parameter Real k0 = exp(8750/350) "Preexponential factor, reaction; 1/min";
        parameter Real EdR = 8750 "Activation 'temperature'; K";
        parameter Real dHr = -5e4 "Specific reaction enthalpy; J/mol";
        parameter Real rho = 1e3 "Density, reactor fluid; g/L";
        parameter Real cp = 0.239 "Specific heat capacity, reactor fluid; J/(g.K)";
        parameter Real UA = 5e4 "Heat transfer parameter; J/(min.K)";
        // Initial state parameter
        parameter Real cA0 = 0.5 "Initial cA; mol/L";
        parameter Real nA0 = cA0*V "Initial 'real' state nA; mol";
        parameter Real T0 = 350 "Initial T; K";
        // Declaring variables
        // -- states
        Real nA(start = nA0, fixed = true);    // initial # moles of A in vessel; mol
        Real T(start = T0, fixed = true);    // initial temperature in vessel; K
        // -- auxiliary variables
        Real ndAi "Influent of A; mol/min";
        Real ndAe "Effluent of A; mol/min";
        Real ndAg "Generation rate of A; mol/min";
        Real r "Rate of reaction; mol/(L.min)";
        Real Qd "Heat flow from cooling fluid to reactor vessel; J/min";
        // Inputs
        input Real Vd "Volumetric flow through reactor vessel; L/min";
        input Real cAi "Reactor vessel influent concentration of A; mol/min";
        input Real Ti "Reactor vessel influent temperature; K";
        input Real Tci "Cooling circuit influent temperature; K";
        // Outputs
        output Real cA "Reactor concentration; mol/L";
    equation
        nA = V*cA;
        ndAi = Vd*cAi;
        ndAe = Vd*cA;
        ndAg = -V*r;
        r = k0*exp(-EdR/T)*cA;
        Qd = UA*(Tci-T);
        //
        der(nA) = ndAi - ndAe + ndAg;
        V*rho*cp*der(T) = rho*cp*Vd*(Ti-T) + (-dHr)*r*V + Qd;
    end ModReactor;
    // End package
end Reactor;