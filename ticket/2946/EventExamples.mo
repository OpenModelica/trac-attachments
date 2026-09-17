package EventExamples
  model test1
    parameter Real p = 1.5;
    Real t = if time < p then time else p;
    Boolean d = t > p and t >= p;
    Boolean e;
  algorithm
    e := true;
    if t > p then
      e := false;
    end if;
    annotation(experiment(StartTime = 0, StopTime = 3));
  end test1;

  model test2
    parameter Real p = 1.5;
    Real t = if time < p then time else p;
    //Boolean d = t > p and t >= p;
    Boolean e;
  algorithm
    e := true;
    if t > p then
      e := false;
    end if;
    annotation(experiment(StartTime = 0, StopTime = 3));
  end test2;

  model test3
    parameter Real p = 1.5;
    Real t = if time < p then time else p;
    Boolean d = t > p and t >= p;
    Boolean e;
  algorithm
    e := true;
    if t >= p then
      e := false;
    end if;
    annotation(experiment(StartTime = 0, StopTime = 3));
  end test3;

  model test4
    parameter Real p = 1.5;
    Real t = if time < p then time else p;
    //Boolean d = t > p and t >= p;
    Boolean e;
  algorithm
    e := true;
    if t >= p then
      e := false;
    end if;
    annotation(experiment(StartTime = 0, StopTime = 3));
  end test4;
end EventExamples;