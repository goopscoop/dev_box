DevBox.controller('UsersShowCtrl',['$scope', '$http', function( $scope, $http ){
  $scope.tools = []

  var init = function(){
    $http.get('/api/users/profile').success( function( data ){
      $scope.tools = data.tools
      console.log($scope.tools)
    } )
  }


  $scope.removeTool = function( toolId ){
    $http.delete( '/api/users/delete/tool/' + toolId ).success( function( data ){
        for (var i = 0; i < $scope.tools.length; i++){
          if ($scope.tools[i].id === toolId ) {
            $scope.tools.splice(i,1);
          }
        }
      } )
  }


  init()
}]);