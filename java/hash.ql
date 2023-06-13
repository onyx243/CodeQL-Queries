import java

from MethodAccess ma
where ma.getMethod().getDeclaringType().getPackage().getName().matches("java.security") 
      and ma.getMethod().getName() = "getInstance"
      and ma.getArgument(0).(StringLiteral).getValue().toLowerCase().matches(["md5", "sha-1"])
select ma, "This hash function is weak."
