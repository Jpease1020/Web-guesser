require 'sinatra'
require 'sinatra/reloader'

NUMBER = rand(101)
@@counter = 5

get '/' do
  user_guess = params[:guess].to_i
  cheat      = params[:cheat]
  message = check_guess(user_guess, NUMBER, cheat = nil)
  erb :index, locals: { :number => NUMBER,
                        :message => message,
                        :color => @color
                      }
end

def check_guess(user_guess, number, cheat)
  if cheat == "true"
    "Here's the secret number you dirty cheater! #{number}"
  elsif @@counter == 0
    restart
  elsif
    guess_actions(user_guess, number)
  end
end

def guess_actions(user_guess, number)
   if user_guess == 0
       @color = '#FFFFFF'
       "You have #{@@counter} guesses left. Take a Guess!"
   elsif user_guess > number + 5
       @@counter -= 1
       @color = '#FF0000'
       "Way too high!  You have #{@@counter} guesses left "
   elsif user_guess > number
       @@counter -= 1
       @color = "#FF9090"
      "Too high. You have #{@@counter} guesses left"
   elsif user_guess < number - 5
       @@counter -= 1
       @color = '#FF0000'
       "Way too low! You have #{@@counter} guesses left"
   elsif user_guess < number
       @@counter -= 1
       @color = "#FF9090"
       "Too low. You have #{@@counter} guesses left"
   elsif user_guess == number
      @color = "#00FF00"
      new_game
      "The SECRET NUMBER is #{number} You got it right! A new game has begun, have fun playing! "
   end
end

def new_game
  @@counter = 5
  NUMBER
end

def restart
  @color = '#FFFFFF'
  @@counter = 5
  NUMBER
  "You've lost, a new number will be generated and the game will start over."
end
