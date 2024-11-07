module book::test_owner;


const OWNER:address= @0x540105a7d2f5f54a812c630f2996f1790ed0e60d1f9a870ce397f03e4cec9b38;

fun init(_ctx:&mut TxContext){

}

public entry fun mint(value:u64,ctx:&mut TxContext):u64{
    assert!(ctx.sender() == OWNER);
    //do moint 
    transfer::transfer(Coin{id:object::new(ctx),balance:value },ctx.sender());
    value
}

public struct Coin has key{
    id: UID,
    balance:u64,
}

#[test]
#[expected_failure]
fun test_mint(){
    let mut ctx = sui::tx_context::dummy();
    
    book::debug::log(&b"mint sender:",&ctx.sender());
    let a = mint(3333,&mut ctx);
    assert!(a == 33);
    std::debug::print(&a);
}
    
