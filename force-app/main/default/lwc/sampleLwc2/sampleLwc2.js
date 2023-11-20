import { LightningElement, track, wire } from 'lwc';
import OBJECT_LIST from '@salesforce/apex/ObjectNamesRetriever.getAllObjectNames'

export default class SampleLwc2 extends LightningElement {

    Step1_complete = false;
    SelectedObject;
    Templatename;

    @track objects;
    @track isShowModal = false;
   


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
    /*******************************************Gettter methods*************************************************** */
    get acceptedFormats() {
        return ['.pdf', '.png'];
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
            console.log(JSON.stringify(this.KeyValuePair));
            this.Step1_complete = false;
            this.isShowModal = false;
        }
    }
    setTemplateName(event) {
        this.Templatename = event.target.value;
    }

}