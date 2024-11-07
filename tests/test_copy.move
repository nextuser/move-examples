module book::test_copy;
public struct Foo has copy{
    
}

#[test]
fun test_copy(){
    let a = Foo{};
    let b = Foo{};
    let aa = a;
    // 释放资源区域
    Foo{} = a;
    Foo{} = aa;
    Foo{} = b;
}