import java

from ClassInstanceExpr cie
where cie.getType().hasQualifiedName("java.util", "Random") 
select cie, "java.util.Random is used, which is not cryptographically secure."
