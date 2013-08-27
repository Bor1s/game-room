@RoomsCtrl = ($scope, Room) ->
  $scope.rooms = Room.query()

  $scope.create = ()->
    Room.save({ title: 'foobar', description: 'foobar' }, (data)->
      $scope.rooms.push data
    )

  $scope.drop = (id)->
    Room.delete({id: id}, (data)->
      $scope.rooms = Room.query() #rewrite this to use splice
    )
