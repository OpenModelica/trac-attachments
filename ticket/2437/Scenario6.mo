package SystemDynamics  "System Dynamics Library (Version 2.1)" 
  package Interfaces  "Connectors and partial models of the System Dynamics methodology" 
    extends Modelica.Icons.Library;
    connector MassInPort = Modelica.Blocks.Interfaces.RealInput "Mass flow input signal" annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Polygon(visible = true, lineColor = {95, 0, 191}, fillColor = {95, 0, 191}, fillPattern = FillPattern.Solid, points = {{0.0, 50.0}, {100.0, 0.0}, {0.0, -50.0}, {0.0, 50.0}})}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, fillPattern = FillPattern.Solid, lineColor = {95, 0, 191}, fillColor = {95, 0, 191})}));
    connector MassOutPort = Modelica.Blocks.Interfaces.RealOutput "Mass flow output signal" annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Polygon(visible = true, lineColor = {95, 0, 191}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100.0, 50.0}, {0.0, 0.0}, {-100.0, -50.0}, {-100.0, 50.0}})}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, fillPattern = FillPattern.Solid, lineColor = {95, 0, 191}, fillColor = {255, 255, 255})}));

    partial block Nonlin_2  "Non-linear function with two inputs" 
      Modelica.Blocks.Interfaces.RealInput u1 "First input variable" annotation(Placement(visible = true, transformation(origin = {-90.0, 40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-90.0, 40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u2 "Second input variable" annotation(Placement(visible = true, transformation(origin = {-90.0, -40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-90.0, -40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {90.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {90.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      annotation(Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{-80.0, 80.0}, {-80.0, -80.0}, {20.0, -80.0}, {80.0, 0.0}, {20.0, 80.0}, {-80.0, 80.0}}, color = {0, 0, 255}, thickness = 0.5), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-80.0, -40.0}, {80.0, 40.0}}, textString = "y = f(u1,u2)", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-76.0, 30.0}, {-54.0, 50.0}}, textString = "u1", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-76.0, -50.0}, {-54.0, -30.0}}, textString = "u2", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-100.0, 80.0}, {100.0, 118.0}}, textString = "%name", fontName = "Arial")}), Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{-80.0, 80.0}, {-80.0, -80.0}, {20.0, -80.0}, {80.0, 0.0}, {20.0, 80.0}, {-80.0, 80.0}}, color = {0, 0, 255}, thickness = 0.5), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-80.0, -40.0}, {80.0, 40.0}}, textString = "y = f(u1,u2)", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-76.0, 30.0}, {-54.0, 50.0}}, textString = "u1", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-76.0, -50.0}, {-54.0, -30.0}}, textString = "u2", fontName = "Arial")}), Documentation(info = "<html>
       General non-linear function with two explicit inputs.
       </html>")); 
    end Nonlin_2;
    annotation(preferedView = "info", Documentation(info = "<html>
     This package contains the mass flow connectors of the System Dynamics methodology and some partial models that are used elsewhere.
     </html>")); 
  end Interfaces;

  package Auxiliary  "Auxiliary elements of the System Dynamics methodology" 
    extends Modelica.Icons.Library;

    block Const  "A constant factor" 
      parameter Real k = 0 "Constant additive term";
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
    equation
      y = k;
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}})}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}}), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-60.0, -30.0}, {60.0, 34.0}}, textString = "k=%k", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-100.0, -112.0}, {100.0, -70.0}}, textString = "%name", fontName = "Arial")}), Documentation(info = "<html>
       System Dynamics constant factor model.
       </html>")); 
    end Const;

    block Gain  "Gain factor" 
      parameter Real k = 1 "Constant multiplicative factor";
      Modelica.Blocks.Interfaces.RealInput u "Input variable" annotation(Placement(visible = true, transformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
    equation
      y = k * u;
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 0, 255}, extent = {{-60.0, -60.0}, {60.0, 60.0}})}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 0, 255}, extent = {{-60.0, -60.0}, {60.0, 60.0}}), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-60.0, -20.0}, {60.0, 20.0}}, textString = "k = %k", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-98.0, -118.0}, {100.0, -80.0}}, textString = "%name", fontName = "Arial")}), Documentation(info = "<html>
       Amplification gain factor.
       </html>")); 
    end Gain;

    block Prod_2  "Product of two influencing factors" 
      Modelica.Blocks.Interfaces.RealInput u1 "First input variable" annotation(Placement(visible = true, transformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u2 "Second input variable" annotation(Placement(visible = true, transformation(origin = {70.0, 0.0}, extent = {{10.0, -10.0}, {-10.0, 10.0}}, rotation = 0), iconTransformation(origin = {70.0, 0.0}, extent = {{10.0, -10.0}, {-10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
    equation
      y = u1 * u2;
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}}), Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5)}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}}), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-38.0, -44.0}, {40.0, 44.0}}, textString = "", fontName = "Arial"), Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5)}), Documentation(info = "<html>
       Product of two influencing factors.
       </html>")); 
    end Prod_2;

    block Prod_3  "Product of three influencing factors" 
      Modelica.Blocks.Interfaces.RealInput u1 "First input variable" annotation(Placement(visible = true, transformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u2 "Second input variable" annotation(Placement(visible = true, transformation(origin = {0.0, -70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {0.0, -70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
      Modelica.Blocks.Interfaces.RealInput u3 "Third input variable" annotation(Placement(visible = true, transformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -180), iconTransformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -180)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
    equation
      y = u1 * u2 * u3;
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5), Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}})}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}}), Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5)}), Documentation(info = "<html>
       Product of three influencing factors.
       </html>")); 
    end Prod_3;

    block Prod_4  "Product of four influencing factors" 
      Modelica.Blocks.Interfaces.RealInput u1 "First input variable" annotation(Placement(visible = true, transformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u2 "Second input variable" annotation(Placement(visible = true, transformation(origin = {-40.0, -56.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {-40.0, -56.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
      Modelica.Blocks.Interfaces.RealInput u3 "Third input variable" annotation(Placement(visible = true, transformation(origin = {40.0, -56.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {40.0, -56.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
      Modelica.Blocks.Interfaces.RealInput u4 "Fourth input variable" annotation(Placement(visible = true, transformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -180), iconTransformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -180)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
    equation
      y = u1 * u2 * u3 * u4;
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}})}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}}), Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5)}), Documentation(info = "<html>
       Product of four influencing factors.
       </html>")); 
    end Prod_4;

    block Prod_5  "Product of five influencing factors" 
      Modelica.Blocks.Interfaces.RealInput u1 "First input variable" annotation(Placement(visible = true, transformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u2 "Second input variable" annotation(Placement(visible = true, transformation(origin = {-46.0, -50.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {-46.0, -50.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
      Modelica.Blocks.Interfaces.RealInput u3 "Third input variable" annotation(Placement(visible = true, transformation(origin = {0.0, -70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {0.0, -70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
      Modelica.Blocks.Interfaces.RealInput u4 "Fourth input variable" annotation(Placement(visible = true, transformation(origin = {46.0, -50.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {46.0, -50.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
      Modelica.Blocks.Interfaces.RealInput u5 "Fifth input variable" annotation(Placement(visible = true, transformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -180), iconTransformation(origin = {70.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -180)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270), iconTransformation(origin = {0.0, 70.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = -270)));
    equation
      y = u1 * u2 * u3 * u4 * u5;
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}})}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-60.0, -60.0}, {60.0, 60.0}}), Line(visible = true, points = {{-30.0, 0.0}, {30.0, 0.0}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, -25.99}, {15.0, 25.99}}, color = {0, 0, 255}, thickness = 0.5), Line(visible = true, points = {{-15.0, 25.99}, {15.0, -25.99}}, color = {0, 0, 255}, thickness = 0.5)}), Documentation(info = "<html>
       Product of five influencing factors.
       </html>")); 
    end Prod_5;
    annotation(preferedView = "info", Documentation(info = "<html>
     This package contains a set of simple static relationships that are frequently used in the System Dynamics approach to modeling.
     </html>")); 
  end Auxiliary;

  package Functions  "Functions of the System Dynamics methodology" 
    extends Modelica.Icons.Library annotation(preferedView = "info", Documentation(info = "<html>
      This package contains a number of standard functional relationships used in the System Dynamics methodology.
      </html>"));

    block Linear  "Linear function" 
      parameter Real m = 1 "Gradient";
      parameter Real b = 0 "Offset";
      Modelica.Blocks.Interfaces.RealInput u "Input variable" annotation(Placement(visible = true, transformation(origin = {-90.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-90.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {90.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {90.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
    equation
      y = m * u + b;
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-80.0, -80.0}, {80.0, 80.0}}), Line(visible = true, points = {{-40.0, -40.0}, {-40.0, 60.0}, {-44.0, 48.0}, {-36.0, 48.0}, {-40.0, 58.0}}, color = {0, 0, 255}), Line(visible = true, points = {{-40.0, -40.0}, {60.0, -40.0}, {48.0, -34.0}, {48.0, -44.0}, {60.0, -40.0}}, color = {0, 0, 255}), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-64.0, 38.0}, {-46.0, 62.0}}, textString = "y", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{40.0, -70.0}, {62.0, -50.0}}, textString = "u", fontName = "Arial"), Line(visible = true, points = {{-40.0, -10.0}, {48.0, 30.0}}, color = {0, 0, 255})}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-80.0, -80.0}, {80.0, 80.0}}), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-98.0, -118.0}, {100.0, -80.0}}, textString = "%name", fontName = "Arial"), Line(visible = true, points = {{-40.0, -40.0}, {-40.0, 60.0}, {-44.0, 48.0}, {-36.0, 48.0}, {-40.0, 58.0}}, color = {0, 0, 255}), Line(visible = true, points = {{-40.0, -40.0}, {60.0, -40.0}, {48.0, -34.0}, {48.0, -44.0}, {60.0, -40.0}}, color = {0, 0, 255}), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-64.0, 38.0}, {-46.0, 62.0}}, textString = "y", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{40.0, -70.0}, {62.0, -50.0}}, textString = "u", fontName = "Arial"), Line(visible = true, points = {{-40.0, -10.0}, {48.0, 30.0}}, color = {0, 0, 255})}), Documentation(info = "<html>
       This is a linear function, as it is frequently used in System Dynamics to represent linear regression models.
       </html>")); 
    end Linear;

    block Tabular  "Tabular function" 
      parameter Real[:] x_vals = {0} "Independent variable data points";
      parameter Real[:] y_vals = {0} "Dependent variable data points";
      Modelica.Blocks.Interfaces.RealInput u "Input variable" annotation(Placement(visible = true, transformation(origin = {-80.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-80.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Output variable" annotation(Placement(visible = true, transformation(origin = {110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
    equation
      y = Functions.Utilities.Piecewise(x = u, x_grid = x_vals, y_grid = y_vals);
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Line(visible = true, points = {{-70.0, 0.0}, {-44.0, 0.0}}, color = {160, 160, 160}), Line(visible = true, points = {{28.0, 0.0}, {100.0, 0.0}}, color = {160, 160, 160}), Text(visible = true, lineColor = {0, 0, 255}, fillColor = {160, 160, 160}, extent = {{-72.0, 2.0}, {-46.0, 20.0}}, textString = "u", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, fillColor = {160, 160, 160}, extent = {{52.0, 2.0}, {78.0, 20.0}}, textString = "y", fontName = "Arial"), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, 40.0}, {-8.0, 60.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, 20.0}, {-8.0, 40.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -2.0}, {-8.0, 20.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -22.0}, {-8.0, 0.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -42.0}, {-8.0, -20.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -60.0}, {-8.0, -40.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, 40.0}, {28.0, 60.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, 20.0}, {28.0, 40.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -2.0}, {28.0, 20.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -20.0}, {28.0, 0.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -40.0}, {28.0, -20.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -60.0}, {28.0, -40.0}})}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, 40.0}, {-8.0, 60.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, 20.0}, {-8.0, 40.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -2.0}, {-8.0, 20.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -22.0}, {-8.0, 0.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -42.0}, {-8.0, -20.0}}), Rectangle(visible = true, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-44.0, -60.0}, {-8.0, -40.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, 40.0}, {28.0, 60.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, 20.0}, {28.0, 40.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -2.0}, {28.0, 20.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -20.0}, {28.0, 0.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -40.0}, {28.0, -20.0}}), Rectangle(visible = true, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-8.0, -60.0}, {28.0, -40.0}}), Line(visible = true, points = {{-70.0, 80.0}, {-70.0, -80.0}, {40.0, -80.0}, {100.0, 0.0}, {40.0, 80.0}, {-70.0, 80.0}}, color = {0, 0, 255}, thickness = 0.5), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-100.0, 80.0}, {100.0, 122.0}}, textString = "%name", fontName = "Arial")}), Documentation(info = "<html>
       This is a tabular function, as it is frequently used in System Dynamics to represent measured or estimated non-linear relationships.
       </html>")); 
    end Tabular;

    package Utilities  "Utility modules of the set of functions" 
      extends Modelica.Icons.Library annotation(preferedView = "info", Documentation(info = "<html>
        Utility models of the set of functions.
        </html>"));

      function Piecewise  "Piecewise linear function" 
        input Real x "Independent variable";
        input Real[:] x_grid "Independent variable data points";
        input Real[:] y_grid "Dependent variable data points";
        output Real y "Interpolated result";
      protected
        Integer n;
      algorithm
        n := size(x_grid, 1);
        assert(size(x_grid, 1) == size(y_grid, 1), "Size mismatch");
        assert(x >= x_grid[1] and x <= x_grid[n], "Out of range");
        for i in 1:n - 1 loop
          if x >= x_grid[i] and x <= x_grid[i + 1] then
            y := y_grid[i] + (y_grid[i + 1] - y_grid[i]) * (x - x_grid[i]) / (x_grid[i + 1] - x_grid[i]);
          else
          end if;
        end for;
        annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-44, 60}, {-8, 40}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, 40}, {-8, 20}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, 20}, {-8, -2}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, 0}, {-8, -22}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, -20}, {-8, -42}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, -40}, {-8, -60}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-8, 60}, {28, 40}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, 40}, {28, 20}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, 20}, {28, -2}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, 0}, {28, -20}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, -20}, {28, -40}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, -40}, {28, -60}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Text(lineColor = {0, 0, 255}, extent = {{-96, 94}, {98, 70}}, textString = "Linear interpolation")}), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-44, 60}, {-8, 40}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, 40}, {-8, 20}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, 20}, {-8, -2}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, 0}, {-8, -22}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, -20}, {-8, -42}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-44, -40}, {-8, -60}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 0}), Rectangle(extent = {{-8, 60}, {28, 40}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, 40}, {28, 20}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, 20}, {28, -2}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, 0}, {28, -20}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, -20}, {28, -40}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}), Rectangle(extent = {{-8, -40}, {28, -60}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, fillColor = {255, 255, 255})})); 
      end Piecewise;
    end Utilities;
  end Functions;

  package Levels  "Levels of the System Dynamics methodology" 
    extends Modelica.Icons.Library annotation(preferedView = "info", Documentation(info = "<html>
      This package contains a set of different <b>Levels</b> (integrators of state variables) frequently used in the System Dynamics methodology.
      </html>"));

    block Level  "General System Dynamics level" 
      parameter Real x0 = 0 "Initial condition";
      output Real level "Continuous state variable";
      Modelica.Blocks.Math.Add Add1(k2 = -1) annotation(Placement(visible = true, transformation(origin = {-40.0, 0.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
      Modelica.Blocks.Continuous.Integrator Integrator1(y_start = x0) annotation(Placement(visible = true, transformation(origin = {20.0, 0.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
      SystemDynamics.Interfaces.MassInPort u1 "Inflow variable" annotation(Placement(visible = true, transformation(origin = {-110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      SystemDynamics.Interfaces.MassInPort u2 "Outflow variable" annotation(Placement(visible = true, transformation(origin = {110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      SystemDynamics.Interfaces.MassOutPort y "State variable" annotation(Placement(visible = true, transformation(origin = {-85.0, 55.0}, extent = {{5.0, -5.0}, {-5.0, 5.0}}, rotation = 0), iconTransformation(origin = {-85.0, 55.0}, extent = {{5.0, -5.0}, {-5.0, 5.0}}, rotation = 0)));
      SystemDynamics.Interfaces.MassOutPort y1 "State variable" annotation(Placement(visible = true, transformation(origin = {85.0, 55.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = 0), iconTransformation(origin = {85.0, 55.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = 0)));
      SystemDynamics.Interfaces.MassOutPort y2 "State variable" annotation(Placement(visible = true, transformation(origin = {75.0, -65.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -90), iconTransformation(origin = {75.0, -65.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -90)));
      SystemDynamics.Interfaces.MassOutPort y3 "State variable" annotation(Placement(visible = true, transformation(origin = {0.0, -65.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -90), iconTransformation(origin = {0.0, -65.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -90)));
      SystemDynamics.Interfaces.MassOutPort y4 "State variable" annotation(Placement(visible = true, transformation(origin = {-75.0, -65.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -90), iconTransformation(origin = {-75.0, -65.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -90)));
    equation
      level = y;
      connect(Add1.y, Integrator1.u) annotation(Line(points = {{-18.0, 0.0}, {-4.0, 0.0}}, color = {0, 0, 255}, visible = true));
      connect(y, Integrator1.y) annotation(Line(points = {{-85.0, 55.0}, {60.0, 55.0}, {60.0, 0.0}, {42.0, 0.0}}, color = {95, 0, 191}, visible = true));
      connect(u1, Add1.u1) annotation(Line(points = {{-110.0, 0.0}, {-80.0, 0.0}, {-80.0, 12.0}, {-64.0, 12.0}}, color = {95, 0, 191}, visible = true));
      connect(u2, Add1.u2) annotation(Line(points = {{110.0, 0.0}, {80.0, 0.0}, {80.0, -40.0}, {-80.0, -40.0}, {-80.0, -12.0}, {-64.0, -12.0}}, color = {95, 0, 191}, visible = true));
      connect(y1, Integrator1.y) annotation(Line(points = {{85.0, 55.0}, {60.0, 55.0}, {60.0, 0.0}, {42.0, 0.0}}, color = {95, 0, 191}, visible = true));
      connect(y2, Integrator1.y) annotation(Line(points = {{75.0, -65.0}, {75.0, -50.0}, {60.0, -50.0}, {60.0, 0.0}, {42.0, 0.0}}, color = {95, 0, 191}, visible = true));
      connect(y3, Integrator1.y) annotation(Line(points = {{0.0, -65.0}, {0.0, -50.0}, {60.0, -50.0}, {60.0, 0.0}, {42.0, 0.0}}, color = {95, 0, 191}, visible = true));
      connect(y4, Integrator1.y) annotation(Line(points = {{-75.0, -65.0}, {-75.0, -50.0}, {60.0, -50.0}, {60.0, 0.0}, {42.0, 0.0}}, color = {95, 0, 191}, visible = true));
      annotation(Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -60.0}, {80.0, 20.0}}), Rectangle(visible = true, lineColor = {127, 0, 255}, lineThickness = 0.5, extent = {{-80.0, -60.0}, {80.0, 60.0}}), Line(visible = true, points = {{-100.0, 0.0}, {-80.0, 0.0}}, color = {127, 0, 255}, thickness = 0.5), Line(visible = true, points = {{80.0, 0.0}, {100.0, 0.0}}, color = {127, 0, 255}, thickness = 0.5), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-100.0, 70.0}, {100.0, 100.0}}, textString = "%name", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-80.0, -6.0}, {80.0, 20.0}}, textString = "x0 = %x0", fontName = "Arial")}), Documentation(info = "<html>
       This is the general continuous <b>Level</b> model of the System Dynamics methodology with a single inflow and a single outflow.  It computes the level by integrating over the difference between inflow and outflow rates.
       </html>"), Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}))); 
    end Level;
  end Levels;

  package Rates  "Rates of the System Dynamics methodology" 
    extends Modelica.Icons.Library annotation(preferedView = "info", Documentation(info = "<html>
      This package contains a set of different <b>Rates</b> (state derivative variables) frequently used in the System Dynamics methodology.
      </html>"));

    block Rate_1  "Unrestricted rate element with one influencing variable" 
      output Real rate;
      Modelica.Blocks.Interfaces.RealInput u "Signal inflow variable" annotation(Placement(visible = true, transformation(origin = {0.0, -105.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -270), iconTransformation(origin = {0.0, -105.0}, extent = {{-5.0, -5.0}, {5.0, 5.0}}, rotation = -270)));
      SystemDynamics.Interfaces.MassOutPort y "Mass inflow variable" annotation(Placement(visible = true, transformation(origin = {-50.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-50.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      SystemDynamics.Interfaces.MassOutPort y1 "Mass outflow variable" annotation(Placement(visible = true, transformation(origin = {50.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {50.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
    equation
      rate = y;
      connect(y, y1) annotation(Line(points = {{-50.0, 0.0}, {50.0, 0.0}}, color = {95, 0, 191}, visible = true));
      connect(y1, u) annotation(Line(points = {{50.0, 0.0}, {0.0, 0.0}, {0.0, -105.0}}, color = {95, 0, 191}, visible = true));
      annotation(Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Polygon(visible = true, lineColor = {127, 0, 255}, fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-60.0, -100.0}, {-60.0, -40.0}, {40.0, 26.0}, {-40.0, 26.0}, {60.0, -40.0}, {60.0, -100.0}, {-60.0, -100.0}}), Line(visible = true, points = {{-40.0, 0.0}, {40.0, 0.0}}, color = {127, 0, 255}, thickness = 0.5), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-100.0, 50.0}, {100.0, 88.0}}, textString = "%name", fontName = "Arial")}), Documentation(info = "<html>
       This is the general System Dynamics unrestricted <b>Rate</b> element, whereby the rate itself is determined by a single variable in its laundry list.  The indicated direction of mass flow simply denotes the direction of positive mass flow.  However if the control signal of the rate assumes a negative value, mass will flow in the opposite direction.
       </html>"), Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}))); 
    end Rate_1;
  end Rates;

  package Sources  "Sources and sinks of the System Dynamics methodology" 
    extends Modelica.Icons.Library;

    block Source  "This is the (dummy) source model of System Dynamics" 
      SystemDynamics.Interfaces.MassInPort MassInPort1 "Outflow variable" annotation(Placement(visible = true, transformation(origin = {110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -8.0}, {8.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -10.0}, {80.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -80.0}, {10.0, 10.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -80.0}, {80.0, 10.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {191, 127, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-62.0, -64.0}, {64.0, 60.0}}), Line(visible = true, points = {{64.0, 0.0}, {110.0, 0.0}}, color = {127, 0, 255}, thickness = 0.5)}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -8.0}, {8.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -10.0}, {80.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -80.0}, {10.0, 10.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -80.0}, {80.0, 10.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {191, 127, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-62.0, -64.0}, {64.0, 60.0}}), Line(visible = true, points = {{64.0, 0.0}, {100.0, 0.0}}, color = {127, 0, 255}, thickness = 0.5)}), Documentation(info = "<html>
       This is the general <b>Source</b> model of the System Dynamics methodology.  In Modelica, this is a dummy model.  It is only provided to maintain the familiarity with the commonly used System Dynamics graphical symbols.
       </html>")); 
    end Source;

    block Sink  "This is the (dummy) sink model of System Dynamics" 
      SystemDynamics.Interfaces.MassInPort MassInPort1 "Inflow variable" annotation(Placement(visible = true, transformation(origin = {-110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0), iconTransformation(origin = {-110.0, 0.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -8.0}, {8.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -10.0}, {80.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -80.0}, {10.0, 10.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -80.0}, {80.0, 10.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {191, 127, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-62.0, -64.0}, {64.0, 60.0}}), Line(visible = true, points = {{-100.0, 0.0}, {-64.0, 0.0}}, color = {127, 0, 255}, thickness = 0.5)}), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -8.0}, {8.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -10.0}, {80.0, 80.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-80.0, -80.0}, {10.0, 10.0}}), Ellipse(visible = true, lineColor = {127, 0, 255}, fillColor = {191, 127, 255}, fillPattern = FillPattern.Solid, extent = {{-10.0, -80.0}, {80.0, 10.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {191, 127, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-62.0, -64.0}, {64.0, 60.0}}), Line(visible = true, points = {{-100.0, 0.0}, {-64.0, 0.0}}, color = {127, 0, 255}, thickness = 0.5)}), Documentation(info = "<html>
       This is the general <b>Sink</b> model of the System Dynamics methodology.  In Modelica, this is a dummy model.  It is only provided to maintain the familiarity with the commonly used System Dynamics graphical symbols.
       </html>", revisions = "")); 
    end Sink;
    annotation(preferedView = "info", Documentation(info = "<html>
       This package contains the (dummy) source and sink elements of the System Dynamics methodology.
       </html>")); 
  end Sources;

  package WorldDynamics  "World models" 
    extends Modelica.Icons.Example;

    package World2  "Forrester's World Model" 
      extends Modelica.Icons.Example;

      model Scenario_6  "6th Scenario" 
        parameter Real Population_0 = 1650000000.0 "World population in 1900";
        parameter Real Pollution_0 = 200000000.0 "Pollution in 1900";
        parameter Real Nat_Resources_0(unit = "ton") = 900000000000.0 "Unrecoverable natural resources in 1900";
        parameter Real Cap_Invest_0(unit = "dollar") = 400000000.0 "Capital investment in 1900";
        parameter Real CIAF_0 = 0.2 "Proportion of capital investment in agriculture in 1900";
        parameter Real BRN(unit = "1/yr") = 0.04 "Normal birth rate";
        parameter Real CIAFN(unit = "dollar") = 0.3 "CIAF normalization";
        parameter Real CIAFT(unit = "yr") = 15.0 "CIAF time constant";
        parameter Real CIDN(unit = "dollar/yr") = 0.025 "Normal capital discard";
        parameter Real CIGN(unit = "dollar/yr") = 0.05 "Normal capital generation";
        parameter Real DRN(unit = "1/yr") = 0.028 "Normal death rate";
        parameter Real ECIRN(unit = "dollar") = 1.0 "Capital normalization";
        parameter Real FC(unit = "kg/yr") = 1.0 "Food coefficient";
        parameter Real FN(unit = "kg/yr") = 1.0 "Food normalization";
        parameter Real Land_Area(unit = "hectare") = 135000000.0 "Area of arable land";
        parameter Real NRI(unit = "ton") = 900000000000.0 "Initial natural resources";
        parameter Real POLN(unit = "1/yr") = 1.0 "Normal pollution";
        parameter Real POLS = 3599900000.0 "Standard pollution";
        parameter Real Pop_dens_norm(unit = "1/hectare") = 26.5 "Normal population density";
        parameter Real QLS = 1.0 "Standard quality of life";
        output Real Pop "World population";
        output Real Pol "Pollution";
        output Real Pol_rat "Pollution ratio";
        output Real Cap_inv(unit = "dollar") "Capital investment";
        output Real Qual_life "Quality of life";
        output Real Nat_res(unit = "ton") "Natural unrecoverable resources";
        parameter Real NRUN2(unit = "1/yr") = 1.0 "Resource utilization after 1970";
        Real NRUN(unit = "1/yr") "Normal resource utilization";
        Real rel_dPop(unit = "1/yr") "Relative derivative of population";
        Real min_dPop(unit = "1/yr") "Minimal derivative of population";
        Real min_QL(start = 1) "Minimum quality of life";
        Real Perf_Index "Preformance index";
        constant Real dPop_fact(unit = "1/yr") = 1 "Dimensionality factor";
        SystemDynamics.Sources.Source Source1 annotation(Placement(visible = true, transformation(origin = {-150.0, 140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 Birth_Rate annotation(Placement(visible = true, transformation(origin = {-120.0, 140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Levels.Level Population(x0 = Population_0) annotation(Placement(visible = true, transformation(origin = {-70.0, 140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 Death_Rate annotation(Placement(visible = true, transformation(origin = {-20.0, 140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Sources.Sink Sink1 annotation(Placement(visible = true, transformation(origin = {10.0, 140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Sources.Source Source2 annotation(Placement(visible = true, transformation(origin = {50.0, 140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 Generation annotation(Placement(visible = true, transformation(origin = {80.0, 140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Levels.Level Natural_Resources(x0 = Nat_Resources_0) annotation(Placement(visible = true, transformation(origin = {130.0, 140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 Depletion annotation(Placement(visible = true, transformation(origin = {180.0, 140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Sources.Sink Sink2 annotation(Placement(visible = true, transformation(origin = {210.0, 140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Const Gen_Const(k = 0) annotation(Placement(visible = true, transformation(origin = {80.0, 101.0}, extent = {{-16.0, -15.0}, {16.0, 15.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular BRMM(x_vals = {0, 1, 2, 3, 4, 5, 20}, y_vals = {1.2, 1.0, 0.85, 0.75, 0.7, 0.7, 0.7}) annotation(Placement(visible = true, transformation(origin = {-105.0, 185.0}, extent = {{15.0, -15.0}, {-15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular DRMM(x_vals = {0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 20}, y_vals = {3.0, 1.8, 1.0, 0.8, 0.7, 0.6, 0.53, 0.5, 0.5, 0.5, 0.5, 0.5}) annotation(Placement(visible = true, transformation(origin = {51.0, 171.0}, extent = {{15.0, -15.0}, {-15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain BR_norm(k = BRN) annotation(Placement(visible = true, transformation(origin = {-135.0, 103.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Prod_5 Prod_5_1 annotation(Placement(visible = true, transformation(origin = {-160.0, 80.0}, extent = {{-16.0, -16.0}, {16.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain DR_norm(k = DRN) annotation(Placement(visible = true, transformation(origin = {-3.0, 103.0}, extent = {{15.0, -15.0}, {-15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Prod_5 Prod_5_2 annotation(Placement(visible = true, transformation(origin = {20.0, 79.0}, extent = {{-16.0, -15.0}, {16.0, 15.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular BRFM(x_vals = {0, 1, 2, 3, 4, 20}, y_vals = {0.0, 1.0, 1.6, 1.9, 2.0, 2.0}) annotation(Placement(visible = true, transformation(origin = {-176.0, 35.0}, extent = {{-16.0, -15.0}, {16.0, 15.0}}, rotation = -270)));
        SystemDynamics.Functions.Tabular BRPM(x_vals = 0:10:60, y_vals = {1.02, 0.9, 0.7, 0.4, 0.25, 0.15, 0.1}) annotation(Placement(visible = true, transformation(origin = {-135.0, 35.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = -270)));
        SystemDynamics.Functions.Tabular BRCM(x_vals = 0:5, y_vals = {1.05, 1.0, 0.9, 0.7, 0.6, 0.55}) annotation(Placement(visible = true, transformation(origin = {-95.0, 35.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = -270)));
        SystemDynamics.Functions.Tabular DRCM(x_vals = 0:5, y_vals = {0.9, 1.0, 1.2, 1.5, 1.9, 3.0}) annotation(Placement(visible = true, transformation(origin = {-25.0, 35.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = -270)));
        SystemDynamics.Functions.Tabular DRPM(x_vals = 0:10:60, y_vals = {0.92, 1.3, 2.0, 3.2, 4.8, 6.8, 9.2}) annotation(Placement(visible = true, transformation(origin = {15.0, 35.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = -270)));
        SystemDynamics.Functions.Tabular DRFM(x_vals = {0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 20}, y_vals = {30.0, 3.0, 2.0, 1.4, 1.0, 0.7, 0.6, 0.5, 0.5, 0.5}) annotation(Placement(visible = true, transformation(origin = {55.0, 35.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = -270)));
        SystemDynamics.Auxiliary.Gain Crowd_Rat(k = 1.0 / (Land_Area * Pop_dens_norm)) annotation(Placement(visible = true, transformation(origin = {-60.0, 35.0}, extent = {{-16.0, -15.0}, {16.0, 15.0}}, rotation = -90)));
        SystemDynamics.Auxiliary.Prod_2 Prod_2_1 annotation(Placement(visible = true, transformation(origin = {140.0, 80.0}, extent = {{-16.0, -16.0}, {16.0, 16.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular NRMM(x_vals = 0:10, y_vals = {0.0, 1.0, 1.8, 2.4, 2.9, 3.3, 3.6, 3.8, 3.9, 3.95, 4.0}) annotation(Placement(visible = true, transformation(origin = {201.0, 80.0}, extent = {{-15.0, 16.0}, {15.0, -16.0}}, rotation = -180)));
        SystemDynamics.Sources.Source Source3 annotation(Placement(visible = true, transformation(origin = {50.0, -40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 CI_Generation annotation(Placement(visible = true, transformation(origin = {80.0, -40.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Levels.Level Capital_Investment(x0 = Cap_Invest_0) annotation(Placement(visible = true, transformation(origin = {130.0, -40.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 CI_Discard annotation(Placement(visible = true, transformation(origin = {180.0, -40.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Sources.Sink Sink3 annotation(Placement(visible = true, transformation(origin = {210.0, -40.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain CIG_norm(k = CIGN) annotation(Placement(visible = true, transformation(origin = {65.0, -77.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Prod_2 Prod_2_2 annotation(Placement(visible = true, transformation(origin = {40.0, -100.0}, extent = {{-14.0, -16.0}, {14.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain CID_norm(k = CIDN) annotation(Placement(visible = true, transformation(origin = {165.0, -77.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular CIM(x_vals = {0, 1, 2, 3, 4, 5, 20}, y_vals = {0.1, 1.0, 1.8, 2.4, 2.8, 3.0, 3.0}) annotation(Placement(visible = true, transformation(origin = {113.0, -100.0}, extent = {{15.0, -16.0}, {-15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain MSL(k = 1.0 / ECIRN) annotation(Placement(visible = true, transformation(origin = {277.0, 30.0}, extent = {{-15.0, -16.0}, {15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain NRFR(k = 1.0 / NRI) annotation(Placement(visible = true, transformation(origin = {137.0, 51.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain ECIR(k = 1.0 / (1.0 - CIAFN)) annotation(Placement(visible = true, transformation(origin = {243.0, 30.0}, extent = {{-15.0, -16.0}, {15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Prod_3 Prod_3_1 annotation(Placement(visible = true, transformation(origin = {215.0, 30.0}, extent = {{-15.0, -16.0}, {15.0, 16.0}}, rotation = -90)));
        SystemDynamics.Functions.Tabular NREM(x_vals = 0:0.25:1, y_vals = {0.0, 0.15, 0.5, 0.85, 1.0}) annotation(Placement(visible = true, transformation(origin = {175.0, 51.0}, extent = {{15.0, 15.0}, {-15.0, -15.0}}, rotation = -180)));
        Modelica.Blocks.Math.Division CIR annotation(Placement(visible = true, transformation(origin = {107.0, 6.0}, extent = {{15.0, -16.0}, {-15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Sources.Source Source4 annotation(Placement(visible = true, transformation(origin = {-150.0, -140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 P_Generation annotation(Placement(visible = true, transformation(origin = {-120.0, -140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Levels.Level Pollution(x0 = Pollution_0) annotation(Placement(visible = true, transformation(origin = {-70.0, -140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 P_Absorption annotation(Placement(visible = true, transformation(origin = {-20.0, -140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Sources.Sink Sink4 annotation(Placement(visible = true, transformation(origin = {10.0, -140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Functions.Linear NotCIAF(m = -1.0, b = 1.0) annotation(Placement(visible = true, transformation(origin = {189.0, 10.0}, extent = {{-15.0, -16.0}, {15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain Pol_Ratio(k = 1.0 / POLS) annotation(Placement(visible = true, transformation(origin = {-29.0, -95.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular FCM(x_vals = 0:5, y_vals = {2.4, 1.0, 0.6, 0.4, 0.3, 0.2}) annotation(Placement(visible = true, transformation(origin = {-85.0, -47.0}, extent = {{-15.0, 15.0}, {15.0, -15.0}}, rotation = -180)));
        SystemDynamics.Auxiliary.Prod_3 Prod_3_2 annotation(Placement(visible = true, transformation(origin = {-117.0, -66.0}, extent = {{15.0, -14.0}, {-15.0, 14.0}}, rotation = 90)));
        SystemDynamics.Auxiliary.Gain Food_Ratio(k = FC / FN) annotation(Placement(visible = true, transformation(origin = {-149.0, -66.0}, extent = {{15.0, -16.0}, {-15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Sources.Source Source5 annotation(Placement(visible = true, transformation(origin = {50.0, -140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 CIAFG annotation(Placement(visible = true, transformation(origin = {80.0, -140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Levels.Level CIAF(x0 = CIAF_0) annotation(Placement(visible = true, transformation(origin = {130.0, -140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Rates.Rate_1 CIAFD annotation(Placement(visible = true, transformation(origin = {180.0, -140.0}, extent = {{-20.0, -20.0}, {20.0, 20.0}}, rotation = 0)));
        SystemDynamics.Sources.Sink Sink5 annotation(Placement(visible = true, transformation(origin = {210.0, -140.0}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain CIAF_D(k = 1.0 / CIAFT) annotation(Placement(visible = true, transformation(origin = {163.0, -180.0}, extent = {{-15.0, -16.0}, {15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain CIAF_G(k = 1.0 / CIAFT) annotation(Placement(visible = true, transformation(origin = {95.0, -180.0}, extent = {{15.0, -16.0}, {-15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Prod_2 Prod_2_3 annotation(Placement(visible = true, transformation(origin = {120.0, -230.0}, extent = {{-16.0, -16.0}, {16.0, 16.0}}, rotation = 0)));
        Modelica.Blocks.Math.Division P_Abs annotation(Placement(visible = true, transformation(origin = {-43.0, -180.0}, extent = {{-15.0, -16.0}, {15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain Pol_norm(k = POLN) annotation(Placement(visible = true, transformation(origin = {-135.0, -180.0}, extent = {{-15.0, -16.0}, {15.0, 16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Prod_2 Prod_2_4 annotation(Placement(visible = true, transformation(origin = {-160.0, -220.0}, extent = {{-16.0, -16.0}, {16.0, 16.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular POLCM(x_vals = {0, 1, 2, 3, 4, 5, 100}, y_vals = {0.05, 1.0, 3.0, 5.4, 7.4, 8.0, 8.0}) annotation(Placement(visible = true, transformation(origin = {-117.0, -220.0}, extent = {{-15.0, 16.0}, {15.0, -16.0}}, rotation = -180)));
        SystemDynamics.Functions.Tabular POLAT(x_vals = 0:10:60, y_vals = {0.6, 2.5, 5.0, 8.0, 11.5, 15.5, 20.0}) annotation(Placement(visible = true, transformation(origin = {-39.0, -220.0}, extent = {{-15.0, 16.0}, {15.0, -16.0}}, rotation = -180)));
        SystemDynamics.Functions.Tabular CFIFR(x_vals = {0, 0.5, 1, 1.5, 2, 20}, y_vals = {1.0, 0.6, 0.3, 0.15, 0.1, 0.1}) annotation(Placement(visible = true, transformation(origin = {69.0, -230.0}, extent = {{15.0, 16.0}, {-15.0, -16.0}}, rotation = -180)));
        SystemDynamics.Functions.Tabular FPM(x_vals = 0:10:60, y_vals = {1.02, 0.9, 0.65, 0.35, 0.2, 0.1, 0.05}) annotation(Placement(visible = true, transformation(origin = {-33.0, -66.0}, extent = {{-15.0, 16.0}, {15.0, -16.0}}, rotation = -180)));
        SystemDynamics.Auxiliary.Prod_2 Prod_2_5 annotation(Placement(visible = true, transformation(origin = {229.0, -200.0}, extent = {{-15.0, 16.0}, {15.0, -16.0}}, rotation = 0)));
        SystemDynamics.Auxiliary.Gain CIRA(k = 1.0 / CIAFN) annotation(Placement(visible = true, transformation(origin = {255.0, -225.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular FPCI(x_vals = {0, 1, 2, 3, 4, 5, 6, 100}, y_vals = {0.5, 1.0, 1.4, 1.7, 1.9, 2.05, 2.2, 2.2}) annotation(Placement(visible = true, transformation(origin = {-153.0, -107.0}, extent = {{15.0, 15.0}, {-15.0, -15.0}}, rotation = -180)));
        SystemDynamics.Functions.Tabular CIQR(y_vals = {0.7, 0.8, 1.0, 1.5, 2.0, 2.0}, x_vals = {0, 0.5, 1, 1.5, 2, 10}) annotation(Placement(visible = true, transformation(origin = {167.0, -230.0}, extent = {{-15.0, 16.0}, {15.0, -16.0}}, rotation = -180)));
        Modelica.Blocks.Math.Division QLMF annotation(Placement(visible = true, transformation(origin = {315.0, -223.0}, extent = {{15.0, -15.0}, {-15.0, 15.0}}, rotation = 0)));
        SystemDynamics.Functions.Tabular QLM(x_vals = {0, 1, 2, 3, 4, 5, 20}, y_vals = {0.2, 1.0, 1.7, 2.3, 2.7, 2.9, 2.9}) annotation(Placement(visible = true, transformation(origin = {319.0, -169.0}, extent = {{15.0, 17.0}, {-15.0, -17.0}}, rotation = -180)));
        SystemDynamics.Functions.Tabular QLF(x_vals = {0, 1, 2, 3, 4, 20}, y_vals = {0.0, 1.0, 1.8, 2.4, 2.7, 2.7}) annotation(Placement(visible = true, transformation(origin = {381.0, -232.0}, extent = {{-15.0, 16.0}, {15.0, -16.0}}, rotation = -180)));
        SystemDynamics.Auxiliary.Prod_4 Prod_4_1 annotation(Placement(visible = true, transformation(origin = {375.0, -163.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = -90)));
        SystemDynamics.Functions.Tabular QLC(x_vals = 0:0.5:5, y_vals = {2.0, 1.3, 1.0, 0.75, 0.55, 0.45, 0.38, 0.3, 0.25, 0.22, 0.2}) annotation(Placement(visible = true, transformation(origin = {335.0, -113.0}, extent = {{15.0, 15.0}, {-15.0, -15.0}}, rotation = -90)));
        SystemDynamics.Functions.Tabular QLP(x_vals = 0:10:60, y_vals = {1.04, 0.85, 0.6, 0.3, 0.15, 0.05, 0.02}) annotation(Placement(visible = true, transformation(origin = {375.0, -113.0}, extent = {{15.0, 15.0}, {-15.0, -15.0}}, rotation = -90)));
        SystemDynamics.Auxiliary.Gain Quality_of_Life(k = QLS) annotation(Placement(visible = true, transformation(origin = {412.0, -163.0}, extent = {{-20.0, -21.0}, {20.0, 21.0}}, rotation = 0)));
        SystemDynamics.WorldDynamics.World2.Utilities.Parameter_Change NR_norm annotation(Placement(visible = true, transformation(origin = {158.8111, 105.0}, extent = {{-15.0, -15.0}, {15.0, 15.0}}, rotation = 0)), extent = [146, 90; 176, 120]);
      equation
        connect(Depletion.u, NR_norm.y) annotation(Line(visible = true, origin = {177.437, 109.6667}, points = {{2.563, 9.3333}, {2.563, -4.6667}, {-5.1259, -4.6667}}, color = {0, 0, 191}));
        connect(NR_norm.u1, Prod_2_1.y) annotation(Line(visible = true, points = {{145.3111, 111.0}, {140.0, 111.0}, {140.0, 91.2}}, color = {0, 0, 191}));
        connect(Food_Ratio.y, BRFM.u) annotation(Line(visible = true, points = {{-159.5, -66.0}, {-176.0, -66.0}, {-176.0, 22.2}}, color = {0, 0, 191}));
        connect(BRFM.y, Prod_5_1.u2) annotation(Line(visible = true, points = {{-176.0, 52.6}, {-176.0, 60.0}, {-167.36, 60.0}, {-167.36, 72.0}}, color = {0, 0, 191}));
        connect(BRPM.u, QLP.u) annotation(Line(visible = true, points = {{-135.0, 23.0}, {-135.0, -20.0}, {-214.0, -20.0}, {-214.0, 214.0}, {375.0, 214.0}, {375.0, -125.0}}, color = {0, 0, 191}));
        connect(Pol_Ratio.y, BRPM.u) annotation(Line(visible = true, points = {{-18.5, -95.0}, {0.0, -95.0}, {0.0, -20.0}, {-135.0, -20.0}, {-135.0, 23.0}}, color = {0, 0, 191}));
        connect(BRPM.y, Prod_5_1.u3) annotation(Line(visible = true, points = {{-135.0, 51.5}, {-135.0, 60.0}, {-160.0, 60.0}, {-160.0, 68.8}}, color = {0, 0, 191}));
        connect(Crowd_Rat.y, BRCM.u) annotation(Line(visible = true, points = {{-60.0, 23.8}, {-60.0, 8.0}, {-95.0, 8.0}, {-95.0, 23.0}}, color = {0, 0, 191}));
        connect(BRCM.y, Prod_5_1.u4) annotation(Line(visible = true, points = {{-95.0, 51.5}, {-95.0, 66.0}, {-152.64, 66.0}, {-152.64, 72.0}}, color = {0, 0, 191}));
        connect(Crowd_Rat.y, DRCM.u) annotation(Line(visible = true, points = {{-60.0, 23.8}, {-60.0, 8.0}, {-25.0, 8.0}, {-25.0, 23.0}}, color = {0, 0, 191}));
        connect(DRCM.y, Prod_5_2.u2) annotation(Line(visible = true, points = {{-25.0, 51.5}, {-25.0, 60.0}, {12.64, 60.0}, {12.64, 71.5}}, color = {0, 0, 191}));
        connect(Pol_Ratio.y, DRPM.u) annotation(Line(visible = true, points = {{-18.5, -95.0}, {0.0, -95.0}, {0.0, 8.0}, {15.0, 8.0}, {15.0, 23.0}}, color = {0, 0, 191}));
        connect(DRPM.y, Prod_5_2.u3) annotation(Line(visible = true, points = {{15.0, 51.5}, {15.0, 60.0}, {20.0, 60.0}, {20.0, 68.5}}, color = {0, 0, 191}));
        connect(Food_Ratio.y, DRFM.u) annotation(Line(visible = true, points = {{-159.5, -66.0}, {-176.0, -66.0}, {-176.0, 0.0}, {55.0, 0.0}, {55.0, 23.0}}, color = {0, 0, 191}));
        connect(DRFM.y, Prod_5_2.u4) annotation(Line(visible = true, points = {{55.0, 51.5}, {55.0, 60.0}, {27.36, 60.0}, {27.36, 71.5}}, color = {0, 0, 191}));
        connect(Crowd_Rat.y, QLC.u) annotation(Line(visible = true, points = {{-60.0, 23.8}, {-60.0, 8.0}, {-206.0, 8.0}, {-206.0, 208.0}, {335.0, 208.0}, {335.0, -125.0}}, color = {0, 0, 191}));
        connect(FCM.u, Crowd_Rat.y) annotation(Line(visible = true, points = {{-73.0, -47.0}, {-60.0, -47.0}, {-60.0, 23.8}}, color = {0, 0, 191}));
        connect(Crowd_Rat.u, Population.y3) annotation(Line(visible = true, points = {{-60.0, 46.2}, {-60.0, 66.0}, {-70.0, 66.0}, {-70.0, 127.0}}, color = {0, 0, 191}));
        connect(Prod_2_5.u2, Prod_3_1.u2) annotation(Line(visible = true, points = {{239.5, -200.0}, {260.0, -200.0}, {260.0, -20.0}, {160.0, -20.0}, {160.0, 30.0}, {203.8, 30.0}}, color = {0, 0, 191}));
        connect(Prod_3_1.y, ECIR.u) annotation(Line(visible = true, points = {{226.2, 30.0}, {232.5, 30.0}}, color = {0, 0, 191}));
        connect(CIR.y, Prod_3_1.u2) annotation(Line(visible = true, points = {{90.5, 6.0}, {80.0, 6.0}, {80.0, 30.0}, {203.8, 30.0}}, color = {0, 0, 191}));
        connect(NotCIAF.y, Prod_3_1.u3) annotation(Line(visible = true, points = {{202.5, 10.0}, {215.0, 10.0}, {215.0, 19.5}}, color = {0, 0, 191}));
        connect(Prod_3_1.u1, NREM.y) annotation(Line(visible = true, points = {{215.0, 40.5}, {215.0, 51.0}, {191.5, 51.0}}, color = {0, 0, 191}));
        connect(QLP.y, Prod_4_1.u1) annotation(Line(visible = true, points = {{375.0, -96.5}, {375.0, -152.5}}, color = {0, 0, 191}));
        connect(QLC.y, Prod_4_1.u2) annotation(Line(visible = true, points = {{335.0, -96.5}, {335.0, -157.0}, {366.6, -157.0}}, color = {0, 0, 191}));
        connect(Prod_4_1.y, Quality_of_Life.u) annotation(Line(visible = true, points = {{385.5, -163.0}, {398.0, -163.0}}, color = {0, 0, 191}));
        connect(QLF.y, Prod_4_1.u4) annotation(Line(visible = true, points = {{364.5, -232.0}, {356.0, -232.0}, {356.0, -190.0}, {375.0, -190.0}, {375.0, -173.5}}, color = {0, 0, 191}));
        connect(QLM.y, Prod_4_1.u3) annotation(Line(visible = true, points = {{335.5, -169.0}, {366.6, -169.0}}, color = {0, 0, 191}));
        connect(QLF.y, QLMF.u2) annotation(Line(visible = true, points = {{364.5, -232.0}, {333.0, -232.0}}, color = {0, 0, 191}));
        connect(QLMF.y, CIQR.u) annotation(Line(visible = true, points = {{298.5, -223.0}, {290.0, -223.0}, {290.0, -256.0}, {190.0, -256.0}, {190.0, -230.0}, {179.0, -230.0}}, color = {0, 0, 191}));
        connect(P_Abs.u1, Pollution.y3) annotation(Line(visible = true, points = {{-61.0, -170.4}, {-70.0, -170.4}, {-70.0, -153.0}}, color = {0, 0, 191}));
        connect(CIG_norm.y, CI_Generation.u) annotation(Line(visible = true, points = {{75.5, -77.0}, {80.0, -77.0}, {80.0, -61.0}}, color = {0, 0, 191}));
        connect(CI_Discard.y1, Sink3.MassInPort1) annotation(Line(visible = true, points = {{190.0, -40.0}, {199.0, -40.0}}, color = {191, 0, 191}));
        connect(Capital_Investment.u2, CI_Discard.y) annotation(Line(visible = true, points = {{152.0, -40.0}, {170.0, -40.0}}, color = {191, 0, 191}));
        connect(Source3.MassInPort1, CI_Generation.y) annotation(Line(visible = true, points = {{61.0, -40.0}, {70.0, -40.0}}, color = {191, 0, 191}));
        connect(CI_Generation.y1, Capital_Investment.u1) annotation(Line(visible = true, points = {{90.0, -40.0}, {108.0, -40.0}}, color = {191, 0, 191}));
        connect(FPM.u, POLAT.u) annotation(Line(visible = true, points = {{-21.0, -66.0}, {0.0, -66.0}, {0.0, -220.0}, {-27.0, -220.0}}, color = {0, 0, 191}));
        connect(CIRA.y, FPCI.u) annotation(Line(visible = true, points = {{265.5, -225.0}, {280.0, -225.0}, {280.0, -252.0}, {-210.0, -252.0}, {-210.0, -107.0}, {-165.0, -107.0}}, color = {0, 0, 191}));
        connect(Prod_2_1.u1, Population.y1) annotation(Line(visible = true, points = {{128.8, 80.0}, {100.0, 80.0}, {100.0, 194.0}, {-46.0, 194.0}, {-46.0, 151.0}, {-53.0, 151.0}}, color = {0, 0, 191}));
        connect(NRMM.u, DRMM.u) annotation(Line(visible = true, points = {{213.0, 80.0}, {300.0, 80.0}, {300.0, 171.0}, {63.0, 171.0}}, color = {0, 0, 191}));
        connect(NRMM.u, BRMM.u) annotation(Line(visible = true, points = {{213.0, 80.0}, {300.0, 80.0}, {300.0, 200.0}, {-70.0, 200.0}, {-70.0, 185.0}, {-93.0, 185.0}}, color = {0, 0, 191}));
        connect(CFIFR.u, QLF.u) annotation(Line(visible = true, points = {{57.0, -230.0}, {40.0, -230.0}, {40.0, -260.0}, {400.0, -260.0}, {400.0, -232.0}, {393.0, -232.0}}, color = {0, 0, 191}));
        connect(Food_Ratio.y, QLF.u) annotation(Line(visible = true, points = {{-159.5, -66.0}, {-220.0, -66.0}, {-220.0, -260.0}, {400.0, -260.0}, {400.0, -232.0}, {393.0, -232.0}}, color = {0, 0, 191}));
        connect(Pol_Ratio.y, FPM.u) annotation(Line(visible = true, points = {{-18.5, -95.0}, {0.0, -95.0}, {0.0, -66.0}, {-21.0, -66.0}}, color = {0, 0, 191}));
        connect(CIR.y, POLCM.u) annotation(Line(visible = true, points = {{90.5, 6.0}, {80.0, 6.0}, {80.0, -6.0}, {10.0, -6.0}, {10.0, -116.0}, {-100.0, -116.0}, {-100.0, -220.0}, {-105.0, -220.0}}, color = {0, 0, 191}));
        connect(QLM.u, CIM.u) annotation(Line(visible = true, points = {{307.0, -169.0}, {300.0, -169.0}, {300.0, -100.0}, {125.0, -100.0}}, color = {0, 0, 191}));
        connect(QLM.y, QLMF.u1) annotation(Line(visible = true, points = {{335.5, -169.0}, {344.0, -169.0}, {344.0, -214.0}, {333.0, -214.0}}, color = {0, 0, 191}));
        connect(MSL.y, QLM.u) annotation(Line(visible = true, points = {{287.5, 30.0}, {300.0, 30.0}, {300.0, -169.0}, {307.0, -169.0}}, color = {0, 0, 191}));
        connect(NRMM.y, Prod_2_1.u2) annotation(Line(visible = true, points = {{184.5, 80.0}, {151.2, 80.0}}, color = {0, 0, 191}));
        connect(MSL.y, NRMM.u) annotation(Line(visible = true, points = {{287.5, 30.0}, {300.0, 30.0}, {300.0, 80.0}, {213.0, 80.0}}, color = {0, 0, 191}));
        connect(ECIR.y, MSL.u) annotation(Line(visible = true, points = {{253.5, 30.0}, {266.5, 30.0}}, color = {0, 0, 191}));
        connect(NotCIAF.u, CIAF.y1) annotation(Line(visible = true, points = {{175.5, 10.0}, {168.0, 10.0}, {168.0, -8.0}, {240.0, -8.0}, {240.0, -110.0}, {154.0, -110.0}, {154.0, -129.0}, {147.0, -129.0}}, color = {0, 0, 191}));
        connect(Prod_2_2.u1, CIR.u2) annotation(Line(visible = true, points = {{30.2, -100.0}, {20.0, -100.0}, {20.0, -14.0}, {140.0, -14.0}, {140.0, -3.6}, {125.0, -3.6}}, color = {0, 0, 191}));
        connect(Prod_2_2.u1, Population.y1) annotation(Line(visible = true, points = {{30.2, -100.0}, {20.0, -100.0}, {20.0, -14.0}, {320.0, -14.0}, {320.0, 194.0}, {-46.0, 194.0}, {-46.0, 151.0}, {-53.0, 151.0}}, color = {0, 0, 191}));
        connect(Prod_2_4.u1, Population.y) annotation(Line(visible = true, points = {{-171.2, -220.0}, {-200.0, -220.0}, {-200.0, 164.0}, {-94.0, 164.0}, {-94.0, 151.0}, {-87.0, 151.0}}, color = {0, 0, 191}));
        connect(CID_norm.u, Capital_Investment.y2) annotation(Line(visible = true, points = {{154.5, -77.0}, {145.0, -77.0}, {145.0, -53.0}}, color = {0, 0, 191}));
        connect(CID_norm.y, CI_Discard.u) annotation(Line(visible = true, points = {{175.5, -77.0}, {180.0, -77.0}, {180.0, -61.0}}, color = {0, 0, 191}));
        connect(CIM.y, Prod_2_2.u2) annotation(Line(visible = true, points = {{96.5, -100.0}, {49.8, -100.0}}, color = {0, 0, 191}));
        connect(Prod_2_2.y, CIG_norm.u) annotation(Line(visible = true, points = {{40.0, -88.8}, {40.0, -77.0}, {54.5, -77.0}}, color = {0, 0, 191}));
        connect(Pol_Ratio.u, Pollution.y1) annotation(Line(visible = true, points = {{-39.5, -95.0}, {-46.0, -95.0}, {-46.0, -129.0}, {-53.0, -129.0}}, color = {0, 0, 191}));
        connect(POLCM.y, Prod_2_4.u2) annotation(Line(visible = true, points = {{-133.5, -220.0}, {-148.8, -220.0}}, color = {0, 0, 191}));
        connect(Prod_2_4.y, Pol_norm.u) annotation(Line(visible = true, points = {{-160.0, -208.8}, {-160.0, -180.0}, {-145.5, -180.0}}, color = {0, 0, 191}));
        connect(Pol_norm.y, P_Generation.u) annotation(Line(visible = true, points = {{-124.5, -180.0}, {-120.0, -180.0}, {-120.0, -161.0}}, color = {0, 0, 191}));
        connect(POLAT.y, P_Abs.u2) annotation(Line(visible = true, points = {{-55.5, -220.0}, {-70.0, -220.0}, {-70.0, -189.6}, {-61.0, -189.6}}, color = {0, 0, 191}));
        connect(P_Abs.y, P_Absorption.u) annotation(Line(visible = true, points = {{-26.5, -180.0}, {-20.0, -180.0}, {-20.0, -161.0}}, color = {0, 0, 191}));
        connect(CFIFR.y, Prod_2_3.u1) annotation(Line(visible = true, points = {{85.5, -230.0}, {108.8, -230.0}}, color = {0, 0, 191}));
        connect(CIQR.y, Prod_2_3.u2) annotation(Line(visible = true, points = {{150.5, -230.0}, {131.2, -230.0}}, color = {0, 0, 191}));
        connect(CIAF_G.y, CIAFG.u) annotation(Line(visible = true, points = {{84.5, -180.0}, {80.0, -180.0}, {80.0, -161.0}}, color = {0, 0, 191}));
        connect(CIAF_G.u, Prod_2_3.y) annotation(Line(visible = true, points = {{105.5, -180.0}, {120.0, -180.0}, {120.0, -218.8}}, color = {0, 0, 191}));
        connect(CIRA.u, Prod_2_5.y) annotation(Line(visible = true, points = {{244.5, -225.0}, {229.0, -225.0}, {229.0, -211.2}}, color = {0, 0, 191}));
        connect(Prod_2_5.u1, CIAF.y3) annotation(Line(visible = true, points = {{218.5, -200.0}, {130.0, -200.0}, {130.0, -153.0}}, color = {0, 0, 191}));
        connect(CIAF_D.u, CIAF.y2) annotation(Line(visible = true, points = {{152.5, -180.0}, {145.0, -180.0}, {145.0, -153.0}}, color = {0, 0, 191}));
        connect(CIAF_D.y, CIAFD.u) annotation(Line(visible = true, points = {{173.5, -180.0}, {180.0, -180.0}, {180.0, -161.0}}, color = {0, 0, 191}));
        connect(CIAFD.y1, Sink5.MassInPort1) annotation(Line(visible = true, points = {{190.0, -140.0}, {199.0, -140.0}}, color = {191, 0, 191}));
        connect(CIAF.u2, CIAFD.y) annotation(Line(visible = true, points = {{152.0, -140.0}, {170.0, -140.0}}, color = {191, 0, 191}));
        connect(CIAFG.y1, CIAF.u1) annotation(Line(visible = true, points = {{90.0, -140.0}, {108.0, -140.0}}, color = {191, 0, 191}));
        connect(Source5.MassInPort1, CIAFG.y) annotation(Line(visible = true, points = {{61.0, -140.0}, {70.0, -140.0}}, color = {191, 0, 191}));
        connect(P_Absorption.y1, Sink4.MassInPort1) annotation(Line(visible = true, points = {{-10.0, -140.0}, {-1.0, -140.0}}, color = {191, 0, 191}));
        connect(Pollution.u2, P_Absorption.y) annotation(Line(visible = true, points = {{-48.0, -140.0}, {-30.0, -140.0}}, color = {191, 0, 191}));
        connect(P_Generation.y1, Pollution.u1) annotation(Line(visible = true, points = {{-110.0, -140.0}, {-92.0, -140.0}}, color = {191, 0, 191}));
        connect(Source4.MassInPort1, P_Generation.y) annotation(Line(visible = true, points = {{-139.0, -140.0}, {-130.0, -140.0}}, color = {191, 0, 191}));
        connect(FPCI.y, Prod_3_2.u3) annotation(Line(visible = true, points = {{-136.5, -107.0}, {-117.0, -107.0}, {-117.0, -76.5}}, color = {0, 0, 191}));
        connect(FPM.y, Prod_3_2.u2) annotation(Line(visible = true, points = {{-49.5, -66.0}, {-107.2, -66.0}}, color = {0, 0, 191}));
        connect(Prod_3_2.u1, FCM.y) annotation(Line(visible = true, points = {{-117.0, -55.5}, {-117.0, -47.0}, {-101.5, -47.0}}, color = {0, 0, 191}));
        connect(Prod_3_2.y, Food_Ratio.u) annotation(Line(visible = true, points = {{-126.8, -66.0}, {-138.5, -66.0}}, color = {0, 0, 191}));
        connect(CIR.u1, Capital_Investment.y1) annotation(Line(visible = true, points = {{125.0, 15.6}, {154.0, 15.6}, {154.0, -29.0}, {147.0, -29.0}}, color = {0, 0, 191}));
        connect(NRFR.y, NREM.u) annotation(Line(visible = true, points = {{147.5, 51.0}, {163.0, 51.0}}, color = {0, 0, 191}));
        connect(DRMM.y, Prod_5_2.u5) annotation(Line(visible = true, points = {{34.5, 171.0}, {26.0, 171.0}, {26.0, 104.0}, {40.0, 104.0}, {40.0, 79.0}, {31.2, 79.0}}, color = {0, 0, 191}));
        connect(DR_norm.y, Death_Rate.u) annotation(Line(visible = true, points = {{-13.5, 103.0}, {-20.0, 103.0}, {-20.0, 119.0}}, color = {0, 0, 191}));
        connect(Prod_5_2.y, DR_norm.u) annotation(Line(visible = true, points = {{20.0, 89.5}, {20.0, 103.0}, {7.5, 103.0}}, color = {0, 0, 191}));
        connect(Prod_5_2.u1, Population.y2) annotation(Line(visible = true, points = {{8.8, 79.0}, {-55.0, 79.0}, {-55.0, 127.0}}, color = {0, 0, 191}));
        connect(BRMM.y, Prod_5_1.u1) annotation(Line(visible = true, points = {{-121.5, 185.0}, {-180.0, 185.0}, {-180.0, 80.0}, {-171.2, 80.0}}, color = {0, 0, 191}));
        connect(Prod_5_1.u5, Population.y4) annotation(Line(visible = true, points = {{-148.8, 80.0}, {-85.0, 80.0}, {-85.0, 127.0}}, color = {0, 0, 191}));
        connect(Prod_5_1.y, BR_norm.u) annotation(Line(visible = true, points = {{-160.0, 91.2}, {-160.0, 103.0}, {-145.5, 103.0}}, color = {0, 0, 191}));
        connect(BR_norm.y, Birth_Rate.u) annotation(Line(visible = true, points = {{-124.5, 103.0}, {-120.0, 103.0}, {-120.0, 119.0}}, color = {0, 0, 191}));
        connect(Source1.MassInPort1, Birth_Rate.y) annotation(Line(visible = true, points = {{-139.0, 140.0}, {-130.0, 140.0}}, color = {191, 0, 191}));
        connect(Birth_Rate.y1, Population.u1) annotation(Line(visible = true, points = {{-110.0, 140.0}, {-92.0, 140.0}}, color = {191, 0, 191}));
        connect(Population.u2, Death_Rate.y) annotation(Line(visible = true, points = {{-48.0, 140.0}, {-30.0, 140.0}}, color = {191, 0, 191}));
        connect(Death_Rate.y1, Sink1.MassInPort1) annotation(Line(visible = true, points = {{-10.0, 140.0}, {-1.0, 140.0}}, color = {191, 0, 191}));
        connect(Source2.MassInPort1, Generation.y) annotation(Line(visible = true, points = {{61.0, 140.0}, {70.0, 140.0}}, color = {191, 0, 191}));
        connect(Gen_Const.y, Generation.u) annotation(Line(visible = true, points = {{80.0, 111.5}, {80.0, 119.0}}, color = {0, 0, 191}));
        connect(NRFR.u, Natural_Resources.y4) annotation(Line(visible = true, points = {{126.5, 51.0}, {115.0, 51.0}, {115.0, 127.0}}, color = {0, 0, 191}));
        connect(Generation.y1, Natural_Resources.u1) annotation(Line(visible = true, points = {{90.0, 140.0}, {108.0, 140.0}}, color = {191, 0, 191}));
        connect(Natural_Resources.u2, Depletion.y) annotation(Line(visible = true, points = {{152.0, 140.0}, {170.0, 140.0}}, color = {191, 0, 191}));
        connect(Depletion.y1, Sink2.MassInPort1) annotation(Line(visible = true, points = {{190.0, 140.0}, {199.0, 140.0}}, color = {191, 0, 191}));
        Pop = Population.y;
        Pol = Pollution.y;
        Pol_rat = Pol_Ratio.y;
        Cap_inv = Capital_Investment.y;
        Qual_life = Quality_of_Life.y;
        Nat_res = Natural_Resources.y;
        NRUN = if time > 1970 then NRUN2 else 1.0;
        NR_norm.u2 = NRUN;
        rel_dPop = (Birth_Rate.rate - Death_Rate.rate) / Population.level;
        when sample(100, 1) then
          min_dPop = min([pre(min_dPop), rel_dPop]);
          min_QL = min([pre(min_QL), Quality_of_Life.y]);
        end when;
        Perf_Index = min_QL + 5 * min_dPop / dPop_fact;
        annotation(Icon(coordinateSystem(extent = {{-220.0, -260.0}, {440.0, 220.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-220.0, -264.0}, {442.0, 220.0}}), Text(visible = true, lineColor = {0, 0, 255}, extent = {{-152.0, 70.0}, {368.0, 140.0}}, textString = "5th Modification", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, extent = {{-148.0, -26.0}, {372.0, 44.0}}, textString = "Optimization", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, extent = {{-150.0, -106.0}, {370.0, -36.0}}, textString = "of use of", fontName = "Arial"), Text(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, extent = {{-150.0, -192.0}, {370.0, -122.0}}, textString = "natural resources", fontName = "Arial")}), Diagram(coordinateSystem(extent = {{-220.0, -260.0}, {440.0, 220.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-62.0, 6.0}, {-58.0, 10.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{98.0, 192.0}, {102.0, 196.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{138.0, -16.0}, {142.0, -12.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-2.0, -22.0}, {2.0, -18.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-178.0, -2.0}, {-174.0, 2.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{78.0, 4.0}, {82.0, 8.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-2.0, -97.0}, {2.0, -93.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-178.0, -68.0}, {-174.0, -64.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-2.0, -68.0}, {2.0, -64.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{158.0, 28.0}, {162.0, 32.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{38.0, -262.0}, {42.0, -258.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{298.0, -102.0}, {302.0, -98.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{298.0, 28.0}, {302.0, 32.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{298.0, 78.0}, {302.0, 82.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{298.0, 169.0}, {302.0, 173.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{342.0, -171.0}, {346.0, -167.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 191}, fillPattern = FillPattern.Solid, extent = {{354.0, -234.0}, {358.0, -230.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-97.0, 6.0}, {-93.0, 10.0}}), Ellipse(visible = true, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-137.0, -22.0}, {-133.0, -18.0}})}), experiment(StartTime = 1900, StopTime = 2100), Documentation(info = "<html>
         The 6<sup>th</sup> scenario starts out from the 2<sup>nd</sup> scenario.  We now wish to vary the resource utilization rate after the year 1970. <p>
          
         <hr> <p>
          
         <b>References:</b> <p>
          
         <ol>
         <li> Cellier, F.E. (1991), <a href=\"http://www.amazon.com/Continuous-System-Modeling-Fran%C3%A7ois-Cellier/dp/0387975020\">Continuous System Modeling</a>, Springer-Verlag, New York, ISBN: 0-387-97502-0, 755p.
         <li> Forrester, J.W. (1971), <a href=\"http://www.amazon.com/World-Dynamics-Jay-W-Forrester/dp/1883823382/ref=ed_oe_h/103-2487145-1208659\">World Dynamics</a>, Pegasus Communications, 160p.
         </ol> <p>
          
         <hr> <p>
          
         Simulate the model six times across 200 years while keeping all six trajectories (plot setup menu).  For the six simulation runs, choose different levels of resource utilization after the year 1970: <br>
         <font color=red><b>NRUN2 = {0.25, 0.5, 0.75, 1.0, 1.25, 1.5}</b></font>. <p>
          
         Compute a performance index: <br>
         <font color=red><b>Perf_Index = min_QL + 5*min_dPop;</b></font> <br>
         where <b>min_QL</b> is the minimal quality of life observed between 2000 and 2100, and <b>min_dPop</b> is the largest negative population gradient observed in the same time period. <p>
          
         Plot the performance index across the calendar years between 2000 and 2100 for all six scenarios on a single graph: <p>
         <img src=\"modelica://SystemDynamics/Resources/Images/SD_Fig6.png\"> <p>
          
         <b>NRUN2 = 0.25</b> and <b>NRUN2 = 0.5</b> lead to massive die-off, whereas the other scenarios avoid this problem.  However in the short run, those scenarios that offer the worst long-term performance are characterized by the best short-term performance.  This is the predicament that humanity is currently facing. <p>
          
         <hr> <p>
         </html>", revisions = "")); 
      end Scenario_6;

      package Utilities  "Utility models of Forrester's WORLD2 model" 
        extends Modelica.Icons.Library;

        block Parameter_Change  "Parameter variation of WORLD2 model" 
          extends Interfaces.Nonlin_2;
        equation
          y = u1 * u2;
        end Parameter_Change;
        annotation(preferedView = "info", Documentation(info = "<html>
         Utility models of Forrester's <font color=red><b>WORLD2</b></font> model.
         </html>")); 
      end Utilities;
      annotation(preferedView = "info", Documentation(info = "<html>
       This model implements <a href=\"http://en.wikipedia.org/wiki/Jay_Wright_Forrester\">Jay Forrester's</a> <font color=red><b>WORLD2</b></font> model as described in his 1971 book on <a href=\"http://www.amazon.com/World-Dynamics-Jay-W-Forrester/dp/1883823382/ref=ed_oe_h/103-2487145-1208659\">World Dynamics</a>.  <p>
        
       It is a very simply model that contains only five state variables: <br>
        
       <ol>
       <li>total human population,
       <li>total persistent pollution,
       <li>remaining non-recoverable natural resources,
       <li>total capital investment, and
       <li>fraction of capital investment allocated to the agricultural sector.
       </ol> <p>
        
       The aim of the model is to demonstrate, in very simple terms, that physical systems remain always constrained.  The production of goods (especially food) on this globe is limited by the available resources, and energy constraints will prevent production to grow indefinitely. <p>
        
       While these are very simple facts, it is useful to investigate, when our globe will reach its limits.  Forrester showed that this will inevitably happen during the first half of the 21st century.  After that, humanity will invariably have to learn to transform itself from a society of (seemingly perpetual) exponential growth to one of (truly perpetual) stagnation, at least as long as humanity limits itself to the resources available on this one planet. <p>
        
       Forrester listed his entire model in his book, which made it easy for other researcher to reproduce his results.  Many people have done so using a variety of different tools.  Whereas the original model had been coded in <font color=red><b>Dynamo</b></font>, a rather clumsy and old-fashioned alphanumerical M&S environment, the most popular tool for coding System Dynamics models today is <font color=red><b>STELLA</b></font>. <p>
        
       In this library, we offer a <font color=red><b>Modelica</b></font> implementation of Forrester's <font color=red><b>WORLD2</b></font> model. <p>
        
       <hr> <p>
        
       <b>References:</b> <p>
        
       <ol>
       <li> Cellier, F.E. (1991), <a href=\"http://www.amazon.com/Continuous-System-Modeling-Fran%C3%A7ois-Cellier/dp/0387975020\">Continuous System Modeling</a>, Springer-Verlag, New York, ISBN: 0-387-97502-0, 755p.
       <li> Forrester, J.W. (1971), <a href=\"http://www.amazon.com/World-Dynamics-Jay-W-Forrester/dp/1883823382/ref=ed_oe_h/103-2487145-1208659\">World Dynamics</a>, Pegasus Communications, 160p.
       </ol> <p>
        
       <hr> <p>
       </html>", revisions = ""), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {160, 160, 160}), Text(lineColor = {0, 0, 255}, extent = {{-80, 90}, {76, 36}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "WORLD2"), Text(lineColor = {0, 0, 255}, extent = {{-73.9, 25.05}, {72, -18}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "world model as proposed"), Text(lineColor = {0, 0, 255}, extent = {{-65.8, 38.1}, {64, 12}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "describes the original"), Text(lineColor = {0, 0, 255}, extent = {{-77.7, -14.85}, {82, -64}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "his book World Dynamics."), Text(lineColor = {0, 0, 255}, extent = {{-61.6, -4.8}, {56, -31}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "by Jay Forrester in")})); 
    end World2;
    annotation(preferedView = "info", Documentation(info = "<html>
     This package offers currently two different world models: <a href=\"http://en.wikipedia.org/wiki/Jay_Wright_Forrester\">Jay Forrester's</a> <font color=red><b>WORLD2</b></font> model (1971), and <a href=\"http://en.wikipedia.org/wiki/Dennis_Meadows\">Dennis (and Dana) Meadows'</a> <font color=red><b>WORLD3</b></font> model (1972), the latter in its most recently updated form of 2004. <p>
      
     World modeling is one of the most important applications of the System Dynamics methodology.  This application, highly popular in the 1970s, has recently found renewed interest due to the widely discussed advents of <font color=red><b>Peak Oil</b></font> and <font color=red><b>Global Warming</b></font>. <p>
      
     <b>References:</b> <p>
      
     <ol>
     <li> Cellier, F.E. (1991), <a href=\"http://www.amazon.com/Continuous-System-Modeling-Fran%C3%A7ois-Cellier/dp/0387975020\">Continuous System Modeling</a>, Springer-Verlag, New York, ISBN: 0-387-97502-0, 755p.
     <li> Forrester, J.W. (1971), <a href=\"http://www.amazon.com/World-Dynamics-Jay-W-Forrester/dp/1883823382/ref=ed_oe_h/103-2487145-1208659\">World Dynamics</a>, Pegasus Communications, 160p.
     <li> Meadows, D.H., D.L. Meadows, J. Randers, and W.W. Behrens III (1972), <i>Limits to Growth: A Report for the Club of Rome's Project on the Predicament of Mankind</i>, Universe Books, New York, 205p.
     <li> Meadows, D.H., D.L. Meadows, and J. Randers (1992), <i>Beyond the Limits</i>, Chelsea Green, 300p.
     <li> Meadows, D.H., J. Randers, and D.L. Meadows (2004), <a href=\"http://www.amazon.com/Limits-Growth-Donella-H-Meadows/dp/193149858X\">Limits to Growth: The 30-Year Update</a>, Chelsea Green, 368p.
     </ol> <p>
      
     <hr> <p>
     </html>"), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {160, 160, 160}), Text(lineColor = {0, 0, 255}, extent = {{-80, 90}, {76, 36}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "World Dynamics"), Text(lineColor = {0, 0, 255}, extent = {{-65.9, 17.05}, {64, -20}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "for discussing some"), Text(lineColor = {0, 0, 255}, extent = {{-59.8, 30.1}, {56, 8}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "global world models"), Text(lineColor = {0, 0, 255}, extent = {{-45.7, -4.85}, {44, -38}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "aspects of the"), Text(lineColor = {0, 0, 255}, extent = {{-79.6, -25.8}, {80, -58}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "predicament of mankind."), Text(lineColor = {0, 0, 255}, extent = {{-54, 54}, {48, 22}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "provides a set of")})); 
  end WorldDynamics;
  annotation(__Wolfram(itemFlippingEnabled = true), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {191, 81, 6}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, lineThickness = 4, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25), Ellipse(visible = true, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, lineThickness = 20, extent = {{-50.0, -50.0}, {50.0, 50.0}}, endAngle = 175), Ellipse(visible = true, lineColor = {253, 106, 8}, lineThickness = 20, extent = {{-50.0, 50.0}, {50.0, -50.0}}, startAngle = 5, endAngle = 180), Ellipse(visible = true, lineColor = {107, 48, 3}, fillColor = {0, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Sphere, extent = {{-40.0, -40.0}, {40.0, 40.0}}), Polygon(visible = true, origin = {50.0, -13.333}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{25.0, 13.333}, {0.0, -21.667}, {-25.0, 13.333}}), Polygon(visible = true, origin = {-50.0, 13.333}, lineColor = {254, 180, 9}, fillColor = {253, 106, 8}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{25.0, -13.333}, {0.0, 21.667}, {-25.0, -13.333}})}), version = "2.1", uses(Modelica(version = "3.2.1")), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, fillPattern = FillPattern.Solid, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {160, 160, 160}), Text(lineColor = {0, 0, 255}, extent = {{-80, 90}, {76, 36}}, textString = "System Dynamics", fillColor = {0, 0, 0}, lineThickness = 0.5), Text(lineColor = {0, 0, 255}, extent = {{-57.9, 13.05}, {52, -12}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "for modeling mass"), Text(lineColor = {0, 0, 255}, extent = {{-39.8, 30.1}, {34, 10}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "methodology"), Text(lineColor = {0, 0, 255}, extent = {{-63.7, -0.85}, {58, -38}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "and information flows"), Text(lineColor = {0, 0, 255}, extent = {{-83.6, -23.8}, {82, -58}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "in a continuous-time system."), Text(lineColor = {0, 0, 255}, extent = {{-54, 54}, {48, 22}}, fillColor = {0, 0, 0}, lineThickness = 0.5, textString = "offers a general")}), Documentation(info = "<html><p>The <span style=\"color: red;\"><strong>SystemDynamics</strong></span> library is designed as a graphical library for modeling mass and information flows in a continuous-time system using <a href=\"http://en.wikipedia.org/wiki/Jay_Wright_Forrester\">Prof. Jay Forrester's</a> System Dynamics metaphor.  Two separate and independent versions of this library had originally been created by <a href=\"http://www.promasim.com/\">Dr. Stefan Fabricius</a> and by <a href=\"http://www.inf.ethz.ch/~fcellier/\">Prof. Fran&ccedil;ois Cellier</a> and his students.  These have now been merged into a single version that has furthermore been enhanced as well.</p>
   <p>System Dynamics offers a fairly low-level graphical interface, not much different from a block diagram.  The fact that continuous systems contain differential equations is hidden from the user by talking about <span style=\"color: red;\"><strong>levels</strong></span>, i.e., quantities that can accumulate (state variables), and <span style=\"color: red;\"><strong>rates</strong></span>, i.e., quantities that influence the accumulation and/or depletion of levels (state derivatives).</p>
   <p>The System Dynamics modeling metaphor is widely used especially by researchers in the life sciences and social sciences.</p>
   <p>&nbsp;</p>
   <hr />
   <p><strong>References:</strong></p>
   <p>&nbsp;</p>
   <ol>
   <li> Cellier, F.E. (1991), <a href=\"http://www.amazon.com/Continuous-System-Modeling-Fran%C3%A7ois-Cellier/dp/0387975020\">Continuous System Modeling</a>, Springer-Verlag, New York, ISBN: 0-387-97502-0, 755p. </li>
   <li> Fisher, D.M. (2007), <a href=\"http://www.iseesystems.com/store/ModelingBook/default.aspx\">Modeling Dynamic Systems: Lessons for a First Course</a>, 2<sup>nd</sup> Edition, ISEE Systems. </li>
   <li> Forrester, J.W. (1971), <a href=\"http://www.amazon.com/Principles-Systems-Jay-Wright-Forrester/dp/1883823412/ref=pd_sim_b_1_img/103-2487145-1208659\">Principles of Systems</a>, Pegasus Communications, 387p. </li>
   </ol>
   <p>&nbsp;</p>
   <hr />
   <p><strong>Corresponding Author:</strong></p>
   <p>Prof. Dr. Fran&ccedil;ois E. Cellier <br /> Institut f&uuml;r Computational Science <br /> ETH Z&uuml;rich <br /> ETH Zentrum CAB G82.1 <br /> CH-8092 Z&uuml;rich <br /> Switzerland</p>
   <p>Phone: +41(44)632-7474 <br /> Fax: +41(44)632-1374 <br /> Email: <a href=\"mailto:FCellier@Inf.ETHZ.CH\">FCellier@Inf.ETHZ.CH</a> <br /> URL: <a href=\"http://www.inf.ethz.ch/~fcellier/\">http://www.inf.ethz.ch/~fcellier/</a></p>
   <p><strong>Other Main Author:</strong></p>
   <p>Dr. Stefan Fabricius <br /> PROMASIM GmbH <br /> Dorfstr. 34 <br /> CH-8835 Feusisberg/SZ <br /> Switzerland</p>
   <p>Phone: +41(44)687-5015 <br /> Fax: +41(44)687-5016 <br /> Email: <a href=\"mailto:stefan.fabricius@promasim.ch\">stefan.fabricius@promasim.ch</a> <br /> URL: <a href=\"http://www.promasim.com/\">http://www.promasim.com/</a></p>
   <p><strong>Version 2.1 update:</strong></p>
   <p>Wolfram MathCore AB <br /> Teknikringen 1F<br />SE-583 30 Link&ouml;ping<br />Sweden</p>
   <p>Phone: +46(13)328500<br />URL: <a href=\"http://www.wolframmathcore.com/\">http://www.wolframmathcore.com/</a></p>
   <hr />
   <p><strong>Release Notes:</strong></p>
   <p>&nbsp;</p>
   <ul>
   <li>Version 1.0: April 9, 2002 </li>
   <li>Version 2.0: September 13, 2007 </li>
   <li>Version 2.1: October 16, 2013</li>
   </ul>
   <p>&nbsp;</p>
   <hr />
   <p><strong>Copyright (C) 2002-2006, Stefan Fabricius.</strong> <br /> <strong>Copyright (C) 2007-2013, Fran&ccedil;ois E. Cellier.</strong></p>
   <p><em>The SystemDynamics package is <strong>free</strong> software; it can be redistributed and/or modified under the terms of the <strong>Modelica License 1.1</strong>, see the license conditions and the accompanying <strong>disclaimer</strong> in the <a href=\"modelica://SystemDynamics/Resources/ModelicaLicense1.1.txt\">documentation</a>.</em></p>
   <p>&nbsp;</p>
   <hr /> </html>", revisions = "")); 
end SystemDynamics;

package Modelica  "Modelica Standard Library - Version 3.2.1 (Build 2)" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;

    package Continuous  "Library of continuous control blocks with internal states" 
      extends Modelica.Icons.Package;

      block Integrator  "Output the integral of the input signal" 
        parameter Real k(unit = "1") = 1 "Integrator gain";
        parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.InitialState "Type of initialization (1: no init, 2: steady state, 3,4: initial output)" annotation(Evaluate = true, Dialog(group = "Initialization"));
        parameter Real y_start = 0 "Initial or guess value of output (= state)" annotation(Dialog(group = "Initialization"));
        extends .Modelica.Blocks.Interfaces.SISO(y(start = y_start));
      initial equation
        if initType == .Modelica.Blocks.Types.Init.SteadyState then
          der(y) = 0;
        elseif initType == .Modelica.Blocks.Types.Init.InitialState or initType == .Modelica.Blocks.Types.Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(y) = k * u;
        annotation(Documentation(info = "<html>
         <p>
         This blocks computes output <b>y</b> (element-wise) as
         <i>integral</i> of the input <b>u</b> multiplied with
         the gain <i>k</i>:
         </p>
         <pre>
                  k
              y = - u
                  s
         </pre>

         <p>
         It might be difficult to initialize the integrator in steady state.
         This is discussed in the description of package
         <a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
         </p>

         </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Line(visible = true, points = {{-80.0, 78.0}, {-80.0, -90.0}}, color = {192, 192, 192}), Polygon(visible = true, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), Line(visible = true, points = {{-90.0, -80.0}, {82.0, -80.0}}, color = {192, 192, 192}), Polygon(visible = true, lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), Text(visible = true, lineColor = {192, 192, 192}, extent = {{0.0, -70.0}, {60.0, -10.0}}, textString = "I"), Text(visible = true, extent = {{-150.0, -150.0}, {150.0, -110.0}}, textString = "k=%k"), Line(visible = true, points = {{-80.0, -80.0}, {80.0, 80.0}}, color = {0, 0, 127})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-60, 60}, {60, -60}}, lineColor = {0, 0, 255}), Line(points = {{-100, 0}, {-60, 0}}, color = {0, 0, 255}), Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 255}), Text(extent = {{-36, 60}, {32, 2}}, lineColor = {0, 0, 0}, textString = "k"), Text(extent = {{-32, 0}, {36, -58}}, lineColor = {0, 0, 0}, textString = "s"), Line(points = {{-46, 0}, {46, 0}}, color = {0, 0, 0})})); 
      end Integrator;
      annotation(Documentation(info = "<html>
       <p>
       This package contains basic <b>continuous</b> input/output blocks
       described by differential equations.
       </p>

       <p>
       All blocks of this package can be initialized in different
       ways controlled by parameter <b>initType</b>. The possible
       values of initType are defined in
       <a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>:
       </p>

       <table border=1 cellspacing=0 cellpadding=2>
         <tr><td valign=\"top\"><b>Name</b></td>
             <td valign=\"top\"><b>Description</b></td></tr>

         <tr><td valign=\"top\"><b>Init.NoInit</b></td>
             <td valign=\"top\">no initialization (start values are used as guess values with fixed=false)</td></tr>

         <tr><td valign=\"top\"><b>Init.SteadyState</b></td>
             <td valign=\"top\">steady state initialization (derivatives of states are zero)</td></tr>

         <tr><td valign=\"top\"><b>Init.InitialState</b></td>
             <td valign=\"top\">Initialization with initial states</td></tr>

         <tr><td valign=\"top\"><b>Init.InitialOutput</b></td>
             <td valign=\"top\">Initialization with initial outputs (and steady state of the states if possible)</td></tr>
       </table>

       <p>
       For backward compatibility reasons the default of all blocks is
       <b>Init.NoInit</b>, with the exception of Integrator and LimIntegrator
       where the default is <b>Init.InitialState</b> (this was the initialization
       defined in version 2.2 of the Modelica standard library).
       </p>

       <p>
       In many cases, the most useful initial condition is
       <b>Init.SteadyState</b> because initial transients are then no longer
       present. The drawback is that in combination with a non-linear
       plant, non-linear algebraic equations occur that might be
       difficult to solve if appropriate guess values for the
       iteration variables are not provided (i.e., start values with fixed=false).
       However, it is often already useful to just initialize
       the linear blocks from the Continuous blocks library in SteadyState.
       This is uncritical, because only linear algebraic equations occur.
       If Init.NoInit is set, then the start values for the states are
       interpreted as <b>guess</b> values and are propagated to the
       states with fixed=<b>false</b>.
       </p>

       <p>
       Note, initialization with Init.SteadyState is usually difficult
       for a block that contains an integrator
       (Integrator, LimIntegrator, PI, PID, LimPID).
       This is due to the basic equation of an integrator:
       </p>

       <pre>
         <b>initial equation</b>
            <b>der</b>(y) = 0;   // Init.SteadyState
         <b>equation</b>
            <b>der</b>(y) = k*u;
       </pre>

       <p>
       The steady state equation leads to the condition that the input to the
       integrator is zero. If the input u is already (directly or indirectly) defined
       by another initial condition, then the initialization problem is <b>singular</b>
       (has none or infinitely many solutions). This situation occurs often
       for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
       since speed is both a state and a derivative, it is always defined by
       Init.InitialState or Init.SteadyState initialization.
       </p>

       <p>
       In such a case, <b>Init.NoInit</b> has to be selected for the integrator
       and an additional initial equation has to be added to the system
       to which the integrator is connected. E.g., useful initial conditions
       for a 1-dim. rotational inertia controlled by a PI controller are that
       <b>angle</b>, <b>speed</b>, and <b>acceleration</b> of the inertia are zero.
       </p>

       </html>"), Icon(graphics = {Line(origin = {0.061, 4.184}, points = {{81.939, 36.056}, {65.362, 36.056}, {14.39, -26.199}, {-29.966, 113.485}, {-65.374, -61.217}, {-78.061, -78.184}}, color = {95, 95, 95}, smooth = Smooth.Bezier)})); 
    end Continuous;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector" annotation(defaultComponentName = "u", Icon(graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}, coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, preserveAspectRatio = true, initialScale = 0.2)), Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{0.0, 50.0}, {100.0, 0.0}, {0.0, -50.0}, {0.0, 50.0}}), Text(lineColor = {0, 0, 127}, extent = {{-10.0, 60.0}, {-10.0, 85.0}}, textString = "%name")}), Documentation(info = "<html>
        <p>
        Connector with one input signal of type Real.
        </p>
        </html>"));
      connector RealOutput = output Real "'output Real' as connector" annotation(defaultComponentName = "y", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100.0, 50.0}, {0.0, 0.0}, {-100.0, -50.0}}), Text(lineColor = {0, 0, 127}, extent = {{30.0, 60.0}, {30.0, 110.0}}, textString = "%name")}), Documentation(info = "<html>
        <p>
        Connector with one output signal of type Real.
        </p>
        </html>"));

      partial block SISO  "Single Input Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u "Connector of Real input signal" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}}, rotation = 0)));
        RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
        annotation(Documentation(info = "<html>
         <p>
         Block has one continuous Real input and one continuous Real output signal.
         </p>
         </html>")); 
      end SISO;

      partial block SI2SO  "2 Single Input / 1 Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u1 "Connector of Real input signal 1" annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}}, rotation = 0)));
        RealInput u2 "Connector of Real input signal 2" annotation(Placement(transformation(extent = {{-140, -80}, {-100, -40}}, rotation = 0)));
        RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
        annotation(Documentation(info = "<html>
         <p>
         Block has two continuous Real input signals u1 and u2 and one
         continuous Real output signal y.
         </p>
         </html>")); 
      end SI2SO;
      annotation(Documentation(info = "<HTML>
       <p>
       This package contains interface definitions for
       <b>continuous</b> input/output blocks with Real,
       Integer and Boolean signals. Furthermore, it contains
       partial models for continuous and discrete blocks.
       </p>

       </html>", revisions = "<html>
       <ul>
       <li><i>Oct. 21, 2002</i>
              by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
              and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
              Added several new interfaces.
       <li><i>Oct. 24, 1999</i>
              by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
              RealInputSignal renamed to RealInput. RealOutputSignal renamed to
              output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
              SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
              SignalGenerator renamed to SignalSource. Introduced the following
              new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
              DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
              BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
       <li><i>June 30, 1999</i>
              by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
              Realized a first version, based on an existing Dymola library
              of Dieter Moormann and Hilding Elmqvist.</li>
       </ul>
       </html>")); 
    end Interfaces;

    package Math  "Library of Real mathematical functions as input/output blocks" 
      extends Modelica.Icons.Package;

      block Add  "Output the sum of the two inputs" 
        extends .Modelica.Blocks.Interfaces.SI2SO;
        parameter Real k1 = +1 "Gain of upper input";
        parameter Real k2 = +1 "Gain of lower input";
      equation
        y = k1 * u1 + k2 * u2;
        annotation(Documentation(info = "<html>
         <p>
         This blocks computes output <b>y</b> as <i>sum</i> of the
         two input signals <b>u1</b> and <b>u2</b>:
         </p>
         <pre>
             <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b>;
         </pre>
         <p>
         Example:
         </p>
         <pre>
              parameter:   k1= +2, k2= -3

           results in the following equations:

              y = 2 * u1 - 3 * u2
         </pre>

         </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 110}, {150, 150}}, textString = "%name"), Line(points = {{-100, 60}, {-74, 24}, {-44, 24}}, color = {0, 0, 127}), Line(points = {{-100, -60}, {-74, -28}, {-42, -28}}, color = {0, 0, 127}), Ellipse(lineColor = {0, 0, 127}, extent = {{-50, -50}, {50, 50}}), Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 127}), Text(extent = {{-38, -34}, {38, 34}}, textString = "+"), Text(extent = {{-100, 52}, {5, 92}}, textString = "%k1"), Text(extent = {{-100, -92}, {5, -52}}, textString = "%k2")}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 255}), Line(points = {{-100, 60}, {-74, 24}, {-44, 24}}, color = {0, 0, 127}), Line(points = {{-100, -60}, {-74, -28}, {-42, -28}}, color = {0, 0, 127}), Ellipse(extent = {{-50, 50}, {50, -50}}, lineColor = {0, 0, 127}), Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 127}), Text(extent = {{-36, 38}, {40, -30}}, lineColor = {0, 0, 0}, textString = "+"), Text(extent = {{-100, 52}, {5, 92}}, lineColor = {0, 0, 0}, textString = "k1"), Text(extent = {{-100, -52}, {5, -92}}, lineColor = {0, 0, 0}, textString = "k2")})); 
      end Add;

      block Division  "Output first input divided by second input" 
        extends .Modelica.Blocks.Interfaces.SI2SO;
      equation
        y = u1 / u2;
        annotation(Documentation(info = "<html>
         <p>
         This block computes the output <b>y</b> (element-wise)
         by <i>dividing</i> the corresponding elements of
         the two inputs <b>u1</b> and <b>u2</b>:
         </p>
         <pre>
             y = u1 / u2;
         </pre>

         </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics = {Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 127}), Line(points = {{-30, 0}, {30, 0}}), Ellipse(fillPattern = FillPattern.Solid, extent = {{-5, 20}, {5, 30}}), Ellipse(fillPattern = FillPattern.Solid, extent = {{-5, -30}, {5, -20}}), Ellipse(lineColor = {0, 0, 127}, extent = {{-50, -50}, {50, 50}}), Text(lineColor = {0, 0, 255}, extent = {{-150, 110}, {150, 150}}, textString = "%name"), Line(points = {{-100, 60}, {-66, 60}, {-40, 30}}, color = {0, 0, 127}), Line(points = {{-100, -60}, {0, -60}, {0, -50}}, color = {0, 0, 127})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{50, 0}, {100, 0}}, color = {0, 0, 255}), Line(points = {{-30, 0}, {30, 0}}, color = {0, 0, 0}), Ellipse(extent = {{-5, 20}, {5, 30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-5, -20}, {5, -30}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-50, 50}, {50, -50}}, lineColor = {0, 0, 255}), Line(points = {{-100, 60}, {-66, 60}, {-40, 30}}, color = {0, 0, 255}), Line(points = {{-100, -60}, {0, -60}, {0, -50}}, color = {0, 0, 255})})); 
      end Division;
      annotation(Documentation(info = "<html>
       <p>
       This package contains basic <b>mathematical operations</b>,
       such as summation and multiplication, and basic <b>mathematical
       functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
       input/output blocks. All blocks of this library can be either
       connected with continuous blocks or with sampled-data blocks.
       </p>
       </html>", revisions = "<html>
       <ul>
       <li><i>October 21, 2002</i>
              by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
              and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
              New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
       <li><i>August 7, 1999</i>
              by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
              Realized (partly based on an existing Dymola library
              of Dieter Moormann and Hilding Elmqvist).
       </li>
       </ul>
       </html>"), Icon(graphics = {Line(points = {{-80, -2}, {-68.7, 32.2}, {-61.5, 51.1}, {-55.1, 64.4}, {-49.4, 72.6}, {-43.8, 77.1}, {-38.2, 77.8}, {-32.6, 74.6}, {-26.9, 67.7}, {-21.3, 57.4}, {-14.9, 42.1}, {-6.83, 19.2}, {10.1, -32.8}, {17.3, -52.2}, {23.7, -66.2}, {29.3, -75.1}, {35, -80.4}, {40.6, -82}, {46.2, -79.6}, {51.9, -73.5}, {57.5, -63.9}, {63.9, -49.2}, {72, -26.8}, {80, -2}}, color = {95, 95, 95}, smooth = Smooth.Bezier)})); 
    end Math;

    package Types  "Library of constants and types with choices, especially to build menus" 
      extends Modelica.Icons.TypesPackage;
      type Init = enumeration(NoInit "No initialization (start values are used as guess values with fixed=false)", SteadyState "Steady state initialization (derivatives of states are zero)", InitialState "Initialization with initial states", InitialOutput "Initialization with initial outputs (and steady state of the states if possible)") "Enumeration defining initialization of a block" annotation(Evaluate = true, Documentation(info = "<html>
          <p>The following initialization alternatives are available:</p>
          <dl>
            <dt><code><strong>NoInit</strong></code></dt>
              <dd>No initialization (start values are used as guess values with <code>fixed=false</code>)</dd>
            <dt><code><strong>SteadyState</strong></code></dt>
              <dd>Steady state initialization (derivatives of states are zero)</dd>
            <dt><code><strong>InitialState</strong></code></dt>
              <dd>Initialization with initial states</dd>
            <dt><code><strong>InitialOutput</strong></code></dt>
              <dd>Initialization with initial outputs (and steady state of the states if possible)</dd>
          </dl>
        </html>"));
      annotation(Documentation(info = "<HTML>
       <p>
       In this package <b>types</b>, <b>constants</b> and <b>external objects</b> are defined that are used
       in library Modelica.Blocks. The types have additional annotation choices
       definitions that define the menus to be built up in the graphical
       user interface when the type is used as parameter in a declaration.
       </p>
       </HTML>")); 
    end Types;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block"  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-150, 150}, {150, 110}}, textString = "%name", lineColor = {0, 0, 255})}), Documentation(info = "<html>
        <p>
        Block that has only the basic icon for an input/output
        block (no declarations, no equations). Most blocks
        of package Modelica.Blocks inherit directly or indirectly
        from this block.
        </p>
        </html>")); end Block;
    end Icons;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}, initialScale = 0.1), graphics = {Rectangle(origin = {0.0, 35.1488}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Rectangle(origin = {0.0, -34.8512}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), Polygon(origin = {-40.0, 35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), Polygon(origin = {40.0, -35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}), Documentation(info = "<html>
     <p>
     This library contains input/output blocks to build up block diagrams.
     </p>

     <dl>
     <dt><b>Main Author:</b>
     <dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
         Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
         Oberpfaffenhofen<br>
         Postfach 1116<br>
         D-82230 Wessling<br>
         email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
     </dl>
     <p>
     Copyright &copy; 1998-2013, Modelica Association and DLR.
     </p>
     <p>
     <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
     </p>
     </html>", revisions = "<html>
     <ul>
     <li><i>June 23, 2004</i>
            by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
            Introduced new block connectors and adapted all blocks to the new connectors.
            Included subpackages Continuous, Discrete, Logical, Nonlinear from
            package ModelicaAdditions.Blocks.
            Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
            and in the new package Modelica.Blocks.Tables.
            Added new blocks to Blocks.Sources and Blocks.Logical.
            </li>
     <li><i>October 21, 2002</i>
            by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
            and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
            New subpackage Examples, additional components.
            </li>
     <li><i>June 20, 2000</i>
            by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
            Michael Tiller:<br>
            Introduced a replaceable signal type into
            Blocks.Interfaces.RealInput/RealOutput:
     <pre>
        replaceable type SignalType = Real
     </pre>
            in order that the type of the signal of an input/output block
            can be changed to a physical type, for example:
     <pre>
        Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
     </pre>
           </li>
     <li><i>Sept. 18, 1999</i>
            by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
            Renamed to Blocks. New subpackages Math, Nonlinear.
            Additional components in subpackages Interfaces, Continuous
            and Sources. </li>
     <li><i>June 30, 1999</i>
            by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
            Realized a first version, based on an existing Dymola library
            of Dieter Moormann and Hilding Elmqvist.</li>
     </ul>
     </html>")); 
  end Blocks;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial model Example  "Icon for runnable examples"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}), Documentation(info = "<html>
      <p>This icon indicates an example. The play button suggests that the example can be executed.</p>
      </html>")); end Example;

    partial package Package  "Icon for standard packages"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, fillPattern = FillPattern.None, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0)}), Documentation(info = "<html>
      <p>Standard package icon.</p>
      </html>")); end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {20.0, 0.0}, lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-10.0, 70.0}, {10.0, 70.0}, {40.0, 20.0}, {80.0, 20.0}, {80.0, -20.0}, {40.0, -20.0}, {10.0, -70.0}, {-10.0, -70.0}}), Polygon(fillColor = {102, 102, 102}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-100.0, 20.0}, {-60.0, 20.0}, {-30.0, 70.0}, {-10.0, 70.0}, {-10.0, -70.0}, {-30.0, -70.0}, {-60.0, -20.0}, {-100.0, -20.0}})}), Documentation(info = "<html>
       <p>This icon indicates packages containing interfaces.</p>
       </html>")); 
    end InterfacesPackage;

    partial package TypesPackage  "Icon for packages containing type definitions" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-12.167, -23}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{12.167, 65}, {14.167, 93}, {36.167, 89}, {24.167, 20}, {4.167, -30}, {14.167, -30}, {24.167, -30}, {24.167, -40}, {-5.833, -50}, {-15.833, -30}, {4.167, 20}, {12.167, 65}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Polygon(origin = {2.7403, 1.6673}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{49.2597, 22.3327}, {31.2597, 24.3327}, {7.2597, 18.3327}, {-26.7403, 10.3327}, {-46.7403, 14.3327}, {-48.7403, 6.3327}, {-32.7403, 0.3327}, {-6.7403, 4.3327}, {33.2597, 14.3327}, {49.2597, 14.3327}, {49.2597, 22.3327}}, smooth = Smooth.Bezier)})); 
    end TypesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-8.167, -17}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Ellipse(origin = {-0.5, 56.5}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, lineColor = {0, 0, 0})})); 
    end IconsPackage;

    partial package Library  "This icon will be removed in future Modelica versions, use Package instead"  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {200, 200, 200}, fillColor = {248, 248, 248}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0), Rectangle(lineColor = {128, 128, 128}, fillPattern = FillPattern.None, extent = {{-100.0, -100.0}, {100.0, 100.0}}, radius = 25.0)}), Documentation(info = "<html>
      <p>This icon of a package will be removed in future versions of the library.</p>
      <h5>Note</h5>
      <p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Package\">Package</a> shall be used.</p>
      </html>")); end Library;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(origin = {-8.167, -17}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, smooth = Smooth.Bezier, lineColor = {0, 0, 0}), Ellipse(origin = {-0.5, 56.5}, fillColor = {128, 128, 128}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5, -12.5}, {12.5, 12.5}}, lineColor = {0, 0, 0})}), Documentation(info = "<html>
     <p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer. </p>

     <h4>Main Authors:</h4>

     <dl>
     <dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
         <dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd>
         <dd>Oberpfaffenhofen</dd>
         <dd>Postfach 1116</dd>
         <dd>D-82230 Wessling</dd>
         <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
     <dt>Christian Kral</dt>
         <dd><a href=\"http://www.ait.ac.at/\">Austrian Institute of Technology, AIT</a></dd>
         <dd>Mobility Department</dd><dd>Giefinggasse 2</dd>
         <dd>1210 Vienna, Austria</dd>
         <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
     <dt>Johan Andreasson</dt>
         <dd><a href=\"http://www.modelon.se/\">Modelon AB</a></dd>
         <dd>Ideon Science Park</dd>
         <dd>22370 Lund, Sweden</dd>
         <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
     </dl>

     <p>Copyright &copy; 1998-2013, Modelica Association, DLR, AIT, and Modelon AB. </p>
     <p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
     </html>")); 
  end Icons;
  annotation(preferredView = "info", version = "3.2.1", versionBuild = 3, versionDate = "2013-08-14", dateModified = "2013-08-23 19:30:00Z", revisionId = "$Id:: package.mo 6954 2013-08-23 17:46:49Z #$", uses(Complex(version = "3.2.1"), ModelicaServices(version = "3.2.1")), conversion(noneFromVersion = "3.2", noneFromVersion = "3.1", noneFromVersion = "3.0.1", noneFromVersion = "3.0", from(version = "2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.1", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"), from(version = "2.2.2", script = "modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")), Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Polygon(origin = {-6.9888, 20.048}, fillColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-93.0112, 10.3188}, {-93.0112, 10.3188}, {-73.011, 24.6}, {-63.011, 31.221}, {-51.219, 36.777}, {-39.842, 38.629}, {-31.376, 36.248}, {-25.819, 29.369}, {-24.232, 22.49}, {-23.703, 17.463}, {-15.501, 25.135}, {-6.24, 32.015}, {3.02, 36.777}, {15.191, 39.423}, {27.097, 37.306}, {32.653, 29.633}, {35.035, 20.108}, {43.501, 28.046}, {54.085, 35.19}, {65.991, 39.952}, {77.897, 39.688}, {87.422, 33.338}, {91.126, 21.696}, {90.068, 9.525}, {86.099, -1.058}, {79.749, -10.054}, {71.283, -21.431}, {62.816, -33.337}, {60.964, -32.808}, {70.489, -16.14}, {77.368, -2.381}, {81.072, 10.054}, {79.749, 19.05}, {72.605, 24.342}, {61.758, 23.019}, {49.587, 14.817}, {39.003, 4.763}, {29.214, -6.085}, {21.012, -16.669}, {13.339, -26.458}, {5.401, -36.777}, {-1.213, -46.037}, {-6.24, -53.446}, {-8.092, -52.387}, {-0.684, -40.746}, {5.401, -30.692}, {12.81, -17.198}, {19.424, -3.969}, {23.658, 7.938}, {22.335, 18.785}, {16.514, 23.283}, {8.047, 23.019}, {-1.478, 19.05}, {-11.267, 11.113}, {-19.734, 2.381}, {-29.259, -8.202}, {-38.519, -19.579}, {-48.044, -31.221}, {-56.511, -43.392}, {-64.449, -55.298}, {-72.386, -66.939}, {-77.678, -74.612}, {-79.53, -74.083}, {-71.857, -61.383}, {-62.861, -46.037}, {-52.278, -28.046}, {-44.869, -15.346}, {-38.784, -2.117}, {-35.344, 8.731}, {-36.403, 19.844}, {-42.488, 23.813}, {-52.013, 22.49}, {-60.744, 16.933}, {-68.947, 10.054}, {-76.884, 2.646}, {-93.0112, -12.1707}, {-93.0112, -12.1707}}, smooth = Smooth.Bezier), Ellipse(origin = {40.8208, -37.7602}, fillColor = {161, 0, 4}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-17.8562, -17.8563}, {17.8563, 17.8562}})}), Documentation(info = "<HTML>
   <p>
   Package <b>Modelica&reg;</b> is a <b>standardized</b> and <b>free</b> package
   that is developed together with the Modelica&reg; language from the
   Modelica Association, see
   <a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>.
   It is also called <b>Modelica Standard Library</b>.
   It provides model components in many domains that are based on
   standardized interface definitions. Some typical examples are shown
   in the next figure:
   </p>

   <p>
   <img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">
   </p>

   <p>
   For an introduction, have especially a look at:
   </p>
   <ul>
   <li> <a href=\"modelica://Modelica.UsersGuide.Overview\">Overview</a>
     provides an overview of the Modelica Standard Library
     inside the <a href=\"modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
   <li><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the changes of new versions of this package.</li>
   <li> <a href=\"modelica://Modelica.UsersGuide.Contact\">Contact</a>
     lists the contributors of the Modelica Standard Library.</li>
   <li> The <b>Examples</b> packages in the various libraries, demonstrate
     how to use the components of the corresponding sublibrary.</li>
   </ul>

   <p>
   This version of the Modelica Standard Library consists of
   </p>
   <ul>
   <li><b>1360</b> models and blocks, and</li>
   <li><b>1280</b> functions</li>
   </ul>
   <p>
   that are directly usable (= number of public, non-partial classes). It is fully compliant
   to <a href=\"https://www.modelica.org/documents/ModelicaSpec32Revision2.pdf\">Modelica Specification Version 3.2 Revision 2</a>
   and it has been tested with Modelica tools from different vendors.
   </p>

   <p>
   <b>Licensed by the Modelica Association under the Modelica License 2</b><br>
   Copyright &copy; 1998-2013, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, Fraunhofer, A.Haumer, ITI, Modelon,
   TU Hamburg-Harburg, Politecnico di Milano, XRG Simulation.
   </p>

   <p>
   <i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
   </p>

   <p>
   <b>Modelica&reg;</b> is a registered trademark of the Modelica Association.
   </p>
   </html>")); 
end Modelica;

model Scenario6
  extends SystemDynamics.WorldDynamics.World2.Scenario_6;
end Scenario6;