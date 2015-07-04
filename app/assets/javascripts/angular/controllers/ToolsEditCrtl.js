DevBox.controller( 'ToolsEditCtrl', [ '$scope' , '$resource', '$location', '$http', '$routeParams', '$rootScope',
  function( $scope, $resource, $location, $http, $routeParams, $rootScope ){
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

  Tool = $resource('/api/tools/:id', null, {
    'update': { method:'PUT' }
  });

  ToolEdit = $resource('/api/tools/:id/edit', null, {
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
      $scope.category02Pre = data.categories[1] || null;
      $scope.category03Pre = data.categories[2] || null;
      $scope.categories = data.allCategories;

    })
  }

  $scope.updateTool = function() {
    if ( $scope.category01Pre == false ||$scope.category01Pre == null ){
      Materialize.toast('please add at least one category', 4000)
    } else {
      var tool = {}
    // $http.put
      tool.title = $scope.title;
      tool.description = $scope.description;
      tool.language = $scope.language;
      tool.is_open = $scope.is_open? true : false;
      tool.is_free = $scope.is_free;
      tool.web_url = $scope.web_url;
      tool.repo_url = $scope.repo_url;
      tool.doc_url = $scope.doc_url;
      tool.categories = [$scope.category01Pre, $scope.category02Pre, $scope.category03Pre];
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
