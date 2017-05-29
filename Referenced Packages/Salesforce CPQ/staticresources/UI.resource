function ControllerManager() {
	this.controllers = {};
}

ControllerManager.prototype.register = function(/*String*/ key, /*Object*/ controller) {
	this.controllers[key] = controller;
}

ControllerManager.prototype.lookup = function(/*String*/ key) {
	return this.controllers[key];
}

ControllerManager.prototype.activateController = function(/*Object*/ activeController) {
	angular.forEach(this.controllers, function(controller,key) {
		var changed = false;
		if (controller == activeController) {
			controller.scope.active = true;
			controller.scope.blockingOperationInProgress = false;
			// Run apply on active controller anyway because there may be other scope changes we want to take effect
			changed = true;
		} else {
			if (controller.scope.active == true) {
				controller.scope.active = false;
				changed = true;
			}
		}
		if (changed) {
			if (controller.scope.active == true) {

        // go to top of page like a "normal" page transition
        setTimeout( function() {
          window.scrollTo(0, 0);
          if( $ )
            $(window).resize();  // position dynamic page header if needed
        }, 50 );

				controller.onActivate();
			} else {
				controller.onDeactivate();
			}
			controller.executeApply();
		}
	}, this);
}



function Controller() {
	this.scope = null;
	this.statusProperties = ['blockingOperationInProgress'];
}

Controller.prototype.createErrorHandler = function() {
	var controller = this;
	return function(error) {
		if (console) {
			console.log('Error: ' + angular.toJson(error));
		}
		controller.scope.messages = [{'severity':'error','summary':error.message}];
		angular.forEach(controller.statusProperties, function(prop) {
			if (this.scope[prop]) {
				this.scope[prop] = false;
			}
		}, controller);
		controller.executeApply();
	};
}

Controller.prototype.onDeactivate = function() {
	this.scope.messages = null;
}

Controller.prototype.onActivate = function() {
}

Controller.prototype.executeApply = function(/*Function*/ fn) {
	if (fn == null) {
		fn = function() {};
	}
	(this.scope.$$phase || this.scope.$root.$$phase) ? fn() : this.scope.$apply(fn);
}

Controller.prototype.setErrors = function(/*String[]*/ errors) {
	this.scope.messages = [];
	angular.forEach(errors, function(error) {
		this.scope.messages.push({'severity':'error','summary':error});
	}, this);
}

Controller.prototype.handleError = function(/*Error*/ error) {
	this.scope.messages = [];
	this.scope.messages.push({'severity':'error','summary':error.message});
	if (console) {
		console.log(error.stack);
	}
}

Controller.prototype.setFollow = function(/*String*/ recordId, /*Boolean*/ followed) {
	if (this.scope.chatterService && followed) {
		this.scope.chatterService.follow(recordId);
	} else if (this.scope.chatterService && !followed) {
		this.scope.chatterService.unfollow(recordId);
	} else if (console) {
		console.log('Unable to follow ' + recordId + ' because no chatterService is found in current scope');
	}
}

Controller.prototype.onFollow = function(/*String*/ recordId) {
	if (this.scope.chatterService) {
		this.scope.chatterService.follow(recordId);
	} else if (console) {
		console.log('Unable to follow ' + recordId + ' because no chatterService is found in current scope');
	}
}

Controller.prototype.onUnfollow = function(/*String*/ recordId) {
	if (this.scope.chatterService) {
		this.scope.chatterService.unfollow(recordId);
	} else if (console) {
		console.log('Unable to unfollow ' + recordId + ' because no chatterService is found in current scope');
	}
}

Controller.prototype.isMobile = function() {
	return Controller.isMobileContext();
}

Controller.prototype.isPhoneGap = function() {
	return (typeof cordova != 'undefined');
}

Controller.prototype.isSalesforce1 = function() {
	return (typeof sforce != 'undefined') && (typeof sforce.one != 'undefined');
}

Controller.prototype.getCommunityPrefix = function() {
	var path = document.location.pathname;
	var idx = path.indexOf('/apex');
	if (idx < 0) {
		return '';
	}
	return path.substring(0, idx);
}

