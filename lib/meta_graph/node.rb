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
    # [resource]     Set *Resource* class instance or hash value. If *Resource*
    #                class instance is set in this argument, _fields_ and
    #                _connections_ in this instance are constructed from resource.
    #                If hash value is set, then it is set to _fields_
    #                variable in this instance.
    #
    def initialize(access_token, resource)
      @access_token = access_token

      if resource.is_a?(Resource)
        @resource = resource
        @fields = resource.fields
        @connections = resource.connections
      else
        @fields = resource
        @connections = {}
      end
    end

    #
    # Get ID of this object. Return nil if this object has no id.
    #
    def id
      return @fields[:id] if @fields.key?(:id)
    end

    #
    # Get connection data as an array. Return nil if this ojbect
    # doesn't have connection specified in _name_ argument.
    #
    # === Argument
    # [name] connection name.
    #
    def connection(name)
      if @connections.key?(name)
        res = Resource.new(@access_token, @connections[name])
        return Collection.new(@access_token, res.data)
      end
    end

    #
    # Check if this object's resource is loaded.
    #
    def load_resource?
      !@resource.nil?
    end

    #
    # Load this object's resource from Facebook Graph API and
    # return it. If resource already has loaded or there is no 
    # object id, this method do nothing.
    # 
    def load_resource
      if id && !load_resource?
        @resource = Resource.new(@access_token, id)
        @fields = @resource.fields
        @connections = @resource.connections
      end

      return @resource
    end

    #
    # Read a field value or connection data. Return nil if you
    # set not exist key name to _key_ argument.
    #
    # === Argument
    # [key] field name or connection name you want to read
    #
    def read(key)
      con = connection(key)
      return con if con

      value = read_hash(key)
      return read_graph(@access_token, value) if value
    end

    #
    # You can access object fields as calling method. When this object
    # has _id_, _name_, _link_, etc, you can access these fields like
    # _object.id_, _object.name_, _object.link_.
    #
    # In addition, if the object has connections, you can access connections
    # as well, then *GraphCollection* instance is returned.
    #
    def method_missing(method, *args, &block)
      data = read(method)
      return data if data

      if !load_resource.nil?
        data = read(method)
        return data if data
      end

      super(method, *args, &block)
    end
  end
end
