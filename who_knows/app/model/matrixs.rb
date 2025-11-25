require 'prometheus/client'

# returns a default registry
prometheus = Prometheus::Client.registry

# create a new counter metric
SEARCH_REQUESTS = Prometheus::Client::Counter.new(:search_requests, docstring: 'A of searches made')
# register the metric
prometheus.register(SEARCH_REQUESTS)

# start using the counter
