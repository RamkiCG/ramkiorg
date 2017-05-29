function Directives() {
}

Directives.keyDown = function() {
    return {
        restrict: 'A',
        controller: function($scope, $element, $attrs) {
        	return {};
        },
        link: function(scope, element, attrs, controller) {
        	element.on('keydown', function(event) {
        		scope.$eval(attrs.qqKeydown, {$event:event});
        	});
        }
    };
}

Directives.change = function() {
	return {
		restrict: 'A',
		controller: function($scope, $element, $attrs) {
			return {};
		},
		link: function(scope, element, attrs, controller) {
			var quote = scope.$parent.editorModel.quote;
			var group = quote.grouped ? quote.groupsByKey[quote.selectedGroupKey] : quote;

			if (!quote.grouped || (quote.grouped && scope.group.key === quote.selectedGroupKey)) {
				element.val(group.displayedPageIndex);
				element.on('change', function() {
					event.preventDefault();
					event.stopPropagation();
					var pageIndex = element.val();
					scope.$apply(function() {
						if (pageIndex >= 1 && pageIndex <= group.totalPageCount) {
							group.displayedPageIndex = pageIndex;
						}
						scope.$eval(attrs.qqChange, {$event:event});
					});
				});
			}
		}
	};
}

Directives.dynamicField = function() {
    return {
        restrict: 'A',
        controller: function($scope, $element, $attrs) {return new DynamicFieldController($scope, $attrs);},
        link: function(scope, element, attrs, controller) {
        	var prefix = scope.metaDataService.getPrefix();
        	controller.picklistMgrExpr = attrs.qqPicklistManager == null ? '$parent' : attrs.qqPicklistManager;
        	var picklistMgrScope = scope.$eval(controller.picklistMgrExpr);
        	if (scope.$first && ((picklistMgrScope.picklistManager == null) || (picklistMgrScope.picklistManager.scopeId != picklistMgrScope.$id))) {
        		picklistMgrScope.picklistManager = new PicklistManager(picklistMgrScope);
        	}

        	if (controller.field == null) {
        		return;
        	}

        	var fieldEL = null;

        	if (!controller.editable) {
                var formattedValue = controller.getFormattedValue((controller.field.name == prefix + 'AdditionalDiscount__c') && scope.$eval(attrs.qqUnitValue) == 'Percent');
                if( controller.field.isRenderedAsCheckbox() ) {
                  fieldEL = controller.createCheckboxReadonly( formattedValue );
                }
                else {
                	var value = (ModelUtils.isBlank(scope.$eval(attrs.qqValue)) && attrs.qqBlankValue) ? attrs.qqBlankValue : formattedValue;
                    if (value != null && (((controller.field.name == prefix + 'AdditionalDiscount__c') && scope.$eval(attrs.qqUnitValue) == 'Percent') || (controller.field.name == prefix + 'DistributorDiscount__c') || (controller.field.name == prefix + 'PartnerDiscount__c'))) {
                    	value = value + ' %';
                    }
                    element.html(value);
                }
        	} else if (controller.field.isRenderedAsDate()) {
        		fieldEL = controller.createDateInput(element, attrs.qqSegment);
        	} else if (controller.field.isRenderedAsNumber()) {
        		var multiOption = ((controller.field.name == prefix + 'AdditionalDiscount__c') || (controller.field.name == prefix + 'Markup__c')) ? true : false;
        		fieldEL = controller.createNumberInput(element, attrs.qqSegment, multiOption);
        	} else if (controller.field.isRenderedAsCheckbox()) {
        		fieldEL = controller.createCheckboxInput(element);
        	} else if (controller.field.isRenderedAsSelect()) {
        		fieldEL = controller.createPicklistInput(element);
        	} else if (controller.field.isRenderedAsText()) {
        		fieldEL = controller.createTextInput(element);
        	} else if (controller.field.isRenderedAsTextArea()) {
        		fieldEL = controller.createTextAreaInput(element);
        	} else if (controller.field.isRenderedAsRichText()) {
        		if ((controller.field.name == prefix + 'Description__c') && ModelUtils.isBlank(scope.$eval(attrs.qqValue)) && attrs.qqPlaceholderValue && !Controller.isMobileContext()) {
        			element.html(attrs.qqPlaceholderValue);
        		}
        		fieldEL = controller.createRichTextInput(element);
        	} else if (controller.field.isRenderedAsLookup() && !Controller.isMobileContext()) {
        		fieldEL = controller.createLookup(element);
        	}

        	if ((scope.$last || attrs.qqSegment) && picklistMgrScope && picklistMgrScope.picklistManager) {
        		picklistMgrScope.picklistManager.initOptions();
        	}

        	if (controller.field.isRenderedAsNumber()) {
    			element.css('white-space', 'nowrap');
    		}

        	if (fieldEL != null) {
        		element.append(fieldEL);
        	}


        	// Process unit selector
        	var unitExpr = attrs.qqUnit;
        	var valueExpr = attrs.qqUnitValue;
        	var optionsExpr = attrs.qqUnitOptions;
        	var changeExpr = attrs.qqUnitOnChange;

        	var rendered = scope.$eval(unitExpr);
        	if (rendered) {
	        	var options = scope.$eval(optionsExpr);
	        	if ((options != null) && (options.length > 0)) {
	        		var value = scope.$eval(valueExpr);
	        		var select = angular.element(document.createElement('select'));
	        		angular.forEach(options, function(option) {
	        			var optionEL = angular.element(document.createElement('option'));
	        			optionEL.val(option.value);
	        			optionEL.text(option.label);
	        			select.append(optionEL);
	        		});
	        		select.val(value);
	        		element.append(select);
	        		scope.$watch(valueExpr, function(newValue, oldValue) {
						select.val(newValue);
					});
	        		select.on('change', function() {
	        			scope.$apply(function() {
	        				scope.$eval(valueExpr + '=dfcUnitValue', {dfcUnitValue:select.val()});
	        				if (changeExpr != null) {
	        					scope.$eval(changeExpr);
	        				}
	        			});
		        	});
	        	}

        	}
        }
    };
}



