@RoomsCtrl = ($scope, $http, Room) ->
  $http({method: 'GET', url: '/rest/users'})
    .success (data)->
      $scope.currentUser = data
      $scope.rooms = Room.query()
      #TODO get subscriptions???
    .error (data)->
      console.log data

  $scope.room =
    title       : null
    description : null

  $scope.create = ()->
    Room.save({ title: $scope.room.title, description: $scope.room.description }, (data)->
      $scope.rooms.push data
    )

  $scope.drop = (id)->
    Room.delete({id: id}, (data)->
      $scope.rooms = Room.query() #rewrite this to use splice
    )
