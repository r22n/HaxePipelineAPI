class Sample1 {
    public static function main():Void {

        trace("#show all entries in obj");
        var pip:Pipeline<{key:String,value:Dynamic}>=Pipeline.openFields(obj);
        pip.foreach(function(x){trace(x);});

        trace("#show all entries in map");
        var mappip:Pipeline<{key:String,value:String}>=Pipeline.openMap(map);
        mappip.foreach(function(x){trace(x);});

        trace("show all entries size in bytes");
        pip
        .select(function(x){return x.value.length;})
        .foreach(function(x){trace(x);});



        var gui:Dynamic={type:"form",children:[]};
        var radios:Dynamic={type:"group",children:[]};
        var radio0:Dynamic={type:"radio",name:"radio0",children:[]};
        var radio1:Dynamic={type:"radio",name:"radio1",children:[]};
        radios.children.push(radio0);
        radios.children.push(radio1);
        gui.children.push(radios);
        var ok:Dynamic={type:"button",name:"ok",children:[]};
        gui.children.push(ok);
        var cancel:Dynamic={type:"button",name:"cancel",children:[]};
        gui.children.push(cancel);
        /*
            =======gui========
            =====radios=======
            o radio0 
            o radio1
            ==================
            [ok] [cancel]
            ==================
        */
        trace("=======gui========");
        trace("=====radios=======");
        trace("o radio0");
        trace("o radio1");
        trace("==================");
        trace("[ok] [cancel]");
        trace("==================");
        trace("#get all button or radio names from gui data structure");
        Pipeline
        .open(gui.children)
        .explore(function(x:Dynamic){return x.children;})
        .where(function(x){return x.type=="button" || x.type=="radio";})
        .select(function(x:Dynamic){return x.name;})
        .foreach(function(x){trace(x);});

    }

    private static var obj:Dynamic={
pxuc:"tjio",
pmpt:"leqx",
adqa:"pcng",
xgzc:"jobm",
dlwh:"azel",
gqwc:"nvjp",
jyih:"cccy",
uemc:"wxfa",
pfuf:"gnlj",
ktxu:"moky"
    };
    private static var map:Map<String,String>=[
"pxuc"=>"tjio",
"pmpt"=>"leqx",
"adqa"=>"pcng",
"xgzc"=>"jobm",
"dlwh"=>"azel",
"gqwc"=>"nvjp",
"jyih"=>"cccy",
"uemc"=>"wxfa",
"pfuf"=>"gnlj",
"ktxu"=>"moky"
    ];
}