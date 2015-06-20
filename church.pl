role Zero { }
role Suc[::N] { }

multi sub count(Zero) { 0 }
multi sub count(Suc[::N]) { 1 + count(N) }

subset _0 of Zero;
subset _1 of Suc[Zero];
subset _2 of Suc[_1];
subset _3 of Suc[_2];
# and on and on ...

say count(Suc[Suc[Suc[Zero]]]); #=> 3

role Add[Zero, ::N, Result = N] {}

role Add[Suc[::N], ::N2, Result = Add[N, Suc[N2]].Result] {}

say count(Add[_3, _1].Result);
