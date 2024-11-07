module book::test_capability;

use std::string::String;
use sui::event;

public struct Account has key,store{id:UID,name:String}
public struct AdminCap has key{id:UID}

public struct Ping has copy,drop{ by:ID }

public fun new_cap(_:&AdminCap,name:String,ctx:&mut TxContext) :Account {
    Account{
        id:object::new(ctx),
        name,
    }
}

public fun send_ping(acc:&Account){
    event::emit(Ping{by:acc.id.to_inner()});
}

public fun update(account:&mut Account,name:String){
    account.name = name;
}

fun init(ctx:&mut TxContext){
    transfer::transfer(AdminCap{id:object::new(ctx)}, ctx.sender());
}


#[test]
fun test_cap(){
    let mut ctx = tx_context::dummy();
    init(&mut ctx);
    let cap = AdminCap{id: object::new(&mut ctx)};

    let acc = book::test_capability::new_cap(&cap ,b"abc".to_string(),&mut ctx);

    let Account{id , name:_ } = acc;
    id.delete();
    let AdminCap{id } = cap;
    id.delete();
}
