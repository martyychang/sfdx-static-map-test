public with sharing class TriggerService {

    /**
     * Static map of service instances, keyed by the name of the `SObject`
     * serviced by the instance
     */
    private static Map<String, TriggerService> instanceMap =
            new Map<String, TriggerService>();
    
    public TriggerService() {
        /* do nothing */
    }
    
    /**
     * @param objectName
     *
     * @return the service instance that services the given object
     */
    public static TriggerService getInstance(String objectName) {
        if (!instanceMap.containsKey(objectName)) {
            instanceMap.put(objectName, new TriggerService());
        }

        TriggerService instance = instanceMap.get(objectName);
        return instance;
    }

    /**
     * This is just something that a `StubProvider` can handle
     */
    public Object getWorkflow(Type workflowType) {
        return null;
    }

    /**
     * This is just something that a `StubProvider` can handle
     */
    public void process(List<Type> workflowTypes) {
        /* do nothing */
    }

    /**
     * Use this method to put an explicit instance into the cache,
     * primarily to enable the use of mocks in Apex tests
     *
     * @param name
     *
     * @param instance
     */
    public static void putInstance(String name, TriggerService instance) {
        instanceMap.put(name, instance);
    }
}
