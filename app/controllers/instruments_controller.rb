class InstrumentsController < ApplicationController

  get '/instruments' do
    redirect_if_not_logged_in
    @instruments = Instrument.all
    erb :"instruments/list"
  end

end