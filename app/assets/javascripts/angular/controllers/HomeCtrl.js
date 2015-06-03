DevBox.controller('HomeCtrl',['$scope', '$http', function( $scope, $http ){
  $scope.popular = [];
  $scope.categories = [];
  $scope.tags = [];
  $scope.recent = [];

  $scope.getNumber = function(num) {
          return new Array(num);
    }

  var init = function(){
    $http.get('/api/home').success( function( data ){
      $scope.categories = data.categories;
      $scope.tags = data.tags;
      $scope.popular = data.popular;
      $scope.recent = data.recent;
      console.log($scope.recent);
    } )
  }

  init()
}]);