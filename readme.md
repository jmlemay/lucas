# lucas

Style Guide
------------

- Variable/function names should be `camelCase`
- Most lines should have comments. Capitalize the first letter, no period at the end. E.g.
	```
	z:sum each x,'y; / Describe what this is doing
	```
- Blocks of code that collectively do something should be preceded with a block comment. Capitalize the first letter, put a period at the end.
	```
	/ This block of code does blah blah blah. The comments here
	/ can span multiple lines.
	t:select from quote where sym=`MSFT; / Get MS quotes
	t:select avg price by 60000 xbar time from t; / Average price by second
	```
- Functions should be declared with proper documentation. This includes a description of the function, the variables (with types), and the return value. Variables go on the same line as the function name. Each line in the function should be indented by one tab. The closing brace should be indented by one space.
	```
	/ Does blah blah blah.
	/ @param tn	{sym}	Parameter description (notice the indentation).
	/ @param td	{table}	Another parameter description.
	/ @return	{table}	Return description.
	myFn:{[tn;td]
		/ Do something.
	 }
	 ```
- Avoid unnecessary spaces and parentheses.
	```
	x + (y + 1); / Bad
	x+y+1; / Good
	```
- If you need parentheses, use `[]` instead of `()` where possible.
	```
	(sum x)%y; / Bad
	sum[x]%y; / Good
	```
- If a line runs too long, separate and indent one extra tab.
	```
	t:select price:someLongFnName[price;time],time:toTimeZone[time;`$"America/New York"]
		from table where sym in`AAPL`MSFT,time<12:00;
	```
- `if` and `$` (and the like) use an extra indent. The closing bracket should be done on the last line.
	```
	if[x>10;
		y:2*x;
		z:y-5];
	```

 blah blah blah
