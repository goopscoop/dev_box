DevBox.controller( 'ToolsNewCtrl', [ '$scope' , '$resource', '$location', function( $scope, $resource, $location ){

  console.log('New Tools Ctrl Loaded');

  Tool = $resource('/api/tools/', null, {
    'update': { method:'PUT' }
  });

  NewTool = $resource('/api/tools/new', null, {
    'update': { method: 'PUT' }
  })

  NewTool.get(function(data) {
    console.log(data);
    $scope.categories = data.result.categories;
    $scope.tags = data.result.tags
  },function(err){
    console.log(err);
  });

  $scope.saveTool = function() {

    var tool = new Tool();
    tool.title = $scope.title;
    tool.description = $scope.description;
    tool.language = $scope.language;
    tool.is_open = $scope.is_open? true : false;
    tool.is_free = $scope.is_free;
    tool.web_url = $scope.web_url;
    tool.repo_url = $scope.repo_url;
    tool.doc_url = $scope.doc_url;
    tool.avg_rating = null;
    tool.$save(function(data) {
      console.log(data);
      $location.url("/tool/" + data.result.id)
    })

  } // End saveTool

}])

