@isTest
private class TriggerServiceTest {

    @isTest
    private static void getInstance() {
        TriggerService instance =
                TriggerService.getInstance(Schema.SObjectType.Lead.getName());

        System.assertNotEquals(null, instance);
    }
}
