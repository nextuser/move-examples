module book::strings;
use std::string::{Self,String};
public struct Name has key,store{
    id: UID,
    name : String,
}

public fun issue_name_nft(
    name_bytes : vector<u8>,
    ctx : &mut TxContext,
) :Name{
    Name{
         id : object::new(ctx),
         name : string::utf8(name_bytes),
    }
    
}