angular.module('main', ['roomService', 'paginate']).config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $routeProvider
    .when('/', {templateUrl: '/rest/rooms.html', controller: RoomsCtrl})
    .when('/rooms/:id', {templateUrl: "/rest/rooms/show.html", controller: RoomCtrl})
    .when('/rooms/:id/edit', {templateUrl: "/rest/rooms/edit.html", controller: EditRoomCtrl})
    .otherwise({redirectTo: '/'})
])
