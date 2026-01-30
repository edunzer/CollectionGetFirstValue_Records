public with sharing class CollectionGetFirstValue_Records {

    @InvocableMethod(label='Get First Field Value from Record Collection' description='Returns the first value of a specified field from a list of records.')
    public static List<Response> getFirstValue(List<Request> requests) {
        List<Response> results = new List<Response>();

        for (Request req : requests) {
            Response resp = new Response();

            if (req.records == null || req.records.isEmpty()) {
                resp.response = null;
                results.add(resp);
                continue;
            }

            SObject firstRecord = req.records[0];
            Object fieldValue = firstRecord.get(req.fieldApiName);

            resp.response = (fieldValue == null) ? null : String.valueOf(fieldValue);
            results.add(resp);
        }

        return results;
    }

    public class Request {
        @InvocableVariable(label='Records' description='List of records to search; the first record\'s field value will be returned.' required=true)
        public List<SObject> records;

        @InvocableVariable(label='Field API Name' description='The API name of the field to retrieve from the first record (e.g., Id or Name).' required=true)
        public String fieldApiName;
    }

    public class Response {
        @InvocableVariable(label='Response' description='Single text response containing the first field value')
        public String response;
    }
}
