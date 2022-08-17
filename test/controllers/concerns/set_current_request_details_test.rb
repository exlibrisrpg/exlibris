require "test_helper"

class SetCurrentRequestDetailsTest < ActionDispatch::IntegrationTest
  routes = -> {
    get "system", to: "set_current_request_details_test/anonymous#system", as: "system"
    get "variant", to: "set_current_request_details_test/anonymous#variant"
  }
  controller(ApplicationController, routes: routes) do
    def system
      render plain: Current.system&.name
    end

    def variant
      render layout: false
    end
  end

  views["variant.html.erb"] = "default"
  views["variant.html+morkborg.erb"] = "morkborg"

  context "Current.system" do
    context "with no subdomain" do
      should "be nil" do
        get system_url(subdomain: "")

        assert_equal "", response.body
      end
    end

    context "with www as subdomain" do
      should "be nil" do
        get system_url(subdomain: "www")

        assert_equal "", response.body
      end
    end

    context "with live subdomain" do
      should "find system" do
        get system_url(subdomain: "mausritter")

        assert_equal "Mausritter", response.body
      end
    end

    context "with inactive subdomain" do
      context "as a logged in user" do
        should "find system" do
          sign_in

          get system_url(subdomain: "cyborg")

          assert_equal "CY_BORG", response.body
        end
      end

      context "as an anonymous visitor" do
        should "raise ActiveRecord::RecordNotFound" do
          assert_raises(ActiveRecord::RecordNotFound) do
            get system_url(subdomain: "cyborg")
          end
        end
      end
    end

    context "with unknown subdomain" do
      should "raise ActiveRecord::RecordNotFound" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get system_url(subdomain: "horse-adventure")
        end
      end
    end
  end

  context "request.variant" do
    should "choose a variant view when available" do
      get variant_url(subdomain: "morkborg")

      assert_equal "morkborg", response.body
    end

    should "choose the default view when variant not available" do
      get variant_url(subdomain: "mausritter")

      assert_equal "default", response.body
    end
  end
end
