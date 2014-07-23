require 'sinatra/base'
require './files'

class BattleShips < Sinatra::Base

	# enable :sessions

	set :views, Proc.new { File.join(root, "..", "views") }

	get '/' do
		# session["user"] ||= nil
		erb :index
	end

	  get '/new_game' do
	    erb :new_game
	    # session[:mesage] = "Hello world!"
	  end

	  post '/registration_success' do
	  	@player_1 = Player.new(:name => params[:name_1], :board => Board.new(content:Water.new))
	  	@player_2 = Player.new(:name => params[:name_2], :board => Board.new(content:Water.new))
	  	# session["user"] = params[:name_1]
	  	# @patrol_	boat = @player_1.ships_to_deploy[0]

	    erb :registration_success
	  end



  # get /:task do
  # 	@task = params[:task]


	# start the server if ruby file executed directly
	run! if app_file == $0
end
