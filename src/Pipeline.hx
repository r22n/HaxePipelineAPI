import js.Error;

/**
	the pipeline API abstract definition
	@author r22n ryouta
*/
abstract Pipeline<T>(Iterable<T>) from Iterable<T> to Iterable<T> {
	/**
		retrives iterator object which is Pipielined iterator or array iterator.
		@return the iterator object can be used as terminal operation
	*/
	public function iterator():Iterator<T>{return this.iterator();}

	/**
		open internal operation pipeline which filter element.
		the result yields some datas matches with pred.
		@param pred the condition predicator
		@return the pipeline which outputs filtered
		@exception pred is null
		@exception this is null
	*/
	public function where(pred:T->Bool):Pipeline<T>{
		if(this==null)throw new Error("null ref");
		if(pred==null)throw new Error("pred is null");
		return {
			iterator:function():Iterator<T>{
				var fet:Bool=false;
				var nex:T=null;
				var itr:Iterator<T>=this.iterator();
				var took:Bool=true;
				return {
					hasNext:function():Bool{
						if(!took)return fet;
						took=false;
						while((fet=itr.hasNext())&&!pred(nex=itr.next())){}
						return fet;
					},
					next:function():T{
						if(!fet)throw new Error("no next");
						took=true;
						return nex;
					}
				};
			}
		};
	}

	/**
		open internal operation pipeline which convert to other data structure.
		the result yields all datas which was converted with selector.
		@param selector the data converter
		@return the pipeline which outputs converted datas.
	*/
	public function select<U>(selector:T->U):Pipeline<U> {
		if(this==null)throw new Error("null ref");
		if(selector==null)throw new Error("selector is null");
		return {
			iterator:function():Iterator<U>{
				var fet:Bool=false;
				var nex:U=null;
				var itr:Iterator<T>=this.iterator();
				var took:Bool=true;
				return {
					hasNext:function():Bool{
						if(!took)return fet;
						took=false;
						if(!(fet=itr.hasNext()))return false;
						nex=selector(itr.next());
						return true;
					},
					next:function():U{
						if(!fet)throw new Error("no next");
						took=true;
						return nex;
					}
				};
			}
		};
	}

	/**
		open internal operation pipeline which outputs joined-set.
		the result yields all joined datas.
		@param tar the targets will join into right
		@param join the join method that merge data.
		@return the pipeline which outputs joined data
	*/
	public function join<U,V>(tar:Pipeline<U>,join:T->U->V):Pipeline<V> {
		if(this==null)throw new Error("null ref");
		if(join==null)throw new Error("join is null");
		return {
			iterator:function():Iterator<V>{
				var fet:Bool=false;
				var nex:V=null;
				var elx:T=null;
				var itrx:Iterator<T>=this.iterator();
				var itry:Iterator<U>=null;
				var first:Bool=true;
				var took:Bool=true;
				return {
					hasNext:function():Bool{
						if(!took)return fet;
						took=false;
						if(first||!itry.hasNext()){
							first=false;
							if(!(fet=itrx.hasNext()))return false;
							elx=itrx.next();
							itry=tar.iterator();
						}
						if(!(fet=itry.hasNext()))return false;
						nex=join(elx,itry.next());
						return true;
					},
					next:function():V{
						if(!fet)throw new Error("no next");
						took=true;
						return nex;
					}
				};
			}
		};
	}
	/**
		open internal operation which applies all datas passes in this to com.
		@param com the command will work to all element passes in this pipeline
		@return the pipeline which outputs all datas applied command.
	*/
	public function apply(com:T->Void):Pipeline<T> {
		if(this==null)throw new Error("null ref");
		if(com==null)throw new Error("com is null");
		return {
			iterator:function():Iterator<T>{
				var itr:Iterator<T>=this.iterator();
				var nex:T=null;
				var fet:Bool=false;
				var took:Bool=true;
				return {
					hasNext:function():Bool{
						if(!took)return fet;
						took=false;
						if(!(fet=itr.hasNext()))return false;
						com(nex=itr.next());
						return true;
					},
					next:function():T{
						if(!fet)throw new Error("no next");
						took=true;
						return nex;
					}
				};
			}
		};
	}
	/**
		sort all element as terminal operation.
		if your call method chains has this, datas were determined in there.
		@param com the comparator will work in Array#sort
		@return the terminal operated datas as pipeline type
	*/
	public function sort(com:T->T->Int):Pipeline<T> {
		if(this==null)throw new Error("null ref");
		if(com==null)throw new Error("com is null");
		var ret:Array<T>=[];
		for(x in this)ret.push(x);
		ret.sort(com);
		return ret;
	}
	/**
		execute command for all elements as termianl operation.
		@param com the command will work for all elements.
	*/
	public function foreach(com:T->Void):Void{
		if(this==null)throw new Error("null ref");
		if(com==null)throw new Error("com is null");
		for(x in this)com(x);
	}
	/**
		aggregate all elements with user specific options as terminal operation.
		@param zero the zero value of aggregation
		@param agr aggregator method will recieve arguments (left, right) like left+=right
		@param saf aggregator method will recieve arguments (sum, count) which of count is all element count, sum is you aggregated.
		@return the aggregated result
	*/
	public function aggregate<U>(zero:U,agr:U->T->U,saf:U->Int->U=null):U{
		if(this==null)throw new Error("null ref");
		if(agr==null)throw new Error("agr is null");
		var ret:U=zero;
		var count:Int=0;
		for(x in this){
			ret=agr(ret,x);
			count++;
		}
		return saf!=null?saf(ret,count):ret;
	}
	/**
		get minimum element can minimize the evalator as terminal operation.
		the value of element will be specified with argument.
		@param eval the evalator function of element
		@return the minimum element
	*/
	public function argmin(eval:T->Float):T {
		if(this==null)throw new Error("null ref");
		if(eval==null)throw new Error("eval is null");
		var itr:Iterator<T>=this.iterator();
		if(!itr.hasNext())throw new Error("no elem");
		var ret:T=null;
		var val:Float=null;
		do {
			var x:T=itr.next();
			var y:Float=eval(x);
			if(val==null||val>y) {
				ret=x;
				val=y;
			}
		}while(itr.hasNext());
		return ret;
	}
	/**
		get maximum element can maximize the evalator as terminal operation.
		the value of element will be specified with argument.
		@param eval the evalator function of element
		@return the maximum element
	*/
	public function argmax(eval:T->Float):T {
		if(this==null)throw new Error("null ref");
		if(eval==null)throw new Error("eval is null");
		var itr:Iterator<T>=this.iterator();
		if(!itr.hasNext())throw new Error("no elem");
		var ret:T=null;
		var val:Float=null;
		do {
			var x:T=itr.next();
			var y:Float=eval(x);
			if(val==null||val<y) {
				ret=x;
				val=y;
			}
		}while(itr.hasNext());
		return ret;
	}
	/**
		retrives first element from pipeline as terminal operation.
		@return the first element of all
	*/
	public function first():T{
		if(this==null)throw new Error("null ref");
		var itr:Iterator<T>=this.iterator();
		if(!itr.hasNext())throw new Error("no first element");
		return itr.next();
	}
	/**
		retrives last element from pipeline by fetching all element as terminal operation.
		@return the last element of all
	*/
	public function last():T{
		if(this==null)throw new Error("null ref");
		var itr:Iterator<T>=this.iterator();
		if(!itr.hasNext())throw new Error("no elem");
		var ret:T;
		do{
			ret=itr.next();
		}while(itr.hasNext());
		return ret;
	}
	/**
		fetch and count all element from pipeline as terminal operation
		@return the count of element
	*/
	public function count():Int{
		if(this==null)throw new Error("null ref");
		var ret:Int=0;
		for(x in this)ret++;
		return ret;
	}
}
