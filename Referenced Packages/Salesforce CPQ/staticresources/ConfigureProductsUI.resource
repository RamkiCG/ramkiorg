function ConfigurePage() {
	this.optionLookupDlg = null;
	this.configureOptionDlg = null;
	this.products = new Array();
	this.summaryDisplayed = false;
	this.calculateStatusDlg = null;
	this.deleteStatusDlg = null;
	this.calculateMessage = 'Calculating...';
	this.deleteMessage = 'Deleting...';
	ConfigurePage.INSTANCE = this;
}

ConfigurePage.INSTANCE = null;

ConfigurePage.getInstance = function() {
	return ConfigurePage.INSTANCE;
}

ConfigurePage.prototype.addConfiguredProduct = function(/*String*/ data) {
	this.products.push(this.deserializeProduct(data));
}

ConfigurePage.prototype.deserializeProduct = function(/*Object*/ productObj) {
	if (productObj == null) {
		return;
	}
	var product = new ConfiguredProduct(productObj.values);
	product.optionSelectionAdd = productObj.optionSelectionAdd;
	product.optionSelectionClick = productObj.optionSelectionClick;
	product.level = productObj.level;
	product.customValidated = productObj.customValidated;
	for (var f=0;f<productObj.features.length;f++) {
		var featureObj = productObj.features[f];
		var feature = new ProductFeature(product, featureObj.id, featureObj.values);
		for (var o=0;o<productObj.features[f].options.length;o++) {
			var optionObj = productObj.features[f].options[o];
			var option = new ProductOption(product, optionObj.id, optionObj.record, this.deserializeProduct(optionObj.product));
			option.quantity = optionObj.quantity;
			option.required = optionObj.required;
			option.bundled = optionObj.bundled;
			option.featureId = optionObj.featureId;
			feature.addOption(option);
		}
		product.addFeature(feature);
	}
	return product;
}


ConfigurePage.prototype.getLastAjaxError = function() {
	var el = document.getElementById('lastAjaxError');
	if (el != null) {
		return el.value;
	}
	return '';
}

ConfigurePage.prototype.isLastAjaxRequestSuccess = function() {
	var el = document.getElementById('lastAjaxResult');
	if (el != null) {
		var val = el.value;
		if ((val != null) && (val == 'true')) {
			return true;
		}
	}
	return false;
}

ConfigurePage.prototype.onBeforeDOMUpdate = function() {
	ConfigurePage.getInstance().clearSelectedOptions();
}

ConfigurePage.prototype.onRender = function() {
	/* for (var pi=0;pi<this.products.length;pi++) {
		var product = this.products[pi];
		for (var fi=0;fi<product.features.length;fi++) {
			var feature = product.features[fi];
			var table = new OptionTable(this.optionColumns, feature.selections).render('feature_' + feature.id);
			this.optionTableIndex[feature.id] = table;
		}
	}*/
}

ConfigurePage.prototype.getConfigureOptionDialog = function() {
	if (this.configureOptionDlg == null) {
		this.configureOptionDlg = new ConfigureOptionDialog(this, 'Configure Option');
		this.configureOptionDlg.register();
	}
	return this.configureOptionDlg;
}

ConfigurePage.prototype.getOptionLookupDialog = function() {
	if (this.optionLookupDlg == null) {
		this.optionLookupDlg = new OptionLookupDialog(this, 'Add Option');
		this.optionLookupDlg.register();
	}
	return this.optionLookupDlg;
}

ConfigurePage.prototype.getCalculateStatusDialog = function() {
	if (this.calculateStatusDlg == null) {
		this.calculateStatusDlg = new OverlayStatusDialog('Calculate', this.calculateMessage);
		this.calculateStatusDlg.register();
	}
	return this.calculateStatusDlg;
}

