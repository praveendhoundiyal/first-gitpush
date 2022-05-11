public class TestComponent {
    @AuraEnabled
    public static string saveOpportunity (string opName,string opStage,Date opCloseDate,decimal opAmount) {
        opportunity opr = new opportunity();
        opr.Name = opName;
        opr.StageName = opStage;
        opr.CloseDate = opCloseDate;
        opr.Amount = opAmount;
        insert opr;
        return opr.id;
        
        
    }
    
}