trigger SecurityTrigger on Account (after insert,after update) {
    if(trigger.isafter && trigger.isinsert){
    	SecurityTriggerHandler.filldescription(trigger.new);
    }
    if(trigger.isafter && trigger.isupdate){
    	SecurityTriggerHandler.filldescription(trigger.new);
    }

}