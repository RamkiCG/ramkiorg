function QuoteDocumentGeneratorCtrl(scope, controllerManager, metaDataService, quoteDocumentService) {
	controllerManager.register('QuoteDocumentGenerator', this);

	this.scope = scope;
	this.scope.active = false;
	this.scope.controller = this;
	this.scope.controllerManager = controllerManager;
	this.scope.quoteDocumentService = quoteDocumentService;
	this.scope.metaDataService = metaDataService;
	this.scope.initialized = false;
	this.scope.blockingOperationInProgress = false;

	this.scope.onLoad = this.onLoad;
	this.scope.onCancel = this.onCancel;
	this.scope.onPreview = this.onPreview;
	this.scope.onSave = this.onSave;
	this.scope.onSaveAndEmail = this.onSaveAndEmail;
	this.scope.onSaveAndSendESignature = this.onSaveAndSendESignature;
	this.scope.onTemplateChanged = this.onTemplateChanged;
	this.scope.onEmailMe = this.onEmailMe;
	this.scope.mobilePreview = false;

	this.previewDlg = null;
}
QuoteDocumentGeneratorCtrl.$inject = ['$scope', 'controllerManager', 'metaDataService', 'quoteDocumentServiceProxy'];
QuoteDocumentGeneratorCtrl.prototype = new Controller();


QuoteDocumentGeneratorCtrl.prototype.onPreview = function() {
	var scope = this;
	scope.blockingOperationInProgress = true;
	scope.errors = null;

	var qid = scope.documentModel.quoteId;
	var tid = scope.documentModel.templateId;
	var dn = scope.documentModel.documentName;
	var docIds = scope.relatedContentSelectionModel.getSelectedValues();
	var quoteDocIdx = 0;
	for (var i=0;i<docIds.length;i++) {
		if (docIds[i] == qid) {
			quoteDocIdx = i;
		}
	}

	var successHandler = function(/*String[]*/ parts) {
		scope.blockingOperationInProgress = false;
		var iframe;
		if (Controller.isMobileContext()) {
			iframe = document.getElementById('mobilePreviewFrame');
			scope.mobilePreview = true;
		} else {
			scope.controller.previewDlg.show();
			iframe = document.getElementById(scope.controller.previewDlg.getPreviewFrameId());
		}
		scope.$apply();
		scope.controller.loadPreview(iframe, quoteDocIdx, parts);
	};
	scope.quoteDocumentService.generateDocuments(qid, tid, dn, 'PDF', docIds, successHandler, this.controller.createErrorHandler());
}

QuoteDocumentGeneratorCtrl.prototype.onSave = function() {
	var scope = this;
	scope.blockingOperationInProgress = true;
	scope.errors = null;

	var qid = scope.documentModel.quoteId;
	var tid = scope.documentModel.templateId;
	var dn = scope.documentModel.documentName;
	var of = scope.documentModel.outputFormat;
	var docIds = scope.relatedContentSelectionModel.getSelectedValues();

	var successHandler = function(/*String*/ result) {
		var quoteDocument = angular.fromJson(result);
		if (scope.controller.isMobile()) {
			sforce.one.navigateToSObject(qid, 'chatter');
		} else {
			document.location.assign(scope.controller.getCommunityPrefix() + '/' + quoteDocument.Id);
		}
	};
	scope.quoteDocumentService.saveProposal(qid, tid, dn, of, docIds, successHandler, this.controller.createErrorHandler());
}

QuoteDocumentGeneratorCtrl.prototype.onSaveAndEmail = function() {
	var scope = this;
	scope.blockingOperationInProgress = true;
	scope.errors = null;

	var qid = scope.documentModel.quoteId;
	var tid = scope.documentModel.templateId;
	var dn = scope.documentModel.documentName;
	var of = scope.documentModel.outputFormat;
	var docIds = scope.relatedContentSelectionModel.getSelectedValues();

	var successHandler = function(/*String*/ result) {
		document.location.assign(result);
		scope.blockingOperationInProgress = false;
		scope.$apply();
	};
	scope.quoteDocumentService.saveAndEmailProposal(qid, tid, dn, of, docIds, successHandler, this.controller.createErrorHandler());
}

QuoteDocumentGeneratorCtrl.prototype.onSaveAndSendESignature = function() {
	var scope = this;
	scope.blockingOperationInProgress = true;
	scope.errors = null;

	var qid = scope.documentModel.quoteId;
	var tid = scope.documentModel.templateId;
	var dn = scope.documentModel.documentName;
	var of = scope.documentModel.outputFormat;
	var docIds = scope.relatedContentSelectionModel.getSelectedValues();

	var successHandler = function(/*String*/ result) {
		var quoteDocument = angular.fromJson(result);
		if (scope.controller.isMobile()) {
			sforce.one.navigateToSObject(qid, 'chatter');
		} else {
			document.location.assign(scope.controller.getCommunityPrefix() + '/' + quoteDocument.Id);
		}
	};
	scope.quoteDocumentService.saveAndSendProposalForESignature(qid, tid, dn, of, docIds, successHandler, this.controller.createErrorHandler());
}

