DevBox.controller('CollectionsNewCtrl', ['$scope', '$http', 'devValidate', 'devSearchFn',
  '$location', 'devAlert', 'devInit',
  function( $scope, $http, devValidate, devSearchFn, $location, devAlert, devInit ){

  $scope.searchTools = []
  $scope.toolsInCollection = []
  $scope.showToolsToAdd = false;

  var init = function(){
    loadCatsAndTags();
  }

  $scope.saveCollection = function(){
    if( isCollectionValidated() ){
      $http.post( '/api/collections', {
        name: $scope.name,
        description: $scope.description,
        is_public: true,
        tools: $scope.toolsInCollection
      } )
      .success( function( data ){
        devAlert.alert('collection creation successful');
        $location.url('/collections/' + data.id);

      } )
      .error( function( data ){
        devAlert.alert('Oops. Something happened.');
        console.error( 'Error:', data.message )
      } )
    }
  }

  var loadCatsAndTags = function(){
    if( devInit.notLoaded( $scope.categories, $scope.tags ) ){
      devInit.loadCatsAndTags()
      .then(function(data){
        $scope.categories = data.categories;
        $scope.tags = data.tags;
      })
    }
  }

  var isCollectionValidated = function(){
    if( devValidate.custom( $scope.name, 'a name is required' )
        && devValidate.description( $scope.description )
        && devValidate.custom( ($scope.description.length < 201), 'limit description to 200 chars.' ) ) {
      return true;
    }
  }

  $scope.removeFromCollection = function( toolId ){
    for( var i = 0; i <= $scope.toolsInCollection.length - 1; i++ ){
      if( $scope.toolsInCollection[i].id === toolId ){
        $scope.toolsInCollection.splice(i, 1)
        return
      }
    }
  }

  $scope.addToolToCollection = function(){
    if( $scope.selectedTool ){
      var isUnique = true;
      for( var i = 0; i <= $scope.toolsInCollection.length - 1; i++ ){
        if( $scope.toolsInCollection[i].id === $scope.selectedTool.id ){
          isUnique = false;
          return;
        }
      }
      if( isUnique ){
        $scope.showToolsToAdd = true;
        $scope.toolsInCollection.push( $scope.selectedTool )
        console.log($scope.toolsInCollection)
        return true;
      }
    }
  }

  $scope.getMatches = function( toolSearchText ){
    $http.get( '/api/tools?q=' + toolSearchText ).success( function( data ){
      $scope.searchTools = data;
    }).error(function( err ){
      console.log( err )
    })
    return $scope.searchTools;
  }

  $scope.searchTextChanged = function( toolSearchText ){
    if ( devSearchFn.check( toolSearchText ) ) $scope.getMatches( toolSearchText );
    return $scope.searchTools
  }



  init();

}])