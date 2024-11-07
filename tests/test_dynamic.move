module book::dynamic;
use sui::dynamic_field as df;
use std::string::String;

public struct Character has key{
    id:UID,
}

public struct Hat has key,store{ id:UID,color:u32}
public struct Mustache has key,store{id:UID}

#[test]
fun test_character_and_accessories(){
    let ctx = &mut tx_context::dummy();
    let mut character = Character{id:object::new(ctx)};
    let cid:&mut UID = &mut character.id; 
    
    df::add(cid, b"hat_key", 
    Hat{id:object::new(ctx),color:0xff0000} );

    df::add(cid,b"mustache_key",
    Mustache {
        id:object::new(ctx),
    });
    assert!(df::exists_(cid,b"hat_key"),0);
    assert!(df::exists_(cid,b"mustache_key"),1);

    let hat =df::remove<vector<u8>,Hat>(cid,b"hat_key");
    let mustache = df::remove<vector<u8>,Mustache>(cid,b"mustache_key");
    assert!(hat.color == 0xff0000u32);
    assert!(!df::exists_(cid,b"hat_key"),0);
    assert!(!df::exists_(cid,b"mustache_key"),1);
    sui::test_utils::destroy(character);
    sui::test_utils::destroy(mustache);
    sui::test_utils::destroy(hat);
}