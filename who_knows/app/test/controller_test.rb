#ENV['APP_ENV'] = 'test'

require_relative '../src/controller/controller'
require 'test/unit'
require 'rack/test'

require 'sinatra'
require 'json'
require 'erb'
require 'dotenv/load'

set :port, 8081

class HelloWorldTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_hello_world
    get '/'
    assert last_response.ok?
    assert_equal 'Hello World', last_response.body
  end

  def test_it_says_hello_to_a_person
    get '/', :name => 'Simon'
    assert last_response.body.include?('Simon')
  end
end

