function RemotingQuoteServiceProxy(/*String*/ namespace) {
	this.namespace = namespace;
	this.prefix = (this.namespace == '') ? '' : this.namespace + '.';
}
RemotingQuoteServiceProxy.prototype = new RemotingServiceProxy();

RemotingQuoteServiceProxy.prototype.loadQuoteEditor = function(/*String*/ quoteId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.loadQuoteEditor', quoteId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.addProducts = function(/*QuoteModel*/ quote, /*Integer*/ targetGroupKey, /*Array<ProductVO>*/ products, /*QuoteProcessVO*/ quoteProcess, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.addProducts', angular.toJson(quote), targetGroupKey, angular.toJson(products), angular.toJson(quoteProcess), this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.renewSubscriptions = function(/*QuoteModel*/ quote, /*Integer*/ targetGroupKey, /*SubscriptionVO[]*/ subscriptions, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.renewSubscriptions', angular.toJson(quote), targetGroupKey, angular.toJson(subscriptions), this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.saveQuote = function(/*QuoteModel*/ quote, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.saveQuote', angular.toJson(quote), this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.calculateQuote = function(/*QuoteModel*/ quote, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.calculateQuote', angular.toJson(quote), this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.setSelectedGroupOptional = function(/*QuoteModel*/ quote, /*Boolean*/ optional, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.setSelectedGroupOptional', angular.toJson(quote), optional, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.deleteLines = function(/*QuoteModel*/ quote, /*Integer[]*/ lineKeys, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.deleteLines', angular.toJson(quote), lineKeys, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.deleteGroup = function(/*QuoteModel*/ quote, /*Integer*/ groupKey, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.deleteGroup', angular.toJson(quote), groupKey, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.cloneGroup = function(/*QuoteModel*/ quote, /*Integer*/ groupKey, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.cloneGroup', angular.toJson(quote), groupKey, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.reconfigureQuoteLine = function(/*QuoteModel*/ quote, /*Integer*/ lineKey, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.reconfigureQuoteLine', angular.toJson(quote), lineKey, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.loadLines = function(/*QuoteModel*/ quote, /*Integer*/ groupKey, /*Integer*/ pageIndex, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.loadLines', angular.toJson(quote), groupKey, pageIndex, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteServiceProxy.prototype.moveLineItems = function(/*QuoteModel*/ quote, /*Integer*/ targetGroupKey, /*Integer*/ targetPageIndex, /*String*/ targetLineId, /*List<String>*/ lineIds, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteLineEditorController.moveLineItems', angular.toJson(quote), targetGroupKey, targetPageIndex, targetLineId, lineIds, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}


function RemotingProductServiceProxy(/*String*/ namespace) {
	this.namespace = namespace;
	this.prefix = (this.namespace == '') ? '' : this.namespace + '.';
}
RemotingProductServiceProxy.prototype = new RemotingServiceProxy();

RemotingProductServiceProxy.prototype.loadSearchModel = function(/*QuoteVO*/ quote, /*String*/ processId, /*String*/ actionId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductLookupController.loadSearchModel', angular.toJson(quote), processId, actionId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingProductServiceProxy.prototype.search = function(/*QuoteVO*/ quote, /*Object*/ filterValues, /*String*/ actionId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductLookupController.search', angular.toJson(quote), angular.toJson(filterValues), actionId, null, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingProductServiceProxy.prototype.suggest = function(/*QuoteVO*/ quote, /*QuoteProcessModel*/ quoteProcess, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductLookupController.suggest', angular.toJson(quote), angular.toJson(quoteProcess), null, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingProductServiceProxy.prototype.loadConfiguredProducts = function(/*QuoteVO*/ quote, /*String[]*/ productIds, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductConfigurationController.loadConfiguredProducts', angular.toJson(quote), productIds, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingProductServiceProxy.prototype.updateConfiguration = function(/*QuoteVO*/ quote, /*ProductConfigurationVO*/ config, /*String*/ upgradedAssetId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductConfigurationController.updateConfiguration', angular.toJson(quote), angular.toJson(config), upgradedAssetId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingProductServiceProxy.prototype.saveConfiguration = function(/*QuoteVO*/ quote, /*ProductConfigurationVO[]*/ configs, /*String*/ upgradedAssetId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductConfigurationController.saveConfiguration', angular.toJson(quote), angular.toJson(configs), upgradedAssetId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingProductServiceProxy.prototype.loadAssetsWithUpgrades = function(/*Id[]*/ assetIds, /*QuoteVO*/ quote, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductUpgradeController.loadAssetsWithUpgrades', assetIds, angular.toJson(quote), this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}


function RemotingChatterServiceProxy(/*String*/ namespace) {
	this.namespace = namespace;
	this.prefix = (this.namespace == '') ? '' : this.namespace + '.';
}
RemotingChatterServiceProxy.prototype = new RemotingServiceProxy();

RemotingChatterServiceProxy.prototype.follow = function(/*String*/ subjectId) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductLookupController.follow', subjectId, this.createCallback(function(){}, function(){}), {escape:false,timeout:this.timeout});
}

RemotingChatterServiceProxy.prototype.unfollow = function(/*String*/ subjectId) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'ProductLookupController.unfollow', subjectId, this.createCallback(function(){}, function(){}), {escape:false,timeout:this.timeout});
}



function RemotingSubscriptionServiceProxy(/*String*/ namespace) {
	this.namespace = namespace;
	this.prefix = (this.namespace == '') ? '' : this.namespace + '.';
}
RemotingSubscriptionServiceProxy.prototype = new RemotingServiceProxy();

RemotingSubscriptionServiceProxy.prototype.loadSearchModel = function(/*QuoteVO*/ quote, /*String*/ actionId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'SubscriptionLookupController.loadSearchModel', angular.toJson(quote), actionId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingSubscriptionServiceProxy.prototype.search = function(/*QuoteVO*/ quote, /*Object*/ filterValues, /*String*/ actionId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'SubscriptionLookupController.search', angular.toJson(quote), angular.toJson(filterValues), actionId, null, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}



function RemotingAssetServiceProxy(/*String*/ namespace) {
	this.namespace = namespace;
	this.prefix = (this.namespace == '') ? '' : this.namespace + '.';
}
RemotingAssetServiceProxy.prototype = new RemotingServiceProxy();

RemotingAssetServiceProxy.prototype.loadSearchModel = function(/*QuoteVO*/ quote, /*String*/ actionId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'AssetLookupController.loadSearchModel', angular.toJson(quote), actionId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingAssetServiceProxy.prototype.search = function(/*QuoteVO*/ quote, /*Object*/ filterValues, /*String*/ actionId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'AssetLookupController.search', angular.toJson(quote), angular.toJson(filterValues), actionId, null, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}



function RemotingQuoteDocumentServiceProxy(/*String*/ namespace) {
	this.namespace = namespace;
	this.prefix = (this.namespace == '') ? '' : this.namespace + '.';
}
RemotingQuoteDocumentServiceProxy.prototype = new RemotingServiceProxy();

RemotingQuoteDocumentServiceProxy.prototype.loadDocumentModel = function(/*String*/ quoteId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteDocumentController.loadDocumentModel', quoteId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteDocumentServiceProxy.prototype.listRelatedContent = function(/*String*/ quoteId, /*String*/ templateId, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteDocumentController.listRelatedContent', quoteId, templateId, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteDocumentServiceProxy.prototype.generateDocuments = function(/*String*/ quoteId, /*String*/ templateId, /*String*/ documentName, /*String*/ outputFormat, /*String[]*/ documentIds, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteDocumentController.generateDocuments', quoteId, templateId, documentName, outputFormat, documentIds, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteDocumentServiceProxy.prototype.saveProposal = function(/*String*/ quoteId, /*String*/ templateId, /*String*/ documentName, /*String*/ outputFormat, /*String[]*/ documentIds, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteDocumentController.saveProposal', quoteId, templateId, documentName, outputFormat, documentIds, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteDocumentServiceProxy.prototype.saveAndEmailProposal = function(/*String*/ quoteId, /*String*/ templateId, /*String*/ documentName, /*String*/ outputFormat, /*String[]*/ documentIds, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteDocumentController.saveAndEmailProposal', quoteId, templateId, documentName, outputFormat, documentIds, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteDocumentServiceProxy.prototype.saveAndSendProposalForESignature = function(/*String*/ quoteId, /*String*/ templateId, /*String*/ documentName, /*String*/ outputFormat, /*String[]*/ documentIds, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteDocumentController.saveAndSendProposalForESignature', quoteId, templateId, documentName, outputFormat, documentIds, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}

RemotingQuoteDocumentServiceProxy.prototype.emailMeProposal = function(/*String*/ quoteId, /*String*/ templateId, /*String*/ documentName, /*String*/ outputFormat, /*String[]*/ documentIds, /*Function*/ successHandler, /*Function*/ errorHandler) {
	Visualforce.remoting.Manager.invokeAction(this.prefix + 'QuoteDocumentController.emailMeProposal', quoteId, templateId, documentName, outputFormat, documentIds, this.createCallback(successHandler, errorHandler), {escape:false,timeout:this.timeout});
}



function RemotingServiceProxy() {
	this.timeout = 60000;
}

RemotingServiceProxy.prototype.createCallback = function(/*Function*/ successHandler, /*Function*/ errorHandler) {
	return function(result, event) {
		if (event.status) {
			successHandler(result);
		} else {
			errorHandler(event);
		}
	}
}



function SoapMetaDataService(/*String*/ namespace, /*String*/ sessionId, /*String*/ decimalSymbol) {
	this.sessionId = sessionId;
	this.metaDataCache = {};
	this.namespace = namespace;
	this.decimalSymbol = decimalSymbol;
	this.prefix = (this.namespace == '') ? '' : this.namespace + '__';
}

SoapMetaDataService.CLIENT_ID = 'SteelBrick/SteelBrickCPQ/';

SoapMetaDataService.prototype.getPrefix = function() {
	return this.prefix;
}

SoapMetaDataService.prototype.setExternalFieldMetadata = function(/*Map<String,FieldMetadata__c>*/ metadata) {
	this.externalFieldMetadata = metadata;
	this.processExternalFieldMetadata();
}

SoapMetaDataService.prototype.ensureObjectMetaData = function(/*String[]*/ objectNames, /*Function*/ callback, /*controller*/ controller) {
	var missingObjects = [];
	angular.forEach(objectNames, function(objectName) {
		if (!this.hasMetaData(objectName)) {
			missingObjects.push(objectName);
		}
	}, this);
	if (missingObjects.length > 0) {
		this.loadObjectMetaData(missingObjects, callback, controller);
	} else {
		setTimeout(callback, 0);
	}
}

SoapMetaDataService.prototype.getMetaData = function(/*String*/ objectName) {
	return this.metaDataCache[objectName];
}

SoapMetaDataService.prototype.hasMetaData = function(/*String*/ objectName) {
	return (this.metaDataCache[objectName] != null);
}

SoapMetaDataService.prototype.loadObjectMetaData = function(/*String[]*/ objectNames, /*Function*/ callback, /*controller*/ controller) {
	var service = this;
	var describeSuccess = function(results) {
		angular.forEach(results, function(result) {
			service.processObjectMetaData(result.name, result);
		}, this);
		callback();
	}
	angular.forEach(objectNames, function(objectName) {
		if (!this.hasMetaData(objectName)) {
			this.metaDataCache[objectName] = new ObjectMetaData(objectName);
		}
	}, this);
	sforce.connection.sessionId = this.sessionId;
	sforce.connection.client = SoapMetaDataService.CLIENT_ID;
	try {
		sforce.connection.describeSObjects(objectNames);
		sforce.connection.describeSObjects(objectNames, describeSuccess, this.handleError);
	} catch(e) {
		var errorMessage = e.faultstring;
		controller.displayErrorMessage(errorMessage);
		this.metaDataCache = [];
	}
}

SoapMetaDataService.prototype.loadLayoutMetaData = function(/*String*/ objectName, /*String*/ recordTypeId, /*Function*/ callback) {
	var service = this;
	var describeSuccess = function(result) {
		service.processLayoutMetaData(objectName, result);
		callback();
	}
	if (!this.hasMetaData(objectName)) {
		this.metaDataCache[objectName] = new ObjectMetaData(objectName);
	}
	sforce.connection.sessionId = this.sessionId;
	sforce.connection.client = SoapMetaDataService.CLIENT_ID;
	sforce.connection.describeSObject(objectName, describeSuccess, this.handleError);
	sforce.connection.describeLayout(objectName, recordTypeId, describeSuccess, this.handleError);
}

SoapMetaDataService.prototype.loadMissingMetaData = function(/*String*/ objectName) {
	return (this.metaDataCache[objectName] != null);
}

SoapMetaDataService.prototype.processObjectMetaData = function(/*String*/ objectName, /*DescribeResult*/ result) {
	var metaData = this.getMetaData(objectName);
	metaData.setDescribe(result);
	this.processExternalFieldMetadata();
}

SoapMetaDataService.prototype.processExternalFieldMetadata = function() {
	angular.forEach(this.externalFieldMetadata, function(metadata, id) {
		var objectMD = this.getMetaData(metadata[this.prefix + 'ObjectName__c']);
		if (objectMD != null) {
			var field = objectMD.getField(metadata[this.prefix + 'FieldName__c']);
			if (field != null) {
				field.id = id;
			}
		}
	}, this);
}

SoapMetaDataService.prototype.processLayoutMetaData = function(/*String*/ objectName, /*LayoutResult*/ result) {
	var metaData = this.getMetaData(objectName);
	metaData.setLayout(result);
}

SoapMetaDataService.prototype.handleError = function(error) {
	alert('Error retrieving metadata: ' + result.statusText);
}
