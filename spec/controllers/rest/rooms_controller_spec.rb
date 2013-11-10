require 'spec_helper'

describe Rest::RoomsController do
  before do
    sign_in
  end

  let(:subscription) { FactoryGirl.create(:subscription, user_id: current_user.id) }
  let!(:subscriptions) { FactoryGirl.create_list(:subscription, 3) }

  context 'GET index' do
    it 'responds with 200' do
      get :index, format: :json
      response.status.should be 200
    end
  end

  context 'GET show' do
    it 'responds with 200' do
      get :show, id: subscription.room.id, format: :json
      response.status.should be 200
    end

    it 'responds with 404' do
      get :show, id: 'unexisting', format: :json
      response.status.should be 404
    end
  end

  context 'GET edit' do
    it 'responds with 200' do
      get :edit, id: subscription.room.id, format: :json
      response.status.should be 200
    end

    it 'responds with 404' do
      get :edit, id: 'unexisting', format: :json
      response.status.should be 404
    end
  end

  context 'PUT join' do
    it 'responds with 201' do
      put :join, id: subscription.room.id, format: :json
      response.status.should be 201
    end

    it 'responds with 404' do
      put :join, id: 'unexisting', format: :json
      response.status.should be 404
    end
  end

  context 'PUT redeem' do
    it 'responds with 200' do
      put :redeem, id: subscription.room.id, format: :json
      response.status.should be 200
    end

    it 'responds with 404' do
      put :redeem, id: 'unexisting', format: :json
      response.status.should be 404
    end
  end

  context 'POST create' do
    it 'responds with 201' do
      post :create, {room: {title: 'Foobar', description: 'Baz'}, format: :json}
      response.status.should be 201
    end

    it 'responds with 422' do
      post :create, {room: {title: '', description: ''}, format: :json}
      response.status.should be 422
    end
  end

  context 'PUT update' do
    it 'responds with 204' do
      put :update, {id: subscription.room.id,
                     room: {title: 'Foobar'},
                     format: :json}
      response.status.should be 204
    end

    it 'responds with 422' do
      put :update, {id: subscription.room.id,
                     room: {title: ''},
                     format: :json}
      response.status.should be 422
    end
  end

  context 'DELETE destroy' do
    it 'responds with 200' do
      delete :destroy, id: subscription.room.id
      response.status.should be 200
    end

    it 'responds with 404' do
      delete :destroy, id: 'unexisting'
      response.status.should be 404
    end
  end
end
