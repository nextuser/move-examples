module book::test_epoch;

public fun current_epoch(ctx:&TxContext) :u64{
    ctx.epoch()
}

public fun current_epoch_start_ms(ctx:&TxContext) :u64{
    ctx.epoch_timestamp_ms()
}




