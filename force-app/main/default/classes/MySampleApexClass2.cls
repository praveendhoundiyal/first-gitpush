public class MySampleApexClass2 {
    public static double myvalue;
    public MySampleApexClass2(){
        myvalue = 100;
    }
    public static Double getCalculatedValue (){
        myvalue = myvalue + 10;
        return myvalue;
    }
    public static Double getCalculatedValueViaPrice (Decimal price){
        myvalue = myvalue + price;
        return myvalue;
    }
}