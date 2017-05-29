public class ExpenseController 
{
@AuraEnabled
public static List<Expense__c> getExpenses() 
{
return [SELECT id, name, ramki__amount__c, ramki__client__c, ramki__date__c,
ramki__reimbursed__c, createdDate FROM ramki__Expense__c];
}
}