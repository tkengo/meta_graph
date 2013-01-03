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
      # @access_token = 'AAAID6yj9MNUBADYun1fW1WDQRAxZB8DD8TjmBJxD5ZAYqZBt3n2ADJfmO3VeV6Svkkog4GZB08vYknGzKJcWbA3onfGTqO38XwzpESHJxAZDZD'
      @access_token = access_token
    end

    #
    # Get a data from Graph API.
    #
    # === Argument
    # [path] ID you want or full URL.
    #
    def get(path)
      resource = Resource.new(@access_token, path.to_s)
      Node.new(@access_token, resource.fields, resource.connections)
    end

    #
    # Get a your *User* data from Graph API. It equals to get('me').
    #
    def me
      get(:me)
    end
  end
end