ConfigurePage.prototype.getDeleteStatusDialog = function() {
	if (this.deleteStatusDlg == null) {
		this.deleteStatusDlg = new OverlayStatusDialog('Delete', this.deleteMessage);
		this.deleteStatusDlg.register();
	}
	return this.deleteStatusDlg;
}

ConfigurePage.prototype.onConfigureOption = function(/*Map*/ variables) {
	var selectionId = variables.selectionId;
	var productId = variables.productId;
	this.getConfigureOptionDialog().setTitle(variables.dialogTitle);
	this.getConfigureOptionDialog().onLoad(selectionId, productId);
}

ConfigurePage.prototype.onLookupOption = function(/*Map*/ variables) {
	var featureId = variables.featureId;
	var productId = variables.productId;
	this.getOptionLookupDialog().setTitle(variables.dialogTitle);
	this.getOptionLookupDialog().onLoad(productId, featureId);
}

ConfigurePage.prototype.onCloneOption = function(/*String*/ selectionId, /*String*/ productId, /*String*/ optionId) {
}

ConfigurePage.prototype.onDeleteOption = function(/*String*/ selectionId, /*String*/ productId, /*String*/ optionId) {
	deleteOption(selectionId, productId, optionId);
}

ConfigurePage.prototype.onPreviousFeature = function(/*String*/ featureKeys) {
	this.getConfigureOptionDialog().onPreviousFeature(featureKeys);
}

ConfigurePage.prototype.onNextFeature = function(/*String*/ featureKeys) {
	this.getConfigureOptionDialog().onNextFeature(featureKeys);
}

ConfigurePage.prototype.onOptionQuantityChanged = function(/*Element*/ field, /*String*/ selectionId) {
}

ConfigurePage.prototype.onOptionSelectionChanged = function(/*Element*/ field, /*String*/ selectionId) {
	var wrapper = document.getElementById('option:configureWrapper:' + selectionId);
	if (wrapper != null) {
		wrapper.style.visibility = field.checked ? 'visible' : 'hidden';
	}
	wrapper = document.getElementById('option:quantity:' + selectionId);
	if ((wrapper != null) && (wrapper.firstChild != null)) {
		wrapper.firstChild.disabled = field.checked ? false : true;
	}
}

ConfigurePage.prototype.onCalculateStart = function() {
	try {
	this.getCalculateStatusDialog().show();
	} catch (e) {
		alert('Err:' + e);
	}
}

ConfigurePage.prototype.onCalculateEnd = function() {
	this.getCalculateStatusDialog().hide();
}

ConfigurePage.prototype.onDeleteStart = function() {
	this.getDeleteStatusDialog().show();
}

ConfigurePage.prototype.onDeleteEnd = function() {
	this.getDeleteStatusDialog().hide();
}

ConfigurePage.prototype.clearConfigurationFormValidationMessage = function() {
	document.getElementById('configurationFormValidationMessage').style.display = 'none';
}


function OptionLookupDialog(/*ConfigurePage*/ page, /*String*/ title) {
	this.page = page;
    this.id = 'OptionLookupDialog';
    this.isModal = true;
    this.width = '910px';
    this.height = '600px';
    this.title = title;
    this.buttons = [];
    this.addEvents();
    this.contentWrapper;
    this.waitPanel;
    this.contentCreated = false;
}

OptionLookupDialog.prototype = new OverlayDialog();

OptionLookupDialog.prototype.createContent = function() {
    var content = document.getElementById(this.getContentId());
    var html = [];
    this.createButtons(html);
    this.waitPanel = document.createElement("div");
    new StatusPanel(this.waitPanel, 'Working...');
    content.appendChild(this.waitPanel);
    this.contentWrapper = document.createElement("div");
    var optionLookupContainer = document.getElementById('optionLookupContainer');
    optionLookupContainer.style.display = 'block';
    this.contentWrapper.appendChild(optionLookupContainer);
    content.appendChild(this.contentWrapper);
    this.contentCreated = true;
}

