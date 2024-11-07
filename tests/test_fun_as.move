module book::m1
{
    use std::string::String;
    public struct Emp has drop{ name:String, age : u32}

    public fun new_emp(s : String, a : u32 ) : Emp {
        Emp{
            name:s,
            age:a,
        }
    }



    // function
    public fun get_age(e : &Emp ):u32 {  
        e.age
    }

    // method alias
    public use fun get_age as Emp.getAge;

}

#[test_only]
module book::m2{
        #[test]
    fun test_alias_emp_fun(){
        let a = book::m1::new_emp(b"ljl".to_string(),46);
        std::debug::print(&a);
        std::debug::print(&a.get_age());
        std::debug::print(&a.getAge());
    }
}