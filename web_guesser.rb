require 'sinatra'
require 'sinatra/reloader'
set :sessions, true

X = rand(100)
bgcolor = 'white'

def check_guess(guess)
	if !(guess)
		return ''
	elsif guess.to_i >= X + 5
		return ["Way too high!", 'red']
	elsif guess.to_i > X && guess.to_i < X + 5
		return ["Too High!", 'pink']
	elsif guess.to_i <= X - 5
		return ["Way too low!", 'red']
	elsif guess.to_i < X && guess.to_i > X - 5
		return ["Too low!", 'pink']
	else
		return ["You got it! The Secret Number was #{X}", 'green']
	end
end

get '/' do 
	guess = params["guess"]
	result = check_guess(guess)
	message = result[0]
	bgcolor = result[1]
	erb :index, :locals => {:x => X, :message => message, :bgcolor => bgcolor}
end