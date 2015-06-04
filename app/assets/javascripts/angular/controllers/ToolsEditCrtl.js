DevBox.controller( 'ToolsEditCtrl', [ '$scope' , '$resource', '$location', '$http', '$routeParams',
  function( $scope, $resource, $location, $http, $routeParams ){

  $scope.tool = {};


  Tool = $resource('/api/tools/:id/edit', null, {
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
      $scope.category01 = data.categories[0] || null;
      $scope.category02 = data.categories[1] || null;
      $scope.category03 = data.categories[2] || null;

      console.log(data.tags);
    })
  }

  init()

}])