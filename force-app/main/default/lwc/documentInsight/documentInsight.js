import { LightningElement, track, wire } from 'lwc';
import OBJECT_LIST from '@salesforce/apex/ObjectNamesRetriever.getAllObjectNames'
import OBJECT_INFO from '@salesforce/apex/ObjectNamesRetriever.getFieldDescribeInfo'
import getParentDescribeInfo from '@salesforce/apex/ObjectNamesRetriever.getParentDescribeInfo'
import RESP from '@salesforce/apex/ObjectNamesRetriever.getApiResposne'
import PICKLIST_VALUES from '@salesforce/apex/ObjectNamesRetriever.getPicklistFeildValues'
import getParentPicklistFeildValues from '@salesforce/apex/ObjectNamesRetriever.getParentPicklistFeildValues';
import getFieldType from '@salesforce/apex/ObjectNamesRetriever.getFieldType';


export default class DocumentInsight extends LightningElement {

    Step1_complete = false;
    condition1 = false;
    SelectedObject;
    ObjectInfo;
    ObjectFeilds;
    ParentFeilds;
    ParentObjectInfo;
    Parentdtype;
    Templatename;
    disableFieldPicklist = true;
    resposnse;
    modifiedData;
    PicklistValuesMap;
    a;
    options2 = [
        { label: 'New', value: 'new' },
        { label: 'In Progress', value: 'inProgress' },
        { label: 'Finished', value: 'finished' },
    ];
    @track FinalResponse = [];
    @track objects;
    @track KeyValuePair = [];
    @track isShowModal = false;
    @track Parent;
    @track Object;
    @track SelectedParent;

