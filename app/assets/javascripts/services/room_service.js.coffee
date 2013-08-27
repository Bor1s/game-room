angular.module('roomService', ['ngResource']).
  factory 'Room', ($resource)->
    $resource('/rest/rooms/:id', {format: 'json'},
      query:
        method: "GET"
        isArray: true
      get:
        method: "GET"
        params: {id: '@id'}
        isArray: false
    )

