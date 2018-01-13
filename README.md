# HaxePipelineAPI
data processing pipeline API for HAXE language such MS LINQ, java Stream API.  
simple definition and powerful unified data processing code empower your codes.  

## the pipeline processing
### powerful and unified data processing codes
i want to empower data processing codes.  
the text of:   
[show name] puts name from ...  
[age greater than 20] retrives data which has age greater 20 from ...  
{name:"tom",age:20},{name:"bob",age:30},{name:"ken",age:25},...  
is more abstract and powerful than:  
`    for(person in people) {`
`        if(person.age>20){  `
`            trace(person.name);  `
`        }  `
`    }`
### data processing
exmaple data processing flow shows "[people] => [age greater than 20] => [show name]".  
the "=> [age greater than 20] =>" means internal operation, which requires input element and process it, output element.  
the "=> [show name]" means terminal operation, which requires input element and process it.  
running "[show name]" once, the operation requires one data from source operation such as "[age greater than 20]".  
therefore, the example codes will work for datas such as [{name:"tom",age:20},{name:"bob",age:30},{name:"ken",age:25},...] like:  
[show name] puts name from ...  
[age greater than 20] retrives data which has age greater 20 from ...  
{name:"tom",age:20},{name:"bob",age:30},{name:"ken",age:25},...  
because of this text is more abstract than example codes, i want to empower some codes.  

## how to use
usage is very simple.  
add Pipeline.hx into class path of haxe compiler.  
retrives Iterable type object to Pipeline type.  

STEP 0: retrives some Iterable values  
var src:Pipeline<Dynamic>=datas/*of Iterable type*/;  

STEP 1: open pipeline for data processing  
var pip: Pipeline<String> =  
    src  
    .where(function(x){return x.age>20;})  
    .select(function(x){return x.name;});  
be careful that you can not decide the value of "pip" even if you get value as Iterable type like below.  
var dats: Iterable<String>=  
    src  
    .where(function(x){return x.age>20;})  
    .select(function(x){return x.name;});  
because the "pip" is pipeline, not real data.  

STEP 2: execute data processing  
pip.foreach(function(x){trace(x);})   
or  
for(x in pip)trace(x);  
in this step, you can get the real data flow.  
this step runs as terminal operation.  

so, by writing the internal operation code once, you can get the processing result.
smart your codes such as:  
var targets=[];  
function XXX(){  
    /*targets updated in here*/  
    for(xxx in targets) ...  
}  
function YYY(){  
    /*targets updated in here*/  
    for(xxx in targets) ...  
    ...other  
}  
into:  
var targets:Pipeline<Dynamic>=  
    src  
    .where(function(x){return x.age>20;})  
    .select(function(x){return x.name;});  
function XXX() {  
    for(xxx in targets) ... /*determine all datas which passes from pipeline in here*/  
}  
function YYY() {  
    for(yyy in targets) ... /*determine all datas which passes from pipeline in here*/  
    ...other  
}  
