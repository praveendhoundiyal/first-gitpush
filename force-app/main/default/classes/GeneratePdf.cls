public class GeneratePdf {
    @auraEnabled 
    public static list<OpportunityLineItem> fetchData(string accId){
        set<id> oppId = new set<id>();
        
        for(Opportunity opp : [select id,Account.Name, name,StageName from Opportunity where AccountId =:accId AND StageName='Closed Won' ]){
            oppId.add(opp.id);
        }
        list<OpportunityLineItem> oppLineItemList = [Select Id, name,Product2.Name,opportunity.Name,opportunity.account.name,opportunity.StageName From OpportunityLineItem where opportunityId =:oppId];
        if(oppLineItemList!=null && oppLineItemList.size()>0){
            return oppLineItemList;
        }else {
            return new list<OpportunityLineItem>();
        }
    }
    
    @auraEnabled
    public static void savePDFAccount(string acId){
        system.debug('===acId==='+acId);
        // Account acc = [Select Id, Name from Account where id =: acId];
        // PageReference pdfPage = new PageReference('/apex/TextVFPDF');
        //pdfPage.getParameters().put('Id',acc.id);
        // Blob pdfContent = pdfPage.getContent();
        Blob b = Blob.valueOf('Test Data');
        Attachment att= new Attachment();
        att.ParentId = acId;
        att.Name = 'Test Attachment for PDF';
        att.Body = b;
        // attach1.contentType = 'application/pdf';
        insert att;
        Attachment attach = [SELECT Id,OwnerId, Name, Body, ContentType, ParentId From Attachment where Id =: att.Id];
        
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; 
        conVer.PathOnClient = attach.Name; 
        conVer.Title = attach.Name; 
        conVer.VersionData = b;
        conVer.Origin = 'H';
        conVer.OwnerId = attach.OwnerId;
        conVer.Title = attach.Name;
        insert conVer;  
        system.debug('conVer ' +conVer);
        
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        ContentDocumentLink conDocLink = New ContentDocumentLink();
        conDocLink.LinkedEntityId = acId; 
        conDocLink.ContentDocumentId = conDoc; 
        conDocLink.shareType = 'V';
        conDocLink.Visibility = 'AllUsers';
        insert conDocLink;
        system.debug('conDocLink ' +conDocLink);
    }
   
}