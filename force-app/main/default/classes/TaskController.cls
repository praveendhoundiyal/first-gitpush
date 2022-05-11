public class TaskController {

    @AuraEnabled
    public static List<sobject> getTasks() {
        return [SELECT Subject, Priority, Status FROM Task]; 
    }
}