within ;
package P
connector RealInput = input Real;
connector RealOutput = output Real;

expandable connector MyBus
end MyBus;

expandable connector MyBusB
end MyBusB;

block MyBlock
  parameter Real k = 0.0;
  RealInput x;
  RealOutput y;
equation
  y = x * k;
end MyBlock;

block Const
  parameter Real k = 0;
  RealOutput y;
equation
  y = k;
end Const;

model B
  parameter Real i = 0;
  MyBlock myBlock(k=i);
  MyBusB busB;
  MyBus bus;
equation
  connect(bus.x, myBlock.x);
  connect(myBlock.y, busB.y);
end B;

model A
  MyBus bus;
  MyBusB busB1;
  MyBusB busB2;
  B b1(i=1);
  B b2(i=2);
  Const const(k=42);
equation
  connect(busB1.y, bus.b1);
  connect(busB2.y, bus.b2);
  connect(busB1, b1.busB);
  connect(busB2, b2.busB);
  connect(bus, b1.bus);
  connect(bus, b2.bus);
  connect(const.y, bus.x);
end A;

end P;