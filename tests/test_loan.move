#[test_only]
module book::test_loan;
use book::loan::Coin;
////todo 贷款后赚钱的业务逻辑
fun earn_money(coin : Coin ) :Coin{
    coin
}


#[test]
#[expected_failure(abort_code=book::loan::ErrNotEnoughFeedback)]
fun borrow_test(){
	let mut ctx = tx_context::dummy();
	let (coin,loan) = book::loan::borrow(233,&mut ctx);
	let new_money = earn_money(coin);
	book::loan::repay(new_money,loan);
	//todo 赚钱了，可以把feedback-amount 的钱，存入自己钱包
}