package TestAnnotation
  record DataType
    extends Modelica.Icons.Record;
    Real x;
  annotation(defaultComponentName = "data",
           defaultComponentPrefixes = "parameter");
  end DataType;
  
  record MyData
    extends DataType(
      x = 10);
  end MyData;
  
  model M 
  end M;
end TestAnnotation;
