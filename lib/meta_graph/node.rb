module MetaGraph
  #
  # Node class presents Facebook object which is *User*, *Photo*,
  # *Album*, *Comment*, and so on.
  #
  class Node
    include HashAccessor, GraphAccessor

    hash_accessor :fields

    #
    # Create Node instance from a object that read in *Resource* class
    # instance. Through this class, you can read every fields in a object
    # by accessing to field name such like _obj.id_, _obj.username_.
    #
    # === Arguments
    # [access_token] access token to read a data from Graph API.
    #                Please set to oauth's access_token.
    # [fields]       Fields of Graph API object.
    # [connections]  If object has connections, it should be set in this
    #                argument.
    #
    def initialize(access_token, fields, connections = {})
      @access_token = access_token
      @fields = fields
      @connections = connections
    end

    #
    # You can access object fields as calling method. When this object
    # has _id_, _name_, _link_, etc, you can access _object.id_, _object.name_,
    # _object.link_.
    #
    # In addition, if the object has connections, you can access connections
    # as well, then *GraphCollection* instance is returned.
    #
    def method_missing(method, *args, &block)
      if @connections.key?(method)
        resource = Resource.new(@access_token, @connections[method])
        return Collection.new(@access_token, resource.api_result[:data])
      end

      field = super(method, *args, &block)
      return read_graph(@access_token, field) if field
    end
  end
end
