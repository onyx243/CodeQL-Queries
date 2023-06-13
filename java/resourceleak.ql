import java
import semmle.code.java.dataflow.TaintTracking

class PotentialResourceLeak extends TaintTracking::Configuration {
  PotentialResourceLeak() { this = "PotentialResourceLeak" }

  override predicate isSource(DataFlow::Node source) {
    exists(ConstructorCall cc |
      cc.getConstructedType().hasQualifiedName("java.io", "FileOutputStream") and
      cc = source.asExpr()
    )
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(MethodAccess ma |
      ma.getMethod().hasName("close") and
      ma.getQualifier() = sink.asExpr()
    )
  }
}

from PotentialResourceLeak config, DataFlow::Node source, DataFlow::Node sink
where not config.hasFlow(source, sink)
select source, "File opened here but potentially not closed."