function DynamicFieldController(scope, attrs) {
	this.scope = scope;

	this.filter = angular.injector(['ng']).get('$filter');

	this.fieldExpr = attrs.qqField;
	this.valueExpr = attrs.qqValue;
	this.editableExpr = attrs.qqEditable;
	this.disabledExpr = attrs.qqDisabled;
	this.changeExpr = attrs.qqOnChange;
	this.currencyExpr = attrs.qqCurrencySymbol;
	this.staticValueExpr = attrs.qqStaticValue;
	this.scaleExpr = attrs.qqScale;
	if (!ModelUtils.isBlank(attrs.qqRange)) {
		this.renderAsRange = this.scope.$eval(attrs.qqRange);
	}
	this.key = (attrs.qqKey != null) ? this.scope.$eval(attrs.qqKey) : null;
	if (this.key == null) {
		// No explicitly key specified; generate one automatically. Prepend 'SYS' to avoid name collision.
		this.key = 'SYS' + ModelUtils.generateKey();
	}

	this.field = this.scope.$eval(this.fieldExpr);
	this.editable = this.scope.$eval(this.editableExpr);
	this.currencySymbol = this.scope.$eval(this.currencyExpr);
	this.input = null;

	if (this.field && this.field.isRenderedAsLookup() && !ModelUtils.isBlank(attrs.qqFilteredLookupRecordIds)) {
		this.filteredLookupRecordIds = this.scope.$eval(attrs.qqFilteredLookupRecordIds);
	}
}

DynamicFieldController.prototype.getFormattedValue = function(/*Boolean*/ noCurrencySymbol) {
	if (this.staticValueExpr != null) {
		var staticValue = this.scope.$eval(this.staticValueExpr);
		if (staticValue != null) {
			return staticValue;
		}
	}
	var scale = this.field.scale;
	if (!ModelUtils.isBlank(this.scaleExpr)) {
		scale = this.scope.$eval(this.scaleExpr);
	}
	var value = this.scope.$eval(this.valueExpr);
	if (noCurrencySymbol) {
		return this.field.formatValue(value, null, scale);
	}
	return this.field.formatValue(value, this.currencySymbol, scale);
}

DynamicFieldController.prototype.createDateInput = function(/*Element*/ container, /*Booelan*/ multiSegment) {
	if (this.renderAsRange) {
		var span = angular.element(document.createElement('span'));
		var startInput = this.createDateInputInternal(container, true);
		var endInput = this.createDateInputInternal(container, false);
		var sep = angular.element(document.createElement('span'));
		sep.html(' - ');
		span.append(startInput);
		span.append(sep);
		span.append(endInput);
		return span;
	}
	return this.createDateInputInternal(container, multiSegment);
}

