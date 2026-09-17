model Test 
    Real[3,5] M = [1,2,3,5,6; 1,2,3,5,6; 1,2,3,5,6];
    Real[5,3] TM;
equation 
  TM = transpose(M);
end Test;
