/ Initialize data table.
t:([]sym:enlist`MSFT;bid:enlist 50;bidSize:enlist 10;ask:enlist 80;askSize:enlist 30;time:.z.p)

//! Needs documentation.
bidGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		first[t`bid]+genRand[f;f:first t`bid;.cfg.bidVar];
		lastBid+rand ceiling[rand abs 0.1*1+lastAsk-lastBid],0]
 }

//! Needs documentation.
bidSizeGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		last[t`bidSize]+floor 0.5+rand[0.1*last t`bidSize]-rand 0.1*last t`bidSize; 
		last t`bidSize]
 }

//! Needs documentation.
askBidGen:{[lastBid;lastAsk]
	newBid:bidGen[lastBid;lastAsk];

    $[0=lastAsk-lastBid;
		newAsk:max(newBid;first[t`ask]+floor 0.5+rand[0.1*b]-rand 0.1*b:first t`ask);
		newAsk:max(newBid;lastAsk-rand(ceiling rand abs 0.1*1+lastAsk-newBid),0)];

	`bid`ask!newBid,newAsk
 }

//! Needs documentation.
askSizeGen:{[lastBid;lastAsk]
    $[0=lastAsk-lastBid;
		last[t`askSize]+floor 0.5+rand[0.1*last t`askSize]-rand 0.1*last t`askSize; 
		last t`askSize]
 }

//! Needs documentation.
quoteGen:{[lastBid;lastAsk]
	a:askBidGen[lastBid;lastAsk]; / Generate new ask and bid
	newBidSize:bidSizeGen[lastBid;lastAsk]; / Get new bid size 
	newAskSize:askSizeGen[lastBid;lastAsk]; / Get new ask size
	enlist`MSFT,a[`bid],newBidSize,a[`ask],newAskSize,.z.p / Return table row
 }

//!
genRand:{[x;y;v]
	x+rand[2*vx]-vx:v*x
 }

//! Needs documentation.
tableGen:{[x;y]
	t,:quoteGen[x;y]
 }
