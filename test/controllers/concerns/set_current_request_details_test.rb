require "test_helper"

class SetCurrentRequestDetailsTest < ActionDispatch::IntegrationTest
  routes = -> { get "current_system", to: "set_current_request_details_test/anonymous#show", as: "example" }
  controller(ApplicationController, routes: routes) do
    def show
      render plain: Current.system&.name
    end
  end

  context "Current.system" do
    context "with no subdomain" do
      should "default to Mörk Borg" do
        get example_url(subdomain: "")

        assert_equal "Mörk Borg", response.body
      end
    end

    context "with www as subdomain" do
      should "default to Mörk Borg" do
        get example_url(subdomain: "www")

        assert_equal "Mörk Borg", response.body
      end
    end

    context "with live subdomain" do
      should "find system" do
        get example_url(subdomain: "mausritter")

        assert_equal "Mausritter", response.body
      end
    end

    context "with inactive subdomain" do
      should "raise ActiveRecord::RecordNotFound" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get example_url(subdomain: "cy-borg")
        end
      end
    end

    context "with unknown subdomain" do
      should "raise ActiveRecord::RecordNotFound" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get example_url(subdomain: "horse-adventure")
        end
      end
    end
  end
end
