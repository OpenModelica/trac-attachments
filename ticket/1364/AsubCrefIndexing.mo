package AsubCrefIndexing
  model A
    B b;
    C c(s1=b.a2[1], s2=b.a2[2]);
    D d(s11=b.a22[1,1], s12=b.a22[1,2], s21=b.a22[2,1], s22=b.a22[2,2]);
    E e(s111=b.a222[1,1,1], s112=b.a222[1,1,2], s121=b.a222[1,2,1], s122=b.a222[1,2,2], s211=b.a222[2,1,1], s212=b.a222[2,1,2], s221=b.a222[2,2,1], s222=b.a222[2,2,2]);
    F f(s1111=b.a2222[1,1,1,1], s1112=b.a2222[1,1,1,2], s1121=b.a2222[1,1,2,1], s1122=b.a2222[1,1,2,2], s1211=b.a2222[1,2,1,1], s1212=b.a2222[1,2,1,2], s1221=b.a2222[1,2,2,1], s1222=b.a2222[1,2,2,2], s2111=b.a2222[2,1,1,1], s2112=b.a2222[2,1,1,2], s2121=b.a2222[2,1,2,1], s2122=b.a2222[2,1,2,2], s2211=b.a2222[2,2,1,1], s2212=b.a2222[2,2,1,2], s2221=b.a2222[2,2,2,1], s2222=b.a2222[2,2,2,2]);
  end A;

  model B
    final parameter Real a2[2]={1,2};
    final parameter Real a22[2,2]={{1,2},{3,4}};
    final parameter Real a222[2,2,2]={{{1,2},{3,4}},{{5,6},{7,8}}};
    final parameter Real a2222[2,2,2,2]={{{{1,2},{3,4}},{{5,6},{7,8}}},{{{9,10},{11,12}},{{13,14},{15,16}}}};
  end B;

  model E
    Real s111;
    Real s112;
    Real s121;
    Real s122;
    Real s211;
    Real s212;
    Real s221;
    Real s222;
  end E;

  model C
    Real s1;
    Real s2;
  end C;

  model D
    Real s11;
    Real s12;
    Real s21;
    Real s22;
  end D;

  model F
    Real s1111;
    Real s1112;
    Real s1121;
    Real s1122;
    Real s1211;
    Real s1212;
    Real s1221;
    Real s1222;
    Real s2111;
    Real s2112;
    Real s2121;
    Real s2122;
    Real s2211;
    Real s2212;
    Real s2221;
    Real s2222;
  end F;

end AsubCrefIndexing;
