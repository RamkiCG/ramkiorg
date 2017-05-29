public class apifoldercreation
{
    
    public void foldercreate()
    {
        soapSforceCom200604MyMetadata.MetadataPort service = new soapSforceCom200604MyMetadata.MetadataPort();
service.SessionHeader = new soapSforceCom200604MyMetadata.SessionHeader_element();
service.SessionHeader.sessionId = UserInfo.getSessionId();

soapSforceCom200604MyMetadata.Folder customFolder = new soapSforceCom200604MyMetadata.Folder();
soapSforceCom200604MyMetadata.FolderShare[] customFolderShare = new soapSforceCom200604MyMetadata.FolderShare[2];	
customFolderShare[0]=new soapSforceCom200604MyMetadata.FolderShare();
customFolderShare[0].accessLevel='View';
customFolderShare[0].sharedToType='Role';
customFolderShare[0].sharedTo='CEO';

customFolder.type='DashboardFolder';
customFolder.AccessType ='Public'; 
customFolder.Name='ramki12345'; 
customFolder.fullname='report12345'; 
customFolder.publicFolderAccess = 'ReadWrite';  
customFolder.folderShares=customFolderShare;
soapSforceCom200604MyMetadata.AsyncResult[] results = service.create(new List<soapSforceCom200604MyMetadata.Metadata> { customFolder });
system.debug('results'+results[0].id);
	


    }

}