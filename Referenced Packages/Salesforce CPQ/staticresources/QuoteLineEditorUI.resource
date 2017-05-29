function QuoteLineEditorCtrl(scope, sce, controllerManager, metaDataService, quoteService) {
	controllerManager.register('QuoteLineEditor', this);

	this.scope = scope;
	this.scope.sce = sce;
	this.scope.controllerManager = controllerManager;
	this.scope.active = false;
	this.scope.controller = this;
	this.scope.quoteService = quoteService;
	this.scope.metaDataService = metaDataService;
	this.scope.blockingOperationInProgress = false;

	// Add event handlers to scope.
	this.scope.onDeleteLine = this.onDeleteLine;
	this.scope.onDeleteLines = this.onDeleteLines;
	this.scope.onSelectAllStandardLines = this.onSelectAllStandardLines;
	this.scope.onSelectAllMSLines = this.onSelectAllMSLines;
	this.scope.onEditLine = this.onEditLine;
	this.scope.onChangeValue = this.onChangeValue;
	this.scope.onChangeUnit = this.onChangeUnit;
	this.scope.onLoad = this.onLoad;
	this.scope.onSave = this.onSave;
	this.scope.onExecuteCustomAction = this.onExecuteCustomAction;
	this.scope.onAddProducts = this.onAddProducts;
	this.scope.onRenewSubscriptions = this.onRenewSubscriptions;
	this.scope.onUpgradeAssets = this.onUpgradeAssets;
	this.scope.onReconfigureLine = this.onReconfigureLine;
	this.scope.onAddGroup = this.onAddGroup;
	this.scope.onDeleteGroup = this.onDeleteGroup;
	this.scope.onCloneGroup = this.onCloneGroup;
	this.scope.onChangeGroupOptional = this.onChangeGroupOptional;
	this.scope.onChangeGroupName = this.onChangeGroupName;
	this.scope.onCalculate = this.onCalculate;
	this.scope.onCancel = this.onCancel;
	this.scope.onResetDiscounts = this.onResetDiscounts;
	this.scope.onDropElement = this.onDropElement;
	this.scope.moveElementPaginated = this.moveElementPaginated;
	this.scope.onDragStart = this.onDragStart;
	this.scope.onDragStop = this.onDragStop;
	this.scope.onDragLines = this.onDragLines;
	this.scope.onLineSelectionChanged = this.onLineSelectionChanged;
	this.scope.onMultiSegmentLineSelectionChanged = this.onMultiSegmentLineSelectionChanged;
	this.scope.onChangePage = this.onChangePage;
	this.scope.onChangeGroup = this.onChangeGroup;
	this.scope.onToggleStatus = this.onToggleStatus;
	this.scope.onCollapseAll = this.onCollapseAll;
	this.scope.onExpandAll = this.onExpandAll;
	this.scope.load = this.load;
	this.scope.changePage = this.changePage;
	this.scope.blur = this.blur;
	this.scope.fieldValidationError = this.fieldValidationError;
	this.scope.checkInputValue = this.checkInputValue;
	this.scope.initTooltips = this.initTooltips;
	this.scope.displayErrorMessage = this.displayErrorMessage;


	this.scope.lineDragDropOptions = {
		revert:'invalid',
		helper: function(event) {
			return $('<h4 class="sbDraggedLine"></h4>').text($(this).find(".productName").text());
		},
		cursor:'move',
		cursorAt: {top: -10, left: -10},
		tolerance:'pointer',
		hoverClass:'sbDropRowHover',
		accept:function(e) {
			var target = $(this);
			var scope = angular.element(target).scope();
			if (scope) {
				var editorModel = scope.$parent.group.quote.editorModel;
				if (e.hasClass('sbStandardRow')) {
					if (editorModel.settings.bundleKeptTogether) {
						// accept only standard line items
						if (e.attr('component') == 'true') {
							// if draggable is a component, accept only when it is dropped onto another component of the same bundle
							if (e.attr('parentItemKey') == $(this).attr('parentItemKey')) {
								return true;
							}
						} else {
							// accept non-component standard lines (bundle or standalone)
							if ($(this).attr('component') == 'false') {
								return true;
							}
						}
					} else {
						return true;
					}
				}
			}
		},
		zIndex:100000
	};

	this.scope.multiSegmentLineDragDropOptions = {
		revert:'invalid',
		helper: function(event) {
			return $('<h4 class="sbDraggedLine"></h4>').text($(this).find(".productName").text());
		},
		cursor:'move',
		cursorAt: {top: -10, left: -10},
		tolerance:'pointer',
		hoverClass:'sbDropRowHover',
		accept: function(e) {
			var target = $(this);
			var scope = angular.element(target).scope();
			if (scope) {
				var editorModel = scope.$parent.group.quote.editorModel;
				if (e.hasClass('sbMultiSegmentRow')) {
					if (editorModel.settings.bundleKeptTogether) {
						// accept only multi-segment line items
						if(e.attr('component') == 'true') {
							// if draggable is a component, accept only when it's parent item (bundle) key matches the target's
							if ( e.attr('parentItemKey') == $(this).attr('parentItemKey')) {
								return true;
							}
						} else {
							// accept non-component multi-segment lines
							if ($(this).attr('component') == 'false') {
								return true;
							}
						}
					} else {
						return true;
					}
				}
			}
		},
		zIndex:100000
	};

	this.scope.emptyGroupDragDropOptions = {
		accept: function(e) {
			var target = $(this);
			var scope = angular.element(target).scope();
			if (scope) {
				var editorModel = scope.group.quote.editorModel;
				if (e.hasClass('dataRow')) {
					if (editorModel.settings.bundleKeptTogether) {
						// accept non-component standard and multi-segment line items
						if (e.attr('component') == 'false') {
							return true;
						}
					} else {
						return true;
					}
				}
			}
		},
		hoverClass:'sbEmptyGroupHover'
	};

	this.scope.emptyMSTableDragDropOptions = {
		accept: function(e) {
			var target = $(this);
			var scope = angular.element(target).scope();
			if (scope) {
				var editorModel = scope.group.quote.editorModel;
				if (e.hasClass('sbMultiSegmentRow')) {
					if (editorModel.settings.bundleKeptTogether) {
						// accept non-component multi-segment line items
						if (e.attr('component') == 'false') {
							return true;
						}
					} else {
						return true;
					}
				}
			}
		},
		hoverClass:'sbEmptyTableHover',
	};

	this.scope.emptyStandardTableDragDropOptions = {
		accept: function(e) {
			var target = $(this);
			var scope = angular.element(target).scope();
			if (scope) {
				var editorModel = scope.group.quote.editorModel;
				if (e.hasClass('sbStandardRow')) {
					if (editorModel.settings.bundleKeptTogether) {
						// accept non-component standard line items
						if (e.attr('component') == 'false') {
							return true;
						}
					} else {
						return true;
					}
				}
			}
		},
		hoverClass:'sbEmptyTableHover',
	};

	this.scope.groupDragDropOptions = {
		revert: 'invalid',
		helper: function(event) {
			return $('<h2 class="sbDraggedGroup"></h2>').text($(this).find(".sbGroupHeader h2").text());
		},
		handle: '.sbGroupDragHandle',
		accept: '.sbGroup',
		cursor: 'move',
		cursorAt: {top: -35, left: -35},
		tolerance: 'pointer',
		hoverClass: 'sbDropGroupHover',
		zIndex: 100000
	};

	this.scope.groupTabDragDropOptions = {
		revert:'invalid',
		helper: function(event) {
			return $('<h2 class="sbDraggedGroup"></h2>').text($(this).find(".groupLinkName").text());
		},
		cursor:'move',
		accept: function(e) {
			// accept draggable that is a group name link (as a tab) when pagination is enabled
			if (e.hasClass('paginatedGroupLink')) {
				return true;
			} else if (e.hasClass('lineItem') && e.attr('groupKey') != $(this).attr('key')) {
				var target = $(this);
				var scope = angular.element(target).scope();
				if (scope) {
					var editorModel = scope.group.quote.editorModel;
					if (editorModel.settings.bundleKeptTogether) {
						// accept non-component line items from other groups
						if (e.attr('component') == 'false') {
							return true;
						}
					} else {
						return true;
					}
				}
			}
		},
		cursorAt: {top: 5, left: 5},
		tolerance:'pointer',
		hoverClass:'sbDropGroupHoverPaginated',
		zIndex:100000
	};

	this.scope.pageDragDropOptions = {
		tolerance: 'pointer',
		hoverClass:'sbDropPageHover',
		accept: function(e) {
			if (e.hasClass('lineItem') && !($(this).hasClass('sbDisplayedPage'))) {
				var scope = angular.element(e).scope();
				if (scope) {
					var editorModel = scope.line.quote.editorModel;
					if (editorModel.settings.bundleKeptTogether) {
						// accept non-component line items from other pages on the displayed group
						if (e.attr('component') == 'false') {
							return true;
						}
					} else {
						return true;
					}
				}
			}
		}
	};

	this.richTextEditor = null;
}
QuoteLineEditorCtrl.$inject = ['$scope', '$sce', 'controllerManager', 'metaDataService', 'quoteServiceProxy'];
QuoteLineEditorCtrl.prototype = new Controller();

QuoteLineEditorCtrl.prototype.onLineSelectionChanged = function() {
	var count = 0;
	angular.forEach(this.editorModel.quote.lineItems, function(item) {
		if (item.selected) {
			count++;
		}
	}, this);
	this.controller.scope.editorModel.quote.selectedLineCount = count;
}

QuoteLineEditorCtrl.prototype.onMultiSegmentLineSelectionChanged = function(/*Integer*/ lineKey) {
	var quote = this.controller.scope.editorModel.quote;

	angular.forEach(quote.multiSegmentLineItemsByKey[lineKey].segments, function(item) {
		item.selected = true;
	}, this);

	this.onLineSelectionChanged();
}

QuoteLineEditorCtrl.prototype.onDeactivate = function() {
	// Move editor model out of scope to reduce the amount of processing Angular needs to do
	this.editorModel = this.scope.editorModel;
	this.scope.editorModel = null;
}

QuoteLineEditorCtrl.prototype.onActivate = function() {
	// Move editor model back in scope
	this.scope.editorModel = this.editorModel;
	this.editorModel = null;
}

QuoteLineEditorCtrl.prototype.onDropElement = function(event, ui) {
	var ctrl = this.controller;
	var scope = this.controller.scope;
	var settings = scope.editorModel.settings;

	if (settings.paginationEnabled) {
		this.blur();
	}
	scope.draggingOperationInProgress = false;
	if (ui.draggable) {
		var target = event.target;
		var srcKey = ui.draggable.attr('key');
		var targetKey = target.getAttribute('key');
		if(ui.draggable.prop('tagName') == "TR") {
			if (scope.editorModel.settings.paginationEnabled && (target.tagName !== "TR" || (ui.draggable.attr('bundle') == 'true' && settings.bundleKeptTogether))) {
				// drop line item onto another page or group when pagination is enabled
				this.moveElementPaginated(event, ui);
			} else {
				// drop line item onto another line item - in the same page if pagination is enabled
				this.editorModel.quote.moveLine(srcKey, targetKey);
			}
		} else {
			this.editorModel.quote.moveGroup(srcKey, targetKey);
			if (settings.paginationEnabled) {
				scope.blockingOperationInProgress = true;
				scope.messages = null;
				var quote = scope.editorModel.quote;
				var group = quote.groupsByKey[quote.selectedGroupKey];
				var pageIndex = group.displayedPageIndex ? group.displayedPageIndex : 1;
				this.quoteService.loadLines(this.editorModel.copyQuote(true), quote.selectedGroupKey, pageIndex, ctrl.createUpdateHandler(null, null, null), ctrl.createErrorHandler());
			}
		}
		this.$apply();
	}
}

