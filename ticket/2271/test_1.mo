model test_1
protected 
parameter Integer settings1_showPlaceName = 1 ;
parameter Integer settings1_showTransitionName = 1 ;
parameter Integer settings1_showDelay = 1 ;
parameter Integer settings1_showCapacity = 2 ;
parameter Integer settings1_animateMarking = 1 ;
parameter Integer settings1_animatePlace = 1 ;
parameter Real settings1_scale = 1 ;
parameter Integer settings1_animateTransition = 1 ;
parameter Real settings1_timeFire = 0.3 ;
parameter Integer settings1_animatePutFireTime = 1 ;
parameter Integer settings1_animateHazardFunc = 1 ;
parameter Integer settings1_animateSpeed = 1 ;
parameter Integer settings1_animateWeightTIarc = 1 ;
parameter Integer settings1_animateTIarc = 1 ;
parameter Integer settings1_N = 10 ;
parameter Real settings1_M = 1 ;
public 
constant Integer P1_nIn = 1 ;
constant Integer P1_nOut = 1 ;
parameter Integer P1_startTokens = 1 ;
parameter Integer P1_minTokens = 0 ;
parameter Integer P1_maxTokens = 1073741823 ;
parameter Integer P1_reStartTokens = P1_startTokens ;
parameter Integer P1_enablingType = 1 ;
parameter Real P1_enablingProbIn[P1_nIn] = fill(1/P1_nIn, P1_nIn) 
  ;
parameter Real P1_enablingProbOut[P1_nOut] = fill(1/P1_nOut, P1_nOut) 
  ;
parameter Integer P1_N = settings1_N ;
protected 
parameter Integer P1_enableOut_nOut = P1_nOut ;
parameter Integer P1_enableIn_nIn = P1_nIn ;
public 
constant Integer T1_nIn = 1 ;
constant Integer T1_nOut = 1 ;
parameter Real T1_delay = 1 ;
protected 
parameter Integer T1_activation_nIn = T1_nIn ;
parameter Integer T1_activation_nOut = T1_nOut ;
public 
constant Integer P2_nIn = 1 ;
constant Integer P2_nOut = 1 ;
parameter Integer P2_startTokens = 0 ;
parameter Integer P2_minTokens = 0 ;
parameter Integer P2_maxTokens = 1073741823 ;
parameter Integer P2_reStartTokens = P2_startTokens ;
parameter Integer P2_enablingType = 1 ;
parameter Real P2_enablingProbIn[P2_nIn] = fill(1/P2_nIn, P2_nIn) 
  ;
parameter Real P2_enablingProbOut[P2_nOut] = fill(1/P2_nOut, P2_nOut) 
  ;
parameter Integer P2_N = settings1_N ;
protected 
parameter Integer P2_enableOut_nOut = P2_nOut ;
parameter Integer P2_enableIn_nIn = P2_nIn ;
public 
constant Integer T2_nIn = 1 ;
constant Integer T2_nOut = 1 ;
parameter Real T2_delay = 1 ;
protected 
parameter Integer T2_activation_nIn = T2_nIn ;
parameter Integer T2_activation_nOut = T2_nOut ;
public 
Integer P1_t(start = P1_startTokens) ;
Boolean P1_reStart = false ;
Real P1_levelCon ;
Integer P1_showPlaceName = settings1_showPlaceName ;
Integer P1_showCapacity = settings1_showCapacity ;
Integer P1_animateMarking = settings1_animateMarking ;
Real P1_color[3] ;
protected 
Real P1_tokenscale ;
Integer P1_pret ;
Integer P1_arcWeightIn[P1_nIn] ;
Integer P1_arcWeightOut[P1_nOut] ;
Boolean P1_tokeninout ;
Boolean P1_fireIn[P1_nIn] ;
Boolean P1_fireOut[P1_nOut] ;
Boolean P1_disTransitionIn[P1_nIn] ;
Boolean P1_disTransitionOut[P1_nOut] ;
Boolean P1_activeIn[P1_nIn] ;
Boolean P1_activeOut[P1_nOut] ;
Boolean P1_enabledByInPlaces[P1_nIn] ;
Boolean P1_activeConOut_vec[:] = pre(P1_activeOut) and  not P1_disTransitionOut;
Boolean P1_activeConOut_anychange;
Boolean P1_delayPassedOut_vec[:] = P1_activeOut and P1_disTransitionOut;
Boolean P1_delayPassedOut_anytrue;
Integer P1_delayPassedOut_numtrue;
Boolean P1_delayPassedIn_vec[:] = P1_activeIn and P1_disTransitionIn;
Boolean P1_delayPassedIn_anytrue;
Integer P1_delayPassedIn_numtrue;
Boolean P1_firingSumIn_fire[:] = P1_fireIn and P1_disTransitionIn 
  ;
Integer P1_firingSumIn_arcWeight[:] = P1_arcWeightIn ;
Integer P1_firingSumIn_firingSum ;
Boolean P1_firingSumOut_fire[:] = P1_fireOut and P1_disTransitionOut 
  ;
Integer P1_firingSumOut_arcWeight[:] = P1_arcWeightOut ;
Integer P1_firingSumOut_firingSum ;
Integer P1_enableOut_arcWeight[:] = P1_arcWeightOut ;
Integer P1_enableOut_t = P1_pret ;
Integer P1_enableOut_minTokens = P1_minTokens ;
Boolean P1_enableOut_TAout[:] = P1_activeOut ;
Integer P1_enableOut_enablingType = P1_enablingType ;
Real P1_enableOut_enablingProb[:] = P1_enablingProbOut ;
Boolean P1_enableOut_disTransition[:] = P1_disTransitionOut ;
Boolean P1_enableOut_delayPassed = P1_delayPassedOut_anytrue ;
Boolean P1_enableOut_activeCon = P1_activeConOut_anychange ;
Boolean P1_enableOut_TEout_[P1_enableOut_nOut] ;
Boolean P1_enableOut_TEout[P1_enableOut_nOut] ;
Integer P1_enableOut_remTAout[P1_enableOut_nOut] ;
Real P1_enableOut_cumEnablingProb[P1_enableOut_nOut] ;
Integer P1_enableOut_arcWeightSum ;
Integer P1_enableOut_nremTAout ;
Integer P1_enableOut_nTAout ;
Integer P1_enableOut_k ;
Integer P1_enableOut_posTE ;
Real P1_enableOut_randNum ;
Real P1_enableOut_sumEnablingProbTAout ;
Boolean P1_enableOut_endWhile;
Integer P1_enableIn_arcWeight[:] = P1_arcWeightIn ;
Integer P1_enableIn_t = P1_pret ;
Integer P1_enableIn_maxTokens = P1_maxTokens ;
Boolean P1_enableIn_TAein[:] = P1_enabledByInPlaces ;
Integer P1_enableIn_enablingType = P1_enablingType ;
Real P1_enableIn_enablingProb[:] = P1_enablingProbIn ;
Boolean P1_enableIn_disTransition[:] = P1_disTransitionIn ;
Boolean P1_enableIn_delayPassed = P1_delayPassedIn_anytrue ;
Boolean P1_enableIn_active[:] = P1_activeIn ;
Boolean P1_enableIn_TEin_[P1_enableIn_nIn] ;
Boolean P1_enableIn_TEin[P1_enableIn_nIn] ;
Integer P1_enableIn_remTAin[P1_enableIn_nIn] ;
Real P1_enableIn_cumEnablingProb[P1_enableIn_nIn] ;
Integer P1_enableIn_arcWeightSum ;
Integer P1_enableIn_nremTAin ;
Integer P1_enableIn_nTAin ;
Integer P1_enableIn_k ;
Integer P1_enableIn_posTE ;
Real P1_enableIn_randNum ;
Real P1_enableIn_sumEnablingProbTAin ;
Boolean P1_enableIn_endWhile;
public 
Boolean P1_inTransition__1___active = P1_activeIn[1] ;
Boolean P1_inTransition__1___fire = P1_fireIn[1] ;
Real P1_inTransition__1___arcWeight ;
Integer P1_inTransition__1___arcWeightint = P1_arcWeightIn[1] ;
Boolean P1_inTransition__1___enabledByInPlaces = P1_enabledByInPlaces[1] 
  ;
Boolean P1_inTransition__1___disTransition = P1_disTransitionIn[1] 
  ;
Real P1_inTransition__1___instSpeed ;
Real P1_inTransition__1___prelimSpeed ;
Real P1_inTransition__1___maxSpeed ;
Real P1_inTransition__1___t = P1_pret ;
Integer P1_inTransition__1___tint = P1_pret ;
Real P1_inTransition__1___maxTokens = P1_maxTokens ;
Integer P1_inTransition__1___maxTokensint = P1_maxTokens ;
Boolean P1_inTransition__1___enable = P1_enableIn_TEin_[1] ;
Real P1_inTransition__1___decreasingFactor = 1 ;
Boolean P1_inTransition__1___disPlace = true ;
Boolean P1_inTransition__1___emptied = false ;
Real P1_inTransition__1___speedSum = 0 ;
Boolean P1_outTransition__1___active = P1_activeOut[1] ;
Boolean P1_outTransition__1___fire = P1_fireOut[1] ;
Real P1_outTransition__1___arcWeight ;
Integer P1_outTransition__1___arcWeightint = P1_arcWeightOut[1] ;
Boolean P1_outTransition__1___disTransition = P1_disTransitionOut[1] 
  ;
