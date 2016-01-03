class EnsemblesController < ApplicationController

  get '/ensembles' do
    @error_message = params[:error]
    erb :"ensembles/list"
  end

  get '/ensembles/new' do
  end

  post '/ensembles' do
  end

  get '/ensembles/:id' do
  end

  get '/ensembles/:id/edit' do
  end

  post '/ensembles/:id' do
  end

  get '/ensembles/:id/delete' do
  end

end