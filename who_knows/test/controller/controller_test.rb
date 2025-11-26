ENV['APP_ENV'] = 'test'

require 'test/unit'
require 'rack/test'

require_relative '../../app/controller/controller'
set :views, "../../app/view/templates" # works for now.

# base_url = "localhost:8080"

class DemoTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_search_endpoint
    get '/', params= {q: 'test'}#Mock web layer
    
    assert last_response.ok?
    assert last_response.body.include?('search') #last_response.body is the full html file.

    #puts last_response.body #remove
    #assert_equal 'test', last_response.body #remove

    assert_equal 2+2, 4 #regular unit testing #remove.
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
