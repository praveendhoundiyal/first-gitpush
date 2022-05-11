public class Leapyear {
    public static void test(integer i1){
        if(math.mod(i1, 4)==0 && math.mod(i1,100)!=0 || math.mod(i1,400)==0){
            system.debug('leap year'+i1);
        }
        else{
            system.debug('not leap yrar'+i1);
        }
        
}
}