Controller.isMobileContext = function() {
	return ((typeof sforce != 'undefined') && (typeof sforce.one != 'undefined')) || (typeof cordova != 'undefined');
}

/**
 * Refocuses DOM element after remote transaction.
 */
Controller.prototype.refocus = function() {
	// TODO: Refactor to use scope broadcasting?
	if (this.scope.$root.focusedElementId != null) {
		var el = document.getElementById(this.scope.$root.focusedElementId);
		if (el != null) {
			el.focus();
		}
	}
}


function SelectionModel() {
	this.available = [];
	this.selected = [];
	this.indexByValue = {};
}

SelectionModel.prototype.addAvailable = function(/*Object*/ available) {
	this.available.push(available);
	this.indexByValue[available.value] = available;
}

SelectionModel.prototype.addSelected = function(/*Object*/ selected) {
	this.selected.push(selected);
	this.indexByValue[selected.value] = selected;
}

SelectionModel.prototype.getOption = function(/*Object*/ selected) {
	this.selected.push(selected);
	this.indexByValue[selected.value] = selected;
}

SelectionModel.prototype.getSelectedValues = function() {
	var result = [];
	angular.forEach(this.selected, function(option) {
		result.push(option.value);
	}, this);
	return result;
}

SelectionModel.prototype.selectMarked = function() {
	var opts = this.getMarkedOptions(this.available, this.markedAvailable, false);
	this.markedSelected = [];
	this.markedAvailable = [];
	angular.forEach(opts, function(opt) {
		var idx = this.available.indexOf(opt);
		this.available.splice(idx,1);
		this.addSelected(opt);
		this.markedSelected.push(opt.value);
	}, this);
}

SelectionModel.prototype.unselectMarked = function() {
	var opts = this.getMarkedOptions(this.selected, this.markedSelected, true);
	this.markedSelected = [];
	this.markedAvailable = [];
	angular.forEach(opts, function(opt) {
		var idx = this.selected.indexOf(opt);
		this.selected.splice(idx,1);
		this.addAvailable(opt);
		this.markedAvailable.push(opt.value);
	}, this);
}

SelectionModel.prototype.sortSelectedTop = function() {
	var opts = this.getMarkedOptions(this.selected, this.markedSelected, false);
	angular.forEach(opts, function(opt) {
		var idx = this.selected.indexOf(opt);
		if (idx > -1) {
			this.selected.splice(idx,1);
		}
	}, this);
	for (var i=opts.length-1;i>=0;i--) {
		this.selected.splice(0,0,opts[i]);
	}
}

SelectionModel.prototype.sortSelectedUp = function() {
	var opts = this.getMarkedOptions(this.selected, this.markedSelected, false);
	angular.forEach(opts, function(opt) {
		var idx = this.selected.indexOf(opt);
		if (idx > 0) {
			this.selected.splice(idx,1);
			this.selected.splice(idx - 1, 0, opt);
		}
	}, this);
}

SelectionModel.prototype.sortSelectedDown = function() {
	var opts = this.getMarkedOptions(this.selected, this.markedSelected, false);
	angular.forEach(opts, function(opt) {
		var idx = this.selected.indexOf(opt);
		if ((idx > -1) && (idx < (this.selected.length - 1))) {
			this.selected.splice(idx,1);
			this.selected.splice(idx + 1, 0, opt);
		}
	}, this);
}

SelectionModel.prototype.sortSelectedBottom = function() {
	var opts = this.getMarkedOptions(this.selected, this.markedSelected, false);
	angular.forEach(opts, function(opt) {
		var idx = this.selected.indexOf(opt);
		if (idx > -1) {
			this.selected.splice(idx,1);
			this.selected.push(opt);
		}
	}, this);
}

SelectionModel.prototype.getMarkedOptions = function(/*Option[]*/ options, /*String[]*/ values, /*Boolean*/ skipRequired) {
	var opts = [];
	angular.forEach(values, function(value) {
		var opt = this.indexByValue[value];
		if (opt != null) {
			if (!skipRequired || !opt.required) {
				opts.push(opt);
			}
		}
	}, this);
	return opts;
}

