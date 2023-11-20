import { api, LightningElement } from 'lwc';

import { CloseActionScreenEvent } from 'lightning/actions';
import { getRecord } from 'lightning/uiRecordApi';

export default class LwcQuickAction extends LightningElement {

  

  

    _recordId;

    @api set recordId(value) {
        this._recordId = value;
    
        // do your thing right here with this.recordId / value
    }
    
    get recordId() {
        return this._recordId;
    }
    

    
    handeBtnClick(){

        console.log('Record id is ' + this.recordId);

    }
    closeAction() {

        this.dispatchEvent(new CloseActionScreenEvent());

    }

}