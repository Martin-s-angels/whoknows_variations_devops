# frozen_string_literal: true

require 'test/unit'
require 'mocha/test_unit'
require_relative '../../app/controller/controller'

class SearchTest < Test::Unit::TestCase
  def setup
    @mock_conn = mock('PG::Connection')
    Object.send(:define_method, :db_conn) { @mock_conn }
  end

  def test_search_returns_results
    fake_result = [
      { 'title' => 'Test', 'url' => 'https://test.com', 'language' => 'en', 'content' => 'Some content' }
    ]
    @mock_conn.stubs(:exec_params).returns(fake_result)

    results = search('test')
    assert_equal 1, results.size
    assert_equal 'Test', results.first[:title]
  end

  def test_missing_search_inserts_when_no_rows
    fake_select_result = mock('PG::Result')
    fake_select_result.stubs(:ntuples).returns(0)
    @mock_conn.stubs(:exec_params).returns(fake_select_result)

    @mock_conn.expects(:exec_params).with('INSERT INTO pages_not_found (qury) VALUES ($1)', ['not_found_query'])

    missing_search('not_found_query')
  end
end
