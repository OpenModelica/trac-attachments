model outerProductTest2
 Real n[3] = {1,2,3};
 Real b[3,3] = identity(3);
 Real a[3,3];
 Real phi = 0;
equation
 a = (outerProduct(n, n) + identity(3))*b;
end outerProductTest2;
