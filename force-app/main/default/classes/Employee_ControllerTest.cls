@istest
public class Employee_ControllerTest {
    static TestMethod void deleteRecord_Test(){
        Employee_Management__c obj = New Employee_Management__c();
        obj.EmployeeName__c = 'Mksh';
        obj.Designation__c = 'Acc';
        obj.EmployeePhone__c = '978687876';
        obj.Employee_Email_Id__c = 'praveendhoundiyal14@gmail.com';
        insert obj;
        test.startTest();
        string empdelId=apexPages.currentPage().getParameters().put('delid',obj.id);
        Employee_controller empCon = new Employee_controller();
        empCon.deleteRecord();
        List<Employee_Management__c> updatedEmp = [Select Id from Employee_Management__c where Id =:obj.Id ];
        System.assertEquals(0,updatedEmp.size());
        test.stopTest();
    }
    static TestMethod void next_Test(){
        Employee_Management__c obj = New Employee_Management__c();
        obj.EmployeeName__c = 'Mksh';
        obj.Designation__c = 'Acc';
        obj.EmployeePhone__c = '978687876';
        obj.Employee_Email_Id__c = 'praveendhoundiyal14@gmail.com';
        insert obj;
        Employee_Management__c obj1 = New Employee_Management__c();
        obj1.EmployeeName__c = 'Rksh';
        obj1.Designation__c = 'Acc';
        obj1.EmployeePhone__c = '978687876';
        obj1.Employee_Email_Id__c = 'praveendhoundiyal14@gmail.com';
        insert obj1;
        Employee_Management__c obj2 = New Employee_Management__c();
        obj2.EmployeeName__c = 'nksh';
        obj2.Designation__c = 'IT';
        obj2.EmployeePhone__c = '978687876';
        obj2.Employee_Email_Id__c = 'praveendhoundiyal14@gmail.com';
        insert obj2;
        Employee_Management__c obj3 = New Employee_Management__c();
        obj3.EmployeeName__c = 'Rhul';
        obj3.Designation__c = 'Acc';
        obj3.EmployeePhone__c = '978687876';
        obj3.Employee_Email_Id__c = 'praveendhoundiyal14@gmail.com';
        insert obj3;
        Employee_Management__c obj4 = New Employee_Management__c();
        obj4.EmployeeName__c = 'kshri';
        obj4.Designation__c = 'Acc';
        obj4.EmployeePhone__c = '978687876';
        obj4.Employee_Email_Id__c = 'praveendhoundiyal14@gmail.com';
        insert obj4;
        Employee_Management__c obj5 = New Employee_Management__c();
 		obj5.EmployeeName__c = 'HGrish';
        obj5.Designation__c = 'Acc';
        obj5.EmployeePhone__c = '0987654';
        obj5.Employee_Email_Id__c ='praveendhoundiyal14@gmail.com';
         insert obj5;
        test.startTest();
        Employee_controller empCon = new Employee_controller();
        empCon.next();
        empCon.prev();
        test.stopTest();
        
    }
    static TestMethod void EditRecord_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.EditRecord();
    }
    static TestMethod void newbutton_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.newbutton();
    }
    static TestMethod void Snd_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.Snd();
    }
    static TestMethod void mdelete_mulbtn_test(){
         Employee_controller empCon = new Employee_controller();
        boolean checked = true;
        empCon.mdelete_mulbtn();
    }
    static TestMethod void selectAll_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.selectAll();
    }
    static TestMethod void display_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.display();
    }
    static TestMethod void detail_test(){
        test.startTest();
        /**PageReference pageRef = Page.pdfpage;
Employee_controller empCon = new Employee_controller(Name ='kshri')
insert empCon;
Test.setCurrentPage(pageRef);
pageRef.currentPage().getParameters().put(id);**/
        
        Employee_controller empCon = new Employee_controller();
        Employee_Management__c obj4 = New Employee_Management__c();
        obj4.EmployeeName__c = 'kshri';
        obj4.Designation__c = 'Acc';
        obj4.EmployeePhone__c = '978687876';
        obj4.Employee_Email_Id__c = 'praveendhoundiyal14@gmail.com';
        insert obj4;
        attachment theFile=new attachment();
        empCon.detail();
    }
    static TestMethod void getDisableprev_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.getDisableprev();
    }
    static TestMethod void getDisablenext_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.getDisablenext();
    }
    static TestMethod void beginning_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.beginning();
    }
    static TestMethod void last_test(){
        Employee_controller empCon = new Employee_controller();
        empCon.last();
    }
    public class empWrapper {
        public Boolean checked{set;get;}
        public empWrapper(Employee_Management__c emp){
            checked = true;
        }
    }
}