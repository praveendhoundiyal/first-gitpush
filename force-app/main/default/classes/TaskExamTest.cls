@isTest
private class TaskExamTest {
    @isTest static void testTaskPriority() {
        String pri = TaskExam.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
    
     @isTest static void testTaskHighPriority() {
        String pri = TaskExam.getTaskPriority('CA');
        System.assertEquals('High', pri);
    }
    
    @isTest static void testTaskPriorityInvalid() {
        String pri = TaskExam.getTaskPriority('Montana');
        System.assertEquals(null, pri);
    }
}