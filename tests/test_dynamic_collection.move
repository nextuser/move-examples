#[test_only]
module  book::test_dynamic_collection{
    
    public struct Wrap<T> has store,drop{
        value:T,
    }

    public fun wrap<T>(value: T ): Wrap<T>{
        Wrap<T>{
            value
        }

    }

    public struct Hat has key,store{ id:UID}
    
    use sui::bag::{Self,Bag};
    #[test]
    fun test_bag(){
        let mut ctx = tx_context::dummy();
        let mut bg:Bag = bag::new(&mut ctx);
        assert!(bg.length() == 0,0);
        let v = b"my_value".to_string();
        let v1 = v;
        assert!(!bg.contains(b"my_key"));
        bg.add(b"my_key",v);
        assert!(bg.contains(b"my_key"));
        
        bg.add(b"a",wrap(1));
        assert!(bg.contains(b"a"));

        bg.add(b"b",2);
        assert!(bg.contains(b"b"));


        assert!(bg.borrow(b"a") == wrap(1));
        assert!(bg.borrow(b"b") == 2);
       
        
        assert!(bg.length() == 3, 1);
        assert!(bag::borrow(&bg ,b"my_key") == v1);
        sui::test_utils::destroy(bg);
    }


       #[test]
    fun test_bag_contains(){
        let mut ctx = tx_context::dummy();
        let mut bg = bag::new(&mut ctx);
        assert!(bg.length() == 0,0);
        let key = b"my_key";
        assert!(!bg.contains(key));
        bg.add(key,33);
        assert!(bg.contains(key));
        assert!(bg.borrow(key) == 33);
        sui::test_utils::destroy(bg);
        
    }
}