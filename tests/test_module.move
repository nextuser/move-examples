// File: sources/module_one.move
module book::module_one;

/// Struct defined in the same module.
public struct Character has drop {}

/// Simple function that creates a new `Character` instance.
public fun new(): Character { Character {} }

    // File: sources/module_two.move
module book::module_two{

    use book::module_one; // importing module_one from the same package

    /// Calls the `new` function from the `module_one` module.
    public fun create_and_ignore() {
        let _ = module_one::new();
    }
}

module book::module_import {
    use book::module_one::{Self as m1, Character as Char};

    public fun create() :Char{
        m1::new()
    }

    #[test]
    fun test_create(){
        let ch = create();
        std::debug::print(&ch);
    }
}