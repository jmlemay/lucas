/ Initialize data table.
t:([]sym:enlist`MSFT;bid:enlist 50;bidSize:enlist 10;ask:enlist 80;askSize:enlist 30;time:.z.p)

//! Needs documentation.
bidGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		first[t`bid]+floor 0.5+rand[0.1*a]-rand 0.1*a:first t`bid;
		lastBid+rand ceiling[rand abs 0.1*1+lastAsk-lastBid],0]
 }

//! Needs documentation.
bidSizeGen:{[lastBid;lastAsk]
	$[0=lastAsk-lastBid;
		last[t`bidSize]+floor 0.5+rand[0.1*last t`bidSize]-rand 0.1*last t`bidSize; 
		last t`bidSize]
 }

//! Needs documentation.
askGen:{[lastBid;lastAsk]
	newBid:bidGen[lastBid;lastAsk];

    $[0=lastAsk-lastBid;
		newAsk:max(newBid;first[t`ask]+floor 0.5+rand[0.1*b]-rand 0.1*b:first t`ask);
		newAsk:max(newBid;lastAsk-rand(ceiling rand abs 0.1*1+lastAsk-newBid),0)];

	newBid,newAsk
 }

//! Needs documentation.
askSizeGen:{[lastBid;lastAsk]
    $[0=lastAsk-lastBid;
		last[t`askSize]+floor 0.5+rand[0.1*last t`askSize]-rand 0.1*last t`askSize; 
		last t`askSize]
 }

//! Needs documentation.
quoteGen:{[lastBid;lastAsk]
	newBid:askGen[lastBid;lastAsk][0]; 
	newAsk:askGen[lastBid;lastAsk][1];
	newBidSize:bidSizeGen[lastBid;lastAsk]; 
	newAskSize:askSizeGen[lastBid;lastAsk];
	enlist`MSFT,newBid,newBidSize,newAsk,newAskSize,.z.p
 }

//! Needs documentation.
tableGen:{[x;y]
	t,:quoteGen[x;y]
 }
