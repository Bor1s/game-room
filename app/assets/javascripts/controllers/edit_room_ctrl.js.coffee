@EditRoomCtrl = ['$scope', '$http', '$location', 'Room', '$routeParams', ($scope, $http, $location, Room, $routeParams) ->
  $scope.room = Room.get id: $routeParams.id

  $scope.update = (id)->
    # Removing optional owner keys from object
    delete $scope.room.owner

    Room.update id: id, room: $scope.room, (data)->
      $location.path('/')
]
