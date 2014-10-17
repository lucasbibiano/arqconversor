require 'sinatra'
require "sinatra/activerecord"
require_relative 'converter/converter'
require_relative 'converter/exchange_service_connector'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}

def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
    require file
  end
end

require_all('./models')

get '/' do
  
  erb :index
end

get '/converte/' do
  @result = Converter.new(params[:de], params[:para], params[:valor]).convert
  erb :index
end