OptionLookupDialog.prototype.activate = function() {
	this.waitPanel.style.display = 'none';
	this.contentWrapper.style.display = 'block';
}

OptionLookupDialog.prototype.deactivate = function() {
	this.waitPanel.style.display = 'block';
	this.contentWrapper.style.display = 'none';
}

OptionLookupDialog.prototype.onLoad = function(/*String*/ productId, /*String*/ featureId) {
	this.show();
	this.waitPanel.style.display = 'block';
	this.contentWrapper.style.display = 'none';
	loadOptionLookup(productId, featureId);
}

OptionLookupDialog.prototype.onLoaded = function() {
	if (this.page.getLastAjaxError() != '') {
		alert('Error: ' + this.page.getLastAjaxError());
	}
	this.waitPanel.style.display = 'none';
	this.contentWrapper.style.display = 'block';
	this.position();
}

OptionLookupDialog.prototype.onSave = function(/*String*/ productId) {
	var productId = document.getElementById('optionLookupProductId');
	var selectors = document.getElementsByName('optionSelector');
	var optionIds = new Array();
	for (var i=0;i<selectors.length;i++) {
		if (selectors[i].checked) {
			optionIds.push(selectors[i].id);
		}
	}
	this.deactivate();
	addOption(productId.value, optionIds.join(','));
}

OptionLookupDialog.prototype.onSaved = function() {
	if (!this.page.isLastAjaxRequestSuccess()) {
		this.activate();
		return;
	}
	this.hide();
}

OptionLookupDialog.prototype.onCancel = function() {
	this.hide();
}

OptionLookupDialog.prototype.register = function() {
    sfdcPage.registerDialog(this);
    if (!this.contentCreated) {
    	this.createDialog();
    }
}



function ConfigureOptionDialog(/*ConfigurePage*/ page, /*String*/ title) {
	this.page = page;
    this.id = 'ConfigureOptionDialog';
    this.isModal = true;
    this.width = '910px';
    this.height = '600px';
    this.title = title;
    this.contentWrapper;
    this.waitPanel;
    this.configuredProductStack = new Array();
    this.activeFeatureId;
    this.contentCreated = false;
    this.configFormVisited;
}

ConfigureOptionDialog.prototype = new OverlayDialog();

ConfigureOptionDialog.prototype.createContent = function() {
    var content = document.getElementById(this.getContentId());
    var html = [];
    this.createButtons(html);
    this.waitPanel = document.createElement("div");
    new StatusPanel(this.waitPanel, 'Working...');
    content.appendChild(this.waitPanel);
    this.contentWrapper = document.createElement("div");
    content.appendChild(this.contentWrapper);
    this.contentCreated = true;
}

ConfigureOptionDialog.prototype.activate = function() {
	this.configFormVisited = false;
	this.activeFeatureId = null;
	this.waitPanel.style.display = 'none';
	var configureOptionContainer = document.getElementById('configureOptionContainer');
	configureOptionContainer.style.display = 'block';
    this.contentWrapper.appendChild(configureOptionContainer);
    this.position();
}

ConfigureOptionDialog.prototype.deactivate = function() {
	var configureOptionWrapper = document.getElementById('configureOptionWrapper');
	var configureOptionContainer = document.getElementById('configureOptionContainer');
    configureOptionContainer.style.display = 'none';
    configureOptionWrapper.appendChild(configureOptionContainer);
    this.waitPanel.style.display = 'block';
}

ConfigureOptionDialog.prototype.onLoad = function(/*String*/ selectionId, /*String*/ productId) {
	if (this.configuredProductStack.length == 0) {
		// Configuring first level nested bundle.
		this.show();
	} else {
		// Configuring second or lower level bundle. Dialog is already up.
		this.deactivate();
	}
	this.configuredProductStack.push({selectionId:selectionId,productId:productId});
	configureOption(selectionId, productId);
}

