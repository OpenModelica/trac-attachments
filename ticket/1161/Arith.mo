model Arith
  
  function wtf
    output Integer res;
  protected
    Integer r;
  algorithm
    r := 1;
    res := 2*(2^r);
  end wtf;

  parameter Integer param = wtf();

end Arith;