SelectionModel.prototype.isAvailableOptionMarked = function(/*Option*/ opt) {
	return (this.markedAvailable != null) && (this.markedAvailable.indexOf(opt.value) >= 0);
}

SelectionModel.prototype.isSelectedOptionMarked = function(/*Option*/ opt) {
	return (this.markedSelected != null) && (this.markedSelected.indexOf(opt.value) >= 0);
}



function ModelUtils() {
}
ModelUtils.CURRENT_KEY = 0;

ModelUtils.generateKey = function() {
	ModelUtils.CURRENT_KEY++;
	return ModelUtils.CURRENT_KEY;
}

ModelUtils.copyProperties = function(src, target) {
	for (var attr in src) {
		if (!(src[attr] instanceof Function)) {
			target[attr] = src[attr];
		}
	}
}

ModelUtils.isEmpty = function(value) {
	if (value != null) {
		for (key in value) {
			return false;
		}
	}
	return true;
}

/* ModelUtils.convertValues = function(fields, values) {
	// Convert string dates, numbers and booleans to actual dates, numbers and booleans
	angular.forEach(fields, function(field) {
		var value = values[field.name];
		if (value != null) {
			if (field.typeDate) {
				values[field.name] = new Date(Date.parse(value));
			} else if (field.typeNumber || field.typeCurrency) {
				values[field.name] = new Number(value);
			} else if (field.isRenderedAsCheckbox()) {
				values[field.name] = new Boolean(value);
			}
		}
	}, this);
} */

ModelUtils.parseDate = function(/*String*/ value) {
	if ((value == null) || (value.trim() == '')) {
		return null;
	}
	var filter = angular.injector(['ng']).get('$filter');
	var testDate = new Date(2010, 11, 30);
	var testFormat = filter('date')(testDate, 'shortDate');
	var dayIdx = testFormat.indexOf('30');
	var sep = '';
	if (dayIdx == 0) {
		sep = testFormat.substring(2,3);
	} else {
		sep = testFormat.substring(dayIdx - 1,dayIdx);
	}

	var testParts = testFormat.split(sep);
	var parts = value.split(sep);
	var month, day, year;
	if (parts.length != 3) {
		throw new Error('Too many parts in a date: ' + value);
	}
	for (var i=0;i<parts.length;i++) {
		if (testParts[i] == '30') {
			day = parseInt(parts[i]);
		} else if (testParts[i] == '12') {
			month = parseInt(parts[i]);
		} if ((testParts[i] == '10') || (testParts[i] == '2010')) {
			year = parseInt(parts[i]);
			if (parts[i].length < 4) {
				var currentYear = '' + (new Date()).getFullYear();
				year = parseInt( currentYear.substring(0,2) + parts[i] );
			}
		}
	}
	return new Date(year, month - 1, day);
}

ModelUtils.parseNumber = function(/*String*/ value) {
	var filter = angular.injector(['ng']).get('$filter');
	var testNumber = 34.56;
	var decimalSep = filter('number')(34.56).substring(2,3);
	var groupSep = filter('number')(1234).substring(1,2);
	if (!ModelUtils.isBlank(value)) {
		value = value.replace(groupSep, '').replace(' ','').replace(groupSep, '.');
	}
	return new Number(value);
}

ModelUtils.defaultIfNull = function(value, defaultValue) {
	return (value == null) ? defaultValue : value;
}

ModelUtils.getNullProperties = function(/*Object*/ record) {
	var result = [];
	angular.forEach(record, function(value,key) {
		if (value == null) {
			result.push(key);
		}
	})
	return result;
}

ModelUtils.setNullProperties = function(/*Object*/ record, /*String[]*/ properties) {
	angular.forEach(properties, function(property) {
		if (record[property] == undefined) {
			record[property] = null;
		}
	});
}

ModelUtils.copyNullProperties = function(/*Object*/ source, /*Object*/ target) {
	if ((source != null) && (target != null)) {
		ModelUtils.setNullProperties(target, ModelUtils.getNullProperties(source));
	}
}

