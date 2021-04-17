require "application_system_test_case"

class VisitorResetsPasswordTest < ApplicationSystemTestCase
  test "by navigating to the page" do
    visit sign_in_path

    click_link I18n.t("sessions.form.forgot_password")

    assert_current_path new_password_path
  end

  test "with valid email" do
    user = user_with_reset_password

    assert_content I18n.t("passwords.create.description")
    assert_reset_notification_sent_to user
  end

  test "with non-user account" do
    reset_password_for "unknown.email@example.com"

    assert_content I18n.t("passwords.create.description")
    assert_mailer_has_no_deliveries
  end

  private

  def assert_reset_notification_sent_to(user)
    refute_predicate user.confirmation_token, :blank?
    assert_mailer_has_delivery(
      user.email,
      "password",
      user.confirmation_token
    )
  end

  def assert_mailer_has_delivery(recipient, subject, body)
    refute_empty ActionMailer::Base.deliveries

    message = ActionMailer::Base.deliveries.any? do |email|
      email.to == [recipient] &&
        email.subject =~ /#{subject}/i &&
        email.html_part.body =~ /#{body}/ &&
        email.text_part.body =~ /#{body}/
    end

    assert message
  end

  def assert_mailer_has_no_deliveries
    assert_empty ActionMailer::Base.deliveries
  end
end
