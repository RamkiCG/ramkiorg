function AssetLookupCtrl(scope, controllerManager, metaDataService, assetService) {
	controllerManager.register('AssetLookup', this);
	
	this.scope = scope;
	this.scope.active = false;
	this.scope.controller = this;
	this.scope.controllerManager = controllerManager;
	this.scope.assetService = assetService;
	this.scope.metaDataService = metaDataService;
	this.scope.initialSearchModel = null;
	this.scope.initialized = false;
	this.scope.blockingOperationInprogress = false;
	
	this.scope.onSelect = this.onSelect;
	this.scope.onCancel = this.onCancel;
	this.scope.onSwitchTab = this.onSwitchTab;
	this.scope.onSearch = this.onSearch;
	this.scope.onSuggest = this.onSuggest;
	this.scope.load = this.load;
	this.scope.onKeyDown = this.onKeyDown;
	this.scope.clearFields = this.clearFields;
	this.scope.resizePanel = this.resizePanel;
	this.scope.selectAllCheckboxes = this.selectAllCheckboxes;
	this.scope.displayErrorMessage = this.displayErrorMessage;

	this.statusProperties.push('searchInProgress');
}

AssetLookupCtrl.$inject = ['$scope', 'controllerManager', 'metaDataService', 'assetServiceProxy'];
AssetLookupCtrl.prototype = new Controller();

AssetLookupCtrl.prototype.load = function(/*Controller*/ srcController, /*QuoteVO*/ quote, /*Integer*/ targetGroupKey, /*String*/ actionId) {
	var controller = this;
	var scope = controller.scope;
	scope.quote = quote;
	scope.targetGroupKey = targetGroupKey;
	if (scope.searchModel == null || scope.searchModel.actionId != actionId) {
		var successHandler = function(/*String*/ result) {
			try {
				scope.searchModel = new AssetSearchModel();
				scope.searchModel.actionId = actionId;
				scope.searchModel.init(scope, angular.fromJson(result));
			} catch (e) {
				scope.controller.handleError(e);
			}
			scope.controllerManager.activateController(controller);
			resizeTableResults('#sbAssetSearch');
			resizePanels('.sbTable.sbAssets', false, '.sbAssetFilter', []);

      $(window).resize(); // dynamically adjust page header
		};
		var metaDataCompleteHandler = function() {
			scope.assetService.loadSearchModel(quote, actionId, successHandler, srcController.createErrorHandler());
		}
		scope.metaDataService.ensureObjectMetaData(['Asset'], metaDataCompleteHandler, srcController);
	} else {
		scope.searchModel.resetSelections();
		scope.controllerManager.activateController(controller);
		resizeTableResults('#sbAssetSearch');

		//	Focuses first input of opened Panel when you click one of the buttons and revisit the Add Products page.
		if ($('.sbAssetFilter').hasClass('open')) openedPanel = $('.sbAssetFilter');
		if (openedPanel != null) {
			var openedPanelInput = $(openedPanel.find('fieldset')[0]).find('input')[0] || $(openedPanel.find('fieldset')[0]).find('select')[0];
			setTimeout(function() {
				$(openedPanelInput).focus();
			}, 50);
		}
	}
}

AssetLookupCtrl.prototype.onSearch = function() {
	var scope = this;
	var successHandler = function(/*String*/ result) {
		scope.$apply(function() {
			scope.searchModel.updateResults(angular.fromJson(result));
			scope.searchInProgress = false;
		});
		resizeTableResults('#sbAssetSearch');
	};
	scope.searchInProgress = true;
	scope.messages = null;
	scope.assetService.search(scope.quote, scope.searchModel.getFilterValues(), scope.searchModel.actionId, successHandler, scope.controller.createErrorHandler());
}

AssetLookupCtrl.prototype.onSelect = function() {
	var scope = this;
	scope.blockingOperationInProgress = true;

	var assets = this.searchModel.getSelectedAssets();
	var targetCtrl = scope.controllerManager.lookup('ProductUpgrader');
	targetCtrl.selectProductUpgrades(scope.controller, assets, scope.quote, scope.targetGroupKey);
}

AssetLookupCtrl.prototype.onCancel = function() {
	var targetCtrl = this.controllerManager.lookup('QuoteLineEditor');
	this.controllerManager.activateController(targetCtrl);
}

AssetLookupCtrl.prototype.onKeyDown = function(event) {
	if (event.keyCode == 13) {
		if (event.target && (event.target != null)) {
			// Trigger onchange event so the model is updated
			event.target.blur();
			event.target.focus();
		}
		this.onSearch();
		event.preventDefault();
		this.controller.executeApply();
	}
}

AssetLookupCtrl.prototype.clearFields = function() {
	this.searchModel.searchFilters.forEach(function(filters){filters.value=null});
}

AssetLookupCtrl.prototype.resizePanel = function(/*panel*/ panel) {
	resizePanels('.sbTable.sbAssets', $(panel).hasClass('open'), panel, []);
}

AssetLookupCtrl.prototype.selectAllCheckboxes = function() {
	var assetRows = this.scope.searchModel.results;
	var allSelected = $('.sbAssetsSelectAll')[0].checked;
	for (var i=0;i<assetRows.length;i++) {
		assetRows[i].selected = allSelected;
	}
}

AssetLookupCtrl.prototype.displayErrorMessage = function(message) {
	this.scope.messages = [{severity:'error', summary: message}];
	this.scope.blockingOperationInProgress = false;
}

<!-- End of AssetLookupCtrl -->


function AssetSearchModel() {
}

AssetSearchModel.prototype = new SearchModel();

AssetSearchModel.prototype.getSelectedAssets = function() {
	var result = new Array();
	for (var i=0;i<this.resultRows.length;i++) {
		if (this.resultRows[i].selected == true) {
			result.push({record:this.resultRows[i].record});
		}
	}
	return result;
}

<!-- End of AssetSearchModel -->


