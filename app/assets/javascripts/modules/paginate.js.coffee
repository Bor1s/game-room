angular.module('paginate', []).
  service 'Paginator', ->
    that = @
    # Init Paginator object with default values
    that.init = (resource)->
      that.resource = resource
      that.root_key = "rooms"
      that.page = 1
      that

    # Ask Resource to fetch it's entries from the server.
    # On success - write entries in callback
    that.getPage = (pageNumber, success)->
      that.resource.query({page: pageNumber || that.page}, (data)->
        success(data[that.root_key], data.total)
      )
