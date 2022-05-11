@isTest
private class TestRestrictContactByName {
    
     @isTest static void TestLastNameIsvalid() {	
       
 		Contact c = new Contact (FirstName='abcd',LastName='rana',Department='Technology');
        insert c;
       
        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();
       
        System.assert(result.isSuccess());
    }          
    
    @isTest static void TestLastNameIsNotInvalid() {
      
        Contact c2 = new Contact (FirstName='xyz',LastName='INVALIDNAME',Department='Finance');
        insert c2;
        Test.startTest();
        Database.SaveResult result = Database.insert(c2, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML.',
                             result.getErrors()[0].getMessage());
    }   
}