public with sharing class EditPlanSave
{
    ApexPages.StandardController standardController;
    public EditPlanSave(ApexPages.StandardController controller)
    {
       standardController=controller;
    }
    public pagereference save()
    {
        standardController.save(); 
        return new pagereference(page.CommissionPlanPage.getUrl());
    }
}