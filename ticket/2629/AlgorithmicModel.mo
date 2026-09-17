package AlgorithmicModel
  model BaseModelEquations
    parameter Integer n=1000;
    input Real[n] u1;
    input Real[n] u2;
    output Real[n] y1;
    output Real y2;
  equation 
    y1=array(if u1[i] > 0 then u1[i] else u2[i] for i in 1:n);
    y2=sum(y1);
  end BaseModelEquations;

  model BaseModelAlgorithm
    parameter Integer n=1000;
    input Real[n] u1;
    input Real[n] u2;
    output Real[n] y1;
    output Real y2;
  algorithm 
    y1:=array(if u1[i] > 0 then u1[i] else u2[i] for i in 1:n);
    y2:=sum(y1);
  end BaseModelAlgorithm;

  model ExtendedModelEquations
    extends BaseModelEquations(n=1000);
    Real[n] v1;
  equation 
    v1=u1 - u2;
  end ExtendedModelEquations;

  model ExtendedModelAlgorithm
    extends BaseModelAlgorithm(n=1000);
    Real[n] v1;
  algorithm 
    v1:=u1 - u2;
  end ExtendedModelAlgorithm;

  model ExtendedModelEquations2
    extends BaseModelEquations(n=1000);
    Real[n] v1;
  equation 
    for i in 1:n loop
      v1[i]=u1[i] - u2[i];
    end for;
  end ExtendedModelEquations2;

  model ExtendedModelAlgorithm2
    extends BaseModelAlgorithm(n=1000);
    Real[n] v1;
  algorithm 
    for i in 1:n loop
      v1[i]:=u1[i] - u2[i];
    end for;
  end ExtendedModelAlgorithm2;

end AlgorithmicModel;
