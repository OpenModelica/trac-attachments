model TestMod
  Integer j, j_mod;
  Integer k, k_mod;
algorithm
  when initial() then
    j := -5;
    j_mod := mod(j,3);
   end when;
equation
    k = -5;
    k_mod = mod(k,3);
end TestMod;
