module MetaGraph
  module GraphAccessor
    def read_graph(access_token, data)
      if data.is_a?(Array)
        Collection.new(access_token, data)
      elsif data.is_a?(Hash)
        Node.new(access_token, data)
      else
        data
      end
    end
  end
end
