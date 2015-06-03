DevBox.controller( 'ToolsShowCtrl', [ '$scope' , '$resource', '$http', '$location', '$routeParams', function( $scope, $resource, $http, $location, $routeParams ){

  console.log('New Tools Ctrl Loaded');

  $scope.number = 5;
  $scope.getNumber = function(num) {
      return new Array(num);
  }

  $scope.addTool = function( toolId ){
    $http.post('/api/users/' + toolId + '/tool').success( function( data ){
      console.log(data)
    } )
  }

  Tool = $resource('/api/tools/:id', null, {
    'update': { method:'PUT' }
  });

  console.log("RouteParams:", $routeParams.id);
  Tool.get({id:$routeParams.id},function(data) {
    // $rootScope.loading = false;
    console.log("Tool.get call running");
    console.log(data);
    $scope.tool = data.result;
  },function(err){
    console.log(err);
  });

}])
