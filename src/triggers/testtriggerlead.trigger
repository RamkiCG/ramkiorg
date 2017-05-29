trigger testtriggerlead on Lead (before insert,before update) 
{

system.debug('test...trigger.new'+trigger.new);
system.debug('test...trigger.old'+trigger.old);

system.debug('test...trigger.newmap'+trigger.newmap);

system.debug('test...trigger.oldmap'+trigger.oldmap);


}