    /************************************************ Wire Decorators *************************************** */
    @wire(OBJECT_LIST) ObjList({ error, data }) {
        if (data) {
            this.objects = data.map(item => ({
                label: item,
                value: item
            }));
        } else if (error) {
            console.error(error);
        }

    }
    @wire(OBJECT_INFO, { SelectedObject: '$SelectedObject' }) Objfeilds({ error, data }) {
        if (data) {
            this.ObjectFeilds = data;
            this.ObjectInfo = data.map(item => ({
                label: item.fieldName,
                value: item.fieldName
            }));

        } else if (error) {
            console.error(error);
        }

    }
    @wire(RESP) data({ error, data }) {
        if (data) {
            this.resposnse = JSON.parse(data);
            let idx = 1;
            for (const key in this.resposnse) {
                this.KeyValuePair.push({
                    id: idx,
                    key: key,
                    UniqueId1: `Picklist2${key}`,
                    Parent1Id: `Parent1${key}`,
                    Parent2Id: `Parent2${key}`,
                    Parent3Id: `Parent3${key}`,


                });
                idx++;
            }
        } else if (error) {
            console.error(error);
        }

    }
    @wire(PICKLIST_VALUES, { SelectedObject: '$SelectedObject' }) PicklistValues({ error, data }) {
        if (data) {
            this.PicklistValuesMap = JSON.parse(data);
        } else if (error) {
            console.error(error);
        }

    }
    /******************************************* Gettter methods     *******8******************************************** */
    get acceptedFormats() {
        return ['.pdf', '.png'];
    }
    get options() {
        return [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }

    /**********************************************  Modal Functions ***************************************** */
    showModalBox() {
        this.isShowModal = true;
    }

    hideModalBox() {
        this.isShowModal = false;
    }


    /**********************************************  Onchange  Functions ***************************************** */

    SelectObject(event) {
        this.SelectedObject = event.target.value;
    }
    handleFileChange(event) {
        const selectedFile = event.target.files[0]; // Get the first selected file
        console.log('Selected File: ', selectedFile);

    }
    handleClick(event) {
        if (event.target.dataset.id === "Step1") {
            if (this.Templatename.length != null && this.SelectObject !== null) {
                this.Step1_complete = true;
            }
        }
        if (event.target.dataset.id === "Step2") {
            console.log(JSON.stringify(this.FinalResponse));
            this.Step1_complete = false;
            this.isShowModal = false;

        }

    }
    ChangePicklistFeild(event) {
        const key = event.target.dataset.id;
        this.EditFinalResponse(key, event.target.value, "sPicklistValue")
    }

    SelectMappingFeild(event) {
         console.log(event.target.value);
        const result = this.ObjectFeilds.filter((word) => word.fieldName == event.target.value);
        const object = {
            "sPossibleKey": event.target.dataset.id,
            "sObjectName": this.SelectedObject,
            "sDataType": result[0].fieldType,
            "sFieldAPIName": event.target.value,
            "sPicklistValue":"",
            "isParent": false,
            "linkRecord": false
        }

        if (this.ObjectFeilds.length > 0) {
            const index = this.FinalResponse.findIndex(obj => obj.sPossibleKey === object.sPossibleKey);
            if (index !== -1) {
                this.FinalResponse[index] = object;
            }
            else {
                this.FinalResponse.push(object);
            }

        }
        // FILLING THE  DATA TYPE VALUE

        let dtype = this.template.querySelector('#' + event.target.dataset.id + "-123");
        dtype.innerHTML = result[0].fieldType;
        console.log('type-'+result[0].fieldType);

        // SELECTING THE PICKLIST FROM DOM  
        let picklist = this.template.querySelector('.' + event.target.dataset.id);
        
         // IF DATA TYPE IS PICKLIST ENABLE SELECTING VALUE FEILD AND FILL IN THE OPTIONS
        if (result[0].fieldType === "PICKLIST") {

            picklist.disabled = false;
            
            picklist.options = this.PicklistValuesMap[event.target.value].map(item => ({
                label: item,
                value: item
            }));
        }
        else  {
            picklist.disabled = true;
            picklist.value='';
      
        }
        // FETCHING PARENT FEILDS FROM DOM
        let Parent1 = this.template.querySelector('#Parent1' + event.target.dataset.id + "-123");
        let Parent2 = this.template.querySelector('#Parent2' + event.target.dataset.id + "-123");
        let Parent3 = this.template.querySelector('#Parent3' + event.target.dataset.id + "-123");

        if (result[0].fieldType !== "REFERENCE") {
         let picklist = Parent1.querySelector('.custom-combobox-label');
         picklist.disabled=true;
         picklist.value='';
         picklist.style.display="none";
         Parent2.innerHTML='';
        let picklist2 = Parent3.querySelector('.' + event.target.dataset.id);
         picklist2.disabled=true;
         picklist2.value='';
         picklist2.style.display="none";

        } else {
            this.EditFinalResponse(object.sPossibleKey, event.target.value, "sObjectName")
            this.EditFinalResponse(object.sPossibleKey, true, "isParent")
            this.SelectedParent = 'School__c';
            let picklist = Parent1.querySelector('.custom-combobox-label');
            picklist.disabled=false;
            picklist.style.display="block";
            getParentDescribeInfo({ SelectedObject: 'School__c' })
                .then(result => {
                    let options = result.map(item => ({
                        label: item.fieldName,
                        value: item.fieldName
                    }));
                    picklist.options = options;
                })
                .catch(error => {
                    console.warn(error);
                })

        }
    }
    setTemplateName(event) {
        this.Templatename = event.target.value;
    }
    ChangeParentFeild(event) {

       
        let dtype = this.template.querySelector('#Parent2' + event.target.dataset.id + "-123");
        let Parent = this.template.querySelector('#Parent3' + event.target.dataset.id + "-123");
        let picklist = Parent.querySelector('.' + event.target.dataset.id);
        let feildname=event.target.dataset.id;
         

        this.EditFinalResponse(event.target.dataset.id, event.target.value, "sFieldAPIName")

        getFieldType({ objectName: 'School__c', fieldName: event.target.value })
            .then(result => {
                dtype.innerHTML = result;
                const res = result;

                if (res.toLowerCase() == 'PICKLIST'.toLowerCase()) {
                    picklist.disabled = false;
                    picklist.style.display="block";

                }
                else {
                    picklist.disabled = true;
                    picklist.value='';
                    picklist.style.display="";

                }
                this.EditFinalResponse(feildname, result, "sDataType");


            })
            .catch(error => {
                console.warn(error);
            })
        console.log(this.Parentdtype);
    }

    handleTermsChange(event) {
        if (event.target.dataset.id === "condition1") {
            this.condition1 = !this.condition1;
        }

    }

    /****************************************  Final response Functions *********************************************** */

    EditFinalResponse(key, value, feild) {
        const index = this.FinalResponse.findIndex(obj => obj.sPossibleKey === key);
        if (index !== -1) {
            if (this.FinalResponse[index].hasOwnProperty(feild)) {
                this.FinalResponse[index][feild] = value;
            }

        }
    }


}