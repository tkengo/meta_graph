require 'bundler/setup'
require 'httpclient'
require 'json'

require 'meta_graph/hash_accessor'
require 'meta_graph/graph_accessor'
require 'meta_graph/client'
require 'meta_graph/resource'
require 'meta_graph/node'
require 'meta_graph/collection'

module MetaGraph
  #
  # GraphAPI based URL
  #
  GRAPH_API_END_POINT = 'https://graph.facebook.com/'
end
