angular.module('main', ['roomService', 'paginate']).config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $routeProvider
    .when('/', {templateUrl: '/rest/rooms.html', controller: RoomsCtrl})
    .when('/rooms/:id/edit', {templateUrl: "/rest/rooms/edit.html", controller: RoomsCtrl})
    .otherwise({redirectTo: '/'})
])
