@RoomCtrl = ['$scope', '$http', 'Room', '$routeParams', ($scope, $http, Room, $routeParams) ->
  Room.get id: $routeParams.id, (data)->
    $scope.room = data.room
    $scope.totalPlayers = data.total_players
    $scope.players = data.players
    $scope.joined = data.joined
    $scope.owned = data.owned

  # Join room
  $scope.join = (id)->
    Room.join id: id, (data)->
      $scope.joined = true
      $scope.totalPlayers += 1

  $scope.leave = (id)->
    if confirm 'You sure want leave this room?'
      Room.leave id: id, (data)->
        $scope.joined = false
        $scope.totalPlayers -= 1
]
