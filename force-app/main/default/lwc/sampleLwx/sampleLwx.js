import { LightningElement, track, wire,api } from 'lwc';
import OBJECT_LIST from '@salesforce/apex/ObjectNamesRetriever.getAllObjectNames'
import CreateDocumentInsight from '@salesforce/apex/ObjectNamesRetriever.CreateDocumentInsight'
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class SampleLwx extends LightningElement {

    Step1_complete = false;
    SelectedObject;
    Templatename;
    file;
    error;
    formdata;
   ContendDocumentId;
   @api recordid;
    
    @track objects;
    @track isShowModal = true;
    @track fileContent;
    
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
    handleFileChange(event) {
        const uploadedFile = event.detail.files[0];
            var documentId  = uploadedFile.documentId; 
            this.ContendDocumentId=documentId
    }
    /*******************************************Gettter methods*************************************************** */
    get acceptedFormats() {
        return ['.pdf'];
    }
    SelectObject(event) {
        this.SelectedObject = event.target.value;
    }
  
    handleClick(event) {
        if (event.target.dataset.id === "Step1") {
            if (this.Templatename.length != null && this.SelectObject !== null  && this.fileContent !==null) {
              
                CreateDocumentInsight({objectName:this.SelectedObject,TemplateName:this.Templatename,fileContent:this.ContendDocumentId})
                .then(result => {

                       
                    this.recordid=result;
                    console.log(this.recordid);
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Document Insight template successfully created',
                            variant: 'success'
                        })
                    );
                    this.dispatchEvent(new CustomEvent('close'));
                    
                    this.Step1_complete = true;


                })
                .catch(error => {
                    this.error='An unexpected error occurred: ' + error.body.message;
                    console.warn(error);
                })
                
            }
            else{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Please Fill the required feilds',
                        variant: 'error'
                    })
                );
                this.dispatchEvent(new CustomEvent('close'));
            }

        }
       
    }
    setTemplateName(event) {
        this.Templatename = event.target.value;
    }

}