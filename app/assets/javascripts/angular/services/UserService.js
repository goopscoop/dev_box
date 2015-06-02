DevBox.factory('UserService', ['$http', '$rootScope', function( $http , $rootScope ) {
  $rootScope.isAuthenticated = false;
  return {

    check: function(callback) {

      var self = this;

      $http.get('/api/check')
      .success(function(data) {
        if (data && data.user) {
          self.currentUser = data.user;
          $rootScope.isAuthenticated = true;
        } else {
          self.currentUser = false;
          $rootScope.isAuthenticated = false;
        }
        callback(null, data);
      })
      .error(function(err) {
        callback(err);
      })
    },

    logout: function(callback) {
      this.currentUser = false;

      $http.delete('/api/logout')
      .success(function(data) {
        callback(null, data);
      })
      .error(function(err) {
        callback(err);
      })
    }
  }
}])
