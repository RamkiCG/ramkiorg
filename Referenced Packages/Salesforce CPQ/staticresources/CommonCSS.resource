/* Mobile styles */
@media only screen and (min-device-width : 320px) and (max-device-width : 1024px) {
	@-webkit-keyframes loading-rotate {
		0% {-webkit-transform:rotate(0deg);}
		100% {-webkit-transform:rotate(360deg);}
	}
	
	@-moz-keyframes loading-rotate {
		0% {transform:rotate(0deg);}
		100% {transform:rotate(360deg);}
	}
	
	@keyframes loading-rotate {
		0% {transform:rotate(0deg);}
		100% {transform:rotate(360deg);}
	}
	
	* {
		font-family: ProximaNova, Arial, sans-serif;
		color: #3c3d3e;
		-webkit-font-smoothing: antialiased;
	}
	
	*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	
	body {
		padding: 0px;
		margin: 0px;
	}
	
	.pbSubsection header {
		*zoom: 1;
		margin-left: -7px;
		margin-right: -7px;
		margin-bottom: 5px;
		padding: 14px;
		vertical-align: middle;
		border-bottom-width: 1px;
  		border-bottom-style: solid;
  		border-color: #eceef0;
	}
	
	.pbSubsection header h1 {
		margin: 0px;
		font-weight: 300;
		font-size: 14px;
		color: #3c3d3e; 
	}
	
	header.pageHeader {
		margin: 0px;
		background-color: white;
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-color: #cfd4d9;
		padding-top: 3px;
		padding-bottom: 3px; 
		width: 100%;
	}
	
	header.pageHeader h1 {
		display: inline-block; 
		font-weight: 100;
		vertical-align: middle; 
	}
	
	header.pageHeader h1 .title {
		display: block;
		font-size: 12px;
	}
	
	header.pageHeader h1 .subtitle {
		display: block;
		font-size: 14px;
	}
	
	.icon {
  		display: inline-block;
		background-position: 50%;
		background-repeat: no-repeat;
		border-radius: 5px;
		width: 30px;
  		height: 30px;
		background-size: 100%;
		vertical-align: middle;
		margin-left: 14px;
  		margin-right: 14px;
	}
  
	.iconCustom18 {
  		background-color: #4dca76;
  		background-image: url('/img/icon/t4/custom/custom18_60.png');
  	}
	
	input, textarea, keygen, select, button, isindex {
		margin: 0;
		font: -webkit-small-control;
		font-size: 15px;
		font-family: inherit;
		color: initial;
		letter-spacing: normal;
		word-spacing: normal;
		text-transform: none;
		text-indent: 0px;
		text-shadow: none;
		display: inline-block;
		text-align: start;
		box-sizing: border-box;
		color: #3c3d3e;
		padding: 7px 14px;
		line-height: 25px;
		border-radius: 5px;
		border: 1px solid #cfd0d2;
		-webkit-writing-mode: horizontal-tb;
		-moz-appearance: none;
		-webkit-appearance: none;
		-ms-appearance: none;
		
	}
	
	input {
		border: 1px solid #cfd0d2;
		border-radius: 5px;
		background-color: #e8eaeb;
		box-shadow: inset 0 2px 2px rgba(0,0,0,.07);
		-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
	}
	
	label {
		font-size: 13px;
		color: #696e71;
		margin: 0;
		padding-bottom: 8px;
		display: block;
	}
	
	textarea {
		-webkit-rtl-ordering: logical;
		-webkit-user-select: text;
		flex-direction: column;
		cursor: auto;
		white-space: pre-wrap;
		word-wrap: break-word;
		background-color: #e8eaeb;
		box-shadow: inset 0 2px 2px rgba(0,0,0,.07);
	}
	
	input[type="checkbox"], input[type="radio"] {
		padding: 0px;
  		border-style: solid;
  		border-width: 1px; 
  		height: 22px;
  		width: 22px;
  		border-color: #bbc0c4;
  		box-shadow: 0 1px 0 rgba(0, 0, 0, 0.02), inset 0 0 0 2px rgba(255, 255, 255, 0.5);
	}
	
	input[type="checkbox"]:disabled, input[type="radio"]:disabled {
    	opacity: 0.4;
    }
    
	input[type="checkbox"]:focus, input[type="checkbox"]:active, input[type="radio"]:focus, input[type="radio"]:active {
		background: #e8eaeb;
	}
	
	input[type="checkbox"]:checked, input[type="radio"]:checked {
		border-color: #1c78b1;
		background: #2a94d6 !important;
		box-shadow: 0 1px 0 rgba(0, 0, 0, 0.02);
	}

	input[type="checkbox"]:checked::after {
		display: block;
		position: relative;
		content: '';
		left: 3px;
		top: 4px;
		height: 8px;
		width: 14px;
		border-bottom: 4px solid white;
		border-left: 4px solid white;
		-webkit-transform: rotate(-45deg);
	}

	input[type="radio"]:checked::after {
		display: block;
		position: relative;
		content: '';
		left: 5px;
		top: 5px;
		height: 10px;
		width: 10px;
		border-radius: 100%;
		background: white;
	}
	
	select {
		border-color: #bbc0c4;
  		box-shadow: 0 1px 0 rgba(0, 0, 0, 0.02), inset 0 0 0 2px rgba(255, 255, 255, 0.5);
		background-color: #ffffff;
		background-image: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9ImRvd25fMV8iIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB3aWR0aD0iNjRweCIgaGVpZ2h0PSI2NHB4IiB2aWV3Qm94PSIwIDAgNjQgNjQiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDY0IDY0IiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxnIGlkPSJEb3duX3g0MF8yeC5wbmdfMV8iPg0KCTxnIGlkPSJkaXJlY3Rkb3duX2NvcHkiPg0KCQk8Zz4NCgkJCTxwYXRoIGZpbGw9IiM5Njk4OTkiIGQ9Ik01NS4wNjYsMTcuODY2Yy0wLjUzMy0wLjkzNC0xLjQ2Ny0xLjUzMy0yLjUzMy0xLjZDNTIuMzk4LDE2LjE5OSw0Mi4zOTgsMTUuNiwzMiwxNS42DQoJCQkJYy0xMC4zOTksMC0yMC40LDAuNi0yMC41MzMsMC42NjdjLTEuMDY2LDAuMDY2LTIuMDY2LDAuNjY2LTIuNTMzLDEuNmMtMC41MzMsMC45MzQtMC41MzMsMi4wNjYsMCwzDQoJCQkJYzcuOTMzLDE0LjA2NiwyMC40LDI2LjI2NywyMC45MzMsMjYuNzMyYzEuMiwxLjA2NiwzLjA2NiwxLjA2Niw0LjI2NywwYzAuNTMzLTAuNDY3LDEzLTEyLjY2NiwyMC45MzMtMjYuNzMyDQoJCQkJQzU1LjYsMTkuOTMzLDU1LjYsMTguOCw1NS4wNjYsMTcuODY2eiIvPg0KCQk8L2c+DQoJPC9nPg0KPC9nPg0KPC9zdmc+DQo=),linear-gradient(#ffffff,#f1f1f1); 
		background-repeat: no-repeat;
		background-position: 95% 50%;
		background-size: 16px 16px,100% 100%;
	}
	
	select[size="1"] {
		align-items: center;
		white-space: pre;
	}
	
	button.btn {
		background-color: white;
		border-color: #bbc0c4;
		padding-top: 6px;
  		padding-bottom: 7px;
  		padding-left: 6px;
  		padding-right: 7px;
  		margin-bottom: 14px;
  		text-align: center;
  		background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), to(#f1f1f1));
  		background-image: -webkit-linear-gradient(top, #ffffff, #f1f1f1);
  		background-image: -moz-linear-gradient(top, #ffffff, #f1f1f1);
  		background-image: -ms-linear-gradient(top, #ffffff, #f1f1f1);
  		background-image: -o-linear-gradient(top, #ffffff, #f1f1f1);
  	}
  	
  	button.btn span {
  		font-size: 16px;
  		font-weight: 700;
  		color: #44596c;
  	}
  	
  	button.primary {
  		width: 200px;
  	}
  	
  	button.single {
  		max-width: 250px;
  		width: 100%;
  	}
  	
  	button {
  		color: buttontext;
  	}
  	
	button.btn span.icon-utility-down {
  		margin-left: 10px;
  		margin-right: 10px;
  	}
  	
	.pbHeader {
		width: 100%;
		padding-top: 15px;
		text-align: center;
	}
	
	.pbTitle {
		display: none;
	}
	
	.pbButton {
		width: 100%;
	}
	
	.pbSubsection {
		padding: 7px;
		margin: 14px;
		background-color: white;
		border-width: 1px;
  		border-style: solid;
  		border-color: #cfd4d9;
  		border-radius: 5px;
	}
	
	table.list {
		width: 100%;
	}
	
	table.list tr {
	}
	
	table.list td, table.list th {
		padding: 5px 3px;
	}
	
	table.list th {
		color: #696e71;
		font-size: 12px;
	}
	
	table.list td {
		font-size: 14px;
		color: #3c3d3e;
	}
	
	td.dataCell{
		border-top: 1px solid #cfd4d9;
	}
	
	.labelCol {
		text-align: right;
		padding-right: 10px;
	}
	
	.instructionsCol {
		padding-left: 10px;
		padding-top: 5px;
	}
	
	.buttonContainer {
		width: 100%;
		margin-top: 7px;
		margin-bottom: 7px;
		text-align: center;
	}
	
	.recordEditorForm {
		margin-left: 10px;
		margin-right: 10px;
	}
	
	.recordEditorForm td {
		padding-bottom: 3px;
	}
	
	.recordEditorForm select, .recordEditorForm input[type="text"] {
		width: 100%;
	}
	
	.statusContainer {
		position: absolute;
		right: 0;
		left: 0;
		top: 50%;
		z-index: 1001;
		margin-top: -15px;
		height: 50%;
		text-align: center;
		padding: 0px;
	}
	
	.statusIcon {
		width: 30px;
		height: 30px;
		color: #afb5b9;
		-webkit-animation: loading-rotate linear .8s infinite;
		-moz-animation: loading-rotate linear .8s infinite;
		animation: loading-rotate linear .8s infinite;
		-webkit-animation-fill-mode: forwards;
		-moz-animation-fill-mode: forwards;
		animation-fill-mode: forwards;
		background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI2M3B4IiBoZWlnaHQ9IjYzcHgiIHZpZXdCb3g9IjAgMCA2MyA2MyI+PHBhdGggZmlsbD0iI2FmYjViOSIgZD0iTTMxLjUwMSwxNi43ODF2LTQuODg2Yy0xMC43ODksMC0xOS41MzYsOC43NDUtMTkuNTM2LDE5LjUzNWMwLDEwLjc4OSw4Ljc0NywxOS41MzUsMTkuNTM2LDE5LjUzNWMxMC43ODgsMCwxOS41MzQtOC43NDYsMTkuNTM0LTE5LjUzNWMwLTUuMjE0LTIuMDQ5LTkuOTQ4LTUuMzc3LTEzLjQ1Mmw0LjcxOS00LjQ4M2M0LjQ0LDQuNjcxLDcuMTY4LDEwLjk4Myw3LjE2OCwxNy45MzdjMCwxNC4zODUtMTEuNjYyLDI2LjA0My0yNi4wNDIsMjYuMDQzYy0xNC4zODYsMC0yNi4wNDctMTEuNjU4LTI2LjA0Ny0yNi4wNDNjMC0xNC4zODgsMTEuNjYxLTI2LjA0NywyNi4wNDctMjYuMDQ3VjAuNWw5Ljc2Nyw4LjEzOUwzMS41MDEsMTYuNzgxeiIvPjwvc3ZnPg==') no-repeat center center;
		background-size: 100%;
	}
	
	.modalDialogWrapper {
		z-index: 21;
		display: -moz-box;
		display: -ms-flexbox;
		display: flex;
		-webkit-box-orient: horizontal;
		-webkit-box-pack: center;
		-webkit-box-align: center;
		-moz-box-orient: horizontal;
		-moz-box-pack: center;
		-moz-box-align: center;
		position: absolute;
		width: 100%;
		height: 100%;
		top: 0;
		left: 0;
	}
	
	.modalDialogBackground {
		z-index: 21;
		opacity: .8;
		background-color: #354452;
		position: absolute;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		-webkit-transition: opacity 300ms;
	}
	
	.modalDialog {
		z-index: 21;
		position: relative;
		margin: auto;
		height: auto;
		max-height: 70%;
		max-width: 292px;
		border-radius: 5px;
		background-color: #ffffff;
		width: 100%;
		-webkit-transition: -webkit-transform .3s ease-in;
	}
	
	.modalDialog .closeBtn {
		position: absolute;
		right: 4px;
		top: -30px;
		color: #ffffff;
		font-family: Arial;
		font-weight: 600;
		font-size: 25px;
		padding: 12px;
		margin: -12px;
	}
	
	.modalDialog .body {
		overflow: hidden;
		padding: 1px 14px;
		-webkit-flex: 1;
		border-radius: 5px;
	}
	
	.modalDialog .scrollWrapper {
		overflow: hidden;
		position: relative;
		height: 100%;
		-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
		-webkit-user-drag: none;
	}
	
	.modalDialog .scrollContent {
		-webkit-transition: -webkit-transform 0ms cubic-bezier(0.33, 0.66, 0.66, 1);
		transition: -webkit-transform 0ms cubic-bezier(0.33, 0.66, 0.66, 1);
		-webkit-transform-origin: 0px 0px;
	}
	
	.modalDialog button {
		display: block;
		margin-top: 14px;
		width: 100%;
	}
	
	.documentPreviewContainer {
		position: absolute;
		width: 100%;
		top: 135px;
		bottom: 0px;
		overflow: scroll;
		text-align: center;
		-webkit-overflow-scrolling: touch;
	}
	
	iframe.documentPreviewFrame {
		width: 4000px;
		height: 25000px;
		text-align; center;
	}
	
	.mobile {
		display: initial;
	}
	
	.desktop {
		display: none;
	}
}

/* Tablet styles */
@media only screen and (min-device-width : 641px) and (max-device-width : 1024px) {
	.tablet {
		display: initial;
	}
	
	.phone {
		display: none;
	}
}

/* Phone styles */
@media only screen and (min-device-width : 320px) and (max-device-width : 640px) {
	.phone {
		display: initial;
	}
	
	.tablet {
		display: none;
	}
	
	.instructionsCol {
		padding-left: 3px;
		padding-top: 10px;
	}
}



/* Desktop styles */
@media only screen and (min-width : 1025px) {
	.mobile {
		display: none;
	}
	
	.desktop {
		display: initial;
	}
	
	img.checked {
		background-image: url('/img/checkbox_checked.gif');
	}
	
	img.unchecked {
		background-image: url('/img/checkbox_unchecked.gif');
	}

	img.collapsed {
		background-image: url('/img/alohaSkin/setup/setup_minus_lev1.gif');
	}

	img.expanded {
		background-image: url('/img/alohaSkin/setup/setup_plus_lev1.gif');
	}

	img.first {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: 0 1px;
	}

	img.firstOff {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: 0 -10px;
	}

	img.prev {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: -10px 1px;
	}

	img.prevOff {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: -10px -10px;
	}

	img.next {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: -17px 1px;
	}

	img.nextOff {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: -17px -10px;
	}

	img.last {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: -27px 1px;
	}

	img.lastOff {
		background-image: url('/img/paginationArrows.gif');
		background-repeat:no-repeat;
		background-position: -27px -10px;
	}
	
	select.multi {
		min-width: 50px;
	}
	
	.statusContainer {
		width: 100%;
		margin-top: 50px;
		margin-bottom: 50px;
		text-align: center;
	}
	
	.statusPanel td {
		vertical-align: middle;
		padding: 5px;
	}
	
	.pbEmptySubheader {
		margin-top: 10px;
	}
	
	.instructionsCol {
		padding-left: 10px;
		padding-top: 5px;
	}
	
	div.chatterFollow {
		white-space: nowrap;
	}
	
	.chatterFollow a {
		text-decoration: none;
		color: #000000;
		cursor: pointer;
	}
	
	.chatterFollow .followIcon {
		background-image: url(/img/feeds/follow_sprite.png);
		background-repeat: no-repeat;
		background-position: 0 0;
		width: auto;
		height: 15px;
		margin-right: 0.25em;
	}
	
	.chatterFollow .checkIcon {
		background-image: url(/img/feeds/follow_sprite.png);
		background-repeat: no-repeat;
		background-position: 0 -27px;
		width: auto;
		height: 15px;
		margin-right: 0.25em;
	}
	
	.chatterFollow .unfollowIcon {
		background-image: url(/img/feeds/follow_sprite.png);
		background-repeat: no-repeat;
		background-position: 0 -54px;
		width: auto;
		height: 15px;
		margin-right: 0.25em;
	}
	
	.chatterFollow .hion {
		background-position: 0 -75px;
	}
	
	div.duelingListBox select {
		min-width: 200px;
	}
	
	div.duelingListBox option.required {
		font-weight: bold;
		color: red;
	}
	
	div.wizardConfigurator {
		margin-top: 55px;
		width: 100%;
	}
	
	div.wizardConfigurator .featureSteps {
		margin-left: 10px;
	}
	
	div.wizardConfigurator .featureSteps span.title {
		margin-right: 10px;
		font-size: 13px;
		color: #4a4a56;
	}
	
	div.wizardConfigurator .featureSteps span.active {
		font-weight: bold;
	}
	
	div.wizardConfigurator table.featureContentContainer {
		width: 100%;
	}
	
	div.wizardConfigurator td.featureContent {
		padding-left: 10px;
		padding-top: 5px;
	}
	
	div.wizardConfigurator div.prevNextLinks {
		text-align: left;
		margin-top: 10px;
		padding-left: 5px;
		cursor: pointer;
	}
	
	div.wizardConfigurator span.disabled {
		opacity: 0.5;
	}
	
	.rich-tab-disabled{background-repeat:repeat-x;background-position:center top;border-width:1px 1px 0;border-style:solid;cursor:default;}
	.rich-tab-header{padding:2px 10px 2px 10px;text-align:center;}
	.rich-tabhdr-cell-disabled,
	.rich-tabhdr-cell-inactive{padding-top:2px;}
	.rich-tabhdr-side-cell{border-top-width:1px;border-top-style:solid;}
	.rich-tabhdr-side-border{background-repeat:no-repeat;background-position:top;}
	.rich-tabpanel{width:100%; clear: both;}.
	.rich-tabpanel-content-position{height:100%;position:relative;}
	.rich-tbpnl-tb-sel{border-width:1px;border-style:solid;border-bottom:0;background-repeat:repeat-x;background-position:top;cursor:default;}
	.rich-tab-header{color:#000;font-size:11px;font-family:Arial,Verdana,sans-serif;}
	.rich-tab-active{color:#000;border-color:#fff;}
	.rich-tabhdr-side-cell{border-top-color:#C0C0C0;}
	.rich-tab-bottom-line{border-bottom-color:#C0C0C0;border-bottom-style:solid;border-bottom-width:1px;}
	
	.rich-tab-inactive {
	    background-color: #F0F0F0;
	    background-image: linear-gradient(rgba(255, 255, 255, 0.6) 1px, rgba(255, 255, 255, 0) 1px);
		background-image: -webkit-linear-gradient(rgba(255, 255, 255, 0.6) 1px, rgba(255, 255, 255, 0) 1px);
	    border: 1px solid #CACACA;
	    border-top-left-radius: 5px;
	    border-top-right-radius: 5px;
	    color: #555555 !important;
	    cursor: pointer;
	    display: inline-block;
	    font-size: 12px;
	    font-weight: bold;
	    height: 24px;
	    line-height: 26px;
	    margin: 2px 0;
	    padding: 0 0.8em 0 10px;
	    position: relative;
	    top: 2px;
	    vertical-align: top;
	}
	
	.rich-tab-active {
	    -moz-border-bottom-colors: none;
	    -moz-border-left-colors: none;
	    -moz-border-right-colors: none;
	    -moz-border-top-colors: none;
	    background-image: linear-gradient(#FEFEFE 4px, #F3F3F3 18px, #FCFCFC 29px);
		background-image: -webkit-linear-gradient(#FEFEFE 4px, #F0F0F0 18px, #FCFCFC 29px);
		border: 1px solid #CACACA;
		border-bottom-style: none;
	    border-top-left-radius: 7px;
	    border-top-right-radius: 7px;
		box-shadow: -2px -1px 1px rgba(150, 150, 150, 0.1), 2px -1px 1px rgba(150, 150, 150, 0.1);
	    -moz-box-shadow:  -2px -1px 1px rgba(150, 150, 150, 0.1), 2px -1px 1px rgba(150, 150, 150, 0.1);
	    -webkit-box-shadow:  -2px -1px 1px rgba(150, 150, 150, 0.1), 2px -1px 1px rgba(150, 150, 150, 0.1);
	    color: #555555 !important;
	    cursor: pointer;
	    display: inline-block;
	    font-size: 12px;
	    font-weight: bold;
	    height: 28px;
	    line-height: 30px;
	    margin: 0 2px;
	    padding: 0 0.8em 0 10px;
	    position: relative;
	    top: 6px;
	    vertical-align: top;
	    z-index: 100;
	}
	
	.rich-tabpanel-content {
	    background-image: linear-gradient(rgba(245, 245, 245, 0.3), rgba(250, 250, 250, 0.1) 150px);
	    border-color: #747E96 #C0C0C0 #C0C0C0;
	    padding-top: 20px;
	}
	
	.Custom93Tab .rich-tabpanel-content {
		border-top: 3px solid #441e1c;
	}
	
	.Custom18Tab .rich-tabpanel-content {
		border-top: 3px solid #319431;
	}
	
	.rich-tabhdr-side-border {
	    border:none !important;
		display:none;
	}
	
	.rich-tabhdr-side-cell {
	    border:none !important;
	}
	
}



/** Icons **/

@font-face {
	font-family: 'icomoon';
	src: url('fonts/icomoon.eot');
}
@font-face {
	font-family: 'icomoon';
	src: url(data:application/x-font-ttf;charset=utf-8;base64,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) format('truetype'),
		 url(data:application/font-woff;charset=utf-8;base64,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) format('woff');
	font-weight: normal;
	font-style: normal;
}

[class*="icon-utility-"] {
	font-family: 'icomoon';
	speak: none;
	font-style: normal;
	font-weight: normal;
	font-variant: normal;
	text-transform: none;
	line-height: 1;

	/* Better Font Rendering =========== */
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

.icon-utility-success:before {
	content: "\e600";
}
.icon-utility-attach:before {
	content: "\e000";
}
.icon-utility-bookmark:before {
	content: "\e001";
}
.icon-utility-call:before {
	content: "\e002";
}
.icon-utility-chat:before {
	content: "\e003";
}
.icon-utility-checkin:before {
	content: "\e004";
}
.icon-utility-chevronleft:before {
	content: "\e005";
}
.icon-utility-chevronright:before {
	content: "\e006";
}
.icon-utility-close:before {
	content: "\e007";
}
.icon-utility-down:before {
	content: "\e008";
}
.icon-utility-download:before {
	content: "\e009";
}
.icon-utility-email:before {
	content: "\e00b";
}
.icon-utility-groups:before {
	content: "\e00e";
}
.icon-utility-image:before {
	content: "\e00f";
}
.icon-utility-left:before {
	content: "\e010";
}
.icon-utility-like:before {
	content: "\e011";
}
.icon-utility-link:before {
	content: "\e012";
}
.icon-utility-list:before {
	content: "\e013";
}
.icon-utility-location:before {
	content: "\e014";
}
.icon-utility-logout:before {
	content: "\e015";
}
.icon-utility-people:before {
	content: "\e016";
}
.icon-utility-photo:before {
	content: "\e017";
}
.icon-utility-reply:before {
	content: "\e018";
}
.icon-utility-right:before {
	content: "\e019";
}
.icon-utility-up:before {
	content: "\e01e";
}
.icon-utility-upload:before {
	content: "\e01f";
}
.icon-utility-user:before {
	content: "\e020";
}
.icon-utility-filter:before {
	content: "\e022";
}
.icon-utility-help:before {
	content: "\e023";
}
.icon-utility-error:before {
	content: "\e024";
}
.icon-utility-warning:before {
	content: "\e025";
}
.icon-utility-adduser:before {
	content: "\e026";
}
.icon-utility-add:before {
	content: "\e027";
}
.icon-utility-edit:before {
	content: "\e00a";
}
.icon-utility-back:before {
	content: "\e028";
}
.icon-utility-lock:before {
	content: "\e029";
}
.icon-utility-info:before {
	content: "\e02d";
}
.icon-utility-frozen:before {
	content: "\e02e";
}
.icon-utility-spinner:before {
	content: "\e02b";
}
.icon-utility-news:before {
	content: "\e02f";
}
.icon-utility-dash:before {
	content: "\e030";
}
.icon-utility-question:before {
	content: "\e031";
}
.icon-utility-3dots:before {
	content: "\e032";
}
.icon-utility-refresh:before {
	content: "\e033";
}
.icon-utility-socialshare:before {
	content: "\e034";
}
.icon-utility-priority:before {
	content: "\e021";
}
.icon-utility-search:before {
	content: "\e01b";
}
.icon-utility-rows:before {
	content: "\e01a";
}
.icon-utility-event:before {
	content: "\e00c";
}
.icon-utility-settings:before {
	content: "\e01c";
}
.icon-utility-check:before {
	content: "\e02a";
}
.icon-utility-notification:before {
	content: "\e02c";
}
.icon-utility-share:before {
	content: "\e01d";
}
.icon-utility-favorite:before {
	content: "\e00d";
}
.icon-utility-sms:before {
	content: "\e601";
}
.icon-utility-push:before {
	content: "\e602";
}