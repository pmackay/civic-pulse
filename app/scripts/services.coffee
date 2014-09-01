
ITEMS_PER_PAGE = 20

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


app.factory 'CivicService', ['$timeout', '$http', 'Restangular', '$rootScope', ($timeout, $http, Restangular, $rootScope) ->
  new class CivicService
    constructor: () ->
      @projects = []
      @projectsTotal = 0
      @page = 1
      @languages = {}

    collateLanguages: =>
      @languages = {}
      console.log 'collateLanguages'
      console.log this
      for p in @projects
        # console.log p
        # console.log p.github_details
        lang = p.github_details.language
        # console.log lang
        # console.log typeof(lang)
        # if typeof lang != 'string'
        #   lang =
        if lang == undefined || lang == null || lang == '' || lang == 'null'
          lang = 'Unknown'
          p.github_details.language = 'Unknown'
        if @languages[lang] == undefined
          @languages[lang] = 1
        else
          @languages[lang] += 1
        # console.log $rootScope.languages

    fetchProjects: () =>
      if @projects.length == 0 or @projects.length < @projectsTotal
        console.log 'fetchProjects'
        gotProjects = Restangular.all('projects').getList({'per_page': ITEMS_PER_PAGE, 'page': @page})
        # Ensure next call will get the next page of projects
        @page += 1
        return gotProjects.then (projects) =>
          console.log 'gotProjects'
          # fixProjectTime(p) for p in projects

          for p in projects
            fixProjectTime(p)
            @projects.push p

          # @projects = @projects.concat projects
          # console.log @projects
          @projectsTotal = projects.total
          console.log @projectsTotal
          console.log @projects.length

          console.log @page

          @collateLanguages()

    organizations: () ->
      gotOrgs = Restangular.all('organizations').getList({'per_page': ITEMS_PER_PAGE})
      gotOrgs.then (orgs) ->
        for org in orgs
          fixProjectTime(p) for p in org.current_projects

      return gotOrgs
]
