function ProductLookupCtrl(scope, controllerManager, metaDataService, chatterService, productService) {
	controllerManager.register('ProductLookup', this);

	this.scope = scope;
	this.scope.active = false;
	this.scope.controller = this;
	this.scope.controllerManager = controllerManager;
	this.scope.productService = productService;
	this.scope.metaDataService = metaDataService;
	this.scope.chatterService = chatterService;
	this.scope.initialSearchModel = null;
	this.scope.initialized = false;
	this.scope.blockingOperationInprogress = false;
	this.scope.suggestHasRun = false;

	this.scope.onSelect = this.onSelect;
	this.scope.onSelectAndMore = this.onSelectAndMore;
	this.scope.onCancel = this.onCancel;
	this.scope.onSwitchTab = this.onSwitchTab;
	this.scope.onSearch = this.onSearch;
	this.scope.onSuggest = this.onSuggest;
	this.scope.onKeyDown = this.onKeyDown;
	this.scope.onInit = this.onInit;
	this.scope.selectAllCheckboxes = this.selectAllCheckboxes;
	this.scope.resizePanel = this.resizePanel;
	this.scope.clearFields = this.clearFields;
	this.scope.displayErrorMessage = this.displayErrorMessage;

	this.statusProperties.push('searchInProgress');
}
ProductLookupCtrl.$inject = ['$scope', 'controllerManager', 'metaDataService', 'chatterServiceProxy', 'productServiceProxy'];
ProductLookupCtrl.prototype = new Controller();

ProductLookupCtrl.prototype.load = function(/*Controller*/ srcController, /*QuoteVO*/ quote, /*Integer*/ targetGroupKey, /*String*/ processId, /*String*/ actionId) {
	var controller = this;
	var scope = controller.scope;
	scope.quote = quote;
	scope.targetGroupKey = targetGroupKey;
	scope.quoteProcessId = processId;
	scope.addMore = false;
	var prefix = scope.metaDataService.prefix;
	var openedPanel = null;

	if (scope.searchModel) {
		var searchFilters = scope.searchModel.searchFilters;
		var filterValuesChanged;
		var FILTER_SOURCE_FIELD_FIELD = prefix + 'FilterSourceField__c'
		for (var i = 0; i < searchFilters.length; i++) {
			var filter = searchFilters[i];
			var filterSourceField = filter.record[FILTER_SOURCE_FIELD_FIELD];
			if (filterSourceField && quote.record[filterSourceField] !== undefined && quote.record[filterSourceField] != filter.value) {
				filterValuesChanged = true;
				break;
			}
		}
	}

	if (scope.searchModel == null || scope.searchModel.actionId != actionId || scope.searchModel.processId != processId || scope.searchModel.resetProductLookup || filterValuesChanged) {
		var successHandler = function(/*String*/ result) {
			scope.searchModel = new ProductSearchModel();
			scope.searchModel.actionId = actionId;
			scope.searchModel.processId = processId;
			scope.searchModel.init(scope, angular.fromJson(result));
			scope.controllerManager.activateController(controller);
			resizeTableResults('#sbProductSearch');
			// This doesn't work with angular
			if (scope.searchModel.defaultTabName != 'GuidedSelling') {
				$('#sbGuidedModal').removeClass('sbGuidedModal');
				$('#sbGuidedModal').addClass('sbGuided');	
			}

			if (!($('.sbProductFilter').hasClass('open')) && (scope.searchModel.defaultTabName != 'GuidedSelling' || scope.searchModel.guidedSellingTabShown == false)) {
				resizePanels('.sbTable.sbProducts', false, '.sbProductFilter', []);
			} else {
				//	Focuses first input of opened Panel when you click one of the buttons and revisit the Add Products page.
				if ($('.sbProductFilter').hasClass('open')) openedPanel = $('.sbProductFilter');
				if ($('.sbGuided').hasClass('open')) openedPanel = $('.sbGuided');
				if (openedPanel != null) {
					var openedPanelInput = $(openedPanel.find('fieldset')[0]).find('input')[0] || $(openedPanel.find('fieldset')[0]).find('select')[0];
					setTimeout(function() {
						$(openedPanelInput).focus();
					}, 50);
				}
			}

        	$(window).resize(); // dynamically adjust page header
		};
		var metaDataCompleteHandler = function() {
			scope.productService.loadSearchModel(quote, processId, actionId, successHandler, srcController.createErrorHandler());
		}

		var prefix = scope.metaDataService.getPrefix();
		scope.metaDataService.ensureObjectMetaData(['Product2','PricebookEntry',prefix + 'ProcessInput__c'], metaDataCompleteHandler, srcController);
	} else {
		scope.searchModel.resetSelections();
		scope.searchModel.updateResults(scope.searchModel.resultRows)
		scope.controllerManager.activateController(controller);
		if ($('.sbProductSelectAll').length > 0) {
			$('.sbProductSelectAll')[0].checked = false;
		}
	}
	//	Focuses first input of opened Panel when you click one of the buttons and revisit the Add Products page.
	if ($('.sbProductFilter').hasClass('open')) openedPanel = $('.sbProductFilter');
	if ($('.sbGuided').hasClass('open')) openedPanel = $('.sbGuided');
	if (openedPanel != null) {
		var openedPanelInput = $(openedPanel.find('fieldset')[0]).find('input')[0] || $(openedPanel.find('fieldset')[0]).find('select')[0];
		setTimeout(function() {
			$(openedPanelInput).focus();
		}, 50);
	}

}

