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
      $scope.category02Pre = data.categories[1] || null;
      $scope.category03Pre = data.categories[2] || null;
      $scope.categories = data.allCategories;

      console.log(data.tags);
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
      console.log(tool)
      Tool.update({id: $routeParams.id},tool,function(data){
        console.log(data)
        Materialize.toast('edit successful', 4000)
        $location.url("/tools/" + $routeParams.id)
      });
      //   function(data) {
      //   console.log(data);
      //   $location.url("/tools/" + data.result.id)
      // })
    }
  }

  $scope.newTag = function(chip) {
    // console.log("New Tag Function");
    // console.log("Chip.tag:", chip.tag);
    if ( chip.tag ) {
      return chip;
    }
    return {
      tag: chip
    };
  }

  function querySearch (query) {
    // console.log("query search")
    var results = query ? $scope.tags.filter(createFilterFor(query)) : [];
    // console.log("Results:", results);
    return results;
  }

  function createFilterFor(query) {
    var lowercaseQuery = angular.lowercase(query);
    return function filterFn(tag) {
      // console.log("tag.tag", tag.tag);
      // console.log("lowercaseQuery", lowercaseQuery);
      return (tag.tag.indexOf(lowercaseQuery) === 0);
    };
  }

  init()

}])