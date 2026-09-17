package TestCInterface
  model TestMdl
    Real x1, x2, y1, y2;
  algorithm
    x1 := 2;
    x2 := 10 * time;
    y1 := x1 * sin(x2);
    y2 := ExtFun(x1, x2);
  end TestMdl;

  function ExtFun "two real input one Real output function"
    input Real x1f;
    input Real x2f;
    output Real yf;
  
    external "C" ;
    annotation(
      Include = "#include <D:\OneDrive - University of Pisa\2_MODELICA\OLD e varie\F & C interface\\ExtFun.c>");
  end ExtFun;

  // some text
  //    Include = "#include <D:\\Dropbox\\2_MODELICA\\C interface\\ExtFun.c>");
  annotation(
    Documentation(info = "<html>
<p>
Package per valutare l'interfaccia C.
</p><p>
TestMdl al momento mostra l'uso più semplice dell'interfaccia C:</p>
<p> - senza link a librerie esterne </p>
<p> - con un'unica uscita e l'ordine deglli ingressi immodificato.</p>
<p> Gli esempi delle Modelica specifications consentono agevolmente di fare casi 
più complessi, ad esempio quando ho più di un'uscita, o quando voglio andare 
a pescare delle funzioni C da librerie.</p>

</html>"));
end TestCInterface;
