package Modelica
package Constants
constant Real eps = 0.001;
end Constants;
end Modelica;

function normalize
  input Real v[:];
  input Real eps = 100 * Modelica.Constants.eps;
  output Real result[size(v, 1)];
algorithm 
  result := smooth(0, if length(v) >= eps then v / length(v) else v / eps);
end normalize;

class _1139
  Real n_z_aux = 1;
  Real widthDirection[3] = {0,1,0};
  Real e_x[3] = {1,1,1};
  Real e_y[3](each final unit="1") = noEvent(
    cross(normalize(
              cross(e_x, if n_z_aux*n_z_aux > 1e-06 then widthDirection else if abs(e_x[1]) > 1e-06 then {0,1,0} else {1,0,0})
          ),
          e_x)
  );
end _1139;

// fclass _1139
// Real n_z_aux = 1.0;
// Real widthDirection[1] = 0.0;
// Real widthDirection[2] = 1.0;
// Real widthDirection[3] = 0.0;
// Real e_x[1] = 1.0;
// Real e_x[2] = 1.0;
// Real e_x[3] = 1.0;
// Real e_y[1](unit = "1") = cross(normalize(cross({e_x[1],e_x[2],e_x[3]},if noEvent(n_z_aux ^ 2.0 > 1e-06) then {widthDirection[1],widthDirection[2],widthDirection[3]} else if noEvent(abs(e_x[1]) > 1e-06) then {0.0,1.0,0.0} else {1.0,0.0,0.0}),0.1),{e_x[1],e_x[2],e_x[3]})[1];
// Real e_y[2](unit = "1") = cross(normalize(cross({e_x[1],e_x[2],e_x[3]},if noEvent(n_z_aux ^ 2.0 > 1e-06) then {widthDirection[1],widthDirection[2],widthDirection[3]} else if noEvent(abs(e_x[1]) > 1e-06) then {0.0,1.0,0.0} else {1.0,0.0,0.0}),0.1),{e_x[1],e_x[2],e_x[3]})[2];
// Real e_y[3](unit = "1") = cross(normalize(cross({e_x[1],e_x[2],e_x[3]},if noEvent(n_z_aux ^ 2.0 > 1e-06) then {widthDirection[1],widthDirection[2],widthDirection[3]} else if noEvent(abs(e_x[1]) > 1e-06) then {0.0,1.0,0.0} else {1.0,0.0,0.0}),0.1),{e_x[1],e_x[2],e_x[3]})[3];
// end _1139;

