class ResetPassword < Avo::BaseAction
  self.name = "Reset password"

  def handle(**args)
    models = args[:models]

    args[:models].each do |model|
      model.forgot_password!
      ClearanceMailer.change_password(model).deliver_now
    end

    succeed "Sent password reset #{"email".pluralize(models.count)}"
  end
end
