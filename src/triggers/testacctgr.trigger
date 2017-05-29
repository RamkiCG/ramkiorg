trigger testacctgr on Account (after insert) 
{
system.debug(''+trigger.new);
system.debug(''+trigger.newmap);

}