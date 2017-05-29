
function ProductConfigurationCtrl(scope, controllerManager, metaDataService, productService) {
	controllerManager.register('ProductConfigurator', this);

	this.active = false;
	this.scope = scope;

	this.scope.controller = this;
	this.scope.configurationMode = true;
	this.scope.optionLookupMode = false;
	this.scope.controllerManager = controllerManager;
	this.scope.productService = productService;
	this.scope.metaDataService = metaDataService;
	this.scope.configurationStack = [];
	this.scope.configuredProducts = [];
	// Points to a nested bundle being configured (if any).
	this.scope.selectedConfiguration = null;
	// Points to the feature to which options are being added
	this.scope.selectedFeature = null;
	// Upgraded Asset ID of one of the root products being configured.
	// Only used during nested bundle configuration
	this.scope.upgradedAssetId = null;
	this.scope.quantityScale = 2;

	this.scope.onInit = this.onInit;
	this.scope.onSave = this.onSave;
	this.scope.onCancel = this.onCancel;
	this.scope.onConfigureProducts = this.onConfigureProducts;
	this.scope.onLookupOption = this.onLookupOption;
	this.scope.onAddOption = this.onAddOption;
	this.scope.onCancelOptionLookup = this.onCancelOptionLookup;
	this.scope.onConfigureOption = this.onConfigureOption;
	this.scope.onDeleteOption = this.onDeleteOption;
	this.scope.onSelectionChanged = this.onSelectionChanged;
	this.scope.onConfigurationAttributeChanged = this.onConfigurationAttributeChanged;
	this.scope.onEditOptionConfig = this.onEditOptionConfig;
	this.scope.onNextFeature = this.onNextFeature;
	this.scope.onPreviousFeature = this.onPreviousFeature;
	this.scope.namespacePrefix = metaDataService.getPrefix();
	this.scope.displayErrorMessage = this.displayErrorMessage;

	var prefix = this.scope.namespacePrefix;

	// Initialize field names
	ProductModel.OPTION_LAYOUT_FIELD = prefix + 'OptionLayout__c';
	ProductModel.OPTION_SELECTION_METHOD_FIELD = prefix + 'OptionSelectionMethod__c';
	ProductModel.CONFIGURATION_FIELDS_FIELD = prefix + 'ConfigurationFields__c';
	ProductModel.CUSTOM_CONFIGURATION_PAGE_FIELD = prefix + 'CustomConfigurationPage__c';
	ProductModel.CONFIGURATION_FORM_TITLE_FIELD = prefix + 'ConfigurationFormTitle__c';
	ProductFeatureModel.MIN_OPTION_COUNT_FIELD = prefix + 'MinOptionCount__c';
	ProductFeatureModel.MAX_OPTION_COUNT_FIELD = prefix + 'MaxOptionCount__c';
	ProductFeatureModel.ADD_OPTION_DIALOG_TITLE_FIELD = prefix + 'AddOptionDialogTitle__c';
	ProductFeatureModel.ADD_OPTION_BUTTON_LABEL_FIELD = prefix + 'AddOptionButtonLabel__c';
	ProductFeatureModel.ADD_OPTION_EXCLUDED_FIELDS_FIELD = prefix + 'AddOptionExcludedFields__c';
	ProductFeatureModel.ADDITIONAL_INSTRUCTIONS_FIELD = prefix + 'AdditionalInstructions__c';
	ProductFeatureModel.CATEGORY_FIELD = prefix + 'Category__c';
	ProductOptionModel.OBJECT_NAME = prefix + 'ProductOption__c';
	ProductOptionModel.REQUIRED_FIELD = prefix + 'Required__c';
	ProductOptionModel.FEATURE_ID_FIELD = prefix + 'Feature__c';
	ProductOptionModel.QUANTITY_FIELD = prefix + 'Quantity__c';
	ProductOptionModel.QUANTITY_EDITABLE_FIELD = prefix + 'QuantityEditable__c';
	ProductOptionModel.PRODUCT_QUANTITY_SCALE_FIELD = prefix + 'ProductQuantityScale__c';
	ProductOptionModel.MIN_QUANTITY_FIELD = prefix + 'MinQuantity__c';
	ProductOptionModel.OPTIONAL_SKU_FIELD = prefix + 'OptionalSKU__c';
	ProductOptionModel.PRICE_EDITABLE_FIELD = prefix + 'PriceEditable__c';
	ProductOptionModel.UNIT_PRICE_FIELD = prefix + 'UnitPrice__c';
	ProductOptionModel.DISCOUNT_FIELD = prefix + 'Discount__c';
	ProductOptionModel.DISCOUNT_AMOUNT_FIELD = prefix + 'DiscountAmount__c';
	ProductOptionModel.SYSTEM_FIELD = prefix + 'System__c';
	ProductOptionModel.APPLY_IMMEDIATELY_FIELD = prefix + 'AppliedImmediately__c';
}
ProductConfigurationCtrl.$inject = ['$scope', 'controllerManager', 'metaDataService', 'productServiceProxy'];
ProductConfigurationCtrl.prototype = new Controller();

ProductConfigurationCtrl.prototype.onInit = function(/*Map<String,String>*/ labels, /*String*/ externalInitFunctionName) {
	this.labels = labels;
	if (!ModelUtils.isBlank(externalInitFunctionName)) {
		var externalInitFunction = eval(externalInitFunctionName);
		if (externalInitFunction != null) {
			externalInitFunction(this.controller);
		} else if (console) {
			console.log('External init function [' + externalInitFunctionName + '] not found');
		}
	}
}

ProductConfigurationCtrl.prototype.setSaveCallback = function(/*Function*/ callback) {
	this.saveCallback = callback;
}

