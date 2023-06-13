import java
import semmle.code.java.dataflow.TaintTracking

class LoggingSensitiveInformation extends TaintTracking::Configuration {
  LoggingSensitiveInformation() { this = "LoggingSensitiveInformation" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr().(MethodAccess).getMethod().hasName("getPassword")
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(MethodAccess ma |
      ma = sink.asExpr() and
      ma.getMethod().getDeclaringType() instanceof LogType and
      ma.getMethod().getName().matches("log%")
    )
  }
}

from LoggingSensitiveInformation cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "Sensitive information logged."
