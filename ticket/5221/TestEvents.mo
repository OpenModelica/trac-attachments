model TestEvents
  output Integer counter;
initial equation
  counter = 0;
algorithm
  when sample(0, 0.001) then
    counter := counter + 1;
  end when;
end TestEvents;