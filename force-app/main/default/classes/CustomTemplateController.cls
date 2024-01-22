public class CustomTemplateController{
  public string quoteId {get; set;}
  public string templateId {get; set;}
  public List<SBQQ__QuoteLine__c> lines {get; set;}
  public List<SBQQ__QuoteLineConsumptionSchedule__c> linesWithConsumptionSchedules {get; set;}
  public List<SBQQ__QuoteLineConsumptionRate__c> consumptionRates {get; set;}
  public List<Id> lineIDsWithCS {get; set;}
  public SBQQ__QuoteTemplate__c template {get;set;}
  public boolean showConsumptionSchedule {get;set;}
  public CustomTemplateController(){
    quoteId = ApexPages.currentPage().getParameters().get('qid');
    templateId = ApexPages.currentPage().getParameters().get('tid');
    lineIDsWithCS = new List<Id>{};
    consumptionRates = new List<SBQQ__QuoteLineConsumptionRate__c>{};
    showConsumptionSchedule = false;
    this.populateTemplate();
    this.populateLineData();
    this.populateCSData();
  }
  public void populateTemplate(){
    template = [SELECT Id, SBQQ__FontFamily__c, SBQQ__FontSize__c, SBQQ__ShadingColor__c FROM SBQQ__QuoteTemplate__c WHERE Id = :templateId];
  }
  public void populateLineData(){
    lines = [SELECT Id, SBQQ__HasConsumptionSchedule__c FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c = :quoteId ORDER BY SBQQ__Number__c ASC];
    for(SBQQ__QuoteLine__c line : lines){
      if(line.SBQQ__HasConsumptionSchedule__c){
        lineIDsWithCS.add(line.Id);
        showConsumptionSchedule = TRUE;
      }
    }
  }
  public void populateCSData(){
    linesWithConsumptionSchedules = [SELECT Id, SBQQ__QuoteLine__r.SBQQ__ProductName__c, Name, SBQQ__UnitOfMeasure__c, (SELECT Id, SBQQ__LowerBound__c, SBQQ__UpperBound__c, SBQQ__Price__c, SBQQ__QuoteLineConsumptionSchedule__r.SBQQ__QuoteLine__c FROM SBQQ__QuoteLineConsumptionRates__r ORDER BY SBQQ__ProcessingOrder__c) FROM SBQQ__QuoteLineConsumptionSchedule__c WHERE SBQQ__QuoteLine__r.Id IN :lineIDsWithCS];
    for(SBQQ__QuoteLineConsumptionSchedule__c schedule : linesWithConsumptionSchedules){
      for(SBQQ__QuoteLineConsumptionRate__c rate : schedule.SBQQ__QuoteLineConsumptionRates__r){
        consumptionRates.add(rate);
      }
    }
  }
}