@RoomCtrl = ['$scope', '$http', 'Room', '$routeParams', ($scope, $http, Room, $routeParams) ->
  Room.get id: $routeParams.id, (data)->
    $scope.room = data.room
    $scope.totalPlayers = data.total_players
    $scope.players = data.players

  # Join room
  $scope.join = (id)->
    Room.join id: id, (data)->
      $scope.joined = true

  $scope.leave = (id)->
    if confirm?
      Room.leave id: id, (data)->
        $scope.joined = false
]
