class ApplicationController < ActionController::Base
  include Clearance::Controller

  layout "public"
end
