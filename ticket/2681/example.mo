within ;
package example
  function examplefunction
    "calculate elements of a vector, and return one concatenated vector"

    // INPUTS
    input Integer s_a "some vectorsize in dim1 a";
    input Integer s_b "some vectorsize in dim1 b";

    // OUTPUTS
    output Real[s_a+s_b] resultVector;

  protected
      parameter Real[s_a] aVector = {i for i in 1:s_a};
      parameter Real[s_b] bVector = {j for j in 1:s_b};

  algorithm
    resultVector :=cat(
      1,
      aVector,
      bVector);

  end examplefunction;

  model examplemodel

    parameter Integer s_a = 1 "size of aVector";
    parameter Integer s_b = 1 "size of bVector";

    parameter Integer s_result = s_a + s_b "size of resultvector";

    // function call is not working
    parameter Real resultVector[s_result] = example.examplefunction(s_a,s_b);

    // function taken to model
    parameter Real[s_a] aVector2 = {i for i in 1:s_a};
    parameter Real[s_b] bVector2 = {j for j in 1:s_b};

    parameter Real[s_result] resultVector2 = cat(1, aVector2,bVector2);

  end examplemodel;
  annotation (uses(Modelica(version="3.2.1")));
end example;
