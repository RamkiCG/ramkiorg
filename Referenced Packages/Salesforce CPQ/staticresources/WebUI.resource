/**
 * The main SteelBrick object
 * @type {Object}
 */
var SB = SB || {};

function qqBootstrapWeb(/*Object*/ config) {
	var qq = createSteelBrickCPQModule();
	qq.factory('sfdcSessionId', function() {return config.sessionId});
	qq.factory('packageNamespace', function() {return config.namespace});
	qq.factory('decimalSymbol', function() {return config.decimalSymbol});
	qq.factory('metaDataService', ['packageNamespace', 'sfdcSessionId', 'decimalSymbol', function(namespace, sessionId, decimalSymbol) {return new SoapMetaDataService(namespace, sessionId, decimalSymbol);}]);
	qq.factory('quoteServiceProxy', ['packageNamespace', function(namespace) {return new RemotingQuoteServiceProxy(namespace);}]);
	qq.factory('productServiceProxy', ['packageNamespace', function(namespace) {return new RemotingProductServiceProxy(namespace);}]);
	qq.factory('subscriptionServiceProxy', ['packageNamespace', function(namespace) {return new RemotingSubscriptionServiceProxy(namespace);}]);
	qq.factory('assetServiceProxy', ['packageNamespace', function(namespace) {return new RemotingAssetServiceProxy(namespace);}]);
	qq.factory('quoteDocumentServiceProxy', ['packageNamespace', function(namespace) {return new RemotingQuoteDocumentServiceProxy(namespace);}]);
	qq.factory('chatterServiceProxy', ['packageNamespace', function(namespace) {return new RemotingChatterServiceProxy(namespace);}]);

	angular.bootstrap(document, ['qq','ngDragDrop']);

	return qq;
}

/**
 * Configuration object for CKEDITOR that contains all common configuration settings for the RTE
 * @type {Object}
 */
SB.ckeditorConfig = {
  allowedContent: true,
  autoGrow_onStartup: true,
  autoParagraph: false,
  baseFloatZIndex: 51000, // higher than SF .overlayDialog
  entities_processNumerical: 'force',
  extraPlugins: 'sfdcImage',
  filebrowserImageUploadUrl: '/_ui/common/request/servlet/RtaImageUploadServlet',
  font_names: 'Arial/Arial,sans-serif;Courier/Courier,monospace;Helvetica/Helvetica,sans-serif;Montserrat/Montserrat;Times/Times,serif',
  imageUploadAllowedExtensions: '.(jpg|gif|jpeg|png|jfif|jpe|pjpeg)$',
  imageUploadDeniedExtensions: '',
  removePlugins: 'flash,forms,image',
  removeButtons: 'About,Save,NewPage,Preview,Print,Templates,CreateDiv,Language,Anchor,Smiley,PageBreak,Iframe',
  sfdcLabels: {}
}

function DescriptionEditorDialog(/*Object*/ scope) {
	this.title = 'Edit Description';
	this.id = 'DescriptionEditorDialog';
  this.isModal = true;
  this.width = '910px';
  this.height = '600px';
  this.buttons = [];
  this.addEvents();
  this.contentWrapper;
  this.contentCreated = false;
  this.editField = null;
  this.displayContainer = null;
  this.scope = scope;
}

if (window.Controller && !Controller.isMobileContext()) {
	DescriptionEditorDialog.prototype = new OverlayDialog();
}

DescriptionEditorDialog.prototype.createContent = function() {
    var content = document.getElementById(this.getContentId());
    var html = [];
    this.createButtons(html);
    this.contentWrapper = document.createElement("div");
    var editDescriptionContainer = document.getElementById('editDescriptionContainer');
    editDescriptionContainer.style.display = 'block';
    this.contentWrapper.appendChild(editDescriptionContainer);
    content.appendChild(this.contentWrapper);
    this.contentCreated = true;
}