ModelUtils.isBlank = function(value) {
	if ((value == undefined) || (value == null) || (value === '')) {
		return true;
	}
	return false;
}

ModelUtils.toString = function(value) {
	//return ModelUtils.isBlank(value) ? '' : ('' + value);
	return value;
}



function SearchModel() {
	this.resultRows = new Array();
	this.resultFields = new Array();
}

SearchModel.prototype.resetSelections = function() {

	// Followed and unfollowed are used to sort new followed/unfollowed products
	// Assets and Subscriptions also use this function, but should be unaffected by this
	// They both can be enabled for feed tracking, but we don't sort them by followed/following (currently)

	followedRows = new Array();
	unfollowedRows = new Array();

	for (var i=0; i<this.resultRows.length; i++) {
		this.resultRows[i].selected = false;
		if (this.resultRows[i].followed == true) {
			followedRows.push(this.resultRows[i]);
		} else {
			unfollowedRows.push(this.resultRows[i]);
		}
	}

	this.resultRows = followedRows.concat(unfollowedRows);

}

SearchModel.prototype.updateResults = function(/*SObject[]*/ results) {
	this.resultRows = results;
	angular.forEach(this.resultRows, function(row) {
		var currencySymbol = ((row.record == null) || (row.record.CurrencyIsoCode == null)) ? this.defaultCurrencySymbol : (row.record.CurrencyIsoCode + ' ');
		row.currencySymbol = currencySymbol;
		row.selected = false;
	}, this);
}

SearchModel.prototype.getFilterValues = function() {
	// Update IDs of lookup fields stored in hidden fields into the mdoel.
	// Since they are set by SFDC native popup window there is no way to do this in real time
	this.scope.$broadcast('updateLookups');

	var result = new Object();
	angular.forEach(this.searchFilters, function(filter) {
		var value = filter.value;
		if (value != null) {
			if ((filter.field != null) && filter.field.isRenderedAsLookup()) {
				value = value.Id;
			}
			if (value != 'undefined') {
				result[filter.targetFieldName] = value;
			}
		}
	}, this);
	return result;
}

SearchModel.prototype.init = function(/*Object*/ scope, /*Object*/ data) {
	this.resultFields = new Array();
	this.scope = scope;
	this.prefix = scope.metaDataService.getPrefix();

	ModelUtils.copyProperties(data, this);
	scope.referencedObjects = scope.searchModel.referencedObjects;

	var objectName = this.targetObjectName;
	angular.forEach(this.searchFilters, function(filter) {
		filter.field = scope.metaDataService.getMetaData(objectName).fields[filter.targetFieldName];
	}, this);

	// Initialize result fields
	this.resultFields = this.toFields(this.resultFieldNames);
	this.resultFieldsTablet = this.toFields(this.resultFieldNamesTablet);
	this.resultFieldsPhone = this.toFields(this.resultFieldNamesPhone);

	if (this.results != null) {
		this.updateResults(this.results);
	}
}

SearchModel.prototype.getResultFields = function(/*String*/ formFactor) {
	if ((formFactor == 'tablet') && (this.resultFieldsTablet.length > 0)) {
		return this.resultFieldsTablet;
	} else if ((formFactor == 'phone') && (this.resultFieldsPhone.length > 0)) {
		return this.resultFieldsPhone;
	}
	return this.resultFields;
}

SearchModel.prototype.toFields = function(/*String[]*/ fieldNames) {
	var fields = [];
	angular.forEach(fieldNames, function(/*String*/ fieldName) {
		var field = this.scope.metaDataService.getMetaData(this.targetObjectName).fields[fieldName];
		if (field != null) {
			fields.push(field);
		}
	}, this);
	return fields;
}

SearchModel.prototype.getResultCountLabel = function() {
	if (this.resultRows == null) {
		return '0';
	}
	if ((this.resultLimit != null) && (this.resultRows.length > this.resultLimit)) {
		return this.resultRows.length + '+';
	}
	return this.resultRows.length;
}

