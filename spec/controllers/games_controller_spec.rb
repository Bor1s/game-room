require 'spec_helper'

describe GamesController do
  include Devise::TestHelpers

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @user.confirm!
    sign_in @user
  end

  after do
    User.destroy_all
  end

  it "should GET to index page" do
    get :index
    response.status.should == 200
  end

  it "should create new game" do
    post :create, { game: { title: "HK Gothic", description: "Some game description" } }
    response.should redirect_to games_path
  end
end
