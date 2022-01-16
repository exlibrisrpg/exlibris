module PunditHelpers
  module PolicyTestHelpers
    def assert_permit(user, record, action)
      msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
      assert is_permitted?(user, record, action), msg
    end

    def refute_permit(user, record, action)
      msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
      refute is_permitted?(user, record, action), msg
    end

    def is_permitted?(user, record, action)
      cls = self.class.to_s.gsub(/Test/, "")
      cls.constantize.new(user, record).public_send("#{action}?")
    end

    def assert_scope(user, initial_scope, expected_scope)
      cls = self.class.to_s.gsub(/Test/, "")
      actual_scope = "#{cls}::Scope".constantize.new(user, initial_scope).resolve
      assert_equal expected_scope, actual_scope
    end
  end
end
