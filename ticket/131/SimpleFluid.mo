package SimpleFluid 
  "Simplified models of fluid systems for advanced solver testing" 
  import SI = Modelica.SIunits;
  package Interfaces 
    connector FlangeA "Type-A connector" 
      SI.Pressure p "Pressure";
      flow SI.MassFlowRate w "Mass flowrate";
      output SI.SpecificEnthalpy hAB 
        "Specific enthalpy of fluid flowing from A to B";
      input SI.SpecificEnthalpy hBA 
        "Specific enthalpy of fluid flowing from B to A";
    end FlangeA;
    
    connector FlangeB "Type-B connector" 
      SI.Pressure p "Pressure";
      flow SI.MassFlowRate w "Mass flowrate";
      input SI.SpecificEnthalpy hAB 
        "Specific enthalpy of fluid flowing from A to B";
      output SI.SpecificEnthalpy hBA 
        "Specific enthalpy of fluid flowing from B to A";
    end FlangeB;
    
    connector Thermal_Port 
        SI.Temperature T "Port temperature";
        flow SI.HeatFlowRate Q_flow 
        "Heat flow rate (positive if flowing from outside into the component)";
      annotation (Icon(
                Rectangle(extent=[-40,60; 60,-40],   style(color=42,
                fillColor=42))));
    end Thermal_Port;
  end Interfaces;
  
  package Media 
    partial model BaseProperties 
      "Interface of medium model for all type of media" 
      connector InputPressure =    input SI.Pressure;
      connector InputTemperature = input SI.Temperature;
      InputPressure p(start = 1e5);
      InputTemperature T(start = 300);
      SI.SpecificEnthalpy h;
      SI.Density d(start = 10);
      SI.SpecificInternalEnergy u;
      Real dddp "dd/dp|T";
      Real dddT "dd/dT|p";
      Real dhdp "dh/dp|T";
      Real cp "dh/dT|p";
    end BaseProperties;
    
    model Air "Model of standard air" 
      extends BaseProperties(cp = R/MM*3.5);
      constant Real R(final unit="J/(mol.K)") =  Modelica.Constants.R;
      constant SI.MolarMass MM = 0.029;
    equation 
      h = cp*T;
      p = d*R/MM*T;
      u = h - p/d;
      dddp = 1/(R/MM*T);
      dddT = -d/T;
      dhdp = 0;
    end Air;
  end Media;
  annotation (uses(Modelica(version="2.2.1")));
  package Components 
    model SourceP 
      parameter SI.Pressure p;
      parameter SI.Temperature T;
      Interfaces.FlangeB flange annotation (extent=[90,-10; 110,10]);
      //replaceable model Medium = SimpleFluid.Media.BaseProperties;// This is correct but is not working with OMC
      replaceable model Medium = Media.Air;
      Medium medium;
    equation 
      medium.p = p;
      medium.T = T;
      
      flange.p = p;
      flange.hBA = medium.h;
      annotation (Diagram, Icon(Ellipse(extent=[-90,86; 90,-86], style(color=3,
                rgbcolor={0,0,255}))));
    end SourceP;
    
    model SinkP 
      parameter SI.Pressure p;
      parameter SI.Temperature T;
      Interfaces.FlangeA flange annotation (extent=[-112,-12; -92,8]);
      //replaceable model Medium = SimpleFluid.Media.BaseProperties;// This is correct but is not working with OMC
      replaceable model Medium = Media.Air;
      Medium medium;
    equation 
      medium.p = p;
      medium.T = T;
      
      flange.p = p;
      flange.hAB = medium.h;
      annotation (Icon(Ellipse(extent=[-90,86; 90,-86], style(color=3, rgbcolor=
                 {0,0,255}))), Diagram);
    end SinkP;
    
    model ValveLinear 
      Modelica.Blocks.Interfaces.RealInput u "Valve opening in p.u." 
        annotation (extent=[-20,20; 20,60], rotation=270);
      parameter Real Kv "Hydraulic conductance at full opening";
      SI.MassFlowRate w;
      SI.Pressure dp;
      Interfaces.FlangeA inlet annotation (extent=[-108,-10; -88,10]);
      Interfaces.FlangeB outlet annotation (extent=[90,-10; 110,10]);
    equation 
      // Flow equation
      w = Kv*u*dp;
      
      // Boundary conditions
      w = inlet.w;
      dp = inlet.p - outlet.p;
      
      // Mass balance
      inlet.w + outlet.w = 0;
      
      // Energy balance
      inlet.hBA = outlet.hBA;
      inlet.hAB = outlet.hAB;
      annotation (Icon(Polygon(points=[-80,42; 80,-40; 80,40; -80,-40; -80,42],
              style(color=3, rgbcolor={0,0,255}))), Diagram);
    end ValveLinear;
    
    model PressDropLinear 
      parameter Real Kv "Hydraulic conductance at full opening";
      SI.MassFlowRate w;
      SI.Pressure dp;
      Interfaces.FlangeA inlet annotation (extent=[-108,-10; -88,10]);
      Interfaces.FlangeB outlet annotation (extent=[90,-10; 110,10]);
    equation 
      // Flow equation
      w = Kv*dp;
      
      // Boundary conditions
      w = inlet.w;
      dp = inlet.p - outlet.p;
      
      // Mass balance
      inlet.w + outlet.w = 0;
      
      // Energy balance
      inlet.hBA = outlet.hBA;
      inlet.hAB = outlet.hAB;
      annotation (Icon(Rectangle(extent=[-88,20; 90,-20], style(color=3,
                rgbcolor={0,0,255}))), Diagram);
    end PressDropLinear;
    
    model Volume "ControlVolume" 
      replaceable model Medium = SimpleFluid.Media.BaseProperties;
      // Temporary fix:
      // replaceable model Medium = SimpleFluid.Media.Air;
      Medium medium(p(start = pstart,fixed=false), T(start=Tstart,fixed=false)) 
        "Medium properties";
      parameter SI.Volume V;
      parameter SI.Pressure pstart;
      parameter SI.Temperature Tstart;
      Interfaces.FlangeA inlet annotation (extent=[-112,-8; -92,12]);
      Interfaces.FlangeB outlet annotation (extent=[90,-8; 110,12]);
      Interfaces.Thermal_Port thermalPort 
        annotation (extent=[-10,88; 10,108]);
      SI.MassFlowRate win;
      SI.MassFlowRate wout;
      SI.SpecificEnthalpy hin;
      SI.SpecificEnthalpy hout;
      SI.Power Q;
      SI.Mass M;
      SI.Energy U;
      Real derM;
      Real derh;
      Real derU;
    equation 
      M = medium.d*V;
      U = M*medium.u;
      
    /*
  derM = der(M);
  derU = der(U);
  U = Mh - PV
*/
      
      derM = V*(medium.dddp*der(medium.p) + medium.dddT*der(medium.T));
      derh = medium.dhdp*der(medium.p) + medium.cp*der(medium.T);
      derU = M*derh + derM*medium.h - der(medium.p)*V;
      
      derM = win - wout;
      derU = win*hin - wout*hout + Q;
      
      // Boundary conditions
      hin = if win > 0 then inlet.hBA else medium.h;
      hout = if wout > 0 then medium.h else outlet.hAB;
      
      win = inlet.w;
      wout = -outlet.w;
      medium.p = inlet.p;
      medium.p = outlet.p;
      thermalPort.Q_flow = Q;
      thermalPort.T = medium.T;
      inlet.hAB = medium.h;
      outlet.hBA = medium.h;
      annotation (Icon(Ellipse(extent=[-90,88; 90,-82], style(
              color=3,
              rgbcolor={0,0,255},
              fillColor=3,
              rgbfillColor={0,0,255}))), Diagram);
    end Volume;
  end Components;
  
  package Examples 
    model Test1 
      
      Components.SourceP sourceP(
        T=300,
        redeclare model Medium = Media.Air,
        p=2e5) annotation (extent=[-44,-10; -24,10]);
      Components.SinkP sinkP(
        p=1e5,
        T=300,
        redeclare model Medium = Media.Air) annotation (extent=[18,-10; 38,10]);
      Components.PressDropLinear pressDropLinear(Kv=1/1e5) 
        annotation (extent=[-16,-10; 4,10]);
      annotation (Diagram);
    equation 
      connect(sourceP.flange, pressDropLinear.inlet) annotation (points=[-24,
            6.10623e-16; -21.95,6.10623e-16; -21.95,1.22125e-15; -19.9,
            1.22125e-15; -19.9,6.10623e-16; -15.8,6.10623e-16],
                      style(color=3, rgbcolor={0,0,255}));
      connect(pressDropLinear.outlet, sinkP.flange) annotation (points=[4,
            6.10623e-16; 10.9,6.10623e-16; 10.9,-0.2; 17.8,-0.2],
                                           style(color=3, rgbcolor={0,0,255}));
    end Test1;
    
    model Test2 
      
      Components.SourceP sourceP(
        T=300,
        redeclare model Medium = Media.Air,
        p=2e5) annotation (extent=[-44,-10; -24,10]);
      Components.SinkP sinkP(
        p=1e5,
        T=300,
        redeclare model Medium = Media.Air) annotation (extent=[46,-10; 66,10]);
      annotation (
        Diagram,
        experiment(StopTime=3),
        experimentSetupOutput);
      Components.ValveLinear valveLinear(Kv=1/1e5) 
        annotation (extent=[0,-8; 20,12]);
      Modelica.Blocks.Sources.Ramp ramp(
        height=-0.5,
        duration=1,
        offset=1,
        startTime=1) annotation (extent=[-40,26; -20,46]);
    equation 
      connect(sourceP.flange, valveLinear.inlet) annotation (points=[-24,
            6.10623e-16; -11.9,6.10623e-16; -11.9,2; 0.2,2],
                                      style(color=3, rgbcolor={0,0,255}));
      connect(valveLinear.outlet, sinkP.flange) annotation (points=[20,2; 34,2;
            34,-0.2; 45.8,-0.2], style(color=3, rgbcolor={0,0,255}));
      connect(ramp.y, valveLinear.u) annotation (points=[-19,36; 10,36; 10,6],
          style(color=74, rgbcolor={0,0,127}));
    end Test2;
    
    model Test3 
      
      Components.SourceP sourceP(
        T=300,
        redeclare model Medium = Media.Air,
        p=3e5) annotation (extent=[-44,-10; -24,10]);
      Components.SinkP sinkP(
        p=1e5,
        T=300,
        redeclare model Medium = Media.Air) annotation (extent=[64,-10; 84,10]);
      Components.PressDropLinear pressDropLinear(Kv=0.1/1e5) 
        annotation (extent=[-16,-10; 4,10]);
      annotation (
        Diagram,
        experiment(StopTime=3),
        experimentSetupOutput);
      Components.Volume volume(
        pstart=2e5,
        Tstart=300,
        redeclare model Medium = Media.Air,
        V=0.02)                             annotation (extent=[10,-10; 30,10]);
      Components.ValveLinear valveLinear(Kv=0.1/1e5) 
        annotation (extent=[40,-10; 60,10]);
      Modelica.Blocks.Sources.Ramp step(
        height=-0.5,
        offset=1,
        startTime=1,
        duration=0.001) 
                     annotation (extent=[-36,38; -16,58]);
      
    initial equation 
    // pressDropLinear.w = 0.1;
    // pressDropLinear.w = 1e5;
    volume.medium.p = volume.pstart;
    volume.medium.T = volume.Tstart;
    // valveLinear.w = 0.1;
    // valveLinear.dp = 1e5;
      
    equation 
      connect(sourceP.flange, pressDropLinear.inlet) annotation (points=[-24,0;
            -21.95,0; -21.95,1.22125e-015; -19.9,1.22125e-015; -19.9,0; -15.8,0],
                      style(color=3, rgbcolor={0,0,255}));
      connect(pressDropLinear.outlet, volume.inlet) annotation (points=[4,0; 8.9,
            0; 8.9,0.2; 9.8,0.2],     style(color=3, rgbcolor={0,0,255}));
      connect(volume.outlet, valveLinear.inlet) annotation (points=[30,0.2; 38,
            0.2; 38,0; 40.2,0], style(color=3, rgbcolor={0,0,255}));
      connect(valveLinear.outlet, sinkP.flange) annotation (points=[60,0; 61.9,
            0; 61.9,-0.2; 63.8,-0.2], style(color=3, rgbcolor={0,0,255}));
      connect(step.y, valveLinear.u) annotation (points=[-15,48; 50,48; 50,4],
          style(color=74, rgbcolor={0,0,127}));
    end Test3;
    
    model Test4 
      
      Components.SourceP sourceP(
        T=300,
        redeclare model Medium = Media.Air,
        p=3e5) annotation (extent=[-44,-10; -24,10]);
      Components.SinkP sinkP(
        p=1e5,
        T=300,
        redeclare model Medium = Media.Air) annotation (extent=[64,-10; 84,10]);
      Components.PressDropLinear pressDropLinear(Kv=0.1/1e5) 
        annotation (extent=[-16,-10; 4,10]);
      annotation (
        Diagram,
        experiment(StopTime=3),
        experimentSetupOutput);
      Components.Volume volume(
        pstart=2e5,
        Tstart=300,
        redeclare model Medium = Media.Air,
        V=0.02)                             annotation (extent=[10,-10; 30,10]);
      Components.ValveLinear valveLinear(Kv=0.1/1e5) 
        annotation (extent=[40,-10; 60,10]);
      Modelica.Blocks.Sources.Ramp step(
        height=-0.5,
        offset=1,
        startTime=1,
        duration=0.001) 
                     annotation (extent=[-36,38; -16,58]);
      
    initial equation 
    // pressDropLinear.w = 0.1;
    // pressDropLinear.w = 1e5;
    // volume.medium.p = volume.pstart;
    // volume.medium.T = volume.Tstart;
    der(volume.medium.p) = 0;
    der(volume.medium.T) = 0;
    // valveLinear.w = 0.1;
    // valveLinear.dp = 1e5;
      
    equation 
      connect(sourceP.flange, pressDropLinear.inlet) annotation (points=[-24,0;
            -21.95,0; -21.95,1.22125e-015; -19.9,1.22125e-015; -19.9,0; -15.8,0],
                      style(color=3, rgbcolor={0,0,255}));
      connect(pressDropLinear.outlet, volume.inlet) annotation (points=[4,0; 8.9,
            0; 8.9,0.2; 9.8,0.2],     style(color=3, rgbcolor={0,0,255}));
      connect(volume.outlet, valveLinear.inlet) annotation (points=[30,0.2; 38,
            0.2; 38,0; 40.2,0], style(color=3, rgbcolor={0,0,255}));
      connect(valveLinear.outlet, sinkP.flange) annotation (points=[60,0; 61.9,
            0; 61.9,-0.2; 63.8,-0.2], style(color=3, rgbcolor={0,0,255}));
      connect(step.y, valveLinear.u) annotation (points=[-15,48; 50,48; 50,4],
          style(color=74, rgbcolor={0,0,127}));
    end Test4;
  end Examples;
end SimpleFluid;
