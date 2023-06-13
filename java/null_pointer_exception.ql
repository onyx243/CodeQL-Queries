import java

from IfStmt ifs, Variable v
where ifs.getCondition().getAChild*().(EqualityOperation).getAnOperand() = v.getAnAccess()
  and ifs.getThen().getAChild*().(VariableAccess).getVariable() = v
select v, "Potential null pointer dereference in 'if' statement"
