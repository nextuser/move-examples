module book::addr_module{

    use sui::address;
    use std::debug::print;
    #[test]
    public fun test_addr(){
        let addr_u256 = address::to_u256(@std);
        let addr = address::from_u256(0xdeadbeaf);
        print(&addr_u256);
        print(&addr);
        //let str = address::to_string(addr);
        print(&b"bytes:".to_string());
        let bytes = address::to_bytes(addr);

        print(&bytes);

        print(&address::from_bytes(bytes));
    }
    
}