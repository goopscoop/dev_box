DevBox.controller('CollectionsCtrl', ['$scope', 'devInit',
  function( $scope, devInit ){

  var init = function(){
    loadCatsAndTags();
    loadCollections();
  }

  var loadCollections = function(){
    devInit.apiGet('/api/collections/')
    .then( function( data ){
      $scope.collections = data.result.collections;
      console.log($scope.collections)
    })
  }

  var loadCatsAndTags = function(){
    if( devInit.notLoaded( $scope.categories, $scope.tags ) ){
      devInit.loadCatsAndTags()
      .then( function( data ){
        $scope.categories = data.categories;
        $scope.tags = data.tags;
      })
    }
  }

  init();

}]);