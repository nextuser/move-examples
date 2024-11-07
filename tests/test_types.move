#[test_only]
module book::types;
use std::debug::print;

#[test]
fun test_divide(){
    let m = 5 / 3;

    assert!(m == 1,1);

    assert!(5 % 3 == 2,2);

}


#[test]
fun test_hex(){
    
    let b :u8 = 96;
    print(&b);

    let v = b"Text303132中国"; // use u8 char
    print(&v);
    print(&v.to_string());
    let x = x"303132"; //must be hex number
    print(&x);
    print(&x.to_string());

    let bv = false;
    print(&bv);
}

fun do_swap<T :drop>(o: &mut Option<T>,t: T) {
    print(&o.is_some());  

    print(o);
    let t = option::swap_or_fill(o,t);
    print(&t)  ;

    print(o);
    print(&o.is_some());  
    //t
}

#[test]
fun test_opt(){
    let mut o = option::some<u32>(32);
    assert!(o.borrow()== 32);
    do_swap(&mut o,3);
    let mut ob =  option::none<u32>();
    assert!(ob.is_none());
    do_swap(& mut ob,24);
    assert!(!ob.is_none());
    
    let inner = o.extract();
    assert!(inner == 3);

    let name = option::some(b"alice");
    assert!(name.borrow() == &b"alice");

}
