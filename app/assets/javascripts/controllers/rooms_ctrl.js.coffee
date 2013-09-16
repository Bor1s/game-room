@RoomsCtrl = ($scope, $http, Room, Paginator) ->
  $scope.paginator = Paginator.init Room, 'rooms', (data, totalPages)->
    $scope.rooms = data
    $scope.totalPages = [1..totalPages]

  $http({method: 'GET', url: '/rest/users'})
    .success (data)->
      $scope.currentUser = data
      #TODO get subscriptions???
      $scope.paginator.getPage(1)
    .error (data)->
      console.log data

  $scope.room =
    title       : null
    description : null

  $scope.create = ()->
    Room.save({ title: $scope.room.title, description: $scope.room.description }, (data)->
      $scope.rooms.push data
      $scope.paginator.getPage(1)
    )

  $scope.drop = (id)->
    Room.delete({id: id}, (data)->
      $scope.rooms = Room.query() #rewrite this to use splice
    )

  $scope.visitPage = (pageNumber)->
    $scope.paginator.getPage(pageNumber)
