public class Calculator {
   integer num1 = 2;
    integer num2 = 6;
    integer result;
    public integer add(integer n1,integer n2){
       result = num1 + num2;
        return result;
    }
    public void sub(){
        result = num1 - num2;
        system.debug('subtraction of num1 and num2 =:'+result);
    }
    public void mul(){
        result = num1 * num2;
         system.debug('multiple of num1 and num2 =:'+result);
    }

}