public class Fridge {
    private String modelNumber;
private Integer numberInStock;
public void updateStock(Integer justSold) {
numberInStock = numberInStock - justSold;
system.debug(numberInStock);
}

public void setModelNumber(String theModelNumber) {
modelNumber = theModelNumber;
}
public String getModelNumber() {
return modelNumber;
}
    public Fridge() {
modelNumber = 'XX-XX';
numberInStock = 0;
}
public Fridge(String theModelNumber, Integer theNumberInStock) {
    modelNumber = theModelNumber;
numberInStock = theNumberInStock;
   
}
}