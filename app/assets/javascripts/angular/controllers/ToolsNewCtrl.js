DevBox.controller( 'ToolsNewCtrl', [ '$scope' , '$resource', '$location', '$http', 'devValidate', 'devAlert',
  function( $scope, $resource, $location, $http, devValidate, devAlert ){

  $scope.showPrinciples = true;
  $scope.readonly = false;
  $scope.selectedTag = null;
  $scope.searchText = null;
  $scope.isUniqueTooltipVisible = false;
  $scope.querySearch = querySearch;
  $scope.selectedTags = [];
  $scope.numberChips = [];
  $scope.numberChips2 = [];
  $scope.numberBuffer = '';
  $scope.$watch.isFormattingHelpOpen = false;

  $scope.formattingHelp = function(action){
    $scope.isFormattingHelpOpen = action;
  }

  var Tool = $resource('/api/tools/', null, {
    'update': { method:'PUT' }
  });

  var NewTool = $resource('/api/tools/new', null, {
    'update': { method: 'PUT' }
  })

  NewTool.get(function(data) {
    $scope.categories = data.result.categories;
    $scope.tags = data.result.tags
  },function(err){
    console.log(err);
  });

  $scope.checkForExisitingTool = function(){
    if ( $scope.title ){
        $http.get( '/api/validate?title=' + $scope.title ).success( function( data ){
          if (data.uniqueness === false ){
            $scope.isUniqueMessage = data.message;
            $scope.conflictingTools = data.tools;
          } else {
            $scope.isUniqueMessage = '';
          }
        })
    } else {
      devAlert.alert("a title is required")
    }
  }

  $scope.hidePrinciples = function(boolean){
    $scope.showPrinciples = boolean;
  }

  $scope.hideUniqueMessage = function(boolean){
    $scope.isUniqueMessage = '';
  }

  $scope.saveTool = function() {
    if ( toolIsValidated() ) {
      var tool = new Tool();
      tool.title = $scope.title;
      tool.description = $scope.description;
      tool.language = $scope.language;
      tool.is_open = $scope.is_open? true : false;
      tool.is_free = $scope.is_free;
      tool.web_url = $scope.web_url;
      tool.repo_url = $scope.repo_url;
      tool.doc_url = $scope.doc_url;
      tool.avg_rating = null;
      tool.categories = [$scope.category01];
      tool.tags = $scope.selectedTags;
      tool.$save(function(data) {
        if(data.result.id === null){
                 // ... error_message comes from the server
                 // NOT WORKING YET!!! but validations make chances of error unlikely
            devAlert.alert( 'oops. something happened');
            devAlert.alert( 'please make sure this tool is a unique entry');
          } else {
            $location.url("/tools/" + data.result.id)
          }
      })
    }
  }

  $scope.newTag = function(chip) {
    if ( chip.tag ) {
      return chip;
    }
    return {
      tag: chip
    };
  }
  /**
   * Search for Tags.
   */
  function querySearch (query) {
    var results = query ? $scope.tags.filter( createFilterFor( query ) ) : [];
    return results;
  }
  /**
   * Create filter function for a query string
   */
  function createFilterFor(query) {
    var lowercaseQuery = angular.lowercase(query);
    return function filterFn(tag) {
      return (tag.tag.indexOf(lowercaseQuery) === 0);
    };
  }

  var toolIsValidated = function(){
    if( devValidate.title($scope.title) &&
        devValidate.description($scope.description) &&
        devValidate.category($scope.category01) &&
        devValidate.tags( $scope.selectedTags[0] ) &&
        devValidate.urls( $scope.web_url, $scope.repo_url, $scope.doc_url ) ) return true;
  }

}])
