require 'prometheus/client'

# returns a default registry
prometheus = Prometheus::Client.registry

# create a new messurement: 
# counter counts 
SEARCH_REQUESTS = Prometheus::Client::Counter.new(:total_search_requests, docstring: 'A of searches made')
SEARCH_REQUESTS_NOT_FOUND = Prometheus::Client::Counter.new(:total_search_requests_not_found, docstring: 'A of searches made')
SEARCH_REQUESTS_FOUND = Prometheus::Client::Counter.new(:total_search_requests_found, docstring: 'A of searches made')
#histogram messures time and average 
SEACH_DURATION = Prometheus::Client::Histogram.new(:search_duration_secounds, docstring: 'time spent looking into the db for matches')
#summery makes a average of histogram on all of them i think not implimented yet 

# register the metric
prometheus.register(SEARCH_REQUESTS)
prometheus.register(SEARCH_REQUESTS_NOT_FOUND)
prometheus.register(SEARCH_REQUESTS_FOUND)
prometheus.register(SEACH_DURATION)

#messurement ideers:
#histogram on how long a user is logged in ? 
#how long from register to created user ? 
#db time 