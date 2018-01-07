class Case9{
    public static function main():Void {
        var datas:Array<Dynamic>=[];
        var pip:Pipeline<Dynamic>=datas;
        var ires:Pipeline<Dynamic>=
            pip
            .where(function(x){return x.age>=20;})
            .where(function(x){return x.name.charAt("n");})
            .select(function(x){return x.name;});
        
        datas.push({age:40,name:"tom"});
        datas.push({age:20,name:"alice"});
        datas.push({age:10,name:"bob"});

        var res:Iterator<Dynamic>=ires.iterator();
        if(!(res.hasNext()&&res.next()=="tom"))trace("failed");
        if(!(res.hasNext()&&res.next()=="alice"))trace("failed");
        if(!(!res.hasNext()))trace("failed");


        datas.push({age:80,name:"ken"});
        res=ires.iterator();
        if(!(res.hasNext()&&res.next()=="tom"))trace("failed");
        if(!(res.hasNext()&&res.next()=="alice"))trace("failed");
        if(!(res.hasNext()&&res.next()=="ken"))trace("failed");
        if(!(!res.hasNext()))trace("failed");


    }
}