Real P1_outTransition__1___instSpeed ;
Real P1_outTransition__1___prelimSpeed ;
Real P1_outTransition__1___maxSpeed ;
Real P1_outTransition__1___t = P1_pret ;
Integer P1_outTransition__1___tint = P1_pret ;
Real P1_outTransition__1___minTokens = P1_minTokens ;
Integer P1_outTransition__1___minTokensint = P1_minTokens ;
Boolean P1_outTransition__1___enable = P1_enableOut_TEout_[1] ;
Real P1_outTransition__1___decreasingFactor = 1 ;
Boolean P1_outTransition__1___disPlace = true ;
Integer P1_outTransition__1___arcType = 1 ;
Boolean P1_outTransition__1___fed = false ;
Real P1_outTransition__1___speedSum = 0 ;
Boolean P1_outTransition__1___tokenInOut = pre(P1_tokeninout) ;
Real P1_outTransition__1___testValue = -1 ;
Integer P1_outTransition__1___testValueint = -1 ;
Integer P1_outTransition__1___normalArc = 2 ;
Modelica.Blocks.Interfaces.IntegerOutput P1_pd_t = P1_t ;
Real T1_arcWeightIn[T1_nIn] = fill(1, T1_nIn) ;
Real T1_arcWeightOut[T1_nOut] = fill(1, T1_nOut) ;
Boolean T1_firingCon = true ;
Integer T1_showTransitionName = settings1_showTransitionName ;
Integer T1_showDelay = settings1_showDelay ;
Real T1_color[3] ;
protected 
Real T1_tIn[T1_nIn] ;
Real T1_tOut[T1_nOut] ;
Real T1_testValue[T1_nIn] ;
Real T1_firingTime ;
Real T1_fireTime ;
Real T1_minTokens[T1_nIn] ;
Real T1_maxTokens[T1_nOut] ;
Real T1_delay_ ;
Integer T1_tIntIn[T1_nIn] ;
Integer T1_tIntOut[T1_nOut] ;
Integer T1_arcType[T1_nIn] ;
Integer T1_arcWeightIntIn[T1_nIn] ;
Integer T1_arcWeightIntOut[T1_nOut] ;
Integer T1_minTokensInt[T1_nIn] ;
Integer T1_maxTokensInt[T1_nOut] ;
Integer T1_testValueInt[T1_nIn] ;
Integer T1_normalArc[T1_nIn] ;
Boolean T1_active ;
Boolean T1_fire ;
Boolean T1_disPlaceIn[T1_nIn] ;
Boolean T1_disPlaceOut[T1_nOut] ;
Boolean T1_enableIn[T1_nIn] ;
Boolean T1_enableOut[T1_nOut] ;
Boolean T1_delayPassed ;
Boolean T1_ani ;
Real T1_activation_tIn[:] = T1_tIn ;
Real T1_activation_tOut[:] = T1_tOut ;
Integer T1_activation_tIntIn[:] = T1_tIntIn ;
Integer T1_activation_tIntOut[:] = T1_tIntOut ;
Integer T1_activation_arcType[:] = T1_arcType ;
Real T1_activation_arcWeightIn[:] = T1_arcWeightIn ;
Integer T1_activation_arcWeightIntIn[:] = T1_arcWeightIntIn ;
Real T1_activation_arcWeightOut[:] = T1_arcWeightOut ;
Integer T1_activation_arcWeightIntOut[:] = T1_arcWeightIntOut ;
Real T1_activation_minTokens[:] = T1_minTokens ;
Integer T1_activation_minTokensInt[:] = T1_minTokensInt ;
Real T1_activation_maxTokens[:] = T1_maxTokens ;
Integer T1_activation_maxTokensInt[:] = T1_maxTokensInt ;
Boolean T1_activation_firingCon = T1_firingCon ;
Boolean T1_activation_disPlaceIn[:] = T1_disPlaceIn ;
Boolean T1_activation_disPlaceOut[:] = T1_disPlaceOut ;
Integer T1_activation_normalArc[:] = T1_normalArc ;
Real T1_activation_testValue[:] = T1_testValue ;
Integer T1_activation_testValueInt[:] = T1_testValueInt ;
Boolean T1_activation_active ;
Boolean T1_enabledByInPlaces_vec[:] = T1_enableIn;
Boolean T1_enabledByInPlaces_alltrue;
Boolean T1_enabledByOutPlaces_vec[:] = T1_enableOut;
Boolean T1_enabledByOutPlaces_alltrue;
public 
Real T1_inPlaces__1___t = T1_tIn[1] ;
Integer T1_inPlaces__1___tint = T1_tIntIn[1] ;
Real T1_inPlaces__1___minTokens = T1_minTokens[1] ;
Integer T1_inPlaces__1___minTokensint = T1_minTokensInt[1] ;
Boolean T1_inPlaces__1___enable = T1_enableIn[1] ;
Real T1_inPlaces__1___decreasingFactor ;
Boolean T1_inPlaces__1___disPlace = T1_disPlaceIn[1] ;
Integer T1_inPlaces__1___arcType = T1_arcType[1] ;
Boolean T1_inPlaces__1___fed ;
Real T1_inPlaces__1___speedSum ;
Boolean T1_inPlaces__1___tokenInOut ;
Real T1_inPlaces__1___testValue = T1_testValue[1] ;
Integer T1_inPlaces__1___testValueint = T1_testValueInt[1] ;
Integer T1_inPlaces__1___normalArc = T1_normalArc[1] ;
Boolean T1_inPlaces__1___active = T1_delayPassed ;
Boolean T1_inPlaces__1___fire = T1_fire ;
Real T1_inPlaces__1___arcWeight = T1_arcWeightIn[1] ;
Integer T1_inPlaces__1___arcWeightint = T1_arcWeightIntIn[1] ;
Boolean T1_inPlaces__1___disTransition = true ;
Real T1_inPlaces__1___instSpeed = 0 ;
Real T1_inPlaces__1___prelimSpeed = 0 ;
Real T1_inPlaces__1___maxSpeed = 0 ;
Real T1_outPlaces__1___t = T1_tOut[1] ;
Integer T1_outPlaces__1___tint = T1_tIntOut[1] ;
Real T1_outPlaces__1___maxTokens = T1_maxTokens[1] ;
Integer T1_outPlaces__1___maxTokensint = T1_maxTokensInt[1] ;
Boolean T1_outPlaces__1___enable = T1_enableOut[1] ;
Real T1_outPlaces__1___decreasingFactor ;
Boolean T1_outPlaces__1___disPlace = T1_disPlaceOut[1] ;
Boolean T1_outPlaces__1___emptied ;
Real T1_outPlaces__1___speedSum ;
Boolean T1_outPlaces__1___active = T1_delayPassed ;
Boolean T1_outPlaces__1___fire = T1_fire ;
Real T1_outPlaces__1___arcWeight = T1_arcWeightOut[1] ;
Integer T1_outPlaces__1___arcWeightint = T1_arcWeightIntOut[1] ;
Boolean T1_outPlaces__1___enabledByInPlaces = T1_enabledByInPlaces_alltrue 
  ;
Boolean T1_outPlaces__1___disTransition = true ;
Real T1_outPlaces__1___instSpeed = 0 ;
Real T1_outPlaces__1___prelimSpeed = 0 ;
Real T1_outPlaces__1___maxSpeed = 0 ;
Integer P2_t(start = P2_startTokens) ;
Boolean P2_reStart = false ;
Real P2_levelCon ;
Integer P2_showPlaceName = settings1_showPlaceName ;
Integer P2_showCapacity = settings1_showCapacity ;
Integer P2_animateMarking = settings1_animateMarking ;
Real P2_color[3] ;
protected 
Real P2_tokenscale ;
Integer P2_pret ;
Integer P2_arcWeightIn[P2_nIn] ;
Integer P2_arcWeightOut[P2_nOut] ;
Boolean P2_tokeninout ;
Boolean P2_fireIn[P2_nIn] ;
Boolean P2_fireOut[P2_nOut] ;
Boolean P2_disTransitionIn[P2_nIn] ;
Boolean P2_disTransitionOut[P2_nOut] ;
Boolean P2_activeIn[P2_nIn] ;
Boolean P2_activeOut[P2_nOut] ;
Boolean P2_enabledByInPlaces[P2_nIn] ;
Boolean P2_activeConOut_vec[:] = pre(P2_activeOut) and  not P2_disTransitionOut;
Boolean P2_activeConOut_anychange;
Boolean P2_delayPassedOut_vec[:] = P2_activeOut and P2_disTransitionOut;
Boolean P2_delayPassedOut_anytrue;
Integer P2_delayPassedOut_numtrue;
Boolean P2_delayPassedIn_vec[:] = P2_activeIn and P2_disTransitionIn;
Boolean P2_delayPassedIn_anytrue;
Integer P2_delayPassedIn_numtrue;
Boolean P2_firingSumIn_fire[:] = P2_fireIn and P2_disTransitionIn 
  ;
Integer P2_firingSumIn_arcWeight[:] = P2_arcWeightIn ;
Integer P2_firingSumIn_firingSum ;
Boolean P2_firingSumOut_fire[:] = P2_fireOut and P2_disTransitionOut 
  ;
