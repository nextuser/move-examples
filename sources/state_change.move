module book::state_change;
use sui::event::emit;
use std::string::{Self,String,utf8};

public struct StateEvent has copy,drop{
    addr : address,
    from_state:String, 
    to_state:String,
    old_owner:address,
    owner: address,
}

const ADDR_NONE : address = @0x0;
const ADDR_PUBLIC : address = @0x1;

public struct Foo has key {
    id : UID,
    state : String,
    owner : address,
}

fun change_state(foo: &mut Foo , to_state : vector<u8> , owner :address)
{
    let old_owner = foo.owner;
    let from_state =  foo.state;
    foo.owner = owner;

    foo.state = utf8(to_state);
    emit( StateEvent{
        addr : foo.id.to_address(),
        from_state ,
        to_state: foo.state,
        old_owner:old_owner,
        owner:owner,
    });

}

public entry fun destory( foo :Foo ,_:&TxContext) {
    let mut f = foo;
    change_state( &mut f, b"destroy", ADDR_NONE);
    let Foo{ id,state:_ ,owner:_ } = f;
  
    object::delete(id);
}

public entry fun do_freeze( foo :Foo ,_:&TxContext) {
    let mut f = foo;
    change_state( &mut f, b"freeze", ADDR_PUBLIC);
    transfer::freeze_object(f);
}

fun new_foo(ctx :&mut TxContext):Foo {
    let mut foo = Foo{
        id : object::new(ctx),
        state : utf8(b"new"),
        owner : ADDR_NONE,
    };
    change_state(&mut foo,b"running", ADDR_NONE);
    foo
}


public entry fun mint_and_transfer(to: address,ctx :&mut TxContext) {
    let foo = new_foo(ctx);
    transfer::transfer(foo,to);
}

public entry fun do_share( foo : Foo ,_:&TxContext) {
    let mut f = foo;
    change_state( &mut f ,b"share", ADDR_PUBLIC);
    transfer::share_object(f);
}


public entry fun do_transfer( foo : Foo, to :address ,_:&TxContext) {
    let mut f = foo;
    change_state(&mut f, b"own", to);
    transfer::transfer(f,to );
}

fun init(ctx : &mut TxContext){
       let foo = new_foo(ctx);
       do_transfer(foo, ctx.sender(),ctx); 
}