DynamicFieldController.prototype.createDateInputInternal = function(/*Element*/ container, /*Booelan*/ multiSegment, /*Boolean*/ startRange) {
	var controller = this;
	var locale = controller.getUserLocale();
	var input = angular.element(document.createElement('input'));
	var size = multiSegment ? 15 : this.field.getInputSize();
	input.prop('size', size);
	this.configureInputControl(input, startRange);
	//Need to adjust jQuery's native _gotoToday method so that clicking the 'Today' button will input the selected date.
	$.datepicker._gotoToday = function(id) {
		$(id).datepicker('setDate', new Date()).datepicker('hide').change().blur();
	};
	$.datepicker.setDefaults($.datepicker.regional[locale]);
	input.datepicker({
		changeMonth: true,
		changeYear: true,
		showOtherMonths: true,
		selectOtherMonths: true,
		showButtonPanel: true,
		dayNamesMin: $.datepicker._defaults.dayNamesShort,
		monthNamesShort: $.datepicker._defaults.monthNames,
		closeText: '',
		prevText: '',
		nextText: ''
	});
	return input;
}

DynamicFieldController.prototype.getUserLocale = function() {
	var locale = UserContext.locale.replace(/_/g, '-');
	var availableLocales = {
		'af':'af','ar':'ar','ar-DZ':'ar-DZ','ar':'ar','az':'az','be':'be','bg':'bg','bn':'bn','bs':'bs','ca':'ca','cs':'cs',
		'cy-GB':'cy-GB','da':'da','de':'de','el':'el','en-AU':'en-AU','en-GB':'en-GB','en-NZ':'en-NZ','eo':'eo','es':'es','et':'et',
		'eu':'eu','fa':'fa','fi':'fi','fo':'fo','fr':'fr','fr-CA':'fr-CA','fr-CH':'fr-CH','ga':'ga','gl':'gl','hi':'hi','hr':'hr',
		'hu':'hu','hy':'hy','in':'id','is':'is','it':'it','it-CH':'it-CH','iw':'he','ja':'ja','ka':'ka','kk':'kk','km':'km','ko':'ko',
		'ky':'ky','lb':'lb','lt':'lt','lv':'lv','mk':'mk','ml':'ml','ms':'ms','mt':'mt','nb':'nb','nl':'nl','nl-BE':'nl-BE','nn':'nn',
		'no':'no','pl':'pl','pt':'pt','pt-BR':'pt-BR','rm':'rm','ro':'ro','ru':'ru','sh':'sr-SR','sk':'sk','sl':'sl','sq':'sq','sr':'sr',
		'sv':'sv','ta':'ta','tg':'tj','th':'th','tr':'tr','tl':'tl','uk':'uk','vi':'vi','zh-CN':'zh-CN','zh-HK':'zh-HK','zh-TW':'zh-TW'
	};
	if (availableLocales[locale] != undefined) {
		return locale;
	} else {
		var baseLocale = locale.split('-');
		if (baseLocale.length > 1) {
			if (availableLocales[baseLocale[0] + '-' + baseLocale[1]] != undefined) {
				return baseLocale[0] + '-' + baseLocale[1];
			} else if (availableLocales[baseLocale[0]] != undefined) {
				return availableLocales[baseLocale[0]];
			} else {
				return '';
			}
		} else {
			return '';
		}
	}
}

DynamicFieldController.prototype.createNumberInput = function(/*Element*/ container, /*Boolean*/ multiSegment, /*String*/ multiOption) {
	var controller = this;
	var input = angular.element(document.createElement('input'));
	var size = this.field.getInputSize();
	//sizing for the segment details
	if (multiSegment) {
		size = multiOption ? 5 : 15;
	}
	input.prop('size', size);
	this.configureInputControl(input);
	return input;
}

DynamicFieldController.prototype.createTextInput = function(/*Element*/ container) {
	var controller = this;
	var input = angular.element(document.createElement('input'));
	this.configureInputControl(input);
	return input;
}

DynamicFieldController.prototype.createTextAreaInput = function(/*Element*/ container) {
	var controller = this;
	var input = angular.element(document.createElement('textarea'));
	this.configureInputControl(input);
	return input;
}

DynamicFieldController.prototype.createCheckboxReadonly = function(/*Boolean*/ checked) {
  var img = null;
  if( checked ) {
    img = angular.element( document.createElement( 'img' ) );
    img.attr( {src: '/img/checkbox_checked.gif', class: 'checkImg', alt: 'Checked'});
  }
  return img;
}

