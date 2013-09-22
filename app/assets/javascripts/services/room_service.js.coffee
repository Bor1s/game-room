angular.module('roomService', ['ngResource']).
  factory 'Room', ($resource)->
    $resource('/rest/rooms/:id', {format: 'json'},
      query:
        method: "GET"
        isArray: false
      get:
        method: "GET"
        params: {id: '@id'}
        isArray: false
      update:
        method: 'PUT'
        params: {id: '@id'}
        isArray: false
    )