DescriptionEditorDialog.prototype.onEdit = function(/*Function*/ getter, /*Function*/ setter, /*String*/ title, /*Integer*/ lineKey) {
	this.updateTitle(title);
	this.setter = setter;
	this.lineKey = lineKey;

	if( CKEDITOR.instances.qq_descriptionEditor )
		CKEDITOR.instances.qq_descriptionEditor.destroy();

	var value = getter();
	if ((value == undefined) || (value == null)) {
		value = '';
	}
	document.getElementById('qq_descriptionEditor').value = value;

  CKEDITOR.replace( document.querySelector( '#qq_descriptionEditor' ), SB.ckeditorConfig );
	this.show();
}

DescriptionEditorDialog.prototype.onSave = function() {
	this.setter( CKEDITOR.instances.qq_descriptionEditor.getData() );

	// to copy the summary line description field into each segment
	if (this.lineKey && this.scope.editorModel.quote.multiSegmentLineItemsByKey) {
		var editorModel = this.scope.editorModel;
		var line = editorModel.quote.multiSegmentLineItemsByKey[this.lineKey];
		var prefix = editorModel.developerPrefix;
		if (line && line.multiSegment && line.segments) {
			for (var i = 0; i < line.segments.length; i++) {
				line.segments[i].record[prefix + 'Description__c'] = CKEDITOR.instances.qq_descriptionEditor.getData();
			}
		}
	}

	this.hide();
  CKEDITOR.instances.qq_descriptionEditor.destroy();
}

DescriptionEditorDialog.prototype.onCancel = function() {
	this.valueExpr = null;
	this.hide();
  CKEDITOR.instances.qq_descriptionEditor.destroy();
}

DescriptionEditorDialog.prototype.updateTitle = function(/*String*/ title) {
	document.getElementById(this.id + 'Title').innerHTML = title;
}



function StatusPanel(/*Element*/ parent, /*String*/ message) {
	//console.log('Status Panel...' + message);
	var html = [];
	this.id = 'StatusMessage_' + (StatusPanel.LAST_ID + 1);
	StatusPanel.LAST_ID++;
    html.push('<table border="0" class="statusPanel"><tbody><tr>');
    html.push('<td><img src="/s.gif" class="waitIcon"/></td>');
    html.push('<td><span id="' + id + '">' + message + '</span></td>');
    html.push('</tr></tbody></table>');
    parent.innerHTML = html.join('');
}

StatusPanel.prototype.setMessage = function(/*String*/ value) {
	document.getElementById(this.id).innerHTML = value;
}

StatusPanel.LAST_ID = 0;


function RestUtils() {
}

RestUtils.getInstanceHostName = function() {
	var elements = location.hostname.split(".");
    var instance = null;
    if (elements.length == 4 && elements[1] === 'my') {
        instance = elements[0] + '.' + elements[1];
    } else if (elements.length == 3) {
        instance = elements[0];
    } else {
        instance = elements[1];
    }

    return "https://" + instance + ".salesforce.com";
}

function StatusService(/*OverlayStatusDialog*/ loadingDlg, /*OverlayStatusDialog*/ savingDlg) {
	this.loadingDlg = loadingDlg;
	this.savingDlg = savingDlg;
	this.loadingRegistered = false;
	this.savingRegistered = false;
}

StatusService.prototype.showLoading = function() {
	if (!this.loadingRegistered) {
		this.loadingDlg.register();
		this.loadingRegistered = true;
	}
	this.loadingDlg.show();
}

StatusService.prototype.showSaving = function() {
	if (!this.savingRegistered) {
		this.savingDlg.register();
		this.savingRegistered = true;
	}
	this.savingDlg.show();
}

StatusService.prototype.hideLoading = function() {
	this.loadingDlg.hide();
}

StatusService.prototype.hideSaving = function() {
	this.savingDlg.hide();
}


function resizeTableResults(/*ElementLookup*/ element) {
	element = $(element);
	// Must add an additional 111px to the height to account for the Salesforce header
	if ((element.height() + 111) < $(window).height()) {
		element.css('min-height', ($(window).height() - 180) + 'px');
	}
}

