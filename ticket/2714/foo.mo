within ;
function foo

  input Integer a "size of first internal array";
  input Integer b "size of second internal array";
  input Integer c "size of output array, which is a+b and is known from the outside";

  output Real[c] returnValue;

protected
  parameter Real array1[a] = {i for i in 1:a};
  parameter Real array2[b] = {i*i for i in 1:b};

  Real[c] arrayTotal = cat(
    1,
    array1,
    array2);

algorithm
  returnValue :=arrayTotal;

  annotation (uses(Modelica(version="3.2.1")));
end foo;
