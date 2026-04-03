@IsTest
public with sharing class CollectionGetFirstValue_RecordsTest {

    @IsTest
    static void testGetFirstValue_VariousCases() {
        Account aInserted = new Account(Name = 'Inserted Account');
        insert aInserted;

        Account aNotInserted = new Account(Name = 'Uninserted Account');

        // Request 1: first record has Name (not inserted) -> should return its Name
        CollectionGetFirstValue_Records.Request req1 = new CollectionGetFirstValue_Records.Request();
        req1.records = new List<SObject>{ aNotInserted };
        req1.fieldApiName = 'Name';

        // Request 2: empty records list -> should return null
        CollectionGetFirstValue_Records.Request req2 = new CollectionGetFirstValue_Records.Request();
        req2.records = new List<SObject>();
        req2.fieldApiName = 'Name';

        // Request 3: Id field on inserted record -> should return the Id as string
        CollectionGetFirstValue_Records.Request req3 = new CollectionGetFirstValue_Records.Request();
        req3.records = new List<SObject>{ aInserted };
        req3.fieldApiName = 'Id';

        List<CollectionGetFirstValue_Records.Request> requests = new List<CollectionGetFirstValue_Records.Request>{ req1, req2, req3 };

        Test.startTest();
        List<CollectionGetFirstValue_Records.Response> responses = CollectionGetFirstValue_Records.getFirstValue(requests);
        Test.stopTest();

        System.assertEquals(3, responses.size(), 'Should return a response for each request');
        System.assertEquals('Uninserted Account', responses[0].response, 'Name should be returned for first request');
        System.assertEquals(null, responses[1].response, 'Empty records list should yield null response');
        System.assertEquals(String.valueOf(aInserted.Id), responses[2].response, 'Id should be returned as string for inserted record');
    }

    @IsTest
    static void testGetFirstValue_InvalidFieldApiName() {
        Account a = new Account(Name = 'Test Account');

        CollectionGetFirstValue_Records.Request req = new CollectionGetFirstValue_Records.Request();
        req.records = new List<SObject>{ a };
        req.fieldApiName = 'NonExistentField__xyz';

        List<CollectionGetFirstValue_Records.Request> requests = new List<CollectionGetFirstValue_Records.Request>{ req };

        try {
            CollectionGetFirstValue_Records.getFirstValue(requests);
            System.assert(false, 'Expected IllegalArgumentException was not thrown for invalid field API name');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('NonExistentField__xyz'), 'Exception message should contain the invalid field name');
            System.assert(e.getMessage().contains('Account'), 'Exception message should contain the SObject type name');
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception type thrown: ' + e.getTypeName() + ' - ' + e.getMessage());
        }
    }

    @IsTest
    static void testGetFirstValue_NullRecordsField() {
        CollectionGetFirstValue_Records.Request req = new CollectionGetFirstValue_Records.Request();
        req.records = null;
        req.fieldApiName = 'Name';

        List<CollectionGetFirstValue_Records.Request> requests = new List<CollectionGetFirstValue_Records.Request>{ req };

        List<CollectionGetFirstValue_Records.Response> responses = CollectionGetFirstValue_Records.getFirstValue(requests);

        System.assertEquals(1, responses.size());
        System.assertEquals(null, responses[0].response, 'Null records should result in null response');
    }

}