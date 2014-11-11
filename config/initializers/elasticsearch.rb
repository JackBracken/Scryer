# Connect to specific Elasticsearch cluster
ELASTICSEARCH_URL = ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'
$elasticsearch = Elasticsearch::Client.new host: ELASTICSEARCH_URL

#$elasticsearch.transport.reload_connections!


# Print Curl-formatted traces in development into a file
#

if Rails.env.development?
  tracer = ActiveSupport::Logger.new('log/elasticsearch.log')
  tracer.level =  Logger::DEBUG
end
$elasticsearch.transport.tracer = tracer
