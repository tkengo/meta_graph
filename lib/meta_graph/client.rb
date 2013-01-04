module MetaGraph
  #
  # Graph API Client class.
  #
  # To get a user data, photo data, album data, and so on from Facebook's
  # Graph API. First, create this client and call the _get_ method, then
  # you can get a instance of Node class.
  #
  class Client
    attr_reader :access_token

    #
    # Create and initialize Graph API Client.
    #
    # === Argument
    # [access_token] access token to read a data from Graph API.
    #                Please set to oauth's access_token.
    #
    def initialize(access_token)
      @access_token = access_token
    end

    #
    # Get a data from Graph API.
    #
    # === Argument
    # [path] ID you want or full URL.
    #
    def fetch(path)
      resource = Resource.new(@access_token, path.to_s)

      if resource.data && resource.data.is_a?(Array)
        Collection.new(@access_token, resource.data)
      else
        Node.new(@access_token, resource)
      end
    end

    #
    # Get a your *User* data from Graph API. It equals to fetch('me').
    #
    def me
      fetch(:me)
    end
  end
end
