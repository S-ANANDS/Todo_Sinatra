require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

get '/' do
  input=params['choice'].to_i
  erb :index,locals: {input: input    }
end
 
get '/add' do 
  
  db=SQLite3::Database.open('todo.db')
  db.execute 'CREATE TABLE IF NOT EXISTS Tasks(Name VARCHAR)'
  value=params['task']
  input=params['choice'].to_i
  erb :one,locals: {input: input ,value: value   }
  db.execute "INSERT INTO Tasks (Name) VALUES (?)",[value]
end
