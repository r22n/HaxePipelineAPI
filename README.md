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
## APIs
### open
open pipeline from Iterable<T>.  
pipeline variable allows you write powerful codes, but before do it, must store Iterable<T> into Pipeline type variable such as:  
`var x:Pipeline<T>=array;`.  
you can store Iterable<T> object into Pipeline<T> variables directly, but also, use open operation like:  
`var x:Pipeline<T>=Pipeline.open(array);`.  
this guearantees what variable of x is pipeline of array even if change this API's specification.  
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
