package testModel
  model modelInner
    parameter typeA param1=typeA.e1;
    type typeA= enumeration(e1, e2, e3);
    parameter Boolean k1=param1 == typeA.e1;
    parameter Boolean k2=param1 == typeA.e2;
    parameter Boolean k3=param1 == typeA.e3;
  end modelInner;

  model topModel
    modelInner m(param1=testModel.modelInner.typeA.e2);
  end topModel;

end testModel;
