#[test_only]
module book::test_local_var{
    #[test]
    fun annotated_local_var(){
        let u:u8 = 0;
        let b:vector<u8> = b"hello";
        let a:address = @0x0;
        let (x,y):(&u64,&mut u64) = (&0,&mut 1);
        book::debug::log(&b"u is",&b);
        book::debug::log(&b"u is",&u);
        book::debug::log(&b"a is",&a);
        book::debug::log(&b"x is",x);
        book::debug::log(&b"y first",y);
        *y = 5;
        book::debug::log(&b"y second",y);
    }

    #[test]
    //#[expected_failure]
    fun test_reduce_type(){
        //let c :signer = loop(); //虽然编译通过,但是死循环导致超时
        //book::debug::log(&b"c is", &c);
        let a:u8 = return ();//虽然编译通过,但是返回退出
        book::debug::log(&b"a is", &a);
        let b: bool = abort 0;//虽然编译通过,但是会异常退出
        book::debug::log(&b"b is", &b);
    }

        public struct X(u64)
    public struct Y{x1:X,x2:X}
    
    fun new_x():X{
        X(1)
    }
    
    //test pos struct
    #[test]
    fun test_strut_pos_local(){
        let Y{x1:X(f), x2 } = Y{x1:new_x(),x2:new_x()};
        assert!(f + x2.0 == 2);
        book::debug::log(&b"x2:", &x2);
        X(_) = x2  ;//x2 需要显式解构,没有drop能力
    }

    #[test]
    fun test_move(){
        let x = 5;
        let x1  = x + 1;
        book::debug::log(&b"x:",&x);
        book::debug::log(&b"x1:",&x1);

        let y = 5;
        let y1  = move y + 1;
        //book::debug::log(&b"x:",&y);
        book::debug::log(&b"x1:",&y1);5;
    }

    #[test]
    fun test_eq(){
        let x = 5;
        let x1 = &x;
        let y = 5;
        let y1 = & y;
        book::debug::log(&b"x1==y1?" , &(x1==y1));
    }

    public struct Wrap(u32)

    #[test]
    fun test_swap(){
        let mut x = Wrap(3);
        let mut y = Wrap(4);
        book::debug::log(&b"x",&x);
        book::debug::log(&b"y",&y);
        (x,y ) = (y,x);
        book::debug::log(&b"x",&x);
        book::debug::log(&b"y",&y);
        let Wrap(_) = x;
        let Wrap(_) = y;
    }


}