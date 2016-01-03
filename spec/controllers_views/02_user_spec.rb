require 'spec_helper'

describe "User Session Activity" do

  before do
    @user = User.create(username: "Waldo", password: "blendin")
    @user.save
  end

  it "Successful Login takes user to /ensembles" do
    visit '/login'
    expect(page.body).to_not include("List of Your Ensembles")
    fill_in(:username, :with => "Waldo")
    fill_in(:password, :with => "blendin")
    click_button 'Log In'
    expect(page.body).to include("List of Your Ensembles")
  end

  it "Signup succeeds for a new user" do
    visit '/logout'
    visit '/signup'
    expect(page.body).to_not include("List of Your Ensembles")
    fill_in(:username, :with => "Carl")
    fill_in(:password, :with => "pass1234")
    click_button 'Sign Up'
    expect(page.body).to include("List of Your Ensembles")
  end

  it "Signup fails for existing users" do
    visit '/logout'
    visit '/signup'
    fill_in(:username, :with => "Waldo")
    fill_in(:password, :with => "blendin")
    click_button 'Sign Up'
    expect(page.body).to include("Username already exists")
  end

  it "Log Out successfully ends session" do
    visit '/login'
    fill_in(:username, :with => "Waldo")
    fill_in(:password, :with => "blendin")
    click_button 'Log In'
    visit '/logout'
    visit '/ensembles'
    expect(page.body).to include("You have to be logged in to do that")
  end

end