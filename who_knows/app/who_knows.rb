require 'sinatra'
require 'json'


set :port, 8080

get '/' do
    content_type:json
    {message: "Hello Frank!, why "}.to_json
end

