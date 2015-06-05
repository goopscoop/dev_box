DevBox.controller( 'ToolsShowCtrl', [ '$scope' , '$resource', '$http', '$location', '$routeParams', '$rootScope', 'showdown', 'UserService',
 function( $scope, $resource, $http, $location, $routeParams, $rootScope, showdown, UserService ){
  $rootScope.isAuthenticated;

  $scope.favorited = false;
  $scope.number = 5;
  $scope.UserService = UserService;

  $scope.$watchCollection('UserService', function() {
    $scope.currentUser = UserService.currentUser;
  });

  $scope.getNumber = function( num ) {
      return new Array(num);
  }

  $scope.displayRating = function( idx ) {
    if (!$rootScope.isAuthenticated) return;
    $scope.userRating = idx + 1;
  }

  $scope.resetRatingDisplay = function() {
    $scope.userRating = $scope.originalRating;
  }

  $scope.setRating = function( idx ) {
    if (!$rootScope.isAuthenticated) return;
    if ($scope.userRated) {

      // Update code here
      var review = {}
      review.id = $scope.userReviewId;
      review.rating = idx + 1;
      review.tool_id = $routeParams.id;
      Review.update({id: $scope.userReviewId}, review, function(data) {
        console.log(data);
        // Set user rating and set original rating to the user's new rating
        $scope.userRating = idx + 1;
        $scope.originalRating = $scope.userRating;
        Materialize.toast('rating saved', 4000)
      })

    } else {

      // New review code here
      var review = new Review();
      review.post = null;
      review.rating = idx + 1;
      review.tool_id = $routeParams.id;
      review.$save(function(data) {
        console.log(data);
        // Set user rating and set original rating to the user's new rating
        $scope.userRating = idx + 1;
        $scope.originalRating = $scope.userRating;
        Materialize.toast('rating saved', 4000)
      })

    }
  }

  $scope.addTool = function( toolId ){
    if ( $scope.tool.favorited === false ) {
      $http.post('/api/users/' + toolId + '/tool').success( function( data ){
        if (data.result === true){
          $scope.tool.favorited = true;
          Materialize.toast( 'added to toolbox', 4000)
        }
      } )
    } else if ( $scope.tool.favorited === true ) {
      $http.delete( '/api/users/delete/tool/' + toolId ).success( function( data ){
        if (data.result === true){
          $scope.tool.favorited = false;
          Materialize.toast( 'removed from toolbox', 4000)
        }
      } )
    }
  }

  Tool = $resource('/api/tools/:id', null, {
    'update': { method:'PUT' }
  });

  Review = $resource('/api/tools/' + $routeParams.id + '/reviews/:id', null, {
    'update': { method:'PUT' }
  });

  var init = function(){
      Tool.get({id:$routeParams.id},function(data) {
        $scope.categories = data.navCats;
        $scope.tags = data.navTags;
        $scope.tool = data.result;

        if ($scope.tool.tool.is_free == -1) {
          $scope.is_free = 'freemium'
        } else if ($scope.tool.tool.is_free == 0) {
          $scope.is_free = 'paid'
        } else if ($scope.tool.tool.is_free == 1) {
          $scope.is_free = 'free'
        }

        for(i = 0; i < $scope.tool.reviews_users.length; i++) {
          if ($scope.tool.reviews_users[i].review.user_id == $scope.currentUser.id) {
            $scope.userRating = $scope.tool.reviews_users[i].review.rating;
            // Set a variable so that we know this user has already rated
            // or reviewed the tool
            $scope.userRated = true;
            $scope.userReviewId = $scope.tool.reviews_users[i].review.id
          }
        }

        $scope.userRating = $scope.userRating || 0;
        $scope.originalRating = $scope.userRating;

      },function(err){
        console.log(err);
      });
    }

  init()

  $scope.saveReview = function() {
    console.log("Add Review Function");
    var content = editor.exportFile();
    var review = new Review();
    review.post = content;
    review.tool_id = $routeParams.id;
    review.$save(function(data) {
      console.log(data);
      // Add new comment to list
      $scope.tool.reviews_users.unshift(data.result);

      // Clear the editor
      editor.edit();
      editor.getElement('editor').body.innerHTML = '';
    })
  }

}])
