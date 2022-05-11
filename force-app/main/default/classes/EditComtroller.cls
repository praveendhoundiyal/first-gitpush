public class EditComtroller {
    public Employee_Management__c emp { get; set; }
  //  public list <Employee_Management__c> emp_list {get;set;}
    public string empName {get;set;}
    public string empAddress{get;set;}
    public string empDesignation{get;set;}
    public decimal empSalary{get;set;}
    public string empPhone{get;set;}
    public string empmail{get;set;}
    public boolean checkbox{get;set;}
    public string empId{get;set;}
     
    public EditComtroller(){
        // emp = new Employee_Management__c();
         emp=[SELECT EmployeeName__c,Employee_Email_Id__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c LIMIT 1];
    }

    
    public pagereference save(){
        pagereference savepage;
        try{
   
     //   emp_list=[SELECT EmployeeName__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c order by createdDate asc];
        update emp;
          
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