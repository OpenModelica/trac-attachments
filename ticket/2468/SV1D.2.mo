model SV1D
  /*Chute de SISTERON
Lit simple, pas d'apport, pas de confluent, beta=1*/
  import Modelica.SIunits;
  //nombre de pas(section)
  parameter Integer n = 4;
  //Longueur du canal
  parameter SIunits.Length L = 32000;
  parameter Real beta = 1;
  //coefficient de Strickler
  parameter Integer K = 65;
  constant Real g = 9.81;
  //Cote
  SIunits.Position Z[n + 1](start = fill(574.27, n + 1));
  //débit
  SIunits.VolumeFlowRate Q[n + 1](start = fill(0, n + 1));
  //aire d'une section
  SIunits.Area S[n + 1](start = fill(Lbase * 574.27 + 2 * 574.27 ^ 2, n + 1));
  //largeur au miroir
  SIunits.Length Lt[n + 1](start = fill(4 * 574.27 + Lbase, n + 1));
  //rayon hydraulique
  SIunits.Length R[n + 1](start = fill((Lbase * 574.27 + 2 * 574.27 ^ 2) / (4 * 574.27 + 2 * Lbase + 2 * sqrt(5) * 574.27), n + 1));
  //taux moyen de dissipation de l'énergie
  Real J[n + 1](start = fill(0, n + 1));
  //variable temporaire
  Real A[n + 1](start = fill(Lbase * 574.27 + 2 * 574.27 ^ 2, n + 1));
protected
  //longueur d'une section
  parameter SIunits.Length dx = 32000 / 4;
  //largeur de base d'une section trapezoidale
  parameter SIunits.Length Lbase = 8.6;
equation
  for i in 1:n loop
  A[i] = der(Lbase * Z[i] + 2 * Z[i] ^ 2);

  end for;
  //boucle sur sur les sections
  for i in 1:n loop
  S[i] - Lbase * Z[i] - 2 * Z[i] ^ 2 = 0;
  Lt[i] - 4 * Z[i] - Lbase = 0;
  R[i] - (Lbase * Z[i] + 2 * Z[i] ^ 2) / (4 * Z[i] + 2 * Lbase + 2 * sqrt(5) * Z[i]) = 0;
  J[i] - Q[i] ^ 2 / (65 * S[i] ^ 2 * R[i] ^ (4 / 3)) = 0;
  //Q[i + 1] - Q[1] + dx * Somme(i, n + 1, A) = 0;
  (Q[i + 1] - Q[i]) / dx + A[i] = 0;
  //(Q[i + 1] - Q[1]) / dx + Somme(i, n + 1, A) = 0;
  der(Q[i]) + beta * (Q[i + 1] ^ 2 / S[i + 1] - Q[i] ^ 2 / S[i]) / dx + g * S[i] * ((Z[i + 1] - Z[i]) / dx + J[i]) = 0;

  end for;
  //Condition aux limites
  A[n + 1] = Lbase * 574.27 + 2 * 574.27 ^ 2;
  S[n + 1] - Lbase * Z[n + 1] - 2 * Z[n + 1] ^ 2 = 0;
  Lt[n + 1] - Z[n + 1] - Lbase = 0;
  R[n + 1] - (Lbase * Z[n + 1] + 2 * Z[n + 1] ^ 2) / (4 * Z[n + 1] + 2 * Lbase + 2 * sqrt(5) * Z[n + 1]) = 0;
  J[n + 1] - Q[n + 1] * Q[n + 1] / (65 * S[n + 1] ^ 2 * R[n + 1] ^ (4 / 3)) = 0;
  Z[n + 1] - 574.27 = 0;
  Q[1] - 12500 = 0;
end SV1D;