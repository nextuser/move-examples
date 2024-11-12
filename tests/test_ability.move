#[test_only]
module book::ability{
    use std::debug::print;
    public struct NoDrop{}
    public struct IgnoreMe has drop{
        a:u32,
        b:u32
    }

    #[test]
    fun test_ignore(){
        let im = IgnoreMe{a:3,b:4};
        print(&im);
        let no_drop = NoDrop{};
        print(&no_drop);

        let NoDrop{} = no_drop;
    }

    public struct Copyable has copy{
        value :u64,
    }

    #[test]
    fun test_copy(){
        let c = Copyable{ value:33};
        let mut d = c ; //此时c对象拷贝给d
        d.value = 44;
        std::debug::print(&c);
        std::debug::print(&d);
        
        sui::test_utils::destroy(c);
        sui::test_utils::destroy(d);
    }   

    
    public struct Keyable has key,store{
        id : UID,
    }

    #[test]
    fun test_key(){
        let mut ctx = tx_context ::dummy();
        let k = Keyable{ id: object::new(&mut ctx)};
        std::debug::print(&k);
        transfer::public_transfer(k,ctx.sender());
    }


    public struct Storeable has store{
        
    }
    
    public struct Object1 has key,store{
        id: UID,
        value : Storeable,
    }
    
    #[test]
    fun test_storeable(){
        let mut  ctx = tx_context::dummy();
        let o = Object1 {
            id : object::new(&mut ctx),
            value:Storeable{},
        };
        std::debug::print(&o);
        transfer::transfer(o,ctx.sender());
    }


    public struct NonCopyable {
        value :u64,
    }

    #[test]
    fun test_non_copy(){
        let c = NonCopyable{ value:33};
        let d =c ;
       // std::debug::print(&c); //此时c对象已经被移动给d
        std::debug::print(&d);

       // sui::test_utils::destroy(c);
        sui::test_utils::destroy(d);
    }   
}