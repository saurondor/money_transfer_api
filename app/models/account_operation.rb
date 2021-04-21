class AccountOperation < ApplicationRecord
  belongs_to :checking_account

  # lets start with a simple operation SET
  OP_DEPOSIT = "deposit"
  OP_WITHDRAW = "withdraw"

  STATUS_INIT = "init"
  STATUS_COMPLETE = "complete"
  STATUS_INSUFFICIENT_FUNDS = "no_funds"
end
