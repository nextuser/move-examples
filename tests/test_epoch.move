module book::test_epoch;

public fun current_epoch(ctx:&TxContext) :u64{
    ctx.epoch()
}

public fun current_epoch_start_ms(ctx:&TxContext) :u64{
    ctx.epoch_timestamp_ms()
}


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
    sui::test_utils::destroy(clock);
    assert!(ms > 0);
}


