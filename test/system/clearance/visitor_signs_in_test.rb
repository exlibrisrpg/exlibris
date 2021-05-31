require "application_system_test_case"

class VisitorSignsInTest < ApplicationSystemTestCase
  test "with valid email and password" do
    sign_in_with users(:john).email, "password"

    assert_user_signed_in users(:john)
  end

  test "with valid mixed-case email and password " do
    sign_in_with users(:john).email.upcase, "password"

    assert_user_signed_in users(:john)
  end

  test "tries with invalid password" do
    sign_in_with users(:john).email.upcase, "wrong_password"

    assert_includes page.body, I18n.t("flashes.failure_after_create")
    assert_user_signed_out
  end

  test "tries with invalid email" do
    sign_in_with "unknown.email@example.com", "password"

    assert_includes page.body, I18n.t("flashes.failure_after_create")
    assert_user_signed_out
  end
end
