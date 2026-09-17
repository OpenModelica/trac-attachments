impure function func
//function func
	input String name;
	output String out;
algorithm
	out := name + ".ext";
end func;

block Impure
	Modelica.Blocks.Sources.CombiTimeTable tab(fileName=func("file"),
		tableName="tab", tableOnFile=true);
end Impure;

// When impure the C code somehow thinks that we are trying to give it a usertab,
// which is not implemented in OpenModelica
// Looking at the source it is likely that somehow the C code is getting "NoName"
