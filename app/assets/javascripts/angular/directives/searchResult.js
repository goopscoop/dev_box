DevBox.directive('boxSearchResult', function(){
  return {
    restrict: 'E',
    link: function(scope, element, attribute){
      scope.searchObject = attribute.object;
    },
    template: "<h1>TESTING MY DIRECTIVE</h1>",
    replace: true
  }
})