function resizePanels(/*ElementLookup*/ element, /*Boolean*/ panelOpen, /*TargetPanel*/ panel, /*AllPanels[]*/ panels) {
	var otherPanelOpened = null;
	element = $(element);
	panel = $(panel);

	if (panels.length > 0) {
		for (var i=0;i<panels.length;i++) {
			if (panels[i] != panel && $(panels[i]).hasClass('open')) {
				otherPanelOpened = $(panels[i]);
			}
		}
	}

	if (!panelOpen && otherPanelOpened == null) {
		panel.addClass('open');
		element.width(element.width() - panel.width());
		if (panel == 'sbGuided') {
			if ($('#sbGuidedMask').hasClass('close')) {
				var firstFieldSet = $(panel.find('fieldset')[0]).find('input')[0] || $(panel.find('fieldset')[0]).find('select')[0];
				$(firstFieldSet).focus();
			}
		} else {
			var firstFieldSet = $(panel.find('fieldset')[0]).find('input')[0] || $(panel.find('fieldset')[0]).find('select')[0];
			$(firstFieldSet).focus();
		}
	} else if (!panelOpen && otherPanelOpened != null) {
		otherPanelOpened.removeClass('open');
		panel.addClass('open');
		element.width(element.width() + (otherPanelOpened.width() - panel.width()));
		var firstFieldSet = $(panel.find('fieldset')[0]).find('input')[0] || $(panel.find('fieldset')[0]).find('select')[0];
		$(firstFieldSet).focus();
	} else if (panelOpen) {
		panel.removeClass('open');
		element.width('100%');
	}

  if ( $('#sbGuidedModal').length > 0 ) $('.sbFieldCon').css('max-height', '');
}

// This function allows a delay before the function is called. Primarily used for window resizing event.
function debounce(/*Function*/ func, /*TimeDelayed*/ delay, /*Boolean*/ immediate) {
    var timeout;
    return function() {
        var context = this,
            args = arguments;
        var later = function() {
            timeout = null;
            if (!immediate) {
            	func.apply(context, args);
            }
        };
        var callNow = immediate && !timeout;

        clearTimeout(timeout);
        timeout = setTimeout(later, delay);
        if (callNow) {
        	func.apply(context, args);
        }
    };
};

/*
  Set up the window scroll event listener that will fix/unfix the page header to the top of the browser window
 */
