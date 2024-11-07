module book::test_abort;

const ErrLengthLessThanTwo :u64 = 42u64;
fun pop_twice<T>(v:&mut vector<T>):(T,T){
    assert!(v.length()> 1,ErrLengthLessThanTwo);
    (vector::pop_back(v),vector::pop_back(v))

}

#[test]
public fun test_pop_succ(){
    let mut v = b"abc";
    std::debug::print(&v);
    let (c,b) = pop_twice(&mut v);
    book::debug::log(&b"c is",&c);
    book::debug::log(&b"b is",&b);
    
    assert!(b == 98);
    assert!(c == 99);
}


#[test]
#[expected_failure(abort_code=ErrLengthLessThanTwo)]
public fun test_pop_fail(){
    let mut v = b"a";
    pop_twice(&mut v);
}

