DevBox.controller('HomeCtrl',['$scope', '$http', function( $scope, $http ){

  var init = function(){
    $http.get('/api/home').success( function( data ){
      console.log(data)
    } )
  }

  init()
}]);