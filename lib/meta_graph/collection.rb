module MetaGraph
  #
  # *Collection* class presents an array data in Facebook Graph API.
  #
  class Collection
    include GraphAccessor
    include Enumerable

    #
    # Create *Collection* instance from an array.
    #
    # === Arguments
    # [access_token] access token to read a data from Graph API.
    #                Please set to oauth's access_token.
    # [collection]   An array of collection data.
    #
    def initialize(access_token, collection)
      @access_token = access_token
      @collection = collection
    end

    def [](index)
      read_graph(@access_token, @collection[index])
    end

    def each
      @collection.each_with_index do |value, index|
        yield self[index]
      end
    end
  end
end
