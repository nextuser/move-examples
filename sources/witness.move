module book::witness;
use sui::coin::{Self,Coin};
use sui::sui::SUI;
use std::string::{Self,String};
const PASSPORT_FEE:u64 = 50000;

public struct ShareInfo has key{
    id :UID,
    owner:address,
   
}
fun init(ctx:&mut TxContext){
    let share_info = ShareInfo{
        id:object::new(ctx),
        owner:ctx.sender(),
    };
    transfer::freeze_object(share_info);
}

public struct House has key{
    id:UID,
    name:String,
}

public struct Passport has drop{ }

/// 花钱购买一个Passport
public fun requirePassport(mut c:Coin<SUI>,share_info: &ShareInfo, ctx : &mut TxContext) : Passport{
    //分割出来收费
    let fee = coin::split(&mut c, PASSPORT_FEE, ctx);
    transfer::public_transfer(fee,share_info.owner);
    //归还找零的钱
    transfer::public_transfer(c,ctx.sender());
    //返回Passport
    Passport{}
} 

///获得Passport 才能创建House , Passport 每次使用之后都会消耗掉
public fun create_house(_:Passport, name:String, ctx:&mut TxContext){
    let house = House{
        id:object::new(ctx),
        name:name,
    };
    //转让房子给交易发起者
    transfer::transfer(house,ctx.sender());
}

/// 为了在模块外测试代码调用init函数
#[test_only]
public fun test_init(ctx:&mut TxContext){
    init(ctx);
}
///为了模块外测试代码获取本模块常量, 因为常量不是public的
#[test_only]
public fun get_passport_fee():u64{
    PASSPORT_FEE
}