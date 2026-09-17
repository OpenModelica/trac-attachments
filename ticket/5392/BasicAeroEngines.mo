package BasicAeroEngines
  extends Modelica.Icons.Package;

  package Examples "Working examples of system models"
    extends Modelica.Icons.ExamplesPackage;
  end Examples;

  package Components "Components of aeroengines"
    extends Modelica.Icons.Library;

    model Environment "Outer model providing environmental conditions to components"
      constant Modelica.SIunits.Pressure A "Coefficient of standard atmospheric model";
      constant Modelica.SIunits.Length H0 "Scale length of standard atmospheric model";
      Modelica.Blocks.Interfaces.RealInput temperature "Temperature in K" annotation(
        Placement(visible = true, transformation(origin = {-100, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput altitude "Altitude in m" annotation(
        Placement(visible = true, transformation(origin = {-90, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput airspeed "Airspeed in m/s" annotation(
        Placement(visible = true, transformation(origin = {-80, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    
      Modelica.SIunits.Temperature T "Air temperature";
      Modelica.SIunits.Length H "Height of the engine above sea level";
      Modelica.SIunits.Velocity v "Airspeed";
      Modelica.SIunits.Pressure P "Air pressure";
    equation
      T = temperature;
      H = altitude;
      v = airspeed;
      P = A*exp(-H/H0);
    annotation(
        Icon(graphics = {Rectangle(fillColor = {110, 156, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Ellipse(origin = {-33, -15}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-41, 19}, {41, -19}}, endAngle = 360), Ellipse(origin = {-1, -41}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-41, 19}, {31, -11}}, endAngle = 360), Ellipse(origin = {25, -3}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-41, 19}, {31, -11}}, endAngle = 360), Ellipse(origin = {57, 58}, lineColor = {255, 255, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{25, 24}, {-25, -24}}, endAngle = 360)}, coordinateSystem(initialScale = 0.1)));
    end Environment;

    model Intake "Intake model converting forward speed into static pressure"
      outer Environment environment;
    annotation (
        defaultComponentName="environment",
        defaultComponentPrefixes="inner",
        missingInnerMessage="No \"environment\" component is defined. Please drag BasicAeroEngines.Components.Environment into the top level of your model.",
  Icon(graphics = {Polygon(fillColor = {150, 150, 150}, fillPattern = FillPattern.Solid, points = {{-60, 100}, {-60, -100}, {60, -60}, {60, 60}, {60, 60}, {-60, 100}})}));
    end Intake;

    model CompressorMapsBetaLines "Compressor model using non-dimensional maps and beta lines"
    end CompressorMapsBetaLines;

    model TurbineStodolaEtaMap "Turbine model using Stodola's ellipse law and non-dimensional efficiency maps"
    end TurbineStodolaEtaMap;

    model NozzleExhaust "Nozzle exhaust model converting static pressure into thrust"
    end NozzleExhaust;

    model CombustionChamberLHV "Simple model of combustion chamber with given fuel LHV and CnHmOq chemical composition"
    end CombustionChamberLHV;
  end Components;

  package Interfaces "Connectors"
    extends Modelica.Icons.InterfacesPackage;
    
    connector AirPort "Fluid port for air working medium"
      package Medium = Media.Air;
      Medium.AbsolutePressure P "Static pressure";
      Medium.MassFlowRate f "Mass flow rate (positive entering)";
      Medium.SpecificEnthalpy h_L "Specific enthalpy of leaving fluid";
      annotation(
        Icon(graphics = {Ellipse(lineColor = {170, 223, 255}, fillColor = {170, 223, 255}, fillPattern = FillPattern.Solid,extent = {{-100, 100}, {100, -100}}, endAngle = 360)}));
    end AirPort;
  
    connector ExhaustPort "Fluid port for exhaust gas working medium"
      package Medium = Media.Exhaust;
      Medium.AbsolutePressure P "Static pressure";
      Medium.MassFlowRate f "Mass flow rate (positive entering)";
      Medium.SpecificEnthalpy h_L "Specific enthalpy of leaving fluid";
      Medium.MassFraction X_L[Medium.nX] "Composition of leaving fluid";
      annotation(
        Icon(graphics = {Ellipse(lineColor = {170, 223, 255}, fillColor = {170, 223, 255}, fillPattern = FillPattern.Solid,extent = {{-100, 100}, {100, -100}}, endAngle = 360)}));
    end ExhaustPort;
  
  end Interfaces;

  package BaseClasses "Base models"
    extends Modelica.Icons.BasesPackage;
  end BaseClasses;
  
  package Types "Record definitions"
    extends Modelica.Icons.BasesPackage;
  end Types;

  package Media "Working medium models"
    extends Modelica.Icons.MaterialPropertiesPackage;
    
    package Air
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
        mediumName="SimpleAirN2O2",
        data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,
              Modelica.Media.IdealGases.Common.SingleGasesData.O2},
        fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,
                        Modelica.Media.IdealGases.Common.FluidData.O2},
        substanceNames = {"Nitrogen", "Oxygen"},
        reference_X={0.768,0.232});
    end Air;
    
    package ExhaustGas
      extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
       mediumName="ExhaustGas",
       data={Common.SingleGasesData.N2,
             Common.SingleGasesData.O2,
             Common.SingleGasesData.H2O,
             Common.SingleGasesData.CO2},
       fluidConstants={Common.FluidData.N2,
                       Common.FluidData.O2,
                       Common.FluidData.H2O,
                       Common.FluidData.CO2},
       substanceNames = {"Nitrogen","Oxygen","Water", "Carbondioxide"},
       reference_X={0.768,0.232,0.0,0.0});
    end ExhaustGas;
  end Media;

  package Tests "Test models for individual components"
    extends Modelica.Icons.ExamplesPackage;
  end Tests;
  annotation(
    uses(Modelica(version = "3.2.2")));
end BasicAeroEngines;
