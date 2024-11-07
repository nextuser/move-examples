module book::test_lib;
use std::debug::print;
#[test]
fun test_int(){

    let mut ret = std::u32::divide_and_round_up(32, 3);
    print(&ret);
    ret = 32/3;
    print(&ret);
    print(& std::u32::pow(2,5));
    print(& std::u32::sqrt(26));
    print(& std::u32::diff(26,20));
    print(& std::u32::diff(20,26));

    print(& std::u32::max(20,26));
    print(& std::u32::max(26,20));

}
