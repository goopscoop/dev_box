var DevBox = angular.module('DevBox',['ngRoute', 'ngResource', 'ngMaterial']);

DevBox.run(['$rootScope', 'UserService', function($rootScope, UserService) {
  console.log("I am running!")

  UserService.check(function(err, data) {
    console.log('Check', err, data);
  })

}])

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
  .when('/tools/new', {
    templateUrl: 'assets/tools/new.html',
    controller: 'ToolsNewCtrl'
  })
  .when('/tools/:id', {
    templateUrl: 'assets/tools/show.html',
    controller: 'ToolsShowCtrl'
  })
  .when('/tools/:id/edit', {
    templateUrl: 'assets/tools/edit.html',
    controller: 'ToolsEditCtrl'
  })
  .when('/users/profile', {
    templateUrl: 'assets/users/show.html',
    controller: 'UsersShowCtrl'
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