ProductConfigurationCtrl.prototype.setCancelCallback = function(/*Function*/ callback) {
	this.cancelCallback = callback;
}

ProductConfigurationCtrl.prototype.onSave = function() {
	var scope = this.controller.scope;
	var controller = scope.controller;
	if (controller.scope.active) {
		var valid = true;
		var affectedAreasMap = {};
		angular.forEach(scope.configuredProducts, function(product) {
			valid = valid && product.validateConfigurationAttributes(affectedAreasMap);
		}, this);
		if (!valid) {
			var affectedAreas = [];
			angular.forEach(affectedAreasMap, function(value,key) {
				if (value) {
					affectedAreas.push(key);
				}
			});
			var msg = scope.labels.invalidConfigData;
			msg = msg.replace('{0}', affectedAreas.join(', '));
			scope.messages = [{severity:'error',summary:msg}];
			return;
		}

		scope.blockingOperationInProgress = true;
		scope.messages = null;

		if (this.configurationStack.length == 0) {
			// We are at the root; add packages to quote
			var targetCtrl = this.controllerManager.lookup('QuoteLineEditor');
			var groupKey = scope.quote.selectedGroupKey;
			var quoteProcess = null;
			var products = this.configuredProducts;
			var psm = (targetCtrl != null) ? targetCtrl.scope.productSelectionModel : null;
			if (psm != null) {
				psm.updateConfigurations(products);
				products = psm.selectedProducts;
				groupKey = psm.targetGroupKey;
				quoteProcess = psm.quoteProcess;
			} else {
				products[0] = products[0].createVO();
			}
			if (targetCtrl != null) {
				targetCtrl.addProducts(this.controller, groupKey, products, quoteProcess);
			} else if (controller.saveCallback != null) {
				controller.saveCallback(products);
			}
		} else {
			var successHandler = function(/*String*/ result) {
				var config = angular.fromJson(result);
				scope.configuredProducts[0].updateConfiguration(config);

				if ((config.validationMessages == null) || (config.validationMessages.length == 0)) {
					var state = scope.configurationStack.pop();
					var product = scope.configuredProducts[0];
					scope.selectedConfiguration.updateNestedConfigurations(product.configuration.createVO());
					scope.selectedConfiguration.configured = true;
					scope.configuredProducts = state.configuredProducts;
					scope.selectedConfiguration = state.selectedConfiguration;
				}
				if (scope.configurationStack.length == 1) {
					scope.upgradedAssetId = null;
				}
				scope.blockingOperationInProgress = false;
				scope.$apply();
			}
			var upgradedAssetId = (this.configuredProducts[0].upgradedAssetId == null) ? scope.upgradedAssetId : this.configuredProducts[0].upgradedAssetId;
			this.productService.saveConfiguration(scope.quote, this.configuredProducts[0].configuration.createVO(), upgradedAssetId, successHandler, this.controller.createErrorHandler());
		}
	}
	var checkBlockingOperation = setInterval(function() {
		if (scope.blockingOperationInProgress == false) {
			if (scope.configuredProducts[0].configuration.validationMessages.length > 0) {
				window.scrollTo(0, 120);
			}
			clearInterval(checkBlockingOperation);	
		}
	}, 200);
}

ProductConfigurationCtrl.prototype.onCancel = function() {
	var scope = this.controller.scope;

	if (scope.configurationStack.length == 0) {
		var targetCtrl = scope.controllerManager.lookup('QuoteLineEditor');
		if (targetCtrl != null) {
			scope.controllerManager.activateController(targetCtrl);
		} else if (controller.cancelCallback != null) {
			controller.cancelCallback();
		}
	} else {
		var state = scope.configurationStack.pop();
		scope.configuredProducts = state.configuredProducts;
		scope.selectedConfiguration = state.selectedConfiguration;
	}
}

ProductConfigurationCtrl.prototype.onConfigureOption = function(/*ProductConfigurationModel*/ config) {
	// 'this' refers to descendant scope of controller scope; we need to use the controller scope
	var scope = this.controller.scope;
	scope.configuredProducts[0].configuration.validationMessages.pop();
	scope.blockingOperationInProgress = true;
	scope.messages = null;

	var successHandler = function(/*String*/ result) {
		if (scope.configurationStack.length == 0) {
			scope.upgradedAssetId = config.parentProduct.upgradedAssetId;
		}
		scope.configurationStack.push({configuredProducts:scope.configuredProducts,selectedConfiguration:scope.selectedConfiguration});
		scope.selectedConfiguration = config;
		var products = angular.fromJson(result);
		if (config.configured) {
			products[0].configuration = config.createVO();
		}
		if (products[0].options.length == 0) {
			// case where product option has no options but is set to configuration required/always
			scope.messages = [{severity:'error', summary: scope.labels.configurableHasNoOptions}];
			config.selected = false;
			config.option.noOptions = true; // makes read-only
			config.option.configurable = false;
			config.option.configurationRequired = false;
			scope.blockingOperationInProgress = false;
			scope.$apply();
		} else {
			scope.controller.setConfiguredProducts(products);
			scope.blockingOperationInProgress = false;
			scope.$apply();
		}
	}
	scope.productService.loadConfiguredProducts(scope.quote, [config.option.getOptionalProductId()], successHandler, this.controller.createErrorHandler());
}

