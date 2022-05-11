global class ScheduledClass Implements Schedulable
            {
                   global void execute(SchedulableContext sc)  
                   {
                     sendmail();
                   }
			
    public void sendmail(){
         messaging.SingleEmailMessage emails=new messaging.SingleEmailMessage();
         list<string> empHire=new list<string>();
         for(Employee_Management__c empEmail:[SELECT Employee_Email_Id__c FROM Employee_Management__c WHERE HireDate__c=Tomorrow])
         {
		     empHire.add(empEmail.Employee_Email_Id__c);
         }
         //empHire.add('praveendhoundiyal14@gmail.com');
       // empHire.add('anil.singh@cynoteck.com');
       for(empCustom__c empC:[Select empCustom_email__c from empCustom__c ])
       {
           if(empC.empCustom_email__c != null)
           {
              empHire.add(empC.empCustom_email__c);
           }
       }
         
         system.debug('====empHire======'+empHire);
         list<Employee_Management__c> listEmp=[SELECT EmployeeName__c,HireDate__c,Employee_Email_Id__c,EmployeePhone__c,Address__c,Salary__c,Designation__c FROM Employee_Management__c WHERE HireDate__c=Tomorrow];

         string hbody = '';
          hbody = '<Table border="1" cellpadding="0" cellspacing="0" width="100%">'+
                    '<tr style="background-color:#EAEAEA;">'+
                        '<th width="15">'+
                            'Name' +
                        '</th>'+
                        '<th width="15">'+
                            'Hire Date'+
                        '</th>'+
                        '<th width="20">'+
                            'Email'+
                        '</th>'+
                        '<th width="20">'+
                            'Address'+
                        '</th>'+
                    '</tr>';
        string body='';
         for(Employee_Management__c emp:listEmp){
            body +=       
                    '<tr>'+
                        '<td width="15">'+
                            emp.EmployeeName__c +
                        '</td>'+
                        '<td width="15">'+
                            emp.HireDate__c +
                        '</td>'+
                        '<td width="20">'+
                            emp.Employee_Email_Id__c+
                        '</td>'+
                        '<td width="20">'+
                           emp.Address__c +
                        '</td>';
            
                    body += '</tr>';           
                    system.debug('----body------' + body);
            }
          emails.setHtmlBody(hbody+body+'</table>');  
        
          emails.setSubject('Hired Employee Details.');
          //emails.setPlainTextBody('<b>Employee Details:</b><br/><table border="1"><tr><th>TEST</th></tr></table>');
          emails.setToAddresses(empHire);
          Messaging.sendEmail(New Messaging.SingleEmailMessage[]{emails});
    }
}