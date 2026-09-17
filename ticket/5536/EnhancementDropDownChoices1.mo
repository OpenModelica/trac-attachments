package EnhancementDropDownChoices1
  model Model1
    parameter String Option = "Option 1" annotation(choices(choice = "Option 1", choice = "Option 2", choice = "Option 3"));
  
    parameter Boolean test1;
  equation

  end Model1;

  model testModel1
    BugDropDown.Model1 model11(test1 = false)  annotation(
      Placement(visible = true, transformation(origin = {2, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end testModel1;
end EnhancementDropDownChoices1;
