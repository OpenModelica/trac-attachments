class Model2Unit1 = TestLibrary.Containers.Container1.SubContainer1.Unit1(
	redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel1 sm1,
	redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel3 sm3,
	redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel4 sm4,
	redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel5 sm5);

class Model2Unit2 = TestLibrary.Containers.Container1.SubContainer1.Unit2(
	redeclare TestLibrary.Models.ModelContainer2.Model2.SubModel5 sm5);

model Model2Test
	Model2Unit1 i;
	Model2Unit2 e;

equation
	connect(i.sm5, e.sm5);
end Model2Test;
