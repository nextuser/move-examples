module book::test_typename{
    use std::type_name::{Self,TypeName};
    use std::ascii::String;

    public struct TypeInfo has drop{
        is_primitive:bool,
        address_info: String,
        module_name: String,
        name:String,
        name2:String,
    }
    
    public fun do_i_now<T>(_ :&T):TypeInfo {
        let t:TypeName = type_name::get<T>();
        let str :String = * t.borrow_string(); // 解引用,拷贝到str
        TypeInfo{
            is_primitive:t.is_primitive(),
            module_name:t.get_module(),
            address_info:t.get_address(),
            name:t.into_string(),
            name2:str,
        }
    }

    public struct MyObject has drop{

    }

    #[test]
    fun test_know(){
        let o = MyObject{};
        let info = do_i_now(&o);
        std::debug::print(&info);

    }
}

