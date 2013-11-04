require 'spec_helper'

describe Rest::RoomsController do
  before do
    sign_in
  end

  context 'GET index' do
    it 'responds with 200' do
      get :index, format: :json
      response.status.should be 200
    end
  end

  context 'GET show' do
    it 'responds with 200' do
      subscription = FactoryGirl.create(:subscription)
      get :show, id: subscription.room.id, format: :json
      response.status.should be 200
    end

    it 'responds with 404' do
      get :show, id: 'unexisting', format: :json
      response.status.should be 404
    end
  end
end
