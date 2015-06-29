DevBox.controller( 'ToolsCtrl', [ '$scope', '$http', '$resource', '$location', '$rootScope', 'buildUrl',
  function( $scope, $http, $resource, $location, $rootScope, buildUrl ){

    $scope.categories = [];
    // String the search bar is binding to.
    $scope.toolSearchText;
    // Object returned after search is completed
    $scope.selectedTool = {};
    $scope.searchTools = [];
    $scope.activeCategory;
    $scope.activeTag;

    var init = function(){
      loadCatsAndTags()
      queryDatabase()
    }

    $scope.getNumber = function(num) {
          return new Array(num);
    }

    var isEmpty = function(ob){
       for(var i in ob){ return true;}
      return false;
    }



    $scope.clearSearch = function(){
      $location.search("")
    }

    $scope.getMatches = function( toolSearchText ){
      $http.get( '/api/tools?q=' + toolSearchText ).success( function( data ){
        // returns an array of objects with Tools and associated categories and tags
         $scope.searchTools = data;
      })
        return $scope.searchTools;
        // console.log("get matches function",$scope.searchTools)
    }

     $scope.focusOnSelectedTool = function( ){
      if ($scope.selectedTool) {
        $scope.searchTools = [];
        $scope.searchTools.unshift($scope.selectedTool);
        return $scope.searchTools;
        // console.log("get matches function",$scope.searchTools)
      }
      return $scope.searchTools;
      // $scope.searchTools = $scope.selectedTool
    }

    $scope.addCat = function( catName ){
      localUrl = buildUrl.build( false, $location.search().q, catName, $location.search().t);
      $location.search(localUrl);
    }

    $scope.addTag = function( tagName ){
      localUrl = buildUrl.build( false, $location.search().q, $location.search().c, tagName );
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

    var loadCatsAndTags = function(){
      if( !$scope.categories || !$scope.tags ){
        $http.get( '/api/tools' ).success( function( data ){
          // returns an array of objects with Tools and associated categories and tags
          $scope.categories = data.categories;
          $scope.tags = data.tags;
          // console.log( $scope.tools )
        })
      }
    }

    var queryDatabase = function(){
      if( isEmpty( $location.search() ) ){
        $scope.activeCategory = $location.search().c || null;
        $scope.activeTag = $location.search().t || null;
        // console.log($scope.activeCategory)
        get = buildUrl.build( true, $location.search().q, $location.search().c, $location.search().t )
        $http.get( get ).success( function( data ){
          // returns an array of objects with Tools and associated categories and tags
          $scope.searchTools = data
        })
      }
    }

    init();
}]);
