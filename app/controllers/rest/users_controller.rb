class Rest::UsersController < ApplicationController
  respond_to :json

  def get_current_user
    respond_with current_user.to_json(include: :subscriptions)
  end
end
