module book::loan;
//hot potato pattern
public struct Loan{
    feedback: u64, //还钱数
}

public struct Coin has key,store{
	id:UID,//
	amount:u64
}

//借出钱
public fun borrow(amount:u64,ctx:&mut TxContext) :(Coin,Loan){
	let feedback = amount * 103 /100;
	let c = Coin{ id: object::new(ctx),amount};
	(c, Loan{feedback}) 
}

const ErrNotEnoughFeedback:u64 = 43;
const OWNER_ADDR :address = @0xafe36044ef56d22494bfe6231e78dd128f097693f2d974761ee4d649e61f5fa2;//todo

public fun repay(coin: Coin,loan:Loan){
	assert!(coin.amount >= loan.feedback,ErrNotEnoughFeedback);
	transfer::public_transfer(coin,OWNER_ADDR);
	Loan{ feedback:_} = loan;
}
