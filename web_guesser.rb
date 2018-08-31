require 'sinatra'
require 'sinatra/reloader'
set :sessions, true

@@X = rand(100)
bgcolor = 'white'
@@guesses = 5



def check_guess(guess)
	message = ''
	case
	when !(guess)
		values = ['Guess my secret number!', 'white']
	when guess.to_i >= @@X + 5
		@@guesses -= 1
		values = ['Way too high!', 'red']
	when guess.to_i > @@X && guess.to_i < @@X + 5
		@@guesses -= 1
		values = ['Too high!', 'pink']
	when guess.to_i <= @@X - 5
		@@guesses -= 1
		values = ['Way too low!', 'red']
	when guess.to_i < @@X && guess.to_i > @@X - 5
		@@guesses -= 1
		values = ['Too low!', 'pink']
	else
		values = ['You got it!', 'green']
	end
	unless @@guesses == 0
		return values
	else
		@@guesses = 5
		@@X = rand(100)
		values = ["That's too bad, you didn't guess my number. I'll pick a new one.", 'gray']
		return values
	end
end

get '/' do 
	guess = params["guess"]
	result = check_guess(guess)
	message = result[0]
	bgcolor = result[1]
	erb :index, :locals => {:x => @@X, :message => message, :bgcolor => bgcolor}
end