function handleFixedPageHeader() {
  $(window).load( function() {

    var qq = $('#qq').addClass( 'sbHeaderFixed' ),
        sfSidebar = $( '#sidebarCell' ),
        globalHeaderBar = $( '#globalHeaderBar' ),
        isSidebarOpen = !sfSidebar.hasClass( 'sidebarCollapsed' ),
        bodyDiv = $( '.bodyDiv' ),
        bodyDivBorder = bodyDiv.css( 'border-top-width' ), // need to get "3px" of SF border-top
        bodyDivPixels = bodyDivBorder && (bodyDivBorder.indexOf( 'px' ) == (bodyDivBorder.length-2)) ? parseInt( bodyDivBorder.substring( 0, bodyDivBorder.length-2 ) ) : 0;
        bottomOfHeader = $( '#AppBodyHeader' ).outerHeight() + bodyDivPixels + (globalHeaderBar.length ? globalHeaderBar.outerHeight() : 0),
        w = $(window),
        SF_GUTTER = 10,
        SF_HANDLE = 10;  //extra pixels for sidebar handle icon

    // check for non-Aloha UIs and reset positions as needed
    if( window.top != window.self ) { // we are in an iFrame, must be Service Could UI or new Lightning UI
      bottomOfHeader = 0;
      SF_GUTTER = 0;  // no gutters in SF Service Cloud UI
      SF_HANDLE = 0;
    }

    // need to run this positioning code every time the user expands/collapses the SF sidebar
    sfSidebar.children( '#handlebarContainer' ).click( function() {
      setTimeout( function() {
        w.resize();
      }, 10 );
    })

    w.on( 'scroll resize', function(e) {
      var windowWidth = w.width(),
          header = $('.sbPageTitle').filter( ':visible' ),
          canScrollH = $(document).width() > windowWidth,  // can we possibly scroll horizontally?
          scrollY = (this.scrollY || this.pageYOffset), // latter is for IE
          scrollX = (this.scrollX || this.pageXOffset), // latter is for IE
          isSidebarOpen = !sfSidebar.hasClass( 'sidebarCollapsed' ),
          sidebarWidth = isSidebarOpen ? sfSidebar.outerWidth() + SF_HANDLE : 0,
          left = scrollX > 0 ? Math.max( SF_GUTTER - scrollX, 0 ) : SF_GUTTER,
          right = canScrollH ? 0 : SF_GUTTER,
          top = scrollY <= bottomOfHeader ? (bottomOfHeader-scrollY) + 'px' : 0;

      if( isSidebarOpen )
        left = scrollX > 0 ? Math.max( sidebarWidth - scrollX, 0 ) : sidebarWidth;

      qq.css( 'padding-top', header.outerHeight() + 'px' );  // add same vertical amount as we are about to take out
      header.css( { left: left, right: right, top: top, visibility: 'visible' } );
    });
  });

/*
  w.on( 'scroll resize', function(e) {
    var windowWidth = w.width();
    var header = $('.sbPageTitle').filter( ':visible' );
    var canScrollH = $(document).width() > windowWidth;  // can we possibly scroll horizontally?
    var scrollY = (this.scrollY || this.pageYOffset); // latter is for IE

    if( !qq ) return;

    if( scrollY > bottomOfHeader ) {
        // Fixed header, special floaty positioning
      qq.css( 'margin-top', header.outerHeight() + 'px' );  // add same vertical amount as we are about to take out
      qq.addClass( 'sbHeaderFixed' );

      if( canScrollH )
        header.css( 'margin-right', 0 ); // keep header all the way on right since there is content there
    } else {
        // No fixed header, normal positioning.
        var rightHeader = $('.sbPageTitleRight').filter( ':visible' );
        rightHeader.width( windowWidth - rightHeader.offset().left - 15 ); // position in view, always

        qq.css( 'margin-top', '0px' );  // remove vertical amount as we are about to take out
      qq.removeClass( 'sbHeaderFixed' );

        if( canScrollH )
            header.css( 'margin-right', '' );  // reset it back
    }
  });
*/
}

/*
  Set up the window resize event listener that will resize the search tables (Product/Asset/Subscription Lookup)
 */
function handleSearchTableResize() {
  window.addEventListener('resize', debounce(function() {

    var panel = $('.sbGuided'),
        pfPanel = $('.sbProductFilter');

    if( $('.sbAssetFilter').hasClass('open') )
      $('.sbTable.sbAssets').css('transition', 'none').width($('#sbAssetSearch').width() - panel.width());

    if( $('.sbSubscriptionFilter').hasClass('open') )
      $('.sbTable.sbSubscriptions').css('transition', 'none').width($('#sbSubscriptionSearch').width() - panel.width());

    var p;
    if( panel.hasClass('open') ) {
      p = panel;
    } else if ( pfPanel.hasClass('open')) {
      p = pfPanel;
    }

    if( p )
      $('.sbTable.sbProducts').css('transition', 'none').width($('#sbProductSearch').width() - p.width());
  }, 100));
}

function handleGuidedModalResize() {
  var w = $(window),
      guidedModal = $('.sbFieldCon');
  w.on('resize', function(e) {
    $('#bodyCell').css('min-height', (w.height() - 130) + 'px'); // 130 is approximate height of SF header.
    if ( $('.sbGuided').length == 0 ) {
      guidedModal.css('max-height', (w.height() - 500) + 'px');
    }
  })
}
