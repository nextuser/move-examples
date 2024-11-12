#[test_only]
module book::test_clock;
use sui::clock::Clock;
public fun getTime(clock :&Clock):u64{
    clock.timestamp_ms()
}

#[test]
public fun test_clock(){
    let mut ctx = tx_context::dummy();
    let mut clock = sui::clock::create_for_testing(&mut ctx);
    clock.increment_for_testing(333);
    let ms = getTime(&clock);
    
    std::debug::print(&ms);
    assert!(ms > 0);
    sui::test_utils::destroy(clock);
    
}
