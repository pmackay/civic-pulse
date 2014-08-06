(function(){"use strict";var a,b;a="http://www.codeforamerica.org/api",b=angular.module("civicpulseApp",["ngAnimate","ngCookies","ngResource","ngRoute","ngSanitize","ngTouch","restangular","angularMoment"]),b.config(["$httpProvider","RestangularProvider",function(a){return a.defaults.useXDomain=!0,delete a.defaults.headers.common["X-Requested-With"]}]),b.config(["$routeProvider","RestangularProvider",function(b,c){return b.when("/",{templateUrl:"views/orgs.html",controller:"OrgsController"}).when("/about",{templateUrl:"views/about.html",controller:"AboutCtrl"}).when("/orgs",{templateUrl:"views/orgs.html",controller:"OrgsController"}).otherwise({redirectTo:"/"}),c.setBaseUrl(a)}])}).call(this),function(){var a;a=angular.module("civicpulseApp"),a.config(["RestangularProvider",function(a){return a.addResponseInterceptor(function(a,b){var c;return c=a,"getList"===b&&(c=a.objects),c})}]),a.factory("CivicService",["$timeout","$http","Restangular","$rootScope",function(a,b,c){return{projects:function(){var a;return console.log("projects"),a=c.all("projects").getList()},organizations:function(){var a;return a=c.all("organizations").getList(),a.then(function(a){var b,c,d,e,f,g;for(g=[],e=0,f=a.length;f>e;e++)b=a[e],g.push(function(){var a,e,f,g;for(f=b.current_projects,g=[],a=0,e=f.length;e>a;a++)c=f[a],console.log(c.last_updated),d=c.last_updated.replace(" GMT",""),console.log(d),c.last_updated=moment(d,"ddd, D MMM YYYY HH:mm:ss").format("X"),g.push(console.log(c.last_updated));return g}());return g}),a}}}])}.call(this),function(){"use strict";var a;a=angular.module("civicpulseApp"),a.controller("ActivityController",["$scope","CivicService",function(a,b){var c;return console.log("ActivityController"),c=b.projects(),console.log("ActivityController"),c.then(function(b){return console.log(b),a.projects=b})}]),a.controller("OrgsController",["$scope","CivicService",function(a,b){var c;return c=b.organizations(),c.then(function(b){return console.log(b),a.organizations=b})}])}.call(this),function(){"use strict";angular.module("civicpulseApp").controller("AboutCtrl",["$scope",function(a){return a.awesomeThings=["HTML5 Boilerplate","AngularJS","Karma"]}])}.call(this);