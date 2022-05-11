public class MySampleApexClass {       
   public static Integer myValue = 10;  
  // public static String myString = '';
   
   public static void getCalculatedValue () {
 
      myValue = myValue+10;
      system.debug('=='+myValue);
   }
}