ProductConfigurationCtrl.prototype.onSelectionChanged = function(/*ProductModel*/ configuredProduct, /*ProductConfigurationModel*/ config) {
	// Process constraints

	var parentFeature = config.optionData ? configuredProduct.featuresById[config.optionData[ProductOptionModel.FEATURE_ID_FIELD]] : configuredProduct.featuresById[config];
	if (parentFeature && parentFeature.record[ProductFeatureModel.MAX_OPTION_COUNT_FIELD] == 1){
		angular.forEach(parentFeature.optionConfigurations, function(optionConfiguration){
			if (optionConfiguration.optionId != config.optionId) {	
				optionConfiguration.selected = false;
			} else {
				optionConfiguration.selected = true;
			}
		})
	}

	configuredProduct.configuration.evaluateConstraints(config);
	if (config.option && config.option.isAppliedImmediately()) {
		this.controller.updateConfiguration(configuredProduct);
	}
}

ProductConfigurationCtrl.prototype.onConfigurationAttributeChanged = function(/*ProductModel*/ configuredProduct, /*ConfigurationAttributeModel*/ configAttr) {
	// Process constraints
	if (configAttr.appliedImmediately) {
		this.controller.updateConfiguration(configuredProduct);
	}
}

ProductConfigurationCtrl.prototype.onPreviousFeature = function(/*ProductModel*/ configuredProduct) {
	var features = configuredProduct.getVisibleFeatures();
	for (var i=0;i<features.length;i++) {
		if ((configuredProduct.activeFeature == features[i]) && (i > 0)) {
			configuredProduct.activeFeature = features[i - 1];
			return;
		}
	}
}

ProductConfigurationCtrl.prototype.onNextFeature = function(/*ProductModel*/ configuredProduct) {
	var features = configuredProduct.getVisibleFeatures();
	for (var i=0;i<features.length;i++) {
		if ((configuredProduct.activeFeature == features[i]) && (i < (features.length - 1))) {
			configuredProduct.activeFeature = features[i + 1];
			return;
		}
	}
}

ProductConfigurationCtrl.prototype.updateConfiguration = function(/*ProductModel*/ configuredProduct) {
	var scope = this.scope;
	scope.blockingOperationInProgress = true;
	scope.messages = null;

	var successHandler = function(/*String*/ result) {
		var config = angular.fromJson(result);
		configuredProduct.updateConfiguration(config);
		scope.blockingOperationInProgress = false;
		scope.$apply();
	}
	var upgradedAssetId = (configuredProduct.upgradedAssetId == null) ? scope.upgradedAssetId : configuredProduct.upgradedAssetId;
	scope.productService.updateConfiguration(scope.quote, configuredProduct.configuration.createVO(), upgradedAssetId, successHandler, this.createErrorHandler());
}

ProductConfigurationCtrl.prototype.configureProducts = function(/*Controller*/ srcController, /*QuoteVO*/ quote, /*ProductVO[]*/ configuredProducts) {
	var scope = this.scope;
	var controller = this;
	scope.quote = quote;

	if (srcController == null) {
		srcController = controller;
	}

	var metaDataCompleteHandler = function() {
		var optionMD = scope.metaDataService.getMetaData(ProductOptionModel.OBJECT_NAME);
		if (optionMD != null) {
			var qtyField = optionMD.getField(ProductOptionModel.QUANTITY_FIELD);
			if (qtyField != null) {
				qtyField.scale = scope.quantityScale;
			}
		}
		try {
			controller.setConfiguredProducts(configuredProducts);
		} catch (e) {
			controller.handleError(e);
		}
		scope.controllerManager.activateController(controller);
		resizeTableResults('#sbProductConfigurator');
    	$(window).resize(); // dynamically adjust page header
	}
	scope.blockingOperationInProgress = true;
	controller.executeApply();
	scope.metaDataService.ensureObjectMetaData([ProductOptionModel.OBJECT_NAME], metaDataCompleteHandler, srcController);
}

ProductConfigurationCtrl.prototype.configureQuoteLine = function(/*Controller*/ srcController, /*QuoteVO*/ quote, /*Integer*/ lineKey) {
	var scope = this.scope;
	var controller = this;
	scope.quote = quote;

	if (srcController == null) {
		srcController = controller;
	}

	var metaDataCompleteHandler = function() {
		try {
			controller.setConfiguredProducts(configuredProducts);
		} catch (e) {
			handleError(e);
		}
		scope.controllerManager.activateController(controller);
	}
	scope.blockingOperationInProgress = true;
	controller.executeApply();
	scope.metaDataService.ensureObjectMetaData([ProductOptionModel.OBJECT_NAME], metaDataCompleteHandler, srcController);
}

ProductConfigurationCtrl.prototype.setConfiguredProducts = function(/*ProductVO[]*/ configuredProducts) {
	var scope = this.scope;
	scope.configuredProducts = jQuery.map(configuredProducts, function(value) {
		var newProductModel = new ProductModel(value, scope.metaDataService);
		var newCtrl = scope.controllerManager.lookup('QuoteLineEditor');
		newProductModel.settings = newCtrl.editorModel != null ? newCtrl.editorModel.settings : newCtrl.scope.editorModel.settings;
		return newProductModel;
	});
}

ProductConfigurationCtrl.prototype.onLookupOption = function(/*ProductFeatureModel*/ feature) {
	var scope = this.controller.scope;
	scope.messages = null;

	try {
		scope.selectedFeature = feature;
		scope.configurationMode = false;
		scope.optionLookupMode = true;
	} catch (e) {
		scope.controller.handleError(e);
	}
	setTimeout(function() {
		resizeTableResults('#sbProductConfigurator');
    	$(window).resize(); // dynamically adjust page header
	}, 50);
}

