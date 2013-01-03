module MetaGraph
  module GraphAccessor
    def read_graph(access_token, data)
      if data.is_a?(Array)
        Collection.new(access_token, data)
      elsif data.is_a?(Hash)
        if data.key?(:id)
          resource = Resource.new(access_token, data[:id])
          Node.new(access_token, resource.fields, resource.connections)
        else
          Node.new(access_token, data)
        end
      else
        data
      end
    end
  end
end
