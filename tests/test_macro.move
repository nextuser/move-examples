module book::test_macro;

macro fun max<$T> ($x:$T, $y:$T ): $T{
    if ($x > $y){
        $x
    }
    else{
        $y
    }
}


#[test]
public fun test_max(){
    book::debug::log(&b"max(3,5)",&max!(3,5));
    book::debug::log(&b"max(111,33)",&max!(111u8,33u8));
    book::debug::log(&b"max(111,33)",&max!(111u32,33u32));
    let a =0xa;
    let b = 0xb;
    book::debug::log(&b"max(111,33)",&max!(a,b));
}