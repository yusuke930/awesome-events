module SignInSupport
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: { nickname: user.name,
              image: user.image_url })

    #get root_path
    visit root_url
    click_on "Login to GitHub"
    @current_user = user
  end
  
  def current_user
    @current_user
  end
end
    