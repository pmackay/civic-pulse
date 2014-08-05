'use strict'

###*
 # @ngdoc function
 # @name civicpulseApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the civicpulseApp
###
angular.module('civicpulseApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
