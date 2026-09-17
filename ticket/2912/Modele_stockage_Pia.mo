package Modele_stockage_Pia
  package Composants
    package Echangeurs
      model Ech_simplifie
        replaceable package Milieu_fluide_chaud = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
        replaceable package Milieu_fluide_froid = Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true);
        Utilitaires.Connecteurs.Cnctr_Fluide_I fluide_chaud_in annotation(Placement(transformation(extent = {{-82,42},{-62,62}}), iconTransformation(extent = {{-82,42},{-62,62}})));
        Utilitaires.Connecteurs.Cnctr_Fluide_O fluide_chaud_out annotation(Placement(transformation(extent = {{-84,-46},{-64,-26}}), iconTransformation(extent = {{-84,-46},{-64,-26}})));
        Utilitaires.Connecteurs.Cnctr_Fluide_O fluide_froid_out annotation(Placement(transformation(extent = {{68,44},{88,64}}), iconTransformation(extent = {{68,44},{88,64}})));
        Utilitaires.Connecteurs.Cnctr_Fluide_I fluide_froid_in annotation(Placement(transformation(extent = {{68,-46},{88,-26}}), iconTransformation(extent = {{68,-46},{88,-26}})));
        // Parametres de la simulation
        parameter Real pinch_ch = 10 "pincement cote chaud";
        parameter Real pinch_fr = 10 "pincement cote froid";
        Modelica.SIunits.Temperature T_ch_in;
        Modelica.SIunits.Temperature T_ch_out;
        Modelica.SIunits.Temperature T_fr_in;
        Modelica.SIunits.Temperature T_fr_out;
        parameter Real signe = 1 "Mettre (-1) si besoin d'inverse le signe du debit sortant (1 sinon)";
      equation
        //conservation des debits massiques et des pressions (pertes de charges negligees)
        fluide_chaud_in.m = fluide_chaud_out.m;
        fluide_froid_out.m = fluide_froid_in.m;
        fluide_chaud_in.P = fluide_chaud_out.P;
        fluide_froid_out.P = fluide_froid_in.P;
        // Entrees : Traduction des enthalpies donnees par les connecteurs en temperatures:
        T_ch_in = Milieu_fluide_chaud.temperature_phX(fluide_chaud_in.P, fluide_chaud_in.h, {1});
        // Too few arguments ...
        T_fr_in = Milieu_fluide_froid.temperature_phX(fluide_froid_in.P, fluide_froid_in.h, {1});
        // Les temperatures de sortie sont imposees par les pincements
        T_ch_out = T_fr_in + pinch_fr;
        T_fr_out = T_ch_in - pinch_ch;
        // Les temperatures calculees sont alors traduites en enthalpies pour les connnecteurs
        fluide_chaud_out.h = Milieu_fluide_chaud.specificEnthalpy_pTX(fluide_chaud_out.P, T_ch_out, {1});
        fluide_froid_out.h = Milieu_fluide_froid.specificEnthalpy_pTX(fluide_froid_out.P, T_fr_out, {1});
        // Too many arguments ...
        // Bilan thermique: (permet de sortir le debit qui n'a pas ete impose)
        signe * fluide_chaud_in.m * (fluide_chaud_in.h - fluide_chaud_out.h) = fluide_froid_in.m * (fluide_froid_out.h - fluide_froid_in.h);
        // les 2 delta_h sont positif, c'est la variable signe qui determine si les 2 debits sont de meme signe (1) ou de signes contraires (-1).
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-62,54},{-50,50}}, lineColor = {255,0,0}, fillColor = {255,85,85}, fillPattern = FillPattern.Solid),Polygon(points = {{-50,58},{-50,46},{-40,52},{-50,58}}, lineColor = {255,0,0}, smooth = Smooth.None, fillColor = {255,85,85}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-50,-36},{-38,-40}}, lineColor = {255,0,0}, fillColor = {255,213,170}, fillPattern = FillPattern.Solid),Polygon(points = {{-50,-32},{-50,-44},{-62,-38},{-50,-32}}, lineColor = {255,0,0}, smooth = Smooth.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-38,50},{-34,-34}}, lineColor = {255,0,0}, fillColor = {255,170,85}, fillPattern = FillPattern.Solid),Rectangle(extent = {{56,-32},{68,-36}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid),Polygon(points = {{56,-28},{56,-40},{44,-34},{56,-28}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {85,85,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{46,58},{58,54}}, lineColor = {0,0,255}, fillColor = {213,170,255}, fillPattern = FillPattern.Solid),Polygon(points = {{58,62},{58,50},{68,56},{58,62}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {255,85,85}, fillPattern = FillPattern.Solid),Rectangle(extent = {{34,52},{38,-32}}, lineColor = {0,0,255}, fillColor = {170,170,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-66,70},{70,-56}}, lineColor = {0,0,255}),Rectangle(extent = {{-32,48},{32,-30}}, lineColor = {0,0,255}, fillPattern = FillPattern.Solid, fillColor = {255,213,170})}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Ech_simplifie;
    end Echangeurs;
  end Composants;
  package Tests_2
    package Tests_composants
      model Test_1_OK
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_air annotation(Placement(transformation(extent = {{40,12},{60,32}})));
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_eau annotation(Placement(transformation(extent = {{-54,-48},{-34,-28}})));
        Composants.Echangeurs.Ech_simplifie ech_simplifie(redeclare package Milieu_fluide_chaud = Modelica.Media.Water.WaterIF97_ph, redeclare package Milieu_fluide_froid = Modelica.Media.Air.DryAirNasa, signe = 1) annotation(Placement(transformation(extent = {{-52,-50},{42,52}})));
        Utilitaires.Sources.Input_eau_P_T input_eau_P_T(T_in = 523.15, P_in = 5000000) annotation(Placement(transformation(extent = {{-68,38},{-48,58}})));
        Utilitaires.Scenarios.Scource_scenario_air scource_scenario_air(m_comp = 20, m_detente = 20, T1 = 3600, T0 = 3600, T2 = 3600, T0bis = 3600, P_comp = 5000000, P_detente = 12000000, T_comp = 533.15, T_detente = 303.15) annotation(Placement(transformation(extent = {{66,-34},{86,-14}})));
      equation
        connect(ech_simplifie.fluide_froid_out,sortie_air.eau_output) annotation(Line(points = {{31.66,28.54},{36.83,28.54},{36.83,21.6},{42,21.6}}, color = {255,2,6}, smooth = Smooth.None));
        connect(ech_simplifie.fluide_chaud_out,sortie_eau.eau_output) annotation(Line(points = {{-39.78,-17.36},{-39.78,-28.68},{-52,-28.68},{-52,-38.4}}, color = {255,2,6}, smooth = Smooth.None));
        connect(input_eau_P_T.cnctr_Fluide_O,ech_simplifie.fluide_chaud_in) annotation(Line(points = {{-56.7,48},{-46,48},{-46,27.52},{-38.84,27.52}}, color = {255,2,6}, smooth = Smooth.None));
        connect(scource_scenario_air.cnctr_detente_O,ech_simplifie.fluide_froid_in) annotation(Line(points = {{76.90000000000001,-28},{54,-28},{54,-17.36},{31.66,-17.36}}, color = {255,2,6}, smooth = Smooth.None));
        annotation(Placement(transformation(extent = {{-60,-60},{60,62}})), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,255}, fillColor = {255,85,85}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-60,64},{60,-60}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-94,58},{-66,30}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{68,62},{96,34}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-94,-24},{-66,-52}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{66,-24},{94,-52}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experiment(StartTime = 0, StopTime = 30000, Tolerance = 0.0001, Interval = 60));
      end Test_1_OK;
      model Test_2_OK
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_ech_air annotation(Placement(visible = true, transformation(origin = {-60,-84}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Utilitaires.Boundaries_ech.Source_eau source_eau(T_in(displayUnit = "degC") = 308.15, P_in = 5000000) annotation(Placement(visible = true, transformation(origin = {48,-92}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Composants.Echangeurs.Ech_simplifie echangeur_Adelaide(redeclare package Milieu_fluide_chaud = Modelica.Media.Air.DryAirNasa, redeclare package Milieu_fluide_froid = Modelica.Media.Water.WaterIF97_ph) annotation(Placement(visible = true, transformation(origin = {0,-60}, extent = {{-34,-31},{34,31}}, rotation = 0)));
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_ech_air1 annotation(Placement(visible = true, transformation(origin = {80,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Utilitaires.Scenarios.Scource_scenario_air scource_scenario_air(m_comp = 20, m_detente = 20, T1 = 3600, T0 = 3600, T2 = 3600, T0bis = 3600, P_comp = 5000000, P_detente = 12000000, T_comp = 533.15, T_detente = 303.15) annotation(Placement(visible = true, transformation(origin = {-60,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      equation
        connect(echangeur_Adelaide.fluide_froid_out,sortie_ech_air1.eau_output) annotation(Line(points = {{26.52,-43.26},{43.26,-43.26},{56.6523,-41.1266},{72,-40.4}}, color = {255,2,6}));
        connect(scource_scenario_air.cnctr_comp_O,echangeur_Adelaide.fluide_chaud_in) annotation(Line(points = {{-59.1,-36.2},{-48.6699,-24.2096},{-31.1946,-29.6666},{-24.48,-43.88}}, color = {255,2,6}));
        connect(sortie_ech_air.eau_output,echangeur_Adelaide.fluide_chaud_out) annotation(Line(points = {{-68,-84.40000000000001},{-60,-84.40000000000001},{-25.16,-64.16},{-25.16,-71.16}}, color = {0,0,255}));
        connect(source_eau.Debit_source,echangeur_Adelaide.fluide_froid_in) annotation(Line(points = {{57,-92},{66,-92},{26.52,-68.16},{26.52,-71.16}}, color = {0,0,255}));
        annotation(Placement(transformation(extent = {{-60,-60},{60,62}})), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,255}, fillColor = {255,85,85}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-60,64},{60,-60}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-94,58},{-66,30}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{68,62},{96,34}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{-94,-24},{-66,-52}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid),Ellipse(extent = {{66,-24},{94,-52}}, lineColor = {0,0,255}, fillColor = {255,255,255}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experiment(StartTime = 0, StopTime = 30000, Tolerance = 0.0001, Interval = 60));
      end Test_2_OK;
      model Test_KO
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_ech_air annotation(Placement(visible = true, transformation(origin = {-50,-74}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Utilitaires.Boundaries_ech.Source_eau source_eau(T_in(displayUnit = "degC") = 308.15, P_in = 5000000) annotation(Placement(visible = true, transformation(origin = {58,-82}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Composants.Echangeurs.Ech_simplifie echangeur_Adelaide(redeclare package Milieu_fluide_chaud = Modelica.Media.Air.DryAirNasa, redeclare package Milieu_fluide_froid = Modelica.Media.Water.WaterIF97_ph) annotation(Placement(visible = true, transformation(origin = {10,-50}, extent = {{-34,-31},{34,31}}, rotation = 0)));
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_ech_air1 annotation(Placement(visible = true, transformation(origin = {90,-30}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Utilitaires.Scenarios.Scource_scenario_air scource_scenario_air(m_comp = 20, m_detente = 20, T1 = 3600, T0 = 3600, T2 = 3600, T0bis = 3600, P_comp = 5000000, P_detente = 12000000, T_comp = 533.15, T_detente = 303.15) annotation(Placement(visible = true, transformation(origin = {-50,-30}, extent = {{-10,-10},{10,10}}, rotation = 0)));
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_air annotation(Placement(transformation(extent = {{30,54},{50,74}})));
        Utilitaires.Boundaries_ech.Sortie_ech_eau sortie_eau annotation(Placement(transformation(extent = {{-64,-6},{-44,14}})));
        Composants.Echangeurs.Ech_simplifie ech_simplifie(redeclare package Milieu_fluide_chaud = Modelica.Media.Water.WaterIF97_ph, redeclare package Milieu_fluide_froid = Modelica.Media.Air.DryAirNasa, signe = 1) annotation(Placement(transformation(extent = {{-62,-8},{32,94}})));
        Utilitaires.Sources.Input_eau_P_T input_eau_P_T(T_in = 523.15, P_in = 5000000) annotation(Placement(transformation(extent = {{-78,80},{-58,100}})));
        Utilitaires.Scenarios.Scource_scenario_air scource_scenario_air1(m_comp = 20, m_detente = 20, T1 = 3600, T0 = 3600, T2 = 3600, T0bis = 3600, P_comp = 5000000, P_detente = 12000000, T_comp = 533.15, T_detente = 303.15) annotation(Placement(transformation(extent = {{56,8},{76,28}})));
      equation
        connect(echangeur_Adelaide.fluide_froid_out,sortie_ech_air1.eau_output) annotation(Line(points = {{36.52,-33.26},{53.26,-33.26},{66.6523,-31.1266},{82,-30.4}}, color = {255,2,6}));
        connect(scource_scenario_air.cnctr_comp_O,echangeur_Adelaide.fluide_chaud_in) annotation(Line(points = {{-49.1,-26.2},{-38.6699,-14.2096},{-21.1946,-19.6666},{-14.48,-33.88}}, color = {255,2,6}));
        connect(sortie_ech_air.eau_output,echangeur_Adelaide.fluide_chaud_out) annotation(Line(points = {{-58,-74.40000000000001},{-50,-74.40000000000001},{-15.16,-54.16},{-15.16,-61.16}}, color = {0,0,255}));
        connect(source_eau.Debit_source,echangeur_Adelaide.fluide_froid_in) annotation(Line(points = {{67,-82},{76,-82},{36.52,-58.16},{36.52,-61.16}}, color = {0,0,255}));
        connect(ech_simplifie.fluide_froid_out,sortie_air.eau_output) annotation(Line(points = {{21.66,70.54000000000001},{26.83,70.54000000000001},{26.83,63.6},{32,63.6}}, color = {255,2,6}, smooth = Smooth.None));
        connect(ech_simplifie.fluide_chaud_out,sortie_eau.eau_output) annotation(Line(points = {{-49.78,24.64},{-49.78,13.32},{-62,13.32},{-62,3.6}}, color = {255,2,6}, smooth = Smooth.None));
        connect(input_eau_P_T.cnctr_Fluide_O,ech_simplifie.fluide_chaud_in) annotation(Line(points = {{-66.7,90},{-56,90},{-56,69.52},{-48.84,69.52}}, color = {255,2,6}, smooth = Smooth.None));
        connect(scource_scenario_air1.cnctr_detente_O,ech_simplifie.fluide_froid_in) annotation(Line(points = {{66.90000000000001,14},{44,14},{44,24.64},{21.66,24.64}}, color = {255,2,6}, smooth = Smooth.None));
      end Test_KO;
    end Tests_composants;
  end Tests_2;
  package Utilitaires
    package Connecteurs
      connector Ref_Connector_I_O "Connecteur de reference qui permet de transporter de masse et d'energie en utilisant: P la pression, h l'enthalpie specifique et le d?bit massique"
        Modelica.SIunits.Pressure P "Pression";
        Modelica.SIunits.SpecificEnthalpy h "Enthalpy";
        Modelica.SIunits.MassFlowRate m "Mass Flow Rate";
        annotation(Icon(graphics = {Rectangle(extent = {{-14,12},{14,-14}}, lineColor = {0,0,255}, fillColor = {35,191,24}, fillPattern = FillPattern.Solid)}));
      end Ref_Connector_I_O;
      connector Cnctr_Fluide_I
        extends Ref_Connector_I_O;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-38,40},{32,-22}}, lineColor = {0,0,255}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid),Text(extent = {{-76,-28},{76,-44}}, lineColor = {0,0,255}, textString = "%name")}));
      end Cnctr_Fluide_I;
      connector Cnctr_Fluide_O
        extends Ref_Connector_I_O;
        annotation(Icon(graphics = {Rectangle(extent = {{-50,42},{20,-20}}, lineColor = {255,2,6}, fillColor = {240,0,4}, fillPattern = FillPattern.Solid),Text(extent = {{-90,-22},{62,-38}}, lineColor = {255,0,0}, textString = "%name")}));
      end Cnctr_Fluide_O;
      connector Cnctr_Signal = input Real "'input Real' as connector" annotation(defaultComponentName = "u", Icon(graphics = {Polygon(points = {{-40,80},{60,0},{-40,-80},{-40,80}}, lineColor = {0,0,127}, fillColor = {255,255,0}, fillPattern = FillPattern.Solid),Text(extent = {{-19.5,31},{19.5,-31}}, lineColor = {0,0,255}, fillColor = {255,255,0}, fillPattern = FillPattern.Solid, textString = "S", origin = {-1,0.5}, rotation = 90)}, coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.2)), Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Polygon(points = {{1,51},{101,1},{1,-49},{1,51}}, lineColor = {0,0,127}, fillColor = {255,255,0}, fillPattern = FillPattern.Solid),Text(extent = {{-10,85},{-10,60}}, lineColor = {0,0,127}, textString = "%name"),Text(extent = {{-21.5,19},{21.5,-19}}, lineColor = {0,0,255}, fillColor = {255,255,0}, fillPattern = FillPattern.Solid, textString = "S", origin = {35,5.5}, rotation = 90)}), Documentation(info = "<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));
    end Connecteurs;
    package Sources
      model Input_m_h
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.SpecificEnthalpy h_in "enthalpie d'entree en J/kg";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
      equation
        cnctr_Fluide_O.m = m_in;
        cnctr_Fluide_O.h = h_in;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}));
      end Input_m_h;
      model Input_m_T
        replaceable package Milieu = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Temperature T_in "rentrer ici la temperature a imposer";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
      equation
        cnctr_Fluide_O.m = m_in;
        cnctr_Fluide_O.h = Milieu.specificEnthalpy(Milieu.setState_pTX(cnctr_Fluide_O.P, T_in, {1}));
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}));
      end Input_m_T;
      model Input_m_T_sat
        replaceable package Milieu = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Temperature T_in "rentrer ici la temperature a imposer";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
      equation
        cnctr_Fluide_O.m = m_in;
        cnctr_Fluide_O.P = Milieu.saturationPressure(T_in);
        cnctr_Fluide_O.h = Milieu.specificEnthalpy(Milieu.setState_pTX(cnctr_Fluide_O.P, T_in, {0.1}));
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}));
      end Input_m_T_sat;
      model Input_m_h_pulse
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.SpecificEnthalpy h_in "enthalpie d'entree en J/kg";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
        Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-98,-16},{-58,24}})));
      equation
        cnctr_Fluide_O.m = u * m_in;
        cnctr_Fluide_O.h = h_in;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Input_m_h_pulse;
      model Input_m_T_sat_u
        replaceable package Milieu = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Temperature T_in "rentrer ici la temperature a imposer";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
        Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent = {{-88,-6},{-48,34}})));
      equation
        cnctr_Fluide_O.m = u * m_in;
        cnctr_Fluide_O.P = Milieu.saturationPressure(T_in);
        cnctr_Fluide_O.h = Milieu.specificEnthalpy(Milieu.setState_pTX(cnctr_Fluide_O.P, T_in, {0.1}));
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Input_m_T_sat_u;
      model Input_m
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        //parameter Modelica.SIunits.SpecificEnthalpy h_in "enthalpie d'entree en J/kg";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
      equation
        cnctr_Fluide_O.m = m_in;
        //cnctr_Fluide_O.h = h_in;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}));
      end Input_m;
      model Input_eau_m_P_T
        replaceable package Milieu = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Temperature T_in "rentrer ici la temperature a imposer";
        parameter Modelica.SIunits.Pressure P_in "rentrer ici la pression a imposer";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
      equation
        cnctr_Fluide_O.m = m_in;
        cnctr_Fluide_O.P = P_in;
        cnctr_Fluide_O.h = Milieu.specificEnthalpy(Milieu.setState_pTX(P_in, T_in, {1}));
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}));
      end Input_eau_m_P_T;
      model Input_eau_P_T
        replaceable package Milieu = Modelica.Media.Water.WaterIF97_ph constrainedby Modelica.Media.Interfaces.PartialMedium;
        // parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Temperature T_in "rentrer ici la temperature a imposer";
        parameter Modelica.SIunits.Pressure P_in "rentrer ici la pression a imposer";
        // lien avec l'exterieur (connecteur)
        Connecteurs.Cnctr_Fluide_O cnctr_Fluide_O annotation(Placement(transformation(extent = {{-72,-90},{98,90}})));
      equation
        //cnctr_Fluide_O.m = m_in;
        cnctr_Fluide_O.P = P_in;
        cnctr_Fluide_O.h = Milieu.specificEnthalpy(Milieu.setState_pTX(P_in, T_in, {1}));
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-178,102},{2,-100}}, pattern = LinePattern.None, fillColor = {170,213,255}, fillPattern = FillPattern.Solid, lineColor = {0,0,0})}));
      end Input_eau_P_T;
    end Sources;
    package Boundaries_ech
      model Source_eau
        package Medium_eau = Modelica.Media.Water.WaterIF97_ph "package eau";
        //parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Pressure P_in "pression d'entree en Pa";
        parameter Modelica.SIunits.Temperature T_in "temperature d'entree en degreC";
        Connecteurs.Cnctr_Fluide_O Debit_source annotation(Placement(transformation(extent = {{80,-10},{100,10}}), iconTransformation(extent = {{80,-10},{100,10}})));
        // lien avec l'exterieur (connecteur)
      equation
        //Debit_source.m = m_in;
        Debit_source.P = P_in;
        Debit_source.h = Medium_eau.specificEnthalpy_pT(P_in, T_in);
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-40,40},{40,-40}}, lineColor = {0,128,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Line(points = {{40,0},{80,0}}, color = {0,128,255}, smooth = Smooth.None),Text(extent = {{-158,-64},{220,-42}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Source_eau;
      model Source_air
        package Medium_air = Modelica.Media.Air.DryAirNasa "package air";
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Pressure P_in "pression d'entree en Pa";
        parameter Modelica.SIunits.Temperature T_in "temperature d'entree en degreC";
        //parameter Modelica.SIunits.SpecificEnthalpy h_in;
        Connecteurs.Cnctr_Fluide_O Air_input annotation(Placement(transformation(extent = {{80,-10},{100,10}}), iconTransformation(extent = {{80,-10},{100,10}})));
        // lien avec l'exterieur (connecteur)
      equation
        Air_input.m = m_in;
        Air_input.P = P_in;
        Air_input.h = Medium_air.specificEnthalpy_pT(P_in, T_in);
        //Air_input.h = h_in;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-40,40},{40,-40}}, lineColor = {0,128,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Line(points = {{40,0},{80,0}}, color = {0,128,255}, smooth = Smooth.None),Text(extent = {{-166,-62},{192,-42}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Source_air;
      model Sortie_ech_eau
        Connecteurs.Cnctr_Fluide_I eau_output annotation(Placement(transformation(extent = {{-108,-36},{-52,28}})));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(graphics = {Polygon(points = {{0,60},{0,-60},{60,0},{0,60}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-100,20},{0,-20}}, lineColor = {0,0,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{-182,-84},{176,-64}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}));
      end Sortie_ech_eau;
      model Sortie_ech_air
        package Medium_air = Modelica.Media.Air.DryAirNasa "package air";
        //parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        //Modelica.SIunits.Pressure P_in "pression d'entree en Pa";
        parameter Modelica.SIunits.Temperature T_in "temperature d'entree en degreC";
        Connecteurs.Cnctr_Fluide_I Air_output annotation(Placement(transformation(extent = {{54,-28},{102,24}}), iconTransformation(extent = {{60,-20},{100,20}})));
        // lien avec l'exterieur (connecteur)
      equation
        Air_output.h = Medium_air.specificEnthalpy_pT(Air_output.P, T_in);
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{-40,60},{-40,-60},{-100,0},{-40,60}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-40,20},{60,-20}}, lineColor = {0,0,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{-182,-84},{176,-64}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}));
      end Sortie_ech_air;
      model Source_m_P_T
        replaceable package Milieu = Modelica.Media.Air.DryAirNasa constrainedby Modelica.Media.Interfaces.PartialMedium;
        // replaceable package Milieu = Modelica.Media.Interfaces.PartialMedium;
        parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        parameter Modelica.SIunits.Pressure P_in "pression d'entree en Pa";
        parameter Modelica.SIunits.Temperature T_in "temperature d'entree en degreC";
        Connecteurs.Cnctr_Fluide_O Debit_source annotation(Placement(transformation(extent = {{80,-10},{100,10}}), iconTransformation(extent = {{80,-10},{100,10}})));
        // lien avec l'exterieur (connecteur)
      equation
        Debit_source.m = m_in;
        Debit_source.P = P_in;
        Debit_source.h = Milieu.specificEnthalpy_pT(P_in, T_in);
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-40,40},{40,-40}}, lineColor = {0,128,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Line(points = {{40,0},{80,0}}, color = {0,128,255}, smooth = Smooth.None),Text(extent = {{-158,-64},{220,-42}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Source_m_P_T;
      model Sortie_eau_froide
        package Medium_eau = Modelica.Media.Water.WaterIF97_ph "package eau";
        parameter Modelica.SIunits.Temperature T_out "temperature de sortie";
        Connecteurs.Cnctr_Fluide_I Eau_output annotation(Placement(transformation(extent = {{60,-20},{80,0}}), iconTransformation(extent = {{60,-20},{100,20}})));
      equation
        Eau_output.h = Medium_eau.specificEnthalpy_pT(Eau_output.P, T_out);
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(points = {{-40,60},{-40,-60},{-100,0},{-40,60}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-40,20},{60,-20}}, lineColor = {0,0,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{-182,-84},{176,-64}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}));
      end Sortie_eau_froide;
      model Sortie_air_chaud
        Connecteurs.Cnctr_Fluide_I eau_output annotation(Placement(transformation(extent = {{-98,-20},{-60,18}})));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(graphics = {Polygon(points = {{0,60},{0,-60},{60,0},{0,60}}, lineColor = {0,0,255}, smooth = Smooth.None, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Rectangle(extent = {{-100,20},{0,-20}}, lineColor = {0,0,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Text(extent = {{-182,-84},{176,-64}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}));
      end Sortie_air_chaud;
      model Source_eau_T
        package Medium_eau = Modelica.Media.Water.WaterIF97_ph "package eau";
        //parameter Modelica.SIunits.MassFlowRate m_in "rentrer ici le debit d'entree";
        //parameter Modelica.SIunits.Pressure P_in "pression d'entree en Pa";
        parameter Modelica.SIunits.Temperature T_in "temperature d'entree en degreC";
        Connecteurs.Cnctr_Fluide_O Debit_source annotation(Placement(transformation(extent = {{80,-10},{100,10}}), iconTransformation(extent = {{80,-10},{100,10}})));
        // lien avec l'exterieur (connecteur)
      equation
        //Debit_source.m = m_in;
        //Debit_source.P = P_in;
        Debit_source.h = Medium_eau.specificEnthalpy_pT(Debit_source.P, T_in);
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Ellipse(extent = {{-40,40},{40,-40}}, lineColor = {0,128,255}, fillColor = {170,255,255}, fillPattern = FillPattern.Solid),Line(points = {{40,0},{80,0}}, color = {0,128,255}, smooth = Smooth.None),Text(extent = {{-158,-64},{220,-42}}, lineColor = {0,0,0}, fillColor = {0,0,255}, fillPattern = FillPattern.Solid, textString = "%name")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Source_eau_T;
      model Sink_4
        Connecteurs.Cnctr_Fluide_I cnctr_Fluide_I annotation(Placement(transformation(extent = {{-46,76},{-26,96}}), iconTransformation(extent = {{-88,28},{-26,96}})));
        Connecteurs.Cnctr_Fluide_I cnctr_Fluide_I1 annotation(Placement(transformation(extent = {{-78,-82},{-58,-62}}), iconTransformation(extent = {{-78,-82},{-14,0}})));
        Connecteurs.Cnctr_Fluide_I cnctr_Fluide_I2 annotation(Placement(transformation(extent = {{18,30},{38,50}}), iconTransformation(extent = {{18,30},{84,96}})));
        Connecteurs.Cnctr_Fluide_I cnctr_Fluide_I3 annotation(Placement(transformation(extent = {{34,-88},{54,-68}}), iconTransformation(extent = {{34,-88},{92,-18}})));
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Sink_4;
    end Boundaries_ech;
    package Scenarios
      model Scenario_1 "0: rien, 1:compression, 2:detente"
        parameter Real T1 "duree de la phase de compression (en sec)";
        parameter Real T0 "duree de la phase d'attente (en sec)";
        parameter Real T2 "duree de la phase de detente (en sec)";
        parameter Real T0bis "duree de la 2e phase d'attente (en sec)";
        parameter Real periode = T0 + T0bis + T1 + T2 "duree de la periode totale";
        Real count;
        // indicateur de sortie : (0)=rien, (1)=compression, (-1)=detente
        Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
      initial algorithm
        count:=0;
        // nombre de periodes ecoulees
      algorithm
        when time > periode * (count + 1) then
                  count:=count + 1;        
        end when;
        /* On commence par une phase de compression (entre t=0 et T1), Attente (entre T1 et T1+T0),
    Detente (entre T1+T0 et T1+T0+T2),  Attente (entre T1+T0+T2 et periode suivante)... */
      equation
        y = if time >= periode * count and time < T1 + periode * count then 1 else if time >= periode * count + T1 and time < T1 + T0 + periode * count then 0 else if time >= periode * count + T1 + T0 and time < T2 + T1 + T0 + periode * count then -1 else if time >= periode * count + T1 + T0 + T2 and time <= periode * (count + 1) then 0 else 0;
        annotation(uses(Modelica(version = "3.2")), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,127,0}),Text(extent = {{-74,32},{64,-26}}, lineColor = {0,128,0}, textString = "Scenario")}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Scenario_1;
      model Scource_scenario
        // Connecteurs
        Connecteurs.Cnctr_Fluide_O cnctr_comp_O annotation(Placement(transformation(extent = {{40,0},{100,60}}), iconTransformation(extent = {{0,-40},{100,60}})));
        Connecteurs.Cnctr_Fluide_O cnctr_detente_O annotation(Placement(transformation(extent = {{-82,-16},{-22,44}}), iconTransformation(extent = {{-100,-40},{0,60}})));
        ///////////////////////////////////////////////// Partie source /////////////////////////////////////////////////////////////
        parameter Modelica.SIunits.MassFlowRate m_comp;
        parameter Modelica.SIunits.MassFlowRate m_detente "rentrer ici un debit positif";
        parameter Modelica.SIunits.SpecificEnthalpy h_in_comp;
        ///////////////////////////////////////////////// Partie scenario /////////////////////////////////////////////////////////////
        parameter Real T1 "duree de la phase de compression (en sec)";
        parameter Real T0 "duree de la phase d'attente (en sec)";
        parameter Real T2 "duree de la phase de detente (en sec)";
        parameter Real T0bis "duree de la 2e phase d'attente (en sec)";
        parameter Real periode = T0 + T0bis + T1 + T2 "duree de la periode totale";
        Real count;
        Integer y;
        // indicateur de sortie : (0)=rien, (1)=compression, (-1)=detente
      initial algorithm
        count:=0;
        // nombre de periodes ecoulees
      algorithm
        when time > periode * (count + 1) then
                  count:=count + 1;        
        end when;
        /* On commence par une phase de compression (entre t=0 et T1), Attente (entre T1 et T1+T0),
    Detente (entre T1+T0 et T1+T0+T2),  Attente (entre T1+T0+T2 et periode suivante)... */
      equation
        y = if time >= periode * count and time < T1 + periode * count then 1 else if time >= periode * count + T1 and time < T1 + T0 + periode * count then 0 else if time >= periode * count + T1 + T0 and time < T2 + T1 + T0 + periode * count then -1 else if time >= periode * count + T1 + T0 + T2 and time <= periode * (count + 1) then 0 else 0;
        // On peut maintenant definir les connecteurs necessaires :
        cnctr_comp_O.m = if y == (-1) then 0 else y * m_comp;
        // >0 uniquement si y = 1, 0 en attente, et 0 forcee en detente.
        cnctr_comp_O.h = h_in_comp;
        cnctr_detente_O.m = if y == 1 then 0 else y * m_detente;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,60},{100,-40}}, lineColor = {0,0,255}, fillColor = {170,255,170}, fillPattern = FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Scource_scenario;
      model Scource_scenario_air
        package Medium_air = Modelica.Media.Air.DryAirNasa "package air";
        // Connecteurs
        Connecteurs.Cnctr_Fluide_O cnctr_comp_O annotation(Placement(transformation(extent = {{-48,-14},{66,90}})));
        Connecteurs.Cnctr_Fluide_O cnctr_detente_O annotation(Placement(transformation(extent = {{-44,-90},{62,10}})));
        ///////////////////////////////////////////////// Partie source /////////////////////////////////////////////////////////////
        parameter Modelica.SIunits.MassFlowRate m_comp "debit d'air chaud venant du compresseur";
        parameter Modelica.SIunits.MassFlowRate m_detente "debit d'air froid venant du stockage (a chauffer avant detente)";
        parameter Modelica.SIunits.Pressure P_comp "pression de l'air chaud venant du compresseur";
        parameter Modelica.SIunits.Pressure P_detente "pression de l'air froid venant du stockage";
        parameter Modelica.SIunits.Temperature T_comp "Temperature de l'air chaud venant du compresseur";
        parameter Modelica.SIunits.Temperature T_detente "Temperature de l'air froid venant du stockage";
        //parameter Modelica.SIunits.SpecificEnthalpy h_in_comp;
        ///////////////////////////////////////////////// Partie scenario /////////////////////////////////////////////////////////////
        parameter Real T1 "duree de la phase de compression (en sec)";
        parameter Real T0 "duree de la phase d'attente (en sec)";
        parameter Real T2 "duree de la phase de detente (en sec)";
        parameter Real T0bis "duree de la 2e phase d'attente (en sec)";
        parameter Real periode = T0 + T0bis + T1 + T2 "duree de la periode totale";
        Real count;
        Integer y;
        // indicateur de sortie : (0)=rien, (1)=compression, (-1)=detente
      initial algorithm
        count:=0;
        // nombre de periodes ecoulees
      algorithm
        when time > periode * (count + 1) then
                  count:=count + 1;        
        end when;
        /* On commence par une phase de compression (entre t=0 et T1), Attente (entre T1 et T1+T0),
    Detente (entre T1+T0 et T1+T0+T2),  Attente (entre T1+T0+T2 et periode suivante)... */
      equation
        y = if time >= periode * count and time < T1 + periode * count then 1 else if time >= periode * count + T1 and time < T1 + T0 + periode * count then 0 else if time >= periode * count + T1 + T0 and time < T2 + T1 + T0 + periode * count then -1 else if time >= periode * count + T1 + T0 + T2 and time <= periode * (count + 1) then 0 else 0;
        // On peut maintenant definir les connecteurs necessaires :
        cnctr_comp_O.m = if y == (-1) then 0 else y * m_comp;
        // >0 uniquement si y = 1, 0 en attente, et 0 forcee en detente.
        cnctr_detente_O.m = if y == 1 then 0 else y * m_detente;
        // Dans ce cas, mettre la variable signe de l'ech a 1.
        cnctr_comp_O.P = P_comp;
        cnctr_detente_O.P = P_detente;
        cnctr_comp_O.h = Medium_air.specificEnthalpy_pTX(P_comp, T_comp);
        cnctr_detente_O.h = Medium_air.specificEnthalpy_pTX(P_detente, T_detente);
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Rectangle(extent = {{-100,100},{100,-100}}, lineColor = {0,0,255}, fillColor = {170,255,170}, fillPattern = FillPattern.Solid),Text(extent = {{-94,96},{80,62}}, lineColor = {0,0,255}, textString = "Compression"),Text(extent = {{-62,-62},{74,-100}}, lineColor = {0,0,255}, textString = "Detente"),Line(points = {{-100,0},{100,0}}, color = {0,0,255}, smooth = Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
      end Scource_scenario_air;
    end Scenarios;
  end Utilitaires;
  annotation(uses(Modelica(version = "3.2")));
end Modele_stockage_Pia;