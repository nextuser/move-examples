#[test_only]
#[allow(unused_function)]
module book::test_generic{
    public struct Container<T:drop> has drop{
        value:T,
    }

    public fun generate<T:drop>(val:T) :Container<T>{
        Container{
            value:val,
        }
    }

    public fun equals<T:drop>(self:&Container<T>, other:&Container<T>) :bool {
        &self.value == &other.value   //借用value做比较
    }

    #[test]
    fun test_container(){
        let c1 :Container<u8> = Container{value : 10};
        let c2  = Container{value : 10u8};
        let c3  = Container<u8>{value : 10};
        let c4 = generate<u8>(10);

        assert!(c1.value == c2.value);
        assert!(c2.equals(&c3));
        assert!(c3.equals(&c4));
    } 


    public struct Pair<T,V> {
        first:T,
        second:V,
    }

    public fun new_pair<T,V>(first:T,second:V) : Pair<T,V> {
        Pair{first,second}
    }

    public fun destruct<T,V>(p: Pair<T,V>):(T,V){
        let Pair{ first ,second } =  p;
        (first,second) // 此时first second未必有drop能力,因此需要将所有权转移出去
    }

    public fun pair_equals<T,V>(self:&Pair<T,V>, other:&Pair<T,V>):bool{
        (&self.first == & other.first)  &&  (&self.second == &other.second)
    }

    public struct Alone{}

    #[test]
    fun test_pair(){
        let pair1 :Pair<u8,bool> = new_pair(10,true);
        let pair2 = new_pair(10u8,true);
        let pair3 = new_pair<u8,bool>(10,true);
        assert!(pair1.pair_equals(&pair2));
        assert!(pair2.pair_equals(&pair3));
        let (_,_) = destruct(pair1);
        let (_,_) = destruct(pair2);
        let (_,_) = destruct(pair3);
        let p4 = new_pair(Alone{},true);

        let (first,_) = destruct(p4);
        Alone{} = first;//显式析构没有drop能力的Alone
    }

}