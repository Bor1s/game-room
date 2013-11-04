module ControllersHelper
  def sign_in(user=nil)
    user ||= FactoryGirl.create(:user)
    controller.session[:user_id] = user.id
    user
  end
end

RSpec.configure do |config|
  config.include ControllersHelper, type: :controller
end
