trigger OpportunityTrigger on Opportunity (after insert,after update) {

  
        if(trigger.isInsert){
         System.debug('Entered ------> inside Insert Trigger');
         OpportunityTriggerHandler.HandleAfterInsert(trigger.new);  
        }
        if(trigger.isUpdate){
            System.debug('Entered ------> inside update Trigger');
            OpportunityTriggerHandler.HandleAfterUpdate(trigger.new);  
        }
    
}