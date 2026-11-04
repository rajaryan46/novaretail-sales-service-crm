@RestResource(urlMapping='/novaretail/v1/cases')
global with sharing class NovaRetailCaseApi {
    @HttpGet
    global static void getCase() {
        RestResponse response = RestContext.response;
        response.addHeader('Content-Type', 'application/json');

        String caseNumber = RestContext.request.params.get('caseNumber');
        if (String.isBlank(caseNumber)) {
            writeError(400, 'caseNumber is required');
            return;
        }

        try {
            List<Case> matches = [
                SELECT Id, CaseNumber, Subject, Status, Priority, Origin, Owner.Name
                FROM Case
                WHERE CaseNumber = :caseNumber
                WITH USER_MODE
                LIMIT 1
            ];

            if (matches.isEmpty()) {
                writeError(404, 'Case not found');
                return;
            }

            Case record = matches[0];
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(JSON.serialize(new Map<String, Object>{
                'id' => record.Id,
                'caseNumber' => record.CaseNumber,
                'subject' => record.Subject,
                'status' => record.Status,
                'priority' => record.Priority,
                'origin' => record.Origin,
                'ownerName' => record.Owner.Name
            }));
        } catch (QueryException ex) {
            writeError(403, 'Insufficient access to the requested Case data');
        }
    }

    private static void writeError(Integer statusCode, String message) {
        RestContext.response.statusCode = statusCode;
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(
            new Map<String, Object>{ 'error' => message }
        ));
    }
}
