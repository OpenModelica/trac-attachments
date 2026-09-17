// Seems like a bug in verison 1.12.0 of 3 May 2017
model SpinArtistry
import Modelica.SIunits;
import Modelica.Mechanics.MultiBody.Frames.Orientation;
import Modelica.Mechanics.MultiBody.Frames.axisRotation;
import Modelica.Mechanics.MultiBody.Visualizers;
import Modelica.Mechanics.MultiBody.Frames;
import Modelica.Mechanics.MultiBody.Types.Color;
  // Running "simulate" on this model will result in a 
  // Translation Error "The given system is mixed-determined.
  // [index > 3]"
  // If you comment/uncomment the following lines to change
  // the following declaration from a parameter to a constant,
  // it will succeed.
  parameter SIunits.AngularVelocity der_angle = 10.0;
  //constant SIunits.AngularVelocity der_angle = 10.0;

  //parameter Frames.Orientation Rtilt = Frames.axisRotation(3, -0.7, 0);
  constant Frames.Orientation Rtilt = Frames.axisRotation(3, -0.7, 0);
  SIunits.Angle angle;
  Frames.Orientation R;
     
initial equation
  angle = 0.0;
  R = Frames.absoluteRotation(Frames.Orientation(T=identity(3),w={0,der_angle,0}), Rtilt);
equation
  der_angle = der(angle);
  R = Frames.absoluteRotation(Frames.axisRotation(2, angle, der_angle), Rtilt);  
end SpinArtistry;
