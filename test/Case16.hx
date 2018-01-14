class Case16 {
    public static function main():Void {
		var tar:Dynamic={
			x:"X",
			y:"Y"
		};
		var ans:Dynamic={
			x:"X",
			y:"Y"
		};
		var pip:Pipeline<{key:String,value:String}>=Pipeline.openFields(tar);
		var itr:Iterator<{key:String,value:String}>=pip.iterator();
		for(x in Reflect.fields(ans)) {
			if(!(itr.hasNext()))trace("failed");
			var kv:{key:String,value:String}=itr.next();
			if(!(x==kv.key&&Reflect.field(ans,x)==kv.value))trace("failed");
		}
		if(!(!itr.hasNext()))trace("failed");
    }
}
