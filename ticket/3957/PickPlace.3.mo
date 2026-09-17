model PickPlace
  inner Real y(start=10.0);
  inner Real yd(start=0.0);
  inner Real x(start=10.0);
  inner Real xd(start=0.0);
  inner Boolean inn(start=false);
  inner Boolean down(start=true);
  inner Boolean up(start=false);
  inner Boolean out(start=false);
  inner Boolean pick(start=false);
  inner Boolean drop(start=false);
  inner Integer count(start=1);
  inner Boolean ON(start=false);
  inner Boolean OFF(start=false);

  model VerActDyn
    constant Real m=5.0;
    constant Real b=1.0;
    constant Real k=1.0;
    inner outer output Real y;
    inner outer output Real yd;
    inner outer output Integer count;
    outer input Boolean down;
    outer input Boolean up;
    block StandingStill
    end StandingStill;
    StandingStill standingstill;
    block MovingDown
      outer output Real y;
      outer output Real yd;
      outer output Integer count;
    equation
      yd=-5;
      y=previous(y)+yd*0.002;
      count=previous(count)+1;
    end MovingDown;
    MovingDown movingdown;
    block MovingUp
      outer output Real y;
      outer output Real yd;
    equation
        yd=+5;
        y=previous(y)+yd*0.002;
    end MovingUp;
    MovingUp movingup;
  equation
    initialState(standingstill);
    transition(standingstill,movingdown,down,immediate=true,priority=1);
    transition(standingstill,movingup,up,immediate=true,priority=2);
    transition(movingdown,standingstill,not down,immediate=true);
    transition(movingup,standingstill,not up,immediate=true);
  end VerActDyn;
  VerActDyn veractdyn;

  model HorActDyn
    constant Real m=5.0;
    constant Real b=1.0;
    constant Real k=1.0;
    inner outer output Real x;
    inner outer output Real xd;
    outer input Boolean inn;
    outer input Boolean out;
    block StandingStill
    end StandingStill;
    StandingStill standingstill;
    block MovingOut
      outer output Real x;
      outer output Real xd;
    equation
        xd=+5;
        x=previous(x)+xd*0.002;
    end MovingOut;
    MovingOut movingout;
    block MovingIn
      outer output Real x;
      outer output Real xd;
    equation
        xd=-5;
        x=previous(x)+xd*0.002;
    end MovingIn;
    MovingIn movingin;
  equation
    initialState(standingstill);
    transition(standingstill,movingout,out,immediate=true,priority=1);
    transition(standingstill,movingin,inn,immediate=true,priority=2);
    transition(movingout,standingstill,not out,immediate=true);
    transition(movingin,standingstill,not inn,immediate=true);
  end HorActDyn;
  HorActDyn horactdyn;

  model SensorVup
    constant Real ymax=10.0;
    inner outer output Boolean up;
    inner outer output Boolean out;
    inner outer output Boolean inn;
    inner outer input Integer count;
    outer input Real y;
    block On
      Integer res;
      outer input Integer count;
      outer output Boolean out;
      outer output Boolean inn;
      outer output Boolean up;
    equation
      res=rem(count,2);
      out=res>0;
      inn=res<1;
      up=false;
    end On;
    On on;
    block Off
    end Off;
    Off off;
  equation
    initialState(on);
    transition(on,off,y<ymax,immediate=true);
    transition(off,on,y>=ymax,immediate=true);
  end SensorVup;
  SensorVup sensorvup;

  model SensorVdown
    constant Real ymin=0.0;
    inner outer output Boolean down;
    inner outer output Boolean drop;
    inner outer output Boolean pick;
    inner outer input Integer count;
    outer input Real y;
    block On
      Integer res;
      outer output Boolean down;
      outer output Boolean drop;
      outer output Boolean pick;
      outer input Integer count;
    equation
      res=rem(count,2);
      pick=res>0;
      drop=res<1;
      down=false;
    end On;
    On on;
    block Off
    end Off;
    Off off;
  equation
    initialState(off);
    transition(off,on,y<=ymin,immediate=true);
    transition(on,off,y>ymin,immediate=true);
  end SensorVdown;
  SensorVdown sensorvdown;

  model SensorHout
    constant Real xmax=10.0;
    inner outer output Boolean down;
    inner outer output Boolean out;
    outer input Real x;
    block On
      outer output Boolean down;
      outer output Boolean out;
    equation
      out=false;
      down=true;
    end On;
    On on;
    block Off
    end Off;
    Off off;
  equation
    initialState(off);
    transition(off,on,x>=xmax,immediate=true);
    transition(on,off,x<xmax,immediate=true);
  end SensorHout;
  SensorHout sensorhout;

  model SensorHin
    constant Real xmin=0.0;
    inner outer output Boolean inn;
    inner outer output Boolean down;
    outer input Real x;
    block On
      outer output Boolean inn;
      outer output Boolean down;
    equation
      inn=false;
      down=true;
    end On;
    On on;
    block Off
    end Off;
    Off off;
  equation
    initialState(on);
    transition(on,off,x>xmin,immediate=true);
    transition(off,on,x<=xmin,immediate=true);
  end SensorHin;
  SensorHin sensorhin;

  model Picker
    inner outer output Boolean OFF;
    inner outer output Boolean ON;
    outer input Boolean pick;
    outer input Boolean drop;
    block Open
      outer output Boolean OFF;
    equation
      OFF=true;
    end Open;
    Open open;
    block Closed
      outer output Boolean ON;
    equation
      ON=true;
    end Closed;
    Closed closed;
  equation
    initialState(open);
    transition(open,closed,pick,immediate=true);
    transition(closed,open,drop,immediate=true);
  end Picker;
  Picker picker;

  model SensorPicker
    outer input Boolean OFF;
    outer input Boolean ON;
    inner outer output Boolean up;
    block Off
      outer output Boolean up;
    equation
      up=true;
    end Off;
    Off off;
    block On
      outer output Boolean up;
    equation
      up=true;
    end On;
    On on;
  equation
    initialState(off);
    transition(off,on,ON,immediate=true);
    transition(on,off,OFF,immediate=true);
  end SensorPicker;
  SensorPicker sensorpicker;

end PickPlace;
