class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.implicit_order_column = :updated_at
end