DynamicFieldController.prototype.createCheckboxInput = function(/*Element*/ container) {
	var controller = this;
	var input = angular.element(document.createElement('input'));
	input.prop('type', 'checkbox');
	input.prop('value', 'true');
	this.configureInputControl(input);
	return input;
}

DynamicFieldController.prototype.createPicklistInput = function(/*Element*/ container) {
	var controller = this;
	var input = angular.element(document.createElement('select'));
	if (this.field.isMultiPicklist()) {
		input.prop('size', '4');
		input.prop('multiple', true);
		input.addClass('multi');
	} else {
		input.prop('size', 1);
	}
	this.configureInputControl(input);
	var scope = this.scope.$eval(this.picklistMgrExpr);
	scope.picklistManager.register(this, input);
	return input;
}

DynamicFieldController.prototype.configureInputControl = function(input, /*Boolean*/ rangeStart) {
	var controller = this;
	var valueExpr = controller.valueExpr;
	if (this.renderAsRange) {
		if (rangeStart) {
			valueExpr += '.start';
		} else {
			valueExpr += '.end';
		}
	}
	input.prop('id', this.field.name + '_' + this.key);

	controller.scope.$watch(valueExpr, function(newValue, oldValue) {
		controller.setViewValue(input, newValue);
	});
	if (!ModelUtils.isBlank(controller.disabledExpr)) {
		controller.scope.$watch(controller.disabledExpr, function(newValue, oldValue) {
			input.prop('disabled', newValue);
		});
	}
	input.on('change', function(event) {
		var handler = function() {
			controller.setModelValue(controller.getViewValue(input), rangeStart);
			if (controller.field.isRenderedAsSelect()) {
				controller.scope.picklistManager.changeValue(controller);
			}
			if (!ModelUtils.isBlank(controller.changeExpr)) {
				controller.scope.$eval(controller.changeExpr);
			}
		};
		if (controller.scope.$$phase || controller.scope.$root.$$phase) {
			handler();
		} else {
			controller.scope.$apply(handler);
		}
	});
	input.on('focus', function(event) {
		controller.scope.$root.focusedElementId = input.prop('id');
	});
}

DynamicFieldController.prototype.createRichTextInput = function(/*Element*/ container) {
	var controller = this;
	var scope = this.scope;
	// Need to specify the correct parent container for the QuoteLine Editor and the Multi Segment Line Items
	// Container.closest() gets the correct parent container, but could not manipulate the element
	var containerParent = container.is('td') ? container.parent().parent().parent().parent() : container.parent();
	if (this.fieldExpr == 'field') {
		var parentElmScope = container.is('td') ? scope.$parent.$parent.$parent.$parent : scope.$parent;
		var parentLine = (parentElmScope && parentElmScope.line) ? parentElmScope.line : null;
		var parentLineKey = parentLine ? parentLine.key : null;
	}
	container.html(controller.getFormattedValue(false));
	containerParent.css('cursor','default');
	containerParent.on('mouseover', function() {
		containerParent.addClass('inlineEditWriteOn');
	});
	containerParent.on('mouseout', function() {
		containerParent.removeClass('inlineEditWriteOn');
	});
	containerParent.on('dblclick', function() {
		var getter = function() {return controller.getModelValue();}
		var setter = function(value) {controller.setModelValue(value);};
		scope.controller.getRichTextEditor().onEdit(getter, setter, scope.resources.lbl_edit + ' ' + controller.field.label, parentLineKey);
	});
	this.scope.$watch(controller.valueExpr, function(oldValue, newValue) {
		container.html(controller.getFormattedValue(false));
	});
	return null;
}

