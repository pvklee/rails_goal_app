module AuthFeaturesHelper
    def sign_up_as(username)
      visit new_user_url
      fill_in "Username", with: username
      fill_in "Password", with: "password"
      click_button "user_sign_up"
    end
  
    def login_as(user)
      visit new_session_url
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "user_log_in"
    end
  end
  