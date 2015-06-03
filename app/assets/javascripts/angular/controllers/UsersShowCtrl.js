DevBox.controller('UsersShowCtrl',['$scope', '$http', function( $scope, $http ){
  $scope.tools = []

  var init = function(){
    $http.get('/api/users/profile').success( function( data ){
      $scope.tools = data.tools
      console.log($scope.tools)
    } )
  }


  init()
}]);