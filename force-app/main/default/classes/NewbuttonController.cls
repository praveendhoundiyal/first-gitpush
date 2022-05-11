public class NewbuttonController {
    public Employee_Management__c emp { get; set; }  
    public list <Employee_Management__c> emp_list {get;set;}
    
    public NewbuttonController(){
         emp = new Employee_Management__c();
         emp_list=  [SELECT EmployeeName__c,Employee_Email_Id__c,EmployeePhone__c,HireDate__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c ];
    }

 public pagereference save() {
     pagereference savepage;
        try{
         insert emp;
        emp_list=[SELECT EmployeeName__c,Employee_Email_Id__c,EmployeePhone__c,HireDate__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c order by createdDate asc];
        savepage=new pagereference('/apex/EmployeeManagement');
            savepage.setRedirect(true);
        }  
        cATCH(exception e){
            string error=e.getMessage();
            apexPages.addMessage(new apexpages.message(apexpages.Severity.ERROR,error));
        }
     return savepage;
 }
    public PageReference cancel(){
        PageReference page=new PageReference('/apex/EmployeeManagement');
        page.setRedirect(true);
        return page;
    }
}