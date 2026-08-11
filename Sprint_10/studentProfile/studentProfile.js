import { LightningElement, api } from 'lwc';

import getStudent
    from '@salesforce/apex/StudentProfileController.getStudent';

import updateStudent
    from '@salesforce/apex/StudentProfileController.updateStudent';

export default class StudentProfile extends LightningElement {

    @api studentId = 'a05NS000014JigrYAC';

    name = '';
    studentIdValue = '';
    phone = '';
    email = '';
    department = '';
    cgpa = '';
    skills = '';
    preferredLocation = '';
    status = '';

    message = '';
    errorMessage = '';

    isLoading = true;
    isSaving = false;

    connectedCallback() {
        this.loadStudent();
    }

    loadStudent() {

        this.isLoading = true;
        this.errorMessage = '';

        getStudent({
            studentId: this.studentId
        })
            .then(result => {

                this.name = result.Name || '';
                this.studentIdValue = result.Student_ID__c || '';
                this.phone = result.Phone__c || '';
                this.email = result.Email__c || '';
                this.department = result.Department__c || '';
                this.cgpa = result.CGPA__c ?? '';
                this.skills = result.Skills__c || '';
                this.preferredLocation =
                    result.Preferred_Location__c || '';
                this.status = result.Status__c || '';

                this.isLoading = false;
            })
            .catch(error => {

                console.error(
                    'Error loading student:',
                    error
                );

                this.errorMessage =
                    error?.body?.message ||
                    'Unable to load student profile.';

                this.isLoading = false;
            });
    }

    handleChange(event) {

        const field = event.target.name;

        this[field] = event.target.value;

        this.message = '';
        this.errorMessage = '';
    }

    handleSave() {

        this.message = '';
        this.errorMessage = '';

        if (!this.validateForm()) {
            return;
        }

        this.isSaving = true;

        updateStudent({

            studentId: this.studentId,

            studentName: this.name,

            studentIdValue: this.studentIdValue,

            phone: this.phone,

            email: this.email,

            department: this.department,

            cgpa: Number(this.cgpa),

            skills: this.skills,

            preferredLocation: this.preferredLocation,

            status: this.status
        })
            .then(() => {

                this.message =
                    'Student profile updated successfully.';

                this.isSaving = false;

                /*
                 * Tell parent component that
                 * Student record was updated.
                 */
                this.dispatchEvent(
                    new CustomEvent(
                        'profilesaved',
                        {
                            detail: {
                                studentId: this.studentId
                            }
                        }
                    )
                );

                /*
                 * Reload profile values.
                 */
                this.loadStudent();
            })
            .catch(error => {

                console.error(
                    'Error updating student:',
                    error
                );

                this.errorMessage =
                    error?.body?.message ||
                    'We could not update your profile.';

                this.isSaving = false;
            });
    }

    validateForm() {

        const inputs =
            this.template.querySelectorAll(
                'lightning-input, lightning-combobox'
            );

        let valid = true;

        inputs.forEach(input => {

            if (!input.reportValidity()) {
                valid = false;
            }
        });

        if (
            this.cgpa !== '' &&
            (
                Number(this.cgpa) < 0 ||
                Number(this.cgpa) > 10
            )
        ) {

            this.errorMessage =
                'CGPA must be between 0 and 10.';

            valid = false;
        }

        return valid;
    }

    get departmentOptions() {

        return [
            {
                label: 'IT',
                value: 'IT'
            },
            {
                label: 'CSE',
                value: 'CSE'
            },
            {
                label: 'ECE',
                value: 'ECE'
            },
            {
                label: 'EEE',
                value: 'EEE'
            },
            {
                label: 'MECH',
                value: 'MECH'
            },
            {
                label: 'CIVIL',
                value: 'CIVIL'
            }
        ];
    }

    get locationOptions() {

        return [
            {
                label: 'Bangalore',
                value: 'Bangalore'
            },
            {
                label: 'Hyderabad',
                value: 'Hyderabad'
            },
            {
                label: 'Chennai',
                value: 'Chennai'
            },
            {
                label: 'Pune',
                value: 'Pune'
            },
            {
                label: 'Mumbai',
                value: 'Mumbai'
            },
            {
                label: 'Any Location',
                value: 'Any Location'
            }
        ];
    }

    get statusOptions() {

        return [
            {
                label: 'Placed',
                value: 'Placed'
            },
            {
                label: 'Looking for Placement',
                value: 'Looking for Placement'
            },
            {
                label: 'Not Interested',
                value: 'Not Interested'
            }
        ];
    }
}