module book::test_const{
    use std::debug::print;
    #[error]
    const EDivideByZero:vector<u8> = b"error:divide by zero";
    
    fun divide(left:u32,right:u32):u32{
        assert!(right != 0,EDivideByZero);
        left/right
    }
    #[test]
    fun test_divide(){
        print(&divide(3,4));
        print(&divide(30,4));
        //print(&divide(3,0));
    }
    
}