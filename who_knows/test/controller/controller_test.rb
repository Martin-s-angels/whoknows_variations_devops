# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'test/unit'
require 'rack/test'
require 'mocha/test_unit'
require 'pg'
require_relative '../../app/controller/controller'

# set :views, '../../app/view/templates' # works for now.

# base_url = "localhost:8080"

# class DemoTest < Test::Unit::TestCase
# include Rack::Test::Methods

# def test_search_endpoint
# get '/', { q: 'test' } # Mock web layer

# assert last_response.ok?
# assert last_response.body.include?('Mocked result')
# end
# end

# class HelloWorldTest < Test::Unit::TestCase
#   include Rack::Test::Methods
#
#   def app
#     Sinatra::Application
#   end
#
#   def test_it_says_hello_world
#     get '/'
#     assert last_response.ok?
#     assert_equal 'Hello World', last_response.body
#   end
#
#   def test_it_says_hello_to_a_person
#     get '/', :name => 'Simon'
#     assert last_response.body.include?('Simon')
#   end
# end
#
