
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

get '/' do
  
  erb :index
end




$db=SQLite3::Database.open('Todo.db')
$db.execute 'CREATE TABLE IF NOT EXISTS Tasks(Id INTEGER PRIMARY KEY,Name VARCHAR,Status TEXT)'

get '/add' do
  erb :one
end

post '/add' do
  @value = params['task']
  @state=params['status']
  $db.execute "INSERT INTO Tasks(Id,Name,Status) VALUES (NULL,?,?)", [@value,@state]
redirect '/'
end

get '/result' do

erb :data ,locals:{db: $db}
end





delete '/' do
end
patch '/' do
end

# http://www.purgomalum.com/
# If user input is
# If user inpput has profanity, reject it.