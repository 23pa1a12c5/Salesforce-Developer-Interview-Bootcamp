import { LightningElement } from 'lwc';

export default class StudentPortal extends LightningElement {


    handleProfileSaved(event) {

        console.log(
            'Profile saved:',
            event.detail.studentId
        );


        const eligibleJobs =
            this.template.querySelector(
                'c-eligible-jobs'
            );


        if (eligibleJobs) {

            eligibleJobs.refreshJobs();

        }

    }

}