module book::test_reference{
    public struct Card{
        value:u32,
    }

    fun new(value:u32) :Card{
        Card { 
            value
         }
    }
    fun burn(card :Card){
        let Card{value:_} = card;
    }

    use std::debug::print;
    #[test]
    fun test_ref(){
        let c  = new(3);
        let c1 :&Card = &c;
        let c2 :&Card = &c; 
        print(c1);
        print(c2);
        burn(c);
    }

    fun changeCard(card:&mut Card,value :u32) {
        card.value = value;
    }

    #[test]
    fun test_mut_ref(){
        let mut c  = new(3);
        let c1 :&Card = &c;
        let c2 :&mut Card = &mut c;  // 可以同时存在不变和可变的引用,这一点和rust语言存在差异的
        print(c1);

        print(c2);
        changeCard(c2, 4);
        assert!(c2.value == 4);
        print(c2);

        burn(c);
    }

    #[test]
    fun ref_cast(){
        let mut a = 3;
        let a1:&mut u64  = &mut a;
        assert!(a1 == 3);
        *a1=4;
        assert!(a1 == 4);
        let a2 :& u64 = freeze(a1);
        //let a3 :& u64 = &a; //invalid borrow


        std::debug::print(a1);
        std::debug::print(a2);
    }


    
    #[test]
    #[allow(unused_mut_ref)]
    fun test_mut_2ref(){
        let mut c  = new(3);
        let c1 :&mut Card = &mut c;
        let c2 :&mut Card = &mut c;  //可以定义两个可变的引用,但是不能同时使用,和rust不同
        changeCard(c1,5);
        assert!(c1.value == 5);
        print(c1);
        changeCard(c1,5);
        //c2.value = 6; //borrow fail ,不能同时borrow两个可变引用
        book::debug::log(&b"c1",c1);
        //book::debug::log(&b"c2",c2);   //
        assert!(c1.value == 5);
        assert!(c2.value == 5);
        print(c2);
        burn(c);
    }

    #[test]
    fun test_mut_immut_ref(){
        let mut c  = new(3);
        let c1 :&mut Card = &mut c;
        ///let c2 :& Card = & c;  //不能同时存在可变 不变引用
        changeCard(c1,5);
        assert!(c1.value == 5);
        print(c1);
        changeCard(c1,6);
        //assert!(c2.value == 6);
        //print(c2);
        burn(c);
    }
    
    public struct Data has copy,drop{value : u32}

    fun inc(v : &mut Data){
        v.value = v.value + 1;

    }

    #[test]
    fun test_deref(){
        let mut d = Data{value:33};
        let dr = &mut d;
         let c:Data = *dr; //deref need copy property
        inc(dr);
        book::debug::log(&b"c ",&c);
        book::debug::log(&b"d ",dr);
        *dr = c;
    }

    #[test]
    fun test_deref_assign(){
        let mut d = Data{value:24};
        let dr = &mut d;

        *dr = Data{value:25};
        book::debug::log(&b"changed",dr);
    }
}
module book::metro_pass{
    const ENoUses:u64 = 1;
    const USES_INIT_VALUE :u8 = 3;

    public struct Card{ uses : u8}

    public fun purchase() :Card {
        Card{uses: USES_INIT_VALUE}
    }

    public fun is_valid(card:&Card) : bool {
        card.uses > 0
    }

    public fun enter_metro(card : &mut Card){
        assert!(card.uses > 0, ENoUses);
        card.uses = card.uses - 1;

    }

    public fun burn(card :Card){
        let Card{uses:_} = card;
    }
}

module book::test_metro {
    #[test]
    fun test_metro_valid(){
        let mut card = book::metro_pass::purchase();
        card.enter_metro();
        card.enter_metro();
        card.enter_metro();
        assert!(!card.is_valid(),1);
        book::metro_pass::burn(card);//没有drop能力的对象需要释放
    }
}