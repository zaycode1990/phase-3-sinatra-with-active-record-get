class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/games' do
      # get all the games from the database
      games = Game.all.order(:title).limit(10)
      # return a JSON response with an array of all the game data
      games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end


  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(include: :reviews)
end

  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(include: { reviews: { include: :user } })

  end

end
