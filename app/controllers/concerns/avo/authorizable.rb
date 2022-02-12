module Avo::Authorizable
  extend ActiveSupport::Concern

  private

  def authorize_action
    # Temporary fix whilst we resolve this conversation:
    # https://github.com/avo-hq/avo/pull/612#issuecomment-1037199884
    if [:create, :update].include? action_name.to_sym
      fill_model
    end

    super
  end
end
