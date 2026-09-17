model test_symmetric
	Real A[2,2] = [[1,2]; 
	               [3,4]];
	Real B[:,:] = symmetric(A);
end test_symmetric;