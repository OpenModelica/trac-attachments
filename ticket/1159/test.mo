package PhysicalModels
  block MotorModel
    parameter Real R=1;
    parameter Real L=0.001;
    parameter Real U=12;
    parameter Real kphi=0.1;
    parameter Real J=0.0005;

    Real I(start=0);
    output Real omega(start=0);
    output Real Position(start=-100);
  protected
    Real frc(start=0);

  equation
    frc = if Position > -25 then -50*(Position+25) else 0;
    der(I) = (U - R*I - kphi*omega)/L;
    der(omega) = kphi*I/J + frc;
    der(Position) = omega;
  end MotorModel;

  block Hall
    input Real Position(start=-100);
    output Integer HallSignal(start=0);
    output Integer HallPos(start=0);
  algorithm
    if sin(Position*10.0) > 0 then
      HallSignal := -10;
      HallPos := HallPos + 1;
    elseif sin(Position*10.0) < 0 then
      HallSignal := 0;
      HallPos := HallPos + 1;
    end if;
  end Hall;
end PhysicalModels;


model Motor
  function Count_Fkt
    input Real omega;
    output Integer Counter;
    external "C" Counter = Count_Fkt(omega) annotation(Library="test.o",Include="#include \"test.h\"");
  end Count_Fkt;

  PhysicalModels.MotorModel mot;
  PhysicalModels.Hall hall;
  Integer Counter(start=0);

equation
  connect(mot.Position, hall.Position);

algorithm
  if hall.HallSignal <> pre(hall.HallSignal) then
    Counter := Count_Fkt(mot.omega);
  end if;

end Motor;