module book::test_move;

fun to_show(n : u64) :vector<u8>{
    match(n){
        0 => return b"less",
        1 => return b"equal",
        2 => return b"greater",
        _ => b"invalid",
    }
}

#[test]
fun test_match(){
    std::debug::print(&to_show(0));
    std::debug::print(&to_show(1));
    std::debug::print(&to_show(2));
    std::debug::print(&to_show(3));
    assert!(to_show(0) == b"less");
    assert!(to_show(1) == b"equal");
    assert!(to_show(2) == b"greater");
    assert!(to_show(999) == b"invalid");
}