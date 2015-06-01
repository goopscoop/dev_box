DevBox.controller( 'ToolsCtrl' , [ '$scope' , '$http', '$resource' , '$location',
  function( $scope , $http , $resource , $location ){

    var init = function(){
      if($location.search()) {
        get = buildUrl(true, $location.search().q, $location.search().c, $location.search().t)
          $http.get( get ).success( function( data ){
          // returns an array of objects with Tools and associated categories and tags
          $scope.searchTools = data
        })
      }
    }

    // builds url. API is required (true if api call, false if local url)
    // all other paramaters are optional.
    var buildUrl = function( api, query, cats, tags ){
      if ( api ) {
        var url =  '/api/tools?'
      } else {
        url = ''
      }
      if ( query ) url += 'q=' + query;
      if ( (query && cats) || (query && tags) ) url += '&';
      if ( cats ) url += 'c=' + cats;
      if ( cats && tags ) url += '&';
      if ( tags ) url += 't=' + tags;
      return url
    }

    $scope.categories = [];

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
      $scope.categories = data.categories;
      $scope.tags = data.tags;
      // console.log( $scope.tools )
    })

    $scope.addCat = function(catName){

      get = buildUrl( true, $location.search().q , catName )
      localUrl = buildUrl( false, $location.search.q, catName)
      // $http.get( get ).success( function( data ){
      //   console.log(localUrl)
      //   // returns an array of objects with Tools and associated categories and tags
      //   $scope.searchTools = data
      // })
        $location.search(localUrl)
    }


    init();
}]);