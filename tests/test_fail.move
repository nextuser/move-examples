#[test_only]
#[allow(unused_function)]
module book::test_fail;
use std::debug::print;
    

const EDivideByZero: u64 = 1;
const EOutOfRange: u64 = 2;

fun check_range(value : u32){
    assert!(value < 100, EOutOfRange)
}

fun divide(x:u32,y:u32) :u32{

    assert!(y!= 0,EDivideByZero);

    x / y
}

#[test]
#[expected_failure(abort_code=EOutOfRange)]
fun test_range(){
    check_range(200);
}

#[test]
#[expected_failure(abort_code = EDivideByZero)]
fun test_divideZero(){
    print(&divide(5,3));
    print(&divide(5,0));
}

const Err_Zero:u64 = 0;
const Err_One:u64 = 0;

#[test]
#[expected_failure(abort_code = Err_Zero)]
fun test_fail_0() {
    abort Err_Zero // aborts with 0
}

// attributes can be grouped together
#[test, expected_failure(abort_code = Err_One)]
fun test_fail_1() {
    assert!(false, Err_One) // aborts with 1
}
