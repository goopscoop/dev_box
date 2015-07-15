DevBox.controller( 'ToolsEditCtrl', [ '$scope' , '$resource', '$location', '$http', '$routeParams', '$rootScope', 'devValidate',
  function( $scope, $resource, $location, $http, $routeParams, $rootScope, devValidate ){
  $rootScope.isAuthenticated;
    // Vars needed for tags
  $scope.readonly = false;
  $scope.selectedTag = null;
  $scope.searchText = null;
  $scope.querySearch = querySearch;
  $scope.selectedTags = [];
  $scope.numberChips = [];
  $scope.numberChips2 = [];
  $scope.numberBuffer = '';
  $scope.tool = {};
  $scope.$watch.isFormattingHelpOpen = false;

  $scope.formattingHelp = function(action){
    console.log('boop')
    $scope.isFormattingHelpOpen = action;
  }

  var Tool = $resource('/api/tools/:id', null, {
    'update': { method:'PUT' }
  });

  var ToolEdit = $resource('/api/tools/:id/edit', null, {
    'update': { method:'PUT' }
  });

  var init = function(){
    $http.get('/api/tools/' + $routeParams.id + '/edit').success( function( data ){
      $scope.title = data.tool.title;
      $scope.description = data.tool.description;
      $scope.language = data.tool.language;
      $scope.is_open = data.tool.is_open;
      $scope.is_free = data.tool.is_free;
      $scope.web_url = data.tool.web_url;
      $scope.repo_url = data.tool.repo_url;
      $scope.doc_url = data.tool.doc_url;
      $scope.selectedTags = data.tags;
      $scope.tags = data.allTags;
      $scope.category01Pre = data.categories[0] || null;
      $scope.categories = data.allCategories;
    })
  }

  $scope.updateTool = function() {
    if ( devValidate.description($scope.description) &&
        devValidate.category($scope.category01Pre) &&
        devValidate.tags( $scope.selectedTags[0] ) &&
        devValidate.urls( $scope.web_url, $scope.repo_url, $scope.doc_url ) ){

        var tool = {}
        // tool.title = $scope.title;
        tool.description = $scope.description;
        tool.language = $scope.language;
        tool.is_open = $scope.is_open? true : false;
        tool.is_free = $scope.is_free;
        tool.web_url = $scope.web_url;
        tool.repo_url = $scope.repo_url;
        tool.doc_url = $scope.doc_url;
        tool.categories = [$scope.category01Pre];
        tool.tags = $scope.selectedTags;
        Tool.update({id: $routeParams.id},tool,
          function(data){
            Materialize.toast('edit successful', 4000)
            $location.url("/tools/" + $routeParams.id)
          },
          function(err) {
            Materialize.toast('Uh-oh :/ Try refreshing', 4000)
          });

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

  function querySearch (query) {
    var results = query ? $scope.tags.filter(createFilterFor(query)) : [];
    return results;
  }

  function createFilterFor(query) {
    var lowercaseQuery = angular.lowercase(query);
    return function filterFn(tag) {
      return (tag.tag.indexOf(lowercaseQuery) === 0);
    };
  }

  init()

}])
