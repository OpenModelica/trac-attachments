within ;
package P

  model A extends A0;
  end A;

  model B
    extends P.A;
  end B;

  model C
    extends P.B;
    extends P.A;
  end C;

  model D
    extends P.B;
  end D;
end P;
