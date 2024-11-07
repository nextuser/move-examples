#[test_only]
module book::NoDrop{
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

    
}