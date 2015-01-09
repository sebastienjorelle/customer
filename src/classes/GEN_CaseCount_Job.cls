global class GEN_CaseCount_Job implements Schedulable {
   global void execute(SchedulableContext SC) {
      GEN_CaseBatchtoCountCreatedcases obj = new GEN_CaseBatchtoCountCreatedcases();
      dataBase.executeBatch(obj);
   }
}