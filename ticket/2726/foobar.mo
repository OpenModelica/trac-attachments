within ;
model foobar

  import SI = Modelica.SIunits;
  import Modelica.Mechanics.MultiBody.Frames.Orientation;
  import Modelica.Mechanics.MultiBody.Frames;

  // number of elements
  parameter Integer e_ges = 10;

  // moments of inertia for a temporary reference frame
  parameter SI.Inertia[e_ges] JxxTemp = {1 for i in 1:e_ges};
  parameter SI.Inertia[e_ges] JyyTemp = {2 for i in 1:e_ges};
  parameter SI.Inertia[e_ges] JzzTemp = {3 for i in 1:e_ges};
  parameter SI.Inertia[e_ges] JxyTemp = {0 for i in 1:e_ges};
  parameter SI.Inertia[e_ges] JxzTemp = {0 for i in 1:e_ges};
  parameter SI.Inertia[e_ges] JyzTemp = {0 for i in 1:e_ges};

  // some rotation Object
  parameter Orientation[e_ges] Rab = {Frames.nullRotation() for i in 1:e_ges};

  // Array with all inertia tensors
  parameter SI.Inertia[e_ges,3,3] J = {{{JxxTemp[i],JxyTemp[i],JxzTemp[i]},{JxyTemp[i],JyyTemp[i],JyzTemp[i]},{JxzTemp[i],JyzTemp[i],JzzTemp[i]}} for i in 1:e_ges};

  // calculate array with new inertia tensors
  parameter Real[e_ges,3,3] test2 = {Rab[i].T*J[i,:,:]*transpose(Rab[i].T) for i in 1:e_ges};

  annotation (uses(Modelica(version="3.2.1")));
end foobar;
