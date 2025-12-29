# frozen_string_literal: true

require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

require_relative '../app/controller/controller'

ENV['APP_ENV'] = 'production'

use Rack::Protection::HostAuthorization, permitted_hosts: [
  'martins-angels.dk',
  'www.martins-angels.dk',
  '172.167.141.167'
]
use Rack::Protection::HostAuthorization, ip_hosts: [
  '172.167.141.167'
]

use Rack::Protection::HostAuthorization, domain_hosts: [
  'martins-angels.dk',
  'www.martins-angels.dk'
]

set :root, '/..'
set :views, 'app/views/templates/'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Sinatra::Application

# fooo barrr
