within ;
package KeyWordIO "Read and write data files with key words"
  function writeRealVariable "Writing real variable to file"
    input String fileName "Name of file" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
    input String name "Name of parameter";
    input Real data "Actual value of parameter";
    input Boolean append = false "Append data to file";
  algorithm
    if not append then
      Modelica.Utilities.Files.removeFile(fileName);
    end if;
    Modelica.Utilities.Streams.print(name + " = " + String(data), fileName);
  end writeRealVariable;

  function writeRealVariables "Write multiple real variables to file"
    input String fileName "Name of file" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
    input String name[:] "Name of parameter";
    input Real data[:] "Actual value of parameter";
    input Boolean append = false "Append data to file";
  algorithm
    // Check sizes of name and data
    if size(name, 1) <> size(data, 1) then
      assert(false, "writeReadParameters: Lengths of name and data have to be equal");
    end if;
    // Write data to file
    if not append then
      Modelica.Utilities.Files.removeFile(fileName);
    end if;
    for k in 1:size(name, 1) loop
      Modelica.Utilities.Streams.print(name[k] + " = " + String(data[k]), fileName);
    end for;
  end writeRealVariables;

  function readRealParameter "Read the value of a Real parameter from file"
    import Modelica.Utilities.*;
    input String fileName "Name of file" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
    input String name "Name of parameter";
    input Boolean cache = false "Read file with/without caching";
    output Real result "Actual value of parameter on file";
  protected
    String line;
    String identifier;
    String delimiter;
    Integer nextIndex;
    Integer iline = 1;
    Types.TokenValue token;
    String message = "in file \"" + fileName + "\" on line ";
    String message2;
    Boolean found = false;
    Boolean endOfFile = false;
  algorithm
    if not cache then
      (line, endOfFile) := readLineWithoutCache(fileName, iline);
    else
      (line, endOfFile) := Streams.readLine(fileName, iline);
    end if;
    while not found and not endOfFile loop
      (token, nextIndex) := Strings.scanToken(line);
      if token.tokenType == Types.TokenType.NoToken then
        iline := iline + 1;
      elseif token.tokenType == Types.TokenType.IdentifierToken then
        if token.string == name then
          message2 := message + String(iline);
          (delimiter, nextIndex) := Strings.scanDelimiter(line, nextIndex, {"="}, message2);
          (result, nextIndex) := expression(line, nextIndex, message2);
          (delimiter, nextIndex) := Strings.scanDelimiter(line, nextIndex, {";", ""}, message2);
          Strings.scanNoToken(line, nextIndex, message2);
          found := true;
        else
          iline := iline + 1;
        end if;
      else
        Strings.syntaxError(line, nextIndex, "Expected identifier " + message + String(iline));
      end if;
      if not cache then
        (line, endOfFile) := readLineWithoutCache(fileName, iline);
      else
        (line, endOfFile) := Streams.readLine(fileName, iline);
      end if;
    end while;
    // skip line
    // name found, get value of "name = value;"
    // wrong name, skip line
    // wrong token
    // read next line
    /*
                                                      if not cache then
                                                        Streams.close(fileName);
                                                      end if;
                                                    */
    if not found then
      Streams.error("Parameter \"" + name + "\" not found in file \"" + fileName + "\"");
    end if;
    annotation(Documentation(info = "<html>
<h4>Syntax</h4>
<blockquote><pre>
result = <b>readRealParameter</b>(fileName, name);
</pre></blockquote>
<h4>Description</h4>
<p>
This function demonstrates how a function can be implemented
that reads the value of a parameter from file. The function
performs the following actions:
</p>
<ol>
<li> It opens file \"fileName\" and reads the lines of the file.</li>
<li> In every line, Modelica line comments (\"// ... end-of-line\")
     are skipped </li>
<li> If a line consists of \"name = expression\" and the \"name\"
     in this line is identical to the second argument \"name\"
     of the function call, the expression calculator Examples.expression
     is used to evaluate the expression after the \"=\" character.
     The expression can optionally be terminated with a \";\".</li>
<li> The result of the expression evaluation is returned as
     the value of the parameter \"name\". </li>
</ol>
<h4>Example</h4>
<p>
On file \"test.txt\" the following lines might be present:
</p>
<blockquote><pre>
// Motor data
J        = 2.3     // inertia
w_rel0   = 1.5*2;  // relative angular velocity
phi_rel0 = pi/3
</pre></blockquote>
<p>
The function returns the value \"3.0\" when called as:
</p>
<blockquote><pre>
readRealParameter(\"test.txt\", \"w_rel0\")
</pre></blockquote>
</html>"));
  end readRealParameter;

  function expression
    "Expression interpreter that returns with the position after the expression (expression may consist of +,-,*,/,^,(),sin(), cos(), tan(), sqrt(), asin(), acos(), atan(), exp(), log(), pi"
    import Modelica.Utilities.Types;
    import Modelica.Utilities.Strings;
    import Modelica.Math;
    import Modelica.Constants;
    input String string "Expression that is evaluated";
    input Integer startIndex = 1
      "Start scanning of expression at character startIndex";
    input String message = ""
      "Message used in error message if scan is not successful";
    output Real result "Value of expression";
    output Integer nextIndex "Index after the scanned expression";
  protected
    function term "Evaluate term of an expression"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex;
      input String message = "";
      output Real result;
      output Integer nextIndex;
    protected
      Real result2;
      Boolean scanning = true;
      String opString;
    algorithm
      // scan for "primary * primary" or "primary / primary"
      (result, nextIndex) := primary(string, startIndex, message);
      while scanning loop
        (opString, nextIndex) := Strings.scanDelimiter(string, nextIndex, {"*", "/", "^", ""}, message);
        if opString == "" then
          scanning := false;
        else
          (result2, nextIndex) := primary(string, nextIndex, message);
          result := if opString == "*" then result * result2 else if opString == "/" then result / result2 else result ^ result2;
        end if;
      end while;
    end term;

    function primary "Evaluate primary of an expression"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex;
      input String message = "";
      output Real result;
      output Integer nextIndex;
    protected
      Types.TokenValue token;
      Real result2;
      String delimiter;
      String functionName;
      Real pi = Constants.pi;
    algorithm
      (token, nextIndex) := Strings.scanToken(string, startIndex, unsigned=  true);
      if token.tokenType == Types.TokenType.DelimiterToken and token.string == "(" then
        (result, nextIndex) := expression(string, nextIndex, message);
        (delimiter, nextIndex) := Strings.scanDelimiter(string, nextIndex, {")"}, message);
      elseif token.tokenType == Types.TokenType.RealToken then
        result := token.real;
      elseif token.tokenType == Types.TokenType.IntegerToken then
        result := token.integer;
      elseif token.tokenType == Types.TokenType.IdentifierToken then
        if token.string == "pi" then
          result := pi;
        else
          functionName := token.string;
          (delimiter, nextIndex) := Strings.scanDelimiter(string, nextIndex, {"("}, message);
          (result, nextIndex) := expression(string, nextIndex, message);
          (delimiter, nextIndex) := Strings.scanDelimiter(string, nextIndex, {")"}, message);
          if functionName == "sin" then
            result := Math.sin(result);
          elseif functionName == "cos" then
            result := Math.cos(result);
          elseif functionName == "tan" then
            result := Math.tan(result);
          elseif functionName == "sqrt" then
            if result < 0.0 then
              Strings.syntaxError(string, startIndex, "Argument of call \"sqrt(" + String(result) + ")\" is negative.\n" + "Imaginary numbers are not supported by the calculator.\n" + message);
            end if;
            result := sqrt(result);
          elseif functionName == "asin" then
            result := Math.asin(result);
          elseif functionName == "acos" then
            result := Math.acos(result);
          elseif functionName == "atan" then
            result := Math.atan(result);
          elseif functionName == "exp" then
            result := Math.exp(result);
          elseif functionName == "log" then
            if result <= 0.0 then
              Strings.syntaxError(string, startIndex, "Argument of call \"log(" + String(result) + ")\" is negative.\n" + message);
            end if;
            result := log(result);
          else
            Strings.syntaxError(string, startIndex, "Function \"" + functionName + "\" is unknown (not supported)\n" + message);
          end if;
        end if;
      else
        Strings.syntaxError(string, startIndex, "Invalid primary of expression.\n" + message);
      end if;
    end primary;

    Real result2;
    String signOfNumber;
    Boolean scanning = true;
    String opString;
  algorithm
    // scan for optional leading "+" or "-" sign
    (signOfNumber, nextIndex) := Strings.scanDelimiter(string, startIndex, {"+", "-", ""}, message);
    // scan for "term + term" or "term - term"
    (result, nextIndex) := term(string, nextIndex, message);
    if signOfNumber == "-" then
      result := -result;
    end if;
    while scanning loop
      (opString, nextIndex) := Strings.scanDelimiter(string, nextIndex, {"+", "-", ""}, message);
      if opString == "" then
        scanning := false;
      else
        (result2, nextIndex) := term(string, nextIndex, message);
        result := if opString == "+" then result + result2 else result - result2;
      end if;
    end while;
    annotation(Documentation(info = "<html>
<h4>Syntax</h4>
<blockquote><pre>
             result = <b>expression</b>(string);
(result, nextIndex) = <b>expression</b>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
This function is nearly the same as Examples.<b>calculator</b>.
The essential difference is that function \"expression\" might be
used in other parsing operations: After the expression is
parsed and evaluated, the function returns with the value
of the expression as well as the position of the character
directly after the expression.
</p>
<p>
This function demonstrates how a simple expression calculator
can be implemented in form of a recursive decent parser
using basically the Strings.scanToken(..) and scanDelimiters(..)
function. There are 2 local functions (term, primary) that
implement the corresponding part of the grammar.
</p>
<p>
The following operations are supported (pi=3.14.. is a predefined constant):
</p>
<pre>
   +, -
   *, /, ^
   (expression)
   sin(expression)
   cos(expression)
   tan(expression)
   sqrt(expression)
   asin(expression)
   acos(expression)
   atan(expression)
   exp(expression)
   log(expression)
   pi
</pre>
<p>
The optional argument \"startIndex\" defines at which position
scanning of the expression starts.
</p>
<p>
In case of error,
the optional argument \"message\" is appended to the error
message, in order to give additional information where
the error occured.
</p>
<p>
This function parses the following grammaer
</p>
<pre>
  expression: [ add_op ] term { add_op term }
  add_op    : \"+\" | \"-\"
  term      : primary { mul_op primary }
  mul_op    : \"*\" | \"/\" | \"^\"
  primary   : UNSIGNED_NUMBER
              | pi
              | ( expression )
              | functionName( expression )
  function  :   sin
              | cos
              | tan
              | sqrt
              | asin
              | acos
              | atan
              | exp
              | log
</pre>
<p>
Note, in Examples.readRealParameter it is shown, how the expression
function can be used as part of another scan operation.
</p>
<h4>Example</h4>
<blockquote><pre>
  expression(\"2+3*(4-1)\");  // returns 11
  expression(\"sin(pi/6)\");  // returns 0.5
</pre></blockquote>
</html>"));
  end expression;

  function readLineWithoutCache
    "Reads a line of text from a file without cahing and returns it in a string"
    input String fileName "Name of the file that shall be read" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
    input Integer lineNumber(min = 1) "Number of line to read";
    output String string "Line of text";
    output Boolean endOfFile
      "If true, end-of-file was reached when trying to read line";

    external "C" string=  ReadLine(fileName, lineNumber, endOfFile);
    annotation(Include = "
#ifndef ReadLine_C
#define ReadLine_C
# include <stdio.h>
# include <string.h>
extern void ModelicaFormatError(const char* string,...);
extern char* ModelicaAllocateString(size_t len);
#ifndef MAXLEN
#define MAXLEN 133
#endif
const char* ReadLine(const char *fileName, int lineNumber, int* endOfFile)
{
        FILE*  fp;
        char   c, strline[MAXLEN];
        char*  line;
        int    iLine;
        size_t lineLen;
        if ((fp=fopen(fileName,\"r\")) == NULL)
        {
                ModelicaFormatError(\"ReadLine: File %s not found!\\n\",fileName);
                return \"\";
        }
        iLine=0;
        while (++iLine <= lineNumber)
        {
                c=fgetc(fp);
                lineLen=1;
                while (c != '\\n' && c != '\\r' && c != EOF)
                {
                        if (lineLen < MAXLEN)
                        {
                                strline[lineLen-1]=c;
                                c=fgetc(fp);
                                lineLen++;
                        }
                        else
                        {
                                fclose(fp);
                                ModelicaFormatError(\"ReadLine: Line %d of file %s truncated!\\n\",iLine,fileName);
                                return \"\";
                        }
                }
                if (c == EOF && iLine < lineNumber)
                {
                        fclose(fp);
                        line=ModelicaAllocateString(0);
                        *endOfFile=1;
                        return line;
                }
        }
        fclose(fp);
        strline[lineLen-1]='\0';
        line=ModelicaAllocateString(lineLen);
        strcpy(line, strline);
        *endOfFile=0;
        return line;
}
#endif
", Documentation(info = "<html>
<h4>Syntax</h4>
<blockquote><pre>
(string, endOfFile) = <b>readLine</b>(fileName, lineNumber)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>readLine</b>(..) opens the given file, reads enough of the 
content to get the requested line, and returns the line as a string. 
Lines are separated by LF or CR-LF; the returned string does not 
contain the line separator.
</p>
<p>
If lineNumber > countLines(fileName), an empty string is returned
and endOfFile=true. Otherwise endOfFile=false.
</p>
</html>"));
  end readLineWithoutCache;

    annotation(uses(Modelica(version="3.2.2")));
end KeyWordIO;
