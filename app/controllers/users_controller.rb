class UsersController < ApplicationController

  get '/signup' do
    catch_error
    if logged_in?
      redirect "/ensembles?error=Please log out before signing up"
    end
    erb :"users/signup"
  end

  post '/signup' do
    @user = User.find_by_username(params[:username])
    if !@user
      @user = User.create(username: params[:username], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/ensembles'
    else
      redirect '/login?error=Username already exists'
    end
  end

  get '/login' do
    catch_error
    if logged_in?
      redirect "/ensembles?error=You are already logged in"
    end
    erb :"users/login"
  end

  post '/login' do
    @user = User.find_by_username(params[:username])
    if !@user
      redirect '/signup?error=Username not found'
    end
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/ensembles'
    else
      redirect '/login?error=Password did not match that of the given username'
    end
  end

  get '/logout' do
    session.destroy
    redirect '/'
  end

end