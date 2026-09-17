model test "Для тестирования"
  import Modelica.Constants.pi;
  RlsIdentifier tryit(
    x = {{cos(time * omega), sin(time * omega)}},
    y = {{sin(time * omega + pi / 4)}},
    lambda = 0.5);
  parameter Real omega = 5 "Циклическая частота сигнала";
equation
end test;