ProductConfigurationCtrl.prototype.onAddOption = function() {
	var scope = this.controller.scope;
	if (scope.selectedFeature != null) {
		var selectionCount = 0;
		angular.forEach(scope.selectedFeature.getAvailableOptions(), function(/*ProductOptionModel*/ option) {
			selectionCount += (option.selected || option.record.Id == scope.selectedFeature.selectedOptionId) ? 1 : 0;
		}, this);
		if (selectionCount + scope.selectedFeature.optionConfigurations.length > scope.selectedFeature.record[ProductFeatureModel.MAX_OPTION_COUNT_FIELD]) {
			scope.messages = [{severity:'error', summary: this.labels.tooManyOptionsSelected}];
		} else {
			angular.forEach(scope.selectedFeature.getAvailableOptions(), function(/*ProductOptionModel*/ option) {
				if (option.selected == true || option.record.Id == scope.selectedFeature.selectedOptionId) {
					var product = scope.selectedFeature.configuredProduct;
					var config = product.configuration;
					var optionConfig = new ProductConfigurationModel(product, null, {optionId:option.record.Id});
					optionConfig.option = option;
					optionConfig.selected = true;
					optionConfig.quantityEditable = (option.getQuantity() == null);
					optionConfig.optionData = angular.copy(option.record);
					optionConfig.listPrice = option.record[ProductOptionModel.UNIT_PRICE_FIELD];
					config.optionConfigurations.push(optionConfig);
					option.selected = false;
				}
			}, this);
			scope.selectedFeature.configuredProduct.assignConfigurationsToFeatures();
			scope.configurationMode = true;
			scope.optionLookupMode = false;
			scope.messages = null;
		}
	}
	setTimeout(function() {
		resizeTableResults('#sbProductConfigurator');
    	$(window).resize(); // dynamically adjust page header
	}, 50);
}

ProductConfigurationCtrl.prototype.onDeleteOption = function(/*ProductConfigurationModel*/ config) {
	var idx = config.parentProduct.configuration.optionConfigurations.indexOf(config);
	if (idx >= 0) {
		config.parentProduct.configuration.optionConfigurations.splice(idx,1);
		config.parentProduct.assignConfigurationsToFeatures();
	}
}

ProductConfigurationCtrl.prototype.onCancelOptionLookup = function(/*ProductFeatureModel*/ feature) {
	var scope = this.controller.scope;
	scope.configurationMode = true;
	scope.optionLookupMode = false;
	setTimeout(function() {
		resizeTableResults('#sbProductConfigurator');
    	$(window).resize(); // dynamically adjust page header
	}, 50);
}

ProductConfigurationCtrl.prototype.onEditOptionConfig = function(/*ProductConfigurationModel*/ config) {
	this.controller.scope.optionDetailMode = true;
	this.controller.scope.editedOptionConfigs = [config];
}

ProductConfigurationCtrl.prototype.displayErrorMessage = function(message) {
	this.scope.messages = [{severity:'error', summary: message}];
	this.scope.blockingOperationInProgress = false;
}

/**
 * Model object that wraps ProductVO to add rendering logic.
 */
function ProductModel(/*ProductVO*/ data, /*MetaDataService*/ metaDataService) {
	ModelUtils.copyProperties(data, this);
	this.configurationFormTitle = data.record[ProductModel.CONFIGURATION_FORM_TITLE_FIELD];
	this.optionConfigurationFields = metaDataService.getMetaData(ProductOptionModel.OBJECT_NAME).getFields(data.optionConfigurationFieldNames);
	this.optionConfigurationFieldsTablet = this.optionConfigurationFields;
	this.optionConfigurationFieldsPhone = this.optionConfigurationFields;
	if (data.optionConfigurationFieldNamesTablet.length > 0) {
		this.optionConfigurationFieldsTablet = metaDataService.getMetaData(ProductOptionModel.OBJECT_NAME).getFields(data.optionConfigurationFieldNamesTablet);
	}
	if (data.optionConfigurationFieldNamesPhone.length > 0) {
		this.optionConfigurationFieldsPhone = metaDataService.getMetaData(ProductOptionModel.OBJECT_NAME).getFields(data.optionConfigurationFieldNamesPhone);
	}
	this.optionLookupFields = metaDataService.getMetaData(ProductOptionModel.OBJECT_NAME).getFields(data.optionLookupFieldNames);

	// Wrap option VOs in ProductOptionModel objects
	var hasOptionsWithoutFeature = false;
	this.optionsById = {};
	var configuredProduct = this;
	var optionsById = this.optionsById;
	this.options = jQuery.map(this.options, function(value) {
		var option = new ProductOptionModel(configuredProduct, value);
		if (option.getFeatureId() == null) {
			hasOptionsWithoutFeature = true;
		}
		optionsById[option.record.Id] = option;
		return option;
	});

	// Wrap feature VOs in ProductFeatureModel objects
	this.features = jQuery.map(this.features, function(value) {
		return new ProductFeatureModel(configuredProduct, value);
	});
	if (hasOptionsWithoutFeature) {
		var feature = new ProductFeatureModel(configuredProduct, {options:[],record:{Id:null,Name:'Other Options'},addOptionButtonLabel:'Add Option'});
		for (var i=0; i<this.options.length; i++) {
			if (this.options[i].getFeatureId() == null) {
				feature.options.push(this.options[i]);
			}
		}
		this.features.push(feature);
	}
	if (this.features.length > 0) {
		this.features[0].first = true;
		this.activeFeature = this.features[0];
		this.features[this.features.length - 1].last = true;
	}
	if (this.isLayoutTabs()) {
		this.featureTabModel = new TabSetModel();
		angular.forEach(this.features, function(feature) {
			var tab = this.featureTabModel.addTab(feature.record.Id, feature.record.Name, false);
			tab.feature = feature;
		}, this);
	}
	if (this.isFeatureCategoryUsed()) {
		this.featureCategoryTabModel = new TabSetModel();
		angular.forEach(this.featureCategories, function(category) {
			var tab = this.featureCategoryTabModel.addTab(category, category, false);
			tab.features = this.filterFeaturesByCategory(category);
		}, this);
		var featuresWithoutCategories = this.filterFeaturesByCategory(undefined);
		if (featuresWithoutCategories.length > 0) {
			var otherTab = this.featureCategoryTabModel.addTab('Other', 'Other', false);
			otherTab.features = featuresWithoutCategories;
		}
	}

	this.indexFeatures();
	this.processConfigurationAttributes(data, metaDataService);
	this.updateConfiguration(this.configuration);

	angular.forEach(this.features, function(feature) {
		if (feature.record[ProductFeatureModel.MAX_OPTION_COUNT_FIELD] == 1) {
			feature.selectedOptionId = null;
			angular.forEach(feature.optionConfigurations, function(optionConfig){
				if (optionConfig.selected) {
					if (feature.selectedOptionId == null) {
						feature.selectedOptionId = optionConfig.optionId;
					} else {
						feature.selectedOptionId = "Too many preselected options"; 
					}
				}
			});
		}
	}, this);
}