ConfigureOptionDialog.prototype.onLoaded = function() {
	/* var title = document.getElementById('configureOptionDialogTitle');
	if ((title != null) && (title.value != null)) {
		this.setTitle(title.value);
	} */
	this.activate();
	this.show();
}

ConfigureOptionDialog.prototype.onSave = function() {
	additionalInfo = '';
	var iframe = document.getElementById('customConfigurationPageCRM');
	if(iframe == null) {
		iframe = document.getElementById('customConfigurationPageSites');
	}
	if(iframe == null) {
		iframe = document.getElementById('customConfigurationPageWizard');
	}
	if (iframe != null) {
		var iframeField = iframe.contentWindow.document.getElementById('iframeEncodedAdditionalInfo');
		if (iframeField != null) {
			additionalInfo = iframeField.value;
		}
	}
		
	var currentConfig = this.configuredProductStack[this.configuredProductStack.length-1];
	if (this.validateConfigurationForm(currentConfig.productId)) {
		// Deactivation moves content back into its original place so it's included in form submit
		this.deactivate();
		// Kick off the AJAX request
		saveOptionConfiguration(currentConfig.selectionId, currentConfig.productId, additionalInfo);
	}
}

ConfigureOptionDialog.prototype.onSaved = function() {
	if (!this.page.isLastAjaxRequestSuccess()) {
		this.activate();
		return;
	}
	this.cleanUp();
}

ConfigureOptionDialog.prototype.validateConfigurationForm = function(/*String*/ configuredProductId) {
	var iframe = document.getElementById('customConfigurationPageCRM');
	if(iframe == null) {
		iframe = document.getElementById('customConfigurationPageSites');
	}
	if(iframe == null) {
		iframe = document.getElementById('customConfigurationPageWizard');
	}
	var valid = true;
	if (iframe != null) {
		var validated = iframe.contentWindow.document.getElementById('validated');
		var submitted = iframe.contentWindow.document.getElementById('submitted');
		if ((validated == null) || (validated.value != 1)) {
			valid = false;
		} else if (this.configFormVisited) {
			// Since there is no way to know if previously validated config form has been changed
			// we force re-validation whenever form is visited (ie: displayed).
			if ((submitted == null) || (submitted.value != 1)) {
				valid = false;
			}
		}
	} else {
		var inputs = document.getElementsByName('configFieldRequired:' + configuredProductId);
		for (var i=0;i<inputs.length;i++) {
			var fieldName = inputs[i].id.split(':')[2];
			if (inputs[i].value.toLowerCase() == 'true') {
				var field = document.getElementById('configField:' + configuredProductId + ':' + fieldName).firstChild;
				var msg = document.getElementById('configFieldMsg:' + configuredProductId + ':' + fieldName);
				if (field.tagName == 'INPUT') {
					if (field.value.trim() == '') {
						msg.style.display = 'block';
						valid = false;
					} else {
						msg.style.display = 'none';
					}
				} else if (field.tagName == 'SELECT') {
					if (field.options[field.selectedIndex].value.trim() == '') {
						msg.style.display = 'block';
						vaid = false;
					} else {
						msg.style.display = 'none';
					}
				}
			}
		}
	}
	if (valid) {
		document.getElementById('configurationFormValidationMessage').style.display = 'none';
	} else {
		document.getElementById('configurationFormValidationMessage').style.display = 'block';
	}
	return valid;
}

/**
 * Override OvrlayDialog.cancel to properly handle cleanup.
 */
ConfigureOptionDialog.prototype.cancel = function() {
	//OverlayDialog.prototype.cancel.call(this);
	this.onCancel();
}
ConfigureOptionDialog.prototype.onCancel = function() {
	this.deactivate();
	this.cleanUp();
}

