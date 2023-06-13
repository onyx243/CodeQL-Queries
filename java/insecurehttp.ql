import java

from MethodAccess ma
where ma.getMethod().getDeclaringType().getPackage().getName().matches("java.net") 
      and ma.getMethod().getName() = "openConnection"
      and ma.getArgument(0).(StringLiteral).getValue().matches("http://%")
select ma, "This request is made over HTTP, which is not secure."
