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

		puts 'post waiting room'
		puts GAME.start?

		redirect '/place_ships' if GAME.start?

		erb :waiting_room
	end

	get '/waiting_room' do
		redirect '/place_ships' if GAME.start?

		puts 'gets waiting room'
		puts GAME.start?

		erb :waiting_room
	end

	get '/place_ships' do
		@ships = session[:player].ships
		@current_ship = @ships.first
		@current_ship_name = @current_ship.class
		redirect "/place_ships/#{@current_ship_name}"

		erb :place_ships
	end

	get '/place_ships/:shipname' do
		@board = session[:player].board
		erb :place_ships
	end

	post '/place_ships/:shipname' do
		# want to place correct ship with grabbed coordinates in params
		coordinates = params.select{|k,v|v == "on"}.keys
		@current_ship = session[:player].ships.shift
		@board = session[:player].board
		session[:player].board.place(@current_ship, Coordinates.new(coordinates))
		if params[:shipname] == 'NilClass'
			redirect '/game'
		else
			erb :place_ships
		end
	end

	post '/game' do
		@board = session[:player].board
		@opponentsboard = GAME.players.last.board
		erb :game
	end

	get '/game' do
		@board = session[:player].board
		@opponentsboard = GAME.players.last.board
		erb :game
	end

	# start the server if ruby file executed directly
	run! if app_file == $0
end