trigger ContractTrigger on Contract (after update) {

    
    if(trigger.isAfter){
        
        if(trigger.isUpdate){
           ContractTriggerHandler.HandleAfterUpdate();
        }
    }
}