ConfigureOptionDialog.prototype.cleanUp = function() {	
	// Remove currently configured option off the stack
	if (this.configuredProductStack.length > 0) {
		this.configuredProductStack.pop();
		
		// See if there is another option being configured.
		if (this.configuredProductStack.length > 0) {
			var state = this.configuredProductStack.pop();
			var productId = state.productId;
			var selectionId = state.selectionId;
			this.onLoad(selectionId, productId);
		} else {
			this.hide();
		}
	}
}

ConfigureOptionDialog.prototype.onActivateFeature = function(/*String*/ featureId) {
	var featureTitle = null;
	var featureContent = null;
	if (this.activeFeatureId != null) {
		this.deactivateFeature(this.activeFeatureId);
	}
	this.activateFeature(featureId);
	this.activeFeatureId = featureId;
}

ConfigureOptionDialog.prototype.deactivateFeature = function(/*String*/ featureId) {
	featureTitle = Ext.Element.get('feature:title:' + featureId);
	if (featureTitle != null) {
		// Remove active style class
		featureTitle.removeClass('active');
	}
	featureContent = Ext.Element.get('feature:content:' + featureId);
	if (featureContent != null) {
		// Hide feature content
		featureContent.dom.style.display = 'none';
	}
}

ConfigureOptionDialog.prototype.activateFeature = function(/*String*/ featureId) {
	featureTitle = Ext.Element.get('feature:title:' + featureId);
	if (featureTitle != null) {
		// Add active style class
		featureTitle.addClass('active');
	}
	featureContent = Ext.Element.get('feature:content:' + featureId);
	if (featureContent != null) {
		// Show feature content
		featureContent.dom.style.display = 'block';
		if (featureId == 'configurationForm') {
			this.configFormVisited = true;
		}
	}
}

ConfigureOptionDialog.prototype.onSwitchTab = function(/*String*/ featureKeys, /*String*/ selectedFeatureId) {
	var keys = featureKeys.split(',');
	for (var i=0;i<keys.length;i++) {
		this.deactivateFeature(keys[i]);
	}
	this.deactivateFeature('feature:title:configurationForm');
	this.activateFeature(selectedFeatureId);
}

ConfigureOptionDialog.prototype.onPreviousFeature = function(/*String*/ featureKeys) {
	var keys = featureKeys.split(',');
	var idx = this.indexOf(keys,this.activeFeatureId);
	if ((idx == -1) || (idx < 1)) {
		// Shouldn't really happen; handle anyway
		return;
	}
	
	idx--;
	this.updateFeatureScrollButtons(idx == 0, false);
	this.onActivateFeature(keys[idx]);
}

ConfigureOptionDialog.prototype.onNextFeature = function(/*String*/ featureKeys) {
	var keys = featureKeys.split(',');
	var idx = 0;
	if (this.activeFeatureId == null) {
		this.activeFeatureId = keys[0];
	} else {
		idx = this.indexOf(keys,this.activeFeatureId);
		if ((idx == -1) || (idx >= (keys.length-1))) {
			// Shouldn't really happen; handle anyway
			return;
		}
	}
	
	idx++;
	this.updateFeatureScrollButtons(false, idx == (keys.length-1));
	this.onActivateFeature(keys[idx]);
}

ConfigureOptionDialog.prototype.updateFeatureScrollButtons = function(/*boolean*/ first, /*boolean*/ last) {
	var prevBtn = document.getElementById('feature:wizard:button:prev');
	if (prevBtn != null) {
		prevBtn.style.visibility = (first) ? 'hidden' : 'visible';
	}
	var nextBtn = document.getElementById('feature:wizard:button:next');
	if (nextBtn != null) {
		nextBtn.style.visibility = (last) ? 'hidden' : 'visible';
	}
}

ConfigureOptionDialog.prototype.indexOf = function(collection,value) {
	for (var i=0;i<collection.length;i++) {
		if (collection[i] == value) {
			return i;
		}
	}
	return -1;
}

ConfigureOptionDialog.prototype.register = function() {
    sfdcPage.registerDialog(this);
    if (!this.contentCreated) {
    	this.createDialog();
    }
}