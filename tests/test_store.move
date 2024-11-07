module book::test_store;

module book::transfer_a{
    public struct ObjectK has key{ id:UID}
    public struct ObjectKS has key,store {id:UID}
    
    public fun do_transferK(k:ObjectK, to :address){
        sui::transfer::transfer(k,to);
    }
    
    #[allow(lint(custom_state_change))]
    public fun do_transferKS(ks:ObjectKS, to :address){
        sui::transfer::transfer(ks,to);
    }

    public fun burn(k:ObjectK){
        let ObjectK{id } = k;
        id.delete();
    }
}

module book::transfer_b{
    use book::transfer_a::{ObjectK,ObjectKS};

    public fun transfer_k(k:ObjectK,to:address){
        //编译失败 k 只能被内部模块transfer
       //todo sui::transfer::transfer(k,to);
        //编译失败 k不满足store限制
       //todo sui::transfer::public_transfer(k,to);

       // release resource
        _ = to;
        book::transfer_a::burn(k);
    }

    public fun transfer_ks(ks:ObjectKS,to:address){
        //transfer 只能转移module内定义的对象
        //sui::transfer::transfer(ks,to);
        sui::transfer::public_transfer(ks,to);

    }
}