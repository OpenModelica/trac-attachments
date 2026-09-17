block RlsIdentifier "МНК-идентификатор"
  import Modelica.Math.Matrices.*;
  input Real x[:, :] "Матрица базисных функций регрессии";
  input Real y[size(x, 1), :] "Матрица значений результата эксперимента";
  input Real lambda "Параметр забывания";
  output Real theta[size(x, 2), size(y, 2)] "Оценка регрессионных параметров";
  output Real j "Оценка взвешенной невязки";
protected
  Real r[size(x, 2), size(x, 2)] "Информационная матрица";
  Real epsilon[size(x, 1), :] "Ошибка прогноза";
equation
  der(r) = -lambda * r + transpose(x) * x;
  epsilon = y - x * theta;
  der(theta) = leastSquares2(r, transpose(x) * epsilon);
  der(j) = -lambda * j + trace(transpose(epsilon) * epsilon) / 2;
end RlsIdentifier;
