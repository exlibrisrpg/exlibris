module Avo::Authorizable
  extend ActiveSupport::Concern

  private

  def authorize_action
    if [:show, :edit, :destroy, :update].include? action_name.to_sym
      set_model
    end

    super
  end
end
