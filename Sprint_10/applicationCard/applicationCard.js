import { LightningElement, api } from 'lwc';

export default class ApplicationCard extends LightningElement {

    @api application;

    get jobName() {
        return this.application?.Job__r?.Name || 'Job';
    }

    get companyName() {
        return this.application?.Company_Name__c || 'N/A';
    }

    get minimumCgpa() {
        return this.application?.Minimum_CGPA__c ?? 'N/A';
    }

    get applicationDate() {
        return this.application?.Application_Date__c || 'N/A';
    }

    get status() {
        return this.application?.Status__c || 'N/A';
    }
}