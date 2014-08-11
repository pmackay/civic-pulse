
ITEMS_PER_PAGE = 100

app = angular.module('civicpulseApp')


app.config (RestangularProvider) ->
  # Handle list being returned inside a wrapper object
  RestangularProvider.addResponseInterceptor((data, operation, what, url, response, deferred) ->
    # console.log url
    extractedData = data


    if (operation == "getList")
      extractedData = data.objects

    if /projects/.test url
      extractedData.total = data.total

    console.log 'extractedData'
    console.log extractedData
    # extractedData.structure2 = extractedData.structure

    return extractedData
  )

fixProjectTime = (project) ->
  # console.log project.last_updated
  tmp = project.last_updated.replace ' GMT', ''
  # console.log tmp
  # project.last_updated = moment(tmp, 'ddd, D MMM YYYY HH:mm:ss').format('YYYY-MM-DD HH:mm:ss')
  project.last_updated = moment(tmp, 'ddd, D MMM YYYY HH:mm:ss').format('X')
  # console.log project.last_updated

  # Set a flag if a project was created "recently"
  if project.github_details
    createdDate = moment(project.github_details.created_at)
    diff = moment().diff(createdDate)
    # console.log 'diff'
    # console.log diff
    if diff < 2592000000
      project.is_recent = true


app.factory 'CivicService', ($timeout, $http, Restangular, $rootScope) ->

  projects: () ->
    console.log 'projects'
    gotProjects = Restangular.all('projects').getList({'per_page': ITEMS_PER_PAGE})
    gotProjects.then (projects) ->
      fixProjectTime(p) for p in projects
    return gotProjects

  organizations: () ->
    gotOrgs = Restangular.all('organizations').getList({'per_page': ITEMS_PER_PAGE})
    gotOrgs.then (orgs) ->
      for org in orgs
        fixProjectTime(p) for p in org.current_projects

    return gotOrgs

