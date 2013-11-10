angular.module('postService', ['ngResource']).
  factory 'Post', ($resource)->
    $resource('/rest/posts/:id/:action', {format: 'json'},
      query:
        method: "GET"
        isArray: false
      get:
        method: "GET"
        params: {id: '@id'}
        isArray: false
      edit:
        method: "GET"
        params:
          id: '@id'
          action: 'edit'
        isArray: false
      update:
        method: 'PUT'
        params: {id: '@id'}
        isArray: false
    )

