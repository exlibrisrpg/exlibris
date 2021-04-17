require "application_system_test_case"

class UserSignsOutTest < ApplicationSystemTestCase
  test "signs out" do
    sign_in
    sign_out

    assert_user_signed_out
  end
end
