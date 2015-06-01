var DevBox = angular.module('DevBox',['ngRoute', 'ngResource', 'ngMaterial']);

DevBox.run(function(){
  console.log("I am running!")
})

DevBox.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);

  $routeProvider
  .when('/', {
    templateUrl:'assets/home.html',
    controller: 'HomeCtrl'
  })
  .when('/about', {
    templateUrl: 'assets/about.html',
    controller: 'StaticCtrl'
  })
  .when('/tools/', {
    templateUrl: 'assets/tools/index.html',
    controller: 'ToolsCtrl'
  })
  .when('/tool/:id', {
    templateUrl: 'assets/tools/show.html',
    controller: 'ToolsCtrl'
  })
  .when('/tools/new', {
    templateUrl: 'assets/tools/new.html',
    controller: 'ToolsCtrl'
  })
  .when('/tools/:id/edit', {
    templateUrl: 'assets/tools/edit.html',
    controller: 'ToolsCtrl'
  })
  .when('/users/:id', {
    templateUrl: 'assets/users/show.html',
    controller: 'UsersCtrl'
  })
  .when('/users/:id/edit', {
    templateUrl: 'assets/users/edit.html',
    controller: 'UsersCtrl'
  })
  .when('/tools/:id/reviews/:id/edit', {
    templateUrl: 'assets/reviews/edit.html',
    controller: 'ReviewsCtrl'
  })
  .when('/login', {
    templateUrl: 'assets/sessions/new.html',
    controller: 'SessionsCtrl'
  })
  .when('/404', {
    templateUrl: 'assets/404.html',
    controller: 'StaticCtrl'
  })
  .otherwise({redirectTo: '/404'});
}])
