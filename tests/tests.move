#[test_only]
#[allow(unused_function)]
module book::tests; // only one module in the file , not use module name{}  block;

#[test]
fun test_new_country(){
    let c = book::country::new_country(3,1000_000);
    std::debug::print(&c);
    book::country::release(c);
}

module book::other {  //here need brace `{}` for codes in module
    #[test]
    public fun test2(){
        std::debug::print(&b"othertest");
    }
}


module book::country{

    public struct Country {
        id:u8,
        population:u64,
    }
    public fun new_country(id :u8, population : u64) : Country{
        Country{
            id,
            population,
        }
    }

    // Country has no Drop, need release
    public fun release(c:Country){
        let Country{id:_, population:_ } = c;
    }


}


