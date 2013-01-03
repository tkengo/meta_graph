require 'webmock/rspec'
require 'meta_graph'

module MetaGraph
  RSPEC_ACCESS_TOKEN = 'This is dummy access token.'
end

def regist_mock(path, method = :get)
  url = MetaGraph::GRAPH_API_END_POINT + path.to_s

  query = {
    access_token: MetaGraph::RSPEC_ACCESS_TOKEN,
    metadata: 1
  }

  body = open(File.dirname(__FILE__) + "/json/#{path}.json", 'r').read

  stub_request(method, url).with(query: query).to_return(body: body)
end
