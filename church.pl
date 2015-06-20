role Zero { }
role Suc[::N] { }
subset Nat where Zero|Suc;

multi sub count(Zero) { 0 }
multi sub count(Suc[::N]) { 1 + count(N) }

subset _0 of Zero;
subset _1 of Suc[Zero];
subset _2 of Suc[_1];
subset _3 of Suc[_2];
# and on and on ...

say count(Suc[Suc[Suc[Zero]]]); #=> 3

role Add[::T1, ::T2] { ... }
role Mul[::T1, ::T2] { ... }
subset Op where Add|Mul;
subset NatOp where Nat|Op;

role Add[Zero, Zero] {
  method count { Zero };
}
role Add[Zero, NatOp ::N] {
  method count { N.count }
}
role Add[NatOp ::N, Zero] {
  method count { N.count }
}
role Add[NatOp ::N, NatOp ::N2] {
  method count { N2.count }
}

say Add[_2, Add[_1, _3]].count; #=> 9

role Mul[Zero, NatOp ::N] {
  method count { 0 };
}
role Mul[NatOp ::N, Zero] {
  method count { 0 }
}
role Mul[NatOp ::N, NatOp ::N2] {
  method count { N.count * N2.count }
}

say Mul[_3, Add[_1, Mul[_2, _2]]].count; #=> 15
