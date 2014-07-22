require 'sinatra/base'
require './files'

class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, "..", "views") }

	get '/' do
		erb :index
	end

  get '/registration' do
    erb :registration
  end

	post '/registration_success' do
		@player1 = Player.new(:name => params[:player1], :board => Board.new)
		@player2 = Player.new(:name => params[:player2], :board => Board.new)
		erb :registration_success
	end

	get '/place_ships' do
		erb :place_ships
	end



	# start the server if ruby file executed directly
	run! if app_file == $0
end