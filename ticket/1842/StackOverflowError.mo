package StackOverflowError 
  package ASMx 
    package GenericUnits
      model Nitri1 
        replaceable model AerationModel = Interfaces.AerationFine constrainedby
          Interfaces.AerationCommon;
        model JModel2 = AerationModel;
        extends JModel2(redeclare model OxygenModel1=Interfaces.partialModel1);
      equation
      end Nitri1;
    end GenericUnits;

    package Interfaces
      partial model AerationCommon
        replaceable model OxygenModel = partialModel1;
        model JModel = OxygenModel;
        extends JModel;
      end AerationCommon;

      partial model AerationFine
        replaceable model OxygenModel1 = partialModel2;
        extends AerationCommon(redeclare model OxygenModel = OxygenModel1);
      equation
      end AerationFine;

      partial model partialModel1       
      end partialModel1;

      partial model partialModel2       
      end partialModel2;
    end Interfaces;

    package Test = WasteWater.ASMx;

  end ASMx;
end StackOverflowError;
