require 'spec_helper'

describe "Ensemble Behavior" do

  before do
    @user = User.create(username: "Waldo", password: "blendin")
    @user2 = User.create(username: "Elroy", password: "chickenhawk")
    @ensemble = Ensemble.create(name: "Awesome Orchestra Collective", city: "Honolulu", user_id: @user.id)
    @ensemble2 = Ensemble.create(name: "City Center Combo", city: "Gotham", user_id: @user2.id)
    @player = Player.create(name: "Bella Bartok", age: 99, experience: "Mountain Hermit Master")
    @player.save
    @player2 = Player.create(name: "Marvin Martian", age: 375, experience: "intergalactic")
    @player2.save
  end

  it "/players shows all players" do
    visit '/login'
    fill_in(:username, :with => "Elroy")
    fill_in(:password, :with => "chickenhawk")
    click_button 'Log In'

    visit '/players'
    expect(page.body).to include("Bella Bartok")
    expect(page.body).to include("Marvin Martian")
  end

  it "/players/new adds a player to database" do
    visit '/login'
    fill_in(:username, :with => "Elroy")
    fill_in(:password, :with => "chickenhawk")
    click_button 'Log In'

    visit '/players/new'
    fill_in(:name , :with => "Frodo")
    fill_in(:age , :with => 30)
    fill_in(:experience , :with => "minimal")
    fill_in(:instrument , :with => "Whistle")
    click_button 'save'

    expect(page.body).to include("Bella Bartok")
    expect(page.body).to include("Frodo")
  end

  # it "players can be edited" do
  #   visit '/login'
  #   fill_in(:username, :with => "Elroy")
  #   fill_in(:password, :with => "chickenhawk")
  #   click_button 'Log In'

  #   visit '/players/1/edit'
  #   binding.pry
  #   fill_in(:name, :with => "B. B.")
  #   fill_in(:age, :with => 100)
  #   fill_in(:experience, :with => "maestro")
  #   fill_in(:instrument, :with => "Piano")
  #   click_button 'submit'

  #   expect(page.body).to include("B. B.")
  #   expect(page.body).to include(100)
  #   expect(page.body).to include("maestro")
  #   expect(page.body).to include("Piano")
  # end

end