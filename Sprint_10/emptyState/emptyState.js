import { LightningElement, api } from 'lwc';

export default class EmptyState extends LightningElement {

    @api title = 'No Data Available';

    @api message = 'There is no information to display.';
}