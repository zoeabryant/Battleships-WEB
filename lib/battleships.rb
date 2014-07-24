require 'sinatra/base'
require './files'

class BattleShips < Sinatra::Base

	enable :sessions
	GAME = Game.new

	set :views, Proc.new { File.join(root, "..", "views") }
	set :public_folder, Proc.new { File.join(root, "..", "public")}

	get '/' do
		puts GAME.players.inspect
		erb :index
	end

	  get '/new_game' do
	    erb :new_game
	  #   	if GAME.start?
		 #  		"ARM THE BAZOOKA!"
		 #  	else
			# 	erb :index
			# end
	    # session[:mesage] = "Hello world!"
	  end

	  get '/restart' do
	  	GAME.restart
	  	redirect to('/')
	  end

	  post '/registration_success' do
	  	session[:me] = Player.new(:name => params[:name_1], :board => Board.new(content:Water.new))
	  	GAME.add session[:me]
	  	puts params[:name_1]
	  	unless GAME.start?
	  		redirect to ('/new_game')
	  	end
	    erb :registration_success
	  end


	# start the server if ruby file executed directly
	run! if app_file == $0
end
