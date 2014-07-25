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
		GAME.add player

		session[:player] = player.name

		redirect '/place_ships' if GAME.start?

		erb :waiting_room
	end

	get '/waiting_room' do
		redirect '/place_ships' if GAME.start?
		erb :waiting_room
	end

	get '/place_ships' do
		# if taken to instead of waiting room
		@player = GAME.current_player(session[:player])
		@ships = @player.ships
		@current_ship = @ships.first
		@current_ship_name = @current_ship.class

		redirect "/place_ships/#{@current_ship_name}"

		erb :place_ships
	end

	get '/place_ships/:shipname' do
		@player = GAME.current_player(session[:player])
		@board = @player.board

		erb :place_ships
	end

	post '/place_ships/:shipname' do
		@player = GAME.current_player(session[:player])
		@board = @player.board

		coordinates = params.select{|k,v|v == "on"}.keys

		@current_ship = @player.ships.shift

		@board.place(@current_ship, Coordinates.new(coordinates))

		if params[:shipname] == 'NilClass'
			redirect '/game'
		else
			erb :place_ships
		end
	end

	post '/game' do
		@player = GAME.current_player(session[:player])
		@board = @player.board
		@opponentsboard = GAME.opponent_player(session[:player]).board

		erb :game
	end

	get '/game' do
		@player = GAME.current_player(session[:player])
		@board = @player.board
		@opponentname = GAME.opponent_player(session[:player]).name
		@opponentsboard = GAME.opponent_player(session[:player]).board

		if GAME.my_turn?(@player)
			@message = "It is your turn"
			@refresh = false
		else
			@message = "Please wait for #{@opponentname} to make their move"
			@refresh = true
		end

		erb :game
	end

	post '/shot' do
		@player = GAME.current_player(session[:player])
		@board = @player.board
		@opponentsboard = GAME.opponent_player(session[:player]).board


		if GAME.my_turn?(@player)
			@message = "Shot at #{params[:shoot_at]}!!"
			@player.shoot_at(@opponentsboard, params[:shoot_at])
			@refresh = true

			GAME.countup
		else
			@refresh = false
			@message = "Not your turn!!"
		end

		erb :game
	end

	get '/shot' do
		@player = GAME.current_player(session[:player])
		@board = @player.board
		@opponentname = GAME.opponent_player(session[:player]).name
		@opponentsboard = GAME.opponent_player(session[:player]).board

		if GAME.there_a_victor?
			redirect('/end_game')
		elsif GAME.my_turn?(@player)
			@message = "It is your turn"
			@refresh = false
		else
			@refresh = true
			@message = "Please wait for #{@opponentname} to make their move"
		end

		erb :game
	 end

	 get '/end_game' do
	 	@victor = GAME.get_victor.name
		erb :end_game
	 end

	# start the server if ruby file executed directly
	run! if app_file == $0
end