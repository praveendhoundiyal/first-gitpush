public class pdfcontroller {
     public Employee_Management__c emp { get; set; }
   //  public id detailRecordid{get;set;}
       public string empId { get; set; }


    public pdfcontroller(){
         string empId=ApexPages.currentPage().getparameters().get('id');
         system.debug('=====empId======'+empId);
         emp=[SELECT EmployeeName__c,Employee_Email_Id__c,EmployeePhone__c,
              Address__c,Salary__c,Designation__c FROM Employee_Management__c WHERE Id=:empId];
    }
}