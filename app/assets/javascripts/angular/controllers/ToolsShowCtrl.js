DevBox.controller( 'ToolsShowCtrl', [ '$scope' , '$resource', '$http', '$location', '$routeParams', function( $scope, $resource, $http, $location, $routeParams ){

  console.log('New Tools Ctrl Loaded');

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

  // $http.get( '/api/tool/' + $routeParams.id ).success( function( data ){
  //   // returns an array of objects with Tools and associated categories and tags
  //    console.log(data);
  // })

}])
