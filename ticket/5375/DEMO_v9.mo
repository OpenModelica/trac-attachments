package DEMO_v9

	// Here I have put together a small demo-library to illustrate questions
	// around structuring handling of medium. The key structures are taken
	// from MSL fluid, I think it is fair to say.
	
	// Author: Jan Peter Axelsson
	// 2019-02-06 - Created
	// 2019-02-10 - Changed structure for package Equipment d3_test same and works!
	// 2019-02-13 - Changed  package Equipmnet and try replaceable partial model...
	// 2019-02-15 - Added for HarvesttankType initial value of masses to zero
	// 2019-02-15 - Corrected FeedtankType with right sign for flow
	// 2019-02-15 - Set initial values in Modelia code to simplify for OpenModelica
	// 2019-02-16 - Works!
	// 2019-03-02 - Start to try to extend medium conc vector somwhow
	// 2019-03-02 - Medium2 can be expanded but vector mw difficult
	// 2019-03-04 - Medium2 contant vector mw can be replaced by separate statement
	// 2019-03-04 - Medium3 as extension of Medium2 and run with Test
	// 2019-03-04 - Medium3 simplification for Modelica 3.2 from Hans Olsson
	
//  -------------------------------------------------------------------------------
//     Interfaces  
//  -------------------------------------------------------------------------------

	import Modelica.Blocks.Interfaces.RealInput;
	import Modelica.Blocks.Interfaces.RealOutput;

	package Medium2
		replaceable constant String name = "Two components"    "Medium name";
		replaceable constant Integer nc = 2                    "Number of substances";
		replaceable type Concentration = Real[nc]              "Substance conc";
		replaceable constant Real[nc] mw = {10, 20}            "Substance weight";	
		constant Integer A = 1                                 "Substance index";
		constant Integer B = 2                                 "Substance index";	
	end Medium2;

	package Medium3	
		import M2 = DEMO_v9.Medium2;
		extends M2
			(name="Three components"                           "Medium name",
			 nc=3                                              "Number of substances",
			 mw = cat(1,M2.mw,{30})                            "Substance weight",
			 redeclare type Concentration = Real[nc]           "Substance conc");
		constant Integer C = 3                                 "Substance index";	
	end Medium3;

	connector LiquidCon
	    replaceable package medium=DEMO_v9.Medium3;	
		medium.Concentration c                                 "Substance conc";
		flow Real F (unit="m3/s")                              "Flow rate";
	end LiquidCon;

//  -------------------------------------------------------------------------------
//     Equipment dependent on the medium  
//  -------------------------------------------------------------------------------

	package Equipment

		replaceable partial model EquipmentMedium
			replaceable connector LiquidConType=LiquidCon;
		end EquipmentMedium;

		model PumpType
			extends EquipmentMedium;
			LiquidConType inlet, outlet;
    		input RealInput Fsp;
		equation
    		inlet.F = Fsp;
			connect(outlet, inlet);
		end PumpType;

	    model FeedtankType
			extends EquipmentMedium;
	        LiquidConType outlet;
			constant Integer medium_nc = size(outlet.c,1);
			parameter Real[medium_nc] c_in (each unit="kg/m3") 
							= {1.0*k for k in 1:medium_nc}   "Feed inlet conc";                          
	        parameter Real V_0 (unit="m3") = 100             "Initial feed volume";
	        Real V(start=V_0, fixed=true, unit="m3")         "Feed volume";
	    equation	
			for i in 1:medium_nc loop
				outlet.c[i] = c_in[i];
			end for;
	        der(V) = outlet.F;               
	    end FeedtankType;

	    model HarvesttankType
			extends EquipmentMedium;
	        LiquidConType inlet;
			constant Integer medium_nc = size(inlet.c,1);
	        parameter Real V_0 (unit="m3") = 1.0   "Initial harvest liquid volume";
			parameter Real[medium_nc] m_0 
			      (each unit="kg/m3") = zeros(medium_nc)  "Initial substance mass";
			Real[medium_nc] c                             "Substance conc";
			Real[medium_nc] m 
			      (start=m_0, each fixed=true)            "Substance mass";
	        Real V(start=V_0, fixed=true, unit="m3")      "Harvest liquid volume";
	    equation
			for i in 1:medium_nc loop
				der(m[i]) = inlet.c[i]*inlet.F;
				c[i] = m[i]/V;
			end for;
	        der(V) = inlet.F;               
	    end HarvesttankType;

	end Equipment;
	
//  -------------------------------------------------------------------------------
//     Control 
//  -------------------------------------------------------------------------------

	package Control
		block FixValueType
			output RealOutput out;
			parameter Real val=0;
		equation
			out = val;
		end FixValueType;
	end Control;

//  -------------------------------------------------------------------------------
//     Examples of systems 
//  -------------------------------------------------------------------------------

	model Test
		LiquidCon.medium medium;
		Equipment.FeedtankType feedtank;
		Equipment.HarvesttankType harvesttank;
		Equipment.PumpType pump;
		Control.FixValueType Fsp(val=0.2);
	equation
		connect(feedtank.outlet, pump.inlet);
		connect(pump.outlet, harvesttank.inlet);
		connect(Fsp.out, pump.Fsp);
	end Test;

end DEMO_v9;