class CheckingAccount < ApplicationRecord
  belongs_to :user
  has_many :account_operations

  def do_withdraw(amount, destination_account, description = "")
    operation = nil
    self.transaction do
      #description = "Stub description"
      operation = AccountOperation.new(:checking_account => self, :amount => amount,
                                       :operation_type => AccountOperation::OP_WITHDRAW,
                                       :operation_status => AccountOperation::STATUS_INIT, :description => description,
                                       :clabe => destination_account)
      operation.save
      account = CheckingAccount.find(self.id)
      if account.balance < amount
        # raise exception
        #
        operation.operation_status = AccountOperation::STATUS_INSUFFICIENT_FUNDS
        operation.save
        raise InvalidBalanceException.new "Current balance is below withdraw amount"
      end
      account.balance -= amount
      account.save
      operation.operation_status = AccountOperation::STATUS_COMPLETE
      operation.auth_code = generate_auth_code
      operation.save
    end
    operation.auth_code
  end

  def do_deposit(amount, description = "")
    operation = nil
    self.transaction do
      #description = "Stub description"
      #clabe = "aaaaaaaaa"
      operation = AccountOperation.new(:checking_account => self, :amount => amount,
                                       :operation_type => AccountOperation::OP_DEPOSIT,
                                       :operation_status => AccountOperation::STATUS_INIT, :description => description)
      operation.save
      account = CheckingAccount.find(self.id)
      account.balance += amount
      account.save
      operation.operation_status = AccountOperation::STATUS_COMPLETE
      operation.auth_code = generate_auth_code
      operation.save
    end
    operation.auth_code
  end

  private

  def generate_auth_code
    SecureRandom.hex(3).upcase
  end
end
