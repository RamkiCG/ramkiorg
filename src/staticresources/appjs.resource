
 var app = angular.module('main', ['ngTable']).
controller('DemoCtrl', function($scope, $filter, ngTableParams) {
    jsonObj = [];
    tempObj = [];
    var tableData = _tableData.codeUnitData;
    $.each(tableData,function(i,item){
        if(item.apexclass == null){
            var unittype = 't';
            tmp = {
                'name': item.apextrigger['Name'],
                'codeCoverage': item.codeCoverage,
                'id' : item.apextrigger['Id'],
                'unittype' : unittype
            };
            tempObj[item.apextrigger['Id']]= item.apextrigger;
            jsonObj.push(tmp);
        }
        else{
            var unittype = 'c';
            tmp = {
                'name': item.apexclass['Name'],
                'codeCoverage': item.codeCoverage,
                'id' : item.apexclass['Id'],
                'unittype' : unittype
            };
            tempObj[item.apexclass['Id']]= item.apexclass;  
            jsonObj.push(tmp);
        }
    });
    var data = jsonObj;
    
    $scope.tableParams = new ngTableParams({
        page: 1,            // show first page
        count: 10,          // count per page
        sorting: {
            name: 'asc'     // initial sorting
        }
    }, {
        total: data.length, // length of data
        getData: function($defer, params) {
            // use build-in angular filter
            var orderedData = params.sorting() ?
                                $filter('orderBy')(data, params.orderBy()) :
                                data;

            $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
        }
    });
    
    $scope.openPage = function (classId,unittype) {
        window.$windowScope = $scope;
        var newTFTUrl = _PageURLs.codeBodyPage;
        newTFTUrl += '?id='+classId+'&type='+unittype;
        initIFrameCB(newTFTUrl ,'Code Details', null , null );
    }
});
var coveredLines = [];
var uncoveredLines = [];
var app = angular.module('codeBodyApp', []).
controller('CodeBody', function($scope) {
    codeBodyObj = [];
    var codeBodyTableData = parent._tableData.codeUnitData;
    $.each(codeBodyTableData,function(i,item){
        if(item.apexclass == null){            
            codeBodyObj[item.apextrigger['Id']]= item;
        }
        else{
            codeBodyObj[item.apexclass['Id']]= item;  
        }
    });
    var unitId = getParameterByName('id');  
    var unitType = getParameterByName('type');
    
    var unitDetails = codeBodyObj[unitId];
    if(unitType == 'c'){
        $scope.unitbody = unitDetails.apexclass['Body'];
    }
    else{
        $scope.unitbody = unitDetails.apextrigger['Body'];
    }
    coveredLines = unitDetails.coveredLines;
    uncoveredLines = unitDetails.unCoveredLines;
});

/* ---------- Load colorbox function ---------- */
    function initIFrameCB(urlP, titleP, widthP, heightP){
    
        if(urlP == null) return null;
        widthParam = widthP == null ? '60%' : widthP;
        heightParam = heightP == null ? '80%' : heightP;
        $.fn.colorbox({
            title:'<h1 style="float:left; font-size:18px;">'+titleP+'</h1>',
            iframe:true,
            href:urlP,
            open:true, 
            width:widthParam, 
            height: heightParam,
            overlayClose:false,
            escKey:false,
            onClosed:null
        });
    }
    
    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }
