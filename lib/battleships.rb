require 'sinatra/base'
require './files'

class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, "..", "views") }
	enable :sessions
	GAME = Game.new

	get '/' do
		puts GAME.players.inspect
		erb :index
	end

	get '/registration' do
		erb :registration
	end

	post '/place_ships' do
		session[:player] = Player.new(:name => params[:name], :board => Board.new)
		GAME.add session[:player]
		# puts GAME.start?
		# "Waiting for another player..." unless GAME.start?
		erb :place_ships
	end

	get '/grid' do
		@board = Board.new
		erb :grid
	end



	# start the server if ruby file executed directly
	run! if app_file == $0
end