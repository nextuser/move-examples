module book::dynamic_object;

public struct Wrap<T> has copy ,store,drop{
    value: T,
}

public fun wrap<T>(value: T ): Wrap<T> {
    Wrap<T>{
        value
    }
}

#[test]
fun showWrap(){
    std::debug::print(&wrap(33u32));
}
/**
public fun add<Name:copy + drop + store, Value:key +store> (
    id: &mut UID,
    name:Name,
    value:Value,
)**/

use std::string::String;
use sui::dynamic_field as df;
use sui::dynamic_object_field as dof;

public struct Character has key{id :UID}

public struct Metadata has store,drop{
    name:String,
}

public struct Accessory has key,store{ id:UID}

#[test]
fun equip_accessory(){

    let  meta_key:vector<u8> = b"metadata_key";
    let  hat_key:vector<u8> = b"hat_key";
    let ctx = &mut tx_context::dummy();
    let mut character = Character{
        id:object::new(ctx),
    };
    let id = &mut character.id;
    let hat = Accessory{id: object::new(ctx)};
    dof::add(id,hat_key,hat);
    let mdata = Metadata{
        name:b"John".to_string(),
    };
    std::debug::print(&mdata);
    assert!(mdata.name == b"John".to_string());
    df::add(id,meta_key,mdata);
    
    
    let meta:&mut Metadata =  df::borrow_mut<vector<u8>,Metadata>(id,meta_key);
    meta.name = b"charles".to_string();
    assert!(meta.name == b"charles".to_string());
    sui::test_utils::destroy(character);

}