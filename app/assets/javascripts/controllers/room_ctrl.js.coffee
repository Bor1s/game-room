@RoomCtrl = ['$scope', '$http', 'Room', 'Post', '$routeParams', ($scope, $http, Room, Post, $routeParams) ->
  Room.get id: $routeParams.id, (data)->
    $scope.room         = data.room
    $scope.totalPlayers = data.total_players
    $scope.players      = data.players
    $scope.joined       = data.joined
    $scope.owned        = data.owned
    $scope.post         = {}

  # Join room
  $scope.join = (id)->
    Room.join id: id, (data)->
      $scope.joined = true
      $scope.totalPlayers += 1

  $scope.redeem = (id)->
    if confirm 'You sure want leave this room?'
      Room.redeem id: id, (data)->
        $scope.joined = false
        $scope.totalPlayers -= 1

  # Post managing
  $scope.createPost = (room_id)->
    Post.save({ text: $scope.post.text, room_id: room_id }, (data)->
      $scope.room.posts.push data
    )
]
