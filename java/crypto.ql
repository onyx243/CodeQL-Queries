import java

from ClassInstanceExpr cie
where cie.getConstructedType().hasQualifiedName("java.util", "Random")
select cie, "This instance of Random is not cryptographically secure."
