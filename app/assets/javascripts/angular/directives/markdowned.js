angular.module('markdowned', [] )
.directive('markdown', ['showdown', function (showdown) {
  var converter = new showdown.Converter();
  return {
    restrict: 'A',
    link: function (scope, element, attrs) {
      function renderMarkdown() {
          var htmlText = converter.makeHtml(scope.$eval(attrs.markdown)  || '');
          element.html(htmlText);
      }
      scope.$watch(attrs.markdown, renderMarkdown);
      renderMarkdown();
    }
  };
}]);
