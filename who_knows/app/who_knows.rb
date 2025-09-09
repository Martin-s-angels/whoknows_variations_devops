require 'sinatra'
require 'json'
require 'erb'

set :port, 8080

get '/' do
    content_type:json
    {message: "Hello Frank!"}.to_json
end

