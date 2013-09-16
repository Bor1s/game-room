angular.module('paginate', []).
  service 'Paginator', ->
    # Init Paginator object with default values and callback on
    # success getPage result
    @init = (resource, root_key, successCallback)=>
      @resource = resource
      @root_key = root_key
      @page = 1
      @successCallback = successCallback || ->
      @

    # Ask Resource to fetch it's entries from the server.
    # On success - write entries in callback
    @getPage = (pageNumber)->
      @resource.query({page: pageNumber || @page}, (data)=>
        @successCallback(data[@root_key], data.total)
      )
