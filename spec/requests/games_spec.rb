require 'spec_helper'

describe "games index page" do

  after do
    Game.destroy_all
  end

  it "should create new game" do
    user = FactoryGirl.create(:user)
    user.confirm!

    #Logging in
    visit "/"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "1234567"
    click_button "Sign in"
    ############
    
    visit "/games/new"
    fill_in "game_title", with: "HQ Gothic game"
    fill_in "game_description", with: "Some game description"
    click_button "Create"

    page.should have_selector(".game", text: "HQ Gothic game")
    Game.count.should == 1
    Game.first.title.should == "HQ Gothic game"
  end
end
