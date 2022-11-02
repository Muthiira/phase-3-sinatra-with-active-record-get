class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  get '/games' do
    # get all games from the database
    games = Game.all.order(:title).limit(10)
    # return a json response with an array of all the game data
    games.to_json
  end

    get '/games/:id' do 
      # look uo game in the database using id
      game = Game.find(params[:id])
      # send a json formatted response of the game data
      game.to_json(only: [:id, :title, :genre, :price], include: {
        reviews: { only: [:comment, :score], include: {
          user: { only: [:name] }
        } }
      })  end
end
