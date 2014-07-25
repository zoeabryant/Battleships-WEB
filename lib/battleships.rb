require 'sinatra/base'
require './files'

class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, "..", "views") }
	set :public_dir, Proc.new { File.join(root, "..", "public") }
	set :session_secret, 'super secret'
	enable :sessions
	GAME = Game.new

	get '/' do
		erb :index
	end

	get '/registration' do
		erb :registration
	end

	post '/waiting_room' do
		player = Player.new(:name => params[:name], :board => Board.new)
		session[:player] = player.name
		GAME.add player

		puts GAME.players

		puts 'post waiting_room'
		puts 'session:'
		puts GAME.current_player(session[:player])
		puts ''
		puts ''
		puts 'first player in GAME'
		puts GAME.players.first
		puts ''
		puts 'last player in GAME'
		puts GAME.players.last

		redirect '/place_ships' if GAME.start?

		erb :waiting_room
	end

	get '/waiting_room' do
		redirect '/place_ships' if GAME.start?

		puts 'get waiting_room'
		puts 'session:'
		puts GAME.current_player(session[:player])
		puts ''
		puts ''
		puts 'first player in GAME'
		puts GAME.players.first
		puts ''
		puts 'last player in GAME'
		puts GAME.players.last

		erb :waiting_room
	end

	get '/place_ships' do
		@player = GAME.current_player(session[:player])
		@ships = GAME.current_player(session[:player]).ships
		@current_ship = @ships.first
		@current_ship_name = @current_ship.class
		redirect "/place_ships/#{@current_ship_name}"


		puts 'get place_ships'
		puts current_ship
		puts 'session:'
		puts GAME.current_player(session[:player])
		puts ''
		puts ''
		puts 'first player in GAME'
		puts GAME.players.first
		puts ''
		puts 'last player in GAME'
		puts GAME.players.last


		erb :place_ships
	end

	get '/place_ships/:shipname' do
		@player = GAME.current_player(session[:player])
		@board = @player.board

		puts 'get place_ships/:shipname'
		puts 'session:'
		puts GAME.current_player(session[:player])
		puts ''
		puts ''
		puts 'first player in GAME'
		puts GAME.players.first
		puts ''
		puts 'last player in GAME'
		puts GAME.players.last

		erb :place_ships
	end

	post '/place_ships/:shipname' do
		# want to place correct ship with grabbed coordinates in params
		@player = GAME.current_player(session[:player])
		coordinates = params.select{|k,v|v == "on"}.keys
		@current_ship = @player.ships.shift
		@board = @player.board


		puts 'post place_ships/:shipname'
		puts @current_ship
		puts 'session:'
		puts @player
		puts 'post place_ships/:shipname'
		puts @current_ship
		puts 'session:'
		puts @player
		puts ''
		puts ''
		puts 'first player in GAME'
		puts GAME.players.first
		puts ''
		puts 'last player in GAME'
		puts GAME.players.last

		@player.board.place(@current_ship, Coordinates.new(coordinates))


		if params[:shipname] == 'NilClass'
			redirect '/game'
		else
			erb :place_ships
		end
	end

	post '/game' do
		@player = GAME.current_player(session[:player])

		puts 'post game'
		puts 'session:'
		puts @player
		puts ''
		puts ''
		puts 'first player in GAME'
		puts GAME.players.first
		puts ''
		puts 'last player in GAME'
		puts GAME.players.last


		@board = @player.board
		@opponentsboard = GAME.opponent_player(session[:player]).board

		erb :game
	end

	get '/game' do
		@player = GAME.current_player(session[:player])

		puts 'get game'
		puts 'session:'
		puts @player
		puts ''
		puts ''
		puts 'first player in GAME'
		puts GAME.players.first
		puts ''
		puts 'last player in GAME'
		puts GAME.players.last



		@board = @player.board
		@opponentsboard = GAME.opponent_player(session[:player]).board
		erb :game
	end

	# start the server if ruby file executed directly
	run! if app_file == $0
end