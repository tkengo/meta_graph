module MetaGraph
  #
  # Resource module provide a function that read a data from Graph API.
  #
  class Resource
    attr_reader :access_token, :api_result

    #
    # Get the HTTP-Client instance to read a data from Graph API.
    #
    def self.http_client
      @http_client ||= HTTPClient.new(:agent_name => 'MetaGraph')
      @http_client
    end

    #
    # Read a data from Graph API and create Resource class instance.
    #
    # About arguments, Please see at _read_ method's description. _initialize_
    # method arguments are same to _read_ method.
    #
    def initialize(access_token, path)
      @access_token = access_token
      @api_raw_result = read(@access_token, path)
      @api_result = JSON.parse(@api_raw_result, :symbolize_names => true)
      @metadata = @api_result.delete(:metadata)
    end

    #
    # read an object specified id from Graph API.
    #
    # === Arguments
    # [path]         Graph API path you want.
    #                For example, when you specified '*me*' to this arg, this module
    #                read your *User* object from Graph API.
    #                Otherwise, when full api url is specified, you will get data
    #                from that url.
    # [access_token] access token to read a data from Graph API.
    #                Please set to oauth's access_token.
    #
    def read(access_token, path)
      path = GRAPH_API_END_POINT + path.to_s unless path.index(GRAPH_API_END_POINT)
      params = {
        :access_token => access_token,
        :metadata => 1
      }

      Resource.http_client.get(path, params).body
    end

    #
    # Get the metadata in Graph API result set. Return empty hash if result
    # set don't contain the metadata.
    #
    def metadata
      @metadata || {}
    end

    #
    # Get a hash that has a key named field name.
    #
    def fields
      fields = {}
      @api_result.each do |key, value|
        fields[key.to_sym] = value
      end
      fields
    end

    #
    # Get a collection data
    #
    def data
      return @api_result[:data] if @api_result.key?(:data)
    end

    #
    # Get an array of connections that has a key named connection name.
    #
    def connections
      connections = {}
      if metadata.key?(:connections)
        metadata[:connections].each do |connection, url|
          connections[connection.to_sym] = url
        end
      end
      connections
    end
  end
end
