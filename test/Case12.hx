class Case12 {
    public static function main():Void {
        var itr:Iterator<Int>=Pipeline.enumerate(0,10).iterator();
        for(i in 0...10) {
            if(!(itr.hasNext()&&itr.next()==i)) {
                trace("failed");
            }
        }
        if(!(!itr.hasNext())) {
            trace("failed");
        }
    }
}