#[test_only]
module book::test_enum{
    use std::ascii::String;
    public enum NumType has drop{
        negative,
        positive,
        zero,
    }
    fun toString(n : NumType):String{
        match(n){
            negative => b"negative".to_ascii_string(),
            positive => b"positive".to_ascii_string(),
            zero =>  b"zero".to_ascii_string(),

        }
    }
    #[test]
    fun test_match(){
        std::debug::print(&toString(NumType::negative));
        std::debug::print(&toString(NumType::positive));
        std::debug::print(&toString(NumType::zero));

    }


    public enum Action has drop {
        Move { x:u64,y:u64},
        Jump {x:u64},
        Pause{duration:u64},
    }

    use book::debug::log;
    fun showAction(action:Action){
        match(action){
            Action::Move { x, y } => {
               book::debug::log(&b"move x:",&x);
               book::debug::log(&b"move y:",&y);
            },
            Action::Jump { x } =>{ log(&b"jump",&x) },
            Action::Pause{ duration } => log(&b"pause",&duration),
        }
    }
    #[test]
    fun test_showAction(){
        showAction(Action::Move{x:1,y:2});
        showAction(Action::Jump{x:3});
        showAction(Action::Pause{duration:4});
    }


    public enum SimpleEnum {
        Variant1(u64),
        Variant2(u64),
    }

    public fun incr_enum_variant1(simple_enum: &mut SimpleEnum) {
        match (simple_enum) {
            SimpleEnum::Variant1(mut value) => *value = *value + 1,
            _ => (),
        }
    }

    public fun incr_enum_variant2(simple_enum: &mut SimpleEnum) {
        match (simple_enum) {
            SimpleEnum::Variant2(mut value) => *value = *value + 1,
            _ => (),
        }
    }

    fun destroy(simple_enum:SimpleEnum){
        match(simple_enum){
            SimpleEnum::Variant1(_) => (),
            SimpleEnum::Variant2(_) => (),
        }
    }

    use sui::test_utils;
    #[test]
    fun test_incr_enum_variant1(){
        let mut simple_enum = SimpleEnum::Variant1(1);
        incr_enum_variant1(&mut simple_enum);
        let target = SimpleEnum::Variant1(2);
        assert!(simple_enum == &target);
        incr_enum_variant2(&mut simple_enum);
        assert!(simple_enum == &target);

        destroy(simple_enum);
        destroy(target);


    }


}