SearchModel.prototype.isResultLimitExceeded = function() {
	if ((this.resultLimit != null) && (this.resultRows.length > this.resultLimit)) {
		return true;
	}
	return false;
}


function TreeViewModel(/*Object*/ scope, /*Object*/ data, /*String*/ groupByExpression, /*Object*/ otherLabel) {
	// debugger;
	this.groups = {};
	this.groupNames = {};
	this.groupNamesList = [];

	if (groupByExpression === null) {
		this.groups['Ungrouped'] = data;
		this.groupNamesList.push('Ungrouped');
		this.groupNames['Ungrouped'] = false;
	} else {
		angular.forEach(data, function(item){
			var groupName = eval('item.' + groupByExpression) ? eval('item.' + groupByExpression) : otherLabel;
			if (!this.groups[groupName]) {
				this.groups[groupName] = [];
				this.groupNamesList.push(groupName);
				this.groupNames[groupName] = true;
			}
			this.groups[groupName].push(item);
		}, this);
	}

	//reorder groups to display 'other' category as last
	var otherIndex = this.groupNamesList.indexOf(otherLabel);
	if (otherIndex !== -1) {
		this.groupNamesList.splice(otherIndex, 1);
		this.groupNamesList.push(otherLabel);
	}

	//auto-expand the group if there is only 1 group
	if (this.groupNamesList.length === 1) {
		this.groupNames[this.groupNamesList[0]] = false;
	}
}


function CustomActionModel(/*Object*/ data, /*MetaDataService*/ metaDataService) {
	var prefix = metaDataService.getPrefix();
	this.targetObject = data[prefix + 'TargetObject__c'];
	this.label = data[prefix + 'Label__c'];
	this.id = null;
	this.default = data[prefix + 'Default__c'];
	if (data['Id']) {
		this.id = data['Id'];
	}
}

CustomActionModel.prototype.isTargetProduct = function() {
	return (this.targetObject == 'Product');
}

CustomActionModel.prototype.isTargetAsset = function() {
	return (this.targetObject == 'Asset');
}

CustomActionModel.prototype.isTargetSubscription = function() {
	return (this.targetObject == 'Subscription');
}



function TabSetModel() {
	this.tabs = new Array();
	this.activeTab = null;
	this.tabsByName = {};
}

TabSetModel.prototype.addTab = function(/*String*/ name, /*String*/ label, /*Boolean*/ active) {
	var tab = {name:name,label:label,active:false};
	this.tabs.push(tab);
	this.tabsByName[tab.name] = tab;
	if ((active == true) || (this.tabs.length == 1)) {
		this.switchTo(tab);
	}
	return tab;
}

TabSetModel.prototype.switchTo = function(/*Object|String*/ tab) {
	if ((typeof tab).toLowerCase() == 'string') {
		tab = this.tabsByName[tab];
	}
	if (tab != null) {
		angular.forEach(this.tabs, function(t,idx) {t.active = false});
		tab.active = true;
		this.activeTab = tab;
	}
}

TabSetModel.prototype.isActiveTab = function(/*Object|String*/ tab) {
	console.log(this.activeTab.name + ' ' + tab);
	if ((this.activeTab != null) && (tab != null)) {
		if (tab instanceof String) {
			return (this.activeTab.name.toLowerCase() == tab.toLowerCase());
		} else {
			return (this.activeTab == tab);
		}
	}
	return false;
}


function TableLayoutModel() {
	this.rows = new Array();
	this.rowMap = {}; // object of array of arrays {10:[[CA1, CA2], [CA3], [CA4]]} to stack config attributes with same display order on the same column
	this.rowMapKeysSorted = [];
	this.noOfColumns = Controller.isMobileContext() ? 1 : 3;

	this.columnWidth = (100 / this.noOfColumns) + '%';

	this.columns = new Array();
}

