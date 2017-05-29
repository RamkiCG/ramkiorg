public class DynamicComponentExample
 {
    public DynamicComponentExample(ApexPages.StandardController con) { }
    
    
    public Component.Apex.PageBlock getDynamicForm() {
    Component.Apex.PageBlock dynPageBlock = new Component.Apex.PageBlock();

    // Create an input field for Account Name
    Component.Apex.InputField theNameField = new Component.Apex.InputField();
    theNameField.expressions.value = '{!Account.Name}';
    theNameField.id = 'theName';
    Component.Apex.OutputLabel theNameLabel = new Component.Apex.OutputLabel();
    theNameLabel.value = 'Rename Account?';
    theNameLabel.for = 'theName';
    
    // Create an input field for Account Number
    Component.Apex.InputField theAccountNumberField = new Component.Apex.InputField();
    theAccountNumberField.expressions.value = '{!Account.AccountNumber}';
    theAccountNumberField.id = 'theAccountNumber';
    Component.Apex.OutputLabel theAccountNumberLabel = new Component.Apex.OutputLabel();
    theAccountNumberLabel.value = 'Change Account #?';
    theAccountNumberLabel.for = 'theAccountNumber';
    
    // Create a button to submit the form
    Component.Apex.CommandButton saveButton = new Component.Apex.CommandButton();
    saveButton.value = 'Save';
    saveButton.expressions.action = '{!Save}';
    
    // Assemble the form components
    dynPageBlock.childComponents.add(theNameLabel);
    dynPageBlock.childComponents.add(theNameField);
    dynPageBlock.childComponents.add(theAccountNumberLabel);
    dynPageBlock.childComponents.add(theAccountNumberField);
    dynPageBlock.childComponents.add(saveButton);
    
    return dynPageBlock;
}
    
    public Component.Apex.SectionHeader getHeaderWithDueDateCheck() {
        date dueDate = date.newInstance(2011, 7, 4);
        boolean overdue = date.today().daysBetween(dueDate) < 0;

        Component.Apex.SectionHeader sectionHeader = new Component.Apex.SectionHeader();
        if (overdue) {
            sectionHeader.title = 'This Form Was Due On ' + dueDate.format() + '!';
            return sectionHeader;
        } else {
            sectionHeader.title = 'Form Submission';
            return sectionHeader;
        }
    }
}