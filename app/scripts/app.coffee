'use strict'

CIVIC_API_URL = 'http://www.codeforamerica.org/api'

###*
 # @ngdoc overview
 # @name civicpulseApp
 # @description
 # # civicpulseApp
 #
 # Main module of the application.
###
app = angular.module('civicpulseApp', [
  'ngAnimate',
  'ngCookies',
  'ngResource',
  'ngRoute',
  'ngSanitize',
  'ngTouch',
  'restangular'
])


# Support CORS requests
# For some reason this seems to have to be here rather than in services
app.config ['$httpProvider', 'RestangularProvider', ($httpProvider, RestangularProvider) ->
  $httpProvider.defaults.useXDomain = true
  delete $httpProvider.defaults.headers.common['X-Requested-With']
]

app.config ($routeProvider, RestangularProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'views/main.html'
      controller: 'ActivityController'
    .when '/about',
      templateUrl: 'views/about.html'
      controller: 'AboutCtrl'
    .when '/orgs',
      templateUrl: 'views/orgs.html'
      controller: 'OrgsController'
    .otherwise
      redirectTo: '/'

  RestangularProvider.setBaseUrl(CIVIC_API_URL)