TableLayoutModel.prototype.addItem = function(/*Object*/ data, /*String*/ columnOrder, /*String*/ rowOrder) {
	//default legacy configuration attributes with no column order to column 1
	if (!columnOrder) {
		columnOrder = 1;
	}

	if (!this.rowMap.hasOwnProperty(rowOrder)) {
		this.rowMap[rowOrder] = new Array(this.noOfColumns);

		//sorting this.rowMap keys(=rowOrders) to pass the data into this.rows by order
		var keyIndex = 0;
		for(var i = 0; i < this.rowMapKeysSorted.length; i++) {
			if (rowOrder >= this.rowMapKeysSorted[i]) {
				keyIndex++;
			}
		}
		this.rowMapKeysSorted.splice(keyIndex, 0, rowOrder);
	}

	//update this.rowMap
	var row = this.rowMap[rowOrder];
	var columnIndex = columnOrder - 1;
	if (!row[columnIndex]) {
		row[columnIndex] = new Array();
	}
	row[columnIndex].push(data);

	//update this.rows
	var rowIndex = this.rowMapKeysSorted.indexOf(rowOrder);
	this.rows[rowIndex] = row;
}

TableLayoutModel.prototype.transposeRowsToColumns = function() {
	for (var i = 0; i < this.noOfColumns; i ++) {
		this.columns[i] = new Array();
		angular.forEach(this.rows, function(row, rowIndex) {
			this.columns[i][rowIndex] = row[i];
		}, this);
	}
}



function ObjectMetaData(/*String*/ name) {
	this.name = name;
	this.fields = {};
	this.describe = null;
	this.layout = null;
}

ObjectMetaData.prototype.setDescribe = function(/*DescribeObject*/ describe) {
	this.describe = describe;
	if (describe != null) {
		for (var i=0;i<describe.fields.length;i++) {
			var field = new Field(describe.fields[i]);
			field.parentObjectDescribe = describe;
			this.fields[describe.fields[i].name] = field;
		}
		this.relateDependentPicklists();
	}
}

ObjectMetaData.prototype.setLayout= function(layout) {
	this.layout = layout;
}

ObjectMetaData.prototype.relateDependentPicklists = function() {
	for (var fieldName in this.fields) {
		var field = this.fields[fieldName];
		if (field.describe.dependentPicklist) {
			var controllingField = this.fields[field.describe.controllerName];
			field.controllingField = controllingField;
			if(controllingField != null) {
				controllingField.dependentFields.push(field);
			}
		}
	}
}

ObjectMetaData.prototype.getFields = function(/*String[]*/ fieldNames) {
	var result = new Array();
	for (var i=0;i<fieldNames.length;i++) {
		var field = this.fields[fieldNames[i]];
		if (field != null) {
			result.push(field);
		}
	}
	return result;
}

ObjectMetaData.prototype.getField = function(/*String*/ fieldName) {
	return this.fields[fieldName];
}



function Field(/*Object*/ describe) {
	this.describe = describe;
	this.name = describe.name;
	this.label = describe.label;
	this.type = describe.type.toUpperCase();
	this.picklistValues = describe.picklistValues;
	if (!(this.picklistValues instanceof Array)) {
		this.picklistValues = [this.picklistValues];
	}
	this.updateable = (describe.updateable == 'true') || (describe.updateable == true);
	this.controllingField = null;
	this.dependentFields = [];
	this.scale = describe.scale;
	this.required = describe.required;
}

Field.prototype.getKey = function() {
	if (this.parentObjectDescribe) {
		return this.parentObjectDescribe.name + '.' + this.name;
	}
	return this.name;
}

Field.prototype.isDependent = function() {
	return (this.controllingField != null);
}

Field.prototype.isControlling = function() {
	return (this.dependentFields.length > 0);
}

Field.prototype.isRenderedAsInput = function() {
	return this.isRenderedAsText() || this.isRenderedAsNumber() || this.isRenderedAsCheckbox() || this.isRenderedAsDate();
}

Field.prototype.isRenderedAsText = function() {
	return (this.type.toUpperCase() == 'STRING');
}

Field.prototype.isRenderedAsNumber = function() {
	return (this.type.toUpperCase() == 'DOUBLE') || (this.type.toUpperCase() == 'CURRENCY') || (this.type.toUpperCase() == 'PERCENT');
}

