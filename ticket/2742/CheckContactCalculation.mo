package ModelicaServices  
  extends Modelica.Icons.Package;

  package Animation  
    extends Modelica.Icons.Package;

    model Shape  
      extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;
    end Shape;

    model Surface  
      extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface;
    end Surface;
  end Animation;

  package Machine  
    extends Modelica.Icons.Package;
    final constant Real eps = 1.e-15;
    final constant Real small = 1.e-60;
    final constant Real inf = 1.e+60;
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax();
  end Machine;
end ModelicaServices;

package Modelica  
  extends Modelica.Icons.Package;

  package Mechanics  
    extends Modelica.Icons.Package;

    package MultiBody  
      extends Modelica.Icons.Package;

      model World  
        Interfaces.Frame_b frame_b;
        parameter Boolean enableAnimation = true;
        parameter Boolean animateWorld = true;
        parameter Boolean animateGravity = true;
        parameter .Modelica.Mechanics.MultiBody.Types.AxisLabel label1 = "x";
        parameter .Modelica.Mechanics.MultiBody.Types.AxisLabel label2 = "y";
        parameter .Modelica.Mechanics.MultiBody.Types.GravityTypes gravityType = Types.GravityTypes.UniformGravity annotation(Evaluate = true);
        parameter .Modelica.SIunits.Acceleration g = 9.81;
        parameter .Modelica.Mechanics.MultiBody.Types.Axis n = {0, -1, 0} annotation(Evaluate = true);
        parameter Real mue(unit = "m3/s2", min = 0) = 3.986e14;
        parameter Boolean driveTrainMechanics3D = true;
        parameter .Modelica.SIunits.Distance axisLength = nominalLength / 2;
        parameter .Modelica.SIunits.Distance axisDiameter = axisLength / defaultFrameDiameterFraction;
        parameter Boolean axisShowLabels = true;
        input .Modelica.Mechanics.MultiBody.Types.Color axisColor_x = Types.Defaults.FrameColor;
        input .Modelica.Mechanics.MultiBody.Types.Color axisColor_y = axisColor_x;
        input .Modelica.Mechanics.MultiBody.Types.Color axisColor_z = axisColor_x;
        parameter .Modelica.SIunits.Position[3] gravityArrowTail = {0, 0, 0};
        parameter .Modelica.SIunits.Length gravityArrowLength = axisLength / 2;
        parameter .Modelica.SIunits.Diameter gravityArrowDiameter = gravityArrowLength / defaultWidthFraction;
        input .Modelica.Mechanics.MultiBody.Types.Color gravityArrowColor = {0, 230, 0};
        parameter .Modelica.SIunits.Diameter gravitySphereDiameter = 12742000;
        input .Modelica.Mechanics.MultiBody.Types.Color gravitySphereColor = {0, 230, 0};
        parameter .Modelica.SIunits.Length nominalLength = 1;
        parameter .Modelica.SIunits.Length defaultAxisLength = nominalLength / 5;
        parameter .Modelica.SIunits.Length defaultJointLength = nominalLength / 10;
        parameter .Modelica.SIunits.Length defaultJointWidth = nominalLength / 20;
        parameter .Modelica.SIunits.Length defaultForceLength = nominalLength / 10;
        parameter .Modelica.SIunits.Length defaultForceWidth = nominalLength / 20;
        parameter .Modelica.SIunits.Length defaultBodyDiameter = nominalLength / 9;
        parameter Real defaultWidthFraction = 20;
        parameter .Modelica.SIunits.Length defaultArrowDiameter = nominalLength / 40;
        parameter Real defaultFrameDiameterFraction = 40;
        parameter Real defaultSpecularCoefficient(min = 0) = 0.7;
        parameter Real defaultN_to_m(unit = "N/m", min = 0) = 1000;
        parameter Real defaultNm_to_m(unit = "N.m/m", min = 0) = 1000;
      protected
        parameter Integer ndim = if enableAnimation and animateWorld then 1 else 0;
        parameter Integer ndim2 = if enableAnimation and animateWorld and axisShowLabels then 1 else 0;
        parameter .Modelica.SIunits.Length headLength = min(axisLength, axisDiameter * Types.Defaults.FrameHeadLengthFraction);
        parameter .Modelica.SIunits.Length headWidth = axisDiameter * Types.Defaults.FrameHeadWidthFraction;
        parameter .Modelica.SIunits.Length lineLength = max(0, axisLength - headLength);
        parameter .Modelica.SIunits.Length lineWidth = axisDiameter;
        parameter .Modelica.SIunits.Length scaledLabel = Types.Defaults.FrameLabelHeightFraction * axisDiameter;
        parameter .Modelica.SIunits.Length labelStart = 1.05 * axisLength;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowLine(shapeType = "cylinder", length = lineLength, width = lineWidth, height = lineWidth, lengthDirection = {1, 0, 0}, widthDirection = {0, 1, 0}, color = axisColor_x, specularCoefficient = 0) if enableAnimation and animateWorld;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowHead(shapeType = "cone", length = headLength, width = headWidth, height = headWidth, lengthDirection = {1, 0, 0}, widthDirection = {0, 1, 0}, color = axisColor_x, r = {lineLength, 0, 0}, specularCoefficient = 0) if enableAnimation and animateWorld;
        Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines x_label(lines = scaledLabel * {[0, 0; 1, 1], [0, 1; 1, 0]}, diameter = axisDiameter, color = axisColor_x, r_lines = {labelStart, 0, 0}, n_x = {1, 0, 0}, n_y = {0, 1, 0}, specularCoefficient = 0) if enableAnimation and animateWorld and axisShowLabels;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowLine(shapeType = "cylinder", length = lineLength, width = lineWidth, height = lineWidth, lengthDirection = {0, 1, 0}, widthDirection = {1, 0, 0}, color = axisColor_y, specularCoefficient = 0) if enableAnimation and animateWorld;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowHead(shapeType = "cone", length = headLength, width = headWidth, height = headWidth, lengthDirection = {0, 1, 0}, widthDirection = {1, 0, 0}, color = axisColor_y, r = {0, lineLength, 0}, specularCoefficient = 0) if enableAnimation and animateWorld;
        Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines y_label(lines = scaledLabel * {[0, 0; 1, 1.5], [0, 1.5; 0.5, 0.75]}, diameter = axisDiameter, color = axisColor_y, r_lines = {0, labelStart, 0}, n_x = {0, 1, 0}, n_y = {-1, 0, 0}, specularCoefficient = 0) if enableAnimation and animateWorld and axisShowLabels;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowLine(shapeType = "cylinder", length = lineLength, width = lineWidth, height = lineWidth, lengthDirection = {0, 0, 1}, widthDirection = {0, 1, 0}, color = axisColor_z, specularCoefficient = 0) if enableAnimation and animateWorld;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowHead(shapeType = "cone", length = headLength, width = headWidth, height = headWidth, lengthDirection = {0, 0, 1}, widthDirection = {0, 1, 0}, color = axisColor_z, r = {0, 0, lineLength}, specularCoefficient = 0) if enableAnimation and animateWorld;
        Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines z_label(lines = scaledLabel * {[0, 0; 1, 0], [0, 1; 1, 1], [0, 1; 1, 0]}, diameter = axisDiameter, color = axisColor_z, r_lines = {0, 0, labelStart}, n_x = {0, 0, 1}, n_y = {0, 1, 0}, specularCoefficient = 0) if enableAnimation and animateWorld and axisShowLabels;
        parameter .Modelica.SIunits.Length gravityHeadLength = min(gravityArrowLength, gravityArrowDiameter * Types.Defaults.ArrowHeadLengthFraction);
        parameter .Modelica.SIunits.Length gravityHeadWidth = gravityArrowDiameter * Types.Defaults.ArrowHeadWidthFraction;
        parameter .Modelica.SIunits.Length gravityLineLength = max(0, gravityArrowLength - gravityHeadLength);
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowLine(shapeType = "cylinder", length = gravityLineLength, width = gravityArrowDiameter, height = gravityArrowDiameter, lengthDirection = n, widthDirection = {0, 1, 0}, color = gravityArrowColor, r_shape = gravityArrowTail, specularCoefficient = 0) if enableAnimation and animateGravity and gravityType == Types.GravityTypes.UniformGravity;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowHead(shapeType = "cone", length = gravityHeadLength, width = gravityHeadWidth, height = gravityHeadWidth, lengthDirection = n, widthDirection = {0, 1, 0}, color = gravityArrowColor, r_shape = gravityArrowTail + Modelica.Math.Vectors.normalize(n) * gravityLineLength, specularCoefficient = 0) if enableAnimation and animateGravity and gravityType == Types.GravityTypes.UniformGravity;
        parameter Integer ndim_pointGravity = if enableAnimation and animateGravity and gravityType == Types.GravityTypes.UniformGravity then 1 else 0;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravitySphere(shapeType = "sphere", r_shape = {-gravitySphereDiameter / 2, 0, 0}, lengthDirection = {1, 0, 0}, length = gravitySphereDiameter, width = gravitySphereDiameter, height = gravitySphereDiameter, color = gravitySphereColor, specularCoefficient = 0) if enableAnimation and animateGravity and gravityType == Types.GravityTypes.PointGravity;
      equation
        Connections.root(frame_b.R);
        assert(Modelica.Math.Vectors.length(n) > 1.e-10, "Parameter n of World object is wrong (length(n) > 0 required)");
        frame_b.r_0 = zeros(3);
        frame_b.R = Frames.nullRotation();
      end World;

      package Frames  
        extends Modelica.Icons.Package;

        record Orientation  
          extends Modelica.Icons.Record;
          Real[3, 3] T;
          .Modelica.SIunits.AngularVelocity[3] w;

          encapsulated function equalityConstraint  
            extends .Modelica.Icons.Function;
            input .Modelica.Mechanics.MultiBody.Frames.Orientation R1;
            input .Modelica.Mechanics.MultiBody.Frames.Orientation R2;
            output Real[3] residue;
          algorithm
            residue := {.Modelica.Math.atan2(cross(R1.T[1, :], R1.T[2, :]) * R2.T[2, :], R1.T[1, :] * R2.T[1, :]), .Modelica.Math.atan2(-cross(R1.T[1, :], R1.T[2, :]) * R2.T[1, :], R1.T[2, :] * R2.T[2, :]), .Modelica.Math.atan2(R1.T[2, :] * R2.T[1, :], R1.T[3, :] * R2.T[3, :])};
          end equalityConstraint;
        end Orientation;

        function nullRotation  
          extends Modelica.Icons.Function;
          output Orientation R;
        algorithm
          R := Orientation(T = identity(3), w = zeros(3));
        end nullRotation;

        package TransformationMatrices  
          extends Modelica.Icons.Package;

          type Orientation  
            extends Internal.TransformationMatrix;

            encapsulated function equalityConstraint  
              extends .Modelica.Icons.Function;
              input .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation T1;
              input .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation T2;
              output Real[3] residue;
            algorithm
              residue := {cross(T1[1, :], T1[2, :]) * T2[2, :], -cross(T1[1, :], T1[2, :]) * T2[1, :], T1[2, :] * T2[1, :]};
            end equalityConstraint;
          end Orientation;

          function resolve1  
            extends Modelica.Icons.Function;
            input TransformationMatrices.Orientation T;
            input Real[3] v2;
            output Real[3] v1;
          algorithm
            v1 := transpose(T) * v2;
          end resolve1;

          function absoluteRotation  
            extends Modelica.Icons.Function;
            input TransformationMatrices.Orientation T1;
            input TransformationMatrices.Orientation T_rel;
            output TransformationMatrices.Orientation T2;
          algorithm
            T2 := T_rel * T1;
          end absoluteRotation;

          function from_nxy  
            extends Modelica.Icons.Function;
            input Real[3] n_x(each final unit = "1");
            input Real[3] n_y(each final unit = "1");
            output TransformationMatrices.Orientation T;
          protected
            Real abs_n_x = sqrt(n_x * n_x);
            Real[3] e_x(each final unit = "1") = if abs_n_x < 1.e-10 then {1, 0, 0} else n_x / abs_n_x;
            Real[3] n_z_aux(each final unit = "1") = cross(e_x, n_y);
            Real[3] n_y_aux(each final unit = "1") = if n_z_aux * n_z_aux > 1.0e-6 then n_y else if abs(e_x[1]) > 1.0e-6 then {0, 1, 0} else {1, 0, 0};
            Real[3] e_z_aux(each final unit = "1") = cross(e_x, n_y_aux);
            Real[3] e_z(each final unit = "1") = e_z_aux / sqrt(e_z_aux * e_z_aux);
          algorithm
            T := {e_x, cross(e_z, e_x), e_z};
          end from_nxy;
        end TransformationMatrices;

        package Internal  
          extends Modelica.Icons.InternalPackage;
          type TransformationMatrix = Real[3, 3];
        end Internal;
      end Frames;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

        connector Frame  
          .Modelica.SIunits.Position[3] r_0;
          Frames.Orientation R;
          flow .Modelica.SIunits.Force[3] f annotation(unassignedMessage = "All Forces cannot be uniquely calculated.
            The reason could be that the mechanism contains
            a planar loop or that joints constrain the
            same motion. For planar loops, use for one
            revolute joint per loop the joint
            Joints.RevolutePlanarLoopConstraint instead of
            Joints.Revolute.");
          flow .Modelica.SIunits.Torque[3] t;
        end Frame;

        connector Frame_b  
          extends Frame;
        end Frame_b;

        partial function partialSurfaceCharacteristic  
          extends Modelica.Icons.Function;
          input Integer nu;
          input Integer nv;
          input Boolean multiColoredSurface = false;
          output Modelica.SIunits.Position[nu, nv] X;
          output Modelica.SIunits.Position[nu, nv] Y;
          output Modelica.SIunits.Position[nu, nv] Z;
          output Real[if multiColoredSurface then nu else 0, if multiColoredSurface then nv else 0, 3] C;
        end partialSurfaceCharacteristic;
      end Interfaces;

      package Visualizers  
        extends Modelica.Icons.Package;

        package Advanced  
          extends Modelica.Icons.Package;

          model Shape  
            extends ModelicaServices.Animation.Shape;
            extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialShape;
          end Shape;

          model Surface  
            extends Modelica.Mechanics.MultiBody.Icons.Surface;
            extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialSurface;
            extends ModelicaServices.Animation.Surface;
          end Surface;
        end Advanced;

        package Internal  
          extends Modelica.Icons.InternalPackage;

          model Lines  
            input Modelica.Mechanics.MultiBody.Frames.Orientation R = .Modelica.Mechanics.MultiBody.Frames.nullRotation();
            input .Modelica.SIunits.Position[3] r = {0, 0, 0};
            input .Modelica.SIunits.Position[3] r_lines = {0, 0, 0};
            input Real[3] n_x(each final unit = "1") = {1, 0, 0};
            input Real[3] n_y(each final unit = "1") = {0, 1, 0};
            input .Modelica.SIunits.Position[:, 2, 2] lines = zeros(0, 2, 2);
            input .Modelica.SIunits.Length diameter(min = 0) = 0.05;
            input Modelica.Mechanics.MultiBody.Types.Color color = {0, 128, 255};
            input .Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = 0.7;
          protected
            parameter Integer n = size(lines, 1);
            .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation R_rel = .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_nxy(n_x, n_y);
            .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation R_lines = .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.absoluteRotation(R.T, R_rel);
            Modelica.SIunits.Position[3] r_abs = r + .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1(R.T, r_lines);
            Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape[n] cylinders(each shapeType = "cylinder", lengthDirection = array(.Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1(R_rel, vector([lines[i, 2, :] - lines[i, 1, :]; 0])) for i in 1:n), length = array(Modelica.Math.Vectors.length(lines[i, 2, :] - lines[i, 1, :]) for i in 1:n), r = array(r_abs + .Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve1(R_lines, vector([lines[i, 1, :]; 0])) for i in 1:n), each width = diameter, each height = diameter, each widthDirection = {0, 1, 0}, each color = color, each R = R, each specularCoefficient = specularCoefficient);
          end Lines;
        end Internal;
      end Visualizers;

      package Types  
        extends Modelica.Icons.TypesPackage;
        type Axis = Modelica.Icons.TypeReal[3](each final unit = "1");
        type AxisLabel = Modelica.Icons.TypeString;
        type Color = Modelica.Icons.TypeInteger[3](each min = 0, each max = 255);
        type SpecularCoefficient = Modelica.Icons.TypeReal(min = 0);
        type ShapeType = Modelica.Icons.TypeString;
        type ShapeExtra = Modelica.Icons.TypeReal;
        type GravityTypes = enumeration(NoGravity, UniformGravity, PointGravity);

        package Defaults  
          extends Modelica.Icons.Package;
          constant Types.Color FrameColor = {0, 0, 0};
          constant Real FrameHeadLengthFraction = 5.0;
          constant Real FrameHeadWidthFraction = 3.0;
          constant Real FrameLabelHeightFraction = 3.0;
          constant Real ArrowHeadLengthFraction = 4.0;
          constant Real ArrowHeadWidthFraction = 3.0;
        end Defaults;
      end Types;

      package Icons  
        extends Modelica.Icons.IconsPackage;

        model Surface  end Surface;
      end Icons;
    end MultiBody;
  end Mechanics;

  package Math  
    extends Modelica.Icons.Package;

    package Icons  
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  end AxisCenter;
    end Icons;

    package Vectors  
      extends Modelica.Icons.Package;

      function length  
        extends Modelica.Icons.Function;
        input Real[:] v;
        output Real result;
      algorithm
        result := sqrt(v * v);
      end length;

      function normalize  
        extends Modelica.Icons.Function;
        input Real[:] v;
        input Real eps(min = 0.0) = 100 * Modelica.Constants.eps;
        output Real[size(v, 1)] result;
      algorithm
        result := smooth(0, noEvent(if length(v) >= eps then v / length(v) else v / eps));
      end normalize;
    end Vectors;

    function asin  
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = asin(u);
    end asin;

    function atan2  
      extends Modelica.Math.Icons.AxisCenter;
      input Real u1;
      input Real u2;
      output .Modelica.SIunits.Angle y;
      external "builtin" y = atan2(u1, u2);
    end atan2;

    function exp  
      extends Modelica.Math.Icons.AxisCenter;
      input Real u;
      output Real y;
      external "builtin" y = exp(u);
    end exp;
  end Math;

  package Utilities  
    extends Modelica.Icons.Package;

    package Internal  
      extends Modelica.Icons.InternalPackage;

      partial package PartialModelicaServices  
        extends Modelica.Icons.InternalPackage;

        package Animation  
          extends Modelica.Icons.Package;

          partial model PartialShape  
            parameter .Modelica.Mechanics.MultiBody.Types.ShapeType shapeType = "box";
            input .Modelica.Mechanics.MultiBody.Frames.Orientation R = .Modelica.Mechanics.MultiBody.Frames.nullRotation();
            input .Modelica.SIunits.Position[3] r = {0, 0, 0};
            input .Modelica.SIunits.Position[3] r_shape = {0, 0, 0};
            input Real[3] lengthDirection(each final unit = "1") = {1, 0, 0};
            input Real[3] widthDirection(each final unit = "1") = {0, 1, 0};
            input .Modelica.SIunits.Length length = 0;
            input .Modelica.SIunits.Length width = 0;
            input .Modelica.SIunits.Length height = 0;
            input .Modelica.Mechanics.MultiBody.Types.ShapeExtra extra = 0.0;
            input Real[3] color = {255, 0, 0};
            input .Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = 0.7;
          end PartialShape;

          model PartialSurface  
            input .Modelica.Mechanics.MultiBody.Frames.Orientation R = .Modelica.Mechanics.MultiBody.Frames.nullRotation();
            input Modelica.SIunits.Position[3] r_0 = {0, 0, 0};
            parameter Integer nu = 2;
            parameter Integer nv = 2;
            replaceable function surfaceCharacteristic = Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic;
            parameter Boolean wireframe = false;
            parameter Boolean multiColoredSurface = false;
            input Real[3] color = {255, 0, 0};
            input .Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = 0.7;
            input Real transparency = 0;
          end PartialSurface;
        end Animation;
      end PartialModelicaServices;
    end Internal;
  end Utilities;

  package Constants  
    extends Modelica.Icons.Package;
    final constant Real pi = 2 * Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps;
    final constant .Modelica.SIunits.Velocity c = 299792458;
    final constant Real mue_0(final unit = "N/A2") = 4 * pi * 1.e-7;
  end Constants;

  package Icons  
    extends Icons.Package;

    partial model Example  end Example;

    partial package Package  end Package;

    partial package VariantsPackage  
      extends Modelica.Icons.Package;
    end VariantsPackage;

    partial package InterfacesPackage  
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package TypesPackage  
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package IconsPackage  
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial package InternalPackage  end InternalPackage;

    partial function Function  end Function;

    partial record Record  end Record;

    type TypeReal  
      extends Real;
    end TypeReal;

    type TypeInteger  
      extends Integer;
    end TypeInteger;

    type TypeString  
      extends String;
    end TypeString;
  end Icons;

  package SIunits  
    extends Modelica.Icons.Package;

    package Conversions  
      extends Modelica.Icons.Package;

      package NonSIunits  
        extends Modelica.Icons.Package;
        type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC");
      end NonSIunits;
    end Conversions;

    type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
    type Length = Real(final quantity = "Length", final unit = "m");
    type Position = Length;
    type Distance = Length(min = 0);
    type Radius = Length(min = 0);
    type Diameter = Length(min = 0);
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Force = Real(final quantity = "Force", final unit = "N");
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
end Modelica;

package VehicleInterfaces  
  extends Modelica.Icons.Package;

  package Icons  
    extends Modelica.Icons.Package;

    partial class VariantLibrary  
      extends Modelica.Icons.VariantsPackage;
    end VariantLibrary;
  end Icons;

  package Roads  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial function positionBase  
        extends Modelica.Icons.Function;
        input Real s = 0;
        input Real w = 0;
        output Modelica.SIunits.Position[3] r_0 = zeros(3);
      end positionBase;

      partial function trackOffsetBase  
        extends Modelica.Icons.Function;
        input Real s = 0;
        input Real w = 0;
        output Modelica.SIunits.Position[3] trackOffset = zeros(3);
      end trackOffsetBase;

      partial function normalBase  
        extends Modelica.Icons.Function;
        input Real s = 0;
        input Real w = 0;
        output Real[3] e_n_0 = {0, 0, 1};
      end normalBase;

      partial function headingDirectionBase  
        extends Modelica.Icons.Function;
        input Real s = 0;
        input Real w = 0;
        output Real[3] e_s_0 = {1, 0, 0};
      end headingDirectionBase;

      partial function frictionCoefficientBase  
        extends Modelica.Icons.Function;
        input Real s = 0;
        input Real w = 0;
        output Real mue = 1;
      end frictionCoefficientBase;

      partial model Base  
        replaceable function position = VehicleInterfaces.Roads.Interfaces.positionBase;
        replaceable function trackOffset = VehicleInterfaces.Roads.Interfaces.trackOffsetBase;
        replaceable function normal = VehicleInterfaces.Roads.Interfaces.normalBase;
        replaceable function headingDirection = VehicleInterfaces.Roads.Interfaces.headingDirectionBase;
        replaceable function frictionCoefficient = VehicleInterfaces.Roads.Interfaces.frictionCoefficientBase;
      end Base;
    end Interfaces;

    model CircleRoad  
      extends VehicleInterfaces.Roads.Interfaces.Base(redeclare final function position = circlePosition(radius = radius, width = width), redeclare final function trackOffset = constantOffset, redeclare final function normal = circleNormal, redeclare final function headingDirection = circleHeadingDirection(radius = radius), redeclare final function frictionCoefficient = circleFrictionCoefficient(mue_fixed = mue));
      parameter Boolean animation = true;
      parameter Modelica.SIunits.Radius radius;
      parameter Modelica.SIunits.Length width;
      parameter Real mue;
      parameter Modelica.Mechanics.MultiBody.Types.Color roadColor = {255, 0, 0};
      constant Real pi = Modelica.Constants.pi;
    protected
      outer Modelica.Mechanics.MultiBody.World world;
      VehicleInterfaces.Roads.Internal.VisualizeSimpleRoads roadShape(ns = 100, nw = 10, s_min = 0, s_max = 2 * pi * radius, w_min = -width / 2, w_max = width / 2, color = roadColor) if animation and world.enableAnimation;

      function r_middle  
        extends Modelica.Icons.Function;
        input Real s = 0;
        input Real radius = 1;
        output Real[3] r_0 = {radius * sin(s / radius), -radius * cos(s / radius), 0};
      algorithm
        r_0 := {radius * sin(s / radius), -radius * cos(s / radius), 0};
      end r_middle;

      function circlePosition  
        extends VehicleInterfaces.Roads.Interfaces.positionBase;
        input Modelica.SIunits.Radius radius = 1;
        input Modelica.SIunits.Length width = 1;
      algorithm
        r_0 := r_middle(s, radius) + w * .Modelica.Math.Vectors.normalize(r_middle(s, radius));
      end circlePosition;

      function constantOffset  
        extends VehicleInterfaces.Roads.Interfaces.trackOffsetBase;
      algorithm
        trackOffset := {0, 0, 0};
      end constantOffset;

      function circleNormal  
        extends VehicleInterfaces.Roads.Interfaces.normalBase;
      algorithm
        e_n_0 := {0, 0, 1};
      end circleNormal;

      function circleHeadingDirection  
        extends VehicleInterfaces.Roads.Interfaces.headingDirectionBase;
        input Modelica.SIunits.Radius radius = 1;
      algorithm
        e_s_0 := {cos(s / radius), sin(s / radius), 0};
      end circleHeadingDirection;

      function circleFrictionCoefficient  
        extends VehicleInterfaces.Roads.Interfaces.frictionCoefficientBase;
        input Real mue_fixed = 1;
      algorithm
        mue := mue_fixed;
      end circleFrictionCoefficient;
    end CircleRoad;

    package Internal  
      extends Modelica.Icons.InternalPackage;

      model VisualizeSimpleRoads  
        parameter Integer ns(min = 2) = 2;
        parameter Integer nw(min = 2) = 2;
        extends Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface(final nu = ns, final nv = nw, redeclare final function surfaceCharacteristic = roadSurfaceCharacteristic(final position = road.position, final s_min = s_min, final s_max = s_max, final w_min = w_min, final w_max = w_max));
        parameter Real s_min = 0;
        parameter Real s_max = 1;
        parameter Real w_min = -1;
        parameter Real w_max = 1;
      protected
        outer VehicleInterfaces.Roads.Interfaces.Base road;

        encapsulated function roadSurfaceCharacteristic  
          extends .Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(final multiColoredSurface = false);
          input .VehicleInterfaces.Roads.Interfaces.positionBase position;
          input Real s_min = 0;
          input Real s_max = 1;
          input Real w_min = -1;
          input Real w_max = 1;
        protected
          Real s;
          Real w;
          Real[3] r;
          parameter Real ds = s_max - s_min;
          parameter Real dw = w_max - w_min;
        algorithm
          for j in 1:nv loop
            w := w_min + (j - 1) * dw / (nv - 1);
            for i in 1:nu loop
              s := s_min + (i - 1) * ds / (nu - 1);
              r := position(s, w);
              X[i, j] := r[1];
              Y[i, j] := r[2];
              Z[i, j] := r[3];
            end for;
          end for;
        end roadSurfaceCharacteristic;
      end VisualizeSimpleRoads;

      model DummyTyre  
        parameter .Modelica.SIunits.Radius wheelRadius = 1;
        input Real[3] e_axis;
        input .Modelica.SIunits.Position[3] r_wheel;
        output .Modelica.SIunits.Position[3] r_CP(start = {0, -wheelRadius, 0});
        output .Modelica.SIunits.Length penetrationDepth;
        output Real mue;
        Real s(start = 0);
        Real w(start = 0);
        outer VehicleInterfaces.Roads.Interfaces.Base road;
      protected
        Real[3] e_n;
        Real[3] e_s;
        Real[3] e_w;
        Real[3] e_CP;
        Real[3] d_CP;
        Modelica.SIunits.Radius reducedRadius;
      equation
        r_CP = road.position(s, w);
        e_n = road.normal(s, w);
        e_s = road.headingDirection(s, w);
        e_w = cross(e_n, e_s);
        e_CP = .Modelica.Math.Vectors.normalize(e_n - e_n * e_axis * e_axis);
        d_CP = r_wheel - r_CP;
        reducedRadius = e_n * d_CP / (e_n * e_CP);
        penetrationDepth = wheelRadius - reducedRadius;
        0 = e_s * d_CP - reducedRadius * (e_s * e_CP);
        0 = e_w * d_CP - reducedRadius * (e_w * e_CP);
        mue = road.frictionCoefficient(s, w);
      end DummyTyre;

      model CheckContactCalculation  
        extends Modelica.Icons.Example;
        parameter Real wheelRadius = 1;
        Real phi;
        Real radius_wheel;
        Real[3] axis_wheel;
        Real[3] r_circle = {road.radius * sin(phi), -road.radius * cos(phi), 0};
        VehicleInterfaces.Roads.Internal.DummyTyre tyre(wheelRadius = wheelRadius, e_axis = Modelica.Math.Vectors.normalize(axis_wheel), r_wheel = {radius_wheel * sin(phi), -radius_wheel * cos(phi), 1 + sin(phi) / 20});
        inner VehicleInterfaces.Roads.CircleRoad road(radius = 50, width = 8, mue = 0.5, roadColor = {100, 100, 100});
        inner Modelica.Mechanics.MultiBody.World world(enableAnimation = true, axisLength = 20, n = {0, 0, -1});
      equation
        phi = time;
        radius_wheel = road.radius + road.radius / 20 * sin(20 * phi);
        axis_wheel = {sin(phi), -cos(phi), sin(10 * phi) / 10};
      end CheckContactCalculation;
    end Internal;
  end Roads;
end VehicleInterfaces;

model CheckContactCalculation
  extends VehicleInterfaces.Roads.Internal.CheckContactCalculation;
  annotation(experiment(StopTime = 6.2));
end CheckContactCalculation;
