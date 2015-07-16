DevBox.controller( 'ToolsCtrl', [ '$scope', '$http', '$location', '$rootScope', 'buildUrl', 'devAlert',
  function( $scope, $http, $location, $rootScope, buildUrl, devAlert ){

    $scope.toolSearchText; // String the search bar is binding to.
    $scope.selectedTool = {}; // Object returned after search is completed
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

    $scope.searchTextChanged = function( toolSearchText ){
      if(toolSearchText){
        $scope.getMatches( toolSearchText )
      }
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
           devAlert.alert('voted');
           for ( var i = 0; i < $scope.searchTools.length; i++ ) {
              if( $scope.searchTools[i].id === toolId ) {
                $scope.searchTools[i].votes = data.votes;
                $scope.searchTools[i].voteId = data.voteId;
                $scope.searchTools[i].hasVoted = true;
                return
              }
           }
           // Materialize.toast( 'voted', 4000)
        })
      }
    }

    $scope.removeVote = function( toolId, tvoteId ){
      if ( $rootScope.isAuthenticated ){
        $http.delete( '/api/tools/' + toolId + '/tvotes/' + tvoteId ).success( function( data ){
           devAlert.alter( 'removed vote')
           for ( var i = 0; i < $scope.searchTools.length; i++ ) {
              if( $scope.searchTools[i].id === toolId ) {
                $scope.searchTools[i].votes = data.votes
                $scope.searchTools[i].voteId = null;
                $scope.searchTools[i].hasVoted = false;
                return
              }
           }
        })
      }
    }

    var loadCatsAndTags = function(){
      if( !$scope.categories || !$scope.tags ){
        $http.get( '/api/tools' ).success( function( data ){
          $scope.categories = data.categories;
          $scope.tags = data.tags;
        })
      }
    }

    var isNotEmpty = function(ob){
       for(var i in ob){ return true;}
      return false;
    }

    var queryDatabase = function(){
      if( isNotEmpty( $location.search() ) ){
        $scope.activeCategory = $location.search().c || null;
        $scope.activeTag = $location.search().t || null;
        $http.get( buildUrl.build( true, $location.search().q, $location.search().c, $location.search().t ) ).success( function( data ){
          // returns an array of objects with Tools and associated categories and tags
          $scope.searchTools = data
        })
      }

    }

    init();
}]);
