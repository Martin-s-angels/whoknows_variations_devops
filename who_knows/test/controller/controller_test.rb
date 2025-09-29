ENV['APP_ENV'] = 'test'
require_relative '../../app/controller/controller'

#require_relative '../../who_knows'
require 'test/unit'
require 'rack/test'

set :views, "/app/view/templates" #here??

# set :port, 8081 # maybe change? or not...

class DemoTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def testEndpointTest # /test
    #get '/?q=test'
    #get '/test'

    get '/'

    assert last_response.ok?
    assert_equal "Hello World", last_response.body

    assert_equal 2+2, 4
  end
  
end

=begin
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

=end
