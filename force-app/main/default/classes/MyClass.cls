public class MyClass {
    Integer myInteger=10;
    
    public void myMethod(Integer multiplier)
    {
        Integer multiplicationResult;
        multiplicationResult = multiplier*myInteger;
        system.debug('Multiplication'+multiplicationResult);
    }
}