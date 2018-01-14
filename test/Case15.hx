class Case15 {
    public static function main():Void {
		var tar:Map<String,String>=[
			"x"=>"X",
			"y"=>"Y"
		];
		var ans:Map<String,String>=[
			"x"=>"X",
			"y"=>"Y"
		];
		var pip:Pipeline<{key:String,value:String}>=Pipeline.openMap(tar);
		var itr:Iterator<{key:String,value:String}>=pip.iterator();
		for(x in ans.keys()) {
			if(!(itr.hasNext()))trace("failed");
			var kv:{key:String,value:String}=itr.next();
			if(!(x==kv.key&&ans[x]==kv.value))trace("failed");
		}
		if(!(!itr.hasNext()))trace("failed");
    }
}
