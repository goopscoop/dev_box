DevBox.controller( 'ToolsShowCtrl', [ '$scope' , '$resource', '$http', '$location', '$routeParams', '$rootScope', 'showdown',
 function( $scope, $resource, $http, $location, $routeParams, $rootScope, showdown ){
  $rootScope.isAuthenticated;

  $scope.favorited = false;
  $scope.number = 5;

  $scope.getNumber = function(num) {
      return new Array(num);
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

  Review = $resource('/api/tools/' + $routeParams.id + '/reviews', null, {
    'update': { method:'PUT' }
  });

  var init = function(){
      Tool.get({id:$routeParams.id},function(data) {
        // $rootScope.loading = false;
        $scope.categories = data.navCats;
        $scope.tags = data.navTags;
        $scope.tool = data.result;
        console.log($scope.tags)
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
