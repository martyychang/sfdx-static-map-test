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
                (TriggerService)Test.createStub(
                        TriggerService.class, new TriggerServiceStub()));

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

    private class TriggerServiceStub implements StubProvider {

        private Set<String> workflowNameSet;

        public TriggerServiceStub() {
            this.workflowNameSet = new Set<String>();
        }

        public Object getWorkflow(Type workflowType) {
            return this.workflowNameSet.contains(workflowType.getName())
                    ? workflowType.getName()
                    : null;
        }

        public void process(List<Type> workflowTypes) {
            for(Type eachType : workflowTypes) {
                this.workflowNameSet.add(eachType.getName());
            }
        }

        public Boolean hasProcessed(Type workflowType) {
            return this.workflowNameSet.contains(workflowType.getName());
        }

        public Object handleMethodCall(
                Object stubbedObject, String stubbedMethodName,
                System.Type returnType, List<System.Type> listOfParamTypes,
                List<String> listOfParamNames, List<Object> listOfArgs) {

            // Initialize return value
            Object returnValue = null;

            if (stubbedMethodName.equals('process')) {
                this.process((List<Type>)listOfArgs[0]);
            }
            else if (stubbedMethodName.equals('getWorkflow')) {
                returnValue = getWorkflow((Type)listOfArgs[0]);
            }

            // Return a value
            return returnValue;
        }
    }
}
