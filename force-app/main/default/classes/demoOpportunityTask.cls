public class demoOpportunityTask {
    
    /*  public class wrapperClass {
// @auraEnabled 
// public List<Account> wrapAccountList {get; set;}
// @auraEnabled   
// public string ErrorList{get; set;} 
@AuraEnabled public list<user> allGetUser {get;set;}

public Integer pageSize {get;set;}
public Integer pageNumber {get;set;}
public Integer totalRecords {get;set;}
public Integer recordStart {get;set;}
public Integer recordEnd {get;set;}
public List<Opportunity> opplist {get;set;}

}*/
    
    public class opportunityWrap{
        @AuraEnabled public list<user> allGetUser {get;set;}
        @AuraEnabled public User singleUser {get;set;}
        @AuraEnabled public list<opportunity> allOppData {get;set;}
        @AuraEnabled public string userName {get;set;}
        @AuraEnabled public integer totalLineItem {get;set;}
        @AuraEnabled public string opportunityId {get;set;}
        @AuraEnabled public string opportunityName {get;set;}
        @AuraEnabled public string accountName {get;set;}
        @AuraEnabled public date closeDate {get;set;}
        @AuraEnabled public decimal Amount {get;set;}
        // @AuraEnabled public integer Totaloppline {get;set;}   
        @AuraEnabled public string StageName {get;set;}
    }
    
    @auraEnabled
    public static opportunityWrap fetchOpportunity(string uId,integer mnthId){
        // String sortBy = isSortAsc ? 'ASC' : 'DESC';
        system.debug('==mnthId=='+mnthId);
        system.debug('==uId=='+uId);
        opportunityWrap opWrap = new opportunityWrap();
        date todayDate = system.today();
        system.debug('===todayDate=='+todayDate);
        integer thisYear = todayDate.year()-1;
        system.debug('thisYear ' +thisYear);
        list<user> userAllList = new list<user>();
        
        string opQuery = 'SELECT Id, Name,Account.Name, CloseDate, StageName,Amount,OwnerId,Owner.Name  FROM Opportunity where id!=null ';
        if(uId!=null && uId != 'All'){
            for(User usr : [Select id,Name from User]){
                userAllList.add(usr);
            }
            opQuery+= ' AND OwnerId =:uId ';
            //  opWrap.singleUser = [select id , name from user where id =: uid];
            // for(User usr : [select id, name from user where id !=: uId]){
            //    userAllList.add(usr);
            //}
        } else{
            for(User usr : [Select id,Name from User]){
                userAllList.add(usr);
            }
            opQuery+= ' AND OwnerId in : userAllList ';
            // opWrap.singleUser = new user();
        }
        if(mnthId!=0 ){
            date updateDate=date.newinstance(thisYear,mnthId,1);
            date previousDate= updateDate.addmonths(1);
            system.debug('==updateDate=='+updateDate);
            opQuery+= ' AND CloseDate >=:updateDate AND CloseDate <:previousDate';
        }
        // system.debug('=opQuery=='+Database.query(opQuery));
        list<Opportunity> opList = Database.query(opQuery);
        system.debug('==opList='+opList);
        
        opWrap.allGetUser = userAllList;
        opWrap.allOppData =opList;
        return opWrap;
    }
    
    /*  @auraEnabled
public static string fetchOpportunity(Integer pageSize, Integer pageNumber, String sortingField, Boolean isSortAsc){
Integer offset = (pageNumber - 1) * pageSize;
Integer totalRecords = [SELECT COUNT() FROM Opportunity];
Integer recordEnd = pageSize * pageNumber;
String jsonDT = '';
String sortBy = isSortAsc ? 'ASC' : 'DESC';

String query = 'SELECT Id, Name, Account.Name, CloseDate, StageName,Amount,Owner.Name  FROM Opportunity ORDER BY ';
query += sortingField + ' ' + sortBy;
query += ' LIMIT :pageSize OFFSET :offset';

wrapperClass wrap1 = new wrapperClass(); 

list<user> userAllList = new list<user>();
for(User usr : [Select id,Name from User]){
userAllList.add(usr);
}
wrap1.allGetUser = userAllList;
wrap1.pageSize = pageSize;
wrap1.pageNumber = pageNumber;
wrap1.recordStart = offset + 1;
wrap1.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
wrap1.totalRecords = totalRecords;
wrap1.opplist = Database.query(query);

jsonDT = JSON.serialize(wrap1);
// system.debug('==='+wrap1.initJsonDT);
return jsonDT;

}*/
    @auraEnabled
    public static opportunity EditOpportunity(string opId){
        
        opportunity op= new opportunity();
        if(opId!=null){
            list <opportunity> opplist =  [select id,Account.name,Name,CloseDate,StageName,Amount FROM Opportunity where id =:opId];
            if(opplist.size()>0){
                op = opplist[0];
            }else{
                op = new opportunity();
            }
        }
        return op;
    }
    @auraEnabled
    public static void UpdateOpportunity(Opportunity opp, string opid){
        if(opid!=null){
            opp.id = opid;
        }
        update opp;
    }
    
    @auraEnabled
    public static Opportunity deleteOppRec(string deleteoppRecId){
        system.debug('--deleteoppRecId--'+deleteoppRecId);
        
        Opportunity deleteopt =[select id,StageName,amount from opportunity where id=:deleteoppRecId];
        /*   if(deleteopt.StageName != 'Closed Won' && deleteopt.Amount == 0){
system.debug('----');
delete deleteopt;
}*/
        return deleteopt;
    }
    @auraEnabled
    public static void deleteRec(string deleteoppRecId){
        system.debug('--deleteoppRecId--'+deleteoppRecId);
        
        Opportunity deleteopt =[select id,StageName,amount from opportunity where id=:deleteoppRecId];
        delete deleteopt;
        
        // return deleteopt;
    }
    /*   public class opportunityLineItemWrap{
@AuraEnabled public string userName {get;set;}
@AuraEnabled public integer totalLineItem {get;set;}
@AuraEnabled public string opportunityId {get;set;}
@AuraEnabled public string opportunityName {get;set;}
@AuraEnabled public date closeDate {get;set;}
@AuraEnabled public decimal Amount {get;set;}
@AuraEnabled public string StageName {get;set;}

}
@AuraEnabled
public static list<opportunityLineItemWrap> getOppLine(string usId, integer mnId){
String query = 'SELECT Name,Opportunity.id, Opportunity.Name, Opportunity.Account.Name, Opportunity.CloseDate, Opportunity.StageName,Opportunity.Amount,Opportunity.Owner.Name FROM OpportunityLineItem';
map<string,opportunityLineItemWrap> oplnItmMap = new map<string,opportunityLineItemWrap>();
opportunityLineItemWrap opplineItem = new opportunityLineItemWrap();

for(OpportunityLineItem os: Database.query(query)){
if(oplnItmMap.containsKey(os.Opportunity.Id)){
opplineItem.totalLineItem += 1;
oplnItmMap.put(os.Opportunity.Id,opplineItem);
}
else{
opplineItem = new opportunityLineItemWrap();
opplineItem.opportunityId =os.Opportunity.Id;
opplineItem.totalLineItem= 1;
opplineItem.closeDate=os.Opportunity.CloseDate;
opplineItem.opportunityName=os.Opportunity.Name;
opplineItem.Amount=os.Opportunity.Amount;
opplineItem.StageName=os.Opportunity.StageName;
opplineItem.userName =os.Opportunity.Owner.Name;
oplnItmMap.put(os.Opportunity.Id,opplineItem);
}
}
return oplnItmMap.Values();
}*/
    
    /*  @auraEnabled
public static list<opportunityWrap> showOpp(){
opportunityWrap opShowWrap = new opportunityWrap();
map <string,opportunityWrap> oppIdMap= new map<string,opportunityWrap>();
list<Opportunity> opSList = [SELECT Id, Name,Account.Name, CloseDate, StageName,Amount,Owner.Name  FROM Opportunity where StageName='Closed Won' ];

for(opportunity opp :opSList){
opShowWrap.userName = opp.Owner.Name;
opShowWrap.accountName = opp.Account.Name;
opShowWrap.opportunityId = opp.Id;
opShowWrap.opportunityName = opp.Name;
opShowWrap.closeDate = opp.closeDate;
opShowWrap.Amount = opp.Amount;
opShowWrap.StageName = opp.StageName;
oppIdMap.put(opp.id,opShowWrap);
}

system.debug('oppIdMap== '+oppIdMap);
system.debug('accountName== '+opShowWrap.accountName);
system.debug('opportunityId== '+opShowWrap.opportunityId);
system.debug('closeDate== '+opShowWrap.closeDate);
system.debug('Amount== '+opShowWrap.Amount);

return oppIdMap.values();

}*/
}