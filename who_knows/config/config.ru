require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

require_relative '../app/controller/controller.rb'

set :root, '/..'
set :views, "app/views/templates/"

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Sinatra::Application 