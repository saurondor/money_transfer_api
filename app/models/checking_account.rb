class CheckingAccount < ApplicationRecord
  belongs_to :user
  has_many :account_operations
end
