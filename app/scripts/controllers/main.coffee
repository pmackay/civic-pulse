'use strict'

###*
 # @ngdoc function
 # @name civicpulseApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the civicpulseApp
###
app = angular.module('civicpulseApp')

app.controller 'ActivityController', ($scope, $rootScope, CivicService) ->
  $scope.languageFilterSelected = (language) ->
    console.log language
    $scope.languageFilter = language

  $scope.getProjectVisibility = (project) ->
    return $scope.newProjectsValue && ! project.is_recent || ($scope.languageFilter != "" && $scope.languageFilter != project.github_details.language)

  $scope.resetFilters = () ->
    $scope.query = ''
    $scope.languageFilter = ''
    $scope.newProjectsValue = false

  $rootScope.activeTab = 'activity'
  $scope.languageFilter = ''
  console.log 'ActivityController ' + $scope.projects
  if $rootScope.projects == undefined
    gotProjects = CivicService.projects()
    console.log 'ActivityController'
    $scope.newProjectsValue = false
    gotProjects.then (data) ->
      console.log data
      $rootScope.projects = data
      $rootScope.projectsTotal = data.total

      # Collate list of languages
      $rootScope.languages = {}
      for p in $rootScope.projects
        lang = p.github_details.language
        # console.log lang
        # console.log typeof(lang)
        # if typeof lang != 'string'
        #   lang =
        if lang == undefined || lang == null || lang == '' || lang == 'null'
          lang = 'Unknown'
          p.github_details.language = 'Unknown'
        if $rootScope.languages[lang] == undefined
          $rootScope.languages[lang] = 1
        else
          $rootScope.languages[lang] += 1
      console.log $rootScope.languages

  # gotOrgs = CivicService.organizations()
  # # console.log 'ActivityController'
  # gotOrgs.then (data) ->
  #   console.log data
  #   $scope.organizations = data


app.controller 'OrgsController', ($scope, $rootScope, CivicService) ->
  $rootScope.activeTab = 'orgs'
  # console.log 'ActivityController'
  if $rootScope.organizations == undefined
    gotOrgs = CivicService.organizations()
    # console.log 'ActivityController'
    gotOrgs.then (data) ->
      # console.log data
      $rootScope.organizations = data
