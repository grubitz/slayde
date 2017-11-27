module AuthHelper

  def sign_in(user=nil)
    @user = user || create(:user)
    session[:user_id] = @user.id
  end

end

RSpec.configure do |config|
  config.include AuthHelper
end
