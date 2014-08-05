
app = angular.module('civicpulseApp')


app.config (RestangularProvider) ->
  # Handle list being returned inside a wrapper object
  RestangularProvider.addResponseInterceptor((data, operation, what, url, response, deferred) ->
    # console.log url
    extractedData = data

    if (operation == "getList")
      extractedData = data.objects
    # console.log extractedData.structure
    # extractedData.structure2 = extractedData.structure
    return extractedData
  )

app.factory 'CivicService', ($timeout, $http, Restangular, $rootScope) ->
  projects: () ->
    console.log 'projects'
    gotProjects = Restangular.all('projects').getList()
    return gotProjects

  organizations: () ->
    got = Restangular.all('organizations').getList()
    return got
