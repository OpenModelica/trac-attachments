package Test
package PNlib2

  package DiskretComponents

    model PDPP "Discrete Place "
      discrete Real t(start = startTokens) "marking";
      parameter Integer nIn = 0 "number of input transitions";
      parameter Integer nOut = 0 "number of output transitions";
      //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
      parameter Real startTokens = 0 "start tokens";
      parameter Real minTokens = 0 "minimum capacity";
      parameter Real maxTokens = PNlib2.Constants.inf "maximum capacity";
      Boolean reStart = false "restart condition";
      parameter Real reStartTokens = startTokens "number of tokens at restart";
      parameter Integer N = settings1.N "N+1=amount of levels";
      //****MODIFIABLE PARAMETERS AND VARIABLES END****//
      Real levelCon
        "conversion of tokens to level concentration according to M and N of the settings box";
      Integer showPlaceName = settings1.showPlaceName
        "only for place animation and display (Do not change!)";
      Integer showCapacity = settings1.showCapacity
        "only for place animation and display (Do not change!)";
      Integer animateMarking = settings1.animateMarking
        "only for place animation and display (Do not change!)";
      Real color[3] "only for place animation and display (Do not change!)";
      //protected
      outer PNlib2.Settings settings1
        "global settings for animation and display";
      Real tokenscale "only for place animation and display";
      //discrete Real pret "pre marking";
      Real pret "pre marking";
      Real arcWeightIn[nIn] "Integer weights of input arcs";
      Real arcWeightOut[nOut] "Integer weights of output arcs";
      Boolean tokeninout "change of tokens?";
      Boolean fireIn[nIn] "Do input transtions fire?";
      Boolean fireOut[nOut] "Do output transitions fire?";
      Boolean activeIn[nIn] "Are delays passed of input transitions?";
      Boolean activeOut[nOut] "Are delay passed of output transitions?";
      Boolean enabledByInPlaces[nIn]
        "Are input transitions are enabled by all their input places?";
      //****BLOCKS BEGIN****// since no events are gePNlib2.DiskretComponents.PDnerated within functions!!!
      //change of activation of output transitions
      PNlib2.Blocks.anyChange activeConOut(vec = pre(activeOut));
      //Does any delay passed of a connected transition?
      PNlib2.Blocks.anyTrue delayPassedOut(vec = activeOut);
      PNlib2.Blocks.anyTrue delayPassedIn(vec = activeIn);
      //firing sum calculation
      PNlib2.Blocks.firingSumDis firingSumIn(fire = fireIn, arcWeight = arcWeightIn);
      PNlib2.Blocks.firingSumDis firingSumOut(fire = fireOut, arcWeight = arcWeightOut);
      //Enabling process
      PNlib2.Blocks.enablingOutDisP enableOut(delayPassed = delayPassedOut.anytrue, activeCon = activeConOut.anychange, nOut = nOut, arcWeight = arcWeightOut, t = pret, minTokens = minTokens, TAout = activeOut);
      PNlib2.Blocks.enablingInDisP enableIn(delayPassed = delayPassedIn.anytrue, active = activeIn, nIn = nIn, arcWeight = arcWeightIn, t = pret, maxTokens = maxTokens, TAein = enabledByInPlaces);
      //****BLOCKS END****//
    public
      PNlib2.Interfaces.InterfacesOhneKonflikt.PlaceIn inTransition[nIn](each t = pret, each maxTokens = maxTokens, enable = enableIn.TEin_, fire = fireIn, arcWeight = arcWeightIn, active = activeIn, enabledByInPlaces = enabledByInPlaces)
        "connector for input transitions";
      PNlib2.Interfaces.InterfacesOhneKonflikt.PlaceOut outTransition[nOut](each t = pret, each minTokens = minTokens, enable = enableOut.TEout_, each tokenInOut = pre(tokeninout), fire = fireOut, arcWeight = arcWeightOut, active = activeOut)
        "connector for output transitions";
      /*Modelica.Blocks.Interfaces.IntegerOutput pd_t=t 
                                                                                                                                                                                        "connector for Simulink connection"                                               annotation (Placement(
                                                                                                                                                                                            transformation(extent={{-36,68},{-16,88}}), iconTransformation(
                                                                                                                                                                                            extent={{-10,-10},{10,10}},
                                                                                                                                                                                            rotation=90,
                                                                                                                                                                                            origin={0,106})));*/
    equation
      //****MAIN BEGIN****//
      //recalculation of tokens
      pret = pre(t);
      tokeninout = firingSumIn.firingSum > 0 or firingSumOut.firingSum > 0;
      when tokeninout or pre(reStart) then
        t = if tokeninout then pret + firingSumIn.firingSum - firingSumOut.firingSum else reStartTokens;
      end when;
      //Conversion of tokens to level concentrations
      levelCon = t * settings1.M / N;
      //****MAIN END****//
      //****ANIMATION BEGIN****//
      tokenscale = t * settings1.scale;
      color = if settings1.animatePlace == 1 then if tokenscale < 100 then {255, 255 - 2.55 * tokenscale, 255 - 2.55 * tokenscale} else {255, 0, 0} else {255, 255, 255};
      //****ANIMATION END****//
      //****ERROR MESSENGES BEGIN****//
      assert(startTokens >= minTokens and startTokens <= maxTokens, "minTokens<=startTokens<=maxTokens");
      //****ERROR MESSENGES END****//
    end PDPP;

    model TDPP "Discrete Transition"
      parameter Integer nIn = 0 "number of input places";
      parameter Integer nOut = 0 "number of output places";
      //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
      parameter Real delay = 1 "delay of timed transition";
      Real arcWeightIn[nIn] = fill(1, nIn) "arc weights of input places";
      Real arcWeightOut[nOut] = fill(1, nOut) "arc weights of output places";
      Boolean firingCon = true "additional firing condition";
      //****MODIFIABLE PARAMETERS AND VARIABLES END****//
      Integer showTransitionName = settings1.showTransitionName
        "only for transition animation and display (Do not change!)";
      Integer showDelay = settings1.showDelay
        "only for transition animation and display (Do not change!)";
      Real color[3]
        "only for transition animation and display (Do not change!)";
      Boolean active "Is the transition active?";
      //protected
      outer PNlib2.Settings settings1
        "global settings for animation and display";
      Real tIn[nIn] "tokens of input places";
      Real tOut[nOut] "tokens of output places";
      Real firingTime "next putative firing time";
      Real fireTime "for transition animation";
      Real minTokens[nIn] "minimum tokens of input places";
      Real maxTokens[nOut] "maximum tokens of output places";
      Real delay_ "due to problems if d==0";
      Boolean fire "Does the transition fire?";
      Boolean enableIn[nIn] "Is the transition enabled by input places?";
      Boolean enableOut[nOut] "Is the transition enabled by output places?";
      Boolean delayPassed "Is the delay passed?";
      Boolean ani "for transition animation";
      //****BLOCKS BEGIN****// since no events are generated within functions!!!
      //activation process
      PNlib2.Blocks.activationDis activation(nIn = nIn, nOut = nOut, tIn = tIn, tOut = tOut, arcWeightIn = arcWeightIn, arcWeightOut = arcWeightOut, minTokens = minTokens, maxTokens = maxTokens, firingCon = firingCon);
      //Is the transition enabled by all input places?
      PNlib2.Blocks.allTrue enabledByInPlaces(vec = enableIn);
      //Is the transition enabled by all output places?
      PNlib2.Blocks.allTrue enabledByOutPlaces(vec = enableOut);
      //****BLOCKS END****//
    public
      PNlib2.Interfaces.InterfacesPrioKonflikt.TransitionIn inPlaces[nIn](each active = delayPassed, arcWeight = arcWeightIn, each fire = fire, t = tIn, minTokens = minTokens, enable = enableIn)
        "connector for input places";
      PNlib2.Interfaces.InterfacesPrioKonflikt.TransitionOut outPlaces[nOut](each active = delayPassed, arcWeight = arcWeightOut, each fire = fire, each enabledByInPlaces = enabledByInPlaces.alltrue, t = tOut, maxTokens = maxTokens, enable = enableOut)
        "connector for output places";
    equation
      //****MAIN BEGIN****//
      delay_ = if delay <= 0 then 10 ^ (-6) else delay;
      //due to event problems if delay==0
      //reset active when delay passed
      active = activation.active and not pre(delayPassed);
      //save next putative firing time
      when active then
        firingTime = time + delay_;
      end when;
      //delay passed?
      delayPassed = active and time >= firingTime;
      //firing process
      fire = if nOut == 0 then enabledByInPlaces.alltrue else enabledByOutPlaces.alltrue;
      //****MAIN END****//
      //****ANIMATION BEGIN****//
      when fire then
        fireTime = time;
        ani = true;
      end when;
      color = if fireTime + settings1.timeFire >= time and settings1.animateTransition == 1 and ani then {255, 255, 0} else {0, 0, 0};
      //****ANIMATION END****//
      //****ERROR MESSENGES BEGIN****//
      for i in 1:nIn loop
        assert(arcWeightIn[i] >= 0, "Input arc weights must be positive.");
      end for;
      for i in 1:nOut loop
        assert(arcWeightOut[i] >= 0, "Output arc weights must be positive.");
      end for;
      //****ERROR MESSENGES END****//
    end TDPP;

    model PDWW "Discrete Place "
      discrete Real t(start = startTokens) "marking";
      parameter Integer nIn = 0 "number of input transitions";
      parameter Integer nOut = 0 "number of output transitions";
      //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
      parameter Real startTokens = 0 "start tokens";
      parameter Real minTokens = 0 "minimum capacity";
      parameter Real maxTokens = PNlib2.Constants.inf "maximum capacity";
      Boolean reStart = false "restart condition";
      parameter Real reStartTokens = startTokens "number of tokens at restart";
      parameter Real enablingProbIn[nIn] = fill(1 / nIn, nIn)
        "enabling probabilities of input transitions";
      parameter Real enablingProbOut[nOut] = fill(1 / nOut, nOut)
        "enabling probabilities of output transitions";
      parameter Integer N = settings1.N "N+1=amount of levels";
      //****MODIFIABLE PARAMETERS AND VARIABLES END****//
      Real levelCon
        "conversion of tokens to level concentration according to M and N of the settings box";
      Integer showPlaceName = settings1.showPlaceName
        "only for place animation and display (Do not change!)";
      Integer showCapacity = settings1.showCapacity
        "only for place animation and display (Do not change!)";
      Integer animateMarking = settings1.animateMarking
        "only for place animation and display (Do not change!)";
      Real color[3] "only for place animation and display (Do not change!)";
      //protected
      outer PNlib2.Settings settings1
        "global settings for animation and display";
      Real tokenscale "only for place animation and display";
      //discrete Real pret "pre marking";
      Real pret "pre marking";
      Real arcWeightIn[nIn] "Integer weights of input arcs";
      Real arcWeightOut[nOut] "Integer weights of output arcs";
      Boolean tokeninout "change of tokens?";
      Boolean fireIn[nIn] "Do input transtions fire?";
      Boolean fireOut[nOut] "Do output transitions fire?";
      Boolean activeIn[nIn] "Are delays passed of input transitions?";
      Boolean activeOut[nOut] "Are delay passed of output transitions?";
      Boolean enabledByInPlaces[nIn]
        "Are input transitions are enabled by all their input places?";
      //****BLOCKS BEGIN****// since no events are gePNlib2.DiskretComponents.PDnerated within functions!!!
      //change of activation of output transitions
      PNlib2.Blocks.anyChange activeConOut(vec = pre(activeOut));
      //Does any delay passed of a connected transition?
      PNlib2.Blocks.anyTrue delayPassedOut(vec = activeOut);
      PNlib2.Blocks.anyTrue delayPassedIn(vec = activeIn);
      //firing sum calculation
      PNlib2.Blocks.firingSumDis firingSumIn(fire = fireIn, arcWeight = arcWeightIn);
      PNlib2.Blocks.firingSumDis firingSumOut(fire = fireOut, arcWeight = arcWeightOut);
      //Enabling process
      PNlib2.Blocks.enablingOutDisW enableOut(delayPassed = delayPassedOut.anytrue, activeCon = activeConOut.anychange, nOut = nOut, arcWeight = arcWeightOut, t = pret, minTokens = minTokens, TAout = activeOut, enablingProb = enablingProbOut);
      PNlib2.Blocks.enablingInDisW enableIn(delayPassed = delayPassedIn.anytrue, active = activeIn, nIn = nIn, arcWeight = arcWeightIn, t = pret, maxTokens = maxTokens, TAein = enabledByInPlaces, enablingProb = enablingProbIn);
      //****BLOCKS END****//
    public
      PNlib2.Interfaces.InterfacesOhneKonflikt.PlaceIn inTransition[nIn](each t = pret, each maxTokens = maxTokens, enable = enableIn.TEin_, fire = fireIn, arcWeight = arcWeightIn, active = activeIn, enabledByInPlaces = enabledByInPlaces)
        "connector for input transitions";
      PNlib2.Interfaces.InterfacesOhneKonflikt.PlaceOut outTransition[nOut](each t = pret, each minTokens = minTokens, enable = enableOut.TEout_, each tokenInOut = pre(tokeninout), fire = fireOut, arcWeight = arcWeightOut, active = activeOut)
        "connector for output transitions";
      /*Modelica.Blocks.Interfaces.IntegerOutput pd_t=t 
                                                                                                                                                                                        "connector for Simulink connection"                                               annotation (Placement(
                                                                                                                                                                                            transformation(extent={{-36,68},{-16,88}}), iconTransformation(
                                                                                                                                                                                            extent={{-10,-10},{10,10}},
                                                                                                                                                                                            rotation=90,
                                                                                                                                                                                            origin={0,106})));*/
    equation
      //****MAIN BEGIN****//
      //recalculation of tokens
      pret = pre(t);
      tokeninout = firingSumIn.firingSum > 0 or firingSumOut.firingSum > 0;
      when tokeninout or pre(reStart) then
        t = if tokeninout then pret + firingSumIn.firingSum - firingSumOut.firingSum else reStartTokens;
      end when;
      //Conversion of tokens to level concentrations
      levelCon = t * settings1.M / N;
      //****MAIN END****//
      //****ANIMATION BEGIN****//
      tokenscale = t * settings1.scale;
      color = if settings1.animatePlace == 1 then if tokenscale < 100 then {255, 255 - 2.55 * tokenscale, 255 - 2.55 * tokenscale} else {255, 0, 0} else {255, 255, 255};
      //****ANIMATION END****//
      //****ERROR MESSENGES BEGIN****//
      assert(abs(sum(enablingProbIn) - 1) < 1e-6 or nIn == 0, "The sum of input enabling probabilities has to be equal to 1");
      assert(abs(sum(enablingProbOut) - 1) < 1e-6 or nOut == 0, "The sum of output enabling probabilities has to be equal to 1");
      assert(startTokens >= minTokens and startTokens <= maxTokens, "minTokens<=startTokens<=maxTokens");
      //****ERROR MESSENGES END****//
    end PDWW;
  end DiskretComponents;

  package Constants
    "contains constants which are used in the Petri net component models"

    constant Real inf = 1e+60
      "Biggest Real number such that inf and -inf are representable on the machine";

    constant Real eps = 1.e-9 "Biggest number such that 1.0 + eps = 1.0";
  end Constants;

  package Blocks "
                                                            contains blocks with specific procedures that are used in the Petri net component models"

    block activationDis "Activation of a discrete transition"
      parameter input Integer nIn "number of input places";
      parameter input Integer nOut "number of output places";
      input Real tIn[:] "tokens of input places";
      input Real tOut[:] "tokens of output places";
      input Real arcWeightIn[:] "arc weights of input places";
      input Real arcWeightOut[:] "arc weights of output places";
      input Real minTokens[:] "minimum capacities of input places";
      input Real maxTokens[:] "maximum capacities of output places";
      input Boolean firingCon "firing condition of transition";
      output Boolean active "activation of transition";
    algorithm
      active := true;
      //check input places
      for i in 1:nIn loop
        if not tIn[i] + Constants.eps - arcWeightIn[i] >= minTokens[i] then
          active := false;
        end if;
      end for;
      //check output places
      for i in 1:nOut loop
        if not tOut[i] - Constants.eps + arcWeightOut[i] <= maxTokens[i] then
          active := false;
        end if;
      end for;
      active := active and firingCon;
    end activationDis;

    block allTrue "Are all entries of a Boolean vector true?"
      input Boolean vec[:];
      output Boolean alltrue;
    algorithm
      alltrue := true;
      for i in 1:size(vec, 1) loop
        alltrue := alltrue and vec[i];
      end for;
    end allTrue;

    block anyTrue "Is any entry of a Boolean vector true?"
      input Boolean vec[:];
      output Boolean anytrue;
      output Integer numtrue;
    algorithm
      anytrue := false;
      numtrue := 0;
      for i in 1:size(vec, 1) loop
        anytrue := anytrue or vec[i];
        if vec[i] then
          numtrue := numtrue + 1;
        end if;
      end for;
    end anyTrue;

    block anyChange "Does any entry of a Boolean vector change its value?"
      input Boolean vec[:];
      output Boolean anychange;
    algorithm
      anychange := false;
      for i in 1:size(vec, 1) loop
        anychange := anychange or change(vec[i]);
      end for;
    end anyChange;

    block firingSumDis "calculates the firing sum of discrete places"
      input Boolean fire[:] "firability of transitions";
      input Real arcWeight[:] "arc weights";
      output Real firingSum "firing sum";
    algorithm
      firingSum := 0;
      for i in 1:size(fire, 1) loop
        if fire[i] then
          firingSum := firingSum + arcWeight[i];
        end if;
      end for;
    end firingSumDis;

    block enablingInDisP "enabling process of discrete input transitions"
      parameter input Integer nIn "number of input transitions";
      input Real arcWeight[:] "arc weights of input transitions";
      input Real t "current token number";
      input Real maxTokens "maximum capacity";
      input Boolean TAein[:]
        "active previous transitions which are already enabled by their input places";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean active[:] "Are the input transitions active?";
      output Boolean TEin_[nIn] "enabled input transitions";
    protected
      Boolean TEin[nIn] "enabled input transitions";
      Real arcWeightSum "arc weight sum";
    algorithm
      TEin := fill(false, nIn);
      when delayPassed then
        if nIn > 0 then
          arcWeightSum := 0;
          for i in 1:nIn loop
            if TAein[i] and t + arcWeightSum + arcWeight[i] <= maxTokens then
              TEin[i] := true;
              arcWeightSum := arcWeightSum + arcWeight[i];
            end if;
          end for;
        else
          arcWeightSum := 0;
        end if;
      end when;
      ///new 07.03.2011
      //arc weight sum of all active input transitions which are already enabled by their input places
      //Place has no actual conflict; all active input transitions are enabled
      TEin_ := TEin and active;
    end enablingInDisP;

    block enablingOutDisP "enabling process of output transitions"
      parameter input Integer nOut "number of output transitions";
      input Real arcWeight[:] "arc weights of output transitions";
      input Real t "current token number";
      input Real minTokens "minimum capacity";
      input Boolean TAout[:] "active output transitions with passed delay";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean activeCon "change of activation of output transitions";
      output Boolean TEout_[nOut] "enabled output transitions";
    protected
      Boolean TEout[nOut] "enabled input transitions";
      Real arcWeightSum "arc weight sum";
    algorithm
      TEout := fill(false, nOut);
      when delayPassed or activeCon then
        if nOut > 0 then
          arcWeightSum := 0;
          for i in 1:nOut loop
            if TAout[i] and t - (arcWeightSum + arcWeight[i]) >= minTokens then
              TEout[i] := true;
              arcWeightSum := arcWeightSum + arcWeight[i];
            end if;
          end for;
        else
          arcWeightSum := 0;
        end if;
      end when;
      //discrete transitions are proven at first
      //arc weight sum of all active output transitions
      //Place has no actual conflict; all active output transitions are enabled
      TEout_ := TEout and TAout;
    end enablingOutDisP;

    block enablingInDisW "enabling process of discrete input transitions"
      parameter input Integer nIn "number of input transitions";
      input Real arcWeight[:] "arc weights of input transitions";
      input Real t "current token number";
      input Real maxTokens "maximum capacity";
      input Boolean TAein[:]
        "active previous transitions which are already enabled by their input places";
      input Real enablingProb[:] "enabling probabilites of input transitions";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean active[:] "Are the input transitions active?";
      output Boolean TEin_[nIn] "enabled input transitions";
    protected
      Boolean TEin[nIn] "enabled input transitions";
      Integer remTAin[nIn] "remaining active input transitions";
      Real cumEnablingProb[nIn] "cumulated, scaled enabling probabilities";
      Real arcWeightSum "arc weight sum";
      Integer nremTAin "number of remaining active input transitions";
      Integer nTAin "number ofactive input transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      Real randNum "uniform distributed random number";
      Real sumEnablingProbTAin
        "sum of the enabling probabilities of the active input transitions";
      Boolean endWhile;
    algorithm
      TEin := fill(false, nIn);
      when delayPassed then
        if nIn > 0 then
          arcWeightSum := 0;
          remTAin := zeros(nIn);
          nremTAin := 0;
          for i in 1:nIn loop
            if TAein[i] then
              nremTAin := nremTAin + 1;
              remTAin[nremTAin] := i;
            end if;
          end for;
          nTAin := nremTAin;
          sumEnablingProbTAin := sum(enablingProb[remTAin[1:nremTAin]]);
          cumEnablingProb := zeros(nIn);
          cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
          for j in 2:nremTAin loop
            cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
          end for;
          randNum := PNlib2.Functions.Random.random() / 32767;
          for i in 1:nTAin loop
            randNum := PNlib2.Functions.Random.random() / 32767;
            endWhile := false;
            k := 1;
            while k <= nremTAin and not endWhile loop
              if randNum <= cumEnablingProb[k] then
                posTE := remTAin[k];
                endWhile := true;
              else
                k := k + 1;
              end if;
            end while;
            if t + arcWeightSum + arcWeight[posTE] <= maxTokens then
              arcWeightSum := arcWeightSum + arcWeight[posTE];
              TEin[posTE] := true;
            end if;
            nremTAin := nremTAin - 1;
            if nremTAin > 0 then
              remTAin := Functions.OddsAndEnds.deleteElementInt(remTAin, k);
              cumEnablingProb := zeros(nIn);
              sumEnablingProbTAin := sum(enablingProb[remTAin[1:nremTAin]]);
              if sumEnablingProbTAin > 0 then
                cumEnablingProb[1] := enablingProb[remTAin[1]] / sumEnablingProbTAin;
                for j in 2:nremTAin loop
                  cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAin[j]] / sumEnablingProbTAin;
                end for;
              else
                cumEnablingProb[1:nremTAin] := fill(1 / nremTAin, nremTAin);
              end if;
            end if;
          end for;
        else
          TEin := fill(false, nIn);
          remTAin := fill(0, nIn);
          cumEnablingProb := fill(0.0, nIn);
          arcWeightSum := 0;
          nremTAin := 0;
          nTAin := 0;
          k := 0;
          posTE := 0;
          randNum := 0;
          sumEnablingProbTAin := 0;
          endWhile := false;
        end if;
      end when;
      //number of active input transitions
      //active input transitions
      //number of active input transitions
      //enabling probability sum of all active input transitions
      //cumulative, scaled enabling probabilities
      //muss hier stehen sonst immer fast gleiche Zufallszahl => immer gleiches enabling
      //uniform distributed random number
      //arc weight sum of all active input transitions which are already enabled by their input places
      //Place has no actual conflict; all active input transitions are enabled
      TEin_ := TEin and active;
    end enablingInDisW;

    block enablingOutDisW "enabling process of output transitions"
      parameter input Integer nOut "number of output transitions";
      input Real arcWeight[:] "arc weights of output transitions";
      input Real t "current token number";
      input Real minTokens "minimum capacity";
      input Boolean TAout[:] "active output transitions with passed delay";
      input Real enablingProb[:] "enabling probabilites of output transitions";
      input Boolean delayPassed "Does any delayPassed of a output transition";
      input Boolean activeCon "change of activation of output transitions";
      output Boolean TEout_[nOut] "enabled output transitions";
    protected
      Boolean TEout[nOut] "enabled output transitions";
      Integer remTAout[nOut] "remaining active output transitions";
      Real cumEnablingProb[nOut] "cumulated, scaled enabling probabilities";
      Real arcWeightSum "arc weight sum";
      Integer nremTAout "number of remaining active output transitions";
      Integer nTAout "number of active output transitions";
      Integer k "iteration index";
      Integer posTE "possible enabled transition";
      Real randNum "uniform distributed random number";
      Real sumEnablingProbTAout
        "sum of the enabling probabilities of the active output transitions";
      Boolean endWhile;
    algorithm
      TEout := fill(false, nOut);
      when delayPassed or activeCon then
        if nOut > 0 then
          arcWeightSum := 0;
          remTAout := zeros(nOut);
          nremTAout := 0;
          for i in 1:nOut loop
            if TAout[i] then
              nremTAout := nremTAout + 1;
              remTAout[nremTAout] := i;
            end if;
          end for;
          nTAout := nremTAout;
          if nTAout > 0 then
            sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);
            cumEnablingProb := zeros(nOut);
            cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
            for j in 2:nremTAout loop
              cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
            end for;
            randNum := PNlib2.Functions.Random.random() / 32767;
            for i in 1:nTAout loop
              randNum := PNlib2.Functions.Random.random() / 32767;
              endWhile := false;
              k := 1;
              while k <= nremTAout and not endWhile loop
                if randNum <= cumEnablingProb[k] then
                  posTE := remTAout[k];
                  endWhile := true;
                else
                  k := k + 1;
                end if;
              end while;
              if t - (arcWeightSum + arcWeight[posTE]) >= minTokens then
                arcWeightSum := arcWeightSum + arcWeight[posTE];
                TEout[posTE] := true;
              end if;
              nremTAout := nremTAout - 1;
              if nremTAout > 0 then
                remTAout := Functions.OddsAndEnds.deleteElementInt(remTAout, k);
                cumEnablingProb := zeros(nOut);
                sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);
                if sumEnablingProbTAout > 0 then
                  cumEnablingProb[1] := enablingProb[remTAout[1]] / sumEnablingProbTAout;
                  for j in 2:nremTAout loop
                    cumEnablingProb[j] := cumEnablingProb[j - 1] + enablingProb[remTAout[j]] / sumEnablingProbTAout;
                  end for;
                else
                  cumEnablingProb[1:nremTAout] := fill(1 / nremTAout, nremTAout);
                end if;
              end if;
            end for;
          end if;
        else
          TEout := fill(false, nOut);
          remTAout := fill(0, nOut);
          cumEnablingProb := fill(0.0, nOut);
          arcWeightSum := 0;
          nremTAout := 0;
          nTAout := 0;
          k := 0;
          posTE := 0;
          randNum := 0;
          sumEnablingProbTAout := 0.0;
          endWhile := false;
        end if;
      end when;
      //number of active output transitions
      //active output transitions
      //number of active output transitions
      //enabling probability sum of all active output transitions
      //cumulative, scaled enabling probabilities
      //muss hier stehen sonst immer fast gleiche Zufallszahl => immer gleiches enabling
      //uniform distributed random number
      //arc weight sum of all active output transitions
      //Place has no actual conflict; all active output transitions are enabled
      TEout_ := TEout and TAout;
    end enablingOutDisW;
  end Blocks;

  package Functions
    "contains functions with specific algorithmic procedures which are used in the Petri net component models"

    package Random "random functions"

      impure function random
        "external C-function to generate uniform distributed random numbers"
        output Integer x;

        external "C" x = _random();
      end random;
    end Random;

    package OddsAndEnds "help functions"

      function deleteElementInt "deletes an element of an integer vector"
        input Integer vecin[:];
        input Integer idx;
        output Integer vecout[size(vecin, 1)];
      protected
        parameter Integer nVec = size(vecin, 1);
      algorithm
        vecout[1:idx - 1] := vecin[1:idx - 1];
        vecout[idx:nVec - 1] := vecin[idx + 1:nVec];
        vecout[nVec] := 0;
      end deleteElementInt;
    end OddsAndEnds;
  end Functions;

  model Settings "Global Settings for Animation and Display"
    parameter Integer showPlaceName = 1 "show names of places";
    parameter Integer showTransitionName = 1 "show names of transitions";
    parameter Integer showDelay = 1 "show delays of discrete transitions";
    parameter Integer showCapacity = 2 "show capacities of places";
    parameter Integer animateMarking = 1 "animation of markings";
    parameter Integer animatePlace = 1 "animation of places";
    parameter Real scale = 1 "scale factor for place animation 0-100";
    parameter Integer animateTransition = 1 "animation of transitions";
    parameter Real timeFire = 0.3 "time of transition animation";
    parameter Integer animatePutFireTime = 1
      "animation of putative fire time of stochastic transitions";
    parameter Integer animateHazardFunc = 1
      "animation of hazard functions of stochastic transitions";
    parameter Integer animateSpeed = 1
      "animation speed of continuous transitions";
    parameter Integer animateWeightTIarc = 1
      "show weights of test and inhibitor arcs";
    parameter Integer animateTIarc = 1 "animation of test and inhibition arcs";
    parameter Integer N = 10 "N+1=amount of levels";
    parameter Real M = 1 "maximum concentration";
  end Settings;

  package Examples

    model TestWkeit
      DiskretComponents.PDWW P1(nIn = 1, nOut = 2, startTokens = 1);
      DiskretComponents.TDPP T1(nOut = 1);
      DiskretComponents.TDPP T2(nIn = 1, nOut = 1);
      DiskretComponents.TDPP T3(nIn = 1, nOut = 1);
      DiskretComponents.PDPP P2(nIn = 1);
      DiskretComponents.PDPP P3(nIn = 1);
      inner PNlib2.Settings settings1;
    equation
      connect(T1.outPlaces[1], P1.inTransition[1]);
      connect(P1.outTransition[1], T2.inPlaces[1]);
      connect(P1.outTransition[2], T3.inPlaces[1]);
      connect(T2.outPlaces[1], P2.inTransition[1]);
      connect(T3.outPlaces[1], P3.inTransition[1]);
    end TestWkeit;
  end Examples;

  package Interfaces

    package InterfacesOhneKonflikt
      "contains the connectors for the Petri net component models"

      connector PlaceOut
        "part of place model to connect places to output transitions"
        input Boolean active "Are the output transitions active?";
        input Boolean fire "Do the output transitions fire?";
        input Real arcWeight "Arc weights of output transitions";
        output Real t "Marking of the place";
        output Real minTokens "Minimum capacity of the place";
        output Boolean enable
          "Which of the output transitions are enabled by the place?";
        output Boolean tokenInOut
          "Does the place have a discrete token change?";
      end PlaceOut;

      connector PlaceIn
        "part of place model to connect places to input transitions"
        input Boolean active "Are the input transitions active?";
        input Boolean fire "Do the input transitions fire?";
        input Real arcWeight "Arc weights of input transitions";
        input Boolean enabledByInPlaces
          "Are the input transitions enabled by all theier input places?";
        output Real t "Marking of the place";
        output Real maxTokens "Maximum capacity of the place";
        output Boolean enable
          "Which of the input transitions are enabled by the place?";
      end PlaceIn;
    end InterfacesOhneKonflikt;

    package InterfacesPrioKonflikt
      "contains the connectors for the Petri net component models"

      connector TransitionIn
        "part of transition model to connect transitions to input places"
        input Real t "Markings of input places";
        input Real minTokens "Minimum capacites of input places";
        input Boolean enable "Is the transition enabled by input places?";
        input Boolean tokenInOut
          "Do the input places have a discrete token change?";
        output Boolean active "Is the transition active?";
        output Boolean fire "Does the transition fire?";
        output Real arcWeight "Input arc weights of the transition";
      end TransitionIn;

      connector TransitionOut
        "part of transition model to connect transitions to output places"
        input Real t "Markings of output places";
        input Real maxTokens "Maximum capacities of output places";
        input Boolean enable "Is the transition enabled by output places?";
        output Boolean active "Is the transition active?";
        output Boolean fire "Does the transition fire?";
        output Real arcWeight "Output arc weights of the transition";
        output Boolean enabledByInPlaces
          "Is the transition enabled by all input places?";
      end TransitionOut;
    end InterfacesPrioKonflikt;
  end Interfaces;
end PNlib2;

model PNlib2_Examples_TestWkeit
 extends PNlib2.Examples.TestWkeit;
  annotation(experiment(
    StopTime=5,
    __Dymola_NumberOfIntervals=500,
    Tolerance=0.0001,
    __Dymola_Algorithm="dassl"), uses(Modelica(version="3.2.1")));
end PNlib2_Examples_TestWkeit;
end Test;