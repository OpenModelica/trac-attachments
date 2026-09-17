package myShallowRiver
  // Package for simulating a Shallow River
  // author: 	Bernt Lie
  //			Telemark University College
  //			September 10, 2013
  model compareShallowRiver
    simShallowRiver sr5(NVd = 5),sr10(NVd = 10),sr20(NVd = 20); //,sr50(NVd = 50);
  end compareShallowRiver;
  //
  model simShallowRiver
    // Main Shallow River model
    // author: 	Bernt Lie
    //			Telemark University College
    //			September 10, 2013
	//
	// Constants
	constant Real g = 9.81 "Gravity, m/s2";
    // Parameters
    parameter Real w = 100 "River width, m";
    parameter Real L = 5e3 "River length, m";
    parameter Real H = 57 "River bed drop, m";
	parameter Real th = asin(H/L) "River bed angle, rad";
	parameter Real rho = 1e3 "Density of water, kg/m3";
    parameter Real kS = 20 "Strickler's friction factor, m0.33/s";
    parameter Integer NVd = 18 "Number of momentum balance segments, -";
	parameter Real dx = L/NVd "discretization step, m";
	parameter Real oneh[NVd+1] = ones(NVd+1);
	// Initial state parameters
	parameter Real h0 = 4;// 0.5275 "Initial guess river level, m";
	parameter Real Vd0 = 120 "Initial guess volumetric flow rate, m3/s";
    // Declaring variables
	// -- states
	Real h[NVd+1](each start = h0); //, each fixed = true) "Level states, m";
	Real Vd[NVd](each start = Vd0); //, each fixed = true) "Volumetric flow rates, m3/s";
	// -- auxiliary variables at mass knots
	Real A[NVd+1] "Area perpendicular to flow direction, m2";
	Real per[NVd+1] "Wetting perimeter, m";
	// -- auxiliary variables at momentum knots
	Real h_[NVd] "Staggered levels, m";
	Real A_[NVd] "Staggered areas, m2";
	Real Md_rho_i[NVd] "Input momentum flow/density, m4/s2";
	Real Md_rho_o[NVd] "Output momentum flow/density, m4/s2";
	Real per_[NVd] "Staggered wetted perimeters, m";
	Real R_[NVd] "Staggered hydraulic radii, m";
	Real C_[NVd] "Staggered Chezy coefficient, ...";
	// Real vMd[NVd] "stupid vector";
	// Real vp[NVd] "stupid vector";
	// Real vg[NVd] "stupid vector";
	// Real vf[NVd] "stupid vector";
	Real vMdip[NVd-2] "stupid vector";
	Real vMdim[NVd-2] "stupid vector";
    // -- input variables
    Real Vdin(start = 120);
    Real Vdout(start = 120);
	// -- output variables, scaled
	output Real _Vd, _h;
	// Initializating in steady state
	
  initial equation
	der(h[1:end-1]) = zeros(NVd);
	der(Vd[:]) = zeros(NVd);
	
  // Equations constituting the model
  equation
    // Input values
    //Vdin = 120;
	Vdout = 120;
	
	if time < 1e3 then
		Vdin = 120;
	elseif time < 1.2e3 then
		Vdin = 145;
	else
		Vdin = 120;
	end if;
	
    // Defining auxiliary variables
	A[:] = h[:]*w;
	per[:] = w*oneh[:] + 2*h[:];
	//
	h_[:] = (h[1:end-1] + h[2:end])/2;
	A_[:] = h_[:]*w;
	per_[:] = (per[1:end-1] + per[2:end])/2;
	R_[:] = A_[:]./per_[:];
	C_[:] = kS*((R_[:]).^(1/6));
	//
	Md_rho_i[1] = Vdin^2/A[1];
	for n in 2:NVd-1 loop
		vMdip[n-1] = abs(Vd[n-1])*max(Vd[n-1],0)/A_[n-1];
		vMdim[n-1] = abs(Vd[n+1])*max(-Vd[n+1],0)/A_[n+1];
		Md_rho_i[n] =  vMdip[n-1] + vMdim[n-1];
	end for;
	Md_rho_i[end] = abs(Vd[end-1])*max(Vd[end-1],0)/A_[end-1];
	//
	for n in 1:NVd-1 loop
		Md_rho_o[n] = Vd[n]^2/A_[n];
	end for;
	Md_rho_o[NVd] = Vdout^2/A[NVd+1];
	//
	// vMd[:] = (Md_rho_i[:] - Md_rho_o[:])/dx;
	// vp[:] = g*w*cos(th)*(h[1:end-1].^2 - h[2:end].^2)/(2*dx);
	// vg[:] = A_[:]*g*sin(th);
	// vf[:] = - g*per_[:].*abs(Vd[:]).*Vd[:]./(C_[:].*A_[:]).^2;
    // Differential equations
	der(h[1]) = (Vdin-Vd[1])/(w*dx/2);
	der(h[2:NVd]) = (Vd[1:end-1] - Vd[2:end])/(w*dx);
	der(h[NVd+1]) = (Vd[NVd] - Vdout)/(w*dx/2);
	//
	der(Vd[:]) = (Md_rho_i[:] - Md_rho_o[:])/dx 
		+ g*w*cos(th)*(h[1:end-1].^2 - h[2:end].^2)/(2*dx) 
		+ A_[:]*g*sin(th) 
		- g*per_[:].*abs(Vd[:]).*Vd[:]./(C_[:].*A_[:]).^2;
	// Outputs
	_Vd = Vd[end];
	_h = h[end];
  end simShallowRiver;
  //
  model simShallowRiverWorks
    // Main Shallow River model
    // author: 	Bernt Lie
    //			Telemark University College
    //			September 10, 2013
	//
	// Constants
	constant Real g = 9.81 "Gravity, m/s2";
    // Parameters
    parameter Real w = 100 "River width, m";
    parameter Real L = 5e3 "River length, m";
    parameter Real H = 57 "River bed drop, m";
	parameter Real th = asin(H/L) "River bed angle, rad";
	parameter Real rho = 1e3 "Density of water, kg/m3";
    parameter Real kS = 20 "Strickler's friction factor, m0.33/s";
    parameter Integer NVd = 18 "Number of momentum balance segments, -";
	parameter Real dx = L/NVd "discretization step, m";
	parameter Real oneh[NVd+1] = ones(NVd+1);
	// Initial state parameters
	parameter Real h0 = 4;// 0.5275 "Initial guess river level, m";
	parameter Real Vd0 = 120 "Initial guess volumetric flow rate, m3/s";
    // Declaring variables
	// -- states
	Real h[NVd+1](each start = h0); //, each fixed = true) "Level states, m";
	Real Vd[NVd](each start = Vd0); //, each fixed = true) "Volumetric flow rates, m3/s";
	// -- auxiliary variables at mass knots
	Real A[NVd+1] "Area perpendicular to flow direction, m2";
	Real per[NVd+1] "Wetting perimeter, m";
	// -- auxiliary variables at momentum knots
	Real h_[NVd] "Staggered levels, m";
	Real A_[NVd] "Staggered areas, m2";
	Real Md_rho_i[NVd] "Input momentum flow/density, m4/s2";
	Real Md_rho_o[NVd] "Output momentum flow/density, m4/s2";
	Real per_[NVd] "Staggered wetted perimeters, m";
	Real R_[NVd] "Staggered hydraulic radii, m";
	Real C_[NVd] "Staggered Chezy coefficient, ...";
	Real vMd[NVd] "stupid vector";
	Real vp[NVd] "stupid vector";
	Real vg[NVd] "stupid vector";
	Real vf[NVd] "stupid vector";
	Real vMdip[NVd-2] "stupid vector";
	Real vMdim[NVd-2] "stupid vector";
    // -- input variables
    Real Vdin(start = 120);
    Real Vdout(start = 120);
	// -- output variables, scaled
	output Real _Vd, _h;
	// Initializating in steady state
	
  initial equation
	der(h[1:end-1]) = zeros(NVd);
	der(Vd[:]) = zeros(NVd);
	
  // Equations constituting the model
  equation
    // Input values
    //Vdin = 120;
	Vdout = 120;
	
	if time < 1e3 then
		Vdin = 120;
	elseif time < 1.2e3 then
		Vdin = 145;
	else
		Vdin = 120;
	end if;
	
    // Defining auxiliary variables
	A[:] = h[:]*w;
	per[:] = w*oneh[:] + 2*h[:];
	//
	h_[:] = (h[1:end-1] + h[2:end])/2;
	A_[:] = h_[:]*w;
	per_[:] = (per[1:end-1] + per[2:end])/2;
	R_[:] = A_[:]./per_[:];
	C_[:] = kS*((R_[:]).^(1/6));
	//
	Md_rho_i[1] = Vdin^2/A[1];
	for n in 2:NVd-1 loop
		vMdip[n-1] = abs(Vd[n-1])*max(Vd[n-1],0)/A_[n-1];
		vMdim[n-1] = abs(Vd[n+1])*max(-Vd[n+1],0)/A_[n+1];
		Md_rho_i[n] =  vMdip[n-1] + vMdim[n-1];
	end for;
	Md_rho_i[end] = abs(Vd[end-1])*max(Vd[end-1],0)/A_[end-1];
	//
	for n in 1:NVd-1 loop
		Md_rho_o[n] = Vd[n]^2/A_[n];
	end for;
	Md_rho_o[NVd] = Vdout^2/A[NVd+1];
	//
	vMd[:] = (Md_rho_i[:] - Md_rho_o[:])/dx;
	vp[:] = g*w*cos(th)*(h[1:end-1].^2 - h[2:end].^2)/(2*dx);
	vg[:] = A_[:]*g*sin(th);
	vf[:] = - g*per_[:].*abs(Vd[:]).*Vd[:]./(C_[:].*A_[:]).^2;
    // Differential equations
	der(h[1]) = (Vdin-Vd[1])/(w*dx/2);
	der(h[2:NVd]) = (Vd[1:end-1] - Vd[2:end])/(w*dx);
	der(h[NVd+1]) = (Vd[NVd] - Vdout)/(w*dx/2);
	//
	der(Vd[:]) = vMd[:] + vp[:] + vg[:] + vf[:];
	// Outputs
	_Vd = Vd[end];
	_h = h[end];
  end simShallowRiverWorks;
  // End package
end myShallowRiver;

