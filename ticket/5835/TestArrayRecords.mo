package TestArrayRecords

record Material
  Real x;
  Real y;
end Material;

constant Material myMaterial(x = 10, y = 20);

function computeC
    input Material mats[:] "material properties of the slices";
    output Real c[size(mats,1)];
  algorithm
    for i in 1:size(mats,1) loop
      c[i] := mats[i].x;
    end for;
  end computeC;
 
model Element
  parameter Material materials[:]= {myMaterial, myMaterial};
  final parameter Real c[size(materials,1)] = computeC(materials);
end Element;
end TestArrayRecords;
