import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class sample extends NavigationMixin(LightningElement) {
    handleNavigate() {
        const pageReference = {
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'New_Document_Insight_Template' // Replace with the API name of your tab
            }
        };

        // Navigate to the Lightning tab
        this[NavigationMixin.Navigate](pageReference);
    }
}