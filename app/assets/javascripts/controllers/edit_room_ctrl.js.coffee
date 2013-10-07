@EditRoomCtrl = ['$scope', '$http', '$location', 'Room', '$routeParams', ($scope, $http, $location, Room, $routeParams) ->
  Room.edit id: $routeParams.id, (data)->
    $scope.room = data

  $scope.update = (id)->
    # Removing optional [owner, owned, joined] keys from object
    delete $scope.room.owned
    delete $scope.room.owner
    delete $scope.room.joined

    Room.update id: id, room: $scope.room, (data)->
      $location.path('/')
]
