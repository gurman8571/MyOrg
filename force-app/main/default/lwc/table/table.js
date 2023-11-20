import { LightningElement,api,wire ,track} from 'lwc';
import PICKLIST_VALUES from '@salesforce/apex/ObjectNamesRetriever.getPicklistFeildValues'
import OBJECT_INFO from '@salesforce/apex/ObjectNamesRetriever.getFieldDescribeInfo'
import {CurrentPageReference} from 'lightning/navigation';
import updateRecord from '@salesforce/apex/ObjectNamesRetriever.updateRecord'
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import FetchRecord2 from '@salesforce/apex/ObjectNamesRetriever.FetchRecord2'
import { NavigationMixin } from 'lightning/navigation';
import modal from '@salesforce/resourceUrl/modal';
import { loadStyle} from 'lightning/platformResourceLoader';
export default class Table extends NavigationMixin(LightningElement) {

   @api selectedobject;
   @api templatename;
   @api recordid;
   @api recordId;
   Isedit =false;
   response;
   error;
   showSpinner=true;

   @track objectinfo;
   @track objectfeilds;
   @api keyvaluepair=[];

   @track PicklistValuesMap;



   @wire(CurrentPageReference)
   getStateParameters(currentPageReference) {
       if (currentPageReference) {
           this.recordId = currentPageReference.state.recordId;
       }
   }

 
   connectedCallback() {
    Promise.all([
        loadStyle(this, modal)
    ])

    if (this.recordId === undefined && this.recordid !== undefined ) {
        console.log('no id given');
        this.recordId=this.recordid;
        this.Isedit=false;
    }
    else{
        this.Isedit=true;
    }
  if (this.recordId !== undefined) {
    FetchRecord2 ({recordId:this.recordId}).then((res)=>{
        this.showSpinner=false;
        console.log('res----->'+res[0].Source_feild_mapping__c);
          this.selectedobject=res[0].Source_Object__c;
          this.templatename=res[0].Name;
       let data=JSON.parse(res[0].Source_feild_mapping__c);
       console.log(data);
          data.forEach((element,idx) => {
 
            this.keyvaluepair.push({
                id:idx,
                sPossibleKey:element.sPossibleKey,
                sObjectName:element.sObjectName,
                sDataType:element.sDataType, 
                sFieldAPIName:element.sFieldAPIName,
                sPicklistValue:element.sPicklistValue,
                isParent: element.isParent,
                linkRecord: element.linkRecord,
            })
            idx++;
        })
       
    })
  }
   }
   @wire(PICKLIST_VALUES, { SelectedObject: '$selectedobject' }) PicklistValues({ error, data }) {
    if (data) {
        this.PicklistValuesMap = JSON.parse(data);
    } else if (error) {
       this.error='An unexpected error occurred: ' + error.body.message;
    }


}


@wire(OBJECT_INFO, { SelectedObject: '$selectedobject' }) Objfeilds({ error, data }) {
    if (data) { 
        console.log('Here is iut '+ JSON.stringify(data));
        this.objectfeilds = data;
        this.objectinfo= data.map(item => ({
            label: `${item.fieldLabel}(${item.fieldName})`,
            value: item.fieldName
        }));

    } else if (error) {
        this.error= 'An unexpected error occurred: ' + error.body.message;
    }

}
handleClick(event){
    this.keyvaluepair.forEach((obj)=>{
        delete obj.id;
    })
    updateRecord({ recordId:this.recordId,newValue:JSON.stringify(this.keyvaluepair)}).then((res)=>{
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: res,
                variant: 'success'
            })
        );
        this.dispatchEvent(new CustomEvent('close'));
        

    }) .catch(error => {
        this.error='An unexpected error occurred: ' + error.body.message;
        console.warn(error);
    })
 
        
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                actionName: 'view'
            }
        });
    
}
handleData(event) {

     console.log(JSON.stringify(event.detail));
     const index = this.keyvaluepair.findIndex(obj => obj.id === event.detail.id);
   
     if (index !== -1) {
        this.keyvaluepair[index]=event.detail;
        
    } 
}
handleDelete(event){


this.keyvaluepair.filter((obj) => obj.id !== event.detail);
}
}