QuoteDocumentGeneratorCtrl.prototype.onEmailMe = function() {
	var scope = this;
	scope.blockingOperationInProgress = true;
	scope.errors = null;

	var qid = scope.documentModel.quoteId;
	var tid = scope.documentModel.templateId;
	var dn = scope.documentModel.documentName;
	var of = scope.documentModel.outputFormat;
	var docIds = scope.relatedContentSelectionModel.getSelectedValues();

	var successHandler = function(/*String*/ result) {
		if (scope.controller.isMobile()) {
			sforce.one.navigateToSObject(qid, 'chatter');
		} else {
			document.location.assign(scope.controller.getCommunityPrefix() + '/' + qid);
		}
	};
	scope.quoteDocumentService.emailMeProposal(qid, tid, dn, of, docIds, successHandler, this.controller.createErrorHandler());
}

QuoteDocumentGeneratorCtrl.prototype.onCancel = function() {
	var scope = this;
	var qid = scope.documentModel.quoteId;
	if (scope.controller.isMobile()) {
		sforce.one.navigateToSObject(qid, 'detail');
	} else {
		document.location.assign(scope.controller.getCommunityPrefix() + '/' + qid);
	}
}

QuoteDocumentGeneratorCtrl.prototype.onLoad = function(/*String*/ quoteId, /*String*/ actionName) {
	var controller = this.controller;
	var scope = this;
	scope.currentAction = actionName;
	scope.blockingOperationInProgress = true;

	var successHandler = function(/*String*/ result) {
		//console.log(angular.toJson(angular.fromJson(result), true));
		scope.documentModel = angular.fromJson(result);
		scope.relatedContentSelectionModel = scope.controller.createRelatedContentSelectionModel();
		scope.controllerManager.activateController(controller);

		var model = scope.documentModel;
		if (!Controller.isMobileContext()) {
			scope.controller.previewDlg = new QuoteDocumentPreviewDialog(model.resources['lbl_quote_preview'], model.documentServiceEndpoint, model.previewInFullPage);
			scope.controller.previewDlg.register();
		}

		scope.controller.checkOptionalRelatedContent.apply(scope.documentModel, arguments);
		if (scope.currentAction === 'preview' && !model.hasOptionalRelatedContent && !model.templateSelectorShown) {
			scope.blockingOperationInProgress = true;
			scope.controller.executeApply();
			scope.onPreview();
		}
	};
	scope.quoteDocumentService.loadDocumentModel(quoteId, successHandler, controller.createErrorHandler());
}

QuoteDocumentGeneratorCtrl.prototype.checkOptionalRelatedContent = function() {
	this.hasOptionalRelatedContent = false;
	angular.forEach(this.relatedContent, function(item) {
		if (!item.required) {
			this.hasOptionalRelatedContent = true;
		}
	}, this);
}

QuoteDocumentGeneratorCtrl.prototype.onClosePreview = function() {
	scope.mobilePreview = false;
}

QuoteDocumentGeneratorCtrl.prototype.onTemplateChanged = function() {
	var scope = this;
	var controller = scope.controller;
	scope.blockingOperationInProgress = true;
	scope.errors = null;

  $('#qq > div > .message').remove(); // remove any error messages

	var successHandler = function(/*String*/ result) {
		//console.log(angular.toJson(angular.fromJson(result), true));
		scope.documentModel.relatedContent = angular.fromJson(result);
		scope.relatedContentSelectionModel = scope.controller.createRelatedContentSelectionModel();
		scope.controllerManager.activateController(controller);
	};
	var quoteId = scope.documentModel.quoteId;
	var templateId = scope.documentModel.templateId;
	scope.quoteDocumentService.listRelatedContent(quoteId, templateId, successHandler, controller.createErrorHandler());
}

QuoteDocumentGeneratorCtrl.prototype.createRelatedContentSelectionModel = function() {
	var model = new SelectionModel();
	model.addSelected({value:this.scope.documentModel.quoteId,label:'Quote Document',required:true});
	angular.forEach(this.scope.documentModel.relatedContent, function(/*RelatedContentVO*/ rc) {
		if (rc.required) {
			model.addSelected({value:rc.documentId,label:rc.displayName,required:rc.required,title:rc.metaDataSummary});
		} else {
			model.addAvailable({value:rc.documentId,label:rc.displayName,required:rc.required,title:rc.metaDataSummary});
		}
	}, this);
	return model;
}

