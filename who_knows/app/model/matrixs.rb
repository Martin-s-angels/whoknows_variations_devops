require 'prometheus/client'

# returns a default registry
prometheus = Prometheus::Client.registry

# create a new counter metric
SEARCH_REQUESTS = Prometheus::Client::Counter.new(:total_search_requests, docstring: 'A of searches made')
SEARCH_REQUESTS_NOT_FOUND = Prometheus::Client::Counter.new(:total_search_requests, docstring: 'A of searches made')
SEACH_DURATION = Prometheus::Client::Histogram.new(:service_latency_seconds, docstring: '...', labels: [:service])

# register the metric
prometheus.register(SEARCH_REQUESTS)
prometheus.register(SEARCH_REQUESTS_NOT_FOUND)


# start using the counter
