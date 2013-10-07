angular.module('main', ['roomService', 'paginate', 'ngRoute']).config(['$routeProvider', '$httpProvider', ($routeProvider, $httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $routeProvider
    .when('/', {templateUrl: '/rest/rooms.html', controller: RoomsCtrl})
    .when('/rooms/:id',
      templateUrl: (el, attr)->
        "/rest/rooms/#{el.id}"
      controller: RoomCtrl)
    .when('/rooms/:id/edit',
      templateUrl: (el, attr)->
        "/rest/rooms/#{el.id}/edit"
      controller: EditRoomCtrl
    )
    .otherwise({redirectTo: '/'})
])
