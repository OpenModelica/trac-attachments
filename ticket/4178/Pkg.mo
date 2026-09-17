package Pkg
  model Mdl1
    SubMdl subMdl1 annotation(Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    annotation(Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
  end Mdl1;

  model SubMdl
    annotation(Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})), Icon(graphics = {Text(origin = {8, 127}, extent = {{-106, 11}, {90, -19}}, textString = "%name", fontName = "MS Shell Dlg 2"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
  end SubMdl;
  annotation(Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end Pkg;
