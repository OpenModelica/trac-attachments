function isEqualOnTrue<ElementType>
  input list<ElementType> inList1;
  input list<ElementType> inList2;
  input CompFunc inCompFunc;
  output Boolean outIsEqual;

  partial function CompFunc
    input ElementType inElement1;
    input ElementType inElement2;
    output Boolean outIsEqual;
  end CompFunc;
algorithm
  outIsEqual := match(inList1, inList2)
    local
      ElementType e1, e2;
      list<ElementType> rest1, rest2;

    case (e1 :: rest1, e2 :: rest2) guard(inCompFunc(e1, e2))
      then isEqualOnTrue(rest1, rest2, inCompFunc);

    case ({}, {}) then true;
    else false;
  end match;
end isEqualOnTrue;

function main
algorithm
  _ := isEqualOnTrue({"a"}, {"b"}, stringEq);
end main;