Integer P2_firingSumOut_arcWeight[:] = P2_arcWeightOut ;
Integer P2_firingSumOut_firingSum ;
Integer P2_enableOut_arcWeight[:] = P2_arcWeightOut ;
Integer P2_enableOut_t = P2_pret ;
Integer P2_enableOut_minTokens = P2_minTokens ;
Boolean P2_enableOut_TAout[:] = P2_activeOut ;
Integer P2_enableOut_enablingType = P2_enablingType ;
Real P2_enableOut_enablingProb[:] = P2_enablingProbOut ;
Boolean P2_enableOut_disTransition[:] = P2_disTransitionOut ;
Boolean P2_enableOut_delayPassed = P2_delayPassedOut_anytrue ;
Boolean P2_enableOut_activeCon = P2_activeConOut_anychange ;
Boolean P2_enableOut_TEout_[P2_enableOut_nOut] ;
Boolean P2_enableOut_TEout[P2_enableOut_nOut] ;
Integer P2_enableOut_remTAout[P2_enableOut_nOut] ;
Real P2_enableOut_cumEnablingProb[P2_enableOut_nOut] ;
Integer P2_enableOut_arcWeightSum ;
Integer P2_enableOut_nremTAout ;
Integer P2_enableOut_nTAout ;
Integer P2_enableOut_k ;
Integer P2_enableOut_posTE ;
Real P2_enableOut_randNum ;
Real P2_enableOut_sumEnablingProbTAout ;
Boolean P2_enableOut_endWhile;
Integer P2_enableIn_arcWeight[:] = P2_arcWeightIn ;
Integer P2_enableIn_t = P2_pret ;
Integer P2_enableIn_maxTokens = P2_maxTokens ;
Boolean P2_enableIn_TAein[:] = P2_enabledByInPlaces ;
Integer P2_enableIn_enablingType = P2_enablingType ;
Real P2_enableIn_enablingProb[:] = P2_enablingProbIn ;
Boolean P2_enableIn_disTransition[:] = P2_disTransitionIn ;
Boolean P2_enableIn_delayPassed = P2_delayPassedIn_anytrue ;
Boolean P2_enableIn_active[:] = P2_activeIn ;
Boolean P2_enableIn_TEin_[P2_enableIn_nIn] ;
Boolean P2_enableIn_TEin[P2_enableIn_nIn] ;
Integer P2_enableIn_remTAin[P2_enableIn_nIn] ;
Real P2_enableIn_cumEnablingProb[P2_enableIn_nIn] ;
Integer P2_enableIn_arcWeightSum ;
Integer P2_enableIn_nremTAin ;
Integer P2_enableIn_nTAin ;
Integer P2_enableIn_k ;
Integer P2_enableIn_posTE ;
Real P2_enableIn_randNum ;
Real P2_enableIn_sumEnablingProbTAin ;
Boolean P2_enableIn_endWhile;
public 
Boolean P2_inTransition__1___active = P2_activeIn[1] ;
Boolean P2_inTransition__1___fire = P2_fireIn[1] ;
Real P2_inTransition__1___arcWeight ;
Integer P2_inTransition__1___arcWeightint = P2_arcWeightIn[1] ;
Boolean P2_inTransition__1___enabledByInPlaces = P2_enabledByInPlaces[1] 
  ;
Boolean P2_inTransition__1___disTransition = P2_disTransitionIn[1] 
  ;
Real P2_inTransition__1___instSpeed ;
Real P2_inTransition__1___prelimSpeed ;
Real P2_inTransition__1___maxSpeed ;
Real P2_inTransition__1___t = P2_pret ;
Integer P2_inTransition__1___tint = P2_pret ;
Real P2_inTransition__1___maxTokens = P2_maxTokens ;
Integer P2_inTransition__1___maxTokensint = P2_maxTokens ;
Boolean P2_inTransition__1___enable = P2_enableIn_TEin_[1] ;
Real P2_inTransition__1___decreasingFactor = 1 ;
Boolean P2_inTransition__1___disPlace = true ;
Boolean P2_inTransition__1___emptied = false ;
Real P2_inTransition__1___speedSum = 0 ;
Boolean P2_outTransition__1___active = P2_activeOut[1] ;
Boolean P2_outTransition__1___fire = P2_fireOut[1] ;
Real P2_outTransition__1___arcWeight ;
Integer P2_outTransition__1___arcWeightint = P2_arcWeightOut[1] ;
Boolean P2_outTransition__1___disTransition = P2_disTransitionOut[1] 
  ;
Real P2_outTransition__1___instSpeed ;
Real P2_outTransition__1___prelimSpeed ;
Real P2_outTransition__1___maxSpeed ;
Real P2_outTransition__1___t = P2_pret ;
Integer P2_outTransition__1___tint = P2_pret ;
Real P2_outTransition__1___minTokens = P2_minTokens ;
Integer P2_outTransition__1___minTokensint = P2_minTokens ;
Boolean P2_outTransition__1___enable = P2_enableOut_TEout_[1] ;
Real P2_outTransition__1___decreasingFactor = 1 ;
Boolean P2_outTransition__1___disPlace = true ;
Integer P2_outTransition__1___arcType = 1 ;
Boolean P2_outTransition__1___fed = false ;
Real P2_outTransition__1___speedSum = 0 ;
Boolean P2_outTransition__1___tokenInOut = pre(P2_tokeninout) ;
Real P2_outTransition__1___testValue = -1 ;
Integer P2_outTransition__1___testValueint = -1 ;
Integer P2_outTransition__1___normalArc = 2 ;
Modelica.Blocks.Interfaces.IntegerOutput P2_pd_t = P2_t ;
Real T2_arcWeightIn[T2_nIn] = fill(1, T2_nIn) ;
Real T2_arcWeightOut[T2_nOut] = fill(1, T2_nOut) ;
Boolean T2_firingCon = true ;
Integer T2_showTransitionName = settings1_showTransitionName ;
Integer T2_showDelay = settings1_showDelay ;
Real T2_color[3] ;
protected 
Real T2_tIn[T2_nIn] ;
Real T2_tOut[T2_nOut] ;
Real T2_testValue[T2_nIn] ;
Real T2_firingTime ;
Real T2_fireTime ;
Real T2_minTokens[T2_nIn] ;
Real T2_maxTokens[T2_nOut] ;
Real T2_delay_ ;
Integer T2_tIntIn[T2_nIn] ;
Integer T2_tIntOut[T2_nOut] ;
Integer T2_arcType[T2_nIn] ;
Integer T2_arcWeightIntIn[T2_nIn] ;
Integer T2_arcWeightIntOut[T2_nOut] ;
Integer T2_minTokensInt[T2_nIn] ;
Integer T2_maxTokensInt[T2_nOut] ;
Integer T2_testValueInt[T2_nIn] ;
Integer T2_normalArc[T2_nIn] ;
Boolean T2_active ;
Boolean T2_fire ;
Boolean T2_disPlaceIn[T2_nIn] ;
Boolean T2_disPlaceOut[T2_nOut] ;
Boolean T2_enableIn[T2_nIn] ;
Boolean T2_enableOut[T2_nOut] ;
Boolean T2_delayPassed ;
Boolean T2_ani ;
Real T2_activation_tIn[:] = T2_tIn ;
Real T2_activation_tOut[:] = T2_tOut ;
Integer T2_activation_tIntIn[:] = T2_tIntIn ;
Integer T2_activation_tIntOut[:] = T2_tIntOut ;
Integer T2_activation_arcType[:] = T2_arcType ;
Real T2_activation_arcWeightIn[:] = T2_arcWeightIn ;
Integer T2_activation_arcWeightIntIn[:] = T2_arcWeightIntIn ;
Real T2_activation_arcWeightOut[:] = T2_arcWeightOut ;
Integer T2_activation_arcWeightIntOut[:] = T2_arcWeightIntOut ;
Real T2_activation_minTokens[:] = T2_minTokens ;
Integer T2_activation_minTokensInt[:] = T2_minTokensInt ;
Real T2_activation_maxTokens[:] = T2_maxTokens ;
Integer T2_activation_maxTokensInt[:] = T2_maxTokensInt ;
Boolean T2_activation_firingCon = T2_firingCon ;
Boolean T2_activation_disPlaceIn[:] = T2_disPlaceIn ;
Boolean T2_activation_disPlaceOut[:] = T2_disPlaceOut ;
Integer T2_activation_normalArc[:] = T2_normalArc ;
Real T2_activation_testValue[:] = T2_testValue ;
Integer T2_activation_testValueInt[:] = T2_testValueInt ;
Boolean T2_activation_active ;
Boolean T2_enabledByInPlaces_vec[:] = T2_enableIn;
Boolean T2_enabledByInPlaces_alltrue;
Boolean T2_enabledByOutPlaces_vec[:] = T2_enableOut;
Boolean T2_enabledByOutPlaces_alltrue;
public 
Real T2_inPlaces__1___t = T2_tIn[1] ;
Integer T2_inPlaces__1___tint = T2_tIntIn[1] ;
Real T2_inPlaces__1___minTokens = T2_minTokens[1] ;
Integer T2_inPlaces__1___minTokensint = T2_minTokensInt[1] ;
Boolean T2_inPlaces__1___enable = T2_enableIn[1] ;
Real T2_inPlaces__1___decreasingFactor ;
Boolean T2_inPlaces__1___disPlace = T2_disPlaceIn[1] ;
Integer T2_inPlaces__1___arcType = T2_arcType[1] ;
Boolean T2_inPlaces__1___fed ;
Real T2_inPlaces__1___speedSum ;
Boolean T2_inPlaces__1___tokenInOut ;
Real T2_inPlaces__1___testValue = T2_testValue[1] ;
Integer T2_inPlaces__1___testValueint = T2_testValueInt[1] ;
Integer T2_inPlaces__1___normalArc = T2_normalArc[1] ;
Boolean T2_inPlaces__1___active = T2_delayPassed ;
Boolean T2_inPlaces__1___fire = T2_fire ;
Real T2_inPlaces__1___arcWeight = T2_arcWeightIn[1] ;
Integer T2_inPlaces__1___arcWeightint = T2_arcWeightIntIn[1] ;
Boolean T2_inPlaces__1___disTransition = true ;
Real T2_inPlaces__1___instSpeed = 0 ;
Real T2_inPlaces__1___prelimSpeed = 0 ;
Real T2_inPlaces__1___maxSpeed = 0 ;
Real T2_outPlaces__1___t = T2_tOut[1] ;
Integer T2_outPlaces__1___tint = T2_tIntOut[1] ;
Real T2_outPlaces__1___maxTokens = T2_maxTokens[1] ;
Integer T2_outPlaces__1___maxTokensint = T2_maxTokensInt[1] ;
Boolean T2_outPlaces__1___enable = T2_enableOut[1] ;
Real T2_outPlaces__1___decreasingFactor ;
Boolean T2_outPlaces__1___disPlace = T2_disPlaceOut[1] ;
Boolean T2_outPlaces__1___emptied ;
Real T2_outPlaces__1___speedSum ;
Boolean T2_outPlaces__1___active = T2_delayPassed ;
Boolean T2_outPlaces__1___fire = T2_fire ;
Real T2_outPlaces__1___arcWeight = T2_arcWeightOut[1] ;
Integer T2_outPlaces__1___arcWeightint = T2_arcWeightIntOut[1] ;
Boolean T2_outPlaces__1___enabledByInPlaces = T2_enabledByInPlaces_alltrue 
  ;
