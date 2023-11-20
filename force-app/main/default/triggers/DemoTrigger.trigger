trigger DemoTrigger on Account ( before insert , before update ) {

    if(trigger.isInsert || trigger.isUpdate ){
        for(Account ac :trigger.new){
            if(ac.Industry == 'Agriculture'){
                ac.Fax='100';
            }
        }
    }
        
    
    
}