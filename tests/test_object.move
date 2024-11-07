#[test_only]
module book::test_object{
    use std::string::String;
    use book::debug::log;
    public struct Foo has key{
        id: UID,
        name : String,
    }

    public fun newFoo(name:String,ctx:&mut TxContext): Foo{
        Foo { id: object::new(ctx), name }
    }


    public entry fun main(ctx:&mut TxContext){
        let foo = newFoo(b"ljl".to_string(), ctx);
        std::debug::print(ctx);
        
        std::debug::print(&b"to_address".to_string());
        std::debug::print(&foo.id.to_address());
        std::debug::print(&b"to_id".to_string());
        std::debug::print(&foo.id.to_address().to_id());
        std::debug::print(&foo.id.to_bytes());
        sui::transfer::transfer(foo,ctx.sender()); 
        std::debug::print(&b"created ids".to_string());
        log(&b"ids_created",&ctx.get_ids_created());//test_only method
        //tx_context::get_ids_created
        log(&b"last id", &ctx.last_created_object_id());
        log(&b"fresh object address",&ctx.fresh_object_address());
        log(&b"ids_created",&ctx.get_ids_created());
        log(&b"digest",ctx.digest());
        
        //sui::id::ID();
        //foo.id.to_inner()
        
    }

    #[test] 
    fun test_object_transfer(){
        let mut ctx = sui::tx_context::dummy();
        main(&mut ctx);
    }

}