ProductModel.prototype.getOptionConfigurationFields = function(/*String*/ formFactor) {
	if (formFactor == 'phone') {
		return this.optionConfigurationFieldsPhone;
	} else if (formFactor == 'tablet') {
		return this.optionConfigurationFieldsTablet;
	}
	return this.optionConfigurationFields;
}

ProductModel.prototype.hasMoreOptionConfigurationFields = function(/*String*/ formFactor) {
	if (formFactor == 'phone') {
		return (this.optionConfigurationFields.length > this.optionConfigurationFieldsPhone.length);
	} else if (formFactor == 'tablet') {
		return (this.optionConfigurationFields.length > this.optionConfigurationFieldsTablet.length);
	}
	return false;
}

ProductModel.prototype.indexFeatures = function() {
	// Assign option configs to features
	this.featuresById = {};
	angular.forEach(this.features, function(feature) {
		this.featuresById[feature.record.Id] = feature;
	}, this);
}

ProductModel.prototype.updateConfiguration = function(/*ProductConfigurationVO*/ configuration) {
	// Wrap configuration VO in ProductConfigurationModel object.
	this.configuration = new ProductConfigurationModel(null, this, configuration);
	this.assignConfigurationsToFeatures();
}

ProductModel.prototype.assignConfigurationsToFeatures = function() {
	angular.forEach(this.features, function(feature) {
		feature.optionConfigurations = [];
	});

	// Assign option configs to features and set radio button selection
	angular.forEach(this.configuration.optionConfigurations, function(config) {
		var feature = this.featuresById[config.option.getFeatureId()];
		if (feature != null) {
			feature.optionConfigurations.push(config);
			if (config.selected) {
				feature.selectedOptionId = config.optionId;
			} else if (feature.selectedOptionId == config.optionId) {
				feature.selectedOptionId = null;
			}
		}
	}, this);
}

ProductModel.prototype.processConfigurationAttributes = function(/*ConfigurationAttribute*/ data, /*MetaDataService*/ metaDataService) {
	this.allConfigurationAttributes = [];
	this.topConfigurationAttributes = new TableLayoutModel();
	this.bottomConfigurationAttributes = new TableLayoutModel();
	angular.forEach(data.configurationAttributes, function(attribute) {
		var attrModel = new ConfigurationAttributeModel(attribute, metaDataService);
		this.allConfigurationAttributes.push(attrModel);
		var attrTarget = this;
		if (attrModel.featureId != null) {
			attrTarget = this.featuresById[attrModel.featureId];
		}
		if (attrModel.isPositionTop()) {
			attrTarget.topConfigurationAttributes.addItem(attrModel, attrModel.columnOrder, attrModel.displayOrder);
		} else if (attrModel.isPositionBottom()) {
			attrTarget.bottomConfigurationAttributes.addItem(attrModel, attrModel.columnOrder, attrModel.displayOrder);
		}
		attrModel.parent = attrTarget;
	}, this);
	this.topConfigurationAttributes.transposeRowsToColumns();
	this.bottomConfigurationAttributes.transposeRowsToColumns();
	angular.forEach(this.features, function(feature) {
		feature.topConfigurationAttributes.transposeRowsToColumns();
		feature.bottomConfigurationAttributes.transposeRowsToColumns();
	})
}

ProductModel.prototype.filterFeaturesByCategory = function(/*String*/ category) {
	var result = [];
	angular.forEach(this.features, function(feature) {
		if (feature.record[ProductFeatureModel.CATEGORY_FIELD] == category) {
			result.push(feature);
		}
	}, this);
	return result;
}

ProductModel.prototype.getConfigurationPageURL = function() {
}

ProductModel.prototype.isLayoutSections = function() {
	var layout = this.record[ProductModel.OPTION_LAYOUT_FIELD];
	return (layout == null) || (layout == '') || (layout == 'Sections');
}

ProductModel.prototype.isLayoutTabs = function() {
	var layout = this.record[ProductModel.OPTION_LAYOUT_FIELD];
	return (layout == 'Tabs');
}

ProductModel.prototype.isLayoutWizard = function() {
	var layout = this.record[ProductModel.OPTION_LAYOUT_FIELD];
	return (layout == 'Wizard');
}

ProductModel.prototype.isOptionSelectionMethodAdd = function() {
	var method = this.record[ProductModel.OPTION_SELECTION_METHOD_FIELD];
	return (method == 'Add');
}

