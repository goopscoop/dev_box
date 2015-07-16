DevBox.controller( 'ToolsShowCtrl', [ '$scope' , '$resource', '$http', '$location', '$routeParams', '$rootScope', 'showdown', 'UserService', 'devAlert',
 function( $scope, $resource, $http, $location, $routeParams, $rootScope, showdown, UserService, devAlert ){
  $rootScope.isAuthenticated;

  $scope.editingReview = false;
  $scope.userRated = false;
  $scope.favorited = false;
  $scope.$watch.isFormattingHelpOpen = false;
  $scope.number = 5;
  $scope.UserService = UserService;

  $scope.$watchCollection('UserService', function() {
    $scope.currentUser = UserService.currentUser;
  });

  $scope.getNumber = function( num ) {
      return new Array(num);
  }

  $scope.addTool = function( toolId ){
    if ( $scope.tool.favorited === false ) {
      $http.post('/api/users/' + toolId + '/tool').success( function( data ){
        if (data.result === true){
          $scope.tool.favorited = true;
          devAlert.alert('added to toolbox')
        }
      } )
    } else if ( $scope.tool.favorited === true ) {
      $http.delete( '/api/users/delete/tool/' + toolId ).success( function( data ){
        if (data.result === true){
          $scope.tool.favorited = false;
          devAlert.alert( 'removed from toolbox')
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

  $scope.formattingHelp = function(action){
    console.log('boop')
    $scope.isFormattingHelpOpen = action;
  }

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

        for(var i = 0; i < $scope.tool.reviews_users.length; i++) {
          if ($scope.tool.reviews_users[i].review.user_id == $scope.currentUser.id) {
            $scope.userRating = $scope.tool.reviews_users[i].review.rating;
            // Set a variable so that we know this user has already rated
            // or reviewed the tool
            $scope.userRated = true;
            $scope.userReviewId = $scope.tool.reviews_users[i].review.id
            $scope.userPost = $scope.tool.reviews_users[i].review.post
            $scope.userReviewCreatedAt = $scope.tool.reviews_users[i].review.created_at
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
    if ( !$scope.userRating || $scope.userRating < 1 ) {
      Materialize.toast('please add a rating', 4000)
    } else {
      var review = new Review();
      review.post = $scope.userPost;
      review.rating = $scope.userRating;
      review.tool_id = $routeParams.id;
      review.$save(function(data) {

        // Add new comment to list
        $scope.tool.reviews_users.unshift(data.result);

        // Set the users review info
        $scope.userRating = data.result.review.rating;
        // Set a variable so that we know this user has already rated
        // or reviewed the tool
        $scope.userRated = true;
        $scope.userReviewId = data.result.review.id
        $scope.userPost = data.result.review.post
        $scope.userReviewCreatedAt = data.result.review.created_at
        $scope.tool.tool.avg_rating = data.result.avg_rating
      })
    }
  }

  $scope.updateReview = function() {
    // update logic here
    if ( !$scope.userRating || $scope.userRating < 1 ) {
      devAlert.alert('please add a rating');
    } else {
      var review = {}
      review.post = $scope.userPost;
      review.rating = $scope.userRating;
      review.id = $scope.userReviewId;

      Review.update({id: $scope.userReviewId}, review, function(data) {
          $scope.editingReview = false;
          $scope.userRating = data.result.rating;
          $scope.userPost = data.result.post;
          $scope.userReviewUpdatedAt = data.result.updated_at;
          $scope.tool.tool.avg_rating = data.avg_rating;
          devAlert.alert('review updated');
        })
      }
  }

  $scope.editReview = function() {
    $scope.editingReview = true;
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
    $scope.userRating = idx + 1;
    $scope.originalRating = $scope.userRating;
  }

}])
