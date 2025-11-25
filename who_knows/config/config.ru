require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

require_relative '../app/controller.rb'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Sinatra::Application 