class Admin::AdminController < ApplicationController
  layout "admin"

  before_action :require_login
end
