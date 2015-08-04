DevBox.controller('UsersShowCtrl',['$scope', '$http', 'buildUrl', '$location', 'devSearchFn', 'devInit', 'devAlert',
  function( $scope, $http, buildUrl, $location, devSearchFn, devInit, devAlert ){

  $scope.showResults = true;

  var init = function(){
    loadToolsCatsAndTags(); //Also calls narrowTools() function in callback
    loadCatsAndTags()
  }

  $scope.toolOptions = [
    { name: 'add to collection',
      icon: 'list',
      action: function( toolId, toolName ){
        loadCollectionList(toolId, toolName)
      } },
    { name: 'remove from toolbox',
      icon: 'delete',
      action: function( toolId ){
        removeTool(toolId);
      } }
  ]

  $scope.userToolBox = {
    searchTools: []
  }
  // $scope.searchTools = []


  var loadToolsCatsAndTags = function(){
    if ( !$scope.tools || !$scope.categories || !$scope.tags ) {
      $http.get('/api/users/profile').success( function( data ){
        $scope.tools = data.tools;
        console.log($scope.tools)
      } ).success(function(){
        narrowTools()
      })
    }
  }

  var loadCatsAndTags = function(){
    if( devInit.notLoaded( $scope.categories, $scope.tags ) ){
      devInit.loadCatsAndTags()
      .then(function(data){
        $scope.tags = data.tags;
        $scope.categories = data.categories;
      })
    }
  }

  var isNotEmptyObj = function(ob){
     for(var i in ob){ return true;}
    return false;
  }

  var narrowTools = function( ){
    if( isNotEmptyObj( $location.search() ) ){
      $scope.activeCategory = $location.search().c || null;
      $scope.activeTag = $location.search().t || null;
      $scope.userToolBox.searchTools = narrowByCatAndTag( $scope.tools, $scope.activeCategory, $scope.activeTag );
  }



 function narrowByCatAndTag( allTools, focusedCat, focusedTag ){
    return $.grep( allTools, function(tool){
        if ( focusedCat && focusedTag ) {
          return returnSelectedTagsAndCats( tool, focusedCat, focusedTag );
        } else if ( focusedCat ) {
          return returnSelectedCats( tool, focusedCat );
        } else if ( focusedTag ) {
          return returnSelectedTags( tool, focusedTag );
        }
      });
    }
  }

  var returnSelectedTags = function( tool, focusedTag ){
    for ( i = 0; i < tool.tags.length; i++ ) {
      if ( tool.tags[i].tag.toLowerCase().indexOf( focusedTag.toLowerCase() ) !== -1 ) {
        return true;
      }
    }
  }

  var returnSelectedCats = function( tool, focusedCat){
    for (var i = 0; i < tool.categories.length; i++) {
      if ( tool.categories[i].category.indexOf( focusedCat.toLowerCase() ) !== -1){
        return true;
      }
    }
  }

  var returnSelectedTagsAndCats = function( tool, focusedCat, focusedTag ){
    for (var i = 0; i < tool.categories.length; i++) {
      if ( tool.categories[i].category.indexOf( focusedCat.toLowerCase() ) !== -1){
        for ( i = 0; i < tool.tags.length; i++ ) {
          if ( tool.tags[i].tag.toLowerCase().indexOf( focusedTag.toLowerCase() ) !== -1 ) {
            return true;
          }
        }
      }
    }
  }

  var removeTool = function( toolId ){
    $http.delete( '/api/users/delete/tool/' + toolId ).success( function( data ){
      for (var i = 0; i < $scope.tools.length; i++){
        if ($scope.tools[i].id === toolId ) {
          $scope.tools.splice(i,1);
        }
      }
    });
  }

  var loadCollectionList = function( toolId, toolName ){
    $http.get( '/api/collections' ).then( function( data ){
      console.log(data.data.result)
      $scope.toolForCollection = {id: toolId, title: toolName}
      $scope.showResults = false;
      $scope.collectionList = data.data.result.collections;
    }, function( err ){
      console.log(err)
    } )
  }

  $scope.addToolToCollection = function(collectionId, toolId){
    var collectionToValidate = $.grep($scope.collectionList, function( collection ){ return collection.collection.id === collectionId; })
    console.log(collectionToValidate[0])
    if ( isToolInCollection( collectionToValidate[0], toolId ) ){
      $http.put( '/api/collections/' + collectionId + '/collection_tools/' + toolId)
      .then( function(data){
          devAlert.alert("Tool added to collection")
          $scope.showResults = true;
        },
          function(err){
          console.log(err)
        }
      )
    }
  }

  var isToolInCollection = function(collection, toolId){
    for(var i = 0; i < collection.tools.length; i++){
      if( collection.tools[i].id === toolId ){
        devAlert.alert( collection.tools[i].title + " is already in this collection" );
        return false;
      }
    }
    return true;
  }

  $scope.getMatches = function( toolSearchText ){
      return $scope.userToolBox.searchTools = $.grep($scope.tools, function( tool ){
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
    $scope.userToolBox.searchTools = devSearchFn.focus( $scope.selectedTool )
    return  $scope.userToolBox.searchTools
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