DynamicFieldController.prototype.createLookup = function(/*Element*/ container) {
	var id = (this.field.name + '_LK' + ModelUtils.generateKey());
	this.referencedObject = this.scope.referencedObjects[this.field.describe.referenceTo];
	var lktp = this.referencedObject.keyPrefix;

	var lkid = angular.element(document.createElement('input'));
	lkid.attr('type', 'hidden');
	lkid.attr('id', id + '_lkid');
	lkid.attr('name', id + '_lkid');
	container.append(lkid);

	var lkold = angular.element(document.createElement('input'));
	lkold.attr('type', 'hidden');
	lkold.attr('id', id + '_lkold');
	lkold.attr('name', id + '_lkold');
	container.append(lkold);

	var mod = angular.element(document.createElement('input'));
	mod.attr('type', 'hidden');
	mod.attr('id', id + '_mod');
	mod.attr('name', id + '_mod');
	container.append(mod);

	var lspf = angular.element(document.createElement('input'));
	lspf.attr('type', 'hidden');
	lspf.attr('id', id + '_lspf');
	lspf.attr('name', id + '_lspf');
	container.append(lspf);

	var spn = angular.element(document.createElement('span'));
	spn.attr('class', 'lookupInput');
	container.append(spn);

	var dplp = '';
	if (this.field.describe.filteredLookupInfo != null) {
		dplp = '[null,' + ((this.filteredLookupRecordIds) ? this.filteredLookupRecordIds.join(',') : '') + ']';
		dplp = encodeURIComponent(encodeURIComponent(dplp));
	}

	var name = angular.element(document.createElement('input'));
	name.attr('type', 'text');
	name.attr('maxlength', '255');
	name.attr('id', id);
	name.attr('name', id);
	name.attr('size', '20');
	spn.append(name);

	var fieldId = (this.field.id == null) ? this.field.name : this.field.id;
	var entityType = (this.field.parentObjectDescribe != null) ? this.field.parentObjectDescribe.keyPrefix : '';
	var a = angular.element(document.createElement('a'));
	var prefix = this.scope.controller.getCommunityPrefix() ? this.scope.controller.getCommunityPrefix() : '';
    a.attr('href', "javascript: openLookup('" + prefix + "/_ui/common/data/LookupPage?lkfm=mainForm&lknm=" + id + "&lktp=" + lktp + "&lkent=" + entityType + "&dplp=" + dplp + "&lkfield=" + fieldId + "',670,'1','&lksrch=' + escapeUTF(getElementByIdCS('" + id + "').value.substring(0, 80)))");
	a.attr('onclick', 'setLastMousePosition(event)');
	spn.append(a);

	a.append( '<i class="sb-icon-search"></i>' );

	var controller = this;
	controller.scope.$watch(controller.valueExpr, function(newValue, oldValue) {
		controller.setViewValue(name, newValue);
	});

	name.on('change', function() {
		if (ModelUtils.isBlank(name.val())) {
			lkid.val(null);
		}
	});

	this.scope.$on('updateLookups', function(event) {
		var oldValue = controller.getModelValue();
		var oldId = (oldValue != null) ? oldValue.Id : null;
		var newValue = controller.getViewValue(name);
		var newId = (newValue != null) ? newValue.Id : null;
		if (oldId !== newId) {
			controller.setModelValue(newValue);
			if (!ModelUtils.isBlank(controller.changeExpr)) {
				controller.scope.$eval(controller.changeExpr);
			}
		}
	});

	return null;
}

DynamicFieldController.prototype.getModelValue = function(/*Boolean*/ rangeStart) {
	var expr = this.valueExpr;
	/* if (this.renderAsRange) {
		if (rangeStart) {
			expr = expr + '.start';
		} else {
			expr = expr + '.end';
		}
	} */
	return this.scope.$eval(expr);
}

DynamicFieldController.prototype.setModelValue = function(/*String*/ value, /*Boolean*/ rangeStart) {
	if (this.field.isRenderedAsDate()) {
		value = ModelUtils.parseDate(value);
		if (value != null) {
			// Convert to UTC to avoid adjustments by toISOString()
			// Initialize with y-m-d first to avoid date mangling when month-date combination is illogical, e.g. 4/31
			var utc = new Date( value.getFullYear(), value.getMonth(), value.getDate() );
			utc.setUTCFullYear(value.getFullYear());
			utc.setUTCDate(value.getDate());
			utc.setUTCMonth(value.getMonth());
			// We need to keep value in the model as ISO-formatted string;
			// Otherwise, Angular will serialize JSON using full ISO format (date + time)
			// which Salesforce will not parse
			value = utc.toISOString().split('T')[0];
		}
	} else if (this.field.isRenderedAsNumber()) {
		if (ModelUtils.isBlank(value)) {
			value = null;
		} else {
			value = value.replace(new RegExp('[^\-0-9' + this.scope.metaDataService.decimalSymbol + ']', 'g'), '');
			value = value.replace(this.scope.metaDataService.decimalSymbol, '.');
			value = new Number(value);
		}
	} else if (this.field.isMultiPicklist() && (value != null)) {
		value = value.join(';');
	}

	var modelValue = value;
	var expr = this.valueExpr;
	if (this.renderAsRange) {
		var range = this.scope.$eval(this.valueExpr);
		if (range == null) {
			this.scope.$eval(this.valueExpr + ' = dfcLocalValue', {dfcLocalValue:range});
		}
		if (rangeStart) {
			expr = expr + '.start';
		} else {
			expr = expr + '.end';
		}
	}

	this.scope.$eval(expr + ' = dfcLocalValue', {dfcLocalValue:modelValue});
}

