module book::dynamic;
use sui::dynamic_field;
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
    
    dynamic_field::add(cid, b"hat_key", 
    Hat{id:object::new(ctx),color:0xff0000} );

    dynamic_field::add(cid,b"mustache_key",
    Mustache {
        id:object::new(ctx),
    });
    assert!(dynamic_field::exists_(cid,b"hat_key"),0);
    assert!(dynamic_field::exists_(cid,b"mustache_key"),1);
    let value:&mut Hat = dynamic_field::borrow_mut(cid,b"hat_key");
    value.color = 0x00ee00u32;
    
    let hat = dynamic_field::remove<vector<u8>,Hat>(cid,b"hat_key");
    let mustache = dynamic_field::remove<vector<u8>,Mustache>(cid,b"mustache_key");
    assert!(hat.color == 0x00ee00u32);
    assert!(!dynamic_field::exists_(cid,b"hat_key"),0);
    assert!(!dynamic_field::exists_(cid,b"mustache_key"),1);
    sui::test_utils::destroy(character);
    sui::test_utils::destroy(mustache);
    sui::test_utils::destroy(hat);
}