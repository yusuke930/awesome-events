module SignInHelper
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: { nickname: user.name,
              image: user.image_url })
    case
    when respond_to?(:visit) 
      visit root_url
      click_on "Login to GitHub"
    when respond_to?(:get)
      get "/auth/github/callback"
    else
      raise NotImplementedError.new
    end
    @current_uer = user
  end

  def current_uer
    @current_uer
  end
end

class ActionDispatch::IntegrationTest
  include SignInHelper
end