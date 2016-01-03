require 'spec_helper'

describe "Model Associations" do
  before do

    #sequence of assignment seemed overly touchcy, potential for bugs to still exist in relations

    @user = User.create(username: "Leonard", password: "caramelappletini")
    @ensemble = Ensemble.create(name: "The Orange Peels", city: "Boston", user_id: @user.id)
    @instrument = Instrument.create(name: "trumpet")
    @player = Player.create(name: "Rafael", age: "25", experience: "professional", instrument_id: @instrument.id)
    @ensemble_player = EnsemblePlayer.create(ensemble_id: @ensemble.id, player_id: @player.id)
  end

  it "Users can have Ensembles" do
    expect(@user.ensembles.count).to eq(1)
    expect(@user.ensembles.first.name).to eq("The Orange Peels")
  end

  it "Ensembles can have Players" do
    expect(@ensemble.players.count).to eq(1)
    expect(@ensemble.players.first.name).to eq("Rafael")
  end

  it "Ensembles can have Instruments" do
    expect(@ensemble.instruments.count).to eq(1)
    expect(@ensemble.instruments.first.name).to eq("trumpet")
  end

  it "Players can have an Instrument" do
    expect(@player.instrument.name).to eq("trumpet")
  end

end