package A

  package AA
    model AAA
      parameter Real a(start=0.1);
      parameter Real L(start=0.2);
      Real x;
      Real u;
    equation
      der(x) = -a*L*x + u;
    end AAA;

    partial model AAB
      parameter Real area(start=0.5);
    end AAB;

    model AAC
      extends AAB(final area=aaa1.L+aaa2.L+aaa3.L);
      AAA aaa1(a=0.7,L=0.1);
      AAA aaa2(a=0.01,L=0.4);
      AAA aaa3(a=0.5,L=0.1);
      Real u;
      Real y;
    equation
      u = aaa1.u;
      aaa2.u = aaa1.x;
      aaa3.u = aaa2.x;
      y = aaa3.x;
    end AAC;

    partial model AAD
      replaceable AAC aac(aaa2(L=0.01),aaa3(L=0.012));
      Real u;
      Real y;
    equation
      u = aac.u;
      y = aac.y;
    end AAD;
  end AA;

  package AB
    
    model ABA
      extends AA.AAD(aac(aaa3(L=aac.aaa1.L)));
    end ABA;

    model ABB
      ABA aba;
    equation
      aba.u = sin(0.1*time);
    end ABB;
  end AB;

end A;
