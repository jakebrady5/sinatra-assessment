class PlayersController < ApplicationController

  get '/players' do
    redirect_if_not_logged_in
    catch_error
    erb :"players/list"
  end

  get '/players/new' do
    redirect_if_not_logged_in
    erb :"players/new_player"
  end

  post '/players' do
    @player = Player.create(name: params[:name], age: params[:age], experience: params[:experience])
    # add instrument
    @player.save
  end

  get '/players/:id' do
    redirect_if_not_logged_in
    @player = Player.find_by_id(params[:id])
    if @player
      erb :"players/show"
    else
      redirect '/players?error=Player ID not found'
  end

  get '/players/:id/edit' do
  end

  post '/players/:id' do
  end

  get '/players/:id/delete' do
  end

end