DynamicFieldController.prototype.setViewValue = function(view, value) {
	if (this.field.isRenderedAsDate()) {
		var format = UserContext && UserContext.dateFormat ? UserContext.dateFormat : 'shortDate';
		view.val(this.filter('date')(value, format));
	} else if (this.field.isRenderedAsNumber()) {
		var scale = this.field.scale;
		if (!ModelUtils.isBlank(this.scaleExpr)) {
			scale = this.scope.$eval(this.scaleExpr);
		}
		if ((scale == null) && (value != null)) {
			var parts = value.toString().split('.');
			if (parts.length > 1) {
				scale = parts[1].length;
			} else {
				scale = 0;
			}
		}
		view.val((value == null) ? '' : this.filter('number')(value, scale));
	} else if (this.field.isRenderedAsCheckbox()) {
		view.prop('checked', value);
	} else if (this.field.isRenderedAsLookup()) {
		view.val((value == null) ? '' : value[this.referencedObject.nameField.name]);
		var idElement = document.getElementById(view.attr('id') + '_lkid');
		idElement.value = (value == null) ? '' : value.Id;
	} else {
		if (this.field.isMultiPicklist()) {
			value = (value != null) ? value.split(';') : value;
		}
		view.val(value);
	}
}

DynamicFieldController.prototype.getViewValue = function(view) {
	if (this.field.isRenderedAsCheckbox()) {
		return view.prop('checked');
	} else if (this.field.isRenderedAsLookup()) {
		var idElement = document.getElementById(view.attr('id') + '_lkid');
		var ref = {Id:idElement.value};
		ref[this.referencedObject.nameField.name] = view.val();
		return ModelUtils.isBlank(idElement.value) ? null : ref;
	}
	var value = view.val();
	if (value == '') {
		return null;
	}
	return value;
}

function PicklistManager(scope) {
	this.controllersByFieldName = {}
	this.selectsByFieldName = {};
	this.scopeId = scope.$id;
}

PicklistManager.prototype.register = function(/*DynamicFieldController*/ controller, /*Element*/ select) {
	this.controllersByFieldName[controller.field.getKey()] = controller;
	this.selectsByFieldName[controller.field.getKey()] = select;
}

PicklistManager.prototype.initOptions = function() {
	angular.forEach(this.controllersByFieldName, function(controller) {
		this.updateOptions(controller, false);
	}, this);
}

PicklistManager.prototype.updateOptions = function(controller, cascade) {
	var field = controller.field;
	var select = this.selectsByFieldName[field.getKey()];
	select.html('');
	if (controller.field.picklistValues && (controller.field.picklistValues.length > 0)) {
		var options = angular.copy(controller.field.picklistValues);
		if (controller.field.isDependent()) {
			var controllingController = this.controllersByFieldName[field.controllingField.getKey()];
			var controllingValue = controllingController.getModelValue();
			options = field.getValidPicklistValues(controllingValue);
		}
		var value = controller.getModelValue();
		if (!field.required && !field.isMultiPicklist()) {
			options.splice(0,0,{value:'',label:''});
		}
		angular.forEach(options, function(option) {
			if (option != null) {
				// For some reason empty picklist seems to return a null option
				var optionEL = angular.element(document.createElement('option'));
				optionEL.val(option.value);
				optionEL.text(option.label);
				select.append(optionEL);
			}
		}, this);
		controller.setViewValue(select, value);
	}

	var viewValue = controller.getViewValue(select);
	if (viewValue != value) {
		controller.setModelValue(viewValue);
		if (cascade) {
			this.changeValue(controller);
		}
	}
}

PicklistManager.prototype.changeValue = function(controller) {
	angular.forEach(controller.field.dependentFields, function(field) {
		var dependentController = this.controllersByFieldName[field.getKey()];
		if (dependentController != null) {
			this.updateOptions(dependentController, true);
		}
	}, this);
}
