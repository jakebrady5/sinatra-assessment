class EnsemblesController < ApplicationController

  get '/ensembles' do
    redirect_if_not_logged_in
    catch_error
    @ensembles = Ensemble.all
    @user = current_user
    erb :"ensembles/list"
  end

  get '/ensembles/new' do
    redirect_if_not_logged_in
    erb :"ensembles/new_ensemble"
  end

  post '/ensembles' do
    redirect_if_not_logged_in
    @ensemble = Ensemble.create(name: params[:name], city: params[:city])
    @ensemble.user_id = current_user.id
    @ensemble.save
    redirect "/ensembles/#{@ensemble.id}"
  end

  get '/ensembles/:id' do
    redirect_if_not_logged_in
    @ensemble = Ensemble.find_by_id(params[:id])
    if @ensemble.user_id != current_user.id
      redirect '/ensembles?error=Requested ensemble is not under your user domain'
    end
    @players = @ensemble.players
    if @ensemble
      erb :"ensembles/show"
    else
      redirect '/ensembles?error=Ensemble ID not found'
    end
  end

  get '/ensembles/:id/add_to' do
    redirect_if_not_logged_in
    @ensemble = Ensemble.find_by_id(params[:id])
    @players = Player.all
    @players = @players.drop_while{|a| @ensemble.players.include?(a)}
    if current_user.id == @ensemble.user_id
      erb :"ensembles/add_players"
    else
      redirect '/ensembles?error=This ensemble is not under your management'
    end
  end

  post '/ensembles/:id/add_to' do
  end

  get '/ensembles/:id/edit' do
  end

  post '/ensembles/:id' do
  end

  get '/ensembles/:id/delete' do
  end

end