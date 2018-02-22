@isTest
private class LeadTriggerTest {

    /**
     * When a lead is inserted, the `TriggerService` instance should have
     * processed `LeadAssignWorkflow`
     */
    @isTest
    private static void processLeadAssignWorkflowOnInsert() {

        // Given
        TriggerService.putInstance(
                Schema.SObjectType.Lead.getName(),
                new TriggerService());

        TriggerService leadTrigger =
                TriggerService.getInstance(Schema.SObjectType.Lead.getName());

        System.assertEquals(
                null,
                leadTrigger.getWorkflow(LeadAssignWorkflow.class),
                'workflow should not yet be processed');

        // When
        Test.startTest();

        insert new Lead(
                FirstName = 'Bugs',
                LastName = 'Bunny (TEST)',
                Company = 'Acme Corporation (TEST)');

        // Then
        Test.stopTest();

        System.assertNotEquals(
                null,
                leadTrigger.getWorkflow(LeadAssignWorkflow.class),
                'workflow should have been processed');
    }
}
