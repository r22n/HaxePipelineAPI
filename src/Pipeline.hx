import js.Error;


abstract Pipeline<T>(Iterable<T>) from Iterable<T> to Iterable<T> {
	public function iterator():Iterator<T>{return this.iterator();}
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
	public function sort(com:T->T->Int):Pipeline<T> {
		if(this==null)throw new Error("null ref");
		if(com==null)throw new Error("com is null");
		var ret:Array<T>=[];
		for(x in this)ret.push(x);
		ret.sort(com);
		return ret;
	}
	public function foreach(com:T->Void):Void{
		if(this==null)throw new Error("null ref");
		if(com==null)throw new Error("com is null");
		for(x in this)com(x);
	}
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
		
	public function first():T{
		if(this==null)throw new Error("null ref");
		var itr:Iterator<T>=this.iterator();
		if(!itr.hasNext())throw new Error("no first element");
		return itr.next();
	}
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
	public function count():Int{
		if(this==null)throw new Error("null ref");
		var ret:Int=0;
		for(x in this)ret++;
		return ret;
	}
}
