model mwe_duplicate_parameters
  model submodel
    extends extendme1;
    extends extendme2;
  end submodel;

  model extendme1
    extends extendme0;
  end extendme1;

  model extendme2
    extends extendme0;
  end extendme2;

  mwe_duplicate_parameters.submodel thesubmodel annotation(
    Placement(
      visible = true, 
      transformation(
        origin = {0, 0}, 
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 0)));

  model extendme0
    parameter Real p;
  end extendme0;

  annotation(
    Icon(coordinateSystem(grid = {1, 1})));
end mwe_duplicate_parameters;
