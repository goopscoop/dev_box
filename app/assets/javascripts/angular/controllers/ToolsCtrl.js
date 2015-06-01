DevBox.controller( 'ToolsCtrl' , [ '$scope' , '$http', '$resource' ,
  function ( $scope , $http , $resource){

    $scope.tools = [];

    $http.get('/api/tools').success(function(data){
      $scope.tools = data;
      console.log(data)
    })

}]);