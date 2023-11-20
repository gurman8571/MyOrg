// childComponent.js
import { LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    items = ['Item 1', 'Item 2', 'Item 3'];

    handleItemModification() {
        // Make changes to the items array
        this.items.push('New Item');

        // Dispatch an event to send the modified array to the parent
        const itemChangeEvent = new CustomEvent('itemchange', {
            detail: this.items
        });
        this.dispatchEvent(itemChangeEvent);
    }
}