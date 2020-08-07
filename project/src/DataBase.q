/ Initialize data table.
t:([]sym:enlist`MSFT;bid:enlist 50;bidSize:enlist 10;ask:enlist 80;askSize:enlist 30;time:.z.p) //! Temporary

/ Gets a file handle.
/ @param relPath	{string}	Relative path (from project root) to file.
getFileHandle:{[relPath]
	hsym`$getenv[`DB_PROJECT_HOME],"/",relPath
 }

/ Reads variance parameters from params.csv.
cfg:1!("SFCS";enlist",")0:getFileHandle"cfg/params.csv"

/ Append quoteGen to table
tableGen:{[x;y]
	t,:quoteGen[x;y]
 }

/ generates new quote based on last quote
quoteGen:{[lastBid;lastAsk]
	a:askBidGen[lastBid;lastAsk]; / Generate new ask and bid
	newBidSize:bidSizeGen[lastBid;lastAsk]; / Get new bid size 
	newAskSize:askSizeGen[lastBid;lastAsk]; / Get new ask size
	enlist`MSFT,a[`bid],newBidSize,a[`ask],newAskSize,.z.p / Return table row
 }

/ Generates new ask based on last new bid
askBidGen:{[lastBid;lastAsk]
	newBid:bidGen[lastBid;lastAsk];

	$[lastAsk=lastBid;
		newAsk:max(newBid;genRand[v;lastAsk;v:lastAsk*cfg[`askVar;`val]]);
		newAsk:max(newBid;genRand[0.5+(lastAsk-newBid)*cfg[`askVar;`val];lastAsk;0])];

	`bid`ask!newBid,newAsk
 }

/ Generates new bid size
bidSizeGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		genRand[v;lastBidSize;v:(lastBidSize:last t`bidSize)*cfg[`bidSizeVar;`val]];
		last t`bidSize]
 }

/ Generates new ask Size
askSizeGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		genRand[v;lastAskSize;v:(lastAskSize:last t`askSize)*cfg[`askSizeVar;`val]];
		last t`askSize]
 }

/ Generates new bid
bidGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		genRand[2*v;lastBid;v:lastBid*cfg[`bidVar;`val]]; / we could talk about this 2*v
		genRand[0;lastBid;0.5+(lastAsk-lastBid)*cfg[`bidVar;`val]]]
 }

/ Generates a random integer within a non-symetric interval. //! Use this style everywhere
/ @param left	{number}	Size of left radius.
/ @param mid	{number}	"Centre" of the interval.
/ @param right	{number}	Size of right radius.
/ @return		{long}		A random number within (mid-left, mid+right).
genRand:{[left;mid;right]
	"j"$mid+rand["f"$left+right]-left
 }
