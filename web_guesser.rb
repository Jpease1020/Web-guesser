require 'sinatra'
require 'sinatra/reloader'


@@number = rand(100)
@@counter = 5

get '/' do
  user_guess = params[:guess].to_i
  cheat      = params[:cheat]
  message    = check_guess(user_guess, cheat)
  erb :index, locals: { :number => @number,
                        :message => message,
                        :color => @color }
end

def check_guess(user_guess, cheat)
  if cheat == "true"
    "Here is the number you dirty cheater #{@@number}"
  else

    guess_actions(user_guess)
  end
end

def guess_actions(user_guess)
  number = @@number
  if @@counter == 0
    @color = '#FFFFFF'
    @@counter = 5
    @@number = rand(100)
    "You've lost, a new number will be generated and the game will start over."
  elsif user_guess == 0
    @@counter -= 1
    @color = '#FFFFFF'
    "You have #{@@counter + 1} guesses left. Take a Guess!"
  elsif user_guess > number + 5
    @@counter -= 1
    @color = '#FF0000'
    "Way too high!  You have #{@@counter + 1} guesses left "
  elsif user_guess > number
    @@counter -= 1
    @color = "#FF9090"
    "Too high. You have #{@@counter + 1} guesses left"
  elsif user_guess < number - 5
    @@counter -= 1
    @color = '#FF0000'
    "Way too low! You have #{@@counter + 1} guesses left"
  elsif user_guess < number
    @@counter -= 1
    @color = "#FF9090"
    "Too low. You have #{@@counter + 1} guesses left"
  elsif user_guess == number
    @color = "#00FF00"
    @@counter = 5
    @@number = rand(100)
    "The SECRET NUMBER is #{number} You got it right! A new game has begun, have fun playing! "
  end
end
