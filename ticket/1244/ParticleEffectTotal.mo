package Visualization "Visualization (version 1.0) - Advanced, model integrated offline, online and real-time visualization"
  import SI = Modelica.SIunits;
  extends Visualization.Utilities.Icons.Package;
  annotation(uses(Modelica(version="3.1")), preferedView="info", version="1.0", versionBuild=1, versionDate="2009-10-02 13:00:00Z", revisionId="$Id:: package.mo 5773 2010-01-13 10:22:39Z #$", classOrder={"UsersGuide","Examples","UpdateVisualization","Shapes","Cameras","Lights","FlowElements","HUD","Pathdefinitions","Effects","Utilities","Internal"}, Documentation(info="<html>
<p>
Package <b>Visualization</b> is a <b>commercial</b> Modelica package from <b>DLR-RM</b>
providing an
advanced model integrated visualization for Modelica models, especially in the mechanical,
fluid and electrical area. The components are available for offline,
online, and realtime animation and are usually attached to a Modelica
model with a
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Interfaces.Frame_a\">Frame</a>
connector of the
<a href=\"Modelica://Modelica.Mechanics.MultiBody\">MultiBody</a> library.
</p>
 
<p>
The library contains visualizers for elementary shapes (boxes, spheres, etc.),
CAD files (current formats: dxf, 3ds, obj, stl), flexible bodies
and surfaces, text, light, energy/mass-flow visualizers, analogue instruments,
weather effects, and cameras. The rendering engine is based on
the <a href=\"http://www.openscenegraph.org/projects/osg\">OpenSceneGraph</a>
software and supports multi-camera scenes, fullscreen mode,
several monitors, replays and stereo/wireframe modes.
The integrated video export function allows the export of the animation replays
as MPEG4, Windows Media Video, Flash Video and Lossless HUFF video.
In the next figure several examples are shown
(the landscape in the left image is from <a href=\"http://www.vires.com/\">Vires</a>):
</p>
 
<blockquote>
<table  border=\"1\" cellspacing=\"0\" cellpadding=\"3\" style=\"border-collapse: collapse;\">
  <tr>
    <td><img src=\"../Extras/Images/Overview-VehicleDynamics.png\"></td>
    <td><img src=\"../Extras/Images/Overview-Cooling.png\"></td>
    <td><img src=\"../Extras/Images/Overview-FlexibleShape.png\" width= 200></td>
  </tr>
  <tr>
    <td align=\"center\" style=\"background-color: rgb(240, 240, 240)\">Vehicle dynamics visualization </td>
    <td align=\"center\" style=\"background-color: rgb(240, 240, 240)\">Fluid flow visualization</td>
    <td align=\"center\" style=\"background-color: rgb(240, 240, 240)\">Flexible body visualization</td>
  </tr>
</table>
</blockquote>
 
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"Modelica://Visualization.UsersGuide.Overview\">Overview</a>
  provides an overview of the Visualization Library
  inside the <a href=\"Modelica://Visualization.UsersGuide\">User's Guide</a>.</li>
<li> <a href=\"Modelica://Visualization.Examples\">Examples</a>
     contains many examples demonstrating how to use the
     visualization components.</li>
<li><a href=\"Modelica://Visualization.UsersGuide.ReleaseNotes\">Release Notes</a>
 summarizes the changes of new versions of this package.</li>
<li> <a href=\"Modelica://Visualization.UsersGuide.Contact\">Contact</a>
  lists the contributors of this library.</li>
</ul>
 
<p>
The standard Modelica visualization for multi-body models can be replaced
by this Visualization tool, if you replace the
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Shape</a>
component in the Modelica
Standard Library (version 3.1) or in the
<a href=\"Modelica://ModelicaServices.Animation.Shape\">ModelicaServices</a>
Library (version 3.1) by the
<a href=\"Modelica://Visualization.Internal.Shape\">Visualization.Internal.Shape</a>
component.
</p>
 
<p>
</p>
 
<table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" ></td>
      <td valign=\"center\"> <b>Copyright &copy; 2008-2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
  package Utilities "Utility classes usually not directly utilized by the user"
    extends Icons.Package;
    annotation(preferedView="info", classOrder={"BaseClasses","*"}, Documentation(info="<html>
<p>
This package contains auxiliary packages and elements to be used in context with the PowerTrain library.
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
    constant String RootDir=Modelica.Utilities.Files.fullPathName(classDirectory() + "..");
    package Icons "Collection of icons used for library components"
      extends Package;
      partial class Package "Icon for a package class"
        annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}, grid={1,1}), graphics={Rectangle(extent={{-60,100},{100,-60}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Polygon(points={{-100,60},{-60,100},{-60,60},{-100,60}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Polygon(points={{60,-60},{100,-60},{60,-100},{60,-60}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Rectangle(extent={{-100,60},{60,-100}}, lineColor={0,0,255}, fillColor={215,215,215}, fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<img src=\"../Extras/Images/dlr_logo.png\"  width=60 >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <b>      Copyright &copy; 2006-2007, DLR Institute of Robotics and Mechatronics</b>
</html>", info="<html>
<p>
This partial class is intended to design a <em>default icon for a package class</em>. I should be used for all library packages except for packages of specific purpose (e.g. packages of base classes, of internal material or of examples).
</p>
</html>"));
      end Package;

      annotation(preferedView="info", classOrder={"Package","BaseClassPackage","VariantPackage","ParametrizedPackage","ExamplesPackage","*"}, Documentation(info="<html>
<p>
A collection of basic icons to be used for different elements of the library.
</p>
<b></b><b></b><b></b><b></b><b></b>
</html>", revisions="<html>
<img src=\"../Extras/Images/dlr_logo.png\"  width=60 >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <b>      Copyright &copy; 2006-2007, DLR Institute of Robotics and Mechatronics</b>
</html>"));
      partial model ExecutableModel "Icon for a simulatable model"
        annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}, fillPattern=FillPattern.Sphere, fillColor={150,255,150}),Polygon(points={{-26,40},{54,0},{-26,-40},{-26,40}}, lineColor={0,0,255}, pattern=LinePattern.None, fillColor={0,0,0}, fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<img src=\"../Extras/Images/dlr_logo.png\"  width=60 >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <b>      Copyright &copy; 2006-2007, DLR Institute of Robotics and Mechatronics</b>
</html>", info="<html>
<p>
This partial class is intended to design a <em>default icon for a simulatable model</em>, i.e. for a classes that defines test cases.
</p>
</html>"));
      end ExecutableModel;

      partial class ExamplesPackage "Icon for a package class which contains simulatable models"
        annotation(Documentation(info="<html>
<p>
This partial class is intended to design a <em>default icon for a package class</em> which contains different <em>simulatable</em> models.
</p>
</html>", revisions="<html>
<img src=\"../Extras/Images/dlr_logo.png\"  width=60 >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <b>      Copyright &copy; 2006-2007, DLR Institute of Robotics and Mechatronics</b>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-60,100},{100,-60}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Polygon(points={{-100,60},{-60,100},{-60,60},{-100,60}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Polygon(points={{60,-60},{100,-60},{60,-100},{60,-60}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Rectangle(extent={{-100,60},{60,-100}}, lineColor={0,0,255}, fillColor={150,255,150}, fillPattern=FillPattern.Solid),Polygon(points={{-52,16},{30,-24},{-52,-60},{-52,16}}, lineColor={0,0,255}, pattern=LinePattern.None, fillColor={0,0,0}, fillPattern=FillPattern.Solid)}));
      end ExamplesPackage;

      class BaseClassPackage "Icon for a package class with the names BaseClasses, Internal or Interfaces"
        annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-60,100},{100,-60}}, lineColor={215,215,215}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Polygon(points={{-100,60},{-60,100},{-60,60},{-100,60}}, lineColor={215,215,215}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Polygon(points={{60,-60},{100,-60},{60,-100},{60,-60}}, lineColor={215,215,215}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Rectangle(extent={{-100,60},{60,-100}}, lineColor={215,215,215}, fillColor={240,255,255}, fillPattern=FillPattern.Solid),Rectangle(extent={{100,-20},{100,-60}}, lineColor={215,215,215}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Line(points={{-60,100},{-60,60}}, color={215,215,215}),Line(points={{100,-60},{60,-60}}, color={215,215,215})}), Documentation(revisions="<html>
<img src=\"../Extras/Images/dlr_logo.png\"  width=60 >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <b>      Copyright &copy; 2006-2007, DLR Institute of Robotics and Mechatronics</b>
</html>", info="<html>
<p>
This partial class is intended to design a <em>default icon for a package class</em> with the names <em>BaseClasses</em>, <em>Internal</em> or <em>Interfaces</em>.
</p>
</html>"));
      end BaseClassPackage;

    end Icons;

  end Utilities;

  package Shapes "Collection of geometrical shapes like boxes, CAD-files, flexible parts, strings"
    annotation(classOrder={"Examples","*","BaseClasses","Internal"}, Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{-134,130},{136,-120}}, fileName="../Extras/Images/Icons/shapes.png")}), Documentation(info="<html>
<p>
This package provides visualizers for elementary geometric elements (<b>ElementaryShape</b>), CAD files (<b>FileShape</b>), flexible Surfaces (<b>FlexibleSurface</b>), flexible bodies
(<b>FlexibleShape</b>), Lines (<b>Line</b>) and Text (<b>TextShape</b>, <b>TextValueShape</b>):
</p>
 
<blockquote>
<img src=\"../Extras/Images/Icons/shapes.png\" width=200>
</blockquote>
 
<blockquote>
<img src=\"../Extras/Images/Heli.png\" width=400>
</blockquote>
</html>"));
    package Internal "Collection of base classes involving visualization shapes"
      extends Utilities.Icons.BaseClassPackage;
      annotation(Protection(showDiagram=true), preferedView="info", Documentation(info="<html>
<p>
A collection of base classes to be used for different types of visualization shapes.
</p>
 
<placeholder to comply minimal number of characters for documentation>
 
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=60></td>
      <td valign=\"center\"> <b>Copyright &copy; 2006-2008, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
      package Types
        extends Visualization.Utilities.Icons.Package;
        annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
        type Transparency= Modelica.Icons.TypeReal(min=0, max=1) "Transparency of shape: (0 = opaque, 1 = fully transparent)";
        type Shininess= Modelica.Icons.TypeReal(min=0, max=1) "Shininess: 0 (full surface reflection) .. 1 (point reflection)";
        type ShapeType= Modelica.Icons.TypeString annotation(preferedView="text", Evaluate=true, choices(choice="box" "box", choice="sphere" "sphere", choice="cylinder" "cylinder", choice="cone" "cone", choice="capsule" "capsule", choice="spring" "spring", choice="gearwheel" "gearwheel", choice="pipe" "pipe", choice="coordinate system" "coordinate system", choice="grid" "grid", choice="beam" "beam"));
      end Types;

      package Functions
        extends Visualization.Utilities.Icons.Package;
        annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
        function setBaseObject
          input Visualization.Internal.VisShapeID ID;
          input Integer state;
          input Integer baseObjType;
          input Real pos[3];
          input Real T[6];
          input Real scale[3];
          input Integer color[3];
          input Integer wireframe;
          input Integer reflectsLight;
          input Real shininess;
          input Real extra[3];
          input Real transparency;
          output Boolean y=false;

          external "C" SetBaseObject(ID,state,baseObjType,pos,T,scale,color,wireframe,reflectsLight,shininess,extra,transparency) ;

        end setBaseObject;

      end Functions;

      partial model PartialShape "Base class for a shape model"
        import MBSTypes = Modelica.Mechanics.MultiBody.Types;
        extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
        extends Visualization.Internal.AnimationDefinition;
        import SI = Modelica.SIunits;
        import Cv = Modelica.SIunits.Conversions;
        input SI.Position r_shape[3]={0,0,0} "Vector from frame_a to shape origin resolved in frame_a" annotation(Dialog(tab="Shape frame", group="Definition of shape frame with respect to frame_a"));
        parameter Visualization.Internal.Types.RotationTypes rotationType=Visualization.Internal.Types.RotationTypes.TwoAxesVectors "Type of rotation description (to rotate frame_a to shape frame)" annotation(Evaluate=true, Dialog(tab="Shape frame", group="Definition of shape frame with respect to frame_a"));
        input MBSTypes.Axis axis={1,0,0} "Axis of rotation in frame_a" annotation(Evaluate=true, Dialog(group="if rotationType = RotationAxis", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.RotationAxis));
        input Cv.NonSIunits.Angle_deg angle=0 "Angle to rotate shape around axis n" annotation(Dialog(group="if rotationType = RotationAxis", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.RotationAxis));
        input MBSTypes.Axis lengthDirection={1,0,0} "Vector along length direction (x-axis) of shape resolved in frame_a" annotation(Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.TwoAxesVectors));
        input MBSTypes.Axis widthDirection={0,1,0} "Vector along height direction (y-axis) of shape resolved in frame_a" annotation(Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.TwoAxesVectors));
        parameter MBSTypes.RotationSequence sequence(min={1,1,1}, max={3,3,3})={1,2,3} "Sequence of rotations" annotation(Evaluate=true, Dialog(group="if rotationType = PlanarRotationSequence", tab="Shape frame", enable=rotationType == Types.RotationTypes.PlanarRotationSequence));
        input Cv.NonSIunits.Angle_deg angles[3]={0,0,0} "Rotation angles around the axes defined in 'sequence'" annotation(Dialog(group="if rotationType = PlanarRotationSequence", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.PlanarRotationSequence));
        input Real T[3,3]=diagonal(ones(3)) "Transformation matrix from frame_a to shape frame (vec_s=T*vec_a)" annotation(Evaluate=true, Dialog(group="if rotationType = TransformationMatrix", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.TransformationMatrix));
        annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(extent={{-150,140},{150,100}}, textString="%name", lineColor={0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-80,80},{62,-40}}, lineColor={95,95,95}, pattern=LinePattern.Dash, fillColor={225,225,225}, fillPattern=FillPattern.Solid),Text(extent={{-22,-28},{50,-38}}, lineColor={0,127,0}, pattern=LinePattern.Dash, fillColor={215,215,215}, fillPattern=FillPattern.Solid, textString="if displayVisualizers = true"),Rectangle(extent={{-80,-46},{10,-96}}, lineColor={95,95,95}, pattern=LinePattern.Dash, fillColor={225,225,225}, fillPattern=FillPattern.Solid),Text(extent={{-64,-86},{8,-96}}, lineColor={255,0,0}, pattern=LinePattern.Dash, fillColor={215,215,215}, fillPattern=FillPattern.Solid, textString="if displayVisualizers = false")}, lineColor={0,0,255}, lineColor={0,0,255}, textString="BaseClass"));
      public 
        Visualization.Internal.DynamicRotation fixedDisplacement(final animation=false, final r=r_shape, final n_y=widthDirection, final n_x=lengthDirection, n=axis, angle=angle, sequence=sequence, angles=angles, T=T, final rotationType=rotationType) if displayVisualizers annotation(Placement(transformation(extent={{-72,-10},{-52,10}}, rotation=0)));
        Visualization.Internal.ZeroForcesAndTorques zeroForcesAndTorques if not displayVisualizers "Defines zero forces and torques at frame_a" annotation(Placement(transformation(extent={{-40,-80},{-60,-60}}, rotation=0)));
      protected 
        outer Visualization.UpdateVisualization updateVisualization;
      equation 
        connect(frame_a,fixedDisplacement.frame_a) annotation(Line(points={{-100,0},{-72,0}}, color={95,95,95}, thickness=0.5));
        connect(zeroForcesAndTorques.frame_b,frame_a) annotation(Line(points={{-60,-70},{-90,-70},{-90,0},{-100,0}}, color={95,95,95}, thickness=0.5));
      end PartialShape;

      model EShapeOrientationDefinition "defines the the basic orientation of the elementary shapes in a xyz Coordsystem."
        parameter Visualization.Shapes.Internal.Types.ShapeType shapeType="box" "Type of shape" annotation(Dialog(enable=animation));
        input Real rIn[3] annotation(Dialog=true);
        input Real TIn[3,3] annotation(Dialog=true);
        input Real scaleIn[3] annotation(Dialog=true);
        output Real rOut[3];
        output Real TOut[6];
        output Real scaleOut[3];
      protected 
        Real T_aux[3,3]={{0,0,-1},{0,1,0},{1,0,0}}*TIn;
      equation 
        TOut=if shapeType == "beam" then vector([TIn[1:3,1];TIn[1:3,2]]) else if shapeType == "box" then vector([TIn[1:3,1];TIn[1:3,2]]) else if shapeType == "sphere" then vector([TIn[1:3,1];TIn[1:3,2]]) else if shapeType == "grid" then vector([TIn[1:3,1];TIn[1:3,2]]) else if shapeType == "coordinate system" then vector([TIn[1:3,1];TIn[1:3,2]]) else vector([T_aux[1:3,1];T_aux[1:3,2]]);
        rOut=rIn;
        scaleOut=if shapeType == "beam" then scaleIn else if shapeType == "box" then scaleIn else if shapeType == "sphere" then scaleIn else if shapeType == "grid" then scaleIn else if shapeType == "coordinate system" then scaleIn else if shapeType == "spring" then scaleIn else {scaleIn[3],scaleIn[2],scaleIn[1]};
      end EShapeOrientationDefinition;

      model ElementaryShape "Elementary shape block for external visualisation"
        parameter Visualization.Shapes.Internal.Types.ShapeType shapeType="box" "Type of shape";
        input Integer state=1 annotation(Dialog=true);
        input Real scale[3]={1,1,1} "Scale factor in x, y and z direction" annotation(Dialog=true);
        input Modelica.Mechanics.MultiBody.Types.Color color={255,255,255} "Diffuse color of object" annotation(Dialog=true);
        input Boolean wireframe=false "=true 3D Model will be displayed without faces" annotation(Dialog(enable=animation, group="Material properties"), choices(checkBox=true));
        input Integer reflectsLight=0 "Light reflection of shape: 0 = full absorption, 1 = full reflection" annotation(Dialog=true);
        input Real shininess=1 "Shininess of shape: 0 (= full surface reflection) .. 1 (= point reflection)" annotation(Dialog=true);
        input Real transparency=0 "Transparency of shape: 0 (= opaque) .. 1 (= fully transparent)" annotation(Dialog=true);
        parameter Real extra[3] "extra parameter for spring/pipe/ etc";
      protected 
        Visualization.Internal.VisShapeID ObjectID=Visualization.Internal.VisShapeID();
        outer Visualization.UpdateVisualization updateVisualization "Determine time instant for storing/sending data";
        Integer baseObjectType=if shapeType == "box" then 1 else if shapeType == "sphere" then 2 else if shapeType == "cylinder" then 3 else if shapeType == "cone" then 4 else if shapeType == "capsule" then 5 else if shapeType == "coordinate system" then 6 else if shapeType == "spring" then 7 else if shapeType == "gearwheel" then 8 else if shapeType == "pipe" then 9 else if shapeType == "grid" then 10 else if shapeType == "beam" then 11 else 0;
        Boolean y;
      public 
        Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation(Placement(transformation(extent={{-116,-16},{-84,16}})));
        EShapeOrientationDefinition eShapeOrientationDefinition(rIn=frame_a.r_0, TIn=frame_a.R.T, shapeType=shapeType, scaleIn=scale) annotation(Placement(transformation(extent={{-20,40},{20,60}})));
      equation 
        frame_a.t=zeros(3);
        frame_a.f=zeros(3);
        if updateVisualization.send then
          y=Visualization.Shapes.Internal.Functions.setBaseObject(ObjectID, state, baseObjectType, eShapeOrientationDefinition.rOut, eShapeOrientationDefinition.TOut, eShapeOrientationDefinition.scaleOut, color, if wireframe then 1 else 0, reflectsLight, shininess, extra, transparency);
        else
          y=false;
        end if;
        annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={95,95,95}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Text(extent={{-150,80},{150,40}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="%name"),Text(extent={{-100,-40},{100,-80}}, lineColor={135,135,135}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="Elementary")}), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics));
      end ElementaryShape;

    end Internal;

    model ElementaryShape "Visualisation of an elementary geometrical object, like a box, cylinder, coordinate system"
      import SI = Modelica.SIunits;
      extends Visualization.Shapes.Internal.PartialShape;
      annotation(defaultComponentName="shape", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{-80,80},{80,-72}}, fileName="../Extras/Images/Icons/box.PNG"),Text(extent={{-150,-68},{150,-108}}, lineColor={95,95,95}, textString="%shapeType")}), Documentation(revisions="<html>
</html>", info="<html>
<p>
Model <b>ElementaryShape</b> defines an elementary visual shape that is
shown at the location of the coordinate system defined by its <code>frame_a</code>
connector. All describing data such as size and color can vary dynamically by
providing appropriate expressions in the input fields of the
parameter menu. The only exceptions are parameter shapeType and the
special parameters in tab &quot;Additional Parameters&quot;
that cannot be changed during simulation.
The following elementary shapes are currently supported via
parameter <b>shapeType</b>, e.g., shapeType=\"box\"
(this figure was generated with example model
<a href=\"Modelica://Visualization.Examples.ShowFeatures.ElementaryShapes\">ShowFeatures.ElementaryShapes</a>):
</p>
 
<blockquote>
<img src=\"../Extras/Images/Examples/ElementaryShapes.png\">
</blockquote>
 
<p>
The red arrows in the figure above are directed along
variable <b>lengthDirection</b> (see <a href=\"Modelica://Visualization.UsersGuide.Tutorial.ShapeFrame\">Shape frame tutorial</a>.). The green arrows are directed
along variable <b>widthDirection</b>. The <code>frame_a</code>
coordinate systems are always in the &quot;middle&quot; of the
respective shape (following the OpenSceneGraph convention).
The lengthDirection and widthDirection vectors
are resolved in <code>frame_a</code>. If the two vectors are not orthogonal
to each other, then the widthDirection vector is internally
modified, so that it becomes orthogonal to the 
lengthDirection vector.
</p>
 
<p>
The sizes of the components are defined with the
<b>length</b>, <b>width</b> and <b>height</b> variables.
These are sizes of the shapes along the lenghtDirection,
widthDirection and cross(lengthDirection,widthDirection) directions.
Some components need additional data, e.g., the gearwheel. 
The additional data specific for a particular shape is defined
in tab &quot;Additional Parameters&quot;.
</p>
 
<p>
In some cases it is more convenient to define the directions in a 
different way using other options in tab &quot;Position and Orientation&quot;
</p>
 
<p>
With parameters wireframe, transparency, reflectsLight, the material properties can
be defined. For example, transparency=0.5 gives the following view of
the shapes:
</p>
 
<blockquote>
<img src=\"../Extras/Images/Examples/ElementaryShapesTransparent.png\">
</blockquote>
 
<h4><br>Shape frame</h4>
 
<p>
All quantites of a shape component are defined in the coordinate system of the \"Shape frame\".
By default, the shape frame is identical to <code>frame_a</code>. With the parameters of tab \"Shape frame\",
the shape frame can be positioned and rotated relatively to <code>frame_a</code>.
The details are described in the
<a href=\"Modelica://Visualization.UsersGuide.Tutorial.ShapeFrame\">Shape frame tutorial</a>.
</p>
 
</html>"));
      parameter Visualization.Shapes.Internal.Types.ShapeType shapeType="box" "Type of shape" annotation(Dialog(enable=animation));
      input SI.Distance length=1 "Length of shape" annotation(Dialog(enable=animation));
      input SI.Distance width=length "Width of shape (for \"spring\": spring diameter)" annotation(Dialog(enable=animation));
      input SI.Distance height=length "Height of shape (not used for \"spring\", \"grid\")" annotation(Dialog(enable=animation));
      input Modelica.Mechanics.MultiBody.Types.Color color={0,128,255} "Color of the object" annotation(Dialog(colorSelector, group="Material properties", enable=animation));
      input Boolean wireframe=false "=true 3D Model will be displayed without faces" annotation(Dialog(enable=animation, group="Material properties"), choices(checkBox=true));
      input Visualization.Shapes.Internal.Types.Transparency transparency=0 "Transparency of shape: 0 (= opaque) .. 1 (= fully transparent)" annotation(Dialog(enable=animation, group="Material properties"));
      input Boolean reflectsLight=false "True, if light reflections on the shape shell be enabled" annotation(Dialog(enable=animation, group="Material properties"), choices(checkBox=true));
      Visualization.Shapes.Internal.Types.Shininess shininess=0 "Shininess of shape: 0 (= full surface reflection) .. 1 (= point reflection)" annotation(Dialog(enable=animation and reflectsLight, group="Material properties"));
      parameter Real gearwheelRelativeInnerDiameter=1 "Ratio of inner/outer radius of gearwheel, proportional to radius of gearwheel (0..1)" annotation(Dialog(enable=shapeType == "gearwheel", group="Gearwheel", tab="Specific shape data"));
      parameter SI.Angle gearwheelAngle=0 "Angle for beveled gearwheels (0 = cylindrical gearwheel)" annotation(Dialog(enable=shapeType == "gearwheel", group="Gearwheel", tab="Specific shape data"));
      parameter Integer gearwheelTeeth=20 "Number of gearwheel teeth (negative teeth number for inner gearwheel)" annotation(Dialog(enable=shapeType == "gearwheel", group="Gearwheel", tab="Specific shape data"));
      parameter Real pipeRelativeInnerDiameter=0.9 "Inner diameter of pipe (0 = rigid, 1 = fully hollow)" annotation(Dialog(enable=shapeType == "pipe", group="Pipe", tab="Specific shape data"));
      parameter Real pipeRelativeTipDiameter=1 "Tip diameter of pipe relative to base diameter (0 = real cone, 1 = cylinder)" annotation(Dialog(enable=shapeType == "pipe", group="Pipe", tab="Specific shape data"));
      parameter Integer springWinding=5 "Winding number of the spring" annotation(Dialog(enable=shapeType == "spring", group="Spring", tab="Specific shape data"));
      parameter SI.Radius springRadius=0.02 "Radius of spring wire" annotation(Dialog(enable=shapeType == "spring", group="Spring", tab="Specific shape data"));
      parameter SI.Distance gridDistance=0.5 "Distance or grid points in x- and in y-direction" annotation(Dialog(enable=shapeType == "grid", group="Grid", tab="Specific shape data"));
      parameter Real coneRelativeTipDiameter=0 "Tip diameter relative to base diameter (0 = real cone, 1 = cylinder)" annotation(Dialog(enable=shapeType == "cone", group="Cone", tab="Specific shape data"));
      parameter Real coneRelativeInnerDiameter=0 "Inner diameter of the cone proportional to tip size (0..1)" annotation(Dialog(enable=shapeType == "cone", group="Cone", tab="Specific shape data"));
    protected 
      constant SI.Position unitPosition=1.0;
    protected 
      Visualization.Shapes.Internal.ElementaryShape elementaryShape(shapeType=shapeType, shininess=shininess, reflectsLight=if reflectsLight then 1 else 0, color=color, transparency=transparency, wireframe=wireframe, scale={length,width,height}, extra=if shapeType == "cone" then {coneRelativeTipDiameter,coneRelativeInnerDiameter,0} else if shapeType == "gearwheel" then {gearwheelRelativeInnerDiameter,gearwheelTeeth,SI.Conversions.to_deg(gearwheelAngle)} else if shapeType == "pipe" then {0,pipeRelativeInnerDiameter,pipeRelativeTipDiameter} else if shapeType == "grid" then {gridDistance,0,0} else if shapeType == "spring" then {springWinding,springRadius,0} else {0,0,0}) if displayVisualizers annotation(Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0)));
    equation 
      connect(fixedDisplacement.frame_b,elementaryShape.frame_a) annotation(Line(points={{-52,0},{-20,0}}, color={95,95,95}, thickness=0.5));
    end ElementaryShape;

  end Shapes;

  package Internal
    extends Utilities.Icons.BaseClassPackage;
    package Functions
      extends Visualization.Utilities.Icons.Package;
      annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
      function startVisualization
        input String IP;
        input String pathSimVis;
        input Integer iTcpPort;
        input Boolean synchronizeFrame;
        output Boolean y=true;

        external "C" StartSimVis(IP,pathSimVis,iTcpPort,synchronizeFrame) ;
        annotation(Include="
#ifndef SIMVIS
#define SIMVIS
 
//                                                            /|
// Copyright 2009                                          --/-/--
// _______________________________________________________/_/_/__/___
// Deutsches Zentrum für Luft- und Raumfahrt e.V.           |/ DLR
// Institut für Robotik und Mechatronik
 
 
#define VOID void
typedef char CHAR;
typedef short SHORT;
typedef long LONG;
typedef unsigned char   u_char;
typedef unsigned short  u_short;
typedef unsigned int    u_int;
typedef unsigned long   u_long;
typedef unsigned __int64 u_int64;
 
#include <winsock2.h> 
 
#include <tchar.h> 
  
#pragma comment( lib, \"ws2_32.lib\" )
 
#define ld int
#define lc float
#define lo char
#define l361 SOCKET
#define l374 FILE
#define l130 DWORD
#define l367 WSABUF
#define l415 WSAOVERLAPPED
#define ll struct
#define l411 HANDLE
#define l211 mutex
#define l95 volatile
#define l36 unsigned
#define l16 QueueWritePos
#define l22 QueueReadPos
#define l394 static
#define l61 const
#define l45 QueueSize
#define l79 typedef
#define l76 enum
#define l55 size_t
#define lj void
#define lq if
#define lk sizeof
#define l49 goto
#define ln for
#define l53 else
#define l0 malloc
#define l11 return
#define l65 free
#define l63 memcpy_s

#define l37 while
#define l56 Sleep
#define l384 CreateMutexA
#define l44 NULL
#define l408 false
#define l70 len
#define l80 buf
#define l375 WINAPI
#define l289 TcpThread
#define l410 LPVOID
#define l377 pthis
#define l370 true
#define l358 send
#define l396 continue
#define l109 fwrite
#define l398 STARTUPINFOW
#define l376 PROCESS_INFORMATION
#define l106 LPWSTR
#define l193 SOCKADDR_IN
#define l414 WSADATA
#define l43 linger
#define l164 strcpy
#define l355 fopen
#define l228 strcmp
#define l33 strlen
#define l371 sprintf
#define l124 memset
#define l404 cb
#define l329 MultiByteToWideChar
#define l230 CP_ACP
#define l188 OpenMutexA
#define l206 MUTEX_ALL_ACCESS
#define l416 CreateProcessW
#define l147 FALSE
#define l388 NORMAL_PRIORITY_CLASS
#define l392 MessageBox
#define l272 TEXT
#define l372 MB_OK
#define l390 MB_ICONWARNING
#define l346 WSAStartup
#define l340 MAKEWORD
#define l393 sin_family
#define l203 AF_INET
#define l356 sin_port
#define l344 htons
#define l380 sin_addr
#define l418 s_addr
#define l378 inet_addr
#define l195 setsockopt
#define l359 IPPROTO_TCP
#define l352 TCP_NODELAY
#define l360 socket
#define l417 SOCK_STREAM
#define l343 connect
#define l182 SOCKADDR
#define l365 l_onoff
#define l399 l_linger
#define l402 SOL_SOCKET
#define l397 SO_LINGER
#define l405 CreateThread
#define l379 WSARecv
#define l349 WSAGetOverlappedResult
#define l345 recv
#define l389 StartSimVis
#define l296 ip
#define l341 GetObjectID
#define l368 FreeObjectID
#define l363 closesocket
#define l338 WSACleanup
#define l409 SetTime
#define le double
#define l347 realloc
#define l366 SetBaseObject
#define lu type
#define l412 SetFlowObject2
#define l357 SetFileObject
#define l400 SetLightObject
#define l391 SetTextObject
#define l342 SetHUDObject
#define l369 SetWeatherObject
#define l413 SetCamera
#define l382 SetFlexibleBody
#define l353 SetFlexibleSurface
#define l364 SetLine
#define l403 SetParticleEffect
 
 
ld la;lc l90;lo l138[64];ld l86;l361 l14;l374*l59;l130 l85,l71;l367
l31;l415 l144;ld l58;ld l119;ld l75;ll ls*l38=0;ld l67=0;ld l395=0;
l411 l211;l95 l36 ld l16=0;l95 l36 ld l22=0;l394 l61 l36 ld l45=2000;
ll l20*l42[2000];ld l129=0;l79 l76 l77{l6,l4,l354,l385,l251,l15,l267,
l25,l57,l274,l215,l159,l66,l68,l41,l246,l82,l406,l348,l169,l168,l323,
l219,l151,l327,l154,l220,l294,l152,l279,l266,l295,l177,l121,l62,l101,
l264,l336,l419,l292,l157,l205,l194,l242,l126,l261,l210,l247,l170,l50,
l113,l225,l311,l265,l153,l286,l250,l234,l96,l98,l282,l176,l236,l309,
l179,l198,l301,l161,l256,l284,l307,l235,l278,l245,l133,l139,l248,l118
,l132,l226,l222,l221,l212,l208,l324,l229,l141,l108,l297,l189,l407,
l304,l277,l293,l351,l238,l333,l166,l383,l89};l79 ll l20{l55 lx;lo*lb;
};l79 ll l191{ld lv;l55 lx;l36 ld l2;lj*lb;};l79 ll ls{ll l191 li[l89
];};lj lf(ll ls*lh,l76 l77 lp,ld*lb,ld l10,ld l47){ld lv=0;ld la;lq(!
l47){lq(lh->li[lp].lx!=lk(ld)){lv=1;l49 l21;}ln(la=0;la<lh->li[lp].l2
;la++){lq(((ld* )lh->li[lp].lb)[la]!=lb[la]){lv=1;l49 l21;}}}l53 lv=1
;l21:lq(lv){ld*l12=(ld* )l0(lk(ld) *l10);lq(!l12)l11;ln(la=0;la<l10;
la++)l12[la]=lb[la];lh->li[lp].lv=1;lh->li[lp].lx=lk(ld);lh->li[lp].
l2=l10;l65(lh->li[lp].lb);lh->li[lp].lb=l12;}};lj lg(ll ls*lh,l76 l77
lp,lc*lb,ld l10,ld l47){ld lv=0;ld la;lq(!l47){lq(lh->li[lp].lx!=lk(
lc)){lv=1;l49 l21;}ln(la=0;la<lh->li[lp].l2;la++){lq(((lc* )lh->li[lp
].lb)[la]!=lb[la]){lv=1;l49 l21;}}}l53 lv=1;l21:lq(lv){lc*l12=(lc* )l0
(lk(lc) *l10);lq(!l12)l11;ln(la=0;la<l10;la++)l12[la]=lb[la];lh->li[
lp].lv=1;lh->li[lp].lx=lk(lc);lh->li[lp].l2=l10;l65(lh->li[lp].lb);lh
->li[lp].lb=l12;}};lj l32(ll ls*lh,l76 l77 lp,lo*lb,ld l10,ld l47){ld
lv=0;ld la;lq(!l47){lq(lh->li[lp].lx!=lk(lo)){lv=1;l49 l21;}ln(la=0;
la<lh->li[lp].l2;la++){lq(((lo* )lh->li[lp].lb)[la]!=lb[la]){lv=1;l49
l21;}}}l53 lv=1;l21:lq(lv){lo*l12=(lo* )l0(lk(lo) *l10);lq(!l12)l11;
ln(la=0;la<l10;la++)l12[la]=lb[la];lh->li[lp].lv=1;lh->li[lp].lx=lk(
lo);lh->li[lp].l2=l10;l65(lh->li[lp].lb);lh->li[lp].lb=l12;}};lj l92(
ll ls*lh){ln(la=0;la<l89;la++){lh->li[la].lb=0;lh->li[la].l2=0;lh->li
[la].lx=0;lh->li[la].lv=0;}}lo*l213(ll ls*lh,ld l123,l55*l27){l55 lw=
lk(lw);lo*l23=(lo* )l0(32*1024);( *l27)=32*1024;ln(la=0;la<l89;la++){
lq((lh->li[la].lb)&&(!l123||(l123&&lh->li[la].lv))){lh->li[la].lv=0;
l63(l23+lw,l27-lw,(lo* )&la,lk(la));lw+=lk(la);l63(l23+lw,l27-lw,(lo*
)&lh->li[la].l2,lk(lh->li[la].l2));lw+=lk(lh->li[la].l2);l63(l23+lw,
l27-lw,(lo* )&lh->li[la].lx,lk(lh->li[la].lx));lw+=lk(lh->li[la].lx);
l63(l23+lw,(lh->li[la].l2*lh->li[la].lx),(lo* )lh->li[la].lb,(lh->li[
la].l2*lh->li[la].lx));lw+=(lh->li[la].l2*lh->li[la].lx);}}( *l27)=lw
;lw-=lk(lw);l63(l23,lw,(lo* )&lw,lk(lw));l11 l23;}l61 l95 l36 lc l72(
){lq(l16>=l22)l11 l16-l22;l53 l11 l16+l45-l22;}ll l20*l314(){ll l20*
l23=l42[l22];ld l36 l51=(l22+1)%l45;l22=l51;l11 l23;}lj l160(ll l20*
lh){l36 ld l51=(l16+1)%l45;l37(l51==l22)l56(0);lq(l51!=l22||(lc)l72()/
(lc)l45>0.5){lq(l42[l16]){l65(l42[l16]->lb);l65(l42[l16]);}l42[l16]=
lh;l16=l51;}}lj l200(){l14=0;l58=0;l119=0;l59=0;l211=l384(l44,l408,\"\"
\"\\x4c\\x6f\\x63\\x61\\x6c\\D\\x4c\\x52\\x53\\x69\\x6d\\x56\\x69\\x73\\x43\\x6c\\x69\"
\"\\x65\\x6e\\x74\");l31.l70=lk(ld);l31.l80=(lo* )l0(lk(ld));}lj l350(){
l129=1;}lj l381(ld l34){l58=l34;}ld l339(){l11 l58;}lj*l283(){ld*l137
=(ld* )l0(lk(ld));( *l137)=l119++;l11 l137;}lj l239(lj*lm){l11;}l130
l375 l289(l410 l377){ll l20*lh;l37(l370){lq(l72()>0){lh=l314();l358(
l14,lh->lb,lh->lx,0);}l53{l56(0);l396;}}}lj l387(l61 lo*l258,ld l128,
lc l165){l109(&l128,lk(ld),1,l59);l109(&l165,lk(ld),1,l59);l109(l258,
lk(lo),l128,l59);}lj l273(l61 lo*l84,l61 lo*l140,ld l74,ld l328){lo
l125[1024];l398 l46;l376 l83;l106 l100[1024];l106 l143[256];ld l112;
l193 l48;l414 l331;ld l217=1;l55 l40;l130 l280;ld l337=1;ll l43 l43;
l164(l138,l84);l86=l74;l75=l328;lq(l58)l355(\"\\x73\\x69\\x6d\\x76\\x69\\x73\"
\"\\x2e\\x64\\x61\\x74\",\"\\x77\\x2b\\x62\");lq(l228(l84,\"\\x31\\x32\\x37\\x2e\\x30\"
\"\\x2e\\x30\\x2e\\x31\")==0||l228(l84,\"\\x6c\\x6f\\x63\\x61\\x6c\\x68\\x6f\\x73\"
\"\\x74\")==0){lo l35[256];l164(l35,l140);l40=l33(l35);l37(l40>0&&l35[
l40]!='/'&&l35[l40]!='\\\\')l40--;l35[l40]='\\0';l371(l125,\"\\x25\\x73\\x20\"
\"\\x2d\\x74\\x63\\x70\\x20\\x25\\x64\",l140,l86);l124(&l46,0,lk(l46));l124(&
l83,0,lk(l83));l46.l404=lk(l46);l329(l230,0,l125,-1,l100,1024);l329(
l230,0,l35,-1,l143,256);lq(!l188(l206,0,\"\\x4c\\x6f\\x63\\x61\\x6c\\\\\\x44\"
\"\\x4c\\x52\\x53\\x69\\x6d\\x56\\x69\\x73\"))lq(!l416(l44,(l106)l100,l44,l44,
l147,l388,l44,l143,&l46,&l83))l392(l44,l272(\"\\x45\\x72\\x72\\x6f\\x72\\x20\"
\"\\x73\\x74\\x61\\x72\\x74\\x69\\x6e\\x67\\x20\\x53\\x69\\x6d\\x56\\x69\\x73\\x2e\\x65\"
\"\\x78\\x65\\x20\\x6f\\x6e\\x20\\x6c\\x6f\\x63\\x61\\x6c\\x20\\x63\\x6f\\x6d\\x70\\x75\"
\"\\x74\\x65\\x72\"),l272(\"\\x45\\x72\\x72\\x6f\\x72\"),l372|l390);l37(!l188(
l206,0,\"\\x4c\\x6f\\x63\\x61\\x6c\\\\\\x44\\x4c\\x52\\x53\\x69\\x6d\\x56\\x69\\x73\"))l56
(100);}l112=l346(l340(2,0),&l331);l124(&l48,0,lk(l193));l48.l393=l203
;l48.l356=l344(l86);l48.l380.l418=l378(l138);l195(l112,l359,l352,(lo*
)&l217,lk(ld));l14=l360(l203,l417,0);l343(l14,(l182* )&l48,lk(l182));
l43.l365=1;l43.l399=5;l195(l14,l402,l397,&l43,lk(l43));l405(0,1024,
l289,0,0,&l280);l56(100);}lj l3(ll ls*lb){l55 l70;ll l20*l88=(ll l20*
)l0(lk(ll l20* ));l37(!l14)l56(1);lg(lb,l251,&l90,1,1);l85=0;l379(l14
,&l31,1,&l71,&l85,&l144,0);lq(l349(l14,&l144,&l71,l147,&l85)&&l71&& *
l31.l80==1)l37( *l31.l80==1)l345(l14,(lo* )l31.l80,l31.l70,0);l88->lb
=l213(lb,0,&l70);l88->lx=l70;l160(l88);}lj l389(lo*l296,lo*l335,ld l74
,ld l75){l38=(ll ls* )l0(lk(ll ls) *2);l92(l38);l67=1;l200();l273(
l296,l335,l74,l75);ln(la=0;la<l45;la++)l42[la]=0;}lj*l341(){l11 l283(
);}lj l368(lj*lm){l239(lm);lq(l129){l37(l72()>0)l56(0);l363(l14);l338
();}}lj l409(le l318){l90=(lc)l318;}ll ls*l5(ld lp){ld l39;lq(lp>=l67
){l38=(ll ls* )l347(l38,lk(ll ls) *lp*2);ln(l39=l67;l39<lp*2;l39++)l92
(&l38[l39]);l67=lp*2;}l11&l38[lp];}lj l366(lj*lm,ld l34,ld l196,le*ly
,le*lz,le*l18,ld*l17,ld l29,ld l28,le l30,le*l332,le l9){ll ls*lb;ld
lu=1001;lc l26;lc l300=1-(lc)l9;lc lr[3],lt[6],l1[3],l105[3];l26=(lc)l30
;ln(la=0;la<3;la++){lr[la]=(lc)ly[la];l1[la]=(lc)l18[la];l105[la]=(lc
)l332[la];}ln(la=0;la<6;la++){lt[la]=(lc)lz[la];}lb=l5( * (ld* )lm);
lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lf(lb,l274,&l196,1,0);lg(lb,
l15,lr,3,0);lg(lb,l25,lt,6,0);lg(lb,l57,l1,3,0);lf(lb,l50,l17,3,0);lf
(lb,l66,&l28,1,0);lg(lb,l68,&l26,1,0);lg(lb,l41,&l300,1,0);lg(lb,l246
,l105,3,0);lf(lb,l62,&l29,1,0);l3(lb);}lj l412(lj*lm,lj*l104,lj*l116,
le*l306,le*lz,le*l287,le*l214,le l27,le l148,le l223,le l298,le l288,
le l308,le l175,le l158,ld*l268,le l207,ld*l291,ld l227,ld l120,ld
l316,ld l224){ll ls*lb;ld lu=1006;lc l237=(lc)l27;lc l326=(lc)l148;lc
l330=(lc)l223;lc l317=(lc)l298;lc l325=(lc)l288;lc l281=(lc)l308;lc
l241=(lc)l175;lc l321=(lc)l158;lc l260=(lc)l207;ld l115;ld l145;lc l94
[3],lt[6],l91[3],l122[3];ln(la=0;la<3;la++){l94[la]=(lc)l306[la];l91[
la]=(lc)l287[la];l122[la]=(lc)l214[la];}ln(la=0;la<6;la++)lt[la]=(lc)lz
[la];lb=l5( * (ld* )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lg(
lb,l169,l94,3,0);lg(lb,l168,l91,3,0);lg(lb,l25,lt,6,0);lf(lb,l177,&
l227,1,0);lg(lb,l324,l122,3,0);lg(lb,l323,&l237,1,0);lg(lb,l219,&l326
,1,0);lg(lb,l151,&l330,1,0);lg(lb,l327,&l317,1,0);lg(lb,l154,&l325,1,
0);lg(lb,l220,&l281,1,0);lg(lb,l294,&l241,1,0);lg(lb,l297,&l321,1,0);
lg(lb,l279,&l260,1,0);lf(lb,l152,l268,3,0);lf(lb,l266,l291,3,0);lf(lb
,l295,&l316,1,0);lf(lb,l121,&l120,1,0);lq(!lb->li[l108].lb){l115=(
l104)? * (ld* )l104:-1;lf(lb,l108,&l115,1,0);}lq(!lb->li[l141].lb){
l145=(l116)? * (ld* )l116:-1;lf(lb,l141,&l145,1,0);}lf(lb,l229,&l224,
1,0);lf(lb,l121,&l120,1,0);l3(lb);}lj l357(lj*lm,ld l34,le*ly,le*lz,
le*l18,ld l28,le l30,le l9,ld l29,ld l373,lo*l24,ld l183){ll ls*lb;ld
lu=1002;lc l26=(lc)l30;lc l19=1-(lc)l9;lc lr[3],lt[6],l1[3];ln(la=0;
la<3;la++){lr[la]=(lc)ly[la];l1[la]=(lc)l18[la];}ln(la=0;la<6;la++)lt
[la]=(lc)lz[la];lb=l5( * (ld* )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&
lu,1,1);lg(lb,l15,lr,3,0);lg(lb,l25,lt,6,0);lg(lb,l57,l1,3,0);lf(lb,
l66,&l28,1,0);lg(lb,l68,&l26,1,0);lg(lb,l41,&l19,1,0);lf(lb,l62,&l29,
1,0);l32(lb,l82,l24,l33(l24),0);lf(lb,l189,&l183,1,0);l3(lb);}lj l400
(lj*lm,ld l34,le*ly,le*lz,le l156,ld l192,ld*l276,ld*l180,ld*l302,le
l155,le l322,le l163){ll ls*lb;ld lu=1003;lc l178=(lc)l156;lc l312=(
lc)l155;lc l255=(lc)l322;lc l285=(lc)l163;lc lr[3],lt[6];ln(la=0;la<3
;la++){lr[la]=(lc)ly[la];}ln(la=0;la<6;la++)lt[la]=(lc)lz[la];lb=l5( *
(ld* )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lf(lb,l101,&l34,1,
0);lg(lb,l15,lr,3,0);lg(lb,l25,lt,6,0);lg(lb,l264,&l178,1,0);lf(lb,
l336,&l192,1,0);lf(lb,l215,l276,3,0);lf(lb,l292,l180,3,0);lf(lb,l159,
l302,3,0);lg(lb,l157,&l312,1,0);lg(lb,l205,&l255,1,0);lg(lb,l194,&
l285,1,0);l3(lb);}lj l391(lj*lm,ld l254,lo*l52,le l243,ld l181,le*ly,
le*lz,le l334,lo*l102,ld*l17,le l9){ll ls*lb;ld lu=1004;lc l19=1-(lc)l9
;lc l263=(lc)l243;lc l240=(lc)l334;lc lr[3],lt[6];ln(la=0;la<3;la++)lr
[la]=(lc)ly[la];ln(la=0;la<6;la++)lt[la]=(lc)lz[la];lb=l5( * (ld* )lm
);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lg(lb,l15,lr,3,0);lg(lb,
l25,lt,6,0);lf(lb,l50,l17,3,0);lg(lb,l41,&l19,1,0);lf(lb,l242,&l254,1
,0);l32(lb,l126,l52,l33(l52),0);l32(lb,l170,l102,l33(l102),0);lg(lb,
l261,&l263,1,0);lf(lb,l210,&l181,1,0);lg(lb,l247,&l240,1,0);l3(lb);}
lj l342(lj*lm,le*ly,le l233,lo*l24,ld l257,le*lx,le l231,lo*l52,ld*
l290,le l259,ld l8,le*l162){ll ls*lb;ld lu=1007;lc l174=(lc)l233;lc
l269=(lc)l231;lc l401=(lc)l259;lc lr[3],l107[2];lc*l146=(lc* )l0(2*l8
 *lk(lc));ln(la=0;la<2;la++)l107[la]=(lc)lx[la];ln(la=0;la<3;la++)lr[
la]=(lc)ly[la];ln(la=0;la<l8*2;la++)l146[la]=(lc)l162[la];lb=l5( * (
ld* )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lg(lb,l15,lr,3,0);
lg(lb,l267,&l174,1,0);l32(lb,l82,l24,l33(l24),0);lf(lb,l113,&l257,1,0
);lg(lb,l225,&l107,2,0);lg(lb,l311,&l269,1,0);l32(lb,l126,l52,l33(l52
),0);lf(lb,l132,&l8,1,0);lg(lb,l133,l146,l8*2,0);lf(lb,l265,l290,3,0);
l3(lb);}lj l369(lj*lm,ld l253,le l249,le l187,ld l209,le l81,le*l69,
ld*l17){ll ls*lb;ld lu=1008;lc l271=(lc)l249;lc l150=(lc)l187;lc l78=
(lc)l81;lc l60[3];ln(la=0;la<3;la++){l60[la]=(lc)l69[la];}lb=l5( * (
ld* )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lf(lb,l153,&l253,1,
0);lg(lb,l286,&l271,1,0);lg(lb,l250,&l150,1,0);lg(lb,l96,&l78,1,0);lf
(lb,l234,&l209,1,0);lf(lb,l98,l69,3,0);lf(lb,l50,l17,3,0);l3(lb);}lj
l413(lj*l127,ld l184,le*l167,le*l299,le*l303,le*l173,le*l218,ld l204,
ld l244,ld*l319,le l186,le l190,ld l202,ld l171,le*l305){ll ls*lb;ld
lu=2000;lc l262=(lc)l186;lc l275=(lc)l190;lc l111[3],l103[3],l117[3],
l110[3];lc l93[2],l131[2];ln(la=0;la<3;la++){l111[la]=(lc)l167[la];
l103[la]=(lc)l299[la];l117[la]=(lc)l303[la];l110[la]=(lc)l305[la];}ln
(la=0;la<2;la++){l93[la]=(lc)l173[la];l131[la]=(lc)l218[la];}lb=l5( *
(ld* )l127);lf(lb,l6,(ld* )l127,1,1);lf(lb,l4,&lu,1,1);lf(lb,l282,&
l184,1,0);lg(lb,l176,&l111,3,0);lg(lb,l236,&l103,3,0);lg(lb,l309,&
l117,3,0);lg(lb,l179,&l93,2,0);lg(lb,l198,&l131,2,0);lf(lb,l301,&l204
,1,0);lf(lb,l161,&l244,1,0);lf(lb,l256,l319,3,0);lg(lb,l284,&l262,1,0
);lg(lb,l307,&l275,1,0);lf(lb,l235,&l202,1,0);lf(lb,l278,&l171,1,0);
lg(lb,l245,&l110,3,0);l3(lb);}lj l382(lj*lm,ld l34,le*ly,le*lz,le*l18
,ld l28,le l30,le l9,ld l29,ld l201,lo*l24,ld l8,le*l39,le*l185){ll ls
 *lb;ld lu=1010;lc l19=1-(lc)l9;lc l26=(lc)l30;lc lr[3],lt[6],l1[3];
lc*l134=(lc* )l0(l8*3*lk(lc));lc*l142=(lc* )l0(l8*3*lk(lc));;ln(la=0;
la<3;la++){lr[la]=(lc)ly[la];l1[la]=(lc)l18[la];}ln(la=0;la<6;la++)lt
[la]=(lc)lz[la];ln(la=0;la<3*l8;la++){l142[la]=(lc)l185[la];l134[la]=
(lc)l39[la];}lb=l5( * (ld* )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1
,1);lg(lb,l15,lr,3,0);lg(lb,l25,lt,6,0);lg(lb,l57,l1,3,0);lf(lb,l66,&
l28,1,0);lg(lb,l68,&l26,1,0);lg(lb,l41,&l19,1,0);lf(lb,l101,&l34,1,0);
lf(lb,l62,&l29,1,0);lf(lb,l226,&l201,1,0);l32(lb,l82,l24,l33(l24),0);
lf(lb,l132,&l8,1,0);lg(lb,l118,l134,3*l8,0);lg(lb,l139,l142,3*l8,0);
l3(lb);}lj l353(lj*lm,le*ly,le*lz,le*l18,ld l28,le l30,le l9,ld l29,
ld l13,ld l7,le*l270,le*l320,le*l197,ld*l17,ld l232,lo*l99,ld l97,ld*
l87){ll ls*lb;ld l73;ld lu=1009;lc l19=1-(lc)l9;lc l26=(lc)l30;lc lr[
3],lt[6],l1[3],l386[3];lc*l136=(lc* )l0(l13*l7*lk(lc));lc*l135=(lc* )l0
(l13*l7*lk(lc));lc*l114=(lc* )l0(l13*l7*lk(lc));ld*l54=(ld* )l0(l13*
l7*lk(ld));ln(la=0;la<3;la++){lr[la]=(lc)ly[la];l1[la]=(lc)l18[la];}
ln(la=0;la<6;la++)lt[la]=(lc)lz[la];ln(la=0;la<l13*l7;la++){l136[la]=
(lc)l270[la];l135[la]=(lc)l320[la];l114[la]=(lc)l197[la];}lb=l5( * (
ld* )lm);lq(l97){ln(la=0;la<l13*l7;la++){l54[la]=l87[la*3+0] *1000000
;l54[la]+=l87[la*3+1] *1000;l54[la]+=l87[la*3+2];}l73=l13*l7;}l53{l54
[0]=0;l73=1;}lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lg(lb,l15,lr,3,
0);lg(lb,l25,lt,6,0);lg(lb,l57,l1,3,0);lf(lb,l66,&l28,1,0);lg(lb,l68,
&l26,1,0);lg(lb,l41,&l19,1,0);lf(lb,l62,&l29,1,0);lf(lb,l221,&l232,1,
0);lf(lb,l212,&l13,1,0);lf(lb,l208,&l7,1,0);lf(lb,l50,l17,3,0);l32(lb
,l222,l99,l33(l99),0);lg(lb,l133,l136,l13*l7,0);lg(lb,l139,l135,l13*
l7,0);lg(lb,l248,l114,l13*l7,0);lf(lb,l113,&l97,1,0);lf(lb,l118,l54,
l73,0);l3(lb);}lj l364(lj*lm,ld l64,le*ly,le l310,ld*l17,le l9,ld l313
,le l362){ll ls*lb;ld lu=1011;lc l19=1-(lc)l9;lc l216=(lc)l310;lc*lr=
(lc* )l0(3*l64*lk(lc));ln(la=0;la<3*l64;la++)lr[la]=(lc)ly[la];lb=l5(
 * (ld* )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lg(lb,l15,lr,3*
l64,0);lf(lb,l304,&l64,1,0);lg(lb,l277,&l216,1,0);lf(lb,l50,l17,3,0);
lg(lb,l41,&l19,1,0);lf(lb,l293,&l313,1,0);l3(lb);}lj l403(lj*lm,le*ly
,le*lz,le*l18,le l81,ld l199,le l252,le l149,le*l69){ll ls*lb;ld lu=
1012;lc l78=(lc)l81;lc l172=(lc)l252;lc l315=(lc)l149;lc lr[3],l1[3],
l60[3],lt[6];ln(la=0;la<3;la++){lr[la]=(lc)ly[la];l1[la]=(lc)l18[la];
l60[la]=(lc)l69[la];}ln(la=0;la<6;la++)lt[la]=(lc)lz[la];lb=l5( * (ld
 * )lm);lf(lb,l6,(ld* )lm,1,1);lf(lb,l4,&lu,1,1);lg(lb,l15,lr,3,0);lg
(lb,l25,lt,6,0);lg(lb,l57,l1,3,0);lg(lb,l96,&l78,1,0);lg(lb,l166,&
l172,1,0);lg(lb,l333,&l315,1,0);lf(lb,l238,&l199,1,1);lg(lb,l98,l60,3
,0);l3(lb);}
 
#endif 
 
", Documentation(info="
"));
      end startVisualization;

      function setTime
        input Real t;
        output Boolean y=true;

        external "C" SetTime(t) ;

      end setTime;

    end Functions;

    model ZeroForcesAndTorques "Zero forces and torques acting on frame_b"
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_b;
      annotation(Documentation(info="<html>
<p>
This force element returns zero force and torque vector acting on frame_b. The kinematics of frame_b is <b>not</b> defined here.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(extent={{-150,140},{150,100}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="%name"),Polygon(points={{-100,10},{50,10},{50,31},{94,0},{50,-31},{50,-10},{-100,-10},{-100,10}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Line(points={{-98,14},{-92,27},{-84,42},{-72,62},{-63,74},{-50,86},{-33,95},{-20,98},{-6,98},{9,94},{21,87},{34,79},{46,69},{54,61},{60,54}}, color={0,0,0}, thickness=0.5),Polygon(points={{99,21},{74,80},{40,45},{99,21}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Text(extent={{-60,-46},{58,-84}}, lineColor={95,95,95}, textString="zeros")}));
    equation 
      frame_b.f=zeros(3);
      frame_b.t=zeros(3);
    end ZeroForcesAndTorques;

    model VisualizationControl "controls the Visualisation startup and triggering"
      parameter Real VisUpdateInterval=0.01;
      parameter Boolean animateExtern=true "= true, if external animation shall be enabled";
      parameter Boolean synchronizeFrame=false " = true, all data of a timestep are sended at once";
      parameter String ipAddress="127.0.0.1" "IP-Adress of rendering engine (e.g. SimVis)" annotation(Dialog(enable=animateExtern));
      parameter Integer iTcpPort=11000 "TCP port number for transmitting initial data to SimVis" annotation(Dialog(enable=animateExtern));
    protected 
      Boolean sampling(start=false, fixed=true);
      parameter String SimVisExe=Visualization.Utilities.RootDir + "/Extras/SimVis/SimVis.exe";
      Boolean y,y2;
    public 
      Modelica.Blocks.Interfaces.BooleanOutput send "True, if visualization object shall send the data" annotation(Placement(transformation(extent={{100,-10},{120,10}})));
    equation 
      sampling=sample(0, VisUpdateInterval);
      send=if animateExtern then edge(sampling) else false;
      when initial() and animateExtern then
        y=Visualization.Internal.Functions.startVisualization(ipAddress, SimVisExe, iTcpPort, synchronizeFrame);
      end when;
      when sampling and animateExtern then
        y2=Visualization.Internal.Functions.setTime(time);
      end when;
      annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(extent={{-100,100},{100,-100}}, lineColor={0,0,255}, textString="VC")}));
    end VisualizationControl;

    class VisShapeID
      extends ExternalObject;
      function constructor
        output VisShapeID ObjectID;

        external "C" ObjectID=GetObjectID() ;

      end constructor;

      function destructor
        input VisShapeID ObjectID;

        external "C" FreeObjectID(ObjectID) ;

      end destructor;

    end VisShapeID;

    package Types
      extends Visualization.Utilities.Icons.Package;
      type RotationTypes= enumeration(RotationAxis "Rotating frame_a around an angle with a fixed axis", TwoAxesVectors "Resolve two vectors of shape frame in frame_a", PlanarRotationSequence "Planar rotation sequence", TransformationMatrix "Relative transformation matrix") "Enumeration defining in which way the fixed orientation of the shape frame with respect to frame_a is specified" annotation(Evaluate=true, Documentation(info="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.RotationTypes.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">RotationAxis</td>
    <td valign=\"top\">The shape frame is defined by rotating frame_a along
        an axis fixed in frame_a and with a fixed angle.</td></tr>
 
<tr><td valign=\"top\">TwoAxesVectors</td>
    <td valign=\"top\">The shape frame is defined by resolving two vectors of the shape frame in frame_a.</td></tr>
 
<tr><td valign=\"top\">PlanarRotationSequence</td>
    <td valign=\"top\">The shape frame is defined by rotating frame_a along
        3 consecutive axes vectors with fixed rotation angles
        (e.g. Cardan or Euler angle sequence rotation).</td></tr>
 
<tr><td valign=\"top\">TransformationMatrix</td>
    <td valign=\"top\">The shape frame is defined by a relative
        transformation matrix T such that vec_s = T*vec_a, if
        vec_a is a vector resolved in frame_a and vec_s is a vector
        resolved in the shape frame.</td>
 
</table>
 
</html>"));
      annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
    end Types;

    partial model Frame_to_SimVis "an partial model defining a frame and the objects position and orientation data"
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
    protected 
      Real T[6] "Orientation of the Object, the first two rows of the Orientation matrix";
      Real pos[3] "Position of the Object";
    equation 
      frame_a.t=zeros(3);
      frame_a.f=zeros(3);
      pos=frame_a.r_0;
      T=vector([frame_a.R.T[1:3,1];frame_a.R.T[1:3,2]]);
    end Frame_to_SimVis;

    model DynamicRotation "Dynamic translation followed by a fixed rotation of frame_b with respect to frame_a"
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types;
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a "Coordinate system fixed to the component with one cut-force and cut-torque" annotation(Placement(transformation(extent={{-116,-16},{-84,16}}, rotation=0)));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b "Coordinate system fixed to the component with one cut-force and cut-torque" annotation(Placement(transformation(extent={{84,-16},{116,16}}, rotation=0)));
      parameter Boolean animation=true "= true, if animation shall be enabled";
      input SI.Position r[3]={0,0,0} "Vector from frame_a to frame_b resolved in frame_a" annotation(Dialog=true);
      parameter Visualization.Internal.Types.RotationTypes rotationType=Visualization.Internal.Types.RotationTypes.TwoAxesVectors "Type of rotation description" annotation(Evaluate=true);
      input Types.Axis n={1,0,0} "Axis of rotation in frame_a (= same as in frame_b)" annotation(Evaluate=true, Dialog(group="if rotationType = RotationAxis", enable=rotationType == Visualization.Internal.Types.RotationTypes.RotationAxis));
      input Cv.NonSIunits.Angle_deg angle=0 "Angle to rotate frame_a around axis n into frame_b" annotation(Dialog(group="if rotationType = RotationAxis", enable=rotationType == Visualization.Internal.Types.RotationTypes.RotationAxis));
      input Types.Axis n_x={1,0,0} "Vector along x-axis of frame_b resolved in frame_a" annotation(Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", enable=rotationType == Visualization.Internal.Types.RotationTypes.TwoAxesVectors));
      input Types.Axis n_y={0,1,0} "Vector along y-axis of frame_b resolved in frame_a" annotation(Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", enable=rotationType == Visualization.Internal.Types.RotationTypes.TwoAxesVectors));
      parameter Types.RotationSequence sequence(min={1,1,1}, max={3,3,3})={1,2,3} " Sequence of rotations" annotation(Evaluate=true, Dialog(group="if rotationType = PlanarRotationSequence", enable=rotationType == Visualization.Internal.Types.RotationTypes.PlanarRotationSequence));
      input Cv.NonSIunits.Angle_deg angles[3]={0,0,0} "Rotation angles around the axes defined in 'sequence'" annotation(Dialog(group="if rotationType = PlanarRotationSequence", enable=rotationType == Visualization.Internal.Types.RotationTypes.PlanarRotationSequence));
      input Real T[3,3]=diagonal(ones(3)) "Relative transformation matrix between frame_a and frame_b" annotation(Evaluate=true, Dialog(group="if rotationType = TransformationMatrix", enable=rotationType == Visualization.Internal.Types.RotationTypes.TransformationMatrix));
      final input Frames.Orientation R_rel=if rotationType == 1 then Frames.planarRotation(Modelica.Math.Vectors.normalize(n), Cv.from_deg(angle), 0) else if rotationType == 2 then Frames.from_nxy(n_x, n_y) else if rotationType == 3 then Frames.axesRotations(sequence, Cv.from_deg(angles), zeros(3)) else Frames.from_T(T, {0,0,0}) "Fixed rotation object from frame_a to frame_b";
    protected 
      outer Modelica.Mechanics.MultiBody.World world;
      input Frames.Orientation R_rel_inv=Frames.from_T(transpose(R_rel.T), zeros(3)) "Inverse of R_rel (rotate from frame_b to frame_a)";
      annotation(Documentation(info="<HTML>
<p>
Component for a <b>fixed translation</b> and <b>fixed rotation</b> of frame_b with respect
to frame_a, i.e., the relationship between connectors frame_a and frame_b
remains constant. There are several possibilities to define the
orientation of frame_b with respect to frame_a:
</p>
<ul>
<li><b>Planar rotation</b> along axis 'n' (that is fixed and resolved
    in frame_a) with a fixed angle 'angle'.</li>
<li><b>Vectors n_x</b> and <b>n_y</b> that are directed along the corresponding axes
    direction of frame_b and are resolved in frame_a (if n_y is not
    orthogonal to n_x, the y-axis of frame_b is selected such that it is
    orthogonal to n_x and in the plane of n_x and n_y).</li>
<li><b>Sequence</b> of <b>three planar axes rotations</b>.
    For example, \"sequence = {1,2,3}\" and \"angles = {90, 45, -90}\"
    means to rotate frame_a around the x axis with 90 degrees, around the new
    y axis with 45 degrees and around the new z axis around -90 degrees to
    arrive at frame_b. Note, that sequence={1,2,3}
    is the Cardan angle sequence and sequence = {3,1,3} is the Euler angle
    sequence.</li>
</ul>
<p>
By default, this component is visualized by a cylinder connecting
frame_a and frame_b, as shown in the figure below. In this figure
frame_b is rotated along the z-axis of frame_a with 60 degree. Note, that the
two visualized frames are not part of the component animation and that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/MultiBody/FixedRotation.png\" ALT=\"Parts.FixedRotation\">
</HTML>", revisions="<HTML><p><b>Release Notes:</b></p>
<ul>
  <li><i>July 28, 2003</i><br>
         Bug fixed: if rotationType = PlanarRotationSequence, then 'angles'
         was used with unit [rad] instead of [deg].</li>
</ul>
</HTML>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}, grid={1,1}), graphics={Text(extent={{-136,79},{132,139}}, textString="%name", lineColor={0,0,255}),Rectangle(extent={{-100,5},{100,-4}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Line(points={{80,20},{129,50}}, color={0,0,0}),Line(points={{80,20},{57,59}}, color={0,0,0}),Polygon(points={{144,60},{117,59},{132,37},{144,60}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Polygon(points={{43,80},{46,50},{68,65},{43,80}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Text(extent={{-144,-52},{143,-89}}, lineColor={0,0,0}, textString="r=%r"),Text(extent={{-117,51},{-81,26}}, lineColor={128,128,128}, textString="a"),Text(extent={{84,-24},{120,-49}}, lineColor={128,128,128}, textString="b")}), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}, grid={1,1}), graphics={Line(points={{-100,-1},{-100,-66}}, color={128,128,128}),Line(points={{100,0},{100,-65}}, color={128,128,128}),Line(points={{-100,-60},{89,-60}}, color={128,128,128}),Text(extent={{-22,-36},{16,-60}}, lineColor={128,128,128}, textString="r"),Rectangle(extent={{-100,5},{100,-5}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Line(points={{69,29},{97,45}}, color={128,128,128}, arrow={Arrow.None,Arrow.Filled}),Line(points={{70,27},{55,54}}, color={128,128,128}, arrow={Arrow.None,Arrow.Filled}),Text(extent={{95,42},{109,31}}, lineColor={128,128,128}, textString="x"),Text(extent={{42,70},{57,58}}, lineColor={128,128,128}, textString="y"),Line(points={{-95,22},{-58,22}}, color={128,128,128}, arrow={Arrow.None,Arrow.Filled}),Line(points={{-94,20},{-94,52}}, color={128,128,128}, arrow={Arrow.None,Arrow.Filled}),Text(extent={{-72,37},{-58,26}}, lineColor={128,128,128}, textString="x"),Text(extent={{-113,59},{-98,47}}, lineColor={128,128,128}, textString="y"),Polygon(points={{88,-56},{88,-65},{100,-60},{88,-56}}, lineColor={0,0,0}, fillColor={0,0,0}, fillPattern=FillPattern.Solid)}));
    equation 
      Connections.branch(frame_a.R, frame_b.R);
      assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0, "Neither connector frame_a nor frame_b of FixedRotation object is connected");
      frame_b.r_0=frame_a.r_0 + Frames.resolve1(frame_a.R, r);
      if rooted(frame_a.R) then
        frame_b.R=Frames.absoluteRotation(frame_a.R, R_rel);
        zeros(3)=frame_a.f + Frames.resolve1(R_rel, frame_b.f);
        zeros(3)=frame_a.t + Frames.resolve1(R_rel, frame_b.t) - cross(r, frame_a.f);
      else
        frame_a.R=Frames.absoluteRotation(frame_b.R, R_rel_inv);
        zeros(3)=frame_b.f + Frames.resolve1(R_rel_inv, frame_a.f);
        zeros(3)=frame_b.t + Frames.resolve1(R_rel_inv, frame_a.t) + cross(Frames.resolve1(R_rel_inv, r), frame_b.f);
      end if;
    end DynamicRotation;

    partial model AnimationDefinition "A partial block including the boolean variable animateVisObject and the parameters animation and animatationExtern "
      parameter Boolean animation=true "= true, if animation of component is enabled";
      final parameter Boolean displayVisualizers=animation and updateVisualization.animateExtern and updateVisualization.displayVisualizers;
      final parameter Boolean displayFlowElements=animation and updateVisualization.animateExtern and updateVisualization.displayFlowElements;
      final parameter Boolean displayHUDElements=animation and updateVisualization.animateExtern and updateVisualization.displayHUDElements;
      final parameter Boolean displayEffects=animation and updateVisualization.animateExtern and updateVisualization.displayEffects;
      final parameter Boolean enableLights=animation and updateVisualization.animateExtern and updateVisualization.enableLights;
      final parameter Boolean enableCameras=animation and updateVisualization.animateExtern and updateVisualization.enableCameras;
    protected 
      outer Visualization.UpdateVisualization updateVisualization;
      annotation(Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={Rectangle(visible=not animation, extent={{-100,100},{100,-100}}, fillColor={255,255,255}, fillPattern=FillPattern.Backward, pattern=LinePattern.Dash, lineColor={175,175,175}),Text(visible=not animation, extent={{-100,-112},{100,-136}}, lineColor={135,135,135}, pattern=LinePattern.Dash, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="Deactivated")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    end AnimationDefinition;

  end Internal;

  package Examples "Collection of example models demonstrating the usage of the visualization components"
    annotation(Protection(allowDuplicate=true, showDiagram=true, showText=true), preferedView="info", classOrder={"*","BaseClasses","Internal"}, Documentation(info="<html>
<p>
This package is a collection of simulatable models enabling external animation of simulation results. 
</p>
</html>"));
    extends Utilities.Icons.ExamplesPackage;
    package Effects "Examples demonstrating how to implement effects like rain, fog, snow"
      extends Visualization.Utilities.Icons.ExamplesPackage;
      annotation(preferedView="info", Documentation(info="<html>
 
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
      model ParticleEffect "Smoking plate"
        extends Visualization.Utilities.Icons.ExecutableModel;
        annotation(Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics), experiment(StopTime=10, Interval=0.001), Documentation(info="<html>
<p>
This example shows a plate generating a smoke effect.
</p> 
<blockquote>
<img src=\"../Extras/Images/Examples/ParticleEffect.png\">
</blockquote>
</html>"), experimentSetupOutput(states=false, derivatives=false, inputs=false, outputs=false, auxiliaries=false));
        inner Modelica.Mechanics.MultiBody.World world(n={0,0,-1}, axisLength=1) annotation(Placement(visible=true, transformation(origin={0.0,0.0}, extent={{-80.0,-10.0},{-60.0,10.0}}, rotation=0)));
        Visualization.Shapes.ElementaryShape shape(height=0.001) annotation(Placement(transformation(extent={{20,-10},{40,10}}, rotation=0)));
        Visualization.Effects.ParticleEffect particleEffect annotation(Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
        Cameras.FreeCamera camera(startDistanceToCenter={2,2,2}, backgroundColor={0,0,200}) annotation(Placement(transformation(extent={{-80,-40},{-60,-20}})));
        inner Visualization.UpdateVisualization updateVisualization annotation(Placement(visible=true, transformation(origin={-70.0,43.1523}, extent={{-10.0,-10.0},{10.0,10.0}}, rotation=0)));
      equation 
        connect(camera.frame_b,world.frame_b) annotation(Line(visible=true, points={{-60.0,-30.0},{-50.0,-30.0},{-50.0,0.0},{-60.0,0.0}}, color={95,95,95}, thickness=0.5));
        connect(particleEffect.frame_a,world.frame_b) annotation(Line(visible=true, points={{20.0,30.0},{0.0,30.0},{0.0,0.0},{-60.0,0.0}}, color={95,95,95}, thickness=0.5));
        connect(world.frame_b,shape.frame_a) annotation(Line(visible=true, origin={-20.0,0.0}, points={{-40.0,0.0},{40.0,0.0}}, color={95,95,95}, thickness=0.5));
      end ParticleEffect;

    end Effects;

  end Examples;

  package Effects "Collection of particle effects like smoke, fire, rain, fog, snow"
    annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Line(points={{46,100},{-22,22},{14,-2},{-22,-20},{-18,-42},{-20,-44},{-78,-100}}, color={159,159,0}),Line(points={{2,-8},{14,-28},{10,-42},{40,-52},{48,-86},{58,-100}}, color={159,159,0}),Line(points={{44,-70},{26,-80},{8,-100}}, color={159,159,0})}));
    package Internal "Collection of base classes involving visualization shapes"
      extends Utilities.Icons.BaseClassPackage;
      annotation(Protection(showDiagram=true), preferedView="info", Documentation(info="<html>
<p>
A collection of base classes to be used for different types of visualization shapes.
</p>
 
<placeholder to comply minimal number of characters for documentation>
 
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=60></td>
      <td valign=\"center\"> <b>Copyright &copy; 2006-2008, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
      package Types
        annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
        type ParticleEffectType= enumeration(Smoke "Smoke", Fire "Fire") "Enumeration defining the visualized water effect";
      end Types;

      package Functions
        annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
        function setParticleEffect
          input Visualization.Internal.VisShapeID ID;
          input Real pos[3];
          input Real T[6];
          input Real scale[3];
          input Real intensity;
          input Integer effectType;
          input Real particleSize;
          input Real particleLifeTime;
          input Real wind[3];
          output Boolean y=true;

          external "C" SetParticleEffect(ID,pos,T,scale,intensity,effectType,particleSize,particleLifeTime,wind) ;

        end setParticleEffect;

      end Functions;

      model ParticleEffect "Shape block for external visualisation"
        extends Visualization.Internal.Frame_to_SimVis;
        annotation(Dialog=true, Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={95,95,95}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Text(extent={{-150,80},{150,40}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="%name"),Text(extent={{-100,-40},{100,-80}}, lineColor={135,135,135}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="ParticleEffect")}));
        input Real scale[3]={1,1,1} "Scale factor in x, y and z direction" annotation(Dialog=true);
        input Real intensity=0 "intensity of particle effect" annotation(Dialog=true);
        parameter Integer effectType=0 "effect type";
        input Real particleSize=1 "size of the particles" annotation(Dialog=true);
        input Real particleLifeTime=1 "lifetime of the particles" annotation(Dialog=true);
        input Real wind[3]={0,0,0} "wind effecting the particles" annotation(Dialog=true);
      protected 
        outer Visualization.UpdateVisualization updateVisualization "Determine time instant for storing/sending data";
        Visualization.Internal.VisShapeID ObjectID=Visualization.Internal.VisShapeID();
        Boolean y;
      equation 
        if updateVisualization.send then
          y=Visualization.Effects.Internal.Functions.setParticleEffect(ObjectID, pos, T, scale, intensity, effectType, particleSize, particleLifeTime, wind);
        else
          y=false;
        end if;
      end ParticleEffect;

      partial model PartialEffect "Base class for an effect model"
        import MBSTypes = Modelica.Mechanics.MultiBody.Types;
        extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
        extends Visualization.Internal.AnimationDefinition;
        import SI = Modelica.SIunits;
        import Cv = Modelica.SIunits.Conversions;
        parameter SI.Position r_shape[3]={0,0,0} "Vector from frame_a to shape origin resolved in frame_a" annotation(Dialog(tab="Shape frame", group="Definition of shape frame with respect to frame_a"));
        parameter Visualization.Internal.Types.RotationTypes rotationType=Visualization.Internal.Types.RotationTypes.TwoAxesVectors "Type of rotation description (to rotate frame_a to shape frame)" annotation(Evaluate=true, Dialog(tab="Shape frame", group="Definition of shape frame with respect to frame_a"));
        input MBSTypes.Axis axis={1,0,0} "Axis of rotation in frame_a" annotation(Evaluate=true, Dialog(group="if rotationType = RotationAxis", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.RotationAxis));
        input Cv.NonSIunits.Angle_deg angle=0 "Angle to rotate shape around axis n" annotation(Dialog(group="if rotationType = RotationAxis", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.RotationAxis));
        input MBSTypes.Axis lengthDirection={1,0,0} "Vector along length direction (x-axis) of shape resolved in frame_a" annotation(Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.TwoAxesVectors));
        input MBSTypes.Axis widthDirection={0,1,0} "Vector along height direction (y-axis) of shape resolved in frame_a " annotation(Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.TwoAxesVectors));
        parameter MBSTypes.RotationSequence sequence(min={1,1,1}, max={3,3,3})={1,2,3} "Sequence of rotations" annotation(Evaluate=true, Dialog(group="if rotationType = PlanarRotationSequence", tab="Shape frame", enable=rotationType == Types.RotationTypes.PlanarRotationSequence));
        input Cv.NonSIunits.Angle_deg angles[3]={0,0,0} "Rotation angles around the axes defined in 'sequence'" annotation(Dialog(group="if rotationType = PlanarRotationSequence", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.PlanarRotationSequence));
        input Real T[3,3]=diagonal(ones(3)) "Transformation matrix from frame_a to shape frame (vec_s=T*vec_a)" annotation(Evaluate=true, Dialog(group="if rotationType = TransformationMatrix", tab="Shape frame", enable=rotationType == Visualization.Internal.Types.RotationTypes.TransformationMatrix));
        annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(extent={{-150,140},{150,100}}, textString="%name", lineColor={0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-80,80},{62,-40}}, lineColor={95,95,95}, pattern=LinePattern.Dash, fillColor={225,225,225}, fillPattern=FillPattern.Solid),Text(extent={{-22,-28},{50,-38}}, lineColor={0,127,0}, pattern=LinePattern.Dash, fillColor={215,215,215}, fillPattern=FillPattern.Solid, textString="if displayEffects = true"),Rectangle(extent={{-80,-46},{10,-96}}, lineColor={95,95,95}, pattern=LinePattern.Dash, fillColor={225,225,225}, fillPattern=FillPattern.Solid),Text(extent={{-64,-86},{8,-96}}, lineColor={255,0,0}, pattern=LinePattern.Dash, fillColor={215,215,215}, fillPattern=FillPattern.Solid, textString="if displayEffects = false")}, lineColor={0,0,255}, lineColor={0,0,255}, textString="BaseClass"));
      protected 
        Visualization.Internal.DynamicRotation fixedDisplacement(final animation=false, final r=r_shape, final n_y=widthDirection, final n_x=lengthDirection, final n=axis, final angle=angle, final sequence=sequence, final angles=angles, final T=T, final rotationType=rotationType) if displayEffects annotation(Placement(transformation(extent={{-70,-10},{-50,10}}, rotation=0)));
        Visualization.Internal.ZeroForcesAndTorques zeroForcesAndTorques if not displayEffects "Defines zero forces and torques at frame_a" annotation(Placement(transformation(extent={{-40,-80},{-60,-60}}, rotation=0)));
      protected 
        outer Visualization.UpdateVisualization updateVisualization;
      equation 
        connect(frame_a,fixedDisplacement.frame_a) annotation(Line(points={{-100,0},{-70,0}}, color={95,95,95}, thickness=0.5));
        connect(zeroForcesAndTorques.frame_b,frame_a) annotation(Line(points={{-60,-70},{-90,-70},{-90,0},{-100,0}}, color={95,95,95}, thickness=0.5));
      end PartialEffect;

    end Internal;

    model ParticleEffect "Smoke or fire effects"
      extends Visualization.Effects.Internal.PartialEffect;
      import Visualization.Effects.Internal.Types.ParticleEffectType;
      input Real scale[3]={1,1,1} "Scale factor in x, y and z direction" annotation(Dialog=true);
      input Real intensity=1 "intensity of particle effect" annotation(Dialog=true);
      parameter ParticleEffectType effectType=ParticleEffectType.Smoke "effect type";
      input Real particleSize(unit="m")=1 "size of the particles (at the emitter)" annotation(Dialog=true);
      input Modelica.SIunits.Time particleLifeTime=1 "lifetime of the particles" annotation(Dialog=true);
      input Modelica.SIunits.Velocity wind[3]={0,0,0} "wind effecting the particles" annotation(Dialog=true);
      annotation(Documentation(revisions="<html>
</html>", info="<html>
<p>
The <b>ParticleEffect</b> model implements two particle effects: Fire or Smoke/Steam. 
</p>
 
<p>
In the following figures, these effects are shown for different values of the
effect parameters. 
In the left most subfigure (subfigure 1), the default setting
of the parameters are used (together with a coordinate system with a length of 1 m for
every axis):
</p>
 
<ul>
<li> intensity=1,</li>
<li> particleSize=1,</li>
<li> particleLifeTime=1,</li>
<li> wind={0,0,0} (drift velocity of particles)</li>
</ul>
 
<p>
In the other four subfigures, always the value of one parameter is 
changed, whereas the other parameters keep their default values:
</p>
 
<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\" style=\"border-collapse: collapse;\">
<tr> <td> subfigure 1</td>
     <td> subfigure 2</td>
     <td> subfigure 3</td>
     <td> subfigure 4</td>
     <td> subfigure 5</td>
</tr>
<tr> <td> defaults</td>
     <td> intensity=10</td>
     <td> particleSize=2</td>
     <td> particleLifeTime=3</td>
     <td> wind={2,0,0}</td>
</tr>
</table>
</blockquote>
 
 
<p>
The following figure shows the <b>fire</b> effect
(this figure was generated with example model
<a href=\"Modelica://Visualization.Examples.ShowFeatures.FireEffects\">Examples.ShowFeatures.FireEffects</a>).
</p>
 
<blockquote>
<img src=\"../Extras/Images/Examples/Effects-Fire.png\">
</blockquote>
 
 
<p>
The following figure shows the <b>smoke</b> effect
(this figure was generated with example model
<a href=\"Modelica://Visualization.Examples.ShowFeatures.SmokeEffects\">Examples.ShowFeatures.SmokeEffects</a>).
</p>
 
<blockquote>
<img src=\"../Extras/Images/Examples/Effects-Smoke.png\">
</blockquote>
 
 
<h4><br>Shape frame</h4>
 
<p>
All quantites of the ParticleEffect are defined in the coordinate system of the \"Shape frame\".
By default, the shape frame is identical to <code>frame_a</code>. With the parameters of tab \"Shape frame\",
the shape frame can be positioned and rotated relatively to <code>frame_a</code>.
The details are described in the
<a href=\"Modelica://Visualization.UsersGuide.Tutorial.ShapeFrame\">Shape frame tutorial</a>.
</p>
 
</html>"));
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Polygon(points={{-20,-82},{-24,-82},{-30,-80},{-32,-76},{-32,-70},{-30,-66},{-30,-60},{-24,-58},{-18,-60},{-14,-60},{-10,-60},{-6,-64},{-2,-68},{-2,-72},{-2,-78},{-6,-82},{-14,-84},{-16,-82},{-20,-82}}, lineColor={0,0,255}, pattern=LinePattern.None, fillColor={255,255,0}, fillPattern=FillPattern.Solid),Polygon(points={{-8,-64},{-20,-64},{-30,-58},{-34,-52},{-32,-38},{-30,-30},{-22,-28},{-16,-30},{-12,-26},{-6,-28},{-2,-32},{2,-36},{6,-40},{6,-44},{6,-50},{4,-54},{4,-58},{-2,-64},{-8,-64}}, lineColor={0,0,255}, pattern=LinePattern.None, fillColor={255,132,0}, fillPattern=FillPattern.Solid),Polygon(points={{-4,-36},{-16,-30},{-26,-26},{-32,-6},{-32,10},{-22,20},{-12,20},{0,20},{8,20},{16,16},{24,12},{34,2},{34,-8},{28,-18},{22,-22},{18,-28},{10,-36},{4,-34},{-4,-36}}, lineColor={0,0,255}, pattern=LinePattern.None, fillColor={255,47,0}, fillPattern=FillPattern.Solid),Polygon(points={{-6,2},{-14,10},{-22,14},{-28,30},{-26,40},{-20,48},{-10,56},{6,60},{20,64},{36,62},{48,52},{52,38},{58,18},{46,10},{38,6},{26,0},{14,2},{6,4},{-6,2}}, lineColor={0,0,255}, pattern=LinePattern.None, fillColor={118,22,0}, fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
    protected 
      Internal.ParticleEffect particleEffect(scale=scale, intensity=intensity, particleSize=particleSize, particleLifeTime=particleLifeTime, wind=wind, effectType=effectTypeInt) if displayEffects annotation(Placement(transformation(extent={{-16,-16},{16,16}}, rotation=0)));
    protected 
      parameter Integer effectTypeInt=if effectType == ParticleEffectType.Smoke then 0 else 1;
    equation 
      connect(fixedDisplacement.frame_b,particleEffect.frame_a) annotation(Line(points={{-50,0},{-16,0}}, color={95,95,95}, pattern=LinePattern.None, thickness=0.5));
    end ParticleEffect;

  end Effects;

  package Cameras "Collection of cameras to define the views of the scene"
    annotation(classOrder={"FixedCamera","FollowCamera","DynamicFollowCamera","AttachedCamera","FreeCamera","*","Internal"}, Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{-162,124},{158,-116}}, fileName="../Extras/Images/Icons/camera1.png")}), Documentation(info="<html>
<p>
Cameras are used to define the view of a 3-dim. graphical representation
from a specific viewpoint on the scene.
The camera concept and the main parameters are explained in the
<a href=\"Visualization.UsersGuide.Tutorial.Cameras\">Camera Tutorial</a>.
The <a href=\"Visualization.Examples.CameraAndPaths.Cameras\">Examples.CameraAndPaths.Cameras</a> 
models demonstrate the use of cameras.
</p>
 
<p>
Note that (if present in each case) <code>frame_a</code> always refers
to the viewpoint (the location where the camera is attached)
and <code>frame_b</code> always refers to the view center
(the location to which the camera is looking).
</p>
 
<p>
An example is shown in the next figure (this figure was generated with 
<a href=\"Visualization.Examples.CameraAndPaths.Cameras\">Examples.CameraAndPaths.Cameras</a>).
It consists of four cameras:
</p>
 
<ul>
<li> The two upper cameras are <a href=\"Visualization.Cameras.FollowCamera\">FollowCameras</a>.</li>
<li> The lower left camera is an <a href=\"Visualization.Cameras.AttachedCamera\">AttachedCamera</a>.</li>
<li> The lower right camera is a <a href=\"Visualization.Cameras.AttachedCamera\">FixedCamera</a>.</li>
</ul>
 
<blockquote>
<img src=\"../Extras/Images/SeveralCameras.png\">
</blockquote>
</html>"));
    package Internal
      extends Visualization.Utilities.Icons.BaseClassPackage;
      package Types
        extends Visualization.Utilities.Icons.Package;
        annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
        type WindowMode= enumeration(Window "Window", Fullscreen "Fullscreen") "Enumeration defining the type of window used in the visualization";
        type HUDResizePolicy= enumeration(VerticalAlignment "Vertical alignment", HorizontalAlignment "Horizontal alignment", DynamicChoice "Dynamic choice", Free "Free") "Enumeration defining the policy of HUD element positioning";
      end Types;

      package Functions
        extends Visualization.Utilities.Icons.Package;
        annotation(preferedView="info", Documentation(info="<html>
<p>
</p>
</html>", revisions="<html><table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"../Extras/Images/dlr_logo.png\" width=50></td>
      <td valign=\"center\"> <b>Copyright &copy; 2009, DLR Institute of Robotics and Mechatronics<b> </td>
  </tr>
 </table>
</html>"));
        function setCamera
          input Visualization.Internal.VisShapeID camID;
          input Integer camType;
          input Real posCam[3];
          input Real posLookAt[3];
          input Real upVector[3];
          input Real pos[2];
          input Real size[2];
          input Integer windowType;
          input Integer monitor;
          input Integer backgroundColor[3];
          input Real viewDistance;
          input Real fov;
          input Integer showHUD;
          input Integer resizePolicy;
          input Real startDistanceToCenter[3];
          output Boolean y=true;

          external "C" SetCamera(camID,camType,posCam,posLookAt,upVector,pos,size,windowType,monitor,backgroundColor,viewDistance,fov,showHUD,resizePolicy,startDistanceToCenter) ;

        end setCamera;

      end Functions;

      model CameraObject "Shape block for external visualisation"
        import Visualization.Cameras.Internal.Types.HUDResizePolicy;
        extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_a;
        input Real upVector[3]={0,0,1} annotation(Dialog=true);
        parameter Integer camType=1;
        parameter Real pos[2]={0,0} "Position of window";
        parameter Real size[2]={1,1} "Size of window";
        parameter Integer windowType=0;
        parameter Integer monitor=0;
        input Integer backgroundColor[3]={255,255,255} annotation(Dialog=true);
        parameter Real viewDistance=1500;
        parameter Real fov=30;
        parameter Boolean showHUD=true "shows HUD on this Window";
        parameter HUDResizePolicy hudResizePolicy=HUDResizePolicy.VerticalAlignment;
        parameter Real startDistanceToCenter[3]={-1,0,0} "Distance to start Center of camera";
      protected 
        Real posLookAt[3];
        Real posCam[3];
        Integer resizePolicy=if hudResizePolicy == HUDResizePolicy.VerticalAlignment then 0 else if hudResizePolicy == HUDResizePolicy.HorizontalAlignment then 1 else if hudResizePolicy == HUDResizePolicy.DynamicChoice then 2 else 3;
        outer Visualization.UpdateVisualization updateVisualization "Determine time instant for storing/sending data";
        Visualization.Internal.VisShapeID CamID=Visualization.Internal.VisShapeID();
        Boolean y;
      public 
        Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve annotation(Placement(transformation(extent={{84,-16},{116,16}}, rotation=0)));
      equation 
        frame_a.t=zeros(3);
        frame_a.f=zeros(3);
        frame_resolve.t=zeros(3);
        frame_resolve.f=zeros(3);
        posCam=frame_a.r_0;
        posLookAt=frame_resolve.r_0;
        if updateVisualization.send then
          y=Visualization.Cameras.Internal.Functions.setCamera(CamID, camType, posCam, posLookAt, upVector, pos, size, windowType, monitor, backgroundColor, viewDistance, fov, if showHUD then 1 else 0, resizePolicy, startDistanceToCenter);
        else
          y=false;
        end if;
        annotation(Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={95,95,95}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Text(extent={{-150,80},{150,40}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="%name"),Text(extent={{-100,-40},{100,-80}}, lineColor={135,135,135}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="Camera")}));
      end CameraObject;

      partial model BaseCamera "Partial camera to define a window with a particular view for all types of cameras"
        import Visualization.Cameras.Internal.Types.WindowMode;
        import Visualization.Cameras.Internal.Types.HUDResizePolicy;
        extends Visualization.Internal.AnimationDefinition;
        parameter Real pos[2]={0,0} "Lower left corner (x,y) of camera window relative to SimVis window (0..1)" annotation(Dialog(group="Window parameters"));
        parameter Real size[2]={1,1} "Size (dx,dy) of camera window relative to SimVis window (0..1)" annotation(Dialog(group="Window parameters"));
        parameter Visualization.Cameras.Internal.Types.WindowMode windowMode=Visualization.Cameras.Internal.Types.WindowMode.Window "Mode of window visualization (window, fullscreen)" annotation(Dialog(group="Window parameters"));
        parameter Integer monitor=0 "Choice of monitor (first monitor = 0) only relevant if windowMode=Fullscreen" annotation(Dialog(enable=windowMode == WindowMode.Fullscreen, group="Window parameters"));
        input Modelica.Mechanics.MultiBody.Types.Color backgroundColor={255,255,255} "Background color of window" annotation(Dialog(colorSelector, group="Camera parameters"));
        parameter Modelica.SIunits.Position viewDistance=1500 "Maximal distance where objects are drawn" annotation(Dialog(group="Camera parameters"));
        parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg fov=30 "Field of View in horizontal direction" annotation(Dialog(group="Camera parameters"));
        parameter Boolean showHUD=true "= true, if Head-Up-Displays are shown in this Window" annotation(Dialog(tab="Head-Up-Display configuration"), choices(checkBox=true));
        parameter Visualization.Cameras.Internal.Types.HUDResizePolicy hudResizePolicy=Visualization.Cameras.Internal.Types.HUDResizePolicy.VerticalAlignment "Alignment policy for Head-Up-Displays" annotation(Dialog(tab="Head-Up-Display configuration"));
      protected 
        outer Visualization.UpdateVisualization updateVisualization;
        annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-60,-40},{60,-90}}, lineColor={95,95,95}, pattern=LinePattern.Dash, fillColor={225,225,225}, fillPattern=FillPattern.Solid),Text(extent={{-18,-80},{58,-90}}, lineColor={255,0,0}, pattern=LinePattern.Dash, fillColor={215,215,215}, fillPattern=FillPattern.Solid, textString="if external visualization = false"),Rectangle(extent={{-60,40},{60,-30}}, lineColor={95,95,95}, pattern=LinePattern.Dash, fillColor={225,225,225}, fillPattern=FillPattern.Solid),Text(extent={{-16,-20},{56,-30}}, lineColor={0,127,0}, pattern=LinePattern.Dash, fillColor={215,215,215}, fillPattern=FillPattern.Solid, textString="if external visualization = true")}), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{-100,100},{100,-100}}, fileName="../../Extras/Images/Icons/camera1.png"),Text(extent={{-150,100},{150,60}}, textString="%name", lineColor={0,0,255})}));
      protected 
        CameraObject cameraObject(monitor=monitor, backgroundColor=backgroundColor, viewDistance=viewDistance, fov=fov, pos=pos, size=size, showHUD=showHUD, hudResizePolicy=hudResizePolicy, windowType=1, upVector={0,0,1}) if enableCameras annotation(Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0)));
        Visualization.Internal.ZeroForcesAndTorques zeroForcesAndTorques if not enableCameras annotation(Placement(transformation(extent={{20,-70},{40,-50}}, rotation=0)));
      end BaseCamera;

    end Internal;

    model FreeCamera "Freely movable camera, initially looking to frame_b"
      annotation(defaultComponentName="camera", Documentation(info="<html>
<p>
The FreeCamera basically has the same behavior as the default camera,
but the start view can be parametrized by <code>frame_b</code>
and the default camera values can be changed.
The camera concept and the camera parameters are explained in the
<a href=\"Visualization.UsersGuide.Tutorial.Cameras\">Camera Tutorial</a>.
</p>
 
<blockquote>
<IMG SRC=\"../Extras/Images/CameraFree.png\">
</blockquote>
 
 
</html>"));
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialOneFrame_b;
      extends Visualization.Cameras.Internal.BaseCamera(cameraObject(camType=3, startDistanceToCenter=startDistanceToCenter));
      parameter Modelica.SIunits.Position startDistanceToCenter[3]={0,-1,0} "Initial viewpoint resolved in frame_b" annotation(Dialog(group="Camera parameters"));
      annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(extent={{-80,-60},{80,-80}}, lineColor={0,0,0}, textString="Free")}), Diagram(graphics));
      Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r={0,0,0}, animation=false) if enableCameras annotation(Placement(transformation(extent={{-54,-10},{-34,10}}, rotation=0)));
    protected 
      outer Visualization.UpdateVisualization updateVisualization;
    equation 
      connect(fixed.frame_b,cameraObject.frame_a) annotation(Line(points={{-34,0},{-20,0}}, color={95,95,95}, thickness=0.5, smooth=Smooth.None));
      connect(cameraObject.frame_resolve,frame_b) annotation(Line(points={{20,0},{100,0}}, color={95,95,95}, pattern=LinePattern.Dot, smooth=Smooth.None));
      connect(zeroForcesAndTorques.frame_b,frame_b) annotation(Line(points={{40,-60},{70,-60},{70,0},{100,0}}, color={95,95,95}, thickness=0.5, smooth=Smooth.None));
    end FreeCamera;

  end Cameras;

  model UpdateVisualization "Update visualization (rendering) of all defined visualization objects"
    parameter Boolean animateExtern=true "= true, use external DLR visualization SimVis, otherwise tool animation" annotation(Dialog(group="Visualization options"));
    parameter Modelica.SIunits.Time VisUpdateInterval=0.01 "The sampling time of the visualization update" annotation(Dialog(enable=animateExtern, group="SimVis Parameter"));
    parameter Boolean synchronizeFrame=false " = true, all data of a timestep are sent at once" annotation(Dialog(enable=animateExtern, group="SimVis Parameter"));
    parameter String ipAddress="127.0.0.1" "IP-Adress of rendering engine (e.g. SimVis)" annotation(Dialog(enable=animateExtern, group="SimVis Parameter"));
    parameter Integer tcpPort=11000 "TCP port number for transmitting data to SimVis" annotation(Dialog(enable=animateExtern, group="SimVis Parameter"));
    parameter Boolean displayMultiBodyStructure=true " if enabled, Modelica MultiBody models are displayed" annotation(Dialog(enable=animateExtern, group="Visualization options"), choices(checkBox=true));
    parameter Boolean displayVisualizers=true " if enabled, Visualizers of the DLR Visualization libary are displayed" annotation(Dialog(enable=animateExtern, group="Visualization options"), choices(checkBox=true));
    parameter Boolean displayFlowElements=true " if enabled, FlowElements of the DLR Visualization libary are displayed" annotation(Dialog(enable=animateExtern, group="Visualization options"), choices(checkBox=true));
    parameter Boolean displayHUDElements=true " if enabled, Heads-Up elements of the DLR Visualization libary are displayed" annotation(Dialog(enable=animateExtern, group="Visualization options"), choices(checkBox=true));
    parameter Boolean displayEffects=true " if enabled, effect elements of the DLR Visualization libary are displayed" annotation(Dialog(enable=animateExtern, group="Visualization options"), choices(checkBox=true));
    parameter Boolean enableLights=true " if enabled, light blocks are used for lighting, otherwise only the standard light" annotation(Dialog(enable=animateExtern, group="Visualization options"), choices(checkBox=true));
    parameter Boolean enableCameras=true " if enabled, cameras are used to define the view on the scene" annotation(Dialog(enable=animateExtern, group="Visualization options"), choices(checkBox=true));
    output Boolean send "True, if visualization object shall send the data" annotation(HideResult=true);
    annotation(defaultComponentName="updateVisualization", defaultComponentPrefixes="inner", missingInnerMessage="No \"updateVisualization\" component is defined. A default
    component with the default update interval will be used. If this is not desired, drag 
    Modelica_ExternalDevices.Visualization.UpdateVisualization into the top level of your model.", Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-98,96},{94,-96}}, lineColor={0,0,255}, pattern=LinePattern.None, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),Rectangle(extent={{-2,40},{92,-94}}, lineColor={0,0,255}, pattern=LinePattern.None, lineThickness=1, fillColor={255,255,255}, fillPattern=FillPattern.Solid),Polygon(points={{84,50},{54,28},{88,12},{84,50}}, lineColor={0,0,255}, pattern=LinePattern.None, lineThickness=1, fillColor={0,0,0}, fillPattern=FillPattern.Solid),Text(extent={{-64,66},{66,-68}}, lineColor={0,0,0}, pattern=LinePattern.None, lineThickness=1, fillColor={255,255,255}, fillPattern=FillPattern.Solid, textString="Vis"),Text(extent={{-160,-100},{160,-140}}, lineColor={95,95,95}, textString="animateExtern=%animateExtern")}), Documentation(info="<html>
<p>
Whenever one component of the DLR <b>Visualization</b> library is used, exactly
one instance of <b>UpdateVisualization</b> must be present so that all instances
of the Visualization components are either on the same level or on a lower level as the
<b>UpdateVisualization</b> component. If this block is not present, it is automatically
introduced by the tool with default options:
</p>
<pre>
   <b>inner</b> Visualization.UpdateVisualization updateVisualization;
</pre>
<p>
Via the inner/outer mechanism of Modelica, global options are communicated
to all Visualization components. Especially, all components will be only
called at a fixed sampling rate (default = 0.01 s).
</p>
<p>
The UpdateVisualization block allows the user to disable distinct categories of visualizers.
The following categories exist:
<ul>
<li>Multibody strucures: The <b>displayMultiBodyStructure</b> switch enables Modelica-integrated visualization elements, like the visualization of joints, forces, etc. The standard Modelica <a href=\"Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Visualizer</a> must be replaced with the variant from <a href=\"Visualization.Internal.Shape\">Visualization.Internal</a> the visualization library </li>
<li>Visualizers: By activating the <b>displayVisualizers</b> switch, the visualizers from the <a href=\"Visualization.Shapes\">Visualization.Shapes</a> package are enabled.</li>
<li>Flow elements: The <b>displayFlowElements</b> switch triggers the visualization of energy/mass flow networks, as provided by the <a href=\"Visualization.FlowElements\">Visualization.FlowElements</a> package.</li>
<li>Head-up-displays: The <b>displayHUDElements</b>switch enables/disables the visualization of head-up-display elements from the <a href=\"Visualization.HUD\">Visualization.HUD</a> package.</li>
<li>Effects: The visualization of effects from the <a href=\"Visualization.Effects\">Visualization.Effects</a> package can be triggered with the switch <b>displayEffects</b>. </li>
<li>Lights: The user-defined <a href=\"Visualization.Lights\">lights</a> in the model can be activated/deactivated, using the switch <b>enableLights</b>.</li>
<li>Cameras: The switch <b>enableCameras</b> can be used to globally enable or disable the <a href=\"Visualization.Cameras\">cameras</a> used in the model. </li>
</ul>
</p> 
<h4>SimVis Parameter</h4>
<p> 
The parameters in the group \"SimVis Parameter\" define the communication behavior with the viewer software  <a href=\"Visualization.UsersGuide.Tutorial.SimVis\">DLR SimVis</a>.</p>
<p>
The most important parameter here is the <b>VisUpdateInterval</b> parameter. It defines the update interval used for the transmission of visualization data to the viewer. E.g. a value of 0.04 s leads to a framerate of 25 frames per second. For slow-motion replays, this value has to be decreased (for example 0.001 for 1000 frames per second) resulting in a higher resolution of visualization data. For high-speed replays (e.g. a replay compressing a whole day in a couple of minutes) this value can be increased to reduce the amount of data. </p>
<p>The parameters <b>ipAddress</b> and <b>tcpPort</b> specify the IP address and the TCP port used for network communication with DLR SimVis. In the case of seperate systems for simulation and visualization (the IP address is not \"127.0.0.1\" or \"localhost\"), the viewer software has to be started manually on the remote visualization system. Please note, in this case the paths for files have to be specified in the SimVis settings dialog \"Additional search path\".</p>
</html>"));
    Visualization.Internal.VisualizationControl visualizationControl(VisUpdateInterval=VisUpdateInterval, animateExtern=animateExtern, ipAddress=ipAddress, iTcpPort=tcpPort, synchronizeFrame=synchronizeFrame) if animateExtern annotation(Placement(transformation(extent={{-80,-20},{20,80}})));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false) if not animateExtern annotation(Placement(transformation(extent={{-40,-60},{-20,-40}})));
  protected 
    Modelica.Blocks.Interfaces.BooleanOutput sendIntern annotation(Placement(transformation(extent={{60,-10},{80,10}})));
  equation 
    send=sendIntern;
    connect(booleanConstant.y,sendIntern) annotation(Line(points={{-19,-50},{34,-50},{34,0},{70,0}}, color={255,0,255}, smooth=Smooth.None));
    connect(visualizationControl.send,sendIntern) annotation(Line(points={{25,30},{34,30},{34,0},{70,0}}, color={255,0,255}, smooth=Smooth.None));
  end UpdateVisualization;

end Visualization;
