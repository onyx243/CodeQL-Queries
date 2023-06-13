import java
import semmle.code.java.dataflow.TaintTracking

class SqlInjection extends TaintTracking::Configuration {
  SqlInjection() { this = "SqlInjection" }

  override predicate isSource(DataFlow::Node source) {
    exists(Call c |
      c.getAnArgument() = source.asExpr() and
      c.getCallee().getName() = "getParameter"
    )
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(Jdbc::StatementExecute stmt |
      stmt.getEnclosingCallable().fromSource() and
      sink.asExpr() = stmt.getSql()
    )
  }
}

from SqlInjection cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "SQL Injection vulnerability due to user-controllable data."