Field.prototype.isRenderedAsCheckbox = function() {
	return (this.type.toUpperCase() == 'BOOLEAN');
}

Field.prototype.isRenderedAsSelect = function() {
	return this.isPicklist() || this.isMultiPicklist();
}

Field.prototype.isRenderedAsDate = function() {
	return (this.type.toUpperCase() == 'DATE');
}

Field.prototype.isRenderedAsLookup = function() {
	return (this.type.toUpperCase() == 'REFERENCE');
}

Field.prototype.isRenderedAsTextArea = function() {
	return ((this.type.toUpperCase() == 'TEXTAREA') && !this.describe.htmlFormatted);
}

Field.prototype.isRenderedAsRichText = function() {
	return ((this.type.toUpperCase() == 'TEXTAREA') && this.describe.htmlFormatted);
}

Field.prototype.isPicklist = function() {
	return (this.type.toUpperCase() == 'PICKLIST');
}

Field.prototype.isMultiPicklist = function() {
	return (this.type.toUpperCase() == 'MULTIPICKLIST');
}

Field.prototype.getInputType = function() {
	return (this.isRenderedAsCheckbox() ? 'checkbox' : 'text');
}

Field.prototype.getColumnClass = function() {
	if (this.typeCurrency) {
		return 'CurrencyElement';
	} else if (this.typeNumber) {
		return 'numericalColumn';
	} else if (this.typeDate) {
		return 'DateElement';
	}
	return '';
}

Field.prototype.getValueProperty = function() {
	return this.isRenderedAsLookup() ? this.describe.relationshipName : this.name;
}

Field.prototype.getRelationshipName = function() {
	return this.name.replace('__c', '__r');
}

Field.prototype.getInputSize = function() {
	if ((this.type.toUpperCase() == 'CURRENCY') || (this.type.toUpperCase() == 'DOUBLE')) {
		return Controller.isMobileContext() ? '5' : '10';
	}
	if (this.type.toUpperCase() == 'DATE') {
		return '10';
	}
	return '20';
}

Field.prototype.getValidPicklistValues = function(/*String*/ controllingValue) {
	var base64 = new sforce.Base64Binary("")
	// For each dependent value, check whether it is valid for each controlling value
	var values = this.picklistValues;
	if (this.controllingField == null) {
		return values;
	}
	var validValues = [];
	for (var i=0;i<values.length;i++) {
		var value = values[i];
		if (this.testBit(base64.decode(value.validFor), this.controllingField.getOptionIndex(controllingValue))) {
			validValues.push(value);
		}
	}
	return validValues;
}

Field.prototype.getOptionIndex = function(/*String*/ value) {
	for (var i=0;i<this.picklistValues.length;i++) {
		if (this.picklistValues[i].value == value) {
			return i;
		}
	}
	return -1;
}

Field.prototype.testBit = function(validFor, controllingValueIndex) {
	var byteToCheck = Math.floor(controllingValueIndex / 8);
	var bit = 7 - (controllingValueIndex % 8);
	return ((Math.pow(2, bit) & validFor.charCodeAt(byteToCheck)) >> bit) == 1;
}

Field.prototype.formatValue = function(/*Object*/ value, /*String*/ currencySymbol, /*Integer*/ scale) {
	if ((currencySymbol == null) || ModelUtils.isBlank(value)) {
		currencySymbol = '';
	}
	if (scale == null) {
		scale = this.scale;
	}
	var formatter = angular.injector(['ng']).get('$filter');
	if (this.isRenderedAsNumber() && !ModelUtils.isBlank(value)) {
		return ((this.type.toUpperCase() == 'CURRENCY') ? currencySymbol : '') + formatter('number')(value, scale);
	} else if (this.isRenderedAsDate()) {
		return formatter('date')(value, 'shortDate');
	}

	return value;
}

