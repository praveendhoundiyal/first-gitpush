public class FirstCompontController {
    @AuraEnabled
    public static string getFormRec(string acName,string acEmail,integer acAge,string acAdderss,
                                  boolean acDef,date acBirth,string acRating,string acdes) {
                                      account ac = new account();
                                      ac.Name = acName;
                                      ac.Praveen__Email__c = acEmail;
                                      system.debug(ac.Praveen__Email__c);
                                      ac.Praveen__Age__c = acAge;
                                      system.debug(ac.Praveen__Age__c);
                                      ac.Description = acdes;
                                      system.debug(ac.Description);
                                      ac.Praveen__Only_Default_Contact__c = acdef;
                                      system.debug( ac.Praveen__Only_Default_Contact__c);
                                      ac.Praveen__Birth__c = acBirth;
                                      system.debug(ac.Praveen__Birth__c);
                                      ac.Rating = acRating;
                                      system.debug(ac.Rating);
                                      insert ac;
                                      return ac.id;
                                  }
}