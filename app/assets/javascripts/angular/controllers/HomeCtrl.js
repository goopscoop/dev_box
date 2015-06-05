DevBox.controller('HomeCtrl',['$scope', '$http', '$rootScope', function( $scope, $http, $rootScope ){
  $scope.popular = [];
  $scope.categories = [];
  $scope.tags = [];
  $scope.recent = [];
  $rootScope.isAuthenticated;

  $scope.getNumber = function(num) {
          return new Array(num);
    }

  var init = function(){
    $http.get('/api/home').success( function( data ){
      $scope.categories = data.categories;
      $scope.tags = data.tags;
      $scope.popular = data.popular;
      $scope.recent = data.recent;
      console.log($scope.recent);
    } )
  }

  $scope.upVotePopular = function( toolId ){
      if ( $rootScope.isAuthenticated ){
        $http.post( '/api/tools/' + toolId + '/tvotes' ).success( function( data ){
          // returns an array of objects with Tools and associated categories and tags
          console.log(data)
           for ( var i = 0; i < $scope.popular.length; i++ ) {
              if( $scope.popular[i].id === toolId ) {
                $scope.popular[i].votes = data.votes;
                $scope.popular[i].voteId = data.voteId;
                $scope.popular[i].hasVoted = true;
                return
              }
           }
           Materialize.toast( 'voted', 4000)
        })
      }
    }

    $scope.removeVotePopular = function( toolId, tvoteId ){
      if ( $rootScope.isAuthenticated ){
        $http.delete( '/api/tools/' + toolId + '/tvotes/' + tvoteId ).success( function( data ){
           for ( var i = 0; i < $scope.popular.length; i++ ) {
              if( $scope.popular[i].id === toolId ) {
                $scope.popular[i].votes = data.votes
                $scope.popular[i].voteId = null;
                $scope.popular[i].hasVoted = false;
                return
              }
           }
           Materialize.toast( 'removed vote', 4000)
        })
      }
    }

    $scope.upVoteRecent = function( toolId ){
      if ( $rootScope.isAuthenticated ){
        $http.post( '/api/tools/' + toolId + '/tvotes' ).success( function( data ){
          // returns an array of objects with Tools and associated categories and tags
          console.log(data)
           for ( var i = 0; i < $scope.recent.length; i++ ) {
              if( $scope.recent[i].id === toolId ) {
                $scope.recent[i].votes = data.votes;
                $scope.recent[i].voteId = data.voteId;
                $scope.recent[i].hasVoted = true;
                return
              }
           }
           Materialize.toast( 'voted', 4000)
        })
      }
    }

    $scope.removeVoteRecent = function( toolId, tvoteId ){
      if ( $rootScope.isAuthenticated ){
        $http.delete( '/api/tools/' + toolId + '/tvotes/' + tvoteId ).success( function( data ){
           for ( var i = 0; i < $scope.recent.length; i++ ) {
              if( $scope.recent[i].id === toolId ) {
                $scope.recent[i].votes = data.votes
                $scope.recent[i].voteId = null;
                $scope.recent[i].hasVoted = false;
                return
              }
           }
           Materialize.toast( 'removed vote', 4000)
        })
      }
    }

  init()
}]);