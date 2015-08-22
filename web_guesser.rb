require 'sinatra'
require 'sinatra/reloader'

NUMBER = rand(101)
@@counter = 5

get '/' do
  user_guess = params[:guess].to_i
  message = check_guess(user_guess, NUMBER)
  erb :index, locals: { :number => NUMBER, :message => message, :color => @color }
end

def check_guess(user_guess, number)
  @@counter -= 1
   if user_guess == 0 && @@counter > 0
     if @@counter == 0
       restart
     else
       @color = '#FFFFFF'
       "Take a Guess!"
     end
   elsif user_guess > number + 5 && @@counter > 0
     if @@counter == 0
       restart
     else
       @color = '#FF0000'
       "Way too high!"
     end
   elsif user_guess > number && @@counter > 0
     if @@counter == 0
       restart
     else
       @color = "#FF9090"
      "Too high"
     end
   elsif user_guess < number - 5 && @@counter > 0
     if @@counter == 0
       restart
     else
       @color = '#FF0000'
       "Way too low!"
     end
   elsif user_guess < number && @@counter > 0
     if @@counter == 0
       restart
     else
       @color = "#FF9090"
       "Too low!"
     end
   elsif user_guess == number && @@counter > 0
      @color = "#00FF00"
      "The SECRET NUMBER is #{number} You got it right!"
   end
end

def restart
  @color = '#FFFFFF'
  @@counter = 5
  Number
  "You've lost, a new number will be generated and the game will start over."
end
