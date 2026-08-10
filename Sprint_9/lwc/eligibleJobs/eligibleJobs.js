import { LightningElement, wire } from 'lwc';
import getEligibleJobs from '@salesforce/apex/EligibleJobsController.getEligibleJobs';
import applyForJob from '@salesforce/apex/EligibleJobsController.applyForJob';

export default class EligibleJobs extends LightningElement {

    jobs = [];

    studentId = 'REPLACE_WITH_STUDENT_ID';

    message = '';
    errorMessage = '';
    applyingJobId = null;

    @wire(getEligibleJobs)
    wiredJobs({ data, error }) {
        if (data) {
            this.jobs = data;
        } else if (error) {
            console.error('Error loading jobs:', error);
            this.errorMessage = 'Unable to load jobs.';
        }
    }

    handleApply(event) {

        const jobId = event.detail.jobId;

        this.message = '';
        this.errorMessage = '';
        this.applyingJobId = jobId;

        applyForJob({
            studentId: this.studentId,
            jobId: jobId
        })
            .then(result => {
                this.message = result;
            })
            .catch(error => {
                console.error('Application error:', error);

                if (error.body && error.body.message) {
                    this.errorMessage = error.body.message;
                } else {
                    this.errorMessage =
                        'Something went wrong while applying.';
                }
            })
            .finally(() => {
                this.applyingJobId = null;
            });
    }
}
