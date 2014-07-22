require 'sinatra/base'

class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, "..", "views") }

	get '/' do
		erb :index
	end

  get '/new_game' do
    erb :new_game
  end

	post '/registration_success' do
	 	@player1name = params[:player1name]
		@player2name = params[:player2name]
		erb :registration_success
	end

	# start the server if ruby file executed directly
	run! if app_file == $0
end