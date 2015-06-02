DevBox.controller( 'NewToolsCtrl', [ '$scope' , '$http', '$resource', function( $scope , $http , $resource ){

  console.log('New Tools Ctrl Loaded');

  Tool = $resource('/api/tools/', null, {
    'update': { method:'PUT' }
  });

  $scope.saveTool = function() {
    // var req = {
    //   url: '/api/tools',
    //   params: {
    //     title: $scope.title,
    //     description: $scope.description,
    //     language: $scope.language,
    //     is_open: $scope.is_open,
    //     is_free: $scope.is_free,
    //     web_url: $scope.web_url,
    //     repo_url: $scope.repo_url,
    //     doc_url: $scope.doc_url
    //   }
    // }

    // console.log(req);

    //   // Gather the http response
    // $http.post(req).success(function(data) {

    // })
    // .success(function(data, status, headers, config) {

    // })
    // .error(function(data, status, headers, config) {

    // })
    var tool = new Tool();
    tool.title = $scope.title;
    tool.description = $scope.description;
    tool.language = $scope.language;
    tool.is_open = $scope.is_open;
    tool.is_free = $scope.is_free;
    tool.web_url = $scope.web_url;
    tool.repo_url = $scope.repo_url;
    tool.doc_url = $scope.doc_url;
    tool.avg_rating = null;
    tool.$save(function(data) {
      console.log(data);
    })

  } // End saveTool

  // $scope.createPost = function(){
  //   var post = new Post();
  //   post.title = "My new post title";
  //   post.body = "This is my new post body";
  //   post.$save(function(data){
  //     console.log(data);

  // });

}])

