import { LightningElement, wire } from 'lwc';

import getMyApplications
    from '@salesforce/apex/EligibleJobsController.getMyApplications';

import { refreshApex } from '@salesforce/apex';

export default class MyApplications extends LightningElement {

    studentId = 'a05NS000014JigrYAC';

    applications = [];

    errorMessage = '';

    loading = true;

    wiredApplicationsResult;


    @wire(getMyApplications, {
        studentId: '$studentId'
    })
    wiredApplications(result) {

        this.wiredApplicationsResult = result;

        const { data, error } = result;

        if (data) {

            this.applications = data;

            this.errorMessage = '';

            this.loading = false;

        } else if (error) {

            console.error(
                'Error loading applications:',
                error
            );

            this.applications = [];

            this.errorMessage =
                error?.body?.message ||
                'Unable to load applications.';

            this.loading = false;
        }
    }


    get hasApplications() {

        return this.applications.length > 0;
    }


    get showEmptyState() {

        return !this.loading &&
               !this.errorMessage &&
               !this.hasApplications;
    }


    async handleRefresh() {

        this.loading = true;

        this.errorMessage = '';

        try {

            await refreshApex(
                this.wiredApplicationsResult
            );

        } catch (error) {

            console.error(
                'Refresh error:',
                error
            );

            this.errorMessage =
                error?.body?.message ||
                'Unable to refresh applications.';

        } finally {

            this.loading = false;
        }
    }
}