QuoteLineEditorCtrl.prototype.moveElementPaginated = function(event, ui) {
	// when pagination is enabled, moving a line item to a different page/group is handled on the server as front end receives only a subset of line items
	var scope = this.controller.scope;
	var ctrl = this.controller;
	var quote = scope.editorModel.quote;
	var group = scope.editorModel.getGroup(quote.selectedGroupKey);

	var sourcePageIndex = group.displayedPageIndex;
	var sourceGroupKey = ui.draggable.attr('groupKey');
	var sourceLineKey = ui.draggable.attr('key');

	var lineIds = [];
	if (ui.draggable.hasClass('sbMultiSegmentRow')) {
		var segments = angular.element(ui.draggable).scope().line.segments;
		angular.forEach(segments, function(segment) {
			lineIds.push(segment.record.Id);
		});
	} else {
		lineIds.push(ui.draggable.attr('lineId'));
	}


	this.blur();

	// initialize variables needed for the moveLineItems method
	var targetGroupKey = null;
	var targetPageIndex = null;
	var targetLineId = null;

	// update variables based on drop target
	if ($(event.target).hasClass('sbPageNumber')) {
		// drop line item to a different page on the same group
		targetGroupKey = sourceGroupKey ? sourceGroupKey : null;
		targetPageIndex = event.target.getAttribute('pageNumber');
		targetLineId = null;
	} else if ($(event.target).hasClass('paginatedGroupLink')){
		// drop line item to a different group
		targetGroupKey = event.target.getAttribute('key');
		targetPageIndex = null;
		targetLineId = null;
	} else {
		// drop a bundle line item onto another line on the same page
		// this needs to be handled on the server as the line items are only partial on the front-end with pagination
		targetGroupKey = sourceGroupKey ? sourceGroupKey : null;
		targetPageIndex = group.displayedPageIndex;
		targetLineId = quote.lineItemsByKey[event.target.getAttribute('key')].record.Id;
	}

	scope.blockingOperationInProgress = true;
	scope.messages = null;

	this.quoteService.moveLineItems(this.editorModel.copyQuote(true), targetGroupKey, targetPageIndex, targetLineId, lineIds, ctrl.createUpdateHandler(null, null, null), ctrl.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.onDragStart = function(event, ui) {
	var scope = this.controller.scope;
	scope.draggingOperationInProgress = true;
	this.$apply();
}

QuoteLineEditorCtrl.prototype.onDragStop = function(event, ui) {
	var scope = this.controller.scope;
	scope.draggingOperationInProgress = false;
	this.$apply();
}

QuoteLineEditorCtrl.prototype.onLoad = function(/*String*/ quoteId, /*String*/ usedObjects, /*String*/ returnURL, /*String*/ saveURL) {
	var controller = this.controller;
	this.active = true;
	this.blockingOperationInProgress = true;
	this.returnURL = returnURL;
	this.saveURL = saveURL;
	controller.load(this.controller, quoteId, usedObjects);
}

QuoteLineEditorCtrl.prototype.load = function(/*Controller*/ srcController, /*String*/ quoteId, /*String*/ usedObjects) {
	var scope = this.scope;
	var controller = this;
	var successHandler = function(/*String*/ result) {
		//console.log(angular.toJson(angular.fromJson(result), true));
		scope.controller.editorModel = new QuoteEditorModel(scope, angular.fromJson(result));
		scope.referencedObjects = scope.controller.editorModel.referencedObjects;
		scope.metaDataService.setExternalFieldMetadata(scope.controller.editorModel.fieldMetadata);
		var quote = scope.controller.editorModel.quote;

		if (ModelUtils.isBlank(quote.getPricebookId())) {
			var retUrl = window.location.href;
			if (retUrl.indexOf('cp=1') > -1) {
				document.location.assign(controller.getCommunityPrefix() + '/' + quote.getId());
				return;
			}
			if(quote.getOpportunityId() == null) {
				scope.messages = [{severity:'error', summary: scope.resources.lbl_webQuoteMissingPricebookId}];
				scope.blockingOperationInProgress = false;
				scope.$apply();
				return;
			}
			retUrl = retUrl + '&cp=1';
			document.location.assign(controller.getCommunityPrefix() + '/oppitm/choosepricebook.jsp?id=' + quote.getOpportunityId() + '&retURL=' + encodeURIComponent(retUrl));
			return;
		}

		if ((quote.lineItems.length == 0) && (quote.lineItemGroups.length == 1)) {
			var action = scope.controller.editorModel.getDefaultCustomAction(quote.record[QuoteModel.TYPE_FIELD]);
			if (action) {
				scope.editorModel = controller.editorModel;
				scope.onExecuteCustomAction(action, quote.lineItemGroups[0].key);
				return;
			}
		}



		s2 = new Date();
		scope.blockingOperationInProgress = false;
		scope.controllerManager.activateController(scope.controller);

		scope.controller.initTooltips();
		$(window).resize(); // dynamically adjust page header

		if (console) {
			console.log('Total Time:' + ((new Date()).getTime() - s1.getTime()) + '; Render Time: ' + ((new Date()).getTime() - s2.getTime()));
		}
	};
	var s1;
	var metaDataCompleteHandler = function() {
		s1 = new Date();
		scope.quoteService.loadQuoteEditor(quoteId, successHandler, srcController.createErrorHandler());
	}

	var prefix = scope.metaDataService.getPrefix();
	var objectNames = [prefix + 'Quote__c',prefix + 'QuoteLine__c',prefix + 'QuoteLineGroup__c',prefix+'WebQuote__c',prefix+'WebQuoteLine__c'];
	if (!ModelUtils.isBlank(usedObjects)) {
		objectNames = usedObjects.split(',');
	}
	scope.metaDataService.ensureObjectMetaData(objectNames, metaDataCompleteHandler, srcController);
}

QuoteLineEditorCtrl.prototype.onSave = function() {
	var controller = this.controller;
	if (this.fieldValidationError()) return;
	this.blockingOperationInProgress = true;
	this.messages = null;

	var scope = this;
	var successHandler = function(/*String[]*/ messages) {
		if ((messages != null) && (messages.length > 0)) {
			scope.messages = [];
			angular.forEach(messages, function(msg) {
				this.messages.push({severity:'error',summary:scope.sce.trustAsHtml(msg)});
			}, scope);
			scope.blockingOperationInProgress = false;
			scope.$apply();
		} else {
			if (controller.isSalesforce1()) {
				sforce.one.navigateToSObject(scope.editorModel.quote.record.Id, 'detail');
			} else if (controller.isPhoneGap()) {
				var targetCtrl = this.controllerManager.lookup('QuoteDetail');
				targetCtrl.load(controller);
			} else {
				var redirectURL = controller.getCommunityPrefix() + '/' + scope.editorModel.quote.record.Id;
				if (!ModelUtils.isBlank(scope.saveURL)) {
					redirectURL = scope.saveURL;
				} else if (!ModelUtils.isBlank(scope.returnURL)) {
					redirectURL = scope.returnURL;
				}
				document.location.assign(redirectURL);
			}
		}
	};
	scope.quoteService.saveQuote(scope.editorModel.copyQuote(true), successHandler, this.controller.createErrorHandler());
	var checkBlockingOperation = setInterval(function() {
		if (scope.blockingOperationInProgress == false) {
			if (scope.messages.length > 0) {
				window.scrollTo(0, 120);
			}
			clearInterval(checkBlockingOperation);	
		}
	}, 200);
}

QuoteLineEditorCtrl.prototype.onCancel = function() {
	var controller = this.controller;
	this.blockingOperationInProgress = true;
	this.messages = null;

	if (controller.isSalesforce1()) {
		sforce.one.navigateToSObject(this.editorModel.quote.record.Id, 'detail');
	} else if (controller.isPhoneGap()) {
		var targetCtrl = this.controllerManager.lookup('QuoteDetail');
		targetCtrl.load(controller);
	} else {
		var redirectURL = controller.getCommunityPrefix() + '/' + this.editorModel.quote.record.Id;
		if (!ModelUtils.isBlank(this.returnURL)) {
			redirectURL = this.returnURL;
		}
		document.location.assign(redirectURL);
	}
}

QuoteLineEditorCtrl.prototype.onCalculate = function() {
	var scope = this.controller.scope;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;

	var successHandler = function(/*QuoteVO*/ result) {
		//console.log('IN\n' + angular.toJson(angular.fromJson(result), true));
		var s2 = new Date();
		scope.editorModel.updateQuote(angular.fromJson(result), 'calculate', null, null);
		scope.blockingOperationInProgress = false;
		scope.$apply();
		if (console) {
			console.log('Calculate | Total Time:' + ((new Date()).getTime() - s1.getTime()) + '; Render Time: ' + ((new Date()).getTime() - s2.getTime()));
		}
		scope.controller.refocus();
		scope.controller.initTooltips();
	};
	s1 = new Date();
	var quote = scope.editorModel.copyQuote(true);
	//console.log('OUT\n' + angular.toJson(quote, true));
	scope.quoteService.calculateQuote(quote, successHandler, this.controller.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.onChangeGroupOptional = function(isOptional) {
	var scope = this.controller.scope;
	scope.blockingOperationInProgress = true;
	scope.messages = null;

	var successHandler = function(/*QuoteVO*/ result) {
		//console.log('IN\n' + angular.toJson(angular.fromJson(result), true));
		var s2 = new Date();
		scope.editorModel.updateQuote(angular.fromJson(result), 'calculate', null, null); // HUH?
		scope.blockingOperationInProgress = false;
		scope.$apply();
		if (console) {
			console.log('Update Optional Group Flag | Total Time:' + ((new Date()).getTime() - s1.getTime()) + '; Render Time: ' + ((new Date()).getTime() - s2.getTime()));
		}
		scope.controller.refocus();
		scope.controller.initTooltips();
	};
	s1 = new Date();
	var quote = scope.editorModel.copyQuote(true);
	//console.log('OUT\n' + angular.toJson(quote, true));
	scope.quoteService.setSelectedGroupOptional(quote, isOptional, successHandler, this.controller.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.onRenewSubscriptions = function(/*CustomActionModel*/ action, /*Integer*/ targetGroupKey) {
	var scope = this.controller.scope;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;
	var quote = this.editorModel.copyQuote(false);
	var slc = scope.controllerManager.lookup('SubscriptionLookup');
	slc.load(this.controller, quote, (targetGroupKey == undefined) ? null : targetGroupKey, action.id);
}

QuoteLineEditorCtrl.prototype.onUpgradeAssets = function(/*CustomActionModel*/ action, /*Integer*/ targetGroupKey) {
	var scope = this.controller.scope;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;
	var quote = this.editorModel.copyQuote(false);
	var alc = this.controllerManager.lookup('AssetLookup');
	alc.load(this.controller, quote, (targetGroupKey == undefined) ? null : targetGroupKey, action.id);
}

QuoteLineEditorCtrl.prototype.onReconfigureLine = function(/*QuoteLineModel*/ line) {
	var scope = this.controller.scope;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;
	scope.controllerManager.lookup('ProductConfigurator').scope.currencySymbol = this.editorModel.currencySymbol
	var quote = this.editorModel.copyQuote(true);
	var successHandler = function(/*String*/ result) {
		var targetCtrl = scope.controllerManager.lookup('ProductConfigurator');
		targetCtrl.configureProducts(scope.controller, scope.editorModel.copyQuote(false), [angular.fromJson(result)]);
		scope.controller.initTooltips();
	}
	this.quoteService.reconfigureQuoteLine(quote, line.key, successHandler, scope.controller.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.onExecuteCustomAction = function(/*CustomActionModel*/ action, /*Integer*/ targetGroupKey) {
	if (action.isTargetProduct()) {
		this.onAddProducts(action, targetGroupKey);
	} else if (action.isTargetAsset()) {
		this.onUpgradeAssets(action, targetGroupKey);
	} else if (action.isTargetSubscription()) {
		this.onRenewSubscriptions(action, targetGroupKey);
	}
}

QuoteLineEditorCtrl.prototype.onAddProducts = function(/*CustomActionModel*/ action, /*Integer*/ targetGroupKey) {
	var scope = this.controller.scope;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;
	targetGroupKey = (targetGroupKey == undefined) ?  null : targetGroupKey;
	var targetGroup = (targetGroupKey != null) ? this.editorModel.quote.groupsByKey[targetGroupKey] : null;
	var quoteProcessId = this.editorModel.quote.record[QuoteModel.QUOTE_PROCESS_ID_FIELD];
	quoteProcessId = (quoteProcessId == undefined) ?  null : quoteProcessId;
	var groupProcessId = (targetGroup != null) ? targetGroup.record[QuoteLineGroupModel.QUOTE_PROCESS_FIELD] : null;
	groupProcessId = (groupProcessId == undefined) ?  null : groupProcessId;
	var quote = this.editorModel.copyQuote(false);
	var plc = this.controllerManager.lookup('ProductLookup');
	var processId = ModelUtils.isBlank(groupProcessId) ? (ModelUtils.isBlank(quoteProcessId) ? null : quoteProcessId) : groupProcessId;
	plc.load(this.controller, quote, targetGroupKey, processId, action.id);
}

QuoteLineEditorCtrl.prototype.addProducts = function(/*Controller*/ srcController, /*Integer*/ targetGroupKey, /*ProductVO[]*/ selectedProducts, /*QuoteProcessVO*/ quoteProcess) {
	var controller = this;
	var scope = controller.scope;

	var successHandler = function(/*String*/ result) {
		//console.log(angular.toJson(angular.fromJson(result), true));
		scope.productSelectionModel = new ProductSelectionModel(angular.fromJson(result));
		var quote = scope.productSelectionModel.quote;
		var configs = scope.productSelectionModel.configuredProducts;
		var upgrades = scope.productSelectionModel.upgradeProducts;
		var targetCtrl = controller;
		if ((upgrades.length == 0) && (configs.length == 0)) {
			//passing in action type to redirect to the last page on the group when pagination is on
			controller.editorModel.updateQuote(scope.productSelectionModel.quote, 'addProducts', null, null);
			delete scope.productSelectionModel;

			var productLookupCtrl = scope.controllerManager.lookup('ProductLookup');
			if (productLookupCtrl.scope.addMore) {
				productLookupCtrl.load(srcController, controller.editorModel.copyQuote(true), targetGroupKey, productLookupCtrl.scope.quoteProcessId, productLookupCtrl.scope.searchModel.actionId);
			} else {
				scope.controllerManager.activateController(targetCtrl);
			}
		} else {
			// Keep originally selected products to preserve order and stand-alone product selections.
			scope.productSelectionModel.selectedProducts = selectedProducts;
			scope.productSelectionModel.quoteProcess = quoteProcess;
			scope.productSelectionModel.targetGroupKey = targetGroupKey;
			if (upgrades.length > 0) {
				targetCtrl = scope.controllerManager.lookup('ProductUpgrader');
				targetCtrl.selectUpgradedAssets(upgrades);
			} else if (configs.length > 0) {
				targetCtrl = scope.controllerManager.lookup('ProductConfigurator');
				targetCtrl.scope.currencySymbol = controller.editorModel.currencySymbol;
				targetCtrl.configureProducts(srcController, quote, configs);
			}
		}
		scope.controller.initTooltips();
	};

	var quote = controller.editorModel.copyQuote(true);
	//console.log(angular.toJson(quote, true) + ' Group KEY: ' + targetGroupKey);
	//console.log(angular.toJson(selectedProducts, true));
	scope.quoteService.addProducts(quote, targetGroupKey, selectedProducts, quoteProcess, successHandler, srcController.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.renewSubscriptions = function(/*Controller*/ srcController, /*Integer*/ targetGroupKey, /*SubscriptionVO[]*/ selectedSubscriptions) {
	var controller = this;
	var scope = controller.scope;

	var successHandler = function(/*String*/ result) {
		controller.editorModel.updateQuote(angular.fromJson(result), 'renewSubscriptions', null, null);
		scope.controllerManager.activateController(controller);
	};

	var quote = controller.editorModel.copyQuote(true);
	scope.quoteService.renewSubscriptions(quote, targetGroupKey, selectedSubscriptions, successHandler, srcController.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.onEditLine = function(/*QuoteLineModel*/ line) {
	var scope = this.controller.scope;
	var ctrl = scope.controller;
	scope.editedLines = [];
	if (line.segmentKey != undefined) {
		for (var i=0;i<line.segments.length;i++) {
			scope.editedLines.push(line.segments[i]);
		}
	} else {
		scope.editedLines = [line];
	}
	scope.editLineMode = true;
}

QuoteLineEditorCtrl.prototype.onDeleteLine = function(/*Integer*/ lineKey) {
	var scope = this.controller.scope;
	var ctrl = this.controller;
	var quote = scope.editorModel.quote;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;

	this.blur();

	var lineKeys = [lineKey];
	if (quote.multiSegmentLineItemsByKey && quote.multiSegmentLineItemsByKey[lineKey]) {
		lineKeys = [];
		angular.forEach(quote.multiSegmentLineItemsByKey[lineKey].segments, function(item) {
			lineKeys.push(item.key);
		}, this);
	}

	scope.quoteService.deleteLines(scope.editorModel.copyQuote(true), lineKeys, ctrl.createUpdateHandler('deleteLine', null, null), ctrl.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.onDeleteLines = function() {
	var scope = this.controller.scope;
	var lineKeys = scope.editorModel.quote.getSelectedLineKeys();
	var ctrl = this.controller;
	if (this.fieldValidationError()) return;

	if (lineKeys.length > 0) {
		scope.blockingOperationInProgress = true;
		scope.messages = null;

		scope.quoteService.deleteLines(scope.editorModel.copyQuote(true), lineKeys, ctrl.createUpdateHandler('deleteLines', null, null), ctrl.createErrorHandler());
	}
}

QuoteLineEditorCtrl.prototype.onSelectAllStandardLines = function(/*QuoteLineGroupModel*/ group) {
	var value = $('.sbMultiDelete').is(':checked');
	angular.forEach(group.lineItems, function(line){
		if (!line.multiSegment) {
			line.selected = value;
		}
	}, this);

	this.onLineSelectionChanged();
}

QuoteLineEditorCtrl.prototype.onSelectAllMSLines = function(/*QuoteLineGroupModel*/ group) {
	var value = $('.sbMultiDelete').is(':checked');
	angular.forEach(group.multiSegmentLineItems, function(line){
			line.selected = value;
			angular.forEach(line.segments, function(segment) {
				segment.selected = value;
			});
	}, this);

	this.onLineSelectionChanged();
}

QuoteLineEditorCtrl.prototype.onDeleteGroup = function(/*Integer*/ groupKey) {
	var scope = this.controller.scope;
	var ctrl = this.controller;
	if (this.fieldValidationError(groupKey)) return;

	var deleteConfirmation = confirm(scope.resources.lbl_delete);
	if (deleteConfirmation) {
		scope.blockingOperationInProgress = true;
		scope.messages = null;
		scope.quoteService.deleteGroup(scope.editorModel.copyQuote(true), groupKey, ctrl.createUpdateHandler('deleteGroup', null, 1), ctrl.createErrorHandler());
	}
}

QuoteLineEditorCtrl.prototype.onCloneGroup = function(/*Integer*/ groupKey) {
	var scope = this.controller.scope;
	var ctrl = this.controller;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;

	scope.quoteService.cloneGroup(scope.editorModel.copyQuote(true), groupKey, ctrl.createUpdateHandler('cloneGroup', null, 1), ctrl.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.onAddGroup = function() {
	var solutionGroup = this.editorModel.settings.solutionGroupsEnabled ? this.editorModel.selectedSolutionGroup : null;
	this.editorModel.quote.addGroup(solutionGroup);
}

QuoteLineEditorCtrl.prototype.onChangeGroupName = function(event) {
	event.preventDefault();
	$(event.currentTarget).hide();
	$(event.currentTarget).parent().find('input').show().focus().select();
}

QuoteLineEditorCtrl.prototype.onChangeUnit = function(/*Field*/ field, /*QuoteLineModel*/ line) {
	if (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) {
		line.changeAdditionalDiscountUnit();
	} else if (field.name == QuoteLineModel.MARKUP_FIELD) {
		line.changeMarkupUnit();
	}
}

QuoteLineEditorCtrl.prototype.onResetDiscounts = function(/*Event*/ event, /*QuoteLineGroupModel*/ group) {
	if (event != null) {
		event.preventDefault();
	}

	angular.forEach(group.lineItems, function(item) {
		item.resetAdditionalDiscount();
	}, this);
}

QuoteLineEditorCtrl.prototype.onChangeValue = function(/*Event*/ event, /*Field*/ field, /*Object*/ target) {
	if (event != null) {
		event.preventDefault();
	}

	if ((target instanceof QuoteLineGroupModel) && (field != null) && (field.name == QuoteLineGroupModel.OPTIONAL_FIELD)) {
		target.updateLineOptional(target.isOptional());

		if (this.editorModel.settings.paginationEnabled) {
			this.onChangeGroupOptional(target.isOptional());
		}
	}

	if (target instanceof QuoteLineModel) {
		target.dirty = true;
		if (field != null && field.name == QuoteLineModel.SUBSCRIPTION_SCOPE_FIELD && target.multiSegment && target.key) {
			// set subscription scope for all segments of a multi-select line item when updated from summary line
			var multiSegmentLine = this.editorModel.quote.multiSegmentLineItemsByKey[target.key];
			multiSegmentLine.updateSubscriptionScope(target.record[QuoteLineModel.SUBSCRIPTION_SCOPE_FIELD]);
		}
	}

	if (this.editorModel.settings.calculateImmediately) {
		this.onCalculate();
	}
}

QuoteLineEditorCtrl.prototype.getRichTextEditor = function() {
	if (this.richTextEditor == null) {
		this.richTextEditor = new DescriptionEditorDialog(this.scope);
		this.richTextEditor.register();
	}
	return this.richTextEditor;
}

QuoteLineEditorCtrl.prototype.createUpdateHandler = function(/*String*/ action, /*String*/ type, /*Decimal*/ pageIndex) {
	var controller = this;
	var scope = controller.scope;
	return function(/*String*/ result) {
		scope.editorModel.updateQuote(angular.fromJson(result), action, type, pageIndex);
		scope.blockingOperationInProgress = false;
		scope.$apply();
		scope.controller.initTooltips();
	};
}

QuoteLineEditorCtrl.prototype.onChangePage = function(groupKey, action, type, pageIndex) {
	var scope = this.controller.scope;

	var group = scope.editorModel.quote.grouped ? scope.editorModel.quote.groupsByKey[groupKey] : scope.editorModel.quote;
	var displayedPageIndex = group.displayedPageIndex;

	if ((type === 'first' && displayedPageIndex !== 1) ||
		(type === 'last' && displayedPageIndex !== group.totalPageCount) ||
		(type === 'up' && pageIndex <= group.totalPageCount) ||
		(type === 'down' && pageIndex >= 1) ||
		(type === 'to' && pageIndex >= 1 && pageIndex <= group.totalPageCount)) {
		this.changePage(groupKey, action, type, pageIndex);
	}
}

QuoteLineEditorCtrl.prototype.onChangeGroup = function(groupKey) {
	var scope = this.controller.scope;
	if (this.fieldValidationError()) return;
	this.blur();
	if (groupKey !== scope.editorModel.quote.selectedGroupKey) {
		this.editorModel.updateDisplayedGroup(groupKey, 'changeGroup');
	}
	this.changePage(groupKey, 'changeGroup', null, 1);
}

QuoteLineEditorCtrl.prototype.changePage = function(groupKey, action, type, pageIndex) {
	var scope = this.controller.scope;
	var ctrl = this.controller;
	if (this.fieldValidationError()) return;
	scope.blockingOperationInProgress = true;
	scope.messages = null;

	var key = scope.editorModel.quote.grouped ? groupKey : null;
	this.quoteService.loadLines(this.editorModel.copyQuote(true), key, pageIndex, ctrl.createUpdateHandler(action, type, pageIndex), ctrl.createErrorHandler());
}

QuoteLineEditorCtrl.prototype.blur = function() {
	var scope = this.controller.scope;
	// Trigger blur on previusly focused input area to update model before server call
	var prevFocusedElementId = scope.$parent.focusedElementId;
	if (prevFocusedElementId != null) {
		var prevFocusedElement = document.getElementById(prevFocusedElementId);
		if (prevFocusedElement != null) {
			prevFocusedElement.blur();
		}
		scope.$parent.focusedElementId = null;
	}
}

QuoteLineEditorCtrl.prototype.onToggleStatus = function($event, line) {
	$event.preventDefault();
	this.controller.scope.editorModel.quote.toggleExpandedStatus(line);
}

QuoteLineEditorCtrl.prototype.onExpandAll = function($event, group) {
	$event.preventDefault();
	var quote = this.controller.scope.editorModel.quote.expandAllRows(group);
}

QuoteLineEditorCtrl.prototype.onCollapseAll = function($event, group) {
	$event.preventDefault();
	var quote = this.controller.scope.editorModel.quote.collapseAllRows(group);
}

QuoteLineEditorCtrl.prototype.fieldValidationError = function(/*Integer*/ groupKey) {
	//groupKey is an optional parameter only used by the onDeleteGroup method
	var scope = this.controller.scope;
	var groupQuote = scope.editorModel.quote;
	if (groupQuote.grouped == true && scope.editorModel.settings.groupNameRequired == true) {
		for (var i=0;i<groupQuote.lineItemGroups.length;i++) {
			if (groupQuote.lineItemGroups[i].record.Name == '' && groupKey != groupQuote.lineItemGroups[i].key) {
				alert(scope.editorModel.customLabels['msg_group_name_missing']);
				return true;
			}
		}
	}
	return false;
}

QuoteLineEditorCtrl.prototype.initTooltips = function() {
	$('[class^=sb-icon]').tooltip();
	$( '.sbTooltip' ).tooltip({
		content: function() {
			return $(this).children( '.sbTooltipContent' ).html();
		},
		items: '.sbTooltip',
		tooltipClass: 'sbLineEditorTooltip',
		position: {
			my: "center bottom-20",
			at: "center top",
			using: function( position, feedback ) {
				$( this ).css( position );
				$( "<div>" )
				.addClass( "arrow" )
				.addClass( feedback.vertical )
				.addClass( feedback.horizontal )
				.appendTo( this );
			}
		}
	});
}

QuoteLineEditorCtrl.prototype.displayErrorMessage = function(message) {
	this.scope.messages = [{severity:'error', summary: message}];
	this.scope.blockingOperationInProgress = false;
}


function QuoteEditorModel(/*Scope*/ scope, /*Object*/ data) {
	ModelUtils.copyProperties(data, this);
	this.scope = scope;
	this.metaDataService = scope.metaDataService;
	this.initMetaData();
	this.quote = new QuoteModel(this, data.quote);
	this.quote.renumber();
	this.summarized = (this.quote.summaries != null) && !ModelUtils.isEmpty(this.quote.summaries);
	this.draggedRowKey = null;
	if ((this.solutionGroups != null) && (this.solutionGroups.length > 0)) {
		this.selectedSolutionGroup = this.solutionGroups[0];
	}
}

QuoteEditorModel.prototype.updateQuote = function(/*QuoteVO*/ vo, /*String*/ action, /*String*/ type, /*Decimal*/ pageIndex) {
	var newQuote = new QuoteModel(this, vo);

	ModelUtils.copyNullProperties(this.quote.record, newQuote.record);
	angular.forEach(newQuote.lineItems, function(newItem) {
		var item = this.quote.lineItemsByKey[newItem.key];
		if (item != null) {
			ModelUtils.copyNullProperties(item.record, newItem.record);
		}
	}, this);
	angular.forEach(newQuote.lineItemGroups, function(newGroup) {
		var grp = this.quote.groupsByKey[newGroup.key];
		if (grp != null) {
			ModelUtils.copyNullProperties(grp.record, newGroup.record);
		}
	}, this);

	this.quote = newQuote;
	if (this.settings.paginationEnabled) {
		this.updateDisplayedGroup(this.quote.selectedGroupKey, action);
		this.updatePageIndex(this.quote.selectedGroupKey, action, type, pageIndex);
		this.quote.renumberPaginated();
	} else {
		this.quote.renumber();
	}

	this.summarized = (this.quote.summaries != null) && !ModelUtils.isEmpty(this.quote.summaries);
	this.initQuoteSectionRows();
}

QuoteEditorModel.prototype.getGroup = function(groupKey) {
	return this.quote.grouped ? this.quote.groupsByKey[groupKey] : this.quote;
}

QuoteEditorModel.prototype.isDisplayedGroup = function(groupKey) {
	return !this.quote.grouped ? true : this.quote.selectedGroupKey === groupKey;
}

QuoteEditorModel.prototype.updateDisplayedGroup = function(groupKey, action) {
	if (action === 'deleteGroup') {
		this.quote.selectedGroupKey = this.quote.lineItemGroups.length ? this.quote.lineItemGroups[0].key : null;
	} else if (action === 'cloneGroup') {
		this.quote.selectedGroupKey = this.quote.lineItemGroups[this.quote.lineItemGroups.length - 1].key;
	}
	else {
		this.quote.selectedGroupKey = groupKey;
	}
}

QuoteEditorModel.prototype.getPageCount = function(groupKey) {
	return this.getGroup(groupKey).totalPageCount;
}

QuoteEditorModel.prototype.getPageIndex = function(groupKey) {
	return this.getGroup(groupKey).displayedPageIndex;
}

QuoteEditorModel.prototype.updatePageIndex = function(/*Integer*/ groupKey, /*String*/ action, /*String*/ type, /*Decimal*/ pageIndex) {
	var group = this.getGroup(groupKey);
	if (action === 'changePage') {
		group.displayedPageIndex = pageIndex;
	} else {
		if (action === 'addProducts') {
			group.displayedPageIndex = group.totalPageCount;
		} else if (action === 'changeGroup') {
			group.displayedPageIndex = 1;
		}
	}
}

QuoteEditorModel.prototype.getPageCountArray = function(number) {
	//returning an array of page count length to list pages in the line editor
	return new Array(number);
}

QuoteEditorModel.prototype.getLineFields = function(/*String*/ formFactor) {
	if ((formFactor != null) && (formFactor == 'tablet')) {
		return this.lineFieldsTablet;
	} else if ((formFactor != null) && (formFactor == 'phone')) {
		return this.lineFieldsPhone;
	}
	return this.lineFields;
}

QuoteEditorModel.prototype.getUnitOptions = function(/*Field*/ field) {
	if (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) {
		return this.additionalDiscountUnitOptions;
	} else if (field.name == QuoteLineModel.MARKUP_FIELD) {
		return this.markupUnitOptions;
	}
	return null;
}

QuoteEditorModel.prototype.initMetaData = function() {
	var prefix = this.developerPrefix;

	this.initFieldNames();

	var quoteMetaData = this.metaDataService.getMetaData(this.quoteObjectName);
	var groupMetaData = this.metaDataService.getMetaData(prefix + 'QuoteLineGroup__c');
	var lineMetaData = this.metaDataService.getMetaData(this.quoteLineObjectName);

	this.quoteNetAmountField = quoteMetaData.getField(prefix + 'NetAmount__c');
	if (groupMetaData != null) {
		this.groupNetTotalField = groupMetaData.getField(prefix + 'NetTotal__c');
	} else {
	    // WebQuotes have no access to QuoteLineGroup, so use a different currency field here instead.
	    // This is LESS THAN IDEAL, we should instead explicitly add a currency formatting function, since that
	    // is what this field is used for later on.
	    this.groupNetTotalField = quoteMetaData.getField(prefix + 'TargetCustomerAmount__c');
	}
	this.subscriptionScopeField = angular.copy(lineMetaData.getField(prefix + 'SubscriptionScope__c'));
	if (this.subscriptionScopeField != null) {
		this.subscriptionScopeField.required = true;
	}

	this.quoteFields = [];
	angular.forEach(this.quoteFieldNames, function(name) {
		var qfield = this.metaDataService.getMetaData(this.quoteObjectName).getField(name);
		if (qfield != null) {
			this.quoteFields.push(qfield);
		}
	}, this);

	this.groupFields = [];
	angular.forEach(this.groupFieldNames, function(name) {
		var gfield = groupMetaData.getField(name);
		if (gfield == null) {
			// Field not available; probably because of security settings
			return;
		}
		if (gfield.name == QuoteLineGroupModel.DESCRIPTION_FIELD) {
			this.groupDescriptionField = gfield;
		}
		if ((gfield.name == QuoteLineGroupModel.QUOTE_PROCESS_FIELD) && (this.quoteProcesses != null)) {
			var values = [];
			angular.forEach(this.quoteProcesses, function(qprocess) {
				values.push({value:qprocess.Id,label:qprocess.Name});
			});
			gfield = new Field({name:name,label:gfield.label,updateable:gfield.updateable,type:'PICKLIST',picklistValues:values});
		}
		this.groupFields.push(gfield);
	}, this);

	// Reskinning update: group fields in rows to display in a table with 2 columns on the desktop - no change in mobile
	this.groupFieldRows = [];
	for (var i = 0; i < this.groupFields.length; i++) {
		if ( i == 0) {
			var row = [];
		}
		if (this.groupFields[i].name != 'Name' && this.groupFields[i].name != QuoteLineGroupModel.DESCRIPTION_FIELD) {
			row.push(this.groupFields[i]);
		}
		if (row.length == 2 || i == this.groupFields.length - 1) {
			this.groupFieldRows.push(row);
			row = [];
		}
	}
	this.groupDescriptionRendered = (this.groupDescriptionField != null);

	this.lineFields = [];
	this.calculatedLineFields = {};
	angular.forEach(this.lineFieldNames, function(name) {
		var field = this.metaDataService.getMetaData(this.quoteLineObjectName).getField(name);
		if (field == null) {
			// Field not available; probably because of security settings
			return;
		}
		this.lineFields.push(field);
		if (field.describe.calculated.toLowerCase() == 'true') {
			this.calculatedLineFields[field.name] = field;
		}
		var labelFieldName = field.describe.name.replace('__c', '').replace(prefix + '__', '') + 'ColumnLabel__c';
		if (this.quote.record[labelFieldName]) {
			field.label = this.quote.record[labelFieldName];
		}

		// Convert Subscription Base to a picklist
		if (field.name == QuoteLineModel.SUBSCRIPTION_BASE_FIELD) {
			field.type = 'PICKLIST';
			field.required = true;
			field.picklistValues = this.subscriptionBaseOptions;
		}

		// Shown field flags
		if (field.name == QuoteLineModel.OPTIONAL_FIELD) {
			this.optionalFieldShown = true;
		} else if (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) {
			this.additionalDiscountFieldShown = true;
		}
	}, this);

	this.lineFieldsTablet = this.lineFields;
	if (this.lineFieldNamesTablet != null) {
		this.lineFieldsTablet = [];
		angular.forEach(this.lineFieldNamesTablet, function(name) {
			var field = this.metaDataService.getMetaData(this.quoteLineObjectName).getField(name);
			this.lineFieldsTablet.push(field);
		}, this);
	}

	this.lineFieldsPhone = this.lineFields;
	if (this.lineFieldNamesPhone != null) {
		this.lineFieldsPhone = [];
		angular.forEach(this.lineFieldNamesPhone, function(name) {
			var field = this.metaDataService.getMetaData(this.quoteLineObjectName).getField(name);
			this.lineFieldsPhone.push(field);
		}, this);
	}

	// Create list of fields for multi-segment roll-up line items (excluding segment names)
	this.msSummaryLineFields = [];
	angular.forEach(this.multiSegmentLineSummaryFieldNames, function(name) {
		var field = this.metaDataService.getMetaData(this.quoteLineObjectName).getField(name);
		if (field != null) {
			this.msSummaryLineFields.push(field);
		}

		var labelFieldName = field.describe.name.replace('__c', '').replace(prefix + '__', '') + 'ColumnLabel__c';
		if (this.quote.record[labelFieldName]) {
			field.label = this.quote.record[labelFieldName];
		}

		// Shown field flags
		if (field.name == QuoteLineModel.OPTIONAL_FIELD) {
			this.optionalFieldShown = true;
		} else if (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) {
			this.additionalDiscountFieldShown = true;
		}
	}, this);

	// Create net total field for multi-segment roll-up lines
	this.netTotalField = this.metaDataService.getMetaData(this.quoteLineObjectName).getField(prefix + "NetTotal__c"); //TODO: Update this

	// Create list of fields for multi-segment detail rows
	this.multiSegmentDetailColumnFields = [];
	angular.forEach(this.multiSegmentLineFieldNames, function(name) {
		var field = this.metaDataService.getMetaData(this.quoteLineObjectName).getField(name);
		if (field == null) {
			return;
		}
		this.multiSegmentDetailColumnFields.push(field);

		if (field.describe.calculated.toLowerCase() == 'true') {
			this.calculatedLineFields[field.name] = field;
		}
		var labelFieldName = field.describe.name.replace('__c', '').replace(prefix + '__', '') + 'ColumnLabel__c';
		if (this.quote.record[labelFieldName]) {
			field.label = this.quote.record[labelFieldName];
		}

		// Convert Subscription Base to a picklist
		if (field.name == QuoteLineModel.SUBSCRIPTION_BASE_FIELD) {
			field.type = 'PICKLIST';
			field.required = true;
			field.picklistValues = this.subscriptionBaseOptions;
		}

		// Shown field flags
		if (field.name == QuoteLineModel.OPTIONAL_FIELD) {
			this.optionalFieldShown = true;
		} else if (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) {
			this.additionalDiscountFieldShown = true;
		}
	}, this);


	this.initQuoteSectionRows();

	var actions = this.customActions;
	this.customActions = [];
	angular.forEach(actions, function(action) {
		this.customActions.push(new CustomActionModel(action, this.metaDataService));
	}, this);
}

QuoteEditorModel.prototype.initFieldNames = function() {
	var prefix = this.developerPrefix;

	QuoteLineModel.PRICING_METHOD_FIELD = prefix + 'PricingMethod__c';
	QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD = prefix + 'AdditionalDiscount__c';
	QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD = prefix + 'Discount__c';
	QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD = prefix + 'AdditionalDiscountAmount__c';
	QuoteLineModel.PARTNER_DISCOUNT_FIELD = prefix + 'PartnerDiscount__c';
	QuoteLineModel.DISTRIBUTOR_DISCOUNT_FIELD = prefix + 'DistributorDiscount__c';
	QuoteLineModel.MARKUP_FIELD = prefix + 'Markup__c';
	QuoteLineModel.MARKUP_RATE_FIELD = prefix + 'MarkupRate__c';
	QuoteLineModel.MARKUP_AMOUNT_FIELD = prefix + 'MarkupAmount__c';
	QuoteLineModel.UNIT_COST_FIELD = prefix + 'UnitCost__c';
	QuoteLineModel.QUANTITY_FIELD = prefix + 'Quantity__c';
	QuoteLineModel.CUSTOMER_PRICE_FIELD = prefix + 'CustomerPrice__c';
	QuoteLineModel.REGULAR_PRICE_FIELD = prefix + 'RegularPrice__c';
	QuoteLineModel.SPECIAL_PRICE_FIELD = prefix + 'SpecialPrice__c';
	QuoteLineModel.PARTNER_PRICE_FIELD = prefix + 'PartnerPrice__c';
	QuoteLineModel.NET_PRICE_FIELD = prefix + 'NetPrice__c';
	QuoteLineModel.COMPONENT_DISCOUNTED_BY_PACKAGE_FIELD = prefix + 'ComponentDiscountedByPackage__c';
	QuoteLineModel.COMPONENT_LIST_TOTAL_FIELD = prefix + 'ComponentListTotal__c';
	QuoteLineModel.NON_DISCOUNTABLE_FIELD = prefix + 'NonDiscountable__c';
	QuoteLineModel.NON_PARTNER_DISCOUNTABLE_FIELD = prefix + 'NonPartnerDiscountable__c';
	QuoteLineModel.SUBSCRIPTION_PRICING_FIELD = prefix + 'SubscriptionPricing__c';
	QuoteLineModel.COMPONENT_SUBSCRIPTION_SCOPE_FIELD = prefix + 'ComponentSubscriptionScope__c';
	QuoteLineModel.COMPONENT_VISIBILITY_FIELD = prefix + 'ComponentVisibility__c';
	QuoteLineModel.SUBSCRIBED_ASSET_IDS_FIELD = prefix + 'SubscribedAssetIds__c';
	QuoteLineModel.START_DATE_FIELD = prefix + 'StartDate__c';
	QuoteLineModel.END_DATE_FIELD = prefix + 'EndDate__c';
	QuoteLineModel.SUBSCRIPTION_TERM_FIELD = prefix + 'SubscriptionTerm__c';
	QuoteLineModel.DEFAULT_SUBSCRIPTION_TERM_FIELD = prefix + 'DefaultSubscriptionTerm__c';
	QuoteLineModel.OPTIONAL_FIELD = prefix + 'Optional__c';
	QuoteLineModel.BUNDLE_FIELD = prefix + 'Bundle__c';
	QuoteLineModel.BUNDLED_FIELD = prefix + 'Bundled__c';
	QuoteLineModel.NUMBER_FIELD = prefix + 'Number__c';
	QuoteLineModel.OPTION_TYPE_FIELD = prefix + 'OptionType__c';
	QuoteLineModel.BUNDLED_QUANTITY_FIELD = prefix + 'BundledQuantity__c';
	QuoteLineModel.SUBSCRIPTION_SCOPE_FIELD = prefix + 'SubscriptionScope__c';
	QuoteLineModel.PRICE_EDITABLE_FIELD = prefix + 'PriceEditable__c';
	QuoteLineModel.COST_EDITABLE_FIELD = prefix + 'CostEditable__c';
	QuoteLineModel.LIST_PRICE_FIELD = prefix + 'ListPrice__c';
	QuoteLineModel.SUBSCRIPTION_BASE_FIELD = prefix + 'SubscriptionBase__c';
	QuoteLineModel.PRODUCT_NAME_FIELD = prefix + 'ProductName__c';
	QuoteLineModel.PRODUCT_CODE_FIELD = prefix + 'ProductCode__c';
	QuoteLineModel.RENEWED_ASSET_ID_FIELD = prefix + 'RenewedAsset__c';
	QuoteLineModel.DESCRIPTION_FIELD = prefix + 'Description__c';
	QuoteLineModel.OPTION_LEVEL_FIELD = prefix + 'OptionLevel__c';
	QuoteLineModel.EXISTING_FIELD = prefix + 'Existing__c';
	QuoteLineModel.UPLIFT_FIELD = prefix + 'Uplift__c';
	QuoteLineModel.SEGMENT_KEY = prefix + 'SegmentKey__c';
	QuoteLineModel.SEGMENT_LABEL = prefix + 'SegmentLabel__c';
	QuoteLineModel.SEGMENT_INDEX = prefix + 'SegmentIndex__c';
	QuoteLineModel.RENEWAL_CHECKBOX = prefix + 'Renewal__c';
	QuoteLineModel.PRIOR_QUANTITY_FIELD= prefix + 'PriorQuantity__c';
	QuoteLineGroupModel.DESCRIPTION_FIELD = prefix + 'Description__c';
	QuoteLineGroupModel.CUSTOMER_TOTAL_FIELD = prefix + 'CustomerTotal__c';
	QuoteLineGroupModel.NET_TOTAL_FIELD = prefix + 'NetTotal__c';
	QuoteLineGroupModel.OPTIONAL_FIELD = prefix + 'Optional__c';
	QuoteLineGroupModel.QUOTE_PROCESS_FIELD = prefix + 'QuoteProcess__c';
	QuoteLineGroupModel.SOLUTION_GROUP_ID_FIELD = prefix + 'SolutionGroup__c';
	QuoteLineGroupModel.NUMBER_FIELD = prefix + 'Number__c';
	QuoteModel.QUOTE_PROCESS_ID_FIELD = prefix + 'QuoteProcessId__c';
	QuoteModel.PRICEBOOK_ID_FIELD = prefix + 'PricebookId__c';
	QuoteModel.OPPORTUNITY_ID_FIELD = prefix + 'Opportunity__c';
	QuoteModel.OPPORTUNITY_FIELD = prefix + 'Opportunity__r';
	QuoteModel.GROUP_LINE_ITEMS_FIELD = prefix + 'LineItemsGrouped__c';
	QuoteModel.TYPE_FIELD = prefix + 'Type__c';
}

QuoteEditorModel.prototype.initQuoteSectionRows = function() {
	var maxFieldsPerRow = Controller.isMobileContext() ? 1 : 3;
	this.quoteSectionRows = [];
	var sectionRow = [];
	angular.forEach(this.quoteFields, function(field) {
		sectionRow.push(field);
		if (sectionRow.length == maxFieldsPerRow) {
			this.quoteSectionRows.push(sectionRow);
			sectionRow = [];
		}
	}, this);
	if (sectionRow.length > 0) {
		this.quoteSectionRows.push(sectionRow);
	}
}

QuoteEditorModel.prototype.getSegmentLineItem = function(/*QuoteLineModel*/ line, /*String*/ segmentLabel) {
	var result = null;
	angular.forEach(line.segments, function(segment){
		if (segment.segmentLabel == segmentLabel) {
			result = segment;
		}
	}, this);

	return result;
}

QuoteEditorModel.prototype.getSegmentValue = function(/*QuoteLineModel*/ line, /*String*/ segmentLabel, /*Field*/ field) {
	var segmentLineItem = this.getSegmentLineItem(line, segmentLabel);
	return segmentLineItem ? segmentLineItem.record[segmentLineItem.mapPropertyName(field)] : "";
}

QuoteEditorModel.prototype.getNonSegmentTotal = function(/*Integer*/ key) {
	var groupKey = key ? key : null;
	return this.quote.groupsByKey[groupKey].netNonSegmentTotal ? this.quote.groupsByKey[groupKey].netNonSegmentTotal : 0;
}

QuoteEditorModel.prototype.getQuoteTotal = function() {
	return (this.quote.applyAdditionalDiscountLast) ? this.quote.customerTotal : this.quote.netTotal;
}

QuoteEditorModel.prototype.getLineColumnCount = function(/*String*/ formFactor) {
	var count = this.getLineFields(formFactor).length;
	if (this.isSubscriptionScopeShown() && !Controller.isMobileContext()) {
		count++;
	}
	if (this.settings.multiLineDeleteEnabled && !Controller.isMobileContext()) {
		count++;
	}
	// Reskinning update: +1 to align total cell to the right
	return this.settings.actionsColumnPlacement == 'Left' ? count + 1 : count;
}

// Count of static columns
QuoteEditorModel.prototype.getStaticColumnCount = function() {
	var count = 1 //line numbers column
	if (this.isSubscriptionScopeShown() && !Controller.isMobileContext()) {
		count++;
	}
	if (this.settings.multiLineDeleteEnabled && !Controller.isMobileContext()) {
		count++;
	}
	if (this.settings.actionsColumnPlacement == 'Left') {
		count++;
	}
	return count;
}

QuoteEditorModel.prototype.getEndingStaticColumnCount = function() {
	var count = 1;
	if (this.settings.actionsColumnPlacement != 'Left') {
		count++;
	}
	return count;
}

// Count of columns prior to segments
QuoteEditorModel.prototype.getMultiSegmentColumnCount = function() {
	return this.getStaticColumnCount() + this.msSummaryLineFields.length;
}

// Total count of columns in the multi-segment table
QuoteEditorModel.prototype.getMultiSegmentTotalColumnCount = function(/*Integer*/ key) {
	var groupKey = key ? key : null;
	var count = this.getMultiSegmentColumnCount() + this.quote.groupsByKey[groupKey].multiSegmentColumns.length + 1; // +1 for total column
	if (this.settings.actionsColumnPlacement != 'Left') {
		count++;
	}
	return count;
}

//total column count including line number and actions columns
QuoteEditorModel.prototype.getTotalLineColumnCount = function(/*String*/ formFactor) {
	return this.settings.actionsColumnPlacement == 'Left' ? this.getLineColumnCount(formFactor) + 1 : this.getLineColumnCount(formFactor);
}

QuoteEditorModel.prototype.optionalFieldDisplayed = function() {
}

QuoteEditorModel.prototype.isSubscriptionScopeShown = function() {
	if ((this.quote.grouped == true) && (this.subscriptionScopeField != null)) {
		var result = false;
		angular.forEach(this.quote.lineItems, function(item) {
			result = result || item.subscriptionScopeEditable;
		}, this);
		return result;
	}
	return false;
}

QuoteEditorModel.prototype.isSubscriptionScopeInFieldSet = function() {
	var result = false
	angular.forEach(this.quote.editorModel.lineFields, function(field) {
		result = result || (field.name == QuoteLineModel.SUBSCRIPTION_SCOPE_FIELD)
	})
	return result;
}

QuoteEditorModel.prototype.copyQuote = function(/*Boolean*/ includeDetail) {
	// Update IDs of lookup fields stored in hidden fields into the mdoel.
	// Since they are set by SFDC native popup window there is no way to do this in real time
	this.scope.$broadcast('updateLookups');
	var result = this.quote.createCopy();
	if (includeDetail) {
		if (this.quote.grouped) {
			result.lineItemGroups = [];
			for (var i=0;i<this.quote.lineItemGroups.length;i++) {
				var groupModel = this.quote.lineItemGroups[i];
				if (this.quote.record.CurrencyIsoCode !== undefined) {
					groupModel.record.CurrencyIsoCode = this.quote.record.CurrencyIsoCode;
				}
				result.lineItemGroups.push(groupModel.createCopy());
			}
		}

		result.lineItems = [];
		if (this.quote.hasMultiSegmentProducts()) {
			for (var i = 0; i < this.quote.lineItemGroups.length; i++) {
				var group = this.quote.lineItemGroups[i];
				if (group.multiSegmentLineItems) {
					for (var j = 0; j < group.multiSegmentLineItems.length; j++) {
						var multiSegmentLine = group.multiSegmentLineItems[j];
						for (var k = 0; k < multiSegmentLine.segments.length; k++) {
							var line = multiSegmentLine.segments[k];
							result.lineItems.push(line.createCopy());
						}
					}
				}
				for (var j = 0; j < group.lineItems.length; j++) {
					var line = group.lineItems[j];
					if (!line.multiSegment) {
						result.lineItems.push(line.createCopy());
					}
				}
			}
		} else {
			for (var i = 0; i < this.quote.lineItemGroups.length; i++) {
				var group = this.quote.lineItemGroups[i];
				for (var j = 0; j < group.lineItems.length; j++) {
					var line = group.lineItems[j];
					result.lineItems.push(line.createCopy());
				}
			}
		}
	}
	return result;
}

QuoteEditorModel.prototype.getDefaultCustomAction = function(/*String*/ quoteType) {
	var targetObject = quoteType == "Renewal" ? "Subscription" : "Product";
	for (var i=0;i<this.customActions.length;i++){
		if (this.customActions[i].targetObject === targetObject && this.customActions[i].default){
			return this.customActions[i];
		}
	}
	return null;
}

QuoteEditorModel.prototype.displayTableNames = function(/*Integer*/ key) {
	var groupKey = key ? key : null;
	var group = this.quote.groupsByKey[groupKey];
	return (this.quote.hasMultiSegmentProducts() && this.quote.hasStandardProducts() && group.lineItems.length > 0) ? true : false;
}

QuoteEditorModel.prototype.displayEmptyTableMessage = function(/*Integer*/ key, /*Boolean*/ multiSegment) {
	if (this.quote.grouped && key != null) {
		var group = this.quote.groupsByKey[key];
		if (multiSegment) {
			return (this.quote.hasMultiSegmentProducts() && group.lineItems.length > 0 && !group.hasMultiSegmentProducts()) ? true : false;
		} else {
			return (this.quote.hasStandardProducts() && group.lineItems.length > 0 && !group.hasStandardProducts()) ? true : false;
		}
	}
	return false;
}

QuoteEditorModel.prototype.checkInputValue = function(event) {
	if (event.currentTarget.value != '') {
		$(event.currentTarget).css('display', 'none');
		$(event.currentTarget).parent().find('h2').show();
	}
}




function ProductSelectionModel(/*ProductSelectionModel*/ data) {
	ModelUtils.copyProperties(data, this);
}

ProductSelectionModel.prototype.updateConfigurations = function(/*ProductVO[]*/ configuredProducts) {
	var configsByProductId = {};
	jQuery.each(configuredProducts, function(idx, product) {
		if (product.configuration != null) {
			configsByProductId[product.configuration.configuredProductId] = product.configuration;
		}
	});

	jQuery.each(this.selectedProducts, function(idx, product) {
		var productId = product.record.Id;
		if (configsByProductId[productId] != null) {
			product.configuration = configsByProductId[productId].createVO();
			product.configuration.configured = true;
		}
	});
}

ProductSelectionModel.prototype.setUpgradedAssets = function(/*String*/ productId, /*String[]*/ assetIds) {
	jQuery.each(this.selectedProducts, function(idx, product) {
		var productId = product.record.Id;
		if (product.record.Id == productId) {
			product.upgradedAssetIds = assetIds;
		}
	});
}

ProductSelectionModel.prototype.createCopy = function() {
	var result = angular.copy(this);
	result.selectedProducts = [];
	angular.forEach(this.selectedProducts, function(product) {
		if ((product.upgradedAssetIds != null) && (product.upgradedAssetIds.length > 0)) {
			// Blow out multiple upgraded assets into a separate product/asset pair.
			angular.forEach(product.upgradedAssetIds, function(assetId) {
				var clonedProduct = angular.copy(product);
				clonedProduct.upgradedAssetId = assetId;
				result.selectedProducts.push(clonedProduct);
			});
		} else {
			result.selectedProducts.push(product);
		}
	}, this);
	return result;
}



function QuoteModel(/*QuoteEditorModel*/ editorModel, /*Object*/ data) {
	ModelUtils.copyProperties(data, this);
	this.editorModel = editorModel;
	var qmodel = this;

	this.selectedLineCount = 0;
	this.groupsByKey = {};
	this.lineItemGroups = [];
	this.grouped = data.record[QuoteModel.GROUP_LINE_ITEMS_FIELD];
	if (this.grouped) {
		angular.forEach(data.lineItemGroups, function(itemGroup) {
			var groupModel = new QuoteLineGroupModel(qmodel, itemGroup);
			this.groupsByKey[itemGroup.key] = groupModel;
			this.lineItemGroups.push(groupModel);
			groupModel.summaryLine = new QuoteSummaryModel(qmodel, {record:groupModel.summaries});
		}, this);
	} else {
		var virtualGroup = new QuoteLineGroupModel(qmodel, {record:{}});
		this.lineItemGroups = [virtualGroup];
		virtualGroup.summaryLine = new QuoteSummaryModel(qmodel, {record:qmodel.summaries});
		this.groupsByKey[null] = virtualGroup;
	}

	this.lineItemsByKey = {};
	this.lineItems = [];
	angular.forEach(data.lineItems, function(line) {
		var itemGroup = this.groupsByKey[line.parentGroupKey];
		var item = new QuoteLineModel(qmodel, itemGroup, line)
		this.lineItemsByKey[item.key] = item;
		this.lineItems.push(item);
		if (itemGroup != null) {
			itemGroup.lineItems.push(item);
		}
	}, this);

	if (this.hasMultiSegmentLines) {
		this.createMultiSegmentLineItems();
	}

	if (this.editorModel.settings.paginationEnabled) {
		var pageSize = this.editorModel.settings.pageSize ? this.editorModel.settings.pageSize : 25;
		if (this.grouped) {
			angular.forEach(this.lineItemGroups, function(group) {
				group.displayedPageIndex = group.displayedPageIndex != null ? group.displayedPageIndex :  1;
			}, this);
		} else {
			this.displayedPageIndex = this.displayedPageIndex != null ? this.displayedPageIndex : 1;
		}
	}
}

// Looping through line items assuming all segments for each summary row is returned from the server when pagination enabled
QuoteModel.prototype.createMultiSegmentLineItems = function() {
	this.segmentKeys = {};
	this.multiSegmentLineItemsByKey = {};
	this.multiSegmentLineItems = [];
	angular.forEach(this.lineItemGroups, function(group){
		angular.forEach(group.lineItems, function(lineItem){
			if ((lineItem.segmentIndex == 0 || lineItem.segmentIndex == 1) && !this.segmentKeys[lineItem.segmentKey]) {
				var lineItemGroup = this.groupsByKey[lineItem.parentGroupKey];
				if (!lineItemGroup.multiSegmentLineItems) {
					lineItemGroup.multiSegmentLineItems = [];
				}

				var multiSegmentLineItem = new QuoteLineModel(this, lineItemGroup, lineItem);
				this.multiSegmentLineItems.push(multiSegmentLineItem);
				this.multiSegmentLineItemsByKey[multiSegmentLineItem.key] = multiSegmentLineItem;
				this.segmentKeys[lineItem.segmentKey] = true;

				multiSegmentLineItem.expanded = this.multiSegmentRowExpanded[lineItem.segmentKey];
				multiSegmentLineItem.segments = [];
				var segmentKey = lineItem.segmentKey;
				angular.forEach(lineItemGroup.lineItems, function(item){
					if (item.multiSegment) {
						if (item.segmentKey == segmentKey) {
							multiSegmentLineItem.segments.push(item);
						}
					}
				}, this);
				lineItemGroup.multiSegmentLineItems.push(multiSegmentLineItem);

				// Copy group properties for ungrouped quotes
				if (!this.grouped) {
					lineItemGroup.hasMultiSegmentLines = this.hasMultiSegmentLines;
					lineItemGroup.multiSegmentColumns = this.multiSegmentColumns;
					lineItemGroup.multiSegmentColumnTotals = this.multiSegmentColumnTotals;
					lineItemGroup.multiSegmentRowTotals = this.multiSegmentRowTotals;
					lineItemGroup.netMultiSegmentTotal = this.netMultiSegmentTotal;
					lineItemGroup.netNonSegmentTotal = this.netNonSegmentTotal;
				}
			}
		}, this);
	}, this);

	angular.forEach(this.multiSegmentLineItems, function(item) {
		var key = item.key;
		if (item.segments) {
			angular.forEach(item.segments, function(segment) {
				segment.parentSummaryLineKey = key;
			});
		}
	}, this);
}

QuoteModel.prototype.hasMultiSegmentProducts = function() {
	var result = false;
	angular.forEach(this.lineItemGroups, function(itemGroup){
		if (itemGroup.multiSegmentLineItems && itemGroup.multiSegmentLineItems.length > 0) {
			result = true;
			return;
		}
	}, this);
	return result;
}

QuoteModel.prototype.hasStandardProducts = function() {
	var result = false;
	angular.forEach(this.lineItemGroups, function(itemGroup){
		if (itemGroup.hasStandardProducts()) {
			result = true;
			return;
		}
	}, this);
	return result;
}

QuoteModel.prototype.getId = function() {
	return this.record['Id'];
}

QuoteModel.prototype.getPricebookId = function() {
	if (this.record[QuoteModel.PRICEBOOK_ID_FIELD]) {
		return this.record[QuoteModel.PRICEBOOK_ID_FIELD];
	}
	if (this.record[QuoteModel.OPPORTUNITY_ID_FIELD]) {
		return this.record[QuoteModel.OPPORTUNITY_FIELD].Pricebook2Id;
	}
	return null;
}

QuoteModel.prototype.getOpportunityId = function() {
	return this.record[QuoteModel.OPPORTUNITY_ID_FIELD];
}

QuoteModel.prototype.getId = function() {
	return this.record['Id'];
}

QuoteModel.prototype.createCopy = function() {
	var result = {nextKey:this.nextKey};
	result.contractedAccountId = this.contractedAccountId;
	result.lineSortField = this.lineSortField;
	result.applyAdditionalDiscountLast = this.applyAdditionalDiscountLast;
	result.applyPartnerDiscountFirst = this.applyPartnerDiscountFirst;
	result.channelDiscountsOffList = this.channelDiscountsOffList;
	result.lineItemCount = this.lineItemCount;
	result.record = this.record;
	result.deletedGroupIds = this.deletedGroupIds;
	result.deletedLineIds = this.deletedLineIds;
	result.displayedPageIndex = this.displayedPageIndex;
	result.selectedGroupKey = this.selectedGroupKey;
	result.multiSegmentRowExpanded = this.multiSegmentRowExpanded;
	angular.forEach(this.editorModel.quoteFields, function(field) {
		if (field.isRenderedAsLookup()) {
			var ref = this.record[field.describe.relationshipName];
			result.record[field.name] = (ref == null) ? null : ref.Id;
			delete result.record[field.describe.relationshipName];
		}
	}, this);
	return result;
}

QuoteModel.prototype.addGroup = function(/*SolutionGroup__c*/ solutionGroup) {
	this.nextKey++;
	var itemGroup = new QuoteLineGroupModel(this, {key:this.nextKey,record:{},lineItemCount:0});

	// Set a default group name on adding a group - needed for a better UX and drag & drop functionailty
	var index = this.editorModel.quote.lineItemGroups.length;
	itemGroup.record['Name'] = "Group" + (index + 1);
	if (this.editorModel.settings.paginationEnabled) {
		this.editorModel.updateDisplayedGroup(itemGroup.key, 'changeGroup');
	}

	if (solutionGroup != null) {
		itemGroup.record['Name'] = solutionGroup['Name'];
		itemGroup.record[QuoteLineGroupModel.DESCRIPTION_FIELD] = solutionGroup[QuoteLineGroupModel.DESCRIPTION_FIELD];
		itemGroup.record[QuoteLineGroupModel.SOLUTION_GROUP_ID_FIELD] = solutionGroup['Id'];
	}
	itemGroup.record[QuoteLineGroupModel.QUOTE_PROCESS_FIELD] = this.editorModel.defaultQuoteProcessId;
	this.lineItemGroups.push(itemGroup);
	this.editorModel.quote.renumberGroups();
	this.groupsByKey[itemGroup.key] = itemGroup;
	return itemGroup;
}

QuoteModel.prototype.getInputId = function(/*Field*/ field) {
	return ('q_' + field.name);
}

QuoteModel.prototype.moveLine = function(/*Integer*/ srcKey, /*Integer*/ targetKey) {
	var srcLine = this.lineItemsByKey[srcKey];

	if (srcLine.multiSegment) {
		this.moveMultiSegmentLineItem(srcKey, targetKey);
	} else if (srcLine.bundle && this.editorModel.settings.bundleKeptTogether) {
		this.moveBundleLineItem(srcKey, targetKey);
	} else {
		this.moveLineItem(srcKey, targetKey);
	}

	if (this.editorModel.settings.paginationEnabled) {
		this.renumberPaginated();
	} else {
		this.renumber();
	}
}

QuoteModel.prototype.moveLineItem = function(/*Integer*/ srcKey, /*Integer*/ targetKey) {
	var srcLine = this.lineItemsByKey[srcKey];
	var srcGroup = this.groupsByKey[srcLine.parentGroupKey];
	var srcLineItems = srcGroup.lineItems;
	if (srcLine != null) {
		var srcLineIdx = srcLineItems.indexOf(srcLine);
		if (srcLineIdx < 0) {
			return;
		}
		// remove the dragged line item
		srcLineItems.splice(srcLineIdx, 1);

		// add items back and update the groupKey
		var targetLine = this.lineItemsByKey[targetKey];
		var targetGroup = targetLine != null ? this.groupsByKey[targetLine.parentGroupKey] : this.groupsByKey[targetKey];
		var targetLineItems = targetGroup.lineItems;
		if (targetLine != null) {
			// target is another line item in the same group or in another group
			var targetLineIdx = targetLineItems.indexOf(targetLine);
			if (targetLineIdx < 0) {
				return;
			}

			// update target index & add the removed line item/(s) back at the target index and update the group key
			// when configured to keep bundles together, decrease index by 1 to not allow inserting between the bundle and its components
			var index = (targetLineIdx >= srcLineIdx && !(targetLine.bundle && this.editorModel.settings.bundleKeptTogether)) ? targetLineIdx + 1 : targetLineIdx;
			targetLineItems.splice(index, 0, srcLine);
			srcLine.parentGroupKey = targetLine.parentGroupKey;
		} else if (targetGroup != null) {
			// target is an empty group
			targetLineItems.push(srcLine);
			srcLine.parentGroupKey = targetGroup.key;
		}
	}
}

QuoteModel.prototype.moveMultiSegmentLineItem = function(/*Integer*/ srcKey, /*Integer*/ targetKey) {
	var srcLine = this.multiSegmentLineItemsByKey[srcKey];
	var srcGroup = this.groupsByKey[srcLine.parentGroupKey];
	var srcLineItems = srcGroup.multiSegmentLineItems;
	if (srcLine != null) {
		var srcLineIdx = srcLineItems.indexOf(srcLine);
		if (srcLineIdx < 0) {
			return;
		}
		// remove the dragged line item
		srcLineItems.splice(srcLineIdx, 1);
		for (var i = 0; i < srcLine.segments.length; i++) {
			var segmentIdx = srcGroup.lineItems.indexOf(srcLine.segments[i]);
			srcGroup.lineItems.splice(segmentIdx, 1);
		}

		// add items back and update the groupKey
		var targetLine = this.multiSegmentLineItemsByKey[targetKey];
		var targetGroup = targetLine != null ? this.groupsByKey[targetLine.parentGroupKey] : this.groupsByKey[targetKey];
		if (!targetGroup.multiSegmentLineItems) {
			targetGroup.multiSegmentLineItems = [];
			targetGroup.multiSegmentColumns = srcLine.getSegmentLabels();
		}
		var targetLineItems = targetGroup.multiSegmentLineItems;
		if (targetLine != null) {
			// target is another line item in the same group or in another group
			var targetLineIdx = targetLineItems.indexOf(targetLine);
			if (targetLineIdx < 0) {
				return;
			}

			// update target index & add the removed line item/(s) back at the target index and update the group key
			var index = targetLineIdx >= srcLineIdx ? targetLineIdx + 1 : targetLineIdx;
			// add segments to the end of the targetGroup as we do not know the order of segments within group.lineItems
			for (var i = 0; i < srcLine.segments.length; i++) {
				targetGroup.lineItems.push(srcLine.segments[i]);
			}

			targetLineItems.splice(index, 0, srcLine);
			var targetGroupKey = targetLine.parentGroupKey;
		} else if (targetGroup != null) {
			// target is an empty group
			for (var i = 0; i < srcLine.segments.length; i++) {
				targetGroup.lineItems.push(srcLine.segments[i]);
			}

			targetLineItems.push(srcLine);
			var targetGroupKey = targetGroup.key;
		}

		srcLine.parentGroupKey = targetGroupKey;
		angular.forEach(srcLine.segments, function(segment) {
			segment.parentGroupKey = targetGroupKey;
		});
	}
}

QuoteModel.prototype.moveMultiSegmentComponent = function(/*Integer*/ lineKey, /*Integer*/ targetKey) {
	// dragged multi-segment components added to the end of the target group's multiSegmentLineItems array whether target group is empty or has existing lines
	// we do not know the order of multi-segment components within a group
	var msLine = this.multiSegmentLineItemsByKey[lineKey];
	var srcGroup = this.groupsByKey[msLine.parentGroupKey];
	var index = srcGroup.multiSegmentLineItems.indexOf(msLine);
	if (index >= 0) {
		srcGroup.multiSegmentLineItems.splice(index, 1);
	}

	var targetGroup = this.groupsByKey[targetKey] ? this.groupsByKey[targetKey] : this.groupsByKey[msLine.parentGroupKey];
	if (!targetGroup.multiSegmentLineItems) {
		targetGroup.multiSegmentLineItems = [];
		targetGroup.multiSegmentColumns = msLine.getSegmentLabels();
	}
	targetGroup.multiSegmentLineItems.push(msLine);
	msLine.parentGroupKey = targetGroup.key;
}

QuoteModel.prototype.moveBundleLineItem = function(/*Integer*/ srcKey, /*Integer*/ targetKey) {
	var srcLine = this.lineItemsByKey[srcKey];
	var srcGroup = this.groupsByKey[srcLine.parentGroupKey];
	var srcLineItems = srcGroup.lineItems;
	if (srcLine != null) {
		var srcLineIdx = srcLineItems.indexOf(srcLine);
		if (srcLineIdx < 0) {
			return;
		}
		// remove the dragged line item
		var items = srcLineItems.splice(srcLineIdx, 1);
		// add components of the bundle to the items array
		this.getAllComponents(items, srcLine.key);
		for (var j = 1; j < items.length; j++) {
			var index = srcLineItems.indexOf(items[j]);
			srcLineItems.splice(index, 1);
		}

		// add items back and update the groupKey
		var targetLine = this.lineItemsByKey[targetKey];
		var targetGroup = targetLine != null ? this.groupsByKey[targetLine.parentGroupKey] : this.groupsByKey[targetKey];
		var targetLineItems = targetGroup.lineItems;
		if (targetLine != null) {
			// target is another line item in the same group or in another group
			var targetLineIdx = targetLineItems.indexOf(targetLine);
			if (targetLineIdx < 0) {
				return;
			}

			// update target index & add the removed line item/(s) back at the target index and update the group key
			// decrease index by 1 to not allow inserting between the bundle and its components
			var index = (targetLineIdx >= srcLineIdx && !(targetLine.bundle && this.editorModel.settings.bundleKeptTogether)) ? targetLineIdx + 1 : targetLineIdx;
			var segmentKeys = {};
			for (var i = 0; i < items.length; i++) {
				items[i].parentGroupKey = targetLine.parentGroupKey;
				// move segments of a multi-segment component
				if (items[i].multiSegment && (items[i].segmentIndex == 0 || items[i].segmentIndex == 1) && !segmentKeys[items[i].segmentKey]) {
					this.moveMultiSegmentComponent(items[i].key, targetLine.parentGroupKey);
					segmentKeys[items[i].segmentKey] = true;
				} else {
					targetLineItems.splice(index, 0, items[i]);
					index++;
				}
			}
		} else if (targetGroup != null) {
			// target is an empty group
			var segmentKeys = {};
			for (var i = 0; i < items.length; i++) {
				items[i].parentGroupKey = targetGroup.key;
				// move segments of a multi-segment component
				if (items[i].multiSegment && (items[i].segmentIndex == 0 || items[i].segmentIndex == 1) && !segmentKeys[items[i].segmentKey]) {
					this.moveMultiSegmentComponent(items[i].key, targetGroup.key)
					segmentKeys[items[i].segmentKey] = true;
					items[i].parentGroupKey = targetGroup.key;
				} else {
					targetLineItems.push(items[i]);
				}
			}
		}
	}
}


QuoteModel.prototype.moveGroup = function(/*Integer*/ srcKey, /*Integer*/ targetKey) {
	var srcGroup = this.groupsByKey[srcKey];
	if (srcGroup != null) {
		var targetGroup = this.groupsByKey[targetKey];
		if (targetGroup != null) {
			var srcGroupIdx = this.lineItemGroups.indexOf(srcGroup);
			if (srcGroupIdx < 0) {
				return;
			}
			this.lineItemGroups.splice(srcGroupIdx, 1);

			var targetGroupIdx = this.lineItemGroups.indexOf(targetGroup);
			if (targetGroupIdx < 0) {
				return;
			} else {
				if (targetGroupIdx >= srcGroupIdx) {
					this.lineItemGroups.splice(targetGroupIdx + 1, 0, srcGroup);
				} else {
					this.lineItemGroups.splice(targetGroupIdx, 0, srcGroup);
				}
			}
		}
	}

	this.renumber();
}

QuoteModel.prototype.toggleExpandedStatus = function(/*Object*/ line) {
	this.multiSegmentRowExpanded[line.segmentKey] = !this.multiSegmentRowExpanded[line.segmentKey];
	line.expanded = this.multiSegmentRowExpanded[line.segmentKey];
}

QuoteModel.prototype.expandAllRows = function(/*Object*/ group) {
	angular.forEach(group.multiSegmentLineItems, function(lineItem) {
		this.multiSegmentRowExpanded[lineItem.segmentKey] = true;
		lineItem.expanded = this.multiSegmentRowExpanded[lineItem.segmentKey];
	}, this);
}

QuoteModel.prototype.collapseAllRows = function(/*Object*/ group) {
	angular.forEach(group.multiSegmentLineItems, function(lineItem) {
		this.multiSegmentRowExpanded[lineItem.segmentKey] = false;
		lineItem.expanded = this.multiSegmentRowExpanded[lineItem.segmentKey];
	}, this);
}



QuoteModel.prototype.renumber = function() {

	this.renumberGroups();
	var items = this.getItemsFromGroups();
	this.renumberLines(items, 1);
}

QuoteModel.prototype.renumberPaginated = function() {

	this.renumberGroups();
	var items = this.getItemsFromGroups();
	this.renumberLines(items, this.getPaginatedIndex());
}

QuoteModel.prototype.renumberGroups = function() {
	var idx = 1;
	angular.forEach(this.lineItemGroups, function(itemGroup) {
		itemGroup.record[QuoteLineGroupModel.NUMBER_FIELD] = idx;
		idx++;
	});
}

QuoteModel.prototype.getItemsFromGroups = function() {
	var items = [];
	angular.forEach(this.lineItemGroups, function(itemGroup) {
		if (itemGroup.multiSegmentLineItems && itemGroup.multiSegmentLineItems.length > 0) {
			angular.forEach(itemGroup.multiSegmentLineItems, function(multiSegmentLineItem){
					items.push(multiSegmentLineItem);
			}, this);
			angular.forEach(itemGroup.lineItems, function(item){
				if (!item.multiSegment) {
					items.push(item);
				}
			}, this);
		} else {
			angular.forEach(itemGroup.lineItems, function(item) {
				items.push(item);
			}, this);
		}
	});

	return items;
}

QuoteModel.prototype.renumberLines = function(items, idx) {
	var invisibleIdx = 3000;
	angular.forEach(items, function(item) {
		if (item.isVisibleInEditor()) {
			item.record[QuoteLineModel.NUMBER_FIELD] = idx;
			if (item.multiSegment) {
				angular.forEach(item.segments, function(segment) {
					segment.record[QuoteLineModel.NUMBER_FIELD] = idx;
				});
			}
			idx++;
		} else {
			item.record[QuoteLineModel.NUMBER_FIELD] = invisibleIdx;
			if (item.multiSegment) {
				angular.forEach(item.segments, function(segment) {
					segment.record[QuoteLineModel.NUMBER_FIELD] = invisibleIdx;
				});
			}
			invisibleIdx++;
		}
	}, this);
}

QuoteModel.prototype.getPaginatedIndex = function() {
	var idx = 1;
	var group = (this.grouped && this.groupsByKey[this.selectedGroupKey]) ? this.groupsByKey[this.selectedGroupKey] : this;
	var pageIndex = group.displayedPageIndex ? group.displayedPageIndex : 1;
	var pageSize = this.editorModel.settings.pageSize ? this.editorModel.settings.pageSize : 25;

	if (this.grouped && this.lineItemGroups.length) {
		var index = this.lineItemGroups.indexOf(group);
		for (var i = 0; i < index; i++) {
			idx += this.lineItemGroups[i].lineItemRowCount;
		}
	}
	idx += (pageIndex - 1) * pageSize;

	return idx;
}

QuoteModel.prototype.getSelectedLineKeys = function() {
	var result = [];
	angular.forEach(this.lineItems, function(item) {
		if (item.selected) {
			result.push(item.key);
		}
	}, this);
	return result;
}

QuoteModel.prototype.clearLineSelections = function() {
	angular.forEach(scope.editorModel.lineItems, function(item) {
		if (item.selected) {
			item.selected = false;
		}
	}, this);
}

QuoteModel.prototype.getAllComponents = function(components, key){
	for (var i = 0; i < this.lineItemGroups.length; i++) {
		var group = this.lineItemGroups[i];
		for (var j = 0; j < group.lineItems.length; j++) {
			var item = group.lineItems[j];
			if (item.component && item.parentItemKey == key) {
				components.push(item);
				if (item.bundle){
					this.getAllComponents(components, item.key);
				}
			}
		}
	}
	return components;
}
QuoteModel.prototype.toggleLineOptional = true;

QuoteModel.prototype.updateLineOptional = function(/*Event*/ event) {
  angular.forEach(this.lineItems, function(item) {
    item.record[QuoteLineModel.OPTIONAL_FIELD] = this.toggleLineOptional;
  }, this);

  $(event.currentTarget).children('i').toggleClass( 'sb-icon-dot-circled sb-icon-circle-empty' );
  this.toggleLineOptional = !this.toggleLineOptional;
}




function QuoteLineGroupModel(/*QuoteModel*/ quote, /*Object*/ data) {
	this.lineItems = new Array();
	this.quote = quote;
	ModelUtils.copyProperties(data, this);
	//ModelUtils.convertValues(this.quote.editorModel.groupFields, this.record);
}

QuoteLineGroupModel.prototype.getVisibleLineItems = function() {
	var result = [];
	angular.forEach(this.lineItems, function(lineItem) {
		if (lineItem.isVisibleInEditor()) {
			result.push(lineItem);
		}
	}, this);
	return result;
}

QuoteLineGroupModel.prototype.hasLineItems = function() {
	return (this.lineItems.length > 0);
}

QuoteLineGroupModel.prototype.getTotal = function() {
	if (this.quote.grouped) {
		return (this.quote.applyAdditionalDiscountLast) ? this.record[QuoteLineGroupModel.CUSTOMER_TOTAL_FIELD] : this.record[QuoteLineGroupModel.NET_TOTAL_FIELD];
	} else {
		return (this.quote.applyAdditionalDiscountLast) ? this.quote.customerTotal : this.quote.netTotal;
	}
}

QuoteLineGroupModel.prototype.createCopy = function() {
	var result = {
		record: this.record,
		key: this.key,
		lineItemCount: this.lineItemCount,
		displayedPageIndex: this.displayedPageIndex
	};
	angular.forEach(this.quote.editorModel.groupFields, function(field) {
		if (field.isRenderedAsLookup()) {
			var ref = this.record[field.describe.relationshipName];
			result.record[field.name] = (ref == null) ? null : ref.Id;
		}
	}, this);
	return result;
}

QuoteLineGroupModel.prototype.getInputId = function(/*Field*/ field) {
	return ('g' + this.key + '_' + field.name);
}

QuoteLineGroupModel.prototype.updateLineOptional = function(/*Boolean*/ value) {
	angular.forEach(this.lineItems, function(item) {
		item.record[QuoteLineModel.OPTIONAL_FIELD] = value;
	}, this);
}

QuoteLineGroupModel.prototype.isOptional = function() {
	return this.record[QuoteLineGroupModel.OPTIONAL_FIELD];
}

QuoteLineGroupModel.prototype.addLineItem = function(/*QuoteLineModel*/ item) {
	this.lineItems.push(item);
	item.group = this;
	if (this.isOptional()) {
		item.record[QuoteLineModel.OPTIONAL_FIELD] = true;
	}
	return item;
}

QuoteLineGroupModel.prototype.addMultiSegmentLineItem = function(/*QuoteLineModel*/ item) {
	angular.forEach(item.segments, function(segment) {
		this.lineItems.push(segment);
	}, this);
	item.group = this;
	if (this.isOptional()) {
		angular.forEach(item.segments, function(segment) {
			segment.record[QuoteLineModel.OPTIONAL_FIELD] = true;
		}, this);
	}
	return item;
}

QuoteLineGroupModel.prototype.getGroupKey = function() {
	return this.quote.grouped ? this.key : null;
}

QuoteLineGroupModel.prototype.hasMultiSegmentProducts = function() {
	var result = false;
	angular.forEach(this.lineItems, function(item){
		if (item.multiSegment) {
			result = true;
			return;
		}
	}, this);
	return result;
}

QuoteLineGroupModel.prototype.hasStandardProducts = function() {
	var result = false;
	angular.forEach(this.lineItems, function(item){
		if (!item.multiSegment) {
			result = true;
			return;
		}
	}, this);
	return result;
}





function QuoteLineModel(/*QuoteModel*/ quote, /*QuoteLineGroupModel*/ group, /*Object*/ data) {
	ModelUtils.copyProperties(data, this);
	this.line = null;
	this.calculatedValues = null;
	// This needs to be after copyProperties
	this.quote = quote;
	this.group = group;

	// Default pricing method
	if (this.record[QuoteLineModel.PRICING_METHOD_FIELD] == null) {
		this.record[QuoteLineModel.PRICING_METHOD_FIELD] = 'List';
	}

	var optionType = this.record[QuoteLineModel.OPTION_TYPE_FIELD];
	this.renewedAssetId = this.record[QuoteLineModel.RENEWED_ASSET_ID_FIELD];
	this.component = (this.record[QuoteLineModel.OPTION_LEVEL_FIELD] != null);
	this.subscription = (this.record[QuoteLineModel.SUBSCRIPTION_PRICING_FIELD] != null);
	this.dynamicSubscription = (this.record[QuoteLineModel.SUBSCRIPTION_PRICING_FIELD] == 'Percent Of Total');
	this.subscriptionScopeEditable = this.dynamicSubscription && (this.record[QuoteLineModel.COMPONENT_SUBSCRIPTION_SCOPE_FIELD] == null) && (this.record[QuoteLineModel.SUBSCRIBED_ASSET_IDS_FIELD] == null);
	this.rootPackage = ModelUtils.isBlank(this.parentItemKey);
	this.legacySupport = !(this.record[QuoteLineModel.RENEWAL_CHECKBOX] == true && this.record[QuoteLineModel.EXISTING_FIELD] == false && this.record[QuoteLineModel.PRIOR_QUANTITY_FIELD] == null);
	this.quantityEditable = ((this.record[QuoteLineModel.BUNDLED_QUANTITY_FIELD] == null) || !this.component) && this.legacySupport && (this.productQuantityEditable);
	this.costEditable = (this.record[QuoteLineModel.COST_EDITABLE_FIELD] == true);
	this.unitCostEditable = this.costEditable && !this.bundled && !this.dynamicSubscription;
	this.pricingMethodList = (this.record[QuoteLineModel.PRICING_METHOD_FIELD] == 'List');
	this.pricingMethodCustom = (this.record[QuoteLineModel.PRICING_METHOD_FIELD] == 'Custom');
	this.pricingMethodCost = (this.record[QuoteLineModel.PRICING_METHOD_FIELD] == 'Cost');
	this.bundled = (this.record[QuoteLineModel.BUNDLED_FIELD] == true);
	this.bundle = (this.record[QuoteLineModel.BUNDLE_FIELD] == true);
	this.nonDiscountable = (this.record[QuoteLineModel.NON_DISCOUNTABLE_FIELD] == true);
	this.nonPartnerDiscountable = (this.record[QuoteLineModel.NON_PARTNER_DISCOUNTABLE_FIELD] == true);
	this.componentDiscountedByPackage = (this.record[QuoteLineModel.COMPONENT_DISCOUNTED_BY_PACKAGE_FIELD] == true);
	this.discountable = !this.bundled && !this.nonDiscountable && !this.pricingMethodCustom && !this.componentDiscountedByPackage;
	this.discountEditable = (this.quote.record[QuoteModel.TYPE_FIELD] != 'Amendment' || !this.record[QuoteLineModel.EXISTING_FIELD]);
	this.removable = (this.record[QuoteLineModel.OPTION_LEVEL_FIELD] == null) && (this.quote.record[QuoteModel.TYPE_FIELD] != 'Amendment' || (this.quote.record[QuoteModel.TYPE_FIELD] == 'Amendment' && !this.record[QuoteLineModel.EXISTING_FIELD]));
	this.rootPackage = this.bundle && !this.component;
	this.configurable = this.rootPackage && !this.reconfigurationDisabled && (this.configurationType != 'Disabled') && ((this.configurationEvent == null) || (this.configurationEvent == 'Always') || (this.configurationEvent == 'Edit'));
	this.listPriceEditable = this.record[QuoteLineModel.PRICE_EDITABLE_FIELD] && !this.bundled && !this.dynamicSubscription && this.pricingMethodList;
	this.multiSegment = (this.record[QuoteLineModel.SEGMENT_KEY] != null);
	this.segmentKey = this.record[QuoteLineModel.SEGMENT_KEY];
	this.segmentLabel = this.record[QuoteLineModel.SEGMENT_LABEL];
	this.segmentIndex = this.record[QuoteLineModel.SEGMENT_INDEX];

	this.units = {};
	// Default additional discount unit
	this.units[QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD] = this.quote.editorModel.defaultAdditionalDiscountUnit;
	if (this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD] != null) {
		this.units[QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD] = 'Amount';
	} else if (this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD] != null) {
		this.units[QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD] = 'Percent';
	}

	// Default markup unit
	this.units[QuoteLineModel.MARKUP_FIELD] = this.quote.editorModel.defaultMarkupUnit;
	if (this.record[QuoteLineModel.MARKUP_AMOUNT_FIELD] != null) {
		this.units[QuoteLineModel.MARKUP_FIELD] = 'Amount';
	} else if (this.record[QuoteLineModel.MARKUP_RATE_FIELD] != null) {
		this.units[QuoteLineModel.MARKUP_FIELD] = 'Percent';
	}

	//pricingMethodDisabled = lineVO.isDynamicSubscription() || lineVO.isBundled() || !lineVO.isPricingMethodEditable();
}

QuoteLineModel.prototype.resetAdditionalDiscount = function() {
	this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD] = null;
	this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD] = null;
	this.units[QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD] = this.quote.editorModel.defaultAdditionalDiscountUnit;
}

QuoteLineModel.prototype.isVisibleInEditor = function() {
	var visible = (this.componentVisibility == null) || (this.componentVisibility == 'Always') || (this.componentVisibility == 'Editor Only');
	if (visible && (this.renewedAssetId != null) && this.quote.editorModel.settings.renewedAssetsHiddenWhenEditing) {
		return false;
	}
	return visible;
}

QuoteLineModel.prototype.getProductName = function() {
	return this.record[QuoteLineModel.PRODUCT_NAME_FIELD];
}

QuoteLineModel.prototype.getNumber = function() {
	return this.record[QuoteLineModel.NUMBER_FIELD];
}

QuoteLineModel.prototype.createCopy = function() {
	var result = new Object();
	result.record = new Object();
	// Copy the attributes property of SObject
	result.record.attributes = this.record.attributes;
	result.key = this.key;
	result.parentGroupKey = this.parentGroupKey;
	result.parentItemKey = this.parentItemKey;
	result.componentVisibility = this.componentVisibility;
	result.validPricebookEntryExists = this.validPricebookEntryExists;
	result.opportunityLineItemExists = this.opportunityLineItemExists;
	result.dirty = this.dirty;
	angular.forEach(this.record, function(value, property) {
		if (this.quote.editorModel.calculatedLineFields[property] == null) {
			result.record[property] = value;
		}
	}, this);
	angular.forEach(this.quote.editorModel.lineFields, function(field) {
		if (field.isRenderedAsLookup()) {
			var ref = this.record[field.describe.relationshipName];
			result.record[field.name] = (ref == null) ? null : ref.Id;
			delete result.record[field.describe.relationshipName];
		}
	}, this);
	return result;
}

QuoteLineModel.prototype.getRowId = function(/*String*/ fieldName) {
	return (this.rowId != null) ? this.rowId : this.key;
}

QuoteLineModel.prototype.getInputId = function(/*Field*/ field) {
	return (field.name + '_' + this.key);
}

QuoteLineModel.prototype.isDisabled = function(/*Field*/ field) {
	if ((field.name == QuoteLineModel.OPTIONAL_FIELD) && (this.group != null) && this.group.isOptional()) {
		return true;
	}
	return false;
}

QuoteLineModel.prototype.isIncluded = function(/*Field*/ field) {
	return this.bundled && ((field.name == QuoteLineModel.LIST_PRICE_FIELD) || (field.name == QuoteLineModel.UNIT_COST_FIELD));
}

QuoteLineModel.prototype.isEditable = function(/*Field*/ field) {
	if (field.name == QuoteLineModel.QUANTITY_FIELD) {
		return field.updateable && this.quantityEditable;
	} else if (field.name == QuoteLineModel.LIST_PRICE_FIELD) {
		return field.updateable && this.listPriceEditable;
	} else if (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) {
		return this.discountable && this.discountEditable && !this.componentDiscountedByPackage;
	} else if (field.name == QuoteLineModel.PARTNER_DISCOUNT_FIELD) {
		return this.discountEditable;
	} else if (field.name == QuoteLineModel.DISTRIBUTOR_DISCOUNT_FIELD) {
		return this.discountEditable;
	} else if (field.name == QuoteLineModel.UPLIFT_FIELD) {
		return field.updateable && this.upliftable;
	} else if (field.name == QuoteLineModel.UNIT_COST_FIELD) {
		return field.updateable && this.unitCostEditable;
	} else if (field.name == QuoteLineModel.CUSTOMER_PRICE_FIELD) {
		return field.updateable && this.pricingMethodCustom;
	} else if (field.name == QuoteLineModel.PRICING_METHOD_FIELD) {
		return field.updateable && !this.pricingMethodDisabled;
	} else if (field.name == QuoteLineModel.MARKUP_FIELD) {
		return !this.bundled && this.pricingMethodCost;
	} else if (field.name == QuoteLineModel.NET_PRICE_FIELD) {
		return false;
	} else if (field.name == QuoteLineModel.PARTNER_PRICE_FIELD) {
		return false;
	} else if (field.name == QuoteLineModel.DESCRIPTION_FIELD) {
		return !this.descriptionLocked;
	} else if (field.name == QuoteLineModel.PACKAGE_PRODUCT_CODE_FIELD) {
		return false;
	} else if (field.name == QuoteLineModel.PRORATED_LIST_PRICE_FIELD) {
		return false;
	} else if (field.name == QuoteLineModel.REGULAR_PRICE_FIELD) {
		return false;
	}

	if ((this.fieldEditability != null) && (this.fieldEditability[field.name] != null)) {
		return (this.fieldEditability[field.name] == true);
	}

	if ((this.quote.lineFieldEditablity != null) && (this.quote.lineFieldEditability[field.name] != null)) {
		return (this.quote.lineFieldEditability[field.name] == true);
	}

	return field.updateable;
}

QuoteLineModel.prototype.isFieldRendered = function(/*Field*/ field) {
	if (!this.subscription) {
		if ((field.name == QuoteLineModel.START_DATE_FIELD) ||
				(field.name == QuoteLineModel.END_DATE_FIELD) ||
				(field.name == QuoteLineModel.SUBSCRIPTION_TERM_FIELD)) {
			return false;
		}
	}

	if (!this.dynamicSubscription && (field.name == QuoteLineModel.SUBSCRIPTION_BASE_FIELD)) {
		return false;
	}

	if (!this.discountable && (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD || field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD || field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD)) {
		return false;
	}

	if (!this.pricingMethodCost && (field.name == QuoteLineModel.MARKUP_FIELD)) {
		return false;
	}

	if (this.nonPartnerDiscountable && (field.name == QuoteLineModel.PARTNER_DISCOUNT_FIELD || field.name == QuoteLineModel.DISTRIBUTOR_DISCOUNT_FIELD)) {
		return false;
	}

	if ((this.fieldVisibility != null) && (this.fieldVisibility[field.name] != null)) {
		return (this.fieldVisibility[field.name] == true);
	}

	if ((this.quote.lineFieldVisibility != null) && (this.quote.lineFieldVisibility[field.name] != null)) {
		return (this.quote.lineFieldVisibility[field.name] == true);
	}

	return true;
}

QuoteLineModel.prototype.isUnitRendered = function(/*Field*/ field) {
	if ((field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) && this.discountable && this.discountEditable) {
		return true;
	} else if (field.name == QuoteLineModel.MARKUP_FIELD) {
		return true;
	}
	return false;
}

QuoteLineModel.prototype.getScale = function(/*Field*/ field) {
	if ((field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) && (this.units[field.name] != 'Amount')) {
		return null;
	}
	if ((field.name == QuoteLineModel.MARKUP_FIELD) && (this.units[field.name] != 'Amount')) {
		return null;
	}
	if (field.name == QuoteLineModel.DEFAULT_SUBSCRIPTION_TERM_FIELD) {
		return null;
	}
	if (field.name == QuoteLineModel.QUANTITY_FIELD) {
		return this.productQuantityScale != null ? this.productQuantityScale : this.quote.editorModel.settings.quantityScale;
	}
	if ((field.name == QuoteLineModel.LIST_PRICE_FIELD) ||
			(field.name == QuoteLineModel.REGULAR_PRICE_FIELD) ||
			(field.name == QuoteLineModel.SPECIAL_PRICE_FIELD) ||
			(field.name == QuoteLineModel.CUSTOMER_PRICE_FIELD) ||
			(field.name == QuoteLineModel.PARTNER_PRICE_FIELD) ||
			(field.name == QuoteLineModel.NET_PRICE_FIELD) ||
			(field.name == QuoteLineModel.UNIT_COST_FIELD) ||
			(field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) ||
			(field.name == QuoteLineModel.MARKUP_FIELD)) {
		return this.quote.editorModel.settings.priceScale;
	}
	return field.scale;
}

QuoteLineModel.prototype.mapPropertyName = function(/*Field*/ field) {
	if (field.name == QuoteLineModel.MARKUP_FIELD) {
		if (this.units[field.name] == 'Amount') {
			return QuoteLineModel.MARKUP_AMOUNT_FIELD;
		} else {
			return QuoteLineModel.MARKUP_RATE_FIELD;
		}
	} else if (field.name == QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD) {
		if (this.units[field.name] == 'Amount') {
			return QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD;
		} else {
			return QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD;
		}
	}
	return field.getValueProperty()
}

QuoteLineModel.prototype.changeAdditionalDiscountUnit = function() {
	var price = this.record[QuoteLineModel.REGULAR_PRICE_FIELD];
	if (this.units[QuoteLineModel.ADDITIONAL_DISCOUNT_FIELD] == 'Percent') {
		var discount = this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD];
		discount = (discount == null) ? 0 : discount;
		this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD] = (price != null) ? (discount / price * 100) : null;
		this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD] = null;
	} else {
		var rate = this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD];
		rate = (rate == null) ? 0 : rate;
		this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_AMOUNT_FIELD] = (price != null) ? (price * (rate / 100)) : null;
		this.record[QuoteLineModel.ADDITIONAL_DISCOUNT_RATE_FIELD] = null;
	}
}

QuoteLineModel.prototype.changeMarkupUnit = function() {
	var cost = this.record[QuoteLineModel.UNIT_COST_FIELD];
	if (this.units[QuoteLineModel.MARKUP_FIELD] == 'Percent') {
		var markup = this.record[QuoteLineModel.MARKUP_AMOUNT_FIELD];
		if (markup == null) {
			markup = 0;
		}
		this.record[QuoteLineModel.MARKUP_RATE_FIELD] = (cost != null) ? (markup / cost * 100) : null;
		this.record[QuoteLineModel.MARKUP_AMOUNT_FIELD] = null;
	} else {
		var markup = this.record[QuoteLineModel.MARKUP_RATE_FIELD];
		if (markup == null) {
			markup = 0;
		}
		this.record[QuoteLineModel.MARKUP_AMOUNT_FIELD] = (cost != null) ? (cost * (markup / 100)) : null;
		this.record[QuoteLineModel.MARKUP_RATE_FIELD] = null;
	}
}

QuoteLineModel.prototype.getIndentationClass = function(/*Field*/ field) {
	if (this.quote.editorModel.settings.productHierarchyVisualized && field.label == 'Product Name' && this.record[QuoteLineModel.OPTION_LEVEL_FIELD] > 0) {
		return 'sbIndent' + this.record[QuoteLineModel.OPTION_LEVEL_FIELD];
	} else {
		return '';
	}
}

QuoteLineModel.prototype.getFilteredLookupRecordIds = function(/*Field*/ field) {
	var ids = [];

	if (field.describe.filteredLookupInfo != null) {
		// controllingFields property of describe metadata seems to come back as string
		// rather than Array when there is only one filtered field
		var controllingFields = [];
		if (field.describe.filteredLookupInfo.controllingFields instanceof Array) {
			controllingFields = field.describe.filteredLookupInfo.controllingFields;
		} else {
			controllingFields.push(field.describe.filteredLookupInfo.controllingFields);
		}
		angular.forEach(controllingFields, function(fieldName) {
			var id = this.record[fieldName];
			if (id != null) {
				ids.push('"' + id + '"');
			}
		}, this);
	}

	return ids;
}

QuoteLineModel.prototype.isPrimaryQuote = function() {
	var prefix = this.quote.editorModel.developerPrefix;
	return this.quote.record[prefix + 'Primary__c'];
}

QuoteLineModel.prototype.updateSegmentOptional = function(/*Boolean*/ value) {
	angular.forEach(this.segments, function(item) {
		item.record[QuoteLineModel.OPTIONAL_FIELD] = value;
	}, this);
}

QuoteLineModel.prototype.updateSubscriptionScope = function(/*Boolean*/ value) {
	angular.forEach(this.segments, function(item) {
		item.record[QuoteLineModel.SUBSCRIPTION_SCOPE_FIELD] = value;
	}, this);
}

QuoteLineModel.prototype.getSegmentLabels = function(/*Integer*/ lineKey) {
	var labels = [];
	angular.forEach(this.segments, function(segment) {
		labels.push(segment.segmentLabel);
	}, this);
	return labels;
}

QuoteLineModel.prototype.isDescriptionField = function(/*Field*/ field) {
	return (field.name == QuoteLineModel.DESCRIPTION_FIELD && !this.descriptionLocked);
}

QuoteLineModel.prototype.isProductNameField = function(/*Field*/ field) {
	return field.name == QuoteLineModel.PRODUCT_NAME_FIELD;
}





function QuoteSummaryModel(/*QuoteModel*/ quote, /*Object*/ data) {
	this.values = new Object();
	ModelUtils.copyProperties(data, this);
	// This needs to be after copyProperties
	this.quote = quote;
}

QuoteSummaryModel.prototype.getInputId = function(/*Field*/ field) {
	return (field.name + '_' + this.key);
}

QuoteSummaryModel.prototype.isEditable = function(/*Field*/ field) {
	return false;
}

QuoteSummaryModel.prototype.isFieldRendered = function(/*Field*/ field) {
	if (this.record != null) {
		var value = this.record[this.mapPropertyName(field)];
		return ((value != undefined) && (value != null));
	}
	return false;
}

QuoteSummaryModel.prototype.mapPropertyName = function(/*Field*/ field) {
	return field.name.toLowerCase();
}
