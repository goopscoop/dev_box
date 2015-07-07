DevBox.controller('UsersShowCtrl',['$scope', '$http', 'buildUrl', '$location',
  function( $scope, $http, buildUrl, $location ){

  $scope.userToolBox = {
    searchTools: []
  }
  // $scope.searchTools = []

  var init = function(){
    loadToolsCatsAndTags(); //Also calls narrowTools() function in callback
  }

  var loadToolsCatsAndTags = function(){
    if ( !$scope.tools || !$scope.categories || !$scope.tags ) {
      $http.get('/api/users/profile').success( function( data ){
        $scope.categories = data.categories;
        $scope.tags = data.tags;
        $scope.tools = data.tools;
        console.log($scope.tools)
      } ).success(function(){
        narrowTools()
      })
    }
  }

  var isNotEmptyObj = function(ob){
     for(var i in ob){ return true;}
    return false;
  }

  var narrowTools = function(){
    if( isNotEmptyObj( $location.search() ) ){
      $scope.activeCategory = $location.search().c || null;
      $scope.activeTag = $location.search().t || null;
      $scope.userToolBox.searchTools = $.grep($scope.tools, function(tool){
        if ( $scope.activeCategory && $scope.activeTag ) {
          for (var i = 0; i < tool.categories.length; i++) {
            if ( tool.categories[i].category.indexOf( $scope.activeCategory.toLowerCase() ) !== -1){
              for ( i = 0; i < tool.tags.length; i++ ) {
                if ( tool.tags[i].tag.toLowerCase().indexOf( $scope.activeTag.toLowerCase() ) !== -1 ) {
                  return true;
                }
              }
            }
          }
        } else if ( $scope.activeCategory ) {
          for (var i = 0; i < tool.categories.length; i++) {
            if ( tool.categories[i].category.indexOf( $scope.activeCategory.toLowerCase() ) !== -1){
              return true;
            } else {

            }
          }
        } else if ( $scope.activeTag ) {
          for ( i = 0; i < tool.tags.length; i++ ) {
            if ( tool.tags[i].tag.toLowerCase().indexOf( $scope.activeTag.toLowerCase() ) !== -1 ) {
              return true;
            }
          }
        }
      })
    }
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
      return $scope.userToolBox.searchTools = $.grep($scope.tools, function(tool){
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

  $scope.searchTextChanged = function( toolSearchText ){
    if( toolSearchText ){
      $scope.getMatches(toolSearchText)
    }
  }

  $scope.focusOnSelectedTool = function( ){
    if ($scope.selectedTool) {
      $scope.userToolBox.searchTools = [];
      $scope.userToolBox.searchTools.unshift($scope.selectedTool);
      return $scope.userToolBox.searchTools;
      // console.log("get matches function",$scope.searchTools)
    }
    return $scope.userToolBox.searchTools;
    // $scope.searchTools = $scope.selectedTool
  }

  $scope.clearSearch = function(){
    $scope.userToolBox.searchTools = [];
    $scope.toolSearchText = '';
    $location.search("")
  }

  $scope.addCat = function( catName ){
    localUrl = buildUrl.build( false, $location.search().q, catName, $location.search().t);
    $location.search(localUrl);
  }

  $scope.addTag = function( tagName ){
    localUrl = buildUrl.build( false, $location.search().q, $location.search().c, tagName );
    $location.search(localUrl);
  }

  init()
}]);