ProductModel.prototype.isOptionSelectionMethodClick = function() {
	var method = this.record[ProductModel.OPTION_SELECTION_METHOD_FIELD];
	return (method == null) || (method == '') || (method == 'Click');
}

ProductModel.prototype.isActionColumnShown = function() {
	var shown = !this.isOptionSelectionMethodClick();
	angular.forEach(this.options, function(option) {
		shown = shown || option.configurable;
	}, this);
	return shown;
}

ProductModel.prototype.isFeatureCategoryUsed = function() {
	return (this.featureCategories != null) && (this.featureCategories.length > 0);
}

ProductModel.prototype.validateConfigurationAttributes = function(/*Object*/ affectedAreas) {
	var valid = true;
	angular.forEach(this.allConfigurationAttributes, function(configAttr) {
		if (configAttr.required) {
			configAttr.missingValue = ModelUtils.isBlank(this.configuration.configurationData[configAttr.targetFieldName]);
			valid = valid && !configAttr.missingValue;
			if ((affectedAreas != null) && (configAttr.parent != null) && !affectedAreas[configAttr.parent.record.Name]) {
				affectedAreas[configAttr.parent.record.Name] = true;
			}
		}
	}, this);
	return valid
}

ProductModel.prototype.createVO = function() {
	var result = {record:{Id:this.record.Id}};
	result.configuration = this.configuration.createVO();
	result.upgradedAssetId = this.upgradedAssetId;
	return result;
}

ProductModel.prototype.getQuantityField = function() {
	return ProductOptionModel.QUANTITY_FIELD;
}

ProductModel.prototype.getVisibleFeatures = function() {
	var featuresShown = [];
	for (var i=0;i<this.features.length;i++) {
		if (this.features[i].isShown()) {
			featuresShown.push(this.features[i]);
		}
	}
	return featuresShown;
}



function ProductFeatureModel(/*ProductModel*/ configuredProduct, /*ProductVO.Feature*/ data) {
	ModelUtils.copyProperties(data, this);
	this.active = false;
	this.configuredProduct = configuredProduct;
	this.optionConfigurations = [];
	this.availableOptions = null;
	this.topConfigurationAttributes = new TableLayoutModel();
	this.bottomConfigurationAttributes = new TableLayoutModel();
}

ProductFeatureModel.prototype.getTitle = function() {
	return (this.record != null) ? this.record['Name'] : this.configuredProduct.virtualFeatureTitle;
}

ProductFeatureModel.prototype.getOptionLookupFields = function() {
	var excludedFields = {};
	if (!ModelUtils.isBlank(this.addOptionExcludedFields)) {
		angular.forEach(this.addOptionExcludedFields.split(','), function(/*String*/ fieldName) {
			excludedFields[fieldName] = true;
		}, this);
	}

	var fields = [];
	angular.forEach(this.configuredProduct.optionLookupFields, function(/*Field*/ field) {
		if (!excludedFields[field.name]) {
			fields.push(field);
		}
	}, this);
	return fields;
}

ProductFeatureModel.prototype.getAvailableOptions = function() {
	if (this.availableOptions == null) {
		this.availableOptions = [];
		angular.forEach(this.configuredProduct.options, function(/*ProductOptionModel*/ option) {
			if (option.getFeatureId() == this.record.Id) {
				this.availableOptions.push(option);
			}
		}, this);
	}
	return this.availableOptions;
}

ProductFeatureModel.prototype.isShown = function() {
	if ((this.hasVisibleOptionConfigurations() || this.hasConfigurationAttributes()) && this.configuredProduct.isOptionSelectionMethodClick()) {
		return this.optionConfigurations.length > 0;
	} else if ((this.hasVisibleOptions() || this.hasConfigurationAttributes()) && this.configuredProduct.isOptionSelectionMethodAdd()) {
		return this.getAvailableOptions().length > 0;
	}
	return false;
}

ProductFeatureModel.prototype.hasAdditionalInstructions = function() {
	return !ModelUtils.isBlank(this.additionalInstructions);
}

ProductFeatureModel.prototype.hasVisibleOptionConfigurations = function() {
	for (var i=0;i<this.optionConfigurations.length;i++) {
		if (!this.optionConfigurations[i].hidden) {
			return true;
		}
	}
	return false;
}

ProductFeatureModel.prototype.hasVisibleOptions = function() {
	if (this.options != undefined) {
		for (var i=0;i<this.options.length;i++) {
			if (!this.options[i].hidden) {
				return true;
			}
		}
	}
	return false;
}

ProductFeatureModel.prototype.hasConfigurationAttributes = function() {
	var configurationAttributeIds = {};
	var allConfigs = this.configuredProduct.allConfigurationAttributes;
	for (var i=0;i<allConfigs.length;i++) {
		configurationAttributeIds[allConfigs[i].featureId] = true;
	}
	return configurationAttributeIds[this.record.Id] == true ? true : false;
}

ProductFeatureModel.prototype.isSingleSelection = function() {
	return this.record[ProductFeatureModel.MAX_OPTION_COUNT_FIELD] == 1;
}

ProductFeatureModel.prototype.hasOptionCountOfZeroOrOne = function() {
	return (this.record[ProductFeatureModel.MAX_OPTION_COUNT_FIELD] == 1 && this.record[ProductFeatureModel.MIN_OPTION_COUNT_FIELD] == 0);
}

ProductFeatureModel.prototype.selectedOptionsGreaterOrEqualMax = function() {
	return (this.optionConfigurations.length >= this.record[ProductFeatureModel.MAX_OPTION_COUNT_FIELD]);
}


