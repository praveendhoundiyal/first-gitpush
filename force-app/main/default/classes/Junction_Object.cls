public class Junction_Object {
    public List<pWrapper> display_list {get; set;} 
    public list<pWrapper> wrapperlist;
    // public String setId {get;set;}
    public List<Position__c> PList {get;set;}
    //public Position__c pSet {get; set;}
    public List<InnerWrapper> wrap_PositionList{get; set;}  
    
    public Junction_Object()
    {
        display_list =new list<pWrapper>();
        // display_list = [select Name,Department__c,Status__c,Approval_Status__c from Position__c];
        for ( Position__c pst : [select Name,Department__c,Status__c,Approval_Status__c,
                                 (select Name,Stage__c,Status__c, Position__c from Job_Applications__r) 
                                 from Position__c])
            
        {
            pWrapper pw = new pWrapper();
            pw.Name = pst.Name;
            pw.Department = pst.Department__c;
            pw.Status = pst.Status__c;
            pw.Approval_Status = pst.Approval_Status__c; 
            
            list<InnerWrapper> test = new list<InnerWrapper>();
            for(Job_Application__c ja : pst.Job_Applications__r)
            {
                InnerWrapper inlist = new InnerWrapper();
                inlist.Position = ja.Position__c;
                inlist.Stage = ja.Stage__c;
                inlist.Status = ja.Status__c;
                test.add(inlist);
                
            }
            system.debug('----test-----'+test);
            
            pw.listInner = test;
            display_list.add(pw);
            system.debug('----display_list-----'+display_list);
            
        }
        
        
    }
    
    
    public class pWrapper
    {
        public string Name {get;set;}
        public string Department {get;set;}
        public string Status {get;set;}
        public string Approval_Status {get;set;}
        public list<InnerWrapper> listInner {get;set;}
        
    }
    
    public class InnerWrapper
    {
        public string Position {get;set;}
        public string Stage {get;set;}
        public string Status {get;set;}
        
    }
}