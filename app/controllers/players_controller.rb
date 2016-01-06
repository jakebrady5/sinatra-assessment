class PlayersController < ApplicationController

  get '/players' do
    redirect_if_not_logged_in
    catch_error
    @players = Player.all
    erb :"players/list"
  end

  get '/players/new' do
    redirect_if_not_logged_in
    catch_error
    erb :"players/new_player"
  end

  post '/players' do
    redirect_if_not_logged_in
    @player = Player.find_by_name(params[:name])
    if @player
      redirect "/players/#{@player.id}/edit?error=Player with that name already exists"
    end
    if params[:name] == "" || params[:age] == "" || params[:experience] == "" || params[:instrument] == ""
      redirect '/players/new?error=Fields cannot be left blank'
    end
    @player = Player.create(name: params[:name], age: params[:age], experience: params[:experience])
    @instrument = Instrument.find_by_name(params[:instrument].capitalize)
    if !@instrument
      @instrument = Instrument.create(name: params[:instrument].capitalize)
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
    catch_error
    @player = Player.find_by_id(params[:id])
    if @player
      erb :"players/show"
    else
      redirect '/players?error=Player ID not found'
    end
  end

  get '/players/:id/edit' do
    redirect_if_not_logged_in
    catch_error
    @player = Player.find_by_id(params[:id])
    if @player
      erb :"players/edit"
    else
      redirect '/players?error=Player ID not found'
    end
  end

  post '/players/:id' do
    redirect_if_not_logged_in
    @player = Player.find_by_id(params[:id])
    if params[:name] == "" || params[:age] == "" || params[:experience] == "" || params[:instrument] == ""
      redirect '/players/new?error=Fields cannot be left blank'
    end
    @player.name = params[:name]
    @player.age = params[:age]
    @player.experience = params[:experience]
    @instrument = Instrument.find_by_name(params[:instrument].capitalize)
    if !@instrument
      @instrument = Instrument.create(name: params[:instrument].capitalize)
      @instrument.save
    end
    @player.instrument_id = @instrument.id
    @player.save
    redirect "/players/#{@player.id}"
  end

  get '/players/:id/delete' do
    redirect_if_not_logged_in
    @player = Player.find_by_id(params[:id])
    @eps = EnsemblePlayer.all
    @eps.each do |a|
      if a.player_id == @player.id
        a.destroy
      end
    end
    @player.destroy
    redirect '/players'
  end

end