function ProductOptionModel(/*ProductModel*/ configuredProduct, /*ProductVO.Option*/ data) {
	ModelUtils.copyProperties(data, this);
	this.configuredProduct = configuredProduct;
}

ProductOptionModel.prototype.isReadOnly = function() {
	return this.isRequired() || this.isSystem() || this.isValid();
}

ProductOptionModel.prototype.isRequired = function() {
	return (this.record[ProductOptionModel.REQUIRED_FIELD] == true);
}

ProductOptionModel.prototype.isSystem = function() {
	return (this.record[ProductOptionModel.SYSTEM_FIELD] == true);
}

ProductOptionModel.prototype.isValid = function() {
	return (this.noOptions == true);
}

ProductOptionModel.prototype.isAppliedImmediately = function() {
	return (this.record[ProductOptionModel.APPLY_IMMEDIATELY_FIELD] == true);
}

ProductOptionModel.prototype.getQuantity = function() {
	var value = this.record[ProductOptionModel.QUANTITY_FIELD];
	return (value == undefined) ? null : value;
}

ProductOptionModel.prototype.getFeatureId = function() {
	var value = this.record[ProductOptionModel.FEATURE_ID_FIELD];
	return (value == undefined) ? null : value;
}

ProductOptionModel.prototype.getOptionalProductId = function() {
	return this.record[ProductOptionModel.OPTIONAL_SKU_FIELD];
}

ProductOptionModel.prototype.getOptionalProductId = function() {
	return this.record[ProductOptionModel.OPTIONAL_SKU_FIELD];
}

ProductOptionModel.prototype.isPriceEditable = function() {
	return (this.record[ProductOptionModel.PRICE_EDITABLE_FIELD] == 'Yes');
}



function ProductConfigurationModel(/*ProductModel*/ parentProduct, /*ProductModel*/ configuredProduct, /*ProductConfigurationVO*/ configuration, /*Boolean*/ selected) {
	ModelUtils.copyProperties(configuration, this);
	this.configuredProduct = configuredProduct;
	this.parentProduct = parentProduct;
	this.selected = (selected == true);
	if (this.configurationData == null) {
		this.configurationData = {};
	}
	this.validationMessages = [];
	angular.forEach(configuration.validationMessages, function(msg) {
		this.validationMessages.push({severity:'error',summary:msg});
	}, this);
	var disabledOptionIdx = {};
	angular.forEach(configuration.disabledOptionIds, function(id) {
		disabledOptionIdx[id] = true;
	}, this);
	var hiddenOptionIdx = {};
	angular.forEach(configuration.hiddenOptionIds, function(id) {
		hiddenOptionIdx[id] = true;
	}, this);

	// Reset option configs; it contains VOs and needs to be initialized
	this.optionConfigurations = [];
	this.dependentConfigurations = [];
	this.excludedConfigurations = [];
	this.optionConfigurationsIndex = {};
	if (configuredProduct != null) {
		// Initialize option configs
		if (configuredProduct.isOptionSelectionMethodClick()) {
			var configsByOptionId = {};
			// Index option configs present in the VO; these are selected options.
			angular.forEach(configuration.optionConfigurations, function(config) {
				configsByOptionId[config.optionId] = config;
			}, this);

			// Create config model for every available option selecting ones present in the VO
			angular.forEach(configuredProduct.options, function(option) {
				if (option.record[ProductOptionModel.UNIT_PRICE_FIELD] != null) {
					var optionSelected = true;
					var config = configsByOptionId[option.record.Id];
					if (config == null) {
						optionSelected = false;
						config = {optionId:option.record.Id};
					}
					var model = new ProductConfigurationModel(configuredProduct, null, config, optionSelected);
					model.disabled = (disabledOptionIdx[option.record.Id] == true);
					model.hidden = (hiddenOptionIdx[option.record.Id] == true);
					this.optionConfigurations.push(model);
					this.optionConfigurationsIndex[option.record.Id] = model;
				}
			}, this);
		} else if (configuredProduct.isOptionSelectionMethodAdd()) {
			// Create config model only for options present in the VO
			angular.forEach(configuration.optionConfigurations, function(config) {
				this.optionConfigurations.push(new ProductConfigurationModel(configuredProduct, null, config, true));
			}, this);
		}

		// Connect each config with its master option record & evaluate constraints
		angular.forEach(this.optionConfigurations, function(config) {
			config.setOption(this.configuredProduct.optionsById[config.optionId]);
			this.evaluateConstraints(config);
		}, this);
	} else {
		// When building from nested options the configured product is not available.
		// In that case, just add all configs as selected
		angular.forEach(configuration.optionConfigurations, function(config) {
			this.optionConfigurations.push(new ProductConfigurationModel(configuredProduct, null, config, true));
		}, this);
	}
}

ProductConfigurationModel.prototype.evaluateConstraints = function(/*ProductConfigurationModel*/ config) {
	if (config.option != null) {
		// Process controlling options
		angular.forEach(config.option.controllingIds, function(controllingOptionId) {
			var controllingConfig = this.optionConfigurationsIndex[controllingOptionId];
			if (controllingConfig != null) {
				config.disabled = !controllingConfig.selected;
			}
		}, this);

		// Process dependent options
		angular.forEach(config.option.dependentIds, function(dependentOptionId) {
			var dependentConfig = this.optionConfigurationsIndex[dependentOptionId];
			if (dependentConfig != null) {
				dependentConfig.disabled = !config.selected;
				if (!config.selected) {
					dependentConfig.selected = false;
				}
			}
		}, this);

		// Process exclusive options
		angular.forEach(config.option.exclusionIds, function(exclusiveOptionId) {
			var exclusiveConfig = this.optionConfigurationsIndex[exclusiveOptionId];
			if (exclusiveConfig != null) {
				exclusiveConfig.disabled = config.selected;
				if (config.selected) {
					exclusiveConfig.selected = false;
				}
			}
		}, this);
	}
}

