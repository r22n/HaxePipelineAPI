class Case13 {
    public static function main():Void {
		var itr:Iterator<Int>=
			Pipeline
			.enumerate(0,10)
			.skip(3)
			.iterator();
		for(i in 3...10){
			if(!(itr.hasNext()&&i==itr.next()))trace("failed");
		}
		if(!(!itr.hasNext()))trace("failed");
		
		itr=
			Pipeline
			.enumerate(0,10)
			.limit(5)
			.iterator();
		for(i in 0...5){
			if(!(itr.hasNext()&&i==itr.next()))trace("failed");
		}
		if(!(!itr.hasNext()))trace("failed");
		
		itr=
			Pipeline
			.enumerate(0,10)
			.skip(3)
			.limit(3)
			.iterator();
		for(i in 3...6){
			if(!(itr.hasNext()&&i==itr.next()))trace("failed");
		}
		if(!(!itr.hasNext()))trace("failed");
		
    }
}
