angular.module('roomService', ['ngResource']).
  factory 'Room', ($resource)->
    $resource('/rest/rooms/:id/:action', {format: 'json'},
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
      join:
        method: 'PUT'
        params:
          id: '@id'
          action: 'join'
        isArray: false
      leave:
        method: 'PUT'
        params:
          id: '@id'
          action: 'leave'
        isArray: false
    )

