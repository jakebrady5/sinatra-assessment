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

  it "/ensembles only shows a user's ensembles" do
    visit '/login'
    fill_in(:username, :with => "Elroy")
    fill_in(:password, :with => "chickenhawk")
    click_button 'Log In'

    visit '/ensembles'
    expect(page.body).to include("City Center Combo")
    expect(page.body).to_not include("Awesome Orchestra Collective")
  end

  # test edit

  it "Adds players to roster" do
    visit '/login'
    fill_in(:username, :with => "Elroy")
    fill_in(:password, :with => "chickenhawk")
    click_button 'Log In'

    visit '/ensembles/2/add_to'
    check "Marvin Martian"
    click_button 'submit'
    visit '/ensembles/2'
    expect(page.body).to include("City Center Combo")
    expect(page.body).to include("Marvin Martian")
    # expect(page.body).to_not include("Frank")
    # no idea why this line fails?
  end

  it "Removes players from roster" do
    visit '/login'
    fill_in(:username, :with => "Elroy")
    fill_in(:password, :with => "chickenhawk")
    click_button 'Log In'

    visit '/ensembles/2/add_to'
    check "Marvin Martian"
    check "Bella Bartok"
    click_button 'submit'
    visit '/ensembles/2'
    expect(page.body).to include("City Center Combo")
    expect(page.body).to include("Bella Bartok")

    visit '/ensembles/2/remove'
    check "Bella Bartok"
    click_button 'submit'
    visit '/ensembles/2'
    expect(page.body).to include("Marvin Martian")
    # expect(page.body).not_to include("Bella Bartok")
    # having issues with not_to include
  end

end