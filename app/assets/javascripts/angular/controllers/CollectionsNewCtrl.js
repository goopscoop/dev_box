DevBox.controller('CollectionsNewCtrl', ['$scope', '$http', 'devValidate',
 function( $scope, $http, devValidate ){




  $scope.saveCollection = function(){
    if( isCollectionValidated() ){
    console.log('saved!')
      $http.post( '/api/collections', {
        name: $scope.name,
        description: $scope.description,
        is_public: true} )
      .success( function( data ){
        console.log(data.result);
      } )
      .error( function( data ){
        console.error( 'Error:', data )
      } )
    }
  }

  var init = function(){
    loadCatsAndTags();
  }

  var loadCatsAndTags = function(){
    $http.get('/api/tags-and-cats/').success( function( data ){
      $scope.categories = data.categories;
      $scope.tags = data.tags;
    }).error(function( data ){
      console.error( 'Error:', data );
    });
  }

  var isCollectionValidated = function(){
    if( devValidate.custom( $scope.name, 'a name is required' )
        && devValidate.description( $scope.description )
        && devValidate.custom( ($scope.description.length < 201), 'limit description to 200 chars.' ) ) {
      return true;
    }
  }

  init();

}])