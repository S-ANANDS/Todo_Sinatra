require 'sinatra'
require 'sinatra/reloader'
get '/' do
  input=params['choice'].to_i

erb :index,locals: {input: input    }
case input
when '1'
 
when '2'
  
when '3'
  
  
when '4'
 
when '5'
 
when '6'
  
when '7'

when '8'
 
else

end


end

