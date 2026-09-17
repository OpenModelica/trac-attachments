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

  package Blocks  
    extends Modelica.Icons.Package;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real;
      connector RealOutput = output Real;
      connector IntegerInput = input Integer;
      connector IntegerOutput = output Integer;

      partial block SO  
        extends Modelica.Blocks.Icons.Block;
        RealOutput y;
      end SO;

      partial block SignalSource  
        extends SO;
        parameter Real offset = 0;
        parameter .Modelica.SIunits.Time startTime = 0;
      end SignalSource;

      partial block IntegerSO  
        extends Modelica.Blocks.Icons.IntegerBlock;
        IntegerOutput y;
      end IntegerSO;

      partial block IntegerSignalSource  
        extends IntegerSO;
        parameter Integer offset = 0;
        parameter .Modelica.SIunits.Time startTime = 0;
      end IntegerSignalSource;

      partial block IntegerBlockIcon  end IntegerBlockIcon;
    end Interfaces;

    package Math  
      extends Modelica.Icons.Package;

      block Gain  
        parameter Real k(start = 1, unit = "1");
        .Modelica.Blocks.Interfaces.RealInput u;
        .Modelica.Blocks.Interfaces.RealOutput y;
      equation
        y = k * u;
      end Gain;
    end Math;

    package Sources  
      extends Modelica.Icons.SourcesPackage;

      block Constant  
        parameter Real k(start = 1);
        extends .Modelica.Blocks.Interfaces.SO;
      equation
        y = k;
      end Constant;

      block Step  
        parameter Real height = 1;
        extends .Modelica.Blocks.Interfaces.SignalSource;
      equation
        y = offset + (if time < startTime then 0 else height);
      end Step;

      block IntegerConstant  
        parameter Integer k(start = 1);
        extends .Modelica.Blocks.Interfaces.IntegerSO;
      equation
        y = k;
      end IntegerConstant;

      block IntegerStep  
        parameter Integer height = 1;
        extends .Modelica.Blocks.Interfaces.IntegerSignalSource;
      equation
        y = offset + (if time < startTime then 0 else height);
      end IntegerStep;
    end Sources;

    package Icons  
      extends Modelica.Icons.IconsPackage;

      partial block Block  end Block;

      partial block IntegerBlock  end IntegerBlock;
    end Icons;
  end Blocks;

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

        function angularVelocity2  
          extends Modelica.Icons.Function;
          input Orientation R;
          output Modelica.SIunits.AngularVelocity[3] w;
        algorithm
          w := R.w;
        end angularVelocity2;

        function resolve2  
          extends Modelica.Icons.Function;
          input Orientation R;
          input Real[3] v1;
          output Real[3] v2;
        algorithm
          v2 := R.T * v1;
        end resolve2;

        function nullRotation  
          extends Modelica.Icons.Function;
          output Orientation R;
        algorithm
          R := Orientation(T = identity(3), w = zeros(3));
        end nullRotation;

        function absoluteRotation  
          extends Modelica.Icons.Function;
          input Orientation R1;
          input Orientation R_rel;
          output Orientation R2;
        algorithm
          R2 := Orientation(T = R_rel.T * R1.T, w = resolve2(R_rel, R1.w) + R_rel.w);
        end absoluteRotation;

        function planarRotation  
          extends Modelica.Icons.Function;
          input Real[3] e(each final unit = "1");
          input Modelica.SIunits.Angle angle;
          input Modelica.SIunits.AngularVelocity der_angle;
          output Orientation R;
        algorithm
          R := Orientation(T = [e] * transpose([e]) + (identity(3) - [e] * transpose([e])) * .Modelica.Math.cos(angle) - skew(e) * .Modelica.Math.sin(angle), w = e * der_angle);
        end planarRotation;

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

          function resolve2_der  
            extends Modelica.Icons.Function;
            input Orientation R;
            input Real[3] v1;
            input Real[3] v1_der;
            output Real[3] v2_der;
          algorithm
            v2_der := .Modelica.Mechanics.MultiBody.Frames.resolve2(R, v1_der) - cross(R.w, .Modelica.Mechanics.MultiBody.Frames.resolve2(R, v1));
          end resolve2_der;
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

        connector Frame_a  
          extends Frame;
        end Frame_a;

        connector Frame_b  
          extends Frame;
        end Frame_b;

        connector FlangeWithBearing  
          parameter Boolean includeBearingConnector = false;
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange;
          Modelica.Mechanics.MultiBody.Interfaces.Frame bearingFrame if includeBearingConnector;
        end FlangeWithBearing;

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

      package Parts  
        extends Modelica.Icons.Package;

        model Mounting1D  
          parameter Modelica.SIunits.Angle phi0 = 0;
          parameter Modelica.Mechanics.MultiBody.Types.Axis n = {1, 0, 0};
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
          Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D;
        protected
          outer Modelica.Mechanics.MultiBody.World world;

          encapsulated model Housing  
            input .Modelica.SIunits.Torque[3] t;
            .Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a;
          equation
            frame_a.f = zeros(3);
            frame_a.t = t;
          end Housing;

          Housing housing(t = -n * flange_b.tau) if world.driveTrainMechanics3D;
        equation
          flange_b.phi = phi0;
          connect(housing.frame_a, frame_a);
        end Mounting1D;

        model Rotor1D  
          parameter Boolean animation = true;
          parameter .Modelica.SIunits.Inertia J(min = 0, start = 1);
          parameter Modelica.Mechanics.MultiBody.Types.Axis n = {1, 0, 0};
          parameter .Modelica.SIunits.Position[3] r_center = zeros(3);
          parameter .Modelica.SIunits.Distance cylinderLength = 2 * world.defaultJointLength;
          parameter .Modelica.SIunits.Distance cylinderDiameter = 2 * world.defaultJointWidth;
          input Modelica.Mechanics.MultiBody.Types.Color cylinderColor = Modelica.Mechanics.MultiBody.Types.Defaults.RodColor;
          input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient;
          parameter StateSelect stateSelect = StateSelect.default;
          parameter Boolean exact = true;
          .Modelica.SIunits.Angle phi(start = 0, stateSelect = stateSelect);
          .Modelica.SIunits.AngularVelocity w(start = 0, stateSelect = stateSelect);
          .Modelica.SIunits.AngularAcceleration a(start = 0);
          Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a;
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
          Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D;

          encapsulated model RotorWith3DEffects  
            parameter Boolean animation = true;
            parameter .Modelica.SIunits.Inertia J(min = 0) = 1;
            parameter .Modelica.Mechanics.MultiBody.Types.Axis n = {1, 0, 0};
            parameter .Modelica.SIunits.Position[3] r_center = zeros(3);
            parameter .Modelica.SIunits.Distance cylinderLength = 2 * world.defaultJointLength;
            parameter .Modelica.SIunits.Distance cylinderDiameter = 2 * world.defaultJointWidth;
            input .Modelica.Mechanics.MultiBody.Types.Color cylinderColor = .Modelica.Mechanics.MultiBody.Types.Defaults.RodColor;
            input .Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient;
            parameter StateSelect stateSelect = StateSelect.default;
            parameter Boolean exact = true;
            .Modelica.SIunits.AngularVelocity[3] w_a;
            .Modelica.SIunits.Angle phi(start = 0, final stateSelect = stateSelect);
            .Modelica.SIunits.AngularVelocity w(start = 0, stateSelect = stateSelect);
            .Modelica.SIunits.AngularAcceleration a(start = 0);
            .Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a;
            .Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
            .Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a;
          protected
            outer .Modelica.Mechanics.MultiBody.World world;
            parameter Real[3] e(each final unit = "1") = .Modelica.Math.Vectors.normalizeWithAssert(n);
            parameter .Modelica.SIunits.Inertia[3] nJ = J * e;
            .Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(shapeType = "cylinder", color = cylinderColor, specularCoefficient = specularCoefficient, length = cylinderLength, width = cylinderDiameter, height = cylinderDiameter, lengthDirection = n, widthDirection = {0, 1, 0}, extra = 1, r_shape = r_center - e * (cylinderLength / 2), r = frame_a.r_0, R = .Modelica.Mechanics.MultiBody.Frames.absoluteRotation(frame_a.R, .Modelica.Mechanics.MultiBody.Frames.planarRotation(e, phi, 0))) if world.enableAnimation and animation;
          equation
            phi = flange_a.phi;
            phi = flange_b.phi;
            w = der(phi);
            a = der(w);
            w_a = .Modelica.Mechanics.MultiBody.Frames.angularVelocity2(frame_a.R);
            if exact then
              J * a = flange_a.tau + flange_b.tau - nJ * der(w_a);
            else
              J * a = flange_a.tau + flange_b.tau;
            end if;
            frame_a.f = zeros(3);
            frame_a.t = cross(w_a, nJ * w) - e * (nJ * der(w_a));
          end RotorWith3DEffects;

        protected
          outer Modelica.Mechanics.MultiBody.World world;
          parameter Real[3] e(each final unit = "1") = Modelica.Math.Vectors.normalizeWithAssert(n);
          Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(shapeType = "cylinder", color = cylinderColor, specularCoefficient = specularCoefficient, length = cylinderLength, width = cylinderDiameter, height = cylinderDiameter, lengthDirection = n, widthDirection = {0, 1, 0}, extra = 1, r_shape = r_center - e * (cylinderLength / 2), r = zeros(3), R = Modelica.Mechanics.MultiBody.Frames.planarRotation(e, phi, 0)) if world.enableAnimation and animation and not world.driveTrainMechanics3D;
          Modelica.Mechanics.Rotational.Components.Inertia inertia(J = J, stateSelect = StateSelect.never) if not world.driveTrainMechanics3D;
          RotorWith3DEffects rotorWith3DEffects(animation = animation, J = J, n = n, r_center = r_center, cylinderLength = cylinderLength, cylinderDiameter = cylinderDiameter, cylinderColor = cylinderColor, specularCoefficient = specularCoefficient, exact = exact, stateSelect = StateSelect.never) if world.driveTrainMechanics3D;
        equation
          phi = flange_a.phi;
          w = der(phi);
          a = der(w);
          connect(inertia.flange_a, flange_a);
          connect(inertia.flange_b, flange_b);
          connect(rotorWith3DEffects.flange_b, flange_b);
          connect(rotorWith3DEffects.flange_a, flange_a);
          connect(rotorWith3DEffects.frame_a, frame_a);
        end Rotor1D;
      end Parts;

      package Sensors  
        extends Modelica.Icons.SensorsPackage;

        package Internal  
          extends Modelica.Icons.InternalPackage;

          model ZeroForceAndTorque  
            extends Modelica.Blocks.Icons.Block;
            Interfaces.Frame_a frame_a;
          equation
            frame_a.f = zeros(3);
            frame_a.t = zeros(3);
          end ZeroForceAndTorque;
        end Internal;
      end Sensors;

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
          constant Types.Color RodColor = {155, 155, 155};
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

    package Rotational  
      extends Modelica.Icons.Package;

      package Components  
        extends Modelica.Icons.Package;

        model Fixed  
          parameter .Modelica.SIunits.Angle phi0 = 0;
          Interfaces.Flange_b flange;
        equation
          flange.phi = phi0;
        end Fixed;

        model Inertia  
          Rotational.Interfaces.Flange_a flange_a;
          Rotational.Interfaces.Flange_b flange_b;
          parameter .Modelica.SIunits.Inertia J(min = 0, start = 1);
          parameter StateSelect stateSelect = StateSelect.default annotation(HideResult = true);
          .Modelica.SIunits.Angle phi(stateSelect = stateSelect);
          .Modelica.SIunits.AngularVelocity w(stateSelect = stateSelect);
          .Modelica.SIunits.AngularAcceleration a;
        equation
          phi = flange_a.phi;
          phi = flange_b.phi;
          w = der(phi);
          a = der(w);
          J * a = flange_a.tau + flange_b.tau;
        end Inertia;

        model Brake  
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
          parameter Real[:, 2] mue_pos = [0, 0.5];
          parameter Real peak(final min = 1) = 1;
          parameter Real cgeo(final min = 0) = 1;
          parameter .Modelica.SIunits.Force fn_max(final min = 0, start = 1);
          extends Rotational.Interfaces.PartialFriction;
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
          .Modelica.SIunits.Angle phi;
          .Modelica.SIunits.Torque tau;
          .Modelica.SIunits.AngularVelocity w;
          .Modelica.SIunits.AngularAcceleration a;
          Real mue0;
          .Modelica.SIunits.Force fn;
          Modelica.Blocks.Interfaces.RealInput f_normalized;
        equation
          mue0 = Modelica.Math.tempInterpol1(0, mue_pos, 2);
          phi = flange_a.phi - phi_support;
          flange_b.phi = flange_a.phi;
          w = der(phi);
          a = der(w);
          w_relfric = w;
          a_relfric = a;
          flange_a.tau + flange_b.tau - tau = 0;
          fn = fn_max * f_normalized;
          tau0 = mue0 * cgeo * fn;
          tau0_max = peak * tau0;
          free = fn <= 0;
          tau = if locked then sa * unitTorque else if free then 0 else cgeo * fn * (if startForward then Modelica.Math.tempInterpol1(w, mue_pos, 2) else if startBackward then -Modelica.Math.tempInterpol1(-w, mue_pos, 2) else if pre(mode) == Forward then Modelica.Math.tempInterpol1(w, mue_pos, 2) else -Modelica.Math.tempInterpol1(-w, mue_pos, 2));
          lossPower = tau * w_relfric;
        end Brake;

        model IdealGear  
          extends Modelica.Mechanics.Rotational.Icons.Gear;
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
          parameter Real ratio(start = 1);
          Modelica.SIunits.Angle phi_a;
          Modelica.SIunits.Angle phi_b;
        equation
          phi_a = flange_a.phi - phi_support;
          phi_b = flange_b.phi - phi_support;
          phi_a = ratio * phi_b;
          0 = ratio * flange_a.tau + flange_b.tau;
        end IdealGear;

        model IdealPlanetary  
          parameter Real ratio(start = 100 / 50);
          Interfaces.Flange_a sun;
          Interfaces.Flange_a carrier;
          Interfaces.Flange_b ring;
        equation
          (1 + ratio) * carrier.phi = sun.phi + ratio * ring.phi;
          ring.tau = ratio * sun.tau;
          carrier.tau = -(1 + ratio) * sun.tau;
        end IdealPlanetary;

        model IdealRollingWheel  
          extends Rotational.Interfaces.PartialElementaryRotationalToTranslational;
          parameter Modelica.SIunits.Distance radius(start = 0.3);
        equation
          (flangeR.phi - internalSupportR.phi) * radius = flangeT.s - internalSupportT.s;
          0 = radius * flangeT.f + flangeR.tau;
        end IdealRollingWheel;
      end Components;

      package Sensors  
        extends Modelica.Icons.SensorsPackage;

        model SpeedSensor  
          extends Rotational.Interfaces.PartialAbsoluteSensor;
          Modelica.Blocks.Interfaces.RealOutput w(unit = "rad/s");
        equation
          w = der(flange.phi);
        end SpeedSensor;

        model TorqueSensor  
          extends Rotational.Interfaces.PartialRelativeSensor;
          Modelica.Blocks.Interfaces.RealOutput tau(unit = "N.m");
        equation
          flange_a.phi = flange_b.phi;
          flange_a.tau = tau;
        end TorqueSensor;

        model PowerSensor  
          extends Rotational.Interfaces.PartialRelativeSensor;
          Modelica.Blocks.Interfaces.RealOutput power(unit = "W");
        equation
          flange_a.phi = flange_b.phi;
          power = flange_a.tau * der(flange_a.phi);
        end PowerSensor;
      end Sensors;

      package Sources  
        extends Modelica.Icons.SourcesPackage;

        model Torque  
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
          Modelica.Blocks.Interfaces.RealInput tau(unit = "N.m");
        equation
          flange.tau = -tau;
        end Torque;

        model ConstantTorque  
          extends Rotational.Interfaces.PartialTorque;
          parameter Modelica.SIunits.Torque tau_constant;
          Modelica.SIunits.Torque tau;
        equation
          tau = -flange.tau;
          tau = tau_constant;
        end ConstantTorque;
      end Sources;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

        connector Flange_a  
          .Modelica.SIunits.Angle phi;
          flow .Modelica.SIunits.Torque tau;
        end Flange_a;

        connector Flange_b  
          .Modelica.SIunits.Angle phi;
          flow .Modelica.SIunits.Torque tau;
        end Flange_b;

        connector Support  
          .Modelica.SIunits.Angle phi;
          flow .Modelica.SIunits.Torque tau;
        end Support;

        model InternalSupport  
          input Modelica.SIunits.Torque tau;
          Modelica.SIunits.Angle phi;
          Flange_a flange;
        equation
          flange.tau = tau;
          flange.phi = phi;
        end InternalSupport;

        partial model PartialElementaryOneFlangeAndSupport2  
          parameter Boolean useSupport = false annotation(Evaluate = true, HideResult = true);
          Flange_b flange;
          Support support(phi = phi_support, tau = -flange.tau) if useSupport;
        protected
          Modelica.SIunits.Angle phi_support;
        equation
          if not useSupport then
            phi_support = 0;
          end if;
        end PartialElementaryOneFlangeAndSupport2;

        partial model PartialElementaryTwoFlangesAndSupport2  
          parameter Boolean useSupport = false annotation(Evaluate = true, HideResult = true);
          Flange_a flange_a;
          Flange_b flange_b;
          Support support(phi = phi_support, tau = (-flange_a.tau) - flange_b.tau) if useSupport;
        protected
          Modelica.SIunits.Angle phi_support;
        equation
          if not useSupport then
            phi_support = 0;
          end if;
        end PartialElementaryTwoFlangesAndSupport2;

        partial model PartialElementaryRotationalToTranslational  
          parameter Boolean useSupportR = false annotation(Evaluate = true, HideResult = true);
          parameter Boolean useSupportT = false annotation(Evaluate = true, HideResult = true);
          Rotational.Interfaces.Flange_a flangeR;
          Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT;
          Rotational.Interfaces.Support supportR if useSupportR;
          Translational.Interfaces.Support supportT if useSupportT;
        protected
          Rotational.Interfaces.InternalSupport internalSupportR(tau = -flangeR.tau);
          Translational.Interfaces.InternalSupport internalSupportT(f = -flangeT.f);
          Rotational.Components.Fixed fixedR if not useSupportR;
          Translational.Components.Fixed fixedT if not useSupportT;
        equation
          connect(internalSupportR.flange, supportR);
          connect(internalSupportR.flange, fixedR.flange);
          connect(fixedT.flange, internalSupportT.flange);
          connect(internalSupportT.flange, supportT);
        end PartialElementaryRotationalToTranslational;

        partial model PartialTorque  
          extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
          Modelica.SIunits.Angle phi;
        equation
          phi = flange.phi - phi_support;
        end PartialTorque;

        partial model PartialAbsoluteSensor  
          extends Modelica.Icons.RotationalSensor;
          Flange_a flange;
        equation
          0 = flange.tau;
        end PartialAbsoluteSensor;

        partial model PartialRelativeSensor  
          extends Modelica.Icons.RotationalSensor;
          Flange_a flange_a;
          Flange_b flange_b;
        equation
          0 = flange_a.tau + flange_b.tau;
        end PartialRelativeSensor;

        partial model PartialFriction  
          parameter .Modelica.SIunits.AngularVelocity w_small = 1.0e10;
          .Modelica.SIunits.AngularVelocity w_relfric;
          .Modelica.SIunits.AngularAcceleration a_relfric;
          .Modelica.SIunits.Torque tau0;
          .Modelica.SIunits.Torque tau0_max;
          Boolean free;
          Real sa(final unit = "1");
          Boolean startForward(start = false, fixed = true);
          Boolean startBackward(start = false, fixed = true);
          Boolean locked(start = false);
          constant Integer Unknown = 3;
          constant Integer Free = 2;
          constant Integer Forward = 1;
          constant Integer Stuck = 0;
          constant Integer Backward = -1;
          Integer mode(final min = Backward, final max = Unknown, start = Unknown, fixed = true);
        protected
          constant .Modelica.SIunits.AngularAcceleration unitAngularAcceleration = 1 annotation(HideResult = true);
          constant .Modelica.SIunits.Torque unitTorque = 1 annotation(HideResult = true);
        equation
          startForward = pre(mode) == Stuck and (sa > tau0_max / unitTorque or pre(startForward) and sa > tau0 / unitTorque) or pre(mode) == Backward and w_relfric > w_small or initial() and w_relfric > 0;
          startBackward = pre(mode) == Stuck and (sa < (-tau0_max / unitTorque) or pre(startBackward) and sa < (-tau0 / unitTorque)) or pre(mode) == Forward and w_relfric < (-w_small) or initial() and w_relfric < 0;
          locked = not free and not (pre(mode) == Forward or startForward or pre(mode) == Backward or startBackward);
          a_relfric / unitAngularAcceleration = if locked then 0 else if free then sa else if startForward then sa - tau0_max / unitTorque else if startBackward then sa + tau0_max / unitTorque else if pre(mode) == Forward then sa - tau0_max / unitTorque else sa + tau0_max / unitTorque;
          mode = if free then Free else if (pre(mode) == Forward or pre(mode) == Free or startForward) and w_relfric > 0 then Forward else if (pre(mode) == Backward or pre(mode) == Free or startBackward) and w_relfric < 0 then Backward else Stuck;
        end PartialFriction;
      end Interfaces;

      package Icons  
        extends Modelica.Icons.IconsPackage;

        partial class Gear  end Gear;
      end Icons;
    end Rotational;

    package Translational  
      extends Modelica.Icons.Package;

      package Components  
        extends Modelica.Icons.Package;

        model Fixed  
          parameter .Modelica.SIunits.Position s0 = 0;
          Interfaces.Flange_b flange;
        equation
          flange.s = s0;
        end Fixed;

        model Mass  
          parameter .Modelica.SIunits.Mass m(min = 0, start = 1);
          parameter StateSelect stateSelect = StateSelect.default;
          extends Translational.Interfaces.PartialRigid(L = 0, s(start = 0, stateSelect = stateSelect));
          .Modelica.SIunits.Velocity v(start = 0, stateSelect = stateSelect);
          .Modelica.SIunits.Acceleration a(start = 0);
        equation
          v = der(s);
          a = der(v);
          m * a = flange_a.f + flange_b.f;
        end Mass;

        model Damper  
          extends Translational.Interfaces.PartialCompliantWithRelativeStates;
          parameter .Modelica.SIunits.TranslationalDampingConstant d(final min = 0, start = 0);
          extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
        equation
          f = d * v_rel;
          lossPower = f * v_rel;
        end Damper;
      end Components;

      package Sensors  
        extends Modelica.Icons.SensorsPackage;

        model SpeedSensor  
          extends Translational.Interfaces.PartialAbsoluteSensor;
          Modelica.Blocks.Interfaces.RealOutput v(unit = "m/s");
        equation
          v = der(flange.s);
        end SpeedSensor;
      end Sensors;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

        connector Flange_a  
          .Modelica.SIunits.Position s;
          flow .Modelica.SIunits.Force f;
        end Flange_a;

        connector Flange_b  
          .Modelica.SIunits.Position s;
          flow .Modelica.SIunits.Force f;
        end Flange_b;

        connector Support  
          .Modelica.SIunits.Position s;
          flow .Modelica.SIunits.Force f;
        end Support;

        model InternalSupport  
          input .Modelica.SIunits.Force f;
          .Modelica.SIunits.Position s;
          Flange_a flange;
        equation
          flange.f = f;
          flange.s = s;
        end InternalSupport;

        partial model PartialRigid  
          .Modelica.SIunits.Position s;
          parameter .Modelica.SIunits.Length L(start = 0);
          Flange_a flange_a;
          Flange_b flange_b;
        equation
          flange_a.s = s - L / 2;
          flange_b.s = s + L / 2;
        end PartialRigid;

        partial model PartialCompliantWithRelativeStates  
          parameter StateSelect stateSelect = StateSelect.prefer annotation(HideResult = true);
          parameter .Modelica.SIunits.Distance s_nominal = 1e-4;
          .Modelica.SIunits.Position s_rel(start = 0, stateSelect = stateSelect, nominal = s_nominal);
          .Modelica.SIunits.Velocity v_rel(start = 0, stateSelect = stateSelect);
          .Modelica.SIunits.Force f;
          Translational.Interfaces.Flange_a flange_a;
          Translational.Interfaces.Flange_b flange_b;
        equation
          s_rel = flange_b.s - flange_a.s;
          v_rel = der(s_rel);
          flange_b.f = f;
          flange_a.f = -f;
        end PartialCompliantWithRelativeStates;

        partial model PartialAbsoluteSensor  
          extends Modelica.Icons.TranslationalSensor;
          Interfaces.Flange_a flange;
        equation
          0 = flange.f;
        end PartialAbsoluteSensor;
      end Interfaces;
    end Translational;
  end Mechanics;

  package Thermal  
    extends Modelica.Icons.Package;

    package HeatTransfer  
      extends Modelica.Icons.Package;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort  
          Modelica.SIunits.Temperature T;
          flow Modelica.SIunits.HeatFlowRate Q_flow;
        end HeatPort;

        connector HeatPort_a  
          extends HeatPort;
        end HeatPort_a;

        partial model PartialElementaryConditionalHeatPortWithoutT  
          parameter Boolean useHeatPort = false annotation(Evaluate = true, HideResult = true);
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final Q_flow = -lossPower) if useHeatPort;
          Modelica.SIunits.Power lossPower;
        end PartialElementaryConditionalHeatPortWithoutT;
      end Interfaces;
    end HeatTransfer;
  end Thermal;

  package Math  
    extends Modelica.Icons.Package;

    package Icons  
      extends Modelica.Icons.IconsPackage;

      partial function AxisLeft  end AxisLeft;

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

      function normalizeWithAssert  
        extends Modelica.Icons.Function;
        input Real[:] v;
        output Real[size(v, 1)] result;
      algorithm
        assert(.Modelica.Math.Vectors.length(v) > 0.0, "Vector v={0,0,0} shall be normalized (= v/sqrt(v*v)), but this results in a division by zero.\nProvide a non-zero vector!");
        result := v / .Modelica.Math.Vectors.length(v);
      end normalizeWithAssert;
    end Vectors;

    function sin  
      extends Modelica.Math.Icons.AxisLeft;
      input Modelica.SIunits.Angle u;
      output Real y;
      external "builtin" y = sin(u);
    end sin;

    function cos  
      extends Modelica.Math.Icons.AxisLeft;
      input .Modelica.SIunits.Angle u;
      output Real y;
      external "builtin" y = cos(u);
    end cos;

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

    function tempInterpol1  
      extends Modelica.Icons.Function;
      extends Modelica.Icons.ObsoleteModel;
      input Real u;
      input Real[:, :] table;
      input Integer icol;
      output Real y;
    protected
      Integer i;
      Integer n;
      Real u1;
      Real u2;
      Real y1;
      Real y2;
    algorithm
      n := size(table, 1);
      if n <= 1 then
        y := table[1, icol];
      else
        if u <= table[1, 1] then
          i := 1;
        else
          i := 2;
          while i < n and u >= table[i, 1] loop
            i := i + 1;
          end while;
          i := i - 1;
        end if;
        u1 := table[i, 1];
        u2 := table[i + 1, 1];
        y1 := table[i, icol];
        y2 := table[i + 1, icol];
        assert(u2 > u1, "Table index must be increasing");
        y := y1 + (y2 - y1) * (u - u1) / (u2 - u1);
      end if;
    end tempInterpol1;

    function tempInterpol1_der  
      input Real u;
      input Real[:, :] table;
      input Integer icol;
      input Real du;
      output Real dy;
    protected
      Integer i;
      Integer n;
      Real u1;
      Real u2;
      Real y1;
      Real y2;
    algorithm
      n := size(table, 1);
      if n <= 1 then
        dy := 0;
      else
        if u <= table[1, 1] then
          i := 1;
        else
          i := 2;
          while i < n and u >= table[i, 1] loop
            i := i + 1;
          end while;
          i := i - 1;
        end if;
        u1 := table[i, 1];
        u2 := table[i + 1, 1];
        y1 := table[i, icol];
        y2 := table[i + 1, icol];
        assert(u2 > u1, "Table index must be increasing");
        dy := (y2 - y1) / (u2 - u1);
      end if;
    end tempInterpol1_der;
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

    partial package ExamplesPackage  
      extends Modelica.Icons.Package;
    end ExamplesPackage;

    partial model Example  end Example;

    partial package Package  end Package;

    partial package VariantsPackage  
      extends Modelica.Icons.Package;
    end VariantsPackage;

    partial package InterfacesPackage  
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package SensorsPackage  
      extends Modelica.Icons.Package;
    end SensorsPackage;

    partial package TypesPackage  
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package IconsPackage  
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial package InternalPackage  end InternalPackage;

    partial class RotationalSensor  end RotationalSensor;

    partial class TranslationalSensor  end TranslationalSensor;

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

    expandable connector SignalBus  end SignalBus;

    expandable connector SignalSubBus  end SignalSubBus;

    partial class ObsoleteModel  end ObsoleteModel;
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
    type Time = Real(final quantity = "Time", final unit = "s");
    type AngularVelocity = Real(final quantity = "AngularVelocity", final unit = "rad/s");
    type AngularAcceleration = Real(final quantity = "AngularAcceleration", final unit = "rad/s2");
    type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
    type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
    type Frequency = Real(final quantity = "Frequency", final unit = "Hz");
    type Mass = Real(quantity = "Mass", final unit = "kg", min = 0);
    type Density = Real(final quantity = "Density", final unit = "kg/m3", displayUnit = "g/cm3", min = 0.0);
    type MomentOfInertia = Real(final quantity = "MomentOfInertia", final unit = "kg.m2");
    type Inertia = MomentOfInertia;
    type Force = Real(final quantity = "Force", final unit = "N");
    type TranslationalDampingConstant = Real(final quantity = "TranslationalDampingConstant", final unit = "N.s/m");
    type Torque = Real(final quantity = "Torque", final unit = "N.m");
    type Pressure = Real(final quantity = "Pressure", final unit = "Pa", displayUnit = "bar");
    type AbsolutePressure = Pressure(min = 0.0, nominal = 1e5);
    type Power = Real(final quantity = "Power", final unit = "W");
    type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC");
    type Temperature = ThermodynamicTemperature;
    type HeatFlowRate = Real(final quantity = "Power", final unit = "W");
    type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
  end SIunits;
