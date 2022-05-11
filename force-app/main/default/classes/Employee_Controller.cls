public class Employee_Controller {
       //public Employee_Management__c emp { get; set; }
       public boolean sectRelode{get;set;}
       //public boolean sectRelode1{get;set;}
       //public list <Employee_Management__c> emp_list {get;set;}
      // public id deleteRecordid{get;set;}
      // public id detailRecordid{get;set;}
       //public Employee_Management__c recordToDelete;
       public Boolean allBool{get;set;}
       public list<empWrapper> wrapperlist;
       public list<empWrapper> listwrapperTo{get;set;}
       public integer counter{get;set;}
       public integer totalSize{get;set;}
       public integer counter_pre{get;set;}
       public integer counter_last{get;set;}
       Integer limitSize = 4;
       public Integer pageNumber{get;set;}
     
	   public Employee_Controller() {
        counter=0; 
        totalSize=0;
        sectRelode = true;
        allBool =false;
           
        //sectRelode1 =true;
        display();
       /* emp = new Employee_Management__c();
        
        wrapperlist = new list <empWrapper>();
        //listWrapper = new List<empWrapper>();
      /*  emp_list=  [SELECT EmployeeName__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c ];
           for(Employee_Management__c acc: [select Id, EmployeeName__c,Salary__c,Designation__c,EmployeePhone__c,Address__c  from Employee_Management__c ] )
           {
               empWrapper empw= new empWrapper();
               empw.empId=acc.id;
               empw.empName= acc.EmployeeName__c;
               empw.empSalary= acc.Salary__c;
               empw.empPhone= acc.EmployeePhone__c;
               empw.empAddress= acc.Address__c;
               empw.empDesignation= acc.Designation__c;
                wrapperlist.add(empw);
         

           }*/
       
     }
   /* public void save() {
        try{
         insert emp;
        emp_list=[SELECT EmployeeName__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c order by createdDate asc];
        }  // sectRelode1 = false;
        cATCH(exception e){
            string error=e.getMessage();
            apexPages.addMessage(new apexpages.message(apexpages.Severity.ERROR,error));
        }
 }
    public PageReference cancel(){
        PageReference page=new PageReference('/apex/EmployeeManagement');
        page.setRedirect(true);
        return page;
    }*/
    
public pagereference EditRecord(){
         // system.debug('*****************************************');
        string empId=ApexPages.currentPage().getparameters().get('editName');
        system.debug('||||||||||||||||||||||||'+empId);
        pagereference pageRef=new pagereference('/apex/Edit?id='+empId);
        pageRef.setRedirect(true);
        return pageRef;
    }

public class empWrapper{
       public Boolean checked{set;get;}
      //public string empId{get;set;} 
      public Employee_Management__c emp{ get; set; }
      public empWrapper(Employee_Management__c emp) 
            {
                this.emp = emp;
            }    
   
   }

public void deleteRecord(){ 
            string empdelId=apexPages.currentPage().getParameters().get('delid');
            Employee_Management__c recordToDelete =[SELECT id ,Employee_Email_Id__c,EmployeeName__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c WHERE Id=: empdelId];
            system.debug('---recordToDelete----'+recordToDelete);
			//list<Employee_Management__c> delList=new list<Employee_Management__c>();
     		list<empWrapper> tempDelList=new list<empWrapper> ();
           if(recordToDelete !=null )
           {
     		  Database.DeleteResult dr=database.delete(recordToDelete,false);
               if(dr.isSuccess())
               {
                    for(empWrapper empw : listwrapperTo)
                   	{
                       if (empw.emp.id != empdelId)
                       {
                           tempDelList.add(empw);
                       }
                       
                   }
                   listwrapperTo.clear();
                        
                       if(tempDelList.size()>0)
                       listwrapperTo=tempDelList;
               }
           }
 }  
   
      
public PageReference detail(){
        string emppdfId=apexPages.currentPage().getParameters().get('pdfId');
        system.debug('----------pdfid----'+emppdfId);
        PageReference page=new PageReference('/apex/pdfpage?id='+emppdfId);
        page.setRedirect(true);
        Employee_Management__c emp=[select name from Employee_Management__c Where id=:emppdfId];
        blob body=page.getContentAsPDF();
        attachment theFile=new attachment();
        theFile.IsPrivate=false;
        theFile.Body=body;
        theFile.Name=emp.name;
        theFile.ParentId=emppdfId;
        insert theFile;
        return page;
    }
public PageReference newbutton(){
       string empId=ApexPages.currentPage().getparameters().get('newid');
        system.debug('||||||||||||||||||||||||'+empId);
        pagereference pageRef=new pagereference('/apex/Newbutton?id='+empId);
        pageRef.setRedirect(true);
        return pageRef;
    
}
public PageReference Snd(){
         string empId=ApexPages.currentPage().getparameters().get('empSnd');
        pagereference pageRef=new pagereference('/'+empId);
        pageRef.setRedirect(true);
        return pageRef;
        
    }
public void next(){
        pageNumber = pageNumber+1;
        listwrapperTo.clear();
        counter=counter+limitSize;
       
        if((counter+limitSize) <= totalSize)
        {
            for(Integer i=counter-1;i<(counter+limitSize);i++)
            {
                listwrapperTo.add(wrapperlist.get(i));
            }
        } 
          else
          {
            for(Integer i=counter;i<totalSize;i++)
            {
                listwrapperTo.add(wrapperlist.get(i));
            }
          }
       //counter_prev = counter_prev+counter; 
       //counter_next = counter+ listwrapperTo.size();
  }
    
public void prev(){
     pageNumber = pageNumber-1;
   
        listwrapperTo.clear();
        counter=counter-limitSize;       
        for(Integer i=counter;i<(counter+limitSize); i++)
        {
            listwrapperTo.add(wrapperlist.get(i));
        }
    
        counter_pre = counter_pre - counter; 
        counter_last = counter;
        
    }
    
    public void display(){
         wrapperlist = new list <empWrapper>();
         listwrapperTo = new List<empWrapper>();
         list<Employee_Management__c> listemp =[SELECT EmployeeName__c, Employee_Email_Id__c,HireDate__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c order by createdDate asc limit 30];
         system.debug('========listemp==='+listemp.size());
         if(listemp.size() > 0)
         {
            for(Employee_Management__c emp : listemp) 
                {
                    wrapperlist.add(new empWrapper(emp));
                }       
         }   
         totalSize = wrapperlist.size();
         pageNumber = 1;
         if((counter+limitSize) <= totalSize)
         {
            for(Integer i=0;i<limitSize;i++)
            {
                listwrapperTo.add(wrapperlist.get(i));
            }
        }
        else
        {
            for(Integer i=0;i<totalSize;i++)
            {
                listwrapperTo.add(wrapperlist.get(i));
            }
        }
        
    }
    public boolean getDisableprev(){
        if(counter==0)
            return true;
        else 
            return false;
    }
    public boolean getDisablenext(){
        if((counter + limitsize)>=totalsize)
        return true;
    else 
        return false;
    }
      // counter_pre = 1;
      // counter_last= listWrapperTo.size();

    public void selectAll() 
    {
        system.debug('+++sectRelode++++'+sectRelode);
        sectRelode=true;
           if(allBool) 
            {
                for(empWrapper w : listwrapperTo) 
                {
                    w.checked = true;
                }
            }
             else 
            {
                for(empWrapper w : listwrapperTo) 
                {
                    w.checked = false;
                }
            }

}
     public void beginning(){
       pageNumber = 1;
        listWrapperTo.clear();
        counter=0;
        if((counter + limitSize) <= totalSize){
       
            for(Integer i=0;i<limitSize;i++){
                listwrapperTo.add(wrapperlist.get(i));
            }   
           
        } else{
       
            for(Integer i=0;i<totalSize;i++){
                listwrapperTo.add(wrapperlist.get(i));
            }       
           
        }
        counter_last = listwrapperTo.size();
       
    }
    
     public void last (){
        integer totalP = wrapperlist.size()/limitSize;
        if(math.mod(wrapperlist.size(),limitSize)>0)
        {
            totalP = totalP +1;
        }
        pageNumber = totalP ;
        listWrapperTo.clear();
       
        if(math.mod(totalSize , limitSize) == 0){
            counter = limitSize * ((totalSize/limitSize)-1);
            counter_last = counter;
        } else if (math.mod(totalSize , limitSize) != 0){
            counter = limitSize * ((totalSize/limitSize));
        }
       
        for(Integer i=counter-1;i<totalSize-1;i++){
                listWrapperTo.add(wrapperlist.get(i));
        }
       counter_last = counter + listWrapperTo.size();
    }
     
     public void mdelete_mulbtn()
    {       
        list<Employee_Management__c> listEmpDel = new list<Employee_Management__c>();
        list<empWrapper> listTempWrapper = new list<empWrapper>();
        for(empWrapper w : listWrapperTo) 
        {
            
            if(w.checked) 
                {
                    
                    listEmpDel.add(w.emp);
                }
            else 
                {
                    listTempWrapper.add(w);
                    
                }
             system.debug('..........value of w'+w);
        }
        if(listEmpDel.size() > 0) 
        {
            delete listEmpDel;
            display();
            //wrapperlist = listTempWrapper;
        }
        else 
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Select atleast one employee to delete'));
        }
     }
    }