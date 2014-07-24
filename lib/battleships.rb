require 'sinatra/base'
require './files'

class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, "..", "views") }
	set :public_dir, Proc.new { File.join(root, "..", "public") }
	enable :sessions
	GAME = Game.new

	get '/' do
		puts GAME.players.inspect
		erb :index
	end

	get '/registration' do
		erb :registration
	end

	post '/waiting_room' do
		session[:player] = Player.new(:name => params[:name], :board => Board.new)
		GAME.add session[:player]

		redirect '/place_ships' if GAME.start?

		erb :waiting_room
	end

	get '/waiting_room' do
		redirect '/place_ships' if GAME.start?

		erb :waiting_room
	end

	get '/place_ships' do
		@board = session[:player].board
		erb :grid
	end

	# start the server if ruby file executed directly
	run! if app_file == $0
end