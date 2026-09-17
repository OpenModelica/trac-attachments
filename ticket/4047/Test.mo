    model Test
      Modelica.Blocks.Interfaces.RealInput SP annotation(Placement(visible = true, transformation(extent = {{-100, -20}, {-60, 20}}, rotation = 0), iconTransformation(extent = {{-100, -20}, {-60, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput PVvec[size(num, 1)] "PV(k)...PV(k-#num) at step ns*qs" annotation(Placement(visible = true, transformation(extent = {{-90, -84}, {-50, -44}}, rotation = 0), iconTransformation(extent = {{-100, -20}, {-60, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput CS annotation(Placement(transformation(extent = {{60, -20}, {80, 0}}), iconTransformation(extent = {{60, -20}, {100, 20}})));
      Modelica.Blocks.Interfaces.BooleanInput Etrig annotation(Placement(visible = true, transformation(origin = {-76, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      parameter Real num[:] = {0.5} "num in desc. powers of z, len must match npast+1 in sapmpler";
      parameter Real den[:] = {1, -0.5} "nen in descending powers of z";
      parameter Real qs = 0.1 "must match qs in sampler";
      parameter Integer ns = 10 "must match qs in sampler";
      parameter Real CSmax = 1;
      parameter Real CSmin = -1;
      parameter Real CSstart = 0;
      //protected
      parameter Real Ts = ns * qs;
      parameter Real nnum[:] = num / den[1];
      // normalise num and den by making the latter monic
      parameter Real nden[:] = den / den[1];
      parameter Real rden[:] = Functions.ArraySubset(den, 2, size(den, 1));
      parameter Integer nPV = size(num, 1);
      // No. of PVs to compute CS(k), from k to k-#num
      parameter Integer nSP = nPV;
      // need same number of SPs to compute the errors
      parameter Integer nCS = size(den, 1) - 1;
      // No. of CSs to compute CS(k), from k-1 to k-#den
      discrete Real vCS[nCS](each start = CSstart);
      // vector for the past CSs to compute CS(k)
      discrete Real vSP[nSP](each start = 0);
      // vector for the past SPs to compute CS(k)
      // recorded CSs at events and their times: nCS*qs*ns/qs=nCS*ns is the max No. of events that
      // may have occurred in the time span fron now back to nCS*Ts
      discrete Real recCS[nCS * ns](each start = CSstart);
      // recorded CSs
      discrete Real trecCS[nCS * ns](each start = 0);
      // corresponding times
      // recorded SPs at events: same reasoning nut with nSP
      discrete Real recSP[nSP * ns](each start = 0);
      // recorded SPs
      discrete Real trecSP[nSP * ns](each start = 0);
      // times (redundant for readability)
      discrete Real tCS, tSP;
      discrete Integer dex;
      discrete Real u;
    equation
      CS = u;
    algorithm
      when change(Etrig) then
        for i in 1:nCS loop
          tCS := time - i * Ts;
          dex := 1;
          while dex < nCS * ns and tCS < trecCS[dex] loop
            dex := dex + 1;
          end while;
          vCS[i] := recCS[dex];
        end for;
        for i in 0:nCS * ns - 2 loop
          recCS[nCS * ns - i] := recCS[nCS * ns - i - 1];
          trecCS[nCS * ns - i] := trecCS[nCS * ns - i - 1];
        end for;
        trecCS[1] := time;
        for i in 0:nSP * ns - 2 loop
          recSP[nSP * ns - i] := recSP[nSP * ns - i - 1];
          trecSP[nSP * ns - i] := trecSP[nSP * ns - i - 1];
        end for;
        trecSP[1] := time;
        recSP[1] := SP;
        for i in 1:nSP loop
          tSP := time - (i - 1) * Ts;
          dex := 1;
          while dex < nSP * ns and tSP < trecSP[dex] loop
            dex := dex + 1;
          end while;
          vSP[i] := recSP[dex];
        end for;
        u := rden * vCS + nnum * (vSP - PVvec);
        u := max(CSmin, min(CSmax, u));
        recCS[1] := u;
      end when;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(origin = {18, 124}, fillColor = {200, 180, 180}, fillPattern = FillPattern.Solid, extent = {{6, -24}, {82, -94}}), Text(origin = {0, -14}, extent = {{-40, 52}, {40, -52}}, textString = "R(z)
3TS
oldUin", fontName = "DejaVu Sans Mono")}), uses(Modelica(version = "3.2.1")));
    end Test;
