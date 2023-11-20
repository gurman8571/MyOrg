// parentComponent.js
import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {
    @track items = ['Item 1', 'Item 2', 'Item 3'];

    handleItemChange(event) {
        // Update the items array with the modified data received from the child
        this.items = event.detail;
    }
}