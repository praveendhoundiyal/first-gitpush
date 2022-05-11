public class InsertAccWithConOpp{
    @AuraEnabled
    public static String createparentchildrecord(Account acc, Contact con, Opportunity opp){
        String resultVal ='';
        SavePoint sp = Database.setSavePoint();
        try{
            insert acc;
            con.AccountID  = acc.id;
            insert con;
            opp.AccountID  = acc.id;
            insert opp;
            resultVal=''+acc.ID;
        }
        catch(Exception e){
            Database.rollback(sp);
        }
        return resultVal;
    }
}