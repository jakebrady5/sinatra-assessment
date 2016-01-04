class PlayersController < ApplicationController

  get '/players' do
    redirect_if_not_logged_in
    catch_error
    @players = Player.all
    erb :"players/list"
  end

  get '/players/new' do
    redirect_if_not_logged_in
    erb :"players/new_player"
  end

  post '/players' do
    redirect_if_not_logged_in
    @player = Player.find_by_name(params[:name])
    if @player
      redirect "/players/#{@player.id}/edit?error=Player with that name already exists"
    end
    @player = Player.create(name: params[:name], age: params[:age], experience: params[:experience])
    @instrument = Instrument.find_by_name(params[:instrument])
    if !@instrument
      @instrument = Instrument.create(name: params[:instrument])
      @instrument.save
    end
    @player.instrument_id = @instrument.id
    @player.save
    if params[:submit] == "save many"
      redirect '/players/new'
    else
      redirect '/players'
    end
  end

  get '/players/:id' do
    redirect_if_not_logged_in
    @player = Player.find_by_id(params[:id])
    if @player
      erb :"players/show"
    else
      redirect '/players?error=Player ID not found'
    end
  end

  get '/players/:id/edit' do
    catch_error
  end

  post '/players/:id' do
  end

  get '/players/:id/delete' do
  end

end