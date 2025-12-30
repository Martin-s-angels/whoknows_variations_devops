require 'test/unit'
require 'rack/test'
require_relative '../../app/controller/controller'

ENV['APP_ENV'] = 'test'

class IntegrationTests < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    db_conn.exec('DELETE FROM pages;')
    db_conn.exec('DELETE FROM pages_not_found;')
  end

  def test_search_endpoint
    db_conn.exec("INSERT INTO pages (title, url, language, content) VALUES ('Hello', 'http://hello.com', 'en', 'world')")

    get '/', q: 'Hello'

    assert last_response.ok?
    assert last_response.body.include?('Hello')
  end

  def test_missing_search_endpoint
    get '/', q: 'MissingPage'

    result = db_conn.exec("SELECT * FROM pages_not_found WHERE qury = 'MissingPage'")
    assert_equal 1, result.ntuples
  end
end
