module book::internal_visibility{
    fun show_internal(){
        std::debug::print(&b"internal");
    }

    public(package) fun show_package(){
        std::debug::print(&b"public package");
    }

    #[test]
    fun try_call_internal(){    
        std::debug::print(&b"call internal");
        show_internal();
    }

}

module book::try_call_visibility{
    #[test]
    fun try_call_internal(){
        //internal函数不能被外部效用
       // book::internal_visibility::show_internal();
    }
    #[test]
    fun try_call_package(){
        book::internal_visibility::show_package();
    }
}

