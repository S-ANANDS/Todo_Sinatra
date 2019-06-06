# frozen_string_literal: true

require 'net/http'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

get '/' do
  erb :index
end

$db = SQLite3::Database.open('Todo.db')
$db.execute 'CREATE TABLE IF NOT EXISTS Tasks(Id INTEGER PRIMARY KEY,Name VARCHAR,Status TEXT)'

get '/add' do
  erb :one
end

post '/add' do
  @value = params['task']
  @state = params['status']
  uri = URI('https://www.purgomalum.com/service/containsprofanity?text='"#{@value}")
  response = Net::HTTP.get(uri)
  if response == 'false'
    $db.execute 'INSERT INTO Tasks(Id,Name,Status) VALUES (NULL,?,?)', [@value, @state]
  else
    redirect '/profanity'
  end
  redirect '/'
end

get '/profanity' do
  erb :pro
end

get '/result' do
  erb :data, locals: { db: $db }
end

delete '/' do
end
patch '/' do
end

# http://www.purgomalum.com/
# If user input is
# If user inpput has profanity, reject it.
