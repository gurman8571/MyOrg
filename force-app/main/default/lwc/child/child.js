import { LightningElement ,api,track } from 'lwc';
import getFieldType from '@salesforce/apex/ObjectNamesRetriever.getFieldType';
import getPicklistFeildValues from '@salesforce/apex/ObjectNamesRetriever.getPicklistFeildValues'
import getReferenceObjectFields from '@salesforce/apex/ObjectNamesRetriever.getReferenceObjectFields'
import getReferencedObjectName from '@salesforce/apex/ObjectNamesRetriever.getReferencedObjectName'
export default class Child extends LightningElement {

    @api item ;
    @api parentfeilds;
    @api parentinfo;
    @api selectedobject;
    @api finalresp;
    
    
    SelectedParent;
    Keyname;
    error;
    options;
    parentfeild=null;
    ParentName;
    parentshowPicklist=false;
    showPicklist=false;
    isAlternate=false;
connectedCallback() {
    if (this.item.id % 2 === 1) {
   this.isAlternate=true;
    }
      if (this.item.isParent === true) {
        this.parentfeild=this.item.sObjectName;       
        getReferenceObjectFields({objectName:this.selectedobject,  fieldName:this.item.sObjectName})
        .then(result => {
            console.log(JSON.stringify(result));
              let options = result.map(item => ({
                label: `${item.fieldLabel}(${item.fieldName})`,
            value: item.fieldName
            }));
           this.options = options;
        })
        .catch(error => {
            this.error= 'An unexpected error occurred: ' + error.body.message;
        })
        
      }
      if (this.item.isParent === true  && this.item.sPicklistValue.length>0) {
       this.parentshowPicklist= true;
       getReferencedObjectName({objectName:this.selectedobject, fieldName:this.parentfeild})
       .then(result => {
       this.ParentName=result;
       getPicklistFeildValues({SelectedObject:this.ParentName ,fieldname:this.item.sFieldAPIName}).then((res)=>{
        let data=JSON.parse(res)
        data.forEach(element => {
         console.log(element);
        });
         let options = data.map(item => ({
             label: item,
             value: item
         }));
        this.options2 = options;

       })
       }) 
      
      }
      if (this.item.isParent === false  && this.item.sPicklistValue.length>0) {
        this.showPicklist= true;
        getPicklistFeildValues({SelectedObject: this.selectedobject ,fieldname:this.item.sFieldAPIName}).then((res)=>{
            let data=JSON.parse(res)
            data.forEach(element => {
             console.log(element);
            });
             let options = data.map(item => ({
                 label: item,
                 value: item
             }));
            this.options2 = options;
 
           })
      }
      if (this.item.sDataType === '' || this.item.sDataType === '') {
       
 
      }
    }
@track isShowModal = false;
options2 = [];
showModalBox() {
        this.isShowModal = true;
    }

hideModalBox() {
        this.isShowModal = false;
    }
  
SelectMappingFeild(event) {
        const feild= event.target.value;
        
     
       // FILLING THE  DATA TYPE VALUE
       const result = this.parentinfo.filter((word) => word.fieldName == feild);        
       const updatedObject = { ...this.item};
       updatedObject.sFieldAPIName= event.target.value;
       updatedObject.sDataType= result[0].fieldType;
       
       this.item = updatedObject;
       this.dispatchEvent(new CustomEvent('updateparent',{
        detail:this.item
       }))
    
       

     if (result[0].fieldType === "PICKLIST" || result[0].fieldType === 'MULTIPICKLIST') {
        
         
          this.showPicklist = true;
   
          getPicklistFeildValues({SelectedObject: this.selectedobject ,fieldname:event.target.value}).then((res)=>{
           let data=JSON.parse(res)
           data.forEach(element => {
            console.log(element);
           });
            let options = data.map(item => ({
                label: item,
                value: item
            }));
           this.options2 = options;

          })

       }
       else  {
        this.showPicklist = false;

        const updatedObject = { ...this.item}; 
        updatedObject.sPicklistValue="",
        this.item = updatedObject;
        this.dispatchEvent(new CustomEvent('updateparent',{
            detail:this.item
           }))
       }
       if (result[0].fieldType !== "REFERENCE") {
        this.parentshowPicklist=false;

        const updatedObject = { ...this.item};
        updatedObject.isParent= false;
        updatedObject.sPicklistValue="";
        updatedObject.sObjectName=this.selectedobject;
        this.item = updatedObject;
      
        this.dispatchEvent(new CustomEvent('updateparent',{
            detail:this.item
           }))

       } else {
        this.parentshowPicklist=false;
        const updatedObject = { ...this.item};
        updatedObject.isParent= true;
        updatedObject.sDataType="";
        updatedObject.sObjectName=feild;
        updatedObject.sFieldAPIName="";
        updatedObject.sPicklistValue="",
        this.item = updatedObject;
        this.parentfeild=feild;

        this.dispatchEvent(new CustomEvent('updateparent',{
            detail:this.item
           }))
        
       getReferenceObjectFields({objectName:this.selectedobject,  fieldName:feild})
               .then(result => {
                   let options = result.map(item => ({
                    label: `${item.fieldLabel}(${item.fieldName})`,
                    value: item.fieldName
                   }));
                  this.options = options;
               })
               .catch(error => {
                this.error= 'An unexpected error occurred: ' + error.body.message;
               })
               getReferencedObjectName({objectName:this.selectedobject, fieldName:feild})
               .then(result => {
               
               this.ParentName=result;

               })
               .catch(error => {
                this.error= 'An unexpected error occurred: ' + error.body.message;
               })


       }
      
   }
ChangeParentFeild(event) {  
         let feildname=event.target.value;
          const updatedObject = { ...this.item};
            updatedObject.sFieldAPIName= feildname;
            this.item = updatedObject;
            this.dispatchEvent(new CustomEvent('updateparent',{
                detail:this.item
               }))

    //this.EditFinalResponse(event.target.dataset.id, event.target.value, "sFieldAPIName")
    getFieldType({   objectName:this.ParentName , fieldName: event.target.value })
        .then(result => {
    
            const res = result;
            console.log(res);
            const updatedObject = { ...this.item};
            updatedObject.sDataType= res;
            //updatedObject.sFieldAPIName= event.target.value;
            this.item = updatedObject;
            this.dispatchEvent(new CustomEvent('updateparent',{
                detail:this.item
               }))

            if (res.toLowerCase() == 'PICKLIST'.toLowerCase() || res.toLowerCase() == 'MULTIPICKLIST'.toLowerCase() ){
                this.parentshowPicklist= true;
                getPicklistFeildValues({SelectedObject:this.ParentName ,fieldname:feildname}).then((res)=>{
                    let data=JSON.parse(res)
                    data.forEach(element => {
                     console.log(element);
                    });
                     let options = data.map(item => ({
                         label: item,
                         value: item
                     }));
                    this.options2 = options;
         
                   })

            }
            else {
               this.parentshowPicklist=false;
                const updatedObject = { ...this.item};
                updatedObject.sPicklistValue="";
                this.item = updatedObject;  
                this.dispatchEvent(new CustomEvent('updateparent',{
                    detail:this.item
                   })) 

            }
            //this.EditFinalResponse(feildname, result, "sDataType");


        })
        .catch(error => {
            this.error= 'An unexpected error occurred: ' + error.body.message;
        })
    
}
AddKey(event){
console.log(event.target.dataset.id);

this.isShowModal = true;


}
updateParentObject(key,value){
    console.log('inside it'+key+'---->'+value);
     /*const updatedObject = { ...this.item};
     
    console.log(updatedObject);
 
    if (updatedObject.hasOwnProperty(key)) {
     console.log('inside if');
     updatedObject[key]= value;
 }
  
     this.item = updatedObject;    */
     
 }
ChangePicklistFeild(event) {
    //this.updateParentObject(sPicklistValue,event.target.value)
   const updatedObject = { ...this.item};
    updatedObject.sPicklistValue= event.target.value;
    this.item = updatedObject;
       
         
            this.dispatchEvent(new CustomEvent('updateparent',{
                detail:this.item
               }))
         

        
    
   
}
ConfirmDelete(){
    var result = confirm("Do You Want to delete this key?");
if (result) {
    console.log('clicked ');
    this.dispatchEvent(new CustomEvent('deletekey',{
        detail:this.item.key
       })) 
}
else{
return false;
}

}

handleClick(){
console.log('completed');
this.isShowModal = false;
const updatedObject = { ...this.item};
const ip =this.Keyname;
const op= ip.replace(/,/g, '~');
updatedObject.sPossibleKey=op;
this.item = updatedObject;
this.dispatchEvent(new CustomEvent('updateparent',{
    detail:this.item
   }))
}
ChangeKey(event){
  this.Keyname=event.target.value;
  console.log(this.Keyname);
}



}