require 'sinatra'
require 'sinatra/reloader'
set :sessions, true

X = rand(100)

def check_guess(guess)
	if !(guess)
		return ''
	elsif guess.to_i >= X + 5
		return "Way too high!"
	elsif guess.to_i > X && guess.to_i < X + 5
		return "Too High!"
	elsif guess.to_i <= X - 5
		return "Way too low!"
	elsif guess.to_i < X && guess.to_i > X - 5
		return "Too low!"
	else
		return "You got it! The Secret Number was #{X}"
	end
end

get '/' do 
	guess = params["guess"]
	message = check_guess(guess)
	erb :index, :locals => {:x => X, :message => message}
end