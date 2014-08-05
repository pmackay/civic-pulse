'use strict'

###*
 # @ngdoc function
 # @name civicpulseApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the civicpulseApp
###
app = angular.module('civicpulseApp')

app.controller 'ActivityController', ($scope, CivicService) ->
  console.log 'ActivityController'
  gotProjects = CivicService.projects()
  console.log 'ActivityController'
  gotProjects.then (data) ->
    console.log data
    $scope.projects = data

app.controller 'OrgsController', ($scope, CivicService) ->
  # console.log 'ActivityController'
  gotOrgs = CivicService.organizations()
  # console.log 'ActivityController'
  gotOrgs.then (data) ->
    console.log data
    $scope.organizations = data
