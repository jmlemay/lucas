/ Initialize data table.
t:([]sym:enlist`MSFT;bid:enlist 50;bidSize:enlist 10;ask:enlist 80;askSize:enlist 30;time:.z.p)

/ Define varicance parameters.
cfg:`askVar`bidVar`bidSizeVar`askSizeVar!0.1 0.1 0.1 0.1

/ Generates a random integer in (x-y,x+z) 
genRand:{[y;x;z]
	"j"$x+rand["f"$y+z]-y
 }

/ Generates new bid
bidGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		genRand[2*v;lastBid;v:lastBid*cfg`bidVar]; / we could talk about this 2*v
		genRand[0;lastBid;0.5+(lastAsk-lastBid)*cfg`bidVar]]
 }

/ Generates new bid size
bidSizeGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		genRand[v;lastBidSize;v:(lastBidSize:last t`bidSize)*cfg`bidSizeVar];
		last t`bidSize]
 }

/ Generates new ask based on last new bid
askBidGen:{[lastBid;lastAsk]
	newBid:bidGen[lastBid;lastAsk];
	$[0=lastAsk-lastBid;
		newAsk:max(newBid;genRand[v;lastAsk;v:lastAsk*cfg`askVar]);
		newAsk:max(newBid;genRand[0.5+(lastAsk-newBid)*cfg`askVar;lastAsk;0])];

	`bid`ask!newBid,newAsk
 }

/ Generates new ask Size
askSizeGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		genRand[v;lastAskSize;v:(lastAskSize:last t`askSize)*cfg`askSizeVar];
		last t`askSize]
 }

/ generates new quote based on last quote
quoteGen:{[lastBid;lastAsk]
	a:askBidGen[lastBid;lastAsk]; / Generate new ask and bid
	newBidSize:bidSizeGen[lastBid;lastAsk]; / Get new bid size 
	newAskSize:askSizeGen[lastBid;lastAsk]; / Get new ask size
	enlist`MSFT,a[`bid],newBidSize,a[`ask],newAskSize,.z.p / Return table row
 }

/ Append quoteGen to table
tableGen:{[x;y]
	t,:quoteGen[x;y]
 }
