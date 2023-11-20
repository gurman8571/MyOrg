public class OpportunityTriggerHandler {
    public static void HandleAfterInsert(List<Opportunity>opp){
        System.debug('Entered ------> inside Insert');
        List<Contract>cont=new List<Contract>();
        for(Opportunity op :opp ){
            
            if(op.StageName == 'Closed Won'){
            Contract con =new Contract();
                con.status='DRAFT';
                con.AccountId=op.AccountId;
                con.StartDate=system.today();
                con.ContractTerm=12;
             cont.add(con);   
        }
        }
        Insert Cont;
    } 
      public static void HandleAfterUpdate(List<Opportunity>opp){
           System.debug('Entered ------> inside Update');
         List<Contract>contractList=[SELECT ID FROM Contract];
          List<Contract>contractListNew=new List<Contract>();
          for(Opportunity op :opp ){
              if(op.StageName == 'Closed Lost'){
                  for(Contract ctr :contractList ){
                      ctr.StartDate=system.today()+3;
                      contractListNew.add(ctr);
                  }
              }
          }
          update contractListNew;
    } 
}