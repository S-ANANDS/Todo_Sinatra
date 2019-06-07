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

get '/delete' do
erb :delete
end

post '/delete' do
  user_input=params['id']
  $db.execute 'DELETE FROM Tasks WHERE ID = ?', [user_input]
  redirect '/delete'
  end

get '/search' do
  user_input=params['id']
  erb :select, locals: { db: $db, user_input: user_input }
end

post '/search' do
  user_input=params['id']
  erb :select, locals: { db: $db, user_input: user_input }
  end

  get '/completed' do
    erb :completed
    end
    
    post '/completed' do
      user_input=params['id']
      $db.execute "UPDATE Tasks SET Status = 'Completed' WHERE Id = ? ", [user_input]
      redirect '/completed'
      end

  get '/all' do 
  
  erb :mixture,locals: {db: $db}
  
  
  end
