public with sharing class VehicleParentController {

    @AuraEnabled(cacheable=true)
    public static Vehicle__c getVehicle(Id recordId){

        return [
            SELECT Id,
                   Name,
                   Vehicle_Number__c,
                   Brand__c
            FROM Vehicle__c
            WHERE Id = :recordId
            LIMIT 1
        ];
    }

}