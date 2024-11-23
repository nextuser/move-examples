#[test_only]
module book::witness_tests ;
use sui::test_scenario::{Self, Scenario};
use sui::coin::{Self, Coin};
use sui::sui::SUI;
use std::string;
use book::witness::{Self, ShareInfo, House, Passport};
use book::witness::get_passport_fee;

#[test]
fun test_witness_flow() {
    let owner = @0xA;
    let user = @0xB;
    
    // 第一步：初始化场景
    let mut scenario = test_scenario::begin(owner);
    
    // 初始化合约,创建 ShareInfo
    test_scenario::next_tx(&mut scenario, owner);
    {
        witness::test_init(test_scenario::ctx(&mut scenario));
    };

    // 用户购买 Passport
    test_scenario::next_tx(&mut scenario, user);
    {
        // 创建测试用的 SUI coin
        let coin = coin::mint_for_testing<SUI>(100000, test_scenario::ctx(&mut scenario));
        let share_info = test_scenario::take_immutable<ShareInfo>(&scenario);
        
        let passport = witness::requirePassport(
            coin,
            &share_info,
            test_scenario::ctx(&mut scenario)
        );
        
        // 使用 Passport 创建 House
        witness::create_house(
            passport,
            string::utf8(b"My House"),
            test_scenario::ctx(&mut scenario)
        );
        
        test_scenario::return_immutable(share_info);
    };

    // 验证 House 是否创建成功
    test_scenario::next_tx(&mut scenario, user);
    {
        let coin = test_scenario::take_from_address<Coin<SUI>>(&scenario, owner);
        assert!(coin.value() == get_passport_fee());
        test_scenario::return_to_address(owner, coin);

        let coin = test_scenario::take_from_address<Coin<SUI>>(&scenario, user);
        assert!(coin.value() == 100000 - get_passport_fee());
        test_scenario::return_to_address(user, coin);
        

        assert!(test_scenario::has_most_recent_for_sender<House>(&scenario));
    };
    
    test_scenario::end(scenario);
}


#[test]
#[expected_failure(abort_code = sui::balance::ENotEnough)]
fun test_witness_flow_no_enough() {

    let owner = @0xA;
    let user = @0xB;
    
    // 第一步：初始化场景
    let mut scenario = test_scenario::begin(owner);
    
    // 初始化合约,创建 ShareInfo
    test_scenario::next_tx(&mut scenario, owner);
    {
        witness::test_init(test_scenario::ctx(&mut scenario));
    };

    // 用户购买 Passport
    test_scenario::next_tx(&mut scenario, user);
    {
        let fee = get_passport_fee() - 1;
        let coin = coin::mint_for_testing<SUI>(fee, test_scenario::ctx(&mut scenario));
        let share_info = test_scenario::take_immutable<ShareInfo>(&scenario);
        //这里会因为fee 不够而失败
        let passport = witness::requirePassport(
            coin,
            &share_info,
            test_scenario::ctx(&mut scenario)
        );
        test_scenario::return_shared(share_info);
    };
    
    test_scenario::end(scenario);
}