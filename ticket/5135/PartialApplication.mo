package PartialApplication

  function myfunction
    input Real u1;
    input Real u2;
    output Real y;
  external"C" y = calculate(u1, u2) annotation (__iti_dllNoExport=true, Include=
         "double calculate(double u1, double u2) {
           return u1*u2;
              };");
  end myfunction;

  model ComponentModel_cyclicDependency "not working in OpenModelica"
    Real u2 = time*2;
    function s = PartialApplication.myfunction (    u2 = u2);
    Real y=s(time);

    annotation (Icon(graphics={
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            textString="BM"),
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            textString="BM"),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            textString="CM")}));
  end ComponentModel_cyclicDependency;

  model ComponentModel_notFound "not working in OpenModelica"
    Real u2_ = time*2;
    function s = PartialApplication.myfunction (    u2 = u2_);
    Real y=s(time);

    annotation (Icon(graphics={
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            textString="BM"),
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            textString="BM"),
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Text(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            textString="CM")}));
  end ComponentModel_notFound;

  model Tester_cyclicDependency
    Real r = componentModel.s(time);
    PartialApplication.ComponentModel_cyclicDependency componentModel
      annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Tester_cyclicDependency;

  model Tester_notFound
    Real r = componentModel.s(time);
    PartialApplication.ComponentModel_notFound componentModel
      annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Tester_notFound;

  model Tester_wrongResult
    PartialApplication.ComponentModel_notFound componentModel
      annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Tester_wrongResult;
end PartialApplication;
