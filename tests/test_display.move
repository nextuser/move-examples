
module book::arena;

use std::string::String;
use sui::package;
use sui::display;

public struct ARENA has drop{}

#[allow(unused_field)]
public  struct Hero has key,store{
    id: UID,
    class:String,
    level:u64,
}

#[allow(unused_field)]
public struct CounterWithDisplay has key{
    id:UID,
    name:String,
    description:String,
    image:String,
    counter:u64,
}

fun init(otw:ARENA,ctx:&mut TxContext){
    let publisher = package::claim(otw,ctx);
    let mut display = display::new<Hero>(&publisher,ctx);
    display.add(b"name".to_string(),b"{class} (lvl.{level})".to_string());
    display.add(b"description".to_string(),
    b"One of the greatest heroes of all time.Join us!".to_string());
    display.add(
        b"link".to_string(),
        b"https://example.com/hero/{id}".to_string());
    display.add(b"image_url".to_string(),
    b"https://exmaple.com/hero/{class}.jpg".to_string());
    display.update_version();

    transfer::public_transfer(publisher,ctx.sender());
    transfer::public_transfer(display,ctx.sender());

    let hero = Hero {
        id:object::new(ctx),
        class:b"GoldClass".to_string(),
        level:1,
    };
    transfer::public_transfer(hero, ctx.sender());

}