end Modelica;

package VehicleInterfaces  
  extends Modelica.Icons.Package;

  package Examples  
    extends Modelica.Icons.ExamplesPackage;

    model ConventionalAutomaticVehicleExternalDriver  
      extends Modelica.Icons.Example;
      replaceable Engines.MinimalEngine engine constrainedby VehicleInterfaces.Engines.Interfaces.Base;
      replaceable Transmissions.SingleGearAutomaticTransmission transmission constrainedby VehicleInterfaces.Transmissions.Interfaces.BaseAutomaticTransmission;
      replaceable Chassis.MinimalChassis chassis constrainedby VehicleInterfaces.Chassis.Interfaces.TwoAxleBase;
      replaceable Drivelines.MinimalDriveline driveline constrainedby VehicleInterfaces.Drivelines.Interfaces.TwoAxleBase;
      replaceable Brakes.MinimalBrakes brakes constrainedby VehicleInterfaces.Brakes.Interfaces.TwoAxleBase;
      replaceable Accessories.MinimalAccessories accessories constrainedby VehicleInterfaces.Accessories.Interfaces.Base;
      replaceable VehicleInterfaces.DriverEnvironments.DriveByWireAutomaticExternalDriver driverEnvironment constrainedby VehicleInterfaces.DriverEnvironments.Interfaces.BaseAutomaticTransmissionExternalDriver;
      inner replaceable Roads.FlatRoad road constrainedby VehicleInterfaces.Roads.Interfaces.Base;
      inner replaceable Atmospheres.ConstantAtmosphere atmosphere constrainedby VehicleInterfaces.Atmospheres.Interfaces.Base;
      inner replaceable Modelica.Mechanics.MultiBody.World world(enableAnimation = false, n = {0, 0, -1}, driveTrainMechanics3D = false) constrainedby Modelica.Mechanics.MultiBody.World;
    protected
      Interfaces.ControlBus controlBus;
    public
      replaceable Drivers.MinimalDriver driver constrainedby Drivers.Interfaces.Base;
    equation
      connect(accessories.engineFlange, engine.accessoryFlange);
      connect(engine.transmissionFlange, transmission.engineFlange);
      connect(transmission.drivelineFlange, driveline.transmissionFlange);
      connect(chassis.wheelHub_2, driveline.wheelHub_2);
      connect(driveline.wheelHub_4, chassis.wheelHub_4);
      connect(chassis.wheelHub_4, brakes.wheelHub_4);
      connect(brakes.wheelHub_2, chassis.wheelHub_2);
      connect(driveline.wheelHub_3, chassis.wheelHub_3);
      connect(chassis.wheelHub_1, driveline.wheelHub_1);
      connect(chassis.wheelHub_3, brakes.wheelHub_3);
      connect(chassis.wheelHub_1, brakes.wheelHub_1);
      connect(controlBus, engine.controlBus);
      connect(controlBus, transmission.controlBus);
      connect(controlBus, driveline.controlBus);
      connect(controlBus, chassis.controlBus);
      connect(controlBus, brakes.controlBus);
      connect(accessories.controlBus, controlBus);
      connect(controlBus, driverEnvironment.controlBus);
      connect(driveline.drivelineMount, chassis.chassisFrame);
      connect(transmission.transmissionMount, chassis.chassisFrame);
      connect(engine.engineMount, chassis.chassisFrame);
      connect(driverEnvironment.acceleratorPedal, engine.acceleratorPedal);
      connect(driverEnvironment.brakePedal, brakes.brakePedal);
      connect(driverEnvironment.steeringWheel, chassis.steeringWheel);
      connect(driverEnvironment.chassisFrame, chassis.chassisFrame);
      connect(driverEnvironment.driverInterface, driver.driverInterface);
    end ConventionalAutomaticVehicleExternalDriver;
  end Examples;

  package Blocks  
    extends Modelica.Icons.Package;

    model IntegerPassThrough  
      extends Modelica.Blocks.Interfaces.IntegerBlockIcon;
      Modelica.Blocks.Interfaces.IntegerInput u;
      Modelica.Blocks.Interfaces.IntegerOutput y;
    equation
      y = u;
    end IntegerPassThrough;
  end Blocks;

  package Icons  
    extends Modelica.Icons.Package;

    partial class VariantLibrary  
      extends Modelica.Icons.VariantsPackage;
    end VariantLibrary;

    partial model Accessories  end Accessories;

    partial model Atmosphere  end Atmosphere;

    partial model Brakes  end Brakes;

    partial model Chassis  end Chassis;

    partial model Driveline  end Driveline;

    partial model DriverEnvironment  end DriverEnvironment;

    partial model Driver  end Driver;

    partial model Engine  end Engine;

    partial model Road  end Road;

    expandable connector SignalSubBusWithExplicitSignals  end SignalSubBusWithExplicitSignals;

    partial model Transmission  end Transmission;
  end Icons;

  package Interfaces  
    extends Modelica.Icons.InterfacesPackage;

    expandable connector ControlBus  
      extends Modelica.Icons.SignalBus;
      VehicleInterfaces.Interfaces.AccessoriesBus accessoriesBus;
      VehicleInterfaces.Interfaces.AccessoriesControlBus accessoriesControlBus;
      VehicleInterfaces.Interfaces.BatteryBus batteryBus;
      VehicleInterfaces.Interfaces.BrakesBus brakesBus;
      VehicleInterfaces.Interfaces.BrakesControlBus brakesControlBus;
      VehicleInterfaces.Interfaces.ChassisBus chassisBus;
      VehicleInterfaces.Interfaces.ChassisControlBus chassisControlBus;
      VehicleInterfaces.Interfaces.DrivelineBus drivelineBus;
      VehicleInterfaces.Interfaces.DrivelineControlBus drivelineControlBus;
      VehicleInterfaces.Interfaces.DriverBus driverBus;
      VehicleInterfaces.Interfaces.ElectricMotorBus electricMotorBus;
      VehicleInterfaces.Interfaces.ElectricMotorControlBus electricMotorControlBus;
      VehicleInterfaces.Interfaces.EngineBus engineBus;
      VehicleInterfaces.Interfaces.EngineControlBus engineControlBus;
      VehicleInterfaces.Interfaces.TransmissionBus transmissionBus;
      VehicleInterfaces.Interfaces.TransmissionControlBus transmissionControlBus;
    end ControlBus;

    expandable connector AccessoriesBus  
      extends Modelica.Icons.SignalSubBus;
    end AccessoriesBus;

    expandable connector AccessoriesControlBus  
      extends Modelica.Icons.SignalSubBus;
    end AccessoriesControlBus;

    expandable connector BatteryBus  
      extends Modelica.Icons.SignalSubBus;
    end BatteryBus;

    expandable connector BrakesBus  
      extends Modelica.Icons.SignalSubBus;
    end BrakesBus;

    expandable connector BrakesControlBus  
      extends Modelica.Icons.SignalSubBus;
    end BrakesControlBus;

    expandable connector ChassisBus  
      extends Modelica.Icons.SignalSubBus;
    end ChassisBus;

    expandable connector ChassisControlBus  
      extends Modelica.Icons.SignalSubBus;
    end ChassisControlBus;

    expandable connector DrivelineBus  
      extends Modelica.Icons.SignalSubBus;
    end DrivelineBus;

    expandable connector DrivelineControlBus  
      extends Modelica.Icons.SignalSubBus;
    end DrivelineControlBus;

    expandable connector DriverBus  
      extends Modelica.Icons.SignalSubBus;
    end DriverBus;

    expandable connector DriverInterface  end DriverInterface;

    expandable connector ElectricMotorBus  
      extends Modelica.Icons.SignalSubBus;
    end ElectricMotorBus;

    expandable connector ElectricMotorControlBus  
      extends Modelica.Icons.SignalSubBus;
    end ElectricMotorControlBus;

    expandable connector EngineBus  
      extends Modelica.Icons.SignalSubBus;
    end EngineBus;

    expandable connector EngineControlBus  
      extends Modelica.Icons.SignalSubBus;
    end EngineControlBus;

    expandable connector TransmissionBus  
      extends Modelica.Icons.SignalSubBus;
    end TransmissionBus;

    expandable connector TransmissionControlBus  
      extends Modelica.Icons.SignalSubBus;
      Integer currentGear;
    end TransmissionControlBus;
  end Interfaces;

  package Mechanics  
    extends Modelica.Icons.Package;

    package NormalisedTranslational  
      extends Modelica.Icons.Package;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

        connector Flange  
          Types.NormalizedReal s;
          flow Modelica.SIunits.Force f;
        end Flange;
      end Interfaces;

      model Position  
        parameter Boolean exact = true;
        parameter .Modelica.SIunits.Frequency f_crit = 50;
        Interfaces.Flange flange_b;
        Modelica.Blocks.Interfaces.RealInput position;
        Types.NormalizedReal s;
      protected
        parameter Real w_crit = 2 * Modelica.Constants.pi * f_crit;
        constant Real af = 1.3617;
        constant Real bf = 0.6180;
        Real v;
        Real a;
      initial equation
        if not exact then
          s = position;
        end if;
      equation
        s = flange_b.s;
        if exact then
          s = position;
          v = 0;
          a = 0;
        else
          v = der(s);
          a = der(v);
          a = ((position - s) * w_crit - af * v) * (w_crit / bf);
        end if;
      end Position;

      model PositionSensor  
        extends Modelica.Icons.TranslationalSensor;
        Interfaces.Flange flange_a;
        Modelica.Blocks.Interfaces.RealOutput position;
      equation
        position = flange_a.s;
        0 = flange_a.f;
      end PositionSensor;
    end NormalisedTranslational;

    package NormalisedRotational  
      extends Modelica.Icons.Package;

      package Interfaces  
        extends Modelica.Icons.InterfacesPackage;

        connector Flange  
          Types.NormalizedReal phi;
          flow Modelica.SIunits.Torque tau;
        end Flange;
      end Interfaces;

      model Position  
        parameter Boolean exact = true;
        parameter .Modelica.SIunits.Frequency f_crit = 50;
        Interfaces.Flange flange_b;
        Modelica.Blocks.Interfaces.RealInput phi_ref;
        Types.NormalizedReal phi;
      protected
        parameter Real w_crit = 2 * Modelica.Constants.pi * f_crit;
        constant Real af = 1.3617;
        constant Real bf = 0.6180;
        Real w;
        Real a;
      initial equation
        if not exact then
          phi = phi_ref;
        end if;
      equation
        phi = flange_b.phi;
        w = der(phi);
        a = der(w);
        if exact then
          phi = phi_ref;
        else
          a = ((phi_ref - phi) * w_crit - af * w) * (w_crit / bf);
        end if;
      end Position;
    end NormalisedRotational;

    package MultiBody  
      extends Modelica.Icons.Package;

      model MultiBodyEnd  
        parameter Boolean includeBearingConnector = false;
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing flange(includeBearingConnector = includeBearingConnector);
      protected
        Modelica.Mechanics.MultiBody.Sensors.Internal.ZeroForceAndTorque zeroForceAndTorque if includeBearingConnector;
      public
        Modelica.Mechanics.Rotational.Sources.ConstantTorque zeroTorque1D(final tau_constant = 0);
      equation
        connect(zeroTorque1D.flange, flange.flange);
        connect(zeroForceAndTorque.frame_a, flange.bearingFrame);
      end MultiBodyEnd;
    end MultiBody;
  end Mechanics;

  package Types  
    extends Modelica.Icons.Package;
    type NormalizedReal = Modelica.Icons.TypeReal(final quantity = "", final unit = "1", final displayUnit = "1", final min = 0, final max = 1);
    type Gear = Modelica.Icons.TypeInteger(final quantity = "gear");

    package GearMode  
      constant Integer Drive = 2;

      type Temp  
        extends Integer(min = 1, max = 6);
      end Temp;
    end GearMode;

    package IgnitionSetting  
      constant Integer Start = 3;

      type Temp  
        extends Integer(min = 1, max = 3);
      end Temp;
    end IgnitionSetting;
  end Types;

  package Accessories  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing engineFlange(final includeBearingConnector = includeAccessoriesBearing or usingMultiBodyEngine);
        Mechanics.MultiBody.MultiBodyEnd end_2(final includeBearingConnector = includeAccessoriesBearing or usingMultiBodyEngine);
        VehicleInterfaces.Interfaces.ControlBus controlBus;
        parameter Boolean usingMultiBodyEngine = false;
      protected
        parameter Boolean includeAccessoriesBearing = false;
      equation
        connect(end_2.flange, engineFlange);
      end Base;
    end Interfaces;

    model MinimalAccessories  
      extends VehicleInterfaces.Icons.Accessories;
      extends Interfaces.Base(includeAccessoriesBearing = world.driveTrainMechanics3D);
      parameter Modelica.SIunits.Inertia accessoriesInertia = 0.001;
      parameter Modelica.SIunits.Torque accessoriesLoad = 2;
      parameter Modelica.Mechanics.MultiBody.Types.Axis axisOfRotation = {1, 0, 0};
      Modelica.Mechanics.MultiBody.Parts.Rotor1D inertia(J = accessoriesInertia, n = axisOfRotation);
      Modelica.Mechanics.Rotational.Sources.ConstantTorque torqueLoss(tau_constant = accessoriesLoad, useSupport = includeAccessoriesBearing);
      Modelica.Mechanics.MultiBody.Parts.Mounting1D torqueReaction(n = axisOfRotation) if includeAccessoriesBearing;
    protected
      outer Modelica.Mechanics.MultiBody.World world;
    equation
      connect(torqueLoss.flange, inertia.flange_a);
      connect(inertia.flange_b, engineFlange.flange);
      connect(torqueReaction.frame_a, engineFlange.bearingFrame);
      connect(torqueReaction.flange_b, torqueLoss.support);
      connect(inertia.frame_a, torqueReaction.frame_a);
    end MinimalAccessories;
  end Accessories;

  package Atmospheres  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.Package;

      partial function windVelocityBase  
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Position[3] r = zeros(3);
        output Modelica.SIunits.Velocity[3] v = zeros(3);
      end windVelocityBase;

      partial function densityBase  
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Position[3] r = zeros(3);
        output Modelica.SIunits.Density rho = 1.18;
      end densityBase;

      partial function temperatureBase  
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Position[3] r = zeros(3);
        output Modelica.SIunits.Temperature T = 298;
      end temperatureBase;

      partial function humidityBase  
        extends Modelica.Icons.Function;
        input Modelica.SIunits.Position[3] r = zeros(3);
        output Real h = 0.5;
      end humidityBase;

      partial model Base  
        replaceable function windVelocity = windVelocityBase;
        replaceable function density = densityBase;
        replaceable function temperature = temperatureBase;
        replaceable function humidity = humidityBase;
      end Base;
    end Interfaces;

    model ConstantAtmosphere  
      extends VehicleInterfaces.Icons.Atmosphere;
      extends VehicleInterfaces.Atmospheres.Interfaces.Base(redeclare final function windVelocity = constantWindVelocity(windVelocity = v), redeclare final function density = constantDensity(density = rho), redeclare final function temperature = constantTemperature(T0 = T), redeclare final function humidity = constantHumidity(h0 = h));
      parameter Modelica.SIunits.Velocity[3] v = zeros(3);
      parameter Modelica.SIunits.AbsolutePressure ambientPressure = 101300;
      parameter Modelica.SIunits.Temperature T = 293.15;
      parameter Real h = 0.5;
      constant Real R = 287.0512249529787;
    protected
      parameter Modelica.SIunits.Density rho = ambientPressure / (R * T);

      function constantWindVelocity  
        extends VehicleInterfaces.Atmospheres.Interfaces.windVelocityBase;
        input Modelica.SIunits.Velocity[3] windVelocity = {0, 0, 0};
      algorithm
        v := windVelocity;
      end constantWindVelocity;

      function constantDensity  
        extends VehicleInterfaces.Atmospheres.Interfaces.densityBase;
        input Modelica.SIunits.Density density = 1.18;
      algorithm
        rho := density;
      end constantDensity;

      function constantTemperature  
        extends VehicleInterfaces.Atmospheres.Interfaces.temperatureBase;
        input Modelica.SIunits.Temperature T0 = 293;
      algorithm
        T := T0;
      end constantTemperature;

      function constantHumidity  
        extends VehicleInterfaces.Atmospheres.Interfaces.humidityBase;
        input Real h0 = 0.5;
      algorithm
        h := h0;
      end constantHumidity;
    end ConstantAtmosphere;
  end Atmospheres;

  package Brakes  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        VehicleInterfaces.Interfaces.ControlBus controlBus;
        Modelica.Mechanics.Translational.Interfaces.Flange_a brakePedal if includeBrakePedal;
        parameter Boolean usingMultiBodyChassis = false;
      protected
        parameter Boolean includeBrakePedal = false;
        parameter Boolean includeWheelBearings = false;
      end Base;

      partial model TwoAxleBase  
        extends Base;
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_1(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_2(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_3(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_4(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_2(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_4(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_3(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_1(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
      equation
        connect(end_2.flange, wheelHub_2);
        connect(end_4.flange, wheelHub_4);
        connect(end_3.flange, wheelHub_3);
        connect(end_1.flange, wheelHub_1);
      end TwoAxleBase;

      expandable connector StandardBus  
        extends VehicleInterfaces.Interfaces.BrakesBus;
        extends VehicleInterfaces.Icons.SignalSubBusWithExplicitSignals;
        .Modelica.SIunits.AngularVelocity wheelSpeed_1;
        .Modelica.SIunits.AngularVelocity wheelSpeed_2;
        .Modelica.SIunits.AngularVelocity wheelSpeed_3;
        .Modelica.SIunits.AngularVelocity wheelSpeed_4;
      end StandardBus;
    end Interfaces;

    model MinimalBrakes  
      extends VehicleInterfaces.Icons.Brakes;
      extends VehicleInterfaces.Brakes.Interfaces.TwoAxleBase(includeWheelBearings = world.driveTrainMechanics3D);
      parameter Modelica.SIunits.Torque maxTorque = 1000;
      Modelica.Blocks.Math.Gain computeTorque(k = maxTorque / 4.0);
      Modelica.Mechanics.Rotational.Components.Brake brake_1(mue_pos = [0, 1], useSupport = true, fn_max = 1);
      Modelica.Mechanics.Rotational.Components.Brake brake_2(mue_pos = [0, 1], useSupport = true, fn_max = 1);
      Modelica.Mechanics.Rotational.Components.Brake brake_3(mue_pos = [0, 1], useSupport = true, fn_max = 1);
      Modelica.Mechanics.Rotational.Components.Brake brake_4(mue_pos = [0, 1], useSupport = true, fn_max = 1);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheelSpeed_1;
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheelSpeed_2;
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheelSpeed_3;
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheelSpeed_4;
      Modelica.Mechanics.MultiBody.Parts.Mounting1D torqueReaction_2(n = {0, 1, 0});
      Modelica.Mechanics.MultiBody.Parts.Mounting1D torqueReaction_4(n = {0, 1, 0});
      Modelica.Mechanics.MultiBody.Parts.Mounting1D torqueReaction_3(n = {0, 1, 0});
      Modelica.Mechanics.MultiBody.Parts.Mounting1D torqueReaction_1(n = {0, 1, 0});
    protected
      outer Modelica.Mechanics.MultiBody.World world;
      replaceable VehicleInterfaces.Brakes.Interfaces.StandardBus brakesBus constrainedby VehicleInterfaces.Interfaces.BrakesBus;
      replaceable VehicleInterfaces.DriverEnvironments.Interfaces.MinimalBus driverBus constrainedby VehicleInterfaces.Interfaces.DriverBus;
    equation
      connect(computeTorque.y, brake_1.f_normalized);
      connect(computeTorque.y, brake_2.f_normalized);
      connect(computeTorque.y, brake_3.f_normalized);
      connect(computeTorque.y, brake_4.f_normalized);
      connect(brake_1.flange_b, wheelHub_1.flange);
      connect(brake_2.flange_a, wheelHub_2.flange);
      connect(brake_3.flange_a, wheelHub_3.flange);
      connect(brake_4.flange_b, wheelHub_4.flange);
      connect(wheelSpeed_1.flange, brake_1.flange_a);
      connect(brake_2.flange_b, wheelSpeed_2.flange);
      connect(wheelSpeed_3.flange, brake_3.flange_b);
      connect(brake_4.flange_a, wheelSpeed_4.flange);
      connect(controlBus.driverBus, driverBus);
      connect(computeTorque.u, driverBus.brakePedalPosition);
      connect(wheelSpeed_1.w, brakesBus.wheelSpeed_1);
      connect(wheelSpeed_2.w, brakesBus.wheelSpeed_2);
      connect(wheelSpeed_3.w, brakesBus.wheelSpeed_3);
      connect(wheelSpeed_4.w, brakesBus.wheelSpeed_4);
      connect(controlBus.brakesBus, brakesBus);
      connect(brake_2.support, torqueReaction_2.flange_b);
      connect(torqueReaction_2.frame_a, wheelHub_2.bearingFrame);
      connect(torqueReaction_4.frame_a, wheelHub_4.bearingFrame);
      connect(torqueReaction_4.flange_b, brake_4.support);
      connect(torqueReaction_3.flange_b, brake_3.support);
      connect(torqueReaction_3.frame_a, wheelHub_3.bearingFrame);
      connect(torqueReaction_1.frame_a, wheelHub_1.bearingFrame);
      connect(torqueReaction_1.flange_b, brake_1.support);
    end MinimalBrakes;
  end Brakes;

  package Chassis  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        VehicleInterfaces.Interfaces.ControlBus controlBus;
        Modelica.Mechanics.MultiBody.Interfaces.Frame_b chassisFrame if includeChassisFrame;
        Modelica.Mechanics.Rotational.Interfaces.Flange_a steeringWheel if includeSteeringWheel;
        parameter Boolean usingMultiBodyDriveline = false;
      protected
        parameter Boolean includeWheelBearings = false;
        parameter Boolean includeChassisFrame = false;
        parameter Boolean includeSteeringWheel = false;
      end Base;

      partial model TwoAxleBase  
        extends Base;
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_1(final includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_2(final includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_3(final includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_4(final includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
        Mechanics.MultiBody.MultiBodyEnd end_2(includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
        Mechanics.MultiBody.MultiBodyEnd end_4(includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
        Mechanics.MultiBody.MultiBodyEnd end_3(includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
        Mechanics.MultiBody.MultiBodyEnd end_1(includeBearingConnector = includeWheelBearings or usingMultiBodyDriveline);
      equation
        connect(end_2.flange, wheelHub_2);
        connect(end_4.flange, wheelHub_4);
        connect(end_3.flange, wheelHub_3);
        connect(end_1.flange, wheelHub_1);
      end TwoAxleBase;

      expandable connector StandardBus  
        extends .VehicleInterfaces.Interfaces.ChassisBus;
        extends .VehicleInterfaces.Icons.SignalSubBusWithExplicitSignals;
        .Modelica.SIunits.Velocity longitudinalVelocity;
      end StandardBus;
    end Interfaces;

    model MinimalChassis  
      extends VehicleInterfaces.Icons.Chassis;
      extends VehicleInterfaces.Chassis.Interfaces.TwoAxleBase;
      parameter Modelica.SIunits.Mass vehicleMass = 1200;
      parameter Modelica.SIunits.Radius tyreRadius = 0.34;
      parameter Real drag = 1;
      Modelica.Mechanics.Rotational.Components.IdealRollingWheel tyres(radius = tyreRadius, useSupportT = true, useSupportR = true);
      Modelica.Mechanics.Translational.Components.Mass body(m = vehicleMass, s(stateSelect = StateSelect.always, start = 0, fixed = true));
      Modelica.Mechanics.Translational.Components.Damper dragForces(d = drag);
      Modelica.Mechanics.Translational.Components.Fixed ground;
      Modelica.Mechanics.Translational.Sensors.SpeedSensor longitudinalVelocity;
    protected
      replaceable VehicleInterfaces.Chassis.Interfaces.StandardBus chassisBus constrainedby VehicleInterfaces.Interfaces.ChassisBus;
    public
      Modelica.Mechanics.Rotational.Components.Fixed fixed;
    equation
      connect(tyres.flangeT, body.flange_a);
      connect(body.flange_b, dragForces.flange_a);
      connect(dragForces.flange_b, ground.flange);
      connect(body.flange_b, longitudinalVelocity.flange);
      connect(tyres.flangeR, wheelHub_1.flange);
      connect(tyres.flangeR, wheelHub_2.flange);
      connect(tyres.flangeR, wheelHub_3.flange);
      connect(tyres.flangeR, wheelHub_4.flange);
      connect(controlBus.chassisBus, chassisBus);
      connect(ground.flange, tyres.supportT);
      connect(fixed.flange, tyres.supportR);
      connect(chassisBus.longitudinalVelocity, longitudinalVelocity.v) annotation(Text(string = "%first", index = -1, extent = {{-6, 3}, {-6, 3}}));
    end MinimalChassis;
  end Chassis;

  package Drivelines  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing transmissionFlange(final includeBearingConnector = includeTransmissionBearing or usingMultiBodyTransmission);
        VehicleInterfaces.Interfaces.ControlBus controlBus;
        Modelica.Mechanics.MultiBody.Interfaces.Frame_a drivelineMount if includeMount;
        Mechanics.MultiBody.MultiBodyEnd end_0(final includeBearingConnector = includeTransmissionBearing or usingMultiBodyTransmission);
        parameter Boolean usingMultiBodyChassis = false;
        parameter Boolean usingMultiBodyTransmission = false;
      protected
        parameter Boolean includeWheelBearings = false;
        parameter Boolean includeMount = false;
        parameter Boolean includeTransmissionBearing = false;
      equation
        connect(end_0.flange, transmissionFlange);
      end Base;

      partial model TwoAxleBase  
        extends Base;
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_1(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_2(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_3(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing wheelHub_4(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_1(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_2(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_3(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
        Mechanics.MultiBody.MultiBodyEnd end_4(final includeBearingConnector = includeWheelBearings or usingMultiBodyChassis);
      equation
        connect(end_1.flange, wheelHub_1);
        connect(end_4.flange, wheelHub_4);
        connect(end_3.flange, wheelHub_3);
        connect(end_2.flange, wheelHub_2);
      end TwoAxleBase;
    end Interfaces;

    model MinimalDriveline  
      extends VehicleInterfaces.Icons.Driveline;
      extends VehicleInterfaces.Drivelines.Interfaces.TwoAxleBase(includeMount = world.driveTrainMechanics3D);
      parameter Modelica.SIunits.Inertia halfshaftInertia = 0.1;
      parameter Real finalDriveRatio = 3;
      Modelica.Mechanics.MultiBody.Parts.Rotor1D rightHalfShaft(J = halfshaftInertia);
      Modelica.Mechanics.MultiBody.Parts.Rotor1D leftHalfShaft(J = halfshaftInertia);
      Modelica.Mechanics.Rotational.Components.IdealPlanetary differential(ratio = 1);
    protected
      outer Modelica.Mechanics.MultiBody.World world;
    public
      Modelica.Mechanics.Rotational.Components.IdealGear finalDrive(ratio = finalDriveRatio, useSupport = false);
    equation
      connect(rightHalfShaft.flange_a, wheelHub_2.flange);
      connect(leftHalfShaft.flange_a, wheelHub_1.flange);
      connect(leftHalfShaft.flange_b, differential.sun);
      connect(differential.ring, rightHalfShaft.flange_b);
      connect(rightHalfShaft.frame_a, drivelineMount);
      connect(leftHalfShaft.frame_a, drivelineMount);
      connect(finalDrive.flange_b, differential.carrier);
      connect(finalDrive.flange_a, transmissionFlange.flange);
    end MinimalDriveline;
  end Drivelines;

  package DriverEnvironments  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        VehicleInterfaces.Interfaces.ControlBus controlBus;
        Modelica.Mechanics.MultiBody.Interfaces.Frame_a chassisFrame if includeDriverSeat;
        Modelica.Mechanics.Rotational.Interfaces.Flange_a steeringWheel if includeSteeringWheel;
        Modelica.Mechanics.Translational.Interfaces.Flange_a acceleratorPedal if includeAcceleratorPedal;
        Modelica.Mechanics.Translational.Interfaces.Flange_a brakePedal if includeBrakePedal;
      protected
        parameter Boolean includeDriverSeat = false;
        parameter Boolean includeSteeringWheel = false;
        parameter Boolean includeAcceleratorPedal = false;
        parameter Boolean includeBrakePedal = false;
      end Base;

      partial model BaseAutomaticTransmission  
        extends Base;
      end BaseAutomaticTransmission;

      partial model BaseAutomaticTransmissionExternalDriver  
        extends BaseAutomaticTransmission;
        replaceable VehicleInterfaces.Interfaces.DriverInterface driverInterface;
      end BaseAutomaticTransmissionExternalDriver;

      expandable connector MinimalBus  
        extends VehicleInterfaces.Interfaces.DriverBus;
        extends .VehicleInterfaces.Icons.SignalSubBusWithExplicitSignals;
        VehicleInterfaces.Types.NormalizedReal acceleratorPedalPosition;
        VehicleInterfaces.Types.NormalizedReal brakePedalPosition;
        VehicleInterfaces.Types.IgnitionSetting.Temp ignition;
      end MinimalBus;

      expandable connector BusForAutomaticTransmission  
        extends VehicleInterfaces.DriverEnvironments.Interfaces.MinimalBus;
        VehicleInterfaces.Types.Gear requestedGear;
        VehicleInterfaces.Types.GearMode.Temp gearboxMode;
      end BusForAutomaticTransmission;
    end Interfaces;

    model DriveByWireAutomaticExternalDriver  
      extends VehicleInterfaces.Icons.DriverEnvironment;
      extends Interfaces.BaseAutomaticTransmissionExternalDriver;
      Mechanics.NormalisedTranslational.PositionSensor acceleratorPosition;
      Mechanics.NormalisedTranslational.PositionSensor brakePosition;
      Blocks.IntegerPassThrough gearboxMode;
      Blocks.IntegerPassThrough requestedGear;
      Blocks.IntegerPassThrough ignition;
    protected
      replaceable VehicleInterfaces.DriverEnvironments.Interfaces.BusForAutomaticTransmission driverBus constrainedby VehicleInterfaces.Interfaces.DriverBus;
    equation
      connect(driverBus, controlBus.driverBus);
      connect(driverInterface.gearboxMode, gearboxMode.u) annotation(Text(string = "%first", index = -1, extent = [-6, 3; -6, 3], style(color = 0, rgbcolor = {0, 0, 0})));
      connect(gearboxMode.y, driverBus.gearboxMode) annotation(Text(string = "%second", index = 1, extent = [6, 3; 6, 3], style(color = 0, rgbcolor = {0, 0, 0})));
      connect(driverInterface.requestedGear, requestedGear.u) annotation(Text(string = "%first", index = -1, extent = [-6, 3; -6, 3], style(color = 0, rgbcolor = {0, 0, 0})));
      connect(requestedGear.y, driverBus.requestedGear) annotation(Text(string = "%second", index = 1, extent = [6, 3; 6, 3], style(color = 0, rgbcolor = {0, 0, 0})));
      connect(driverInterface.ignition, ignition.u) annotation(Text(string = "%first", index = -1, extent = [-6, 3; -6, 3], style(color = 0, rgbcolor = {0, 0, 0})));
      connect(ignition.y, driverBus.ignition) annotation(Text(string = "%second", index = 1, extent = [6, 3; 6, 3], style(color = 0, rgbcolor = {0, 0, 0})));
      connect(driverInterface.brakePedal, brakePosition.flange_a) annotation(Text(string = "%first", index = -1, extent = {{-6, 3}, {-6, 3}}));
      connect(driverInterface.acceleratorPedal, acceleratorPosition.flange_a) annotation(Text(string = "%first", index = -1, extent = {{-6, 3}, {-6, 3}}));
      connect(acceleratorPosition.position, driverBus.acceleratorPedalPosition) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
      connect(brakePosition.position, driverBus.brakePedalPosition) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
    end DriveByWireAutomaticExternalDriver;
  end DriverEnvironments;

  package Drivers  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        replaceable VehicleInterfaces.Interfaces.DriverInterface driverInterface;
      end Base;
    end Interfaces;

    model MinimalDriver  
      extends VehicleInterfaces.Icons.Driver;
      extends VehicleInterfaces.Drivers.Interfaces.Base;
      parameter Real initialAccelRequest(min = 0, max = 1) = 1;
      parameter Real initialBrakeRequest(min = 0, max = 1) = 0;
      parameter Real finalAccelRequest(min = 0, max = 1) = 1;
      parameter Real finalBrakeRequest(min = 0, max = 1) = 0;
      parameter Modelica.SIunits.Time accelTime = 10;
      parameter Modelica.SIunits.Time brakeTime = 10;
      parameter VehicleInterfaces.Types.GearMode.Temp selectedGearboxMode = VehicleInterfaces.Types.GearMode.Drive annotation(__Dymola_choicesFromPackage = true);
      parameter VehicleInterfaces.Types.Gear manualGearRequest = 0;
      Modelica.Blocks.Sources.Step brakeDemand(height = finalBrakeRequest, offset = initialBrakeRequest, startTime = brakeTime);
      Modelica.Blocks.Sources.Step acceleratorDemand(height = finalAccelRequest, offset = initialAccelRequest, startTime = accelTime);
      Modelica.Blocks.Sources.Constant steeringAngle(k = 0);
      Modelica.Blocks.Sources.IntegerConstant gearboxMode(k = selectedGearboxMode);
      Modelica.Blocks.Sources.IntegerConstant requestedGear(k = manualGearRequest);
      Mechanics.NormalisedRotational.Position steeringWheelAngle;
      Mechanics.NormalisedTranslational.Position brakePosition;
      Mechanics.NormalisedTranslational.Position acceleratorPosition;
      Modelica.Blocks.Sources.IntegerStep ignition(height = -1, startTime = 0.5, offset = VehicleInterfaces.Types.IgnitionSetting.Start);
    equation
      connect(gearboxMode.y, driverInterface.gearboxMode) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
      connect(requestedGear.y, driverInterface.requestedGear) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
      connect(ignition.y, driverInterface.ignition) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
      connect(steeringAngle.y, steeringWheelAngle.phi_ref);
      connect(brakeDemand.y, brakePosition.position);
      connect(acceleratorDemand.y, acceleratorPosition.position);
      connect(brakePosition.flange_b, driverInterface.brakePedal) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
      connect(acceleratorPosition.flange_b, driverInterface.acceleratorPedal) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
      connect(steeringWheelAngle.flange_b, driverInterface.steeringWheel) annotation(Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
    end MinimalDriver;
  end Drivers;

  package Engines  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        parameter Boolean usingMultiBodyAccessories = false;
        parameter Boolean usingMultiBodyTransmission = false;
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing accessoryFlange(final includeBearingConnector = includeAccessoriesBearing or usingMultiBodyAccessories);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing transmissionFlange(final includeBearingConnector = includeTransmissionBearing or usingMultiBodyTransmission);
        VehicleInterfaces.Interfaces.ControlBus controlBus;
        Modelica.Mechanics.MultiBody.Interfaces.Frame_a engineMount if includeMount;
        Modelica.Mechanics.Translational.Interfaces.Flange_a acceleratorPedal if includeAcceleratorPedal;
        Mechanics.MultiBody.MultiBodyEnd end_2(final includeBearingConnector = includeTransmissionBearing or usingMultiBodyTransmission);
        Mechanics.MultiBody.MultiBodyEnd end_1(final includeBearingConnector = includeAccessoriesBearing or usingMultiBodyAccessories);
      protected
        parameter Boolean includeAcceleratorPedal = false;
        parameter Boolean includeMount = false;
        parameter Boolean includeTransmissionBearing = false;
        parameter Boolean includeAccessoriesBearing = false;
      equation
        connect(end_2.flange, transmissionFlange);
        connect(end_1.flange, accessoryFlange);
      end Base;

      expandable connector StandardBus  
        extends .VehicleInterfaces.Interfaces.EngineBus;
        extends .VehicleInterfaces.Icons.SignalSubBusWithExplicitSignals;
        .Modelica.SIunits.AngularVelocity speed;
      end StandardBus;
    end Interfaces;

    model MinimalEngine  
      extends VehicleInterfaces.Icons.Engine;
      extends Interfaces.Base(includeMount = world.driveTrainMechanics3D, includeAccessoriesBearing = world.driveTrainMechanics3D);
      parameter Modelica.SIunits.AngularVelocity engineSpeed_start(displayUnit = "r/min") = 104.7197551196598;
      parameter Modelica.SIunits.Torque requestedTorque = 50;
      parameter Modelica.SIunits.Inertia flywheelInertia = 0.08;
      parameter Modelica.Mechanics.MultiBody.Types.Axis axisOfRotation = {1, 0, 0};
      Modelica.Mechanics.MultiBody.Parts.Rotor1D flywheel(J = flywheelInertia, n = axisOfRotation, a(fixed = false), phi(fixed = false), w(fixed = true, start = engineSpeed_start));
      Modelica.Mechanics.Rotational.Sources.Torque engine(useSupport = true);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor engineSpeed;
      Modelica.Mechanics.Rotational.Sensors.TorqueSensor engineTorque;
      Modelica.Mechanics.Rotational.Sensors.PowerSensor enginePower;
      Modelica.Blocks.Math.Gain gain(k = requestedTorque);
      Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D(n = axisOfRotation);
    protected
      replaceable VehicleInterfaces.Engines.Interfaces.StandardBus engineBus constrainedby VehicleInterfaces.Interfaces.EngineBus;
      replaceable VehicleInterfaces.DriverEnvironments.Interfaces.MinimalBus driverBus constrainedby VehicleInterfaces.Interfaces.DriverBus;
      outer Modelica.Mechanics.MultiBody.World world;
    equation
      connect(engine.flange, flywheel.flange_a);
      connect(flywheel.flange_b, engineSpeed.flange);
      connect(flywheel.flange_b, engineTorque.flange_a);
      connect(engineTorque.flange_b, enginePower.flange_a);
      connect(controlBus.engineBus, engineBus);
      connect(controlBus.driverBus, driverBus);
      connect(gain.y, engine.tau);
      connect(flywheel.frame_a, engineMount);
      connect(mounting1D.flange_b, engine.support);
      connect(mounting1D.frame_a, engineMount);
      connect(gain.u, driverBus.acceleratorPedalPosition);
      connect(enginePower.flange_b, transmissionFlange.flange);
      connect(flywheel.flange_a, accessoryFlange.flange);
      connect(accessoryFlange.bearingFrame, mounting1D.frame_a);
      connect(engineSpeed.w, engineBus.speed);
    end MinimalEngine;
  end Engines;

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

    model FlatRoad  
      extends VehicleInterfaces.Icons.Road;
      extends VehicleInterfaces.Roads.Interfaces.Base(redeclare final function position = linePosition, redeclare final function trackOffset = constantOffset(offset = offset), redeclare final function normal = lineNormal, redeclare final function headingDirection = lineHeadingDirection, redeclare final function frictionCoefficient = lineFrictionCoefficient(mue_fixed = mue));
      parameter Boolean animation = true;
      parameter Real mue = 0.5;
      parameter Modelica.Mechanics.MultiBody.Types.Color roadColor = {255, 0, 0};
      parameter Modelica.SIunits.Length width = 8;
      parameter Modelica.SIunits.Position x_min = -100;
      parameter Modelica.SIunits.Position x_max = 100;
      parameter Modelica.SIunits.Distance offset = 0;
    protected
      outer Modelica.Mechanics.MultiBody.World world;
      VehicleInterfaces.Roads.Internal.VisualizeSimpleRoads roadShape(ns = 2, nw = 2, s_min = x_min, s_max = x_max, w_min = -width / 2, w_max = width / 2, color = roadColor) if animation and world.enableAnimation;

      function linePosition  
        extends VehicleInterfaces.Roads.Interfaces.positionBase;
      algorithm
        r_0 := {s, w, 0};
      end linePosition;

      function constantOffset  
        extends VehicleInterfaces.Roads.Interfaces.trackOffsetBase;
        input Modelica.SIunits.Distance offset = 0;
      algorithm
        trackOffset := {0, offset, 0};
      end constantOffset;

      function lineNormal  
        extends VehicleInterfaces.Roads.Interfaces.normalBase;
      algorithm
        e_n_0 := {0, 0, 1};
      end lineNormal;

      function lineHeadingDirection  
        extends VehicleInterfaces.Roads.Interfaces.headingDirectionBase;
      algorithm
        e_s_0 := {1, 0, 0};
      end lineHeadingDirection;

      function lineFrictionCoefficient  
        extends VehicleInterfaces.Roads.Interfaces.frictionCoefficientBase;
        input Real mue_fixed = 1;
      algorithm
        mue := mue_fixed;
      end lineFrictionCoefficient;
    end FlatRoad;

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
    end Internal;
  end Roads;

  package Transmissions  
    extends VehicleInterfaces.Icons.VariantLibrary;

    package Interfaces  
      extends Modelica.Icons.InterfacesPackage;

      partial model Base  
        parameter Boolean usingMultiBodyEngine = false;
        parameter Boolean usingMultiBodyDriveline = false;
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing engineFlange(final includeBearingConnector = includeTransmissionBearing or usingMultiBodyEngine);
        Modelica.Mechanics.MultiBody.Interfaces.FlangeWithBearing drivelineFlange(final includeBearingConnector = includeDrivelineBearing or usingMultiBodyDriveline);
        VehicleInterfaces.Interfaces.ControlBus controlBus;
        Modelica.Mechanics.MultiBody.Interfaces.Frame_a transmissionMount if includeMount;
        Mechanics.MultiBody.MultiBodyEnd end_2(final includeBearingConnector = includeDrivelineBearing or usingMultiBodyDriveline);
        Mechanics.MultiBody.MultiBodyEnd end_1(final includeBearingConnector = includeTransmissionBearing or usingMultiBodyEngine);
      protected
        parameter Boolean includeMount = false;
        parameter Boolean includeDrivelineBearing = false;
        parameter Boolean includeTransmissionBearing = false;
      equation
        connect(end_1.flange, engineFlange);
        connect(end_2.flange, drivelineFlange);
      end Base;

      partial model BaseAutomaticTransmission  
        extends Base;
      end BaseAutomaticTransmission;

      expandable connector StandardBus  
        extends .VehicleInterfaces.Interfaces.TransmissionBus;
        extends .VehicleInterfaces.Icons.SignalSubBusWithExplicitSignals;
        .Modelica.SIunits.AngularVelocity outputSpeed;
        Boolean clutchLocked;
      end StandardBus;

      expandable connector StandardControlBus  
        extends .VehicleInterfaces.Interfaces.TransmissionControlBus;
        extends .VehicleInterfaces.Icons.SignalSubBusWithExplicitSignals;
        Integer currentGear;
      end StandardControlBus;
    end Interfaces;

    model SingleGearAutomaticTransmission  
      extends VehicleInterfaces.Icons.Transmission;
      extends Interfaces.BaseAutomaticTransmission(includeMount = world.driveTrainMechanics3D);
      parameter Real gearRatio = 4;
      Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = gearRatio, useSupport = true);
      Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D;
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor outputSpeed;
      Modelica.Blocks.Sources.IntegerConstant currentGear(k = 1);
    protected
      replaceable VehicleInterfaces.Transmissions.Interfaces.StandardBus transmissionBus constrainedby VehicleInterfaces.Interfaces.TransmissionBus;
      replaceable VehicleInterfaces.Transmissions.Interfaces.StandardControlBus transmissionControlBus constrainedby VehicleInterfaces.Interfaces.TransmissionControlBus;
      outer Modelica.Mechanics.MultiBody.World world;
    equation
      connect(mounting1D.flange_b, gear.support);
      connect(mounting1D.frame_a, transmissionMount);
      connect(gear.flange_b, outputSpeed.flange);
      connect(controlBus.transmissionBus, transmissionBus);
      connect(transmissionControlBus, controlBus.transmissionControlBus);
      connect(currentGear.y, transmissionControlBus.currentGear);
      connect(gear.flange_a, engineFlange.flange);
      connect(gear.flange_b, drivelineFlange.flange);
      connect(outputSpeed.w, transmissionBus.outputSpeed);
    end SingleGearAutomaticTransmission;
  end Transmissions;
end VehicleInterfaces;

model ConventionalAutomaticVehicleExternalDriver
  extends VehicleInterfaces.Examples.ConventionalAutomaticVehicleExternalDriver;
  annotation(experiment(StopTime = 10));
end ConventionalAutomaticVehicleExternalDriver;
