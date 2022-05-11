public class FileAttachment {
    @AuraEnabled 
    public static List<ContentVersion> fetchContentDocument(Id recordId){
        system.debug('recordId=='+recordId);
        //List<Attachment> attachMent =  [SELECT  id, Name, ParentId FROM Attachment Where ParentId =: recordId];
        Set<Id> cdIds = new Set<Id>();
        /*ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = '0062w000002NO8AAAW';
        cdl.LinkedEntityId = recordId;
        cdl.ShareType = 'V';
        cdl.Visibility = 'AllUsers';
        insert cdl;*/
        for(ContentDocumentLink  cl : [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId = :recordId]){
            cdIds.add(cl.ContentDocumentId);
            system.debug('cl=='+cl);
            system.debug('cdIds=='+cdIds);
        }       
        //list<ContentDocument> attachMent = new list<ContentDocument>([SELECT  id, Title, ContentSize FROM ContentDocument Where Id In :cdIds]); 
        list<ContentVersion> attachMent = new list<ContentVersion>([SELECT  id FROM ContentVersion Where ContentDocumentId In :cdIds]); 
        system.debug('attachMent===='+attachMent);
        system.debug('attachMent'+attachMent);
        return attachMent;
    }
    @AuraEnabled
    public static string DownloadAttachment(String recordId)
    {
        system.debug('recordId====in'+recordId);
        ContentVersion oldCV = [Select Id,Title from ContentVersion Where Id = :recordId and IsLatest = true ];
        System.Debug('Old LV INitial :'+ oldCV.Id);
        String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
        String URlDownload = fullFileURL+'/sfc/servlet.shepherd/version/download/'+oldCV.Id;
        system.debug('Download URL:' +URlDownload);
        return URlDownload;
    }    
}
/*
* Set<Id> cdIds = new Set<Id>();
for(ContentDocumentLink  cl : [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: recordId]){
    cdIds.add(cl.ContentDocumentId);
    system.debug('cl=='+cl);
    system.debug('cdIds=='+cdIds);
}
//list<ContentDocument> attachMent = new list<ContentDocument>([SELECT  id, Title, ContentSize FROM ContentDocument Where Id In :cdIds]); 
list<ContentDocument> attachMent = new list<ContentDocument>([SELECT  id, Title, ContentSize FROM ContentDocument Where ContentDocumentId In :cdIds]); 
system.debug('attachMent===='+attachMent);
*/