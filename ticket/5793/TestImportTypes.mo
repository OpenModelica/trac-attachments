package TestImportTypes

  package Types
    package Choices
      type MyEnumeration = enumeration(case1 "First case", case2 "Second case");
    end Choices;
  end Types;

  model M
    import TestImportTypes.Types.Choices;
    parameter Choices.MyEnumeration p; 
  end M;

  model System
  M m annotation(
      Placement(visible = true, transformation(origin = {6, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

  end System;
  
end TestImportTypes;
