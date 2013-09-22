@RoomsCtrl = ($scope, $http, Room, Paginator) ->
  $scope.paginator = Paginator.init Room, 'rooms', (data, totalPages)->
    $scope.rooms = data
    $scope.totalPages = if totalPages > 1 then [1..totalPages] else undefined

  $http({method: 'GET', url: '/rest/users'})
    .success (data)->
      $scope.currentUser = data
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
    if confirm?('You sure?')
      Room.remove({id: id}, (data)->
        $scope.paginator.getPage(1)
      )

  $scope.visitPage = (pageNumber)->
    $scope.paginator.getPage(pageNumber)