ProductLookupCtrl.prototype.onInit = function(/*Map<String,String>*/ labels) {
	this.labels = labels;
}

ProductLookupCtrl.prototype.onSearch = function() {
	var scope = this;
	var controller = scope.controller;
	var successHandler = function(/*String*/ result) {
		scope.$apply(function() {
			scope.searchModel.updateResults(angular.fromJson(result));
			scope.searchInProgress = false;
		});
		resizeTableResults('#sbProductSearch');
		$('.sbProductSelectAll')[0].checked = false;
	};
	scope.searchInProgress = true;
	scope.messages = null;
	scope.productService.search(scope.quote, scope.searchModel.getFilterValues(), scope.searchModel.actionId, successHandler, controller.createErrorHandler());
}

ProductLookupCtrl.prototype.onSuggest = function() {
	var scope = this;
	var controller = scope.controller;
	scope.blockingOperationInProgress = true;
	var successHandler = function(/*String*/ result) {
		scope.$apply(function() {
			scope.blockingOperationInProgress = false;
			scope.suggestHasRun = true;
			scope.searchModel.updateResults(angular.fromJson(result));
			scope.searchInProgress = false;
			if ((scope.searchModel.productAutoSelected == true) && (scope.searchModel.resultRows.length == 1)) {
				scope.searchModel.resultRows[0].selected = true;
				scope.onSelect();
			}
		});
		resizeTableResults('#sbProductSearch');
		resizePanels('.sbTable.sbProducts', true, '.sbGuided', []);
		$('.sbProductSelectAll')[0].checked = false;
	};


	scope.searchInProgress = true;
	scope.messages = null;

	scope.productService.suggest(scope.quote, scope.searchModel.getQuoteProcess(), successHandler, controller.createErrorHandler());
	scope.modalClose = true;
}

ProductLookupCtrl.prototype.onSelect = function() {
	this.blockingOperationInProgress = true;
	this.messages = null;

	var products = this.searchModel.getSelectedProducts();
	var quoteProcess = this.searchModel.quoteProcess;
	var targetCtrl = this.controllerManager.lookup('QuoteLineEditor');

	targetCtrl.addProducts(this.controller, this.targetGroupKey, products, quoteProcess);
}

ProductLookupCtrl.prototype.onKeyDown = function(event) {
	if (event.keyCode == 13) {
		if (event.target && (event.target != null)) {
			// Trigger onchange event so the model is updated
			event.target.blur();
			event.target.focus();
		}
		if (event.currentTarget.getAttribute('class').indexOf('sbProductFilter') != -1 || event.currentTarget.getAttribute('class').indexOf('pbProductFilter') != -1) {
			this.onSearch();
		} else {
			this.onSuggest();
		}
		event.preventDefault();
		this.controller.executeApply();
	}
}

ProductLookupCtrl.prototype.onSelectAndMore = function() {
	this.addMore = true;
	this.onSelect();
}

ProductLookupCtrl.prototype.onCancel = function() {
	var targetCtrl = this.controllerManager.lookup('QuoteLineEditor');
	this.controllerManager.activateController(targetCtrl);
}

ProductLookupCtrl.prototype.onSwitchTab = function(/*Object*/ tab) {
	this.searchModel.tabModel.switchTo(tab);
}

ProductLookupCtrl.prototype.onToggleGroups = function($event, group){
	$event.preventDefault();
	this.scope.searchModel.resultsGrouped.groupNames[group] = !this.scope.searchModel.resultsGrouped.groupNames[group];
};

ProductLookupCtrl.prototype.selectAllCheckboxes = function() {
	var groups = this.scope.searchModel.resultsGrouped.groups;
	var groupNames = this.scope.searchModel.resultsGrouped.groupNames;
	var allSelected = $('.sbProductSelectAll')[0].checked;
	for (var i in groupNames) {
		if (groupNames[i] == false) {
			for (var j=0;j<groups[i].length;j++) {
				groups[i][j].selected = allSelected;
			}
		}
	}
}

