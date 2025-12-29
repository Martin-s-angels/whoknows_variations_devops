# frozen_string_literal: true

require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

require_relative '../app/controller/controller'

use Rack::ForwardedHeaders

use Rack::Protection::HostAuthorization,
    permitted_hosts: [
      'martins-angels.dk',
      'www.martins-angels.dk',
      '172.167.141.167'
    ],
    allow_if: ->(env) { !!env['HTTP_X_FORWARDED_HOST'] }

set :root, '/..'
set :views, 'app/views/templates/'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Sinatra::Application

# fooo barrr
