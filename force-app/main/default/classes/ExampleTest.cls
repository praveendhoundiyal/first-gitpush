public class ExampleTest {
    public static decimal FahrenheitToCelsius(Decimal fh)
    {
     Decimal cs = (fh - 32) * 5/9;
        return cs.setScale(2);
    }

}