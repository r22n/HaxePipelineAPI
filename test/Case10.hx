class Case10 {
    public static function main():Void {
        var src:Array<Dynamic>=[];
        var pip:Pipeline<Dynamic>=src;

        var tar:Pipeline<Dynamic>=
            pip
            .where(function(x){return x.age>=20;})
            .sort(function(x,y){return x.age>y.age?1:-1;})
            .select(function(x){return x.name;});
        
        src.push({name:"nancy",age:60});
        src.push({name:"alice",age:20});
        src.push({name:"tom",age:10});
        src.push({name:"bob",age:30});
        src.push({name:"elmo",age:40});

        var ans:Array<String>=["alice","bob","elmo","nancy"];
        var itr:Iterator<Dynamic>=tar.iterator();
        for(x in ans){
            if(!(itr.hasNext()&&x==itr.next())){
                trace("failed");
            }
        }
        if(!(!itr.hasNext())) {
            trace("failed");
        }

        src.push({name:"xyz",age:55});
        ans=["alice","bob","elmo","xyz","nancy"];
        itr=tar.iterator();

        for(x in ans){
            if(!(itr.hasNext()&&x==itr.next())){
                trace("failed");
            }
        }
        if(!(!itr.hasNext())) {
            trace("failed");
        }
    }
}