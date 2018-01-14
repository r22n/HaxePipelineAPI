# HaxePipelineAPI
data processing pipeline API for HAXE language such as MS LINQ, java Stream API.  
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
## High Performance Pipeline Operating
### user specific terminal operation
the terminal operation may mark better pipeline performance than processing with subroutine such as the case:  
`var targets:Array<Dynamic>=subroutine(source);`  
`trace(targets[0]);`  
because of no need to retrive elements from targets[1, ..., size-1], this code consumes machine resources.  
so, we want to solution what can write simple user code such as above trace by single definition subroutine operation.  
single definition subroutine make your code simpler, as defining no subrouine like `findAll` and `findFirst` and so on.  
by using pipeline, you just define single definition `findAll`, the reason is `findAll` returns pipeline to found all elements and it retrives no elements in subroutine.  
for code such that: `var targets:Pipeline<Dynamic>=subroutine(source);`, following codes provides different computing time.  
`trace(targets.first()); => retrives first element only, and abort to process elements from second one`  
`for(target in targets)do something; => retrives all element in here`  
so, you can write single data processing subrouting definition, and it perform better because of the usage of computing resources decides terminal operations what you gave.  
### pre-stall pipeline
by all datas passes pipeline, your code takes computing time as long as size(length) of pipeline like below.  
`src.where(...).select(...).....explore(...).skip(...)...`.  
if pipeline operations does not stall and drop element, re-ordering pipeline has not effects to computing time.  
`src.select(...).sort(...)'s comting time equals to src.sort(...).select(...)`  
however, if pipeline stalls like `where, skip, limit` operations, it is worth of time what processing elements before its.  
so, as writing high stall probability pipeline operation in front of method chain, you can reduce usage of compuing time.  
therefore, `src.skip(100% stalls).limit(100% stalls).where(N% stalls).select(0% stalls)` works faster than:  
`src.select(0% stalls).where(N% stalls).skip(100% stalls).limit(100% stalls)`.  
because, second code drops element in where, skip, limit operation even though select operation processes it.  
### no-recall tree enumeration
for giving effects to composite like tree structure, you may write re-call function such as:  
`doSomethingAndChildrenToo(x){do something; doSomethingAndChildrenToo(x.children);}`  
manipulating x and its children with same action,  apply action to all elements in tree data.  
if you want to other action, you must write functions with other one or using double dispatch.  
but, it causes many definitions of subrouting and difficult factors to maintain its.  
if you just apply same operation to all tree element, `explore` API works fine as internal pipeline operation.  
`x.explore(function(x){return x.children;}).(do something what you want)`  
## APIs
### open
open pipeline from Iterable<T>.  
pipeline variable allows you write powerful codes, but before do it, must store Iterable<T> into Pipeline type variable such as:  
`var x:Pipeline<T>=array;`.  
you can store Iterable<T> object into Pipeline<T> variables directly, but also, use open operation like:  
`var x:Pipeline<T>=Pipeline.open(array);`.  
this guearantees what variable of x is pipeline of array even if change this API's specification.  
### openFields, openMap
open pipeline which fetches all fields with field name.  
in map case, too.
the pipeline yields {key:String,value:Dynamic} pair.  
`Pipeline.openFields({x:XXX,y:YYY}) => {key:"x",value:XXX},{key:"y",value:YYY}`  
`Pipeline.openMap([x=>XXX,y=>YYY]) => {key:x,value:XXX},{key:y,value:YYY}`  
### enumerate
get root pipeline yields continious integer numbers in range.  
the range specified by 2 integer values such that \[begin,end).  
`Pipeline.enumerate(0,10) => 0, 1, 2, ..., 9`
### where(internal operation)
create pipeline filts elements with specified condition.  
as failing to match the elements with condtion, ignore its and stalls pipeline.  
`.where(function(x){return x>=20;}) => all elements is greater equal than 20`.
### select(internal operation)
create pipeline force to remake element into other object.  
`.select(function(x){return x*x;}) => all elements was squared`.
### join(internal operation)
create pipeline yields joined-set.  
N x M elements will be maked in this operation like db's internal-join.  
`.join(array,function(originalSRC,arraySRC){return put your code merge originalSRC and arraySRC in here;}) => all merged elelments such that original[i] x array[j]`.
### apply(internal operation)
apply the command to elements passes in this pipeline.  
`.apply(function(x){return x.age++;}) => elements what age incremeneted`.  
note: if you run apply methods to same data source twice, apply pipeline updates its with same operation twice.  
### explore(internal operation) 
explore tree data structures and yields elements in depth first all search order.  
`.explore(function(x){return x.children;}) => depth order elements from root element`.  
### sort(internal operation)
yields sorted elements with specified comparator.  
this operation retrives all elements from source pipeline temporally.  
`.sort(function(x,y){return x>y?1:-1;}) => sorted elements from smaller`.
### skip(internal operation)
skips elements and force to stall pipeline with count.  
`.skip(10) => skiped 10 counts from head of source pipeline`.
### limit(internal operation)
limits elements and force to abort pipeline with count.  
`.limit(10) => limited 10 counts from head of source pipeline`.
### foreach(terminal operation)
do action for all elements passed from pipeline.  
`.foreach(function(x){trace(x);}) => show all elements by retriving all elements from source pipeline`.
### aggregate(terminal operation)
aggregates all elements to single value.  
`.aggregate(0.0, function(left,right){return left+right;}, function(sum,count){return sum/count;}) => aggregates average value from pipeline`.
first arguments zero value.  
seconds, aggregator.  
lasts, the operation that the sum what you aggregated with elements count.  
### argmin(terminal operation)
retrives minimum elements which can minimize specified evalator.  
`.argmin(function(x){return x.age;}) => youngest`.
### argmax(terminal operation)
retrives maximum elements which can maximize specified evalator.  
`.argmax(function(x){return x.age;}) => oldest`.
### first(terminal operaiton)
just retrives first elements which passed from pipeline and abort pipeline.  
`.first() => first element`.
### last(terminal operation)
retrives last elements by passing elements which is not last.  
`.last() => last element`.
### count(terminal operation)
counts all elements by passing all.  
`.count() => count of elements which passed`.  
### any(terminal operation)
check up there is any element matches specified condition.  
if finds it, abort pipeline.  
`.any(function(x){return x.name=="tom";}) => if true, tom was passed`.
### all(terminal operation)
check up all elements matches specified condition.  
`.all(function(x){return x.isMale;}) => if true, all elements is male`.
### toArray(terminal operation)
packs all elements into Array object.  
`.toArray() => the array decided in here and no receive any effects from pipeline operation`
## how to use
usage is very simple.  
add Pipeline.hx into class path of haxe compiler.  
retrives Iterable type object to Pipeline type.  

STEP 0: retrives some Iterable values  
var src:Pipeline<Dynamic>=datas/\*of Iterable type\*/;  

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
    /\*targets updated in here\*/  
    for(xxx in targets) ...  
}  
function YYY(){  
    /\*targets updated in here\*/  
    for(xxx in targets) ...  
    ...other  
}  
into:  
var targets:Pipeline<Dynamic>=  
    src  
    .where(function(x){return x.age>20;})  
    .select(function(x){return x.name;});  
function XXX() {  
    for(xxx in targets) ... /\*determine all datas which passes from pipeline in here\*/  
}  
function YYY() {  
    for(yyy in targets) ... /\*determine all datas which passes from pipeline in here\*/  
    ...other  
}  
