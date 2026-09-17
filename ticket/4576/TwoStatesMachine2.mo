  package TwoStatesMachine2
    model State1
      outer output Integer i;
    equation
      i = previous(i)+2;
      annotation(
        Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
        __Dymola_state = true,
        singleInstance = true,
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
    end State1;

    model State2
      outer output Integer i;
    equation
      i = previous(i)-1;
    
      annotation(
        Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)),
        __Dymola_state = true,
        singleInstance = true,
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
    end State2;

    model Machine
      inner Integer i(start=0);
      TwoStatesMachine2.State1 state1 annotation(
        Placement(visible = true, transformation(origin = {-12, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TwoStatesMachine2.State2 state2 annotation(
        Placement(visible = true, transformation(origin = {-12, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
    end Machine;



    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  end TwoStatesMachine2;
