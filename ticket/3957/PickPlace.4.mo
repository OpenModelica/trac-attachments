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
  inner Boolean ON(start=false);
  inner Boolean OFF(start=false);
  inner Integer count(start=1);
  inner Real ymax(start=10.0);
  inner Real ymin(start=0.0);
  inner Real xmax(start=10.0);
  inner Real xmin(start=0.0);
    

    block StandingStill
      outer output Real y;
      outer output Real yd;
    equation
      yd=0;
      y=previous(y)+yd*0.002;
    end StandingStill;
    StandingStill standingstill;
    block MovingDown
      outer output Real y;
      outer output Real yd;
      outer output Integer count;
    equation
      yd=-5;
      y=previous(y)+yd*0.002;
      count=count+1;
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


    
  public
    block StandingStilll
      outer output Real x;
      outer output Real xd;
    equation
      xd=0;
      x=previous(x)+xd*0.002;
    end StandingStilll;
    StandingStilll standingstilll;
    block MovingOut
      outer output Real x;
      outer output Real xd;
    equation
      xd=5;
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
    initialState(standingstilll);
    transition(standingstilll,movingout,out,immediate=true,priority=1);
    transition(standingstilll,movingin,inn,immediate=true,priority=2);
    transition(movingout,standingstilll,not out,immediate=true);
    transition(movingin,standingstilll,not inn,immediate=true);


    
  public  
    block On1
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
    end On1;
    On1 on1;
    block Off1
    end Off1;
    Off1 off1;
  equation
    initialState(on1);
    transition(on1,off1,y<ymax,immediate=true);
    transition(off1,on1,y>=ymax,immediate=true);

    
  public  
    block On2
      Integer res;
      outer output Boolean down; 
      outer output Boolean drop;
      outer output Boolean pick;
      outer input Real count;
    equation
      res=rem(count,2);
      pick=res>0;
      drop=res<1;
      down=false;
    end On2;
    On2 on2;
    block Off2
    end Off2;
    Off2 off2;
  equation
    initialState(off2);
    transition(off2,on2,y<=ymin,immediate=true);
    transition(on2,off2,y>ymin,immediate=true);

    
  public  
    block On3
      outer output Boolean down;
      outer output Boolean out;
    equation
      out=false;
      down=true;
    end On3;
    On3 on3;
    block Off3
    end Off3;
    Off3 off3;
  equation
    initialState(off3);
    transition(off3,on3,x>=xmax,immediate=true);
    transition(on3,off3,x<xmax,immediate=true);

   
  public 
    block On4
      outer output Boolean inn;
      outer output Boolean down;
    equation
      inn=false;
      down=true;
    end On4;
    On4 on4;
    block Off4
    end Off4;
    Off4 off4;
  equation
    initialState(on4);
    transition(on4,off4,x>xmin,immediate=true);
    transition(off4,on4,x<=xmin,immediate=true);

  
  public
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

  
  public
    block Off5
      outer output Boolean up;
    equation
      up=true;
    end Off5;
    Off5 off5;
    block On5
      outer output Boolean up;
    equation
      up=true;
    end On5;
    On5 on5;
  equation
    initialState(off5);
    transition(off5,on5,ON,immediate=true);
    transition(on5,off5,OFF,immediate=true);

  
  
end PickPlace;
