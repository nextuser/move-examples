module book::test_string{
    public struct MyString{
        bytes: vector<u8>,
    }

    public fun from_bytes(bytes:vector<u8> ) : MyString{
        MyString{ bytes}
    }

    public fun bytes(self : &MyString) :&vector<u8>{
        &self.bytes
    } 
}

#[test_only]
module book::tests_string{
    use std::string::{Self,String};
    use std::debug::print;
    #[test]
    fun test_utf8(){
        let hello:String = string::utf8(b"早晨好!");
        print(&hello);
        print(&hello.length());

        let str = b"china".to_string();
        print(&str);
        print(&str.length());
    }

    #[test]
    fun test_append(){
        let mut str = b"Hello,".to_string();
        let another = b" World!".to_string();

        str.append(another);
        print(&str);
        print(&str.substring(0, 5));

        print(&str.length());
        print(&str.is_empty());
        let bytes = str.as_bytes();
        print(&bytes.length());
    }

    #[test]
    fun test_invalid(){
        let hello = b"hello".try_to_string();
        assert!(hello.is_some());
        let invalid = b"\xFF".try_to_string();
        assert!(invalid.is_none());
        print(&invalid.is_none());
    }
}