ProductConfigurationModel.prototype.isEditable = function(/*Field*/ field) {
	if (field.name == ProductOptionModel.QUANTITY_FIELD) {
		return this.quantityEditable;
	} else if (field.name == ProductOptionModel.UNIT_PRICE_FIELD) {
		return this.priceEditable;
	}
	return false;
}

ProductConfigurationModel.prototype.setOption = function(/*ProductOptionModel*/ option) {
	var optionRecord = angular.copy(option.record);
	ModelUtils.copyProperties(this.optionData, optionRecord);
	this.optionData = optionRecord;
	this.option = option;
	this.quantityEditable = (option.getQuantity() == null) || option.record[ProductOptionModel.QUANTITY_EDITABLE_FIELD];
	this.priceEditable = option.isPriceEditable();
	if (this.optionData[ProductOptionModel.QUANTITY_FIELD] ==  null) {
		var minQty = this.optionData[ProductOptionModel.MIN_QUANTITY_FIELD];
		this.optionData[ProductOptionModel.QUANTITY_FIELD] = (minQty != null) ? minQty : 1;
	}
	if (this.listPrice == null) {
		this.listPrice = option.record[ProductOptionModel.UNIT_PRICE_FIELD];
	}
	this.calculate();
}

ProductConfigurationModel.prototype.createVO = function() {
	var vo = {};
	ModelUtils.copyProperties(this, vo);
	delete vo.configuredProduct;
	delete vo.parentProduct;
	delete vo.option;
	delete vo.optionConfigurationsIndex;
	delete vo.validationMessages;
	if (this.optionConfigurations != null) {
		vo.optionConfigurations = jQuery.map(this.optionConfigurations, function(config) {
			if (config.selected == true) {
				return config.createVO();
			}
			return null;
		});
	}

	return vo;
}

ProductConfigurationModel.prototype.updateNestedConfigurations = function(/*ProductConfigurationVO*/ config) {
	this.configuredProductId = config.configuredProductId;
	if (config.configurationData != null) {
		this.configurationData = config.configurationData;
	}
	var configuredProduct = this.configuredProduct;
	if (config.optionConfigurations != null) {
		this.optionConfigurations = jQuery.map(config.optionConfigurations, function(configVO) {
			return new ProductConfigurationModel(configuredProduct, null, configVO, true);
		});
	}
}

ProductConfigurationModel.prototype.calculate = function() {
	var discountRate = this.optionData[ProductOptionModel.DISCOUNT_FIELD];
	var discountAmount = this.optionData[ProductOptionModel.DISCOUNT_AMOUNT_FIELD];
	var unitPrice = this.optionData[ProductOptionModel.UNIT_PRICE_FIELD];

	if (!this.priceEditable) {
		if (discountRate != null) {
			this.optionData[ProductOptionModel.UNIT_PRICE_FIELD] = this.listPrice * discountRate / 100;
		} else if (discountAmount != null) {
			this.optionData[ProductOptionModel.UNIT_PRICE_FIELD] = this.listPrice - discountAmount;
		}
	}
}

ProductConfigurationModel.prototype.getInputId = function(/*Field*/ field) {
	return this.configuredProductId + '_' + field.name;
}

ProductConfigurationModel.prototype.getReadOnlyClass = function() {
	return (this.selected) ? 'checked' : 'unchecked';
}

ProductConfigurationModel.prototype.getScale = function(/*Field*/ field) {
	if (field.name == QuoteLineModel.QUANTITY_FIELD) {
		return this.optionData[ProductOptionModel.PRODUCT_QUANTITY_SCALE_FIELD] != null ? this.optionData[ProductOptionModel.PRODUCT_QUANTITY_SCALE_FIELD] : this.parentProduct.settings.quantityScale;
	}
	return field.scale;
}



function ConfigurationAttributeModel(/*ConfigurationAttribute*/ data, /*MetaDataService*/ metaDataService) {
	ModelUtils.copyProperties(data, this);
	this.targetField = metaDataService.getMetaData(ProductOptionModel.OBJECT_NAME).getField(this.targetFieldName);
	if ((this.targetField != null) && this.targetField.isPicklist() &&(!ModelUtils.isBlank(data.shownValues) || !ModelUtils.isBlank(data.hiddenValues))) {
		// Clone the field; otherwise, we'll modify the master list of options.
		this.targetField = this.targetField.clone(this.targetField);
		if (!ModelUtils.isBlank(data.shownValues)) {
			this.targetField.filterShownValues(data.shownValues);
		} else if (!ModelUtils.isBlank(data.hiddenValues)) {
			this.targetField.filterHiddenValues(data.hiddenValues);
		}
	}
}

ConfigurationAttributeModel.prototype.isPositionTop = function() {
	return (this.position == 'Top');
}

ConfigurationAttributeModel.prototype.isPositionBottom = function() {
	return (this.position == 'Bottom');
}



// NOT USED AT THE MOMENT

function OptionLookupDialog() {
    this.id = 'OptionLookupDialog';
    this.isModal = true;
    this.width = '910px';
    this.height = '600px';
    this.title = '';
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
    this.contentWrapper = document.createElement("div");
    var optionLookupContainer = document.getElementById('optionLookupContainer');
    this.contentWrapper.appendChild(optionLookupContainer);
    content.appendChild(this.contentWrapper);
    this.contentCreated = true;
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