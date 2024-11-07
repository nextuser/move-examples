#[test_only]
module book::test_structs{
    use std::string::String;

    public struct Artist{
        name:String,
    }
    
    #[allow(unused_field)]
    public struct Record{
        title:String,
        artist:Artist,
        year:u16,
        is_debut:bool,
        edition:Option<u16>,

    }

    #[test]
    public fun test_struct(){

        let mut artist = Artist{
            name : b"The Beatles".to_string(),
        };

        let artist_name  = artist.name;
        std::debug::print(&artist_name);
        assert!(artist.name == b"The Beatles".to_string());
        artist.name = b"Led Zepplin".to_string();
        let Artist{name:_} = artist;
    }
    
    public struct P(u64, u64)
    
    #[test]
    public fun test_destruct_pos(){
       let p = P(3,4);
       std::debug::print(&p);
       let P(local1,local2) = p;
       assert!(local1==3);
       assert!(local2==4);
    }

    public struct T {
        f1:u32,
        f2:u32
    }
    
    
    #[test]
    fun test_struct_ref_borrow(){
        let mut t = T{f1:3, f2:4};
        book::debug::log(&b"before changed", &t); //借用只读引用
        //todo 这个表现比较特殊
        let T{f1: local1,f2: local2} = & mut t; //借用可变引用,不会被解构
        *local1 = 5 ;
        *local2 = 6;
        book::debug::log(&b"local1",local1);
        book::debug::log(&b"local2",local2);
        book::debug::log(&b"after changed", &t); //借用只读引用
        let T{f1:_,f2:_} = t; //最后解构释放
    }


}