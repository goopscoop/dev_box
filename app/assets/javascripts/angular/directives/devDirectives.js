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


.directive('boxSearchResult', function(){
  var searchResultTemplat = '<div class="section tool-search-results" dir-paginate="tool in searchArray | itemsPerPage: 10">' +
          '<div class="col s1">' +
            '<div ng-if="$root.isAuthenticated === false"><a class="not-voted" href="#" ><i class="mdi-navigation-expand-less up-vote"></i><md-tooltip>log in to vote</md-tooltip></a></div>' +
            '<div ng-if="tool.hasVoted === false && $root.isAuthenticated"><a class="not-voted" href="#" ng-click="upVote(tool.id)"><i class="mdi-navigation-expand-less up-vote"></i></a></div>' +
            '<div ng-if="tool.hasVoted === true && $root.isAuthenticated"><a class="has-voted" href="#" ng-click="removeVote(tool.id, tool.voteId)"><i class="mdi-navigation-expand-less up-vote"></i></a></div>' +
          '</div>' +
          '<div class="col s11">' +
            '<div class="row">' +
              '<div class="col s8 m8">' +
                '<h4 class="tool-title"><a ng-href="/tools/{{tool.id}}">{{tool.title}}</a></h4><span class="tool-language">[ {{tool.language}} ]</span>' +
              '</div>' +
              '<div class="col s4 m4 rev-wrapper">' +
                '<span class="avg-rating" ng-repeat="i in getNumber(5) track by $index">' +
                  '<i ng-if="tool.avg_rating >= $index + 1" id={{$index}} class="search-mouse mdi-hardware-mouse liked"></i>' +
                  '<i ng-if="tool.avg_rating < $index + 1" id={{$index}} class="search-mouse mdi-hardware-mouse"></i>' +
                '</span>' +
              '</div>' +
            '</div>' +
            '<div class="col s8 m8">' +
              '<span class="tvotes-search-results"><strong>{{tool.votes}}</strong> up votes</span>' +
              '<ul>' +
                '<li ng-repeat="category in tool.categories"><a href="#" class="tool-category" ng-click="addCat(category.category)">{{category.category}}</a></li>' +
              '</ul>' +
              '<a class="user-tool-link" ng-show="tool.web_url" ng-href="{{tool.web_url}}">' +
                '<i class="mdi-social-public"></i>' +
                '<md-tooltip>website</md-tooltip>' +
              '</a>' +
              '<a class="user-tool-link" ng-show="tool.repo_url" ng-href="{{tool.repo_url}}">' +
                '<i class="mdi-communication-call-split"></i>' +
                '<md-tooltip>repo</md-tooltip>' +
              '</a>' +
              '<a class="user-tool-link" ng-show="tool.doc_url" ng-href="{{tool.doc_url}}">' +
                '<i class="mdi-action-description"></i>' +
                '<md-tooltip>docs</md-tooltip>' +
              '</a>' +
            '</div>' +
            '<div class="col s4 m4">' +
              '<span class="avg-review-tag">avg. review</span>' +
            '</div>' +
          '</div>' +
        '</div>'

  return {
    restrict: 'E',
    template: searchResultTemplat,
    replace: true
  }
})