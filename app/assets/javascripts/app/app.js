var DevBox = angular.module('DevBox',['ngRoute', 'ngResource', 'ngMaterial']);

DevBox.run(function(){
  console.log("I am running!")
})

DevBox.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);

  $routeProvider
  .when('/', {
    templateUrl:'/views/home.html',
    controller: 'HomeCtrl'
  })
  .when('/about', {
    templateUrl: '/views/about.html',
    controller: 'StaticCtrl'
  })
  .when('/tools/', {
    templateUrl: '/views/tools/index.html',
    controller: 'ToolsCtrl'
  })
  .when('/tool/:id', {
    templateUrl: '/views/tools/show.html',
    controller: 'ToolsCtrl'
  })
  .when('/tools/new', {
    templateUrl: '/views/tools/new.html',
    controller: 'ToolsCtrl'
  })
  .when('/tools/:id/edit', {
    templateUrl: '/views/tools/edit.html',
    controller: 'ToolsCtrl'
  })
  .when('/users/:id', {
    templateUrl: '/views/users/show.html',
    controller: 'UsersCtrl'
  })
  .when('/users/:id/edit', {
    templateUrl: '/views/users/edit.html',
    controller: 'UsersCtrl'
  })
  .when('/tools/:id/reviews/:id/edit', {
    templateUrl: '/views/reviews/edit.html',
    controller: 'ReviewsCtrl'
  })
  .when('/login', {
    templateUrl: '/views/sessions/new.html',
    controller: 'SessionsCtrl'
  })
  .when('/404', {
    templateUrl: '/views/404.html',
    controller: 'StaticCtrl'
  })
  .otherwise({redirectTo: '/404'});
}])