QuoteDocumentGeneratorCtrl.prototype.loadPreview = function(/*Element*/ parent, /*integer*/ quoteDocIndex, /*String[]*/ documentParts) {
	var form;
	if (parent.nodeName.toUpperCase() == 'IFRAME') {
		var iframeDoc;
		if (parent.contentDocument && parent.contentDocument.body) {
			iframeDoc = parent.contentDocument;
		} else {
			iframeDoc = parent.contentWindow.document;
		}
		form = this.createPreviewForm(iframeDoc, quoteDocIndex, documentParts);
		iframeDoc.body.appendChild(form);
		/* $(iframeDoc).ready(function() {
			$(parent).css('height','auto');
			var height = $(iframeDoc.body).height();
			alert('H:' + height);
			$(parent).height(height * 3);
		}); */
	} else {
		form = this.createPreviewForm(document, quoteDocIndex, documentParts);
		parent.appendChild(form);
	}
	form.submit();
}

QuoteDocumentGeneratorCtrl.prototype.createPreviewForm = function(/*Document*/ doc, /*integer*/ quoteDocIndex, /*String[]*/ documentParts) {
	var form = doc.createElement("form");
    form.setAttribute("method", "POST");
    form.setAttribute("action", this.scope.documentModel.documentServiceEndpoint);

	var hiddenField;

	hiddenField = doc.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "quoteDocIndex");
    hiddenField.setAttribute("value", quoteDocIndex);
    form.appendChild(hiddenField);

	hiddenField = doc.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "documentCount");
    hiddenField.setAttribute("value", documentParts.length);
    form.appendChild(hiddenField);

    hiddenField = doc.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "outputFormat");
    hiddenField.setAttribute("value", "binary");
    form.appendChild(hiddenField);

	for (var i=0; i<documentParts.length; i++) {
	    hiddenField = doc.createElement("input");
	    hiddenField.setAttribute("type", "hidden");
	    hiddenField.setAttribute("name", "document" + i);
	    hiddenField.setAttribute("value", documentParts[i]);
	    form.appendChild(hiddenField);
    }
    return form;
}



function QuoteDocumentPreviewDialog(title, previewBaseUrl, fullScreen) {
    this.id = 'QuoteDocumentPreviewDialog';
    this.isModal = true;
    this.fullScreen = fullScreen;
    if (fullScreen) {
    	this.width = ((window.innerWidth || document.documentElement.clientWidth) - 40) + 'px';
    } else {
    	this.width = '910px';
    }

    this.title = title;
    this.buttons = [];
    this.addEvents();
    this.previewBaseUrl = previewBaseUrl;
}

if (!Controller.isMobileContext()) {
	QuoteDocumentPreviewDialog.prototype = new OverlayDialog();
}

QuoteDocumentPreviewDialog.prototype.hide = function() {
	// Clear out the source; otherwise, the inline PDF viewer doesn't go away. Maybe a FF bug.
	var iframe = document.getElementById(this.getPreviewFrameId());
	if (iframe != null) {
		iframe.src = '';
	}
	OverlayDialog.prototype.hide.call(this);
}

QuoteDocumentPreviewDialog.prototype.createContent = function() {
    var content = document.getElementById(this.getContentId());
    var loadingHtml = '<div class="sbLoading sb-icon-loading" style="opacity: 0.99"><div class="sb-icon-bounce1"></div><div class="sb-icon-bounce2"></div><div class="sb-icon-bounce3"></div></div>';

    var height = 425;
    if (this.fullScreen) {
    	height = (window.innerHeight || document.documentElement.clientHeight);
    }
    var html = [];
    html.push('<div style="padding: 10px; text-align: center; font-weight: bold; width: 100%; color: rgb(204, 0, 0); display: none;" id="' + this.id + '_errorElement"></div>');
    html.push('<div id="' + this.id + '_quotePDFEmbed_parent">');
    html.push(loadingHtml);
    html.push('<iframe width="100%" allowTransparency="true" style="position: relative; border: 0px solid black; height: ' + height + 'px;" type="application/pdf" src="" id="' + this.getPreviewFrameId() + '" name="' + this.getPreviewFrameId() + '"></iframe></div>');
    this.createButtons(html);
    var div = document.createElement("div");
    div.innerHTML = html.join('');
    content.appendChild(div);
}

QuoteDocumentPreviewDialog.prototype.getPreviewFrameId = function() {
	return this.id + '_quotePDFEmbed';
}

QuoteDocumentPreviewDialog.prototype.loadEnhancedPreview = function(quoteDocIndex, documentArray) {
	var iframe = document.getElementById(this.getPreviewFrameId());
}
