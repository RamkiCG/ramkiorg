/* Tablet styles */
@media only screen and (min-device-width : 768px) and (max-device-width : 1024px) {
}


/* Desktop styles */
@media only screen and (min-width : 1024px) {
	.dropRowHover {
		background-color: #CCCCCC;
	}
	
	.dropGroupHover {
		border: 2px solid #999999;
	}

	.dropPageTarget.pageNumbers {
		font-size:1.2em;
		font-weight: bold;
	}

	.dropPageTarget {
		background-color: #CCCCCC;
	}

	.dropPageHover{
		color: green;
		font-size: 1.2em;
		text-decoration: underline;
		font-weight: bold;
	}

	.dropGroupHoverPaginated .groupLinkName {
		color: green;
		text-decoration: underline;
		font-weight: bold;
	}

	.ui-draggable-dragging {
		background-color: #F2F3F3;
		border: 1px solid #e0e3e5;
	}

	.handle .ui-draggable-handle {
		cursor: move;
	}

	.tooltip {
		position: relative;
	}

	.tooltip span{
		display: none;
	}

	.tooltip:hover span{
		display: block;
		position: absolute;
		top: 1.25em;
		left: -15em;
		width: 14em;
		z-index: 100;
		padding: 2px 5px;
		border:1px solid orange;
		background-color: #FEFDB9;
		color:black;
		white-space: normal;
		text-align: left;
	}

	.draggedLine {
		padding:10px;
		color:green;
	}

	.draggedGroup .displayedGroup,
	.draggedGroup {
		padding:10px;
		color:green;
	}

	.unpaginatedHeader {
		display: none;
	}

	.groupFields {
		display:inline-block;
		white-space:nowrap;
	}

	.pageNumbersContainer {
		text-align: center;
	}

	.paginatedFooter .pageNumbers {
		display: inline-block;
		padding: 5px 15px 5px 0;
		font-size: 1.2em;
	}

	.pageSelector {
		width: 20px;
	}

	.displayedPage,
	.dropPageTarget.displayedPage {
		font-size: 1.2em;
		text-decoration: underline;
		font-weight: bold;
	}

	.groupList {
		text-align: center;
		padding: 10px 5px;
	}

	.groupList a {
		text-decoration: none;
	}

	.groupList a:hover {
		text-decoration: none;
	}

	.groupList .groupLinkName {
		white-space: nowrap;
		font-weight: bold;
	}

	.groupList .displayedGroup {
		text-decoration: underline;
		font-weight: bold;
	}
}
