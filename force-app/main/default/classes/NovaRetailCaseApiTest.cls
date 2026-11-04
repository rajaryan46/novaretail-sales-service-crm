@IsTest
private class NovaRetailCaseApiTest {
    @TestSetup
    static void makeData() {
        insert new Case(
            Subject = 'NovaRetail API Test',
            Status = 'New',
            Origin = 'Phone',
            Priority = 'Medium'
        );
    }

    private static void setupRequest(String caseNumber) {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/novaretail/v1/cases';
        request.httpMethod = 'GET';
        if (caseNumber != null) {
            request.params.put('caseNumber', caseNumber);
        }
        RestContext.request = request;
        RestContext.response = new RestResponse();
    }

    @IsTest
    static void returnsExistingCase() {
        Case expected = [SELECT CaseNumber FROM Case WHERE Subject = 'NovaRetail API Test' LIMIT 1];
        setupRequest(expected.CaseNumber);

        Test.startTest();
        NovaRetailCaseApi.getCase();
        Test.stopTest();

        System.assertEquals(200, RestContext.response.statusCode);
        Map<String, Object> body = (Map<String, Object>) JSON.deserializeUntyped(
            RestContext.response.responseBody.toString()
        );
        System.assertEquals(expected.CaseNumber, body.get('caseNumber'));
        System.assertEquals('NovaRetail API Test', body.get('subject'));
    }

    @IsTest
    static void requiresCaseNumber() {
        setupRequest(null);

        Test.startTest();
        NovaRetailCaseApi.getCase();
        Test.stopTest();

        System.assertEquals(400, RestContext.response.statusCode);
    }

    @IsTest
    static void returnsNotFound() {
        setupRequest('999999999');

        Test.startTest();
        NovaRetailCaseApi.getCase();
        Test.stopTest();

        System.assertEquals(404, RestContext.response.statusCode);
    }
}
