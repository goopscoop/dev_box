DevBox.controller( 'ToolsCtrl' , [ '$scope' , '$http', '$resource' , '$location', '$rootScope',
  function( $scope , $http , $resource , $location , $rootScope ){

    $scope.categories = [];
    // String the search bar is binding to.
    $scope.toolSearchText;
    // Object returned after search is completed
    $scope.selectedTool = {};
    $scope.searchTools = [];
    $scope.activeCategory;
    $scope.activeTag;
    $scope.getNumber = function(num) {
          return new Array(num);
    }

    function isEmpty(ob){
       for(var i in ob){ return true;}
      return false;
    }

    $http.get( '/api/tools' ).success( function( data ){
      // returns an array of objects with Tools and associated categories and tags
      $scope.categories = data.categories;
      $scope.tags = data.tags;
      // console.log( $scope.tools )
    })

    var init = function(){
      if( isEmpty( $location.search() ) ){
        $scope.activeCategory = $location.search().c || null;
        $scope.activeTag = $location.search().t || null;
        console.log($scope.activeCategory)
        get = buildUrl( true, $location.search().q, $location.search().c, $location.search().t )
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

    $scope.clearSearch = function(){
      $location.search("")
    }

    $scope.getMatches = function( toolSearchText ){
      $http.get( '/api/tools?q=' + toolSearchText ).success( function( data ){
        // returns an array of objects with Tools and associated categories and tags
         $scope.searchTools = data
      })
        console.log("get matches function",$scope.searchTools)
        return $scope.searchTools
    }

    $scope.addCat = function( catName ){
      localUrl = buildUrl( false, $location.search().q, catName, $location.search().t);
      $location.search(localUrl);
    }

    $scope.addTag = function( tagName ){
      localUrl = buildUrl( false, $location.search().q, $location.search().c, tagName );
      $location.search(localUrl);
    }

    $scope.upVote = function( toolId ){
      if ( $rootScope.isAuthenticated ){
        $http.post( '/api/tools/' + toolId + '/tvotes' ).success( function( data ){
          // returns an array of objects with Tools and associated categories and tags
           for ( var i = 0; i < $scope.searchTools.length; i++ ) {
              if( $scope.searchTools[i].id === toolId ) {
                $scope.searchTools[i].votes = data.votes;
                $scope.searchTools[i].voteId = data.voteId;
                $scope.searchTools[i].hasVoted = true;
                return
              }
           }
           Materialize.toast( 'voted', 4000)
        })
      }
    }

    $scope.removeVote = function( toolId, tvoteId ){
      if ( $rootScope.isAuthenticated ){
        $http.delete( '/api/tools/' + toolId + '/tvotes/' + tvoteId ).success( function( data ){
           for ( var i = 0; i < $scope.searchTools.length; i++ ) {
              if( $scope.searchTools[i].id === toolId ) {
                $scope.searchTools[i].votes = data.votes
                $scope.searchTools[i].voteId = null;
                $scope.searchTools[i].hasVoted = false;
                return
              }
           }
           Materialize.toast( 'removed vote', 4000)
        })
      }
    }

    init();
}]);
