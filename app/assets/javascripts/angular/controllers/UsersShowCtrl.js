DevBox.controller('UsersShowCtrl',['$scope', '$http', 'buildUrl',
  function( $scope, $http, buildUrl ){

  $scope.tools = []
  $scope.searchTools = []

  var init = function(){
    $http.get('/api/users/profile').success( function( data ){
      $scope.categories = data.categories;
      $scope.tags = data.tags;
      $scope.tools = data.tools;
    } )
  }


  $scope.removeTool = function( toolId ){
    $http.delete( '/api/users/delete/tool/' + toolId ).success( function( data ){
        for (var i = 0; i < $scope.tools.length; i++){
          if ($scope.tools[i].id === toolId ) {
            $scope.tools.splice(i,1);
          }
        }
      } )
  }

  $scope.getMatches = function( toolSearchText ){
      return $scope.searchTools = $.grep($scope.tools, function(tool){
        // Searching for tool by name
        if ( tool.title.toLowerCase().indexOf( toolSearchText.toLowerCase() ) !== -1 ) {
          return true;
        } else {
          // Searching for tool by tag
          for ( i = 0; i < tool.tags.length; i++ ) {
            if ( tool.tags[i].tag.toLowerCase().indexOf( toolSearchText.toLowerCase() ) !== -1 ) {
              return true;
            }
          }
        }
      });
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

    $scope.clearSearch = function(){
      $scope.searchTools = [];
      $scope.toolSearchText = '';
    }

  $scope.addCat = function( catName ){
    localUrl = buildUrl.build( false, $location.search().q, catName, $location.search().t);
    $location.search(localUrl);
  }

  init()
}]);