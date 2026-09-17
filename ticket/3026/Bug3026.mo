model M
  MyExternalObject obj = MyExternalObject();
  parameter Boolean b(fixed=false);
initial equation
  {b} = getBoolean(obj, 1);
protected
  class MyExternalObject
    extends ExternalObject;
      function constructor
        output MyExternalObject obj;
        external "C" obj = constructor_() annotation(Include = "void* constructor_() {return NULL;}");
      end constructor;

      function destructor
        input MyExternalObject obj;
        external "C" destructor_(obj) annotation(Include = "void* destructor_(void* obj) {}");
      end destructor;
  end MyExternalObject;
  
    function getBoolean
      input MyExternalObject obj;
      input Integer size;
      output Boolean booleanValues[size] = fill(true, size);
    end getBoolean;
end M;