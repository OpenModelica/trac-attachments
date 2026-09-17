package TestSmallRotations
  function smallRotation_new "Return rotation angles valid for a small rotation and optionally residues that should be zero"
  extends Modelica.Icons.Function;
    input Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation T "Orientation object to rotate frame 1 into frame 2";
    output Modelica.SIunits.Angle phi[3] "The rotation angles around x-, y-, and z-axis of frame 1 to rotate frame 1 into frame 2 for a small rotation + optionally 3 residues that should be zero";
  algorithm
    phi := {T[2, 3], -T[1, 3], T[1, 2]};
    annotation(
      Inline = true);
  end smallRotation_new;

  model TestSmallRotation
  
    parameter Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation R = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation() "Orientation object to rotate frame 1 into frame 2";
    parameter Boolean withResidues=false  "= false/true, if 'angles'/'angles and residues' are returned in phi";
    Modelica.SIunits.Angle phi[if withResidues then 6 else 3];
  equation
    phi = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.smallRotation(R, withResidues);
  

  end TestSmallRotation;
  
  model TestSmallRotation_new
  
    parameter Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation R = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.nullRotation() "Orientation object to rotate frame 1 into frame 2";
    parameter Boolean withResidues=false  "= false/true, if 'angles'/'angles and residues' are returned in phi";
    Modelica.SIunits.Angle phi[if withResidues then 6 else 3];
  equation
    phi = smallRotation_new(R);
  
  
  end TestSmallRotation_new;
end TestSmallRotations;
