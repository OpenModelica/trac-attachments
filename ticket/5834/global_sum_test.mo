package global_sum_test

  connector Sum_port
    flow Real a;
    flow Real b;
  end Sum_port;

  model Global
    Sum_port sum;
    annotation(defaultComponentName = "global");
  end Global;
  
  model Sum_adder
    outer Global global;
    outer Sum_port sum; //consider having or not having the outer keyword infron of this declaration
    Real a;
    Real b;
  equation
    sum.a = a;
    sum.b = b;
    connect(sum, global.sum);
  end Sum_adder;

  model Local
    parameter Real a = 0.5;
    parameter Real b = 1.0;
    Sum_adder sum_adder(a=a,b=b);
  end Local;
 
  model Local_nested
    parameter Real a = 0.5;
    parameter Real b = 1.0;
    Sum_adder sum_adder(a=a,b=b);
    Local local;
  end Local_nested;

  model test_model
    inner global_sum_test.Global global;
    Local local;
    Local_nested local_nested;
  end test_model;

end global_sum_test;
