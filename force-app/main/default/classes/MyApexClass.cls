public class MyApexClass {
    
    public static Integer myValue=0;
    public static String myString='xyz';
    
    public static Integer getCalculateValue()
    {
        myValue=myValue+10;
        return myValue;
    }
    }