class Case14 {
    public static function main():Void {
		var a:Dynamic={name:"a",children:[]};
		var b:Dynamic={name:"b",children:[]};
		var c:Dynamic={name:"c",children:[]};
		var d:Dynamic={name:"d",children:[]};
		var e:Dynamic={name:"e",children:[]};
		var f:Dynamic={name:"f",children:[]};
		a.children.push(c);
		a.children.push(d);
		d.children.push(e);
		b.children.push(f);
		/*
			a	b
			cd	f
			 e
			
			=>b f a d e c
		*/
		var ans:Array<String>=["b","f","a","d","e","c"];
		var tar:Iterator<Dynamic>=
			Pipeline.open([a,b])
			.explore(function(x:Dynamic):Iterable<Dynamic>{return x.children;})
			.iterator();

		for(x in ans) {
			if(!(tar.hasNext()&&tar.next().name==x))trace("failed");
		}
		if(!(!tar.hasNext()))trace("failed");		

    }
}
