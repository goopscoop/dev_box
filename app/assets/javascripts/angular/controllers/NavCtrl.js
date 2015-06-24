DevBox.controller('NavCtrl', ['$scope', '$rootScope', 'UserService', function($scope, $rootScope, UserService) {

  $scope.UserService = UserService;

  $scope.logout = function() {
    UserService.logout(function(err, data) {
      // Logout callback doesn't need to do anything
    })
  };

  $scope.$watchCollection('UserService', function() {
    $scope.currentUser = UserService.currentUser;
  });

}])
