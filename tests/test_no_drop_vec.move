module book::no_drop{
    public struct NoDrop{

    }

    #[test]
    public fun test_destory(){
        let v = vector<NoDrop>[];
        std::debug::print(&v.length());
        v.destroy_empty();
    }

}