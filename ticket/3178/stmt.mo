encapsulated package InstSection
  uniontype Statement
    record ALG_WHEN_A
      list<list<Statement>> branches;
      SourceInfo info;
    end ALG_WHEN_A;

    record STMT_WHEN
      list<Statement> statementLst;
      Option<Statement> elseWhen;
    end STMT_WHEN;
  end Statement;

  function instStatement
    input Statement inStatement;
    output list<Statement> outStatements;
  algorithm
    outStatements := match inStatement
      local
        list<Statement> sstmts;
        Option<Statement> when_stmt_opt;
        Statement when_stmt;

      case ALG_WHEN_A()
        algorithm
          when_stmt_opt := NONE();

          for b in inStatement.branches loop
            when_stmt := STMT_WHEN(b, when_stmt_opt);
            when_stmt_opt := SOME(when_stmt);
          end for;
        then
          {when_stmt};

    end match;
  end instStatement;
end InstSection;