Field.prototype.clone = function(targetField) {
	// Cache dependency information to reestablish after clone
	var parentObjectDescribe = targetField.parentObjectDescribe;
	var controllingField = targetField.controllingField;
	if (controllingField) {
		// If targetField's controlling field exists, that controlling field has its own dependent fields
		var cfDependentFields = targetField.controllingField.dependentFields;
		var cfDependentFieldsByName = {};
		for (var i = 0; i < cfDependentFields.length; i++) {
			cfDependentFieldsByName[cfDependentFields[i].name] = cfDependentFields[i];
		}
	}
	var dependentFields = targetField.dependentFields;
	var dependentFieldsByName = {};
	for (var j = 0; j < dependentFields.length; j++) {
		dependentFieldsByName[dependentFields[j].name] = dependentFields[j];
	}

	targetField = new Field(targetField.describe);

	// Update dependency relationships for picklists
	targetField.parentObjectDescribe = parentObjectDescribe;
	targetField.controllingField = controllingField;
	if (targetField.controllingField) {
		// Clear targetField's controlling field's dependent fields list and then populate again.
		// This way targetField's controlling field will point to existing dependent fields, plus the new cloned targetField.
		targetField.controllingField.dependentFields = [];
		for (var k = 0; k < cfDependentFields.length; k++) {
			if(cfDependentFields[k].name !== targetField.name){
				targetField.controllingField.dependentFields.push(cfDependentFieldsByName[cfDependentFields[k].name]);
			} else {
				targetField.controllingField.dependentFields.push(targetField);
			}
		}
	}
	targetField.dependentFields = [];
	for (var l = 0; l < dependentFields.length; l++) {
		targetField.dependentFields.push(dependentFields[l]);
	}
	return targetField;
}

Field.prototype.filterShownValues = function(/*String[]*/ values) {
	var allValues = this.picklistValues;
	this.picklistValues = [];
	angular.forEach(allValues, function(option) {
		if (jQuery.inArray(option.value, values) !== -1) {
			this.picklistValues.push(option);
		}
	}, this);
}

Field.prototype.filterHiddenValues = function(/*String[]*/ values) {
	var allValues = this.picklistValues;
	this.picklistValues = [];
	angular.forEach(allValues, function(option) {
		if (jQuery.inArray(option.value, values) === -1) {
			this.picklistValues.push(option);
		}
	}, this);
}


function createSteelBrickCPQModule() {
	var qq = angular.module('qq', ['ng','ngSanitize']);

	qq.factory('controllerManager', function() {return new ControllerManager();});

	qq.directive('modelUpdateOnChange', function() {
	    return {
	        restrict: 'A',
	        require: 'ngModel',
	        link: function(scope, elm, attr, controller) {
	            if (attr.type === 'radio' || attr.type === 'checkbox') return;

	            elm.unbind('input').unbind('keydown').unbind('change');
	            elm.bind('change', function() {
	                scope.$apply(function() {
	                    controller.$setViewValue(elm.val());
	                });
	            });
	        }
	    };
	});
	qq.directive('inputField', function() {
	    return {
	        restrict: 'A',
	        require: 'ngModel',
	        link: function(scope, elm, attrs, controller) {
	        	var filter = angular.injector(['ng']).get('$filter');
	        	var field = scope.$eval(attrs.inputField);
	        	//var target = scope.$eval(attrs.inputObject);
	        	elm.attr('size', field.getInputSize());
	        	if (field.isRenderedAsNumber()) {
	        		controller.$formatters.push(function(value) {
	        			if (value == null) {
	        				return null;
	        			}
	        			return filter('number')(value, field.scale);
	        		});
	        		controller.$parsers.push(function(value) {
	        			var num = ModelUtils.parseNumber(value);
	        			if (isNaN(num)) {
	        				return controller.$modelValue;
	        			}
	        			return num;
	        		});
	        	}

	        	if (attrs.type != 'radio' && attrs.type != 'checkbox') {
		            elm.unbind('input').unbind('keydown').unbind('change');
		            elm.bind('change', function() {
		                scope.$apply(function() {
		                    controller.$setViewValue(elm.val());
		                });
		            });
	        	}
	        }
	    };
	});

	qq.directive('qqField', Directives.dynamicField);
	qq.directive('qqKeydown', Directives.keyDown);
	qq.directive('qqChange', Directives.change);

	return qq;
}
