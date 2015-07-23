DevBox.directive( 'devMarkdownHelper', function(){
  var helperLogic = function(scope, element, attrs ){
    scope.isFormattingHelpOpen = false;

    scope.formattingHelp = function(action){
      console.log('boop')
      scope.isFormattingHelpOpen = action;
    }
  }
  return {
    restrict: 'A',
    template: 'markdownHelper.html',

    scope: {
      // newclass: '='
    },
    link: helperLogic
  }
} )


.directive('devLeftSidebar', [ '$http', function( $http ){
  var logic = function(scope, element, attrs){
    $http.get('/api/tags-and-cats').success( function( data ){
      scope.categories = data.categories;
      scope.tags = data.tags;
    });
  }

  return {
    restrict: 'E',
    template: 'devLeftSidebar.html',
    replace: true,
    link: logic,
    scope: {

    }
  }
}])