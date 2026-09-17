model outerProductTest
 Real n[3] = {1,2,3};
 Real a[3,3];
equation
 a = outerProduct(n,n);
end outerProductTest;
