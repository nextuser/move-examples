#[test_only]
module book::test_vector{
    use std::string::String;
    use sui::vec_set::{Self,VecSet};
    public struct Book has key,store{
        id : UID,
        name:String,
    }

    public struct BookStore has key,store{
        id:UID,
        books:vector<Book>,
    }
    fun add_book(bstore:&mut BookStore,name:vector<u8>,ctx:&mut TxContext):u64{
        let book = Book{
            id: object::new(ctx),
            name: std::string::utf8(name),
        };
        bstore.books.push_back(book);
        bstore.books.length()
    }

    fun new_store(ctx :&mut TxContext):BookStore{
        let store = BookStore{ 
            id:object::new(ctx),
            books: vector::empty<Book>(),
        
         };
         store
    }



    #[test]
    fun test_book_store(){
        let mut ctx = tx_context::dummy();
        let mut store = new_store(&mut ctx);

         store.add_book(b"平凡的人生",&mut ctx);
         store.add_book(b"白鹿原",&mut ctx);
         assert!(store.add_book(b"我与地坛",&mut ctx) == 3);
         transfer::public_transfer(store,ctx.sender());
    }
   
    #[test]
    #[expected_failure(abort_code=sui::vec_set::EKeyAlreadyExists)]
    fun test_set(){
        let mut s = vec_set::empty<u8>();
        s.insert(32);
        s.insert(44);
        s.insert(32);
        assert!(s.size() == 2);
    }

    #[test]
    fun test_set_size(){
        let mut s = vec_set::empty<u8>();
        s.insert(32);
        s.insert(44);
        assert!(s.size() == 2);
    }


}