package MAssign
  function MatrixAssign
    output Real A[4, 4];
  algorithm
    A := diagonal(vector(ones(1, 4)));
  end MatrixAssign;

  constant Real H[4,4] := MatrixAssign();

end MAssign;
