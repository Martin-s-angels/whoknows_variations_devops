# frozen_string_literal: true

require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

require_relative '../app/controller/controller'
require 'rack/protection'

# use Rack::Protection, except: 'martins-angels.dk'

# use Rack::ForwardedHeaders
#
set :root, '/..'
set :views, 'app/views/templates/'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Sinatra::Application

# fooo barrr
