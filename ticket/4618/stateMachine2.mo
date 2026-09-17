model stateMachine2

  firstState s1;
  secondState s2;
  Real t;
  Clock c = Clock(0.01);

  block firstState
    Real x1;
  equation 
    x1 = previous(x1)+interval();
  end firstState;

  block secondState
    Real x2;
  equation 
    x2 = previous(x2)+interval();
  end secondState;

equation 
  t = sample(time,c);
  initialState(s1);
  transition(s1, s2, t > 0.5, immediate=  false, reset=  true, synchronize=  false, priority=  1);

end stateMachine2;
