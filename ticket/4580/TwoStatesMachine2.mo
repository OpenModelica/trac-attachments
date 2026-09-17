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
      TwoStatesMachine2.State1 state11 annotation(
        Placement(visible = true, transformation(origin = {-12, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      TwoStatesMachine2.State2 state21 annotation(
        Placement(visible = true, transformation(origin = {-12, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
      initialState(state11);
    transition(state21, state11, i < 1, immediate = true, reset = true, synchronize = false, priority = 1) annotation(
      Line(points = {{-2, 10}, {12, 10}, {12, 50}, {-2, 50}}, color = {175, 175, 175}, smooth = Smooth.Bezier),
      Text(lineColor = {95, 95, 95}, extent = {{-4, 4}, {-4, 10}}, textString = "%condition", fontSize = 10, textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Right));
    transition(state11, state21, i > 10, immediate = true, reset = true, synchronize = false, priority = 1) annotation(
      Line(points = {{-22, 50}, {-36, 50}, {-36, 10}, {-22, 10}}, color = {175, 175, 175}, smooth = Smooth.Bezier),
      Text(lineColor = {95, 95, 95}, extent = {{-4, 4}, {-4, 10}}, textString = "%condition", fontSize = 10, textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Right));
    annotation(
        Icon(coordinateSystem(grid = {0.1, 0.1})),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
    end Machine;






    annotation(
      Icon(coordinateSystem(grid = {0.1, 0.1})),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
  end TwoStatesMachine2;
