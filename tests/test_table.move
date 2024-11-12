module book::test_table{
    use std::string::String;

    #[test]
    fun test_table(){
        let mut ctx = tx_context::dummy();
        let mut tb = sui::table::new<String,u32>(&mut ctx);    
        tb.add(b"abc".to_string(),1);
        tb.add(b"def".to_string(),2);
        tb.add(b"opq".to_string(),3);
        tb.add(b"rst".to_string(),4);
        assert!(tb.length() == 4);
        assert!(tb.contains(b"opq".to_string()));
        assert!(!tb.contains(b"unknown".to_string()));
        sui::test_utils::destroy(tb);
    }


}