#[test_only]
module book::test_alias_external{
    //导入外部模块的函数别名不成功,这个比较奇怪
   /// public use fun std::bcs::to_bytes as Hero.to_bytes;
    ////public use fun std::bcs::to_bytes as Hero.to_bytes;

    // Alias for the `bcs::to_bytes` method. Imported aliases should be defined
    // in the top of the module.
    //public use fun to_bytes as Hero.to_bytes;

    /// A struct representing a hero.
    public struct Hero has drop {
        health: u8,
        mana: u8,
    }

    public fun add(h: &Hero) :u8 {
        h.health + h.mana
    }

    use fun add as Hero.addValue;

    public fun to_bytes(self: &mut Hero):vector<u8>{
        sui::bcs::to_bytes(self)
    }

    //use fun sui::bcs::to_bytes as to_bytes2
   

    /// Create a new Hero.
    public fun new(): Hero { Hero { health: 100, mana: 20 } }

    #[test]
    // Test the methods of the `Hero` struct.
    fun test_hero_serialize() {
        let mut hero = new();
        let serialized = hero.to_bytes();
        std::debug::print(&serialized);
         std::debug::print(&serialized.length());
        assert!(hero.add() == 120);
        std::debug::print(&hero.addValue());
        std::debug::print(&hero.add());
        assert!(serialized.length() == 2, 1);
    }

}


module book::test_primitive{
	#[test]
	fun test_int(){
	
	}
	
	#[test]
	fun test_address(){
	
	}
}