module ClearanceHelpers
  module ControllerTestHelpers
    def assert_requires_authentication
      assert_redirected_to sign_in_path
    end

    def sign_in
      sign_in_as users(:john)
    end

    def sign_in_as(user, password = "password")
      post session_path, params: {session: {email: user.email, password: password}}
    end
  end

  module SystemTestHelpers
    def reset_password_for(email)
      visit new_password_path
      fill_in "password_email", with: email
      click_button I18n.t("helpers.submit.password.submit")
    end

    def sign_in
      sign_in_with users(:john).email, "password"
    end

    def sign_in_with(email, password)
      visit sign_in_path
      fill_in "session_email", with: email
      fill_in "session_password", with: password
      click_button I18n.t("helpers.submit.session.submit")
    end

    def sign_out
      click_link users(:john).email
      click_button "Sign out"
    end

    def sign_up_with(email, password)
      visit sign_up_path
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_button I18n.t("helpers.submit.user.create")
    end

    def assert_user_signed_in(user)
      visit "/admin"
      assert_link user.email
    end

    def assert_user_signed_out
      visit "/admin"
      assert_content I18n.t("layouts.application.sign_in")
    end

    def user_with_reset_password
      user = users(:john)
      reset_password_for user.email
      user.reload
    end
  end
end
