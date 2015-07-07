DevBox.controller( 'ToolsNewCtrl', [ '$scope' , '$resource', '$location', '$http',
  function( $scope, $resource, $location, $http ){

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
    $http.get( '/api/validate?title=' + $scope.title ).success( function( data ){
      if (data.uniqueness === false ){
        $scope.isUniqueMessage = data.message;
        $scope.conflictingTools = data.tools;
        console.log('if', data)
      } else {
        $scope.isUniqueMessage = '';
        console.log('else', data)
      }
    })
  }

  $scope.hidePrinciples = function(boolean){
    $scope.showPrinciples = boolean;
  }

  $scope.hideUniqueMessage = function(boolean){
    $scope.isUniqueMessage = '';
  }

  $scope.saveTool = function() {
    if( !$scope.title ) {
      Materialize.toast( 'a title is required', 4000)
    } else if( !$scope.category01 ){
      Materialize.toast( 'a category is required', 4000)
    } else if( !$scope.description ) {
      Materialize.toast( 'a description is required', 4000)
    } else if( !$scope.web_url && !$scope.repo_url && !$scope.doc_url ) {
      Materialize.toast( 'at least one link is required', 4000)
    } else if( !$scope.tags ) {
      Materialize.toast( 'at least one tag is required', 4000)
    } else {
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
      tool.categories = [$scope.category01, $scope.category02, $scope.category03];
      tool.tags = $scope.selectedTags;
      tool.$save(function(data) {
        console.log("server returns before",data);
        if(data.result.id === null){
                 // ... error_message comes from the server
            Materialize.toast( 'Oops. Something happened', 4000)
            Materialize.toast( 'Please make sure this tool is a unique entry', 4000)
             console.log("server returns if",data);

          } else {

               console.log("server returns else",data);
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
    var results = query ? $scope.tags.filter(createFilterFor(query)) : [];
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

}])

