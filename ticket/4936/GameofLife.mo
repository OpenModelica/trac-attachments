within ;
model GameofLife
  parameter Integer n=10; //dimension of the cellular space
  parameter Integer initState[:,2]= [1, 2; 2, 3; 3, 1; 3, 2; 3, 3]; //glider
  Integer state[n,n]; // current state of cells
  Integer newstate[n,n]( start = zeros(n,n)); // new state of cells
  Integer neighbors( start = 0); // number of neighbors alive

initial algorithm
  //when initial() then // set initial configuration for the cells
    for i in 1:n loop
      for j in 1:n loop
        state[i,j] := 0;
      end for;
    end for;

    for i in 1:size(initState,1) loop
      state[initState[i,1],initState[i,2]] := 1;
    end for;
  //end when;

algorithm
  when sample(1,1) then // periodic iterations or steps
    for i in 0:n-1 loop // two for loops to evaluate all cells in the space
      for j in 0:n-1 loop
        neighbors := 1;
        /*neighbors := state[mod(i-1,n)+1,mod(j-1,n)+1]+
                     state[i+1,mod(j-1,n)+1]+
                     state[mod(i+1,n)+1,mod(j-1,n)+1]+
                     state[mod(i-1,n)+1,j+1]+
                     state[mod(i+1,n)+1,j+1]+
                     state[mod(i-1,n)+1,mod(j+1,n)+1]+
                     state[i+1,mod(j+1,n)+1]+
                     state[mod(i+1,n)+1,mod(j+1,n)+1];*/
        if state[i+1,j+1] == 1 then // if alive
          if neighbors < 2  or neighbors > 3 then
            newstate[i+1,j+1] := 0; // dies because of isolation or overpopulation (less than 2 or more than 3 neighbors alive)
          else
            newstate[i+1,j+1] := 1; // otherwise still alive
          end if;
        elseif neighbors == 3 then // if not alive
          newstate[i+1,j+1] := 1; // becomes alive because of reproduction (3 neighbors alive)
        end if;
      end for;
    end for;
    state := newstate; // update state
  end when;

end GameofLife;
