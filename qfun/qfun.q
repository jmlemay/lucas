/ List of primes

odds:{
	3 + 2*til(x-1) div 2
 } 
/  list of odd numbers >1 and <=x

isPrime:{
	not 0 in x mod tmp:odds[floor sqrt x]
 } 
/ check if there is 0 in the list of remainders of division of x 
/by all odd<= sqrt x (Recall that if x is not prime than there is a prime
/ <= sqrt x that divides x)

lp:{
	tmp:odds x; isPrime each  tmp; 2, tmp where 1=isPrime each tmp   
 }
/ list of primes <= x (fixes the list odds x, then apply isprime in 
/this list, take only the ones that are prime, add 2)

//////////////////////////////////////////////

CanVec:{
	tmp:x#0; tmp[y]:1; tmp
 } 
/ [x;y] gives the canonical vector with of size x, with 1 at entry y and 
/zeros elsewhere

PercentSign:{
	tmp:CanVec[x;] each  (x-1) - til x; tmp[0;0]:tmp[x-1;x-1]:1; tmp
 }

//////////////////////////////////////////////////

PrimDiv:{
	tmp where 0=x mod tmp:lp x
 } 
/ list of primes dividing x

MaxPowerDiv:{
	last tmp where  0=y mod  (x xexp') each tmp:1+til y
 } 
/ [x;y] Maximal power of x dividing y

g:{
	prd (x xexp) MaxPower[x;y]
 } 
/ [x;y] gives x^n where n is maximal such that x^n divides y

ListMaxPower:{
	[y] g[;y] each PrimDiv y
 }
/ [x;y] gives list of x^n that divides y, with x prime dividing y 
/and n maximal

MaxPower:{
	last tmp where y>=tmp:(x xexp') each 1+til y
 } 
/ [x;y] Maximal power of x <= y

MaxMult:{
	[y] prd MaxPower[;y] each lp y
 }
/ maximal multiple of all positive integers <=y


f:{
	(+':)[x],1
 } 
/ f applies to a list l_1,…,l_n and gives a new list whose i-tem is
/ l_{i-1}+l_i, and append 1 at the end. 

Pas:{
	{x f/1} each 1+ til x
 } 
/ {x f/1} is just f^x[1]. This is how to consider a power of a function.

