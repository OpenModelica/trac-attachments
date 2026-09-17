model DoublePendulumLoop
  import SI = Modelica.SIunits;
  import CON = Modelica.Constants;
  import Modelica.Utilities.Streams;
  import Modelica.Utilities.Files;
  constant Real pi = CON.pi;
  parameter Integer nLinks = 2;
  parameter SI.Length linkLength = 0.010, linkDiam = 0.0025;
  parameter SI.Area xArea = pi * (linkDiam / 2)^2;
  // cross-sectional area, m^2
  parameter SI.Density density = 7700;
  parameter SI.Mass mass = xArea * linkLength * density;
  parameter SI.Length[3] rLink = {linkLength, 0, 0};
  parameter SI.Length[:,:] rLinkArray = {(if i <= 1 then rLink else rLink * 2) for i in 1:nLinks};
  parameter SI.Length[3] rShapeLink = {0, 0, 0};
  parameter SI.Length[3] linkDirection = {1, 0, 0};
  parameter Real rotAboutZ = 0 * pi / 180;
  parameter Real[3] initialAngle = {0, 0, rotAboutZ};
  parameter Real[:,:] angleArray = {(if i <= 1 then {0,0,0} else {0,0,90*pi/180}) for i in 1:nLinks};
  parameter SI.Time dt = 0.01, tf = 1.0;
  //
  inner Modelica.Mechanics.MultiBody.World world(g = 9.81) annotation(Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed1;
  Modelica.Mechanics.MultiBody.Joints.Spherical[nLinks] sphJoints; 
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder[nLinks] links(r = rLinkArray, each lengthDirection = linkDirection, each angles_fixed = true, angles_start = angleArray, each diameter = linkDiam, each length = linkLength, each w_0_fixed = true);
  //
equation
// Initial connection is done manually
  connect(fixed1.frame_b, sphJoints[1].frame_a);
  connect(sphJoints[1].frame_b, links[1].frame_a);
  for i in 2:nLinks loop
    connect(sphJoints[i].frame_a, links[i - 1].frame_b);
    connect(sphJoints[i].frame_b, links[i].frame_a);
  end for;
algorithm
  when sample(0, dt) then
    if time < dt then
      Files.remove("data.txt");
      Streams.print(String(nLinks), "data.txt");
    end if;
    
    Streams.print(String(time), "data.txt");
    Streams.print(String(links[1].frame_a.r_0[1]) + " " + String(links[1].frame_a.r_0[2]) + " " + String(links[1].frame_a.r_0[3]), "data.txt");
    for j in 1:nLinks loop
      Streams.print(String(links[j].frame_b.r_0[1]) + " " + String(links[j].frame_b.r_0[2]) + " " + String(links[j].frame_b.r_0[3]), "data.txt");
    end for;
    //Streams.print(String(links[1].frame_b.r_0[1]) + " " + String(links[1].frame_b.r_0[2]) + " " + String(links[1].frame_b.r_0[3]), "data.txt");
    //Streams.print(String(links[2].frame_b.r_0[1]) + " " + String(links[2].frame_b.r_0[2]) + " " + String(links[2].frame_b.r_0[3]), "data.txt");
  end when;

  annotation(uses(Modelica(version = "3.2.2")), experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end DoublePendulumLoop;
