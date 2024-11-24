module  book::ma{
    use std::string::String;
    public struct Nft has key{
        id : UID,
        name : vector<u8>,
    }

    public fun mint(name :vector<u8>, ctx : &mut TxContext ){
        let nft = Nft{
            id : object::new(ctx),
            name : name,
        };
        transfer::transfer(nft,ctx.sender());
    }

    public fun get_name(nft : &Nft) : String
    {
        nft.name.to_string()
    }
}

#[test_only]
module book::m2_test {
    use sui::test_scenario::{Self as test, Scenario as Sc};
    const Alice : address = @0xa;
    const Bob : address = @0xb;
    use book::ma;
    #[test]
    fun test_take_control(){
        let mut scenario = test::begin(Alice);
        book::ma::mint(b"nft1",scenario.ctx());
        
        test::next_tx(&mut scenario, Alice);
        {
            let nft = test::take_from_sender(& scenario);
            let name = ma::get_name(&nft);
            std::debug::print(& name);
            test::return_to_sender(&scenario,nft );
        };

        test::end(scenario);
    }

}