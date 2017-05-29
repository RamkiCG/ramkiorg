public with sharing class XMLCasePopupController 
{

    public PageReference endCaseCreation() {
        return null;
    }


 
  public List<Case> results{get;set;} // search results
  public string searchString{get;set;} // search keyword
  public string caseId{get;set;}
  public Boolean ShowCase{get;set;}
  public Case ChosenCase{get;set;}
  public Id IdChosen{get;set;}
 
  public XMLCasePopupController() {
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    caseId = System.currentPageReference().getParameters().get('id');
    //ShowCase=False;
    System.debug('==> searchString = ' + searchString + ' -- caseid ' + caseId);
  //  runSearch(); 
  }

  // performs the keyword search
  public PageReference search() {
 //   runSearch();
 
    return null;
  }

  // performs the keyword search
  public void ShowCaseToTrue() {
    this.ShowCase=True;
    system.debug('El id que tengo que buscar es: '+ IdChosen);
    ChosenCase=[SELECT Id,CaseNumber FROM Case WHERE Id=:IdChosen];
  }
}