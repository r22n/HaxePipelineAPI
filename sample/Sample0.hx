class Sample0 {
    public static function main():Void {

        trace("#show names who has age which is greater equal than 20");
        /*
            [people (root)] 
            => [age greater equal than 20 (internal)] 
            => [show name (terminal)]
        */
        people
        .where(function(x){return x.age>=20;}) 
        .foreach(function(x){trace(x.name);});

        trace("#join the person and pets by id");
        /*
            [people (root)]
            => [join pets (internal)]
            => [match with id between person and pet (internal)]
            => [generate happy message (internal)]
            => [show all message]
        */
        people
        .join(pets,function(x,y){return {person:x,pet:y};})
        .where(function(x){return x.person.id==x.pet.id;})
        .select(function(x:Dynamic){return (x.person.male?"mr.":"ms.")+x.person.name+" loves "+x.pet.pet;})
        .foreach(function(x){trace(x);});

        trace("#list person who has no pet");
        /*
            [people (root)]
            => [check up there is no pet that has id (internal)]
            => [select name (internal)]
            => [show all name (terminal)]
        */
        people
        .where(function(x){return !pets.any(function(y){return y.id==x.id;});})
        .select(function(x){return x.name;})
        .foreach(function(x){trace(x);});

        trace("#count up person who has pet and is male, age what is greater than 60");
        /*
            [people(root)]
            =>[check up there is pet that has id(internal)]
            =>[filter who is male(internal)]
            =>[filter who has age greater than 60(internal)]
            =>[count all elements(terminal)]
        */
        trace(
            people
            .where(function(x){return pets.any(function(y){return y.id==x.id;});})
            .where(function(x){return x.male;})
            .where(function(x){return x.age>60;})
            .count()
        );

        trace("#show first pet name being had by youngest person");
        /*
            [pet(root)]
            =>[join with people(internal)]
            =>[match pet and person by id(internal)]
            =>[youngest element pet and person tuple can minimize age evalator(terminal)]
        */
        trace(
            pets
            .join(people,function(x,y){return {pet:x,person:y};})
            .where(function(x:Dynamic){return x.pet.id==x.person.id;})
            .argmin(function(x:Dynamic):Dynamic{return x.person.age;})
            .pet.pet
        );
        
        trace("#is there person who has no pet and age >= 60, not male ?");
        /*
            [people(root)]
            =>[filter no pet(internal)]
            =>[filter age>=60(internal)]
            =>[filter not male(internal)]
            =>[any match (terminal)]
        */
        trace(
            people
            .where(function(x){return !pets.any(function(y){return x.id==y.id;});})
            .where(function(x){return x.age>=60;})
            .where(function(x){return !x.male;})
            .any(function(x){return true;}) ?
                "yes":"no"
        );
        trace("#are all people has pet?");
        /*
            [people(root)]
            =>[check up do all elements who has pet(terminal)]
        */
        trace(
            people
            .all(function(x){return pets.any(function(y){return x.id==y.id;});}) ?
                "yes":"no"
        );

        trace("#average age of people who is male");
        /*
            [people(root)]
            =>[filter male(internal)]
            =>[select age(internal)]
            =>[aggregate average(terminal)]
        */
        trace(
            people
            .where(function(x){return x.male;})
            .select(function(x){return x.age;})
            .aggregate(0.0,function(left,right){return left+right;},function(sum,count){return sum/count;})
        );

    }



    private static var people:Pipeline<Dynamic>=Pipeline.open([
{id:0,name:"npvqore",age:47,male:false},
{id:1,name:"pqiyqcd",age:19,male:true},
{id:2,name:"aaxntga",age:38,male:true},
{id:3,name:"woeqwea",age:15,male:false},
{id:4,name:"voxgwqr",age:23,male:true},
{id:5,name:"wicexwp",age:69,male:false},
{id:6,name:"lpwdegp",age:56,male:false},
{id:7,name:"cqfjsmt",age:60,male:false},
{id:8,name:"kynuzjz",age:38,male:false},
{id:9,name:"lrojdag",age:41,male:true},
{id:10,name:"bedzaxs",age:67,male:false},
{id:11,name:"rakbbxi",age:49,male:false},
{id:12,name:"gijvjvt",age:66,male:false},
{id:13,name:"jlixxzl",age:16,male:false},
{id:14,name:"tzoyiaj",age:58,male:false},
{id:15,name:"twtjtbn",age:57,male:false},
{id:16,name:"xcpzygc",age:63,male:false},
{id:17,name:"ydlhbcb",age:69,male:true},
{id:18,name:"fzhdhxn",age:11,male:true},
{id:19,name:"fsvrjkr",age:15,male:false},
{id:20,name:"dqmzrha",age:46,male:true},
{id:21,name:"difhlzn",age:26,male:false},
{id:22,name:"mqopotc",age:63,male:true},
{id:23,name:"rvtyvql",age:35,male:false},
{id:24,name:"gptingg",age:39,male:false},
{id:25,name:"bvzbtzh",age:41,male:false},
{id:26,name:"adbvbxh",age:50,male:false},
{id:27,name:"kigmqsx",age:54,male:false},
{id:28,name:"tylszcl",age:43,male:true},
{id:29,name:"opdpihe",age:46,male:false},
{id:30,name:"xjliizm",age:20,male:false},
{id:31,name:"meksmig",age:49,male:true},
{id:32,name:"xeqhoee",age:23,male:false},
{id:33,name:"adsmazr",age:56,male:false},
{id:34,name:"eixmqzt",age:10,male:true},
{id:35,name:"kqrbveo",age:31,male:false},
{id:36,name:"lxkzadp",age:37,male:true},
{id:37,name:"kmxjwff",age:40,male:true},
{id:38,name:"gmldaov",age:19,male:true},
{id:39,name:"vimqgel",age:14,male:false},
{id:40,name:"cuyxfxe",age:58,male:true},
{id:41,name:"vhenxpd",age:59,male:false},
{id:42,name:"jzcqjlz",age:68,male:false},
{id:43,name:"wmewvim",age:50,male:false},
{id:44,name:"xxjtgik",age:36,male:false},
{id:45,name:"esyjehv",age:44,male:false},
{id:46,name:"fhsgkyg",age:24,male:true},
{id:47,name:"reewbsy",age:65,male:true},
{id:48,name:"nugpuet",age:57,male:false},
{id:49,name:"rkrybyr",age:47,male:false},
{id:50,name:"mcocjva",age:64,male:false},
{id:51,name:"arihhto",age:55,male:false},
{id:52,name:"ummbmxl",age:22,male:false},
{id:53,name:"zzgskob",age:22,male:true},
{id:54,name:"xtmugeg",age:16,male:false},
{id:55,name:"vytnqyu",age:66,male:false},
{id:56,name:"xulafci",age:63,male:false},
{id:57,name:"zemlfsb",age:28,male:false},
{id:58,name:"mzjlmvc",age:63,male:true},
{id:59,name:"pqsndrc",age:23,male:true},
{id:60,name:"vmcpvin",age:62,male:false},
{id:61,name:"piwkevz",age:50,male:false},
{id:62,name:"jpmrzjq",age:24,male:true},
{id:63,name:"mhfuhdq",age:50,male:false},
{id:64,name:"qmvwzqc",age:10,male:false},
{id:65,name:"edcfbia",age:65,male:false},
{id:66,name:"njrgnym",age:12,male:true},
{id:67,name:"ezahrpi",age:34,male:false},
{id:68,name:"xwpptuf",age:44,male:false},
{id:69,name:"idgdtjg",age:31,male:true},
{id:70,name:"ztpibwo",age:17,male:false},
{id:71,name:"nzgkdhk",age:66,male:true},
{id:72,name:"qujvtmp",age:35,male:true},
{id:73,name:"ytmugeo",age:30,male:true},
{id:74,name:"nxwnjfw",age:18,male:false},
{id:75,name:"ownntrf",age:35,male:true},
{id:76,name:"smhtgbn",age:21,male:true},
{id:77,name:"pgadoig",age:38,male:true},
{id:78,name:"itvbjml",age:51,male:false},
{id:79,name:"yvdidpd",age:36,male:false},
{id:80,name:"ddqfihw",age:39,male:true},
{id:81,name:"iqcdrif",age:61,male:true},
{id:82,name:"yaptkeo",age:18,male:false},
{id:83,name:"cpdosni",age:54,male:true},
{id:84,name:"rkctphi",age:56,male:false},
{id:85,name:"pyiebfj",age:34,male:true},
{id:86,name:"hncfgml",age:55,male:true},
{id:87,name:"dmnysom",age:53,male:true},
{id:88,name:"udabgmy",age:58,male:false},
{id:89,name:"lvgtsyv",age:59,male:true},
{id:90,name:"ncokgqa",age:56,male:false},
{id:91,name:"vjwmnmu",age:35,male:false},
{id:92,name:"gakqxli",age:49,male:false},
{id:93,name:"nnicgki",age:24,male:true},
{id:94,name:"vcueblp",age:12,male:false},
{id:95,name:"idyqkxc",age:11,male:true},
{id:96,name:"gxvuaam",age:34,male:true},
{id:97,name:"rbckoeq",age:21,male:false},
{id:98,name:"fhkuhrs",age:65,male:false},
{id:99,name:"xkjydkb",age:69,male:true}
    ]);
    private static var pets:Pipeline<Dynamic>=Pipeline.open([
{pid:0,id:47,pet:"lpt"},
{pid:1,id:49,pet:"abz"},
{pid:2,id:17,pet:"xoq"},
{pid:3,id:27,pet:"txg"},
{pid:4,id:70,pet:"nyn"},
{pid:5,id:91,pet:"qoo"},
{pid:6,id:49,pet:"tkg"},
{pid:7,id:45,pet:"msl"},
{pid:8,id:89,pet:"mth"},
{pid:9,id:70,pet:"wad"},
{pid:10,id:19,pet:"ygq"},
{pid:11,id:45,pet:"zdq"},
{pid:12,id:21,pet:"vvp"},
{pid:13,id:47,pet:"apy"},
{pid:14,id:39,pet:"jeo"},
{pid:15,id:9,pet:"vee"},
{pid:16,id:48,pet:"rlu"},
{pid:17,id:41,pet:"swc"},
{pid:18,id:75,pet:"maw"},
{pid:19,id:45,pet:"fvh"}
    ]);
}