require 'spec_helper'

describe "User Session Activity" do

  before do
    @user = User.create(username: "Waldo", password: "blendin")
    @user.save
  end

  it "Successful Login takes user to /ensembles" do
    visit '/login'
    fill_in(:username, :with => "Waldo")
    fill_in(:password, :with => "blendin")
    click_button 'Log In'
    expect(page.body).to include("List of Your Ensembles")
  end

end