/ inicial data table 
t:([] sym:enlist `MSFT;  bid:enlist 50; bidSize:enlist 10; 
	ask:enlist 80; askSize:enlist 30; time:.z.p)


bidGen:{
    [lastbid;lastask];
    $[0=lastask-lastbid;
	(first t[`bid]) + floor(0.5+(rand 0.1*a) 
	- (rand  0.1*a:(first t[`bid])));lastbid +
    rand((ceiling rand abs 0.1*(1+lastask-lastbid)),0)]
 }


bidSizeGen:{
    [lastbid;lastask];
    $[0=lastask-lastbid;
	(last t[`bidSize]) + floor(0.5+ (rand 0.1*(last t[`bidSize])) 
	- (rand 0.1*(last t[`bidSize]))); 
	last t[`bidSize]]
 }


askGen:{
    [lastbid;lastask];
	newbid:bidGen[lastbid;lastask];
    $[0=lastask-lastbid;
	newask:max(newbid;((first t[`ask]) + floor(0.5+ (rand 0.1*b) - 
	(rand  0.1*b:(first t[`ask])))));
	newask:max(newbid;(lastask - 
	rand((ceiling rand abs 0.1*(1+lastask-newbid)),0)))];
	newbid, newask
 }


askSizeGen:{
    [lastbid;lastask];
    $[0=lastask-lastbid;
	(last t[`askSize]) + floor(0.5+ (rand 0.1*(last t[`askSize])) - 
	(rand  0.1*(last t[`askSize]))); 
    last t[`askSize]]
 }


quoteGen:{
	[lastbid;lastask]; 
	newbid:askGen[lastbid;lastask][0]; 
	newask:askGen[lastbid;lastask][1];
	newbidSize:bidSizeGen[lastbid;lastask]; 
	newaskSize:askSizeGen[lastbid;lastask];
	enlist `MSFT, newbid, newbidSize, newask, newaskSize, .z.p
 }


tableGen:{
	t,:quoteGen[x;y]
 }

