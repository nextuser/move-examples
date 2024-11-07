module book::debug{
    public fun log<T> (msg:& vector<u8> ,t: &T){
        std::debug::print(& (*msg).to_string());
        std::debug::print(t);
    }
}