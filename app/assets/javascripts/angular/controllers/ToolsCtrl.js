DevBox.controller( 'ToolsCtrl' , [ '$scope' , '$http', '$resource' ,
  function( $scope , $http , $resource ){

    // var filterArr = function(array, searchText ){
    //   return array.filter( function( tool ){
    //     if ( tool.title.toLowerCase().indexOf(searchText.toLowerCase()) != -1 ) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //   })
    // }

    $scope.tools = [];

    // String the search bar is binding to.
    $scope.toolSearchText;

    // Object returned after search is completed
    $scope.selectedTool = {};
    $scope.searchTools = [];

    $scope.getMatches = function( toolSearchText ){

      $http.get( '/api/tools?q=' + toolSearchText ).success( function( data ){
        // returns an array of objects with Tools and associated categories and tags
         $scope.searchTools = data
      })
        console.log($scope.searchTools)
        return $scope.searchTools

    }

    $http.get( '/api/tools' ).success( function( data ){
      // returns an array of objects with Tools and associated categories and tags
      for( tool in data ){
        $scope.tools.push(data[tool]);
      }
      // console.log( $scope.tools )
    })



}]);