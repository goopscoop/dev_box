DevBox.controller('CollectionsShowCtrl', [ '$scope', '$http', '$routeParams', 'devInit',
  function( $scope, $http, $routeParams, devInit ){

  $scope.collection;
  $scope.collectionTools;

  var init = function(){
    loadCollection();
    loadCatsAndTags();
  }

  var loadCatsAndTags = function(){
    devInit.loadCatsAndTags()
    .then(function(data){
      console.log('controller side data',data)
      $scope.categories = data.categories;
      $scope.tags = data.tags;
    })
  }

  var loadCollection = function(){
    $http.get( '/api/collections/' + $routeParams.id ).success(function( data ){
      $scope.collection = data.collection;
      $scope.collectionTools = data.tools;
    }).error(function( err ){
      console.error( err.message )
    })
  }


  // var loadCatsAndTags = function(){
  //   $http.get('/api/tags-and-cats/').success( function( data ){
  //     $scope.categories = data.categories;
  //     $scope.tags = data.tags;
  //   }).error(function( data ){
  //     console.error( 'Error:', data );
  //   });
  // }

  init()

}])