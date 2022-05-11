public class MySampleApexClass3 {
    public static Double myValue;
    public MySampleApexClass3 () {
        myValue = 100;
        System.debug(' '+myValue);
    }
    public MySampleApexClass3 (Integer newPrice){
        myValue = newPrice;
        System.debug('========'+myValue);
    }
    public static Double getCalculatedValue (){
        myValue = myValue+10;
        return myValue;
    }
    public static Double getCalculatedValueViaPrice (Decimal price){
        myValue = myValue+price;
        return myValue;
    }
}