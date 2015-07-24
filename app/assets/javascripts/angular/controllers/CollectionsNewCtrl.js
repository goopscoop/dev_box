DevBox.controller('CollectionsNewCtrl', ['$scope', '$http', function( $scope, $http ){
  console.log('controller loaded')

  $http.get('/api/tags-and-cats/').success( function( data ){
      console.log( data );
      $scope.categories = data.categories;
      $scope.tags = data.tags;
    }).error(function( data ){
      console.log( data );
    });


}])