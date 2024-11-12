module book::pub_module;
use sui::package::{Publisher};

public struct PUB_MODULE has drop {}

fun init(otw:PUB_MODULE,ctx : &mut TxContext){
    assert!(sui::types::is_one_time_witness(&otw));
   
    let publisher:Publisher = sui::package::claim(otw,ctx);
   
    std::debug::print(publisher.module_());
    std::debug::print(publisher.package());
    assert!(sui::package::from_package<PUB_MODULE>(& publisher));
    assert!(sui::package::from_module<PUB_MODULE>(& publisher));
    sui::transfer::public_transfer(publisher,ctx.sender());
}

#[test_only]
public struct Foo has drop{}

#[test]
#[expected_failure(abort_code = sui::package::ENotOneTimeWitness)]
fun test_package(){
    let o = Foo{};
    let mut ctx = tx_context::dummy();
    let publisher:Publisher = sui::package::claim(o,&mut ctx);

    let c = sui::package::from_package<Foo>(&publisher);
    std::debug::print(&c);

    sui::test_utils::destroy(publisher);
}