Boolean T2_outPlaces__1___disTransition = true ;
Real T2_outPlaces__1___instSpeed = 0 ;
Real T2_outPlaces__1___prelimSpeed = 0 ;
Real T2_outPlaces__1___maxSpeed = 0 ;

function Functions_OddsAndEnds_conditionalSumInt
  input Integer vec[:];
  input Boolean con[:];
  output Integer conSum;

algorithm 
  conSum := 0;
  for i in (1:size(vec, 1)) loop
    if (con[i]) then 
      conSum := conSum+vec[i];
    end if;
  end for;
end Functions_OddsAndEnds_conditionalSumInt;
function Functions_OddsAndEnds_deleteElementInt
  input Integer vecin[:];
  input Integer idx;
  output Integer vecout[size(vecin, 1)];
protected 
  parameter Integer nVec = size(vecin, 1);
  public 
algorithm 
  vecout[1:idx-1] := vecin[1:idx-1];
  vecout[idx:nVec-1] := vecin[idx+1:nVec];
  vecout[nVec] := 0;
end Functions_OddsAndEnds_deleteElementInt;

      impure function Functions_Random_random
        output Integer x;
        external "C" x = _random() annotation(Include = "#include <stdlib.h>
                                                         int _random()
                                                         {
                                                           static int called=0;
                                                           int i;
                                                           if(!called)
                                                           { 
                                                             srand((unsigned) time(NULL));
                                                             called=1;
                                                           }
                                                           return rand();
                                                         }");
      end Functions_Random_random;

  algorithm
    P1_activeConOut_anychange := false;
    for i in (1:size(P1_activeConOut_vec, 1)) loop
      P1_activeConOut_anychange := P1_activeConOut_anychange or change(
        P1_activeConOut_vec[i]);
    end for;

  algorithm
    P1_delayPassedOut_anytrue := false;
    P1_delayPassedOut_numtrue := 0;
    for i in (1:size(P1_delayPassedOut_vec, 1)) loop
      P1_delayPassedOut_anytrue := P1_delayPassedOut_anytrue or P1_delayPassedOut_vec
        [i];
      if (P1_delayPassedOut_vec[i]) then 
        P1_delayPassedOut_numtrue := P1_delayPassedOut_numtrue+1;
      end if;
    end for;

  algorithm
    P1_delayPassedIn_anytrue := false;
    P1_delayPassedIn_numtrue := 0;
    for i in (1:size(P1_delayPassedIn_vec, 1)) loop
      P1_delayPassedIn_anytrue := P1_delayPassedIn_anytrue or P1_delayPassedIn_vec
        [i];
      if (P1_delayPassedIn_vec[i]) then 
        P1_delayPassedIn_numtrue := P1_delayPassedIn_numtrue+1;
      end if;
    end for;

  algorithm
    P1_firingSumIn_firingSum := 0;
    for i in (1:size(P1_firingSumIn_fire, 1)) loop
      if (P1_firingSumIn_fire[i]) then 
        P1_firingSumIn_firingSum := P1_firingSumIn_firingSum+P1_firingSumIn_arcWeight
          [i];
      end if;
    end for;

  algorithm
    P1_firingSumOut_firingSum := 0;
    for i in (1:size(P1_firingSumOut_fire, 1)) loop
      if (P1_firingSumOut_fire[i]) then 
        P1_firingSumOut_firingSum := P1_firingSumOut_firingSum+P1_firingSumOut_arcWeight
          [i];
      end if;
    end for;

  algorithm
    when P1_enableOut_delayPassed or P1_enableOut_activeCon then
      if (P1_enableOut_nOut > 0) then 
        P1_enableOut_TEout := fill(false, P1_enableOut_nOut);
        P1_enableOut_arcWeightSum := Functions_OddsAndEnds_conditionalSumInt
          (P1_enableOut_arcWeight, P1_enableOut_TAout);
        if (P1_enableOut_t-P1_enableOut_arcWeightSum >= P1_enableOut_minTokens)
           then 
          P1_enableOut_TEout := P1_enableOut_TAout;
        else
          if (P1_enableOut_enablingType == 1) then 
            P1_enableOut_arcWeightSum := 0;
            for i in (1:P1_enableOut_nOut) loop
              if (P1_enableOut_TAout[i] and P1_enableOut_disTransition[i] and 
                P1_enableOut_t-(P1_enableOut_arcWeightSum+P1_enableOut_arcWeight
                [i]) >= P1_enableOut_minTokens) then 
                P1_enableOut_TEout[i] := true;
                P1_enableOut_arcWeightSum := P1_enableOut_arcWeightSum+
                  P1_enableOut_arcWeight[i];
              end if;
            end for;
            for i in (1:P1_enableOut_nOut) loop
              if (P1_enableOut_TAout[i] and  not P1_enableOut_disTransition[i]
                 and P1_enableOut_t-(P1_enableOut_arcWeightSum+P1_enableOut_arcWeight
                [i]) >= P1_enableOut_minTokens) then 
                P1_enableOut_TEout[i] := true;
                P1_enableOut_arcWeightSum := P1_enableOut_arcWeightSum+
                  P1_enableOut_arcWeight[i];
              end if;
            end for;
          else
            P1_enableOut_arcWeightSum := 0;
            P1_enableOut_remTAout := zeros(P1_enableOut_nOut);
            P1_enableOut_nremTAout := 0;
            for i in (1:P1_enableOut_nOut) loop
              if (P1_enableOut_TAout[i] and P1_enableOut_disTransition[i]) then 
                P1_enableOut_nremTAout := P1_enableOut_nremTAout+1;
                P1_enableOut_remTAout[P1_enableOut_nremTAout] := i;
              end if;
            end for;
            P1_enableOut_nTAout := P1_enableOut_nremTAout;
            if (P1_enableOut_nTAout > 0) then 
              P1_enableOut_sumEnablingProbTAout := sum(P1_enableOut_enablingProb
                [P1_enableOut_remTAout[1:P1_enableOut_nremTAout]]);
              P1_enableOut_cumEnablingProb := zeros(P1_enableOut_nOut);
              P1_enableOut_cumEnablingProb[1] := P1_enableOut_enablingProb[
                P1_enableOut_remTAout[1]]/P1_enableOut_sumEnablingProbTAout;
              for j in (2:P1_enableOut_nremTAout) loop
                P1_enableOut_cumEnablingProb[j] := P1_enableOut_cumEnablingProb[
                  j-1]+P1_enableOut_enablingProb[P1_enableOut_remTAout[j]]/
                  P1_enableOut_sumEnablingProbTAout;
              end for;
              P1_enableOut_randNum := Functions_Random_random()/32767;
              for i in (1:P1_enableOut_nTAout) loop
                P1_enableOut_randNum := Functions_Random_random()/32767;
                P1_enableOut_endWhile := false;
                P1_enableOut_k := 1;
                while P1_enableOut_k <= P1_enableOut_nremTAout and  not 
                  P1_enableOut_endWhile loop
                  if (P1_enableOut_randNum <= P1_enableOut_cumEnablingProb[
                    P1_enableOut_k]) then 
                    P1_enableOut_posTE := P1_enableOut_remTAout[P1_enableOut_k];
                    P1_enableOut_endWhile := true;
                  else
                    P1_enableOut_k := P1_enableOut_k+1;
                  end if;
                end while;
                if (P1_enableOut_t-(P1_enableOut_arcWeightSum+P1_enableOut_arcWeight
                  [P1_enableOut_posTE]) >= P1_enableOut_minTokens) then 
                  P1_enableOut_arcWeightSum := P1_enableOut_arcWeightSum+
                    P1_enableOut_arcWeight[P1_enableOut_posTE];
                  P1_enableOut_TEout[P1_enableOut_posTE] := true;
                end if;
                P1_enableOut_nremTAout := P1_enableOut_nremTAout-1;
                if (P1_enableOut_nremTAout > 0) then 
                  P1_enableOut_remTAout := Functions_OddsAndEnds_deleteElementInt
                    (P1_enableOut_remTAout, P1_enableOut_k);
                  P1_enableOut_cumEnablingProb := zeros(P1_enableOut_nOut);
                  P1_enableOut_sumEnablingProbTAout := sum(P1_enableOut_enablingProb
                    [P1_enableOut_remTAout[1:P1_enableOut_nremTAout]]);
                  if (P1_enableOut_sumEnablingProbTAout > 0) then 
                    P1_enableOut_cumEnablingProb[1] := P1_enableOut_enablingProb
                      [P1_enableOut_remTAout[1]]/P1_enableOut_sumEnablingProbTAout;
                    for j in (2:P1_enableOut_nremTAout) loop
                      P1_enableOut_cumEnablingProb[j] := P1_enableOut_cumEnablingProb
                        [j-1]+P1_enableOut_enablingProb[P1_enableOut_remTAout[j]]
                        /P1_enableOut_sumEnablingProbTAout;
                    end for;
                  else
                    P1_enableOut_cumEnablingProb[1:P1_enableOut_nremTAout] := 
                      fill(1/P1_enableOut_nremTAout, P1_enableOut_nremTAout);
                  end if;
                end if;
              end for;
            end if;
            for i in (1:P1_enableOut_nOut) loop
              if (P1_enableOut_TAout[i] and  not P1_enableOut_disTransition[i]
                 and P1_enableOut_t-(P1_enableOut_arcWeightSum+P1_enableOut_arcWeight
                [i]) >= P1_enableOut_minTokens) then 
                P1_enableOut_TEout[i] := true;
                P1_enableOut_arcWeightSum := P1_enableOut_arcWeightSum+
                  P1_enableOut_arcWeight[i];
              end if;
            end for;
          end if;
        end if;
      else
        P1_enableOut_TEout := fill(false, P1_enableOut_nOut);
        P1_enableOut_remTAout := fill(0, P1_enableOut_nOut);
        P1_enableOut_cumEnablingProb := fill(0.0, P1_enableOut_nOut);
        P1_enableOut_arcWeightSum := 0;
        P1_enableOut_nremTAout := 0;
        P1_enableOut_nTAout := 0;
        P1_enableOut_k := 0;
        P1_enableOut_posTE := 0;
        P1_enableOut_randNum := 0;
        P1_enableOut_sumEnablingProbTAout := 0.0;
        P1_enableOut_endWhile := false;
      end if;
    end when;
    P1_enableOut_TEout_ := P1_enableOut_TEout and P1_enableOut_TAout;

  algorithm
    when P1_enableIn_delayPassed then
      if (P1_enableIn_nIn > 0) then 
        P1_enableIn_TEin := fill(false, P1_enableIn_nIn);
        P1_enableIn_arcWeightSum := Functions_OddsAndEnds_conditionalSumInt
          (P1_enableIn_arcWeight, P1_enableIn_TAein);
        if (P1_enableIn_t+P1_enableIn_arcWeightSum <= P1_enableIn_maxTokens)
           then 
          P1_enableIn_TEin := P1_enableIn_TAein;
        else
          if (P1_enableIn_enablingType == 1) then 
            P1_enableIn_arcWeightSum := 0;
            for i in (1:P1_enableIn_nIn) loop
              if (P1_enableIn_TAein[i] and P1_enableIn_disTransition[i] and 
                P1_enableIn_t+P1_enableIn_arcWeightSum+P1_enableIn_arcWeight[i]
                 <= P1_enableIn_maxTokens) then 
                P1_enableIn_TEin[i] := true;
                P1_enableIn_arcWeightSum := P1_enableIn_arcWeightSum+
                  P1_enableIn_arcWeight[i];
              end if;
            end for;
          else
            P1_enableIn_arcWeightSum := 0;
            P1_enableIn_remTAin := zeros(P1_enableIn_nIn);
            P1_enableIn_nremTAin := 0;
            for i in (1:P1_enableIn_nIn) loop
              if (P1_enableIn_TAein[i] and P1_enableIn_disTransition[i]) then 
                P1_enableIn_nremTAin := P1_enableIn_nremTAin+1;
                P1_enableIn_remTAin[P1_enableIn_nremTAin] := i;
              end if;
            end for;
            P1_enableIn_nTAin := P1_enableIn_nremTAin;
            P1_enableIn_sumEnablingProbTAin := sum(P1_enableIn_enablingProb[
              P1_enableIn_remTAin[1:P1_enableIn_nremTAin]]);
            P1_enableIn_cumEnablingProb := zeros(P1_enableIn_nIn);
            P1_enableIn_cumEnablingProb[1] := P1_enableIn_enablingProb[
              P1_enableIn_remTAin[1]]/P1_enableIn_sumEnablingProbTAin;
            for j in (2:P1_enableIn_nremTAin) loop
              P1_enableIn_cumEnablingProb[j] := P1_enableIn_cumEnablingProb[j-1]
                +P1_enableIn_enablingProb[P1_enableIn_remTAin[j]]/
                P1_enableIn_sumEnablingProbTAin;
            end for;
            P1_enableIn_randNum := Functions_Random_random()/32767;
            for i in (1:P1_enableIn_nTAin) loop
              P1_enableIn_randNum := Functions_Random_random()/32767;
              P1_enableIn_endWhile := false;
              P1_enableIn_k := 1;
              while P1_enableIn_k <= P1_enableIn_nremTAin and  not 
                P1_enableIn_endWhile loop
                if (P1_enableIn_randNum <= P1_enableIn_cumEnablingProb[
                  P1_enableIn_k]) then 
                  P1_enableIn_posTE := P1_enableIn_remTAin[P1_enableIn_k];
                  P1_enableIn_endWhile := true;
                else
                  P1_enableIn_k := P1_enableIn_k+1;
                end if;
              end while;
              if (P1_enableIn_t+P1_enableIn_arcWeightSum+P1_enableIn_arcWeight[
                P1_enableIn_posTE] <= P1_enableIn_maxTokens) then 
                P1_enableIn_arcWeightSum := P1_enableIn_arcWeightSum+
                  P1_enableIn_arcWeight[P1_enableIn_posTE];
                P1_enableIn_TEin[P1_enableIn_posTE] := true;
              end if;
              P1_enableIn_nremTAin := P1_enableIn_nremTAin-1;
              if (P1_enableIn_nremTAin > 0) then 
                P1_enableIn_remTAin := Functions_OddsAndEnds_deleteElementInt
                  (P1_enableIn_remTAin, P1_enableIn_k);
                P1_enableIn_cumEnablingProb := zeros(P1_enableIn_nIn);
                P1_enableIn_sumEnablingProbTAin := sum(P1_enableIn_enablingProb[
                  P1_enableIn_remTAin[1:P1_enableIn_nremTAin]]);
                if (P1_enableIn_sumEnablingProbTAin > 0) then 
                  P1_enableIn_cumEnablingProb[1] := P1_enableIn_enablingProb[
                    P1_enableIn_remTAin[1]]/P1_enableIn_sumEnablingProbTAin;
                  for j in (2:P1_enableIn_nremTAin) loop
                    P1_enableIn_cumEnablingProb[j] := P1_enableIn_cumEnablingProb
                      [j-1]+P1_enableIn_enablingProb[P1_enableIn_remTAin[j]]/
                      P1_enableIn_sumEnablingProbTAin;
                  end for;
                else
                  P1_enableIn_cumEnablingProb[1:P1_enableIn_nremTAin] := fill(1/
                    P1_enableIn_nremTAin, P1_enableIn_nremTAin);
                end if;
              end if;
            end for;
          end if;
        end if;
      else
        P1_enableIn_TEin := fill(false, P1_enableIn_nIn);
        P1_enableIn_remTAin := fill(0, P1_enableIn_nIn);
        P1_enableIn_cumEnablingProb := fill(0.0, P1_enableIn_nIn);
        P1_enableIn_arcWeightSum := 0;
        P1_enableIn_nremTAin := 0;
        P1_enableIn_nTAin := 0;
        P1_enableIn_k := 0;
        P1_enableIn_posTE := 0;
        P1_enableIn_randNum := 0;
        P1_enableIn_sumEnablingProbTAin := 0;
        P1_enableIn_endWhile := false;
      end if;
    end when;
    P1_enableIn_TEin_ := P1_enableIn_TEin and P1_enableIn_active;

  equation
    P1_pret = pre(P1_t);
    P1_tokeninout = P1_firingSumIn_firingSum > 0 or P1_firingSumOut_firingSum > 0;
    when P1_tokeninout or pre(P1_reStart) then
      P1_t = (if P1_tokeninout then P1_pret+P1_firingSumIn_firingSum-
        P1_firingSumOut_firingSum else P1_reStartTokens);
    end when;
    P1_levelCon = P1_t*settings1_M/P1_N;
    P1_tokenscale = P1_t*settings1_scale;
    P1_color = (if settings1_animatePlace == 1 then (if P1_tokenscale < 100
       then {255, 255-2.55*P1_tokenscale, 255-2.55*P1_tokenscale} else {255, 0, 0})
       else {255, 255, 255});
    assert(sum(P1_enablingProbIn) == 1 or P1_nIn == 0 or P1_enablingType == 1, 
      "The sum of input enabling probabilities has to be equal to 1");
    assert(sum(P1_enablingProbOut) == 1 or P1_nOut == 0 or P1_enablingType == 1,
       "The sum of output enabling probabilities has to be equal to 1");
    assert(P1_startTokens >= P1_minTokens and P1_startTokens <= P1_maxTokens, 
      "minTokens<=startTokens<=maxTokens");

  algorithm
    T1_activation_active := true;
    for i in (1:T1_activation_nIn) loop
      if (T1_activation_disPlaceIn[i]) then 
        if ((T1_activation_arcType[i] == 1 or T1_activation_normalArc[i] == 2)
           and  not (T1_activation_tIntIn[i]-T1_activation_arcWeightIntIn[i] >= 
          T1_activation_minTokensInt[i])) then 
          T1_activation_active := false;
        elseif (T1_activation_arcType[i] == 2 and  not (T1_activation_tIntIn[i]
           > T1_activation_testValueInt[i])) then 
          T1_activation_active := false;
        elseif (T1_activation_arcType[i] == 3 and  not (T1_activation_tIntIn[i]
           < T1_activation_testValueInt[i])) then 
          T1_activation_active := false;
        end if;
      else
        if ((T1_activation_arcType[i] == 1 or T1_activation_normalArc[i] == 2)
           and  not (T1_activation_tIn[i]-T1_activation_arcWeightIn[i] >= 
          T1_activation_minTokens[i])) then 
          if ( not (T1_activation_tIn[i]+1E-015-T1_activation_arcWeightIn[i] >= 
            T1_activation_minTokens[i])) then 
            T1_activation_active := false;
          end if;
        elseif (T1_activation_arcType[i] == 2 and  not (T1_activation_tIn[i] > 
          T1_activation_testValue[i])) then 
          T1_activation_active := false;
        elseif (T1_activation_arcType[i] == 3 and  not (T1_activation_tIn[i] < 
          T1_activation_testValue[i])) then 
          T1_activation_active := false;
        end if;
      end if;
    end for;
    for i in (1:T1_activation_nOut) loop
      if (T1_activation_disPlaceOut[i]) then 
        if ( not (T1_activation_tIntOut[i]+T1_activation_arcWeightIntOut[i] <= 
          T1_activation_maxTokensInt[i])) then 
          T1_activation_active := false;
        end if;
      else
        if ( not (T1_activation_tOut[i]+T1_activation_arcWeightOut[i] <= 
          T1_activation_maxTokens[i])) then 
          T1_activation_active := false;
        end if;
      end if;
    end for;
    T1_activation_active := T1_activation_active and T1_activation_firingCon;

  algorithm
    T1_enabledByInPlaces_alltrue := true;
    for i in (1:size(T1_enabledByInPlaces_vec, 1)) loop
      T1_enabledByInPlaces_alltrue := T1_enabledByInPlaces_alltrue and 
        T1_enabledByInPlaces_vec[i];
    end for;

  algorithm
    T1_enabledByOutPlaces_alltrue := true;
    for i in (1:size(T1_enabledByOutPlaces_vec, 1)) loop
      T1_enabledByOutPlaces_alltrue := T1_enabledByOutPlaces_alltrue and 
        T1_enabledByOutPlaces_vec[i];
    end for;

  equation
    T1_delay_ = (if T1_delay <= 0 then 1E-006 else T1_delay);
    T1_active = T1_activation_active and  not pre(T1_delayPassed);
    when T1_active then
      T1_firingTime = time+T1_delay_;
    end when;
    T1_delayPassed = T1_active and time >= T1_firingTime;
    T1_fire = (if T1_nOut == 0 then T1_enabledByInPlaces_alltrue else 
      T1_enabledByOutPlaces_alltrue);
    when T1_fire then
      T1_fireTime = time;
      T1_ani = true;
    end when;
    T1_color = (if T1_fireTime+settings1_timeFire >= time and settings1_animateTransition
       == 1 and T1_ani then {255, 255, 0} else {0, 0, 0});
    for i in (1:T1_nIn) loop
      if (T1_disPlaceIn[i]) then 
        T1_arcWeightIntIn[i] = integer(T1_arcWeightIn[i]);
      else
        T1_arcWeightIntIn[i] = 1;
      end if;
      assert(T1_disPlaceIn[i] and T1_arcWeightIn[i]-T1_arcWeightIntIn[i] <= 0.0
         or  not T1_disPlaceIn[i], "Input arcs connected to discrete places must have integer weights.");
      assert(T1_arcWeightIn[i] >= 0, "Input arc weights must be positive.");
    end for;
    for i in (1:T1_nOut) loop
      if (T1_disPlaceOut[i]) then 
        T1_arcWeightIntOut[i] = integer(T1_arcWeightOut[i]);
      else
        T1_arcWeightIntOut[i] = 1;
      end if;
      assert(T1_disPlaceOut[i] and T1_arcWeightOut[i]-T1_arcWeightIntOut[i] <= 
        0.0 or  not T1_disPlaceOut[i], "Output arcs connected to discrete places must have integer weights.");
      assert(T1_arcWeightOut[i] >= 0, "Output arc weights must be positive.");
    end for;

  algorithm
    P2_activeConOut_anychange := false;
    for i in (1:size(P2_activeConOut_vec, 1)) loop
      P2_activeConOut_anychange := P2_activeConOut_anychange or change(
        P2_activeConOut_vec[i]);
    end for;

  algorithm
    P2_delayPassedOut_anytrue := false;
    P2_delayPassedOut_numtrue := 0;
    for i in (1:size(P2_delayPassedOut_vec, 1)) loop
      P2_delayPassedOut_anytrue := P2_delayPassedOut_anytrue or P2_delayPassedOut_vec
        [i];
      if (P2_delayPassedOut_vec[i]) then 
        P2_delayPassedOut_numtrue := P2_delayPassedOut_numtrue+1;
      end if;
    end for;

  algorithm
    P2_delayPassedIn_anytrue := false;
    P2_delayPassedIn_numtrue := 0;
    for i in (1:size(P2_delayPassedIn_vec, 1)) loop
      P2_delayPassedIn_anytrue := P2_delayPassedIn_anytrue or P2_delayPassedIn_vec
        [i];
      if (P2_delayPassedIn_vec[i]) then 
        P2_delayPassedIn_numtrue := P2_delayPassedIn_numtrue+1;
      end if;
    end for;

  algorithm
    P2_firingSumIn_firingSum := 0;
    for i in (1:size(P2_firingSumIn_fire, 1)) loop
      if (P2_firingSumIn_fire[i]) then 
        P2_firingSumIn_firingSum := P2_firingSumIn_firingSum+P2_firingSumIn_arcWeight
          [i];
      end if;
    end for;

  algorithm
    P2_firingSumOut_firingSum := 0;
    for i in (1:size(P2_firingSumOut_fire, 1)) loop
      if (P2_firingSumOut_fire[i]) then 
        P2_firingSumOut_firingSum := P2_firingSumOut_firingSum+P2_firingSumOut_arcWeight
          [i];
      end if;
    end for;

  algorithm
    when P2_enableOut_delayPassed or P2_enableOut_activeCon then
      if (P2_enableOut_nOut > 0) then 
        P2_enableOut_TEout := fill(false, P2_enableOut_nOut);
        P2_enableOut_arcWeightSum := Functions_OddsAndEnds_conditionalSumInt
          (P2_enableOut_arcWeight, P2_enableOut_TAout);
        if (P2_enableOut_t-P2_enableOut_arcWeightSum >= P2_enableOut_minTokens)
           then 
          P2_enableOut_TEout := P2_enableOut_TAout;
        else
          if (P2_enableOut_enablingType == 1) then 
            P2_enableOut_arcWeightSum := 0;
            for i in (1:P2_enableOut_nOut) loop
              if (P2_enableOut_TAout[i] and P2_enableOut_disTransition[i] and 
                P2_enableOut_t-(P2_enableOut_arcWeightSum+P2_enableOut_arcWeight
                [i]) >= P2_enableOut_minTokens) then 
                P2_enableOut_TEout[i] := true;
                P2_enableOut_arcWeightSum := P2_enableOut_arcWeightSum+
                  P2_enableOut_arcWeight[i];
              end if;
            end for;
            for i in (1:P2_enableOut_nOut) loop
              if (P2_enableOut_TAout[i] and  not P2_enableOut_disTransition[i]
                 and P2_enableOut_t-(P2_enableOut_arcWeightSum+P2_enableOut_arcWeight
                [i]) >= P2_enableOut_minTokens) then 
                P2_enableOut_TEout[i] := true;
                P2_enableOut_arcWeightSum := P2_enableOut_arcWeightSum+
                  P2_enableOut_arcWeight[i];
              end if;
            end for;
          else
            P2_enableOut_arcWeightSum := 0;
            P2_enableOut_remTAout := zeros(P2_enableOut_nOut);
            P2_enableOut_nremTAout := 0;
            for i in (1:P2_enableOut_nOut) loop
              if (P2_enableOut_TAout[i] and P2_enableOut_disTransition[i]) then 
                P2_enableOut_nremTAout := P2_enableOut_nremTAout+1;
                P2_enableOut_remTAout[P2_enableOut_nremTAout] := i;
              end if;
            end for;
            P2_enableOut_nTAout := P2_enableOut_nremTAout;
            if (P2_enableOut_nTAout > 0) then 
              P2_enableOut_sumEnablingProbTAout := sum(P2_enableOut_enablingProb
                [P2_enableOut_remTAout[1:P2_enableOut_nremTAout]]);
              P2_enableOut_cumEnablingProb := zeros(P2_enableOut_nOut);
              P2_enableOut_cumEnablingProb[1] := P2_enableOut_enablingProb[
                P2_enableOut_remTAout[1]]/P2_enableOut_sumEnablingProbTAout;
              for j in (2:P2_enableOut_nremTAout) loop
                P2_enableOut_cumEnablingProb[j] := P2_enableOut_cumEnablingProb[
                  j-1]+P2_enableOut_enablingProb[P2_enableOut_remTAout[j]]/
                  P2_enableOut_sumEnablingProbTAout;
              end for;
              P2_enableOut_randNum := Functions_Random_random()/32767;
              for i in (1:P2_enableOut_nTAout) loop
                P2_enableOut_randNum := Functions_Random_random()/32767;
                P2_enableOut_endWhile := false;
                P2_enableOut_k := 1;
                while P2_enableOut_k <= P2_enableOut_nremTAout and  not 
                  P2_enableOut_endWhile loop
                  if (P2_enableOut_randNum <= P2_enableOut_cumEnablingProb[
                    P2_enableOut_k]) then 
                    P2_enableOut_posTE := P2_enableOut_remTAout[P2_enableOut_k];
                    P2_enableOut_endWhile := true;
                  else
                    P2_enableOut_k := P2_enableOut_k+1;
                  end if;
                end while;
                if (P2_enableOut_t-(P2_enableOut_arcWeightSum+P2_enableOut_arcWeight
                  [P2_enableOut_posTE]) >= P2_enableOut_minTokens) then 
                  P2_enableOut_arcWeightSum := P2_enableOut_arcWeightSum+
                    P2_enableOut_arcWeight[P2_enableOut_posTE];
                  P2_enableOut_TEout[P2_enableOut_posTE] := true;
                end if;
                P2_enableOut_nremTAout := P2_enableOut_nremTAout-1;
                if (P2_enableOut_nremTAout > 0) then 
                  P2_enableOut_remTAout := Functions_OddsAndEnds_deleteElementInt
                    (P2_enableOut_remTAout, P2_enableOut_k);
                  P2_enableOut_cumEnablingProb := zeros(P2_enableOut_nOut);
                  P2_enableOut_sumEnablingProbTAout := sum(P2_enableOut_enablingProb
                    [P2_enableOut_remTAout[1:P2_enableOut_nremTAout]]);
                  if (P2_enableOut_sumEnablingProbTAout > 0) then 
                    P2_enableOut_cumEnablingProb[1] := P2_enableOut_enablingProb
                      [P2_enableOut_remTAout[1]]/P2_enableOut_sumEnablingProbTAout;
                    for j in (2:P2_enableOut_nremTAout) loop
                      P2_enableOut_cumEnablingProb[j] := P2_enableOut_cumEnablingProb
                        [j-1]+P2_enableOut_enablingProb[P2_enableOut_remTAout[j]]
                        /P2_enableOut_sumEnablingProbTAout;
                    end for;
                  else
                    P2_enableOut_cumEnablingProb[1:P2_enableOut_nremTAout] := 
                      fill(1/P2_enableOut_nremTAout, P2_enableOut_nremTAout);
                  end if;
                end if;
              end for;
            end if;
            for i in (1:P2_enableOut_nOut) loop
              if (P2_enableOut_TAout[i] and  not P2_enableOut_disTransition[i]
                 and P2_enableOut_t-(P2_enableOut_arcWeightSum+P2_enableOut_arcWeight
                [i]) >= P2_enableOut_minTokens) then 
                P2_enableOut_TEout[i] := true;
                P2_enableOut_arcWeightSum := P2_enableOut_arcWeightSum+
                  P2_enableOut_arcWeight[i];
              end if;
            end for;
          end if;
        end if;
      else
        P2_enableOut_TEout := fill(false, P2_enableOut_nOut);
        P2_enableOut_remTAout := fill(0, P2_enableOut_nOut);
        P2_enableOut_cumEnablingProb := fill(0.0, P2_enableOut_nOut);
        P2_enableOut_arcWeightSum := 0;
        P2_enableOut_nremTAout := 0;
        P2_enableOut_nTAout := 0;
        P2_enableOut_k := 0;
        P2_enableOut_posTE := 0;
        P2_enableOut_randNum := 0;
        P2_enableOut_sumEnablingProbTAout := 0.0;
        P2_enableOut_endWhile := false;
      end if;
    end when;
    P2_enableOut_TEout_ := P2_enableOut_TEout and P2_enableOut_TAout;

  algorithm
    when P2_enableIn_delayPassed then
      if (P2_enableIn_nIn > 0) then 
        P2_enableIn_TEin := fill(false, P2_enableIn_nIn);
        P2_enableIn_arcWeightSum := Functions_OddsAndEnds_conditionalSumInt
          (P2_enableIn_arcWeight, P2_enableIn_TAein);
        if (P2_enableIn_t+P2_enableIn_arcWeightSum <= P2_enableIn_maxTokens)
           then 
          P2_enableIn_TEin := P2_enableIn_TAein;
        else
          if (P2_enableIn_enablingType == 1) then 
            P2_enableIn_arcWeightSum := 0;
            for i in (1:P2_enableIn_nIn) loop
              if (P2_enableIn_TAein[i] and P2_enableIn_disTransition[i] and 
                P2_enableIn_t+P2_enableIn_arcWeightSum+P2_enableIn_arcWeight[i]
                 <= P2_enableIn_maxTokens) then 
                P2_enableIn_TEin[i] := true;
                P2_enableIn_arcWeightSum := P2_enableIn_arcWeightSum+
                  P2_enableIn_arcWeight[i];
              end if;
            end for;
          else
            P2_enableIn_arcWeightSum := 0;
            P2_enableIn_remTAin := zeros(P2_enableIn_nIn);
            P2_enableIn_nremTAin := 0;
            for i in (1:P2_enableIn_nIn) loop
              if (P2_enableIn_TAein[i] and P2_enableIn_disTransition[i]) then 
                P2_enableIn_nremTAin := P2_enableIn_nremTAin+1;
                P2_enableIn_remTAin[P2_enableIn_nremTAin] := i;
              end if;
            end for;
            P2_enableIn_nTAin := P2_enableIn_nremTAin;
            P2_enableIn_sumEnablingProbTAin := sum(P2_enableIn_enablingProb[
              P2_enableIn_remTAin[1:P2_enableIn_nremTAin]]);
            P2_enableIn_cumEnablingProb := zeros(P2_enableIn_nIn);
            P2_enableIn_cumEnablingProb[1] := P2_enableIn_enablingProb[
              P2_enableIn_remTAin[1]]/P2_enableIn_sumEnablingProbTAin;
            for j in (2:P2_enableIn_nremTAin) loop
              P2_enableIn_cumEnablingProb[j] := P2_enableIn_cumEnablingProb[j-1]
                +P2_enableIn_enablingProb[P2_enableIn_remTAin[j]]/
                P2_enableIn_sumEnablingProbTAin;
            end for;
            P2_enableIn_randNum := Functions_Random_random()/32767;
            for i in (1:P2_enableIn_nTAin) loop
              P2_enableIn_randNum := Functions_Random_random()/32767;
              P2_enableIn_endWhile := false;
              P2_enableIn_k := 1;
              while P2_enableIn_k <= P2_enableIn_nremTAin and  not 
                P2_enableIn_endWhile loop
                if (P2_enableIn_randNum <= P2_enableIn_cumEnablingProb[
                  P2_enableIn_k]) then 
                  P2_enableIn_posTE := P2_enableIn_remTAin[P2_enableIn_k];
                  P2_enableIn_endWhile := true;
                else
                  P2_enableIn_k := P2_enableIn_k+1;
                end if;
              end while;
              if (P2_enableIn_t+P2_enableIn_arcWeightSum+P2_enableIn_arcWeight[
                P2_enableIn_posTE] <= P2_enableIn_maxTokens) then 
                P2_enableIn_arcWeightSum := P2_enableIn_arcWeightSum+
                  P2_enableIn_arcWeight[P2_enableIn_posTE];
                P2_enableIn_TEin[P2_enableIn_posTE] := true;
              end if;
              P2_enableIn_nremTAin := P2_enableIn_nremTAin-1;
              if (P2_enableIn_nremTAin > 0) then 
                P2_enableIn_remTAin := Functions_OddsAndEnds_deleteElementInt
                  (P2_enableIn_remTAin, P2_enableIn_k);
                P2_enableIn_cumEnablingProb := zeros(P2_enableIn_nIn);
                P2_enableIn_sumEnablingProbTAin := sum(P2_enableIn_enablingProb[
                  P2_enableIn_remTAin[1:P2_enableIn_nremTAin]]);
                if (P2_enableIn_sumEnablingProbTAin > 0) then 
                  P2_enableIn_cumEnablingProb[1] := P2_enableIn_enablingProb[
                    P2_enableIn_remTAin[1]]/P2_enableIn_sumEnablingProbTAin;
                  for j in (2:P2_enableIn_nremTAin) loop
                    P2_enableIn_cumEnablingProb[j] := P2_enableIn_cumEnablingProb
                      [j-1]+P2_enableIn_enablingProb[P2_enableIn_remTAin[j]]/
                      P2_enableIn_sumEnablingProbTAin;
                  end for;
                else
                  P2_enableIn_cumEnablingProb[1:P2_enableIn_nremTAin] := fill(1/
                    P2_enableIn_nremTAin, P2_enableIn_nremTAin);
                end if;
              end if;
            end for;
          end if;
        end if;
      else
        P2_enableIn_TEin := fill(false, P2_enableIn_nIn);
        P2_enableIn_remTAin := fill(0, P2_enableIn_nIn);
        P2_enableIn_cumEnablingProb := fill(0.0, P2_enableIn_nIn);
        P2_enableIn_arcWeightSum := 0;
        P2_enableIn_nremTAin := 0;
        P2_enableIn_nTAin := 0;
        P2_enableIn_k := 0;
        P2_enableIn_posTE := 0;
        P2_enableIn_randNum := 0;
        P2_enableIn_sumEnablingProbTAin := 0;
        P2_enableIn_endWhile := false;
      end if;
    end when;
    P2_enableIn_TEin_ := P2_enableIn_TEin and P2_enableIn_active;

  equation
    P2_pret = pre(P2_t);
    P2_tokeninout = P2_firingSumIn_firingSum > 0 or P2_firingSumOut_firingSum > 0;
    when P2_tokeninout or pre(P2_reStart) then
      P2_t = (if P2_tokeninout then P2_pret+P2_firingSumIn_firingSum-
        P2_firingSumOut_firingSum else P2_reStartTokens);
    end when;
    P2_levelCon = P2_t*settings1_M/P2_N;
    P2_tokenscale = P2_t*settings1_scale;
    P2_color = (if settings1_animatePlace == 1 then (if P2_tokenscale < 100
       then {255, 255-2.55*P2_tokenscale, 255-2.55*P2_tokenscale} else {255, 0, 0})
       else {255, 255, 255});
    assert(sum(P2_enablingProbIn) == 1 or P2_nIn == 0 or P2_enablingType == 1, 
      "The sum of input enabling probabilities has to be equal to 1");
    assert(sum(P2_enablingProbOut) == 1 or P2_nOut == 0 or P2_enablingType == 1,
       "The sum of output enabling probabilities has to be equal to 1");
    assert(P2_startTokens >= P2_minTokens and P2_startTokens <= P2_maxTokens, 
      "minTokens<=startTokens<=maxTokens");

  algorithm
    T2_activation_active := true;
    for i in (1:T2_activation_nIn) loop
      if (T2_activation_disPlaceIn[i]) then 
        if ((T2_activation_arcType[i] == 1 or T2_activation_normalArc[i] == 2)
           and  not (T2_activation_tIntIn[i]-T2_activation_arcWeightIntIn[i] >= 
          T2_activation_minTokensInt[i])) then 
          T2_activation_active := false;
        elseif (T2_activation_arcType[i] == 2 and  not (T2_activation_tIntIn[i]
           > T2_activation_testValueInt[i])) then 
          T2_activation_active := false;
        elseif (T2_activation_arcType[i] == 3 and  not (T2_activation_tIntIn[i]
           < T2_activation_testValueInt[i])) then 
          T2_activation_active := false;
        end if;
      else
        if ((T2_activation_arcType[i] == 1 or T2_activation_normalArc[i] == 2)
           and  not (T2_activation_tIn[i]-T2_activation_arcWeightIn[i] >= 
          T2_activation_minTokens[i])) then 
          if ( not (T2_activation_tIn[i]+1E-015-T2_activation_arcWeightIn[i] >= 
            T2_activation_minTokens[i])) then 
            T2_activation_active := false;
          end if;
        elseif (T2_activation_arcType[i] == 2 and  not (T2_activation_tIn[i] > 
          T2_activation_testValue[i])) then 
          T2_activation_active := false;
        elseif (T2_activation_arcType[i] == 3 and  not (T2_activation_tIn[i] < 
          T2_activation_testValue[i])) then 
          T2_activation_active := false;
        end if;
      end if;
    end for;
    for i in (1:T2_activation_nOut) loop
      if (T2_activation_disPlaceOut[i]) then 
        if ( not (T2_activation_tIntOut[i]+T2_activation_arcWeightIntOut[i] <= 
          T2_activation_maxTokensInt[i])) then 
          T2_activation_active := false;
        end if;
      else
        if ( not (T2_activation_tOut[i]+T2_activation_arcWeightOut[i] <= 
          T2_activation_maxTokens[i])) then 
          T2_activation_active := false;
        end if;
      end if;
    end for;
    T2_activation_active := T2_activation_active and T2_activation_firingCon;

  algorithm
    T2_enabledByInPlaces_alltrue := true;
    for i in (1:size(T2_enabledByInPlaces_vec, 1)) loop
      T2_enabledByInPlaces_alltrue := T2_enabledByInPlaces_alltrue and 
        T2_enabledByInPlaces_vec[i];
    end for;

  algorithm
    T2_enabledByOutPlaces_alltrue := true;
    for i in (1:size(T2_enabledByOutPlaces_vec, 1)) loop
      T2_enabledByOutPlaces_alltrue := T2_enabledByOutPlaces_alltrue and 
        T2_enabledByOutPlaces_vec[i];
    end for;

  equation
    T2_delay_ = (if T2_delay <= 0 then 1E-006 else T2_delay);
    T2_active = T2_activation_active and  not pre(T2_delayPassed);
    when T2_active then
      T2_firingTime = time+T2_delay_;
    end when;
    T2_delayPassed = T2_active and time >= T2_firingTime;
    T2_fire = (if T2_nOut == 0 then T2_enabledByInPlaces_alltrue else 
      T2_enabledByOutPlaces_alltrue);
    when T2_fire then
      T2_fireTime = time;
      T2_ani = true;
    end when;
    T2_color = (if T2_fireTime+settings1_timeFire >= time and settings1_animateTransition
       == 1 and T2_ani then {255, 255, 0} else {0, 0, 0});
    for i in (1:T2_nIn) loop
      if (T2_disPlaceIn[i]) then 
        T2_arcWeightIntIn[i] = integer(T2_arcWeightIn[i]);
      else
        T2_arcWeightIntIn[i] = 1;
      end if;
      assert(T2_disPlaceIn[i] and T2_arcWeightIn[i]-T2_arcWeightIntIn[i] <= 0.0
         or  not T2_disPlaceIn[i], "Input arcs connected to discrete places must have integer weights.");
      assert(T2_arcWeightIn[i] >= 0, "Input arc weights must be positive.");
    end for;
    for i in (1:T2_nOut) loop
      if (T2_disPlaceOut[i]) then 
        T2_arcWeightIntOut[i] = integer(T2_arcWeightOut[i]);
      else
        T2_arcWeightIntOut[i] = 1;
      end if;
      assert(T2_disPlaceOut[i] and T2_arcWeightOut[i]-T2_arcWeightIntOut[i] <= 
        0.0 or  not T2_disPlaceOut[i], "Output arcs connected to discrete places must have integer weights.");
      assert(T2_arcWeightOut[i] >= 0, "Output arc weights must be positive.");
    end for;

  equation
    T2_outPlaces__1___active = P1_inTransition__1___active;
    T2_outPlaces__1___arcWeight = P1_inTransition__1___arcWeight;
    T2_outPlaces__1___arcWeightint = P1_inTransition__1___arcWeightint;
    T2_outPlaces__1___decreasingFactor = P1_inTransition__1___decreasingFactor;
    T2_outPlaces__1___disPlace = P1_inTransition__1___disPlace;
    T2_outPlaces__1___disTransition = P1_inTransition__1___disTransition;
    T2_outPlaces__1___emptied = P1_inTransition__1___emptied;
    T2_outPlaces__1___enable = P1_inTransition__1___enable;
    T2_outPlaces__1___enabledByInPlaces = P1_inTransition__1___enabledByInPlaces;
    T2_outPlaces__1___fire = P1_inTransition__1___fire;
    T2_outPlaces__1___instSpeed = P1_inTransition__1___instSpeed;
    T2_outPlaces__1___maxSpeed = P1_inTransition__1___maxSpeed;
    T2_outPlaces__1___maxTokens = P1_inTransition__1___maxTokens;
    T2_outPlaces__1___maxTokensint = P1_inTransition__1___maxTokensint;
    T2_outPlaces__1___prelimSpeed = P1_inTransition__1___prelimSpeed;
    T2_outPlaces__1___speedSum = P1_inTransition__1___speedSum;
    T2_outPlaces__1___t = P1_inTransition__1___t;
    T2_outPlaces__1___tint = P1_inTransition__1___tint;
    T1_inPlaces__1___active = P1_outTransition__1___active;
    T1_inPlaces__1___arcType = P1_outTransition__1___arcType;
    T1_inPlaces__1___arcWeight = P1_outTransition__1___arcWeight;
    T1_inPlaces__1___arcWeightint = P1_outTransition__1___arcWeightint;
    T1_inPlaces__1___decreasingFactor = P1_outTransition__1___decreasingFactor;
    T1_inPlaces__1___disPlace = P1_outTransition__1___disPlace;
    T1_inPlaces__1___disTransition = P1_outTransition__1___disTransition;
    T1_inPlaces__1___enable = P1_outTransition__1___enable;
    T1_inPlaces__1___fed = P1_outTransition__1___fed;
    T1_inPlaces__1___fire = P1_outTransition__1___fire;
    T1_inPlaces__1___instSpeed = P1_outTransition__1___instSpeed;
    T1_inPlaces__1___maxSpeed = P1_outTransition__1___maxSpeed;
    T1_inPlaces__1___minTokens = P1_outTransition__1___minTokens;
    T1_inPlaces__1___minTokensint = P1_outTransition__1___minTokensint;
    T1_inPlaces__1___normalArc = P1_outTransition__1___normalArc;
    T1_inPlaces__1___prelimSpeed = P1_outTransition__1___prelimSpeed;
    T1_inPlaces__1___speedSum = P1_outTransition__1___speedSum;
    T1_inPlaces__1___t = P1_outTransition__1___t;
    T1_inPlaces__1___testValue = P1_outTransition__1___testValue;
    T1_inPlaces__1___testValueint = P1_outTransition__1___testValueint;
    T1_inPlaces__1___tint = P1_outTransition__1___tint;
    T1_inPlaces__1___tokenInOut = P1_outTransition__1___tokenInOut;
    T1_outPlaces__1___active = P2_inTransition__1___active;
    T1_outPlaces__1___arcWeight = P2_inTransition__1___arcWeight;
    T1_outPlaces__1___arcWeightint = P2_inTransition__1___arcWeightint;
    T1_outPlaces__1___decreasingFactor = P2_inTransition__1___decreasingFactor;
    T1_outPlaces__1___disPlace = P2_inTransition__1___disPlace;
    T1_outPlaces__1___disTransition = P2_inTransition__1___disTransition;
    T1_outPlaces__1___emptied = P2_inTransition__1___emptied;
    T1_outPlaces__1___enable = P2_inTransition__1___enable;
    T1_outPlaces__1___enabledByInPlaces = P2_inTransition__1___enabledByInPlaces;
    T1_outPlaces__1___fire = P2_inTransition__1___fire;
    T1_outPlaces__1___instSpeed = P2_inTransition__1___instSpeed;
    T1_outPlaces__1___maxSpeed = P2_inTransition__1___maxSpeed;
    T1_outPlaces__1___maxTokens = P2_inTransition__1___maxTokens;
    T1_outPlaces__1___maxTokensint = P2_inTransition__1___maxTokensint;
    T1_outPlaces__1___prelimSpeed = P2_inTransition__1___prelimSpeed;
    T1_outPlaces__1___speedSum = P2_inTransition__1___speedSum;
    T1_outPlaces__1___t = P2_inTransition__1___t;
    T1_outPlaces__1___tint = P2_inTransition__1___tint;
    T2_inPlaces__1___active = P2_outTransition__1___active;
    T2_inPlaces__1___arcType = P2_outTransition__1___arcType;
    T2_inPlaces__1___arcWeight = P2_outTransition__1___arcWeight;
    T2_inPlaces__1___arcWeightint = P2_outTransition__1___arcWeightint;
    T2_inPlaces__1___decreasingFactor = P2_outTransition__1___decreasingFactor;
    T2_inPlaces__1___disPlace = P2_outTransition__1___disPlace;
    T2_inPlaces__1___disTransition = P2_outTransition__1___disTransition;
    T2_inPlaces__1___enable = P2_outTransition__1___enable;
    T2_inPlaces__1___fed = P2_outTransition__1___fed;
    T2_inPlaces__1___fire = P2_outTransition__1___fire;
    T2_inPlaces__1___instSpeed = P2_outTransition__1___instSpeed;
    T2_inPlaces__1___maxSpeed = P2_outTransition__1___maxSpeed;
    T2_inPlaces__1___minTokens = P2_outTransition__1___minTokens;
    T2_inPlaces__1___minTokensint = P2_outTransition__1___minTokensint;
    T2_inPlaces__1___normalArc = P2_outTransition__1___normalArc;
    T2_inPlaces__1___prelimSpeed = P2_outTransition__1___prelimSpeed;
    T2_inPlaces__1___speedSum = P2_outTransition__1___speedSum;
    T2_inPlaces__1___t = P2_outTransition__1___t;
    T2_inPlaces__1___testValue = P2_outTransition__1___testValue;
    T2_inPlaces__1___testValueint = P2_outTransition__1___testValueint;
    T2_inPlaces__1___tint = P2_outTransition__1___tint;
    T2_inPlaces__1___tokenInOut = P2_outTransition__1___tokenInOut;

end test_1;