ProductLookupCtrl.prototype.clearFields = function(filtered) {
	if (filtered) {
		this.searchModel.searchFilters.forEach(function(filters){filters.value=null});
	} else {
		this.searchModel.quoteProcess.inputs.forEach(function(input){input.record[input.inputFieldName]=null});
	}
}

ProductLookupCtrl.prototype.resizePanel = function(/*panel*/ panel) {
	setTimeout(
		function(){
			resizePanels('.sbTable.sbProducts', $(panel).hasClass('open'), panel, ['.sbGuided', '.sbProductFilter'])
	}, 0);
}

ProductLookupCtrl.prototype.displayErrorMessage = function(message) {
	this.scope.messages = [{severity:'error', summary: message}];
	this.scope.blockingOperationInProgress = false;
}

<!-- End of ProductLookupCtrl -->

function ProductSearchModel() {
	this.priceField = null;
}
ProductSearchModel.prototype = new SearchModel();

ProductSearchModel.prototype.init = function(/*Object*/ scope, /*Object*/ data) {
	// This must be before call to super init because it calls
	// updateResults which uses this field
	this.priceField = scope.metaDataService.getMetaData('PricebookEntry').fields['UnitPrice'];
	var prefix = scope.metaDataService.getPrefix();

	this.groupByExpression = (!ModelUtils.isBlank(data.productResultsGroupFieldName)) ? 'record.Product2.' + data.productResultsGroupFieldName : null;

	var quoteProcessExists = data.quoteProcess == null ? false : data.quoteProcess.inputs.length > 0;
	if (quoteProcessExists && data.guidedSellingTabShown && data.defaultTabName == 'GuidedSelling') data.results = null;

	SearchModel.prototype.init.apply(this, arguments);

	this.inputFieldsByName = {};
	if (this.quoteProcess != null) {
		angular.forEach(this.quoteProcess.inputs, function(input) {
			var fieldName = input.record[prefix + 'InputField__c'];
			input.inputFieldName = fieldName;
			this.inputFieldsByName[fieldName] = scope.metaDataService.getMetaData(prefix + 'ProcessInput__c').fields[fieldName];
		}, this);
	}

	// Initialize the tab model.
	this.tabModel = new TabSetModel();
	if (this.searchFiltersTabShown == true) {
		this.tabModel.addTab('SearchFilters', 'Search Filters', false);
	}
	if (this.guidedSellingTabShown == true) {
		this.tabModel.addTab('GuidedSelling', 'Guided Selling', false);
	}
	this.tabModel.switchTo(this.defaultTabName);
}

ProductSearchModel.prototype.updateResults = function(/*SObject[]*/ results) {
	SearchModel.prototype.updateResults.apply(this, arguments);
	this.resultsGrouped = new TreeViewModel(this.scope, this.resultRows, this.groupByExpression, this.scope.labels.lbl_other);
}

ProductSearchModel.prototype.getQuoteProcess = function() {
	// Update IDs of lookup fields stored in hidden fields into the mdoel.
	// Since they are set by SFDC native popup window there is no way to do this in real time
	this.scope.$broadcast('updateLookups');

	if (this.quoteProcess == null) {
		return null;
	}

	var prefix = this.scope.metaDataService.getPrefix();
	var processCopy = {record:this.quoteProcess.record};
	processCopy.inputs = [];
	angular.forEach(this.quoteProcess.inputs, function(input) {
		var inputCopy = {};
		ModelUtils.copyProperties(input, inputCopy);
		inputCopy.record = {};
		ModelUtils.copyProperties(input.record, inputCopy.record);
		processCopy.inputs.push(inputCopy);

		var value = input.record[input.inputFieldName];
		var field = this.scope.metaDataService.getMetaData(prefix + 'ProcessInput__c').getField(input.inputFieldName);
		if (field.isRenderedAsLookup()) {
			var value = input.record[input.inputFieldName];
			if ((value != null) && (value.Id != 'undefined')) {
				inputCopy.record[input.inputFieldName] = value.Id;
			}
		}
	}, this);
	return processCopy;
}

ProductSearchModel.prototype.getSelectedProducts = function() {
	var result = new Array();
	for (var i=0;i<this.resultRows.length;i++) {
		if (this.resultRows[i].selected == true) {
			var productId = this.resultRows[i].record.Product2Id;
			result.push({record:{Id:productId}});
		}
	}
	return result;
}

ProductSearchModel.prototype.getGroupClass = function(group) {
	return (this.resultsGrouped.groupNames[group]) ? 'expanded' : 'collapsed';
}

ProductSearchModel.prototype.hasVisibleSearchFilters = function() {
	for (var i = 0; i < this.searchFilters.length; i++) {
		if (!this.searchFilters[i].hidden) {
			return true;
		}
	}
	return false;
}


