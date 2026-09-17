within ;
package B
  package A

    record MyRecord

      String name;
      Real x;
      Real y;
    end MyRecord;

     constant MyRecord A(name="A",x=1,y=4);
     constant MyRecord B(name="B",x=2,y=3);
     constant MyRecord C(name="C",x=3,y=2);
     constant MyRecord D(name="D",x=4,y=1);

     constant MyRecord[4] data = {A,B,C,D};
     constant Integer nX = scalar(size(data));

     function MyRecord_x
       input MyRecord data;
       output Real x;
     algorithm
       x :=data.x;
     end MyRecord_x;

     function test

      input Real x;
      output Real y;
     algorithm
	 y:= {MyRecord_x(data[i])*x for i in 1:nX }*{MyRecord_x(data[i])*x for i in 1:nX }; 
/*
	 y := 0;
       for i in 1:nX loop
         y := MyRecord_x(data[i])*x;
       end for;
*/
	   end test;
  end A;

  model C
    Real x;
  equation
    der(x) = A.test(x);
  end C;
  annotation (uses(Modelica(version="3.2")));
end B;
