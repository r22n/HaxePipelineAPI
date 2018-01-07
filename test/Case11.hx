class Case11 {
    public static function main():Void {
        var src:Pipeline<Dynamic>=
            Pipeline.open([
                {name:"tom",age:20},
                {name:"alice",age:21},
                {name:"bob",age:24},
                {name:"xyz",age:25},
            ]);
        if(!(src.any(function(x){return x.name=="tom";}))) {
            trace("failed");
        }
        if(!(!src
            .where(function(x){return x.name!="tom";})
            .any(function(x){return x.name=="tom";})
        )){
            trace("failed");
        }
        if(!(src.all(function(x){return x.age>=20;}))) {
            trace("failed");
        }
        if(!(!src.all(function(x){return x.name.length<=3;}))) {
            trace("failed");
        }
    }
}