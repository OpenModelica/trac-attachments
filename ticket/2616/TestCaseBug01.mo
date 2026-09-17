within ;
package TestCaseBug "Constanter modell"



  model Controller
    parameter Real timeTableCurrent[:, 2]=[0, 0];
    parameter Real timeTableVoltage[:, 2]=[0, 0];
    parameter StepData stepdef[:]={StepData()} "Step definitions";
    Modelica.Blocks.Sources.TimeTable i_timeTable(table=timeTableCurrent);
    Modelica.Blocks.Sources.TimeTable u_timeTable1(table=timeTableVoltage);
  protected
    Full controller(stepdef=stepdef);
  equation
    connect(u_timeTable1.y, controller.u_now);
    connect(i_timeTable.y, controller.i_now);
  end Controller;

  model Full "Full logic definition"
    parameter StepData stepdef[:]={StepData()} "Step definitions";

    Modelica.Blocks.Interfaces.RealInput u_now "Actual voltage";
    Modelica.Blocks.Interfaces.RealInput i_now "Actual current";
    Modelica.Blocks.Interfaces.RealOutput Temp_C_set;
  algorithm
    Temp_C_set := 1;
  end Full;


  model TestCaseBug
    Controller simpleTest(stepdef={StepData(),StepData(steptype=StepType.rest),
          StepData(steptype=StepType.rest),StepData(steptype=StepType.rest),
          StepData(steptype=StepType.rest)});
  end TestCaseBug;

  record StepData
    import Constanter = TestCaseBug;
    parameter Constanter.StepType steptype=Constanter.StepType.invalid;
    parameter Integer loop_start=0;
    parameter Integer loop_count=0;
  end StepData;

  type StepType = enumeration(
      invalid "invalid step",
      charge "charge step",
      discharge "descharge step",
      rest "rest step") "Definition of the step type; invalid steps are skiped";
  annotation (uses(Modelica(version="3.2.1")));
end TestCaseBug;
