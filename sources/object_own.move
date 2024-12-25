module book::object_own;
use std::string::{Self,String};

public struct A has key{
    id : UID,
    name : String,
}

public struct B has key {
    id : UID,
    name : String
}

#[allow(lint(self_transfer))]
fun init(ctx :&mut TxContext){
    let a = A {
        id : object::new( ctx),
        name : b"a object".to_string()
    };

    let b = B {
        id : object::new( ctx),
        name : b"b object".to_string()
    };
    //把b转移给一个对象a的地址
    transfer::transfer(b,  a.id.uid_to_address());
    transfer::transfer(a , ctx.sender());

}

public struct UseBEvent has copy,drop{
    name : String
}

//尝试拥有a的sender，是否能使用b
public fun  useB(b : &B){
    sui::event::emit(UseBEvent{
        name : b.name
    })
    
}

#[test_only]    const Alice : address = @0xa;
#[test_only] use sui::test_scenario::{Self as test,Scenario};
#[test]
fun test_object_own(){

    let mut sc = test::begin(Alice);
    {
        init(sc.ctx());
    };
    
    sc.next_tx(Alice);
    {
        let a = test::take_from_address<A>(&mut sc,Alice);
        let b = test::take_from_address<B>(&mut sc,a.id.uid_to_address());
        useB(&b);   
        test::return_to_address(a.id.uid_to_address(),b);
        test::return_to_address(Alice,a);

    };
    test::end( sc);

}