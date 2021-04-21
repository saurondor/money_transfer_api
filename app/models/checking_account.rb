class CheckingAccount < ApplicationRecord
  belongs_to :user
  has_many :account_operations

  def do_withdraw(amount)
    self.transaction do
      auth_code = SecureRandom.hex(3)
      description = "Stub description"
      clabe = "aaaaaaaaa"
      operation = AccountOperation.new(:checking_account => self, :amount => amount,
                                       :operation_type => AccountOperation::OP_WITHDRAW,
                                       :operation_status => AccountOperation::STATUS_INIT, :description => description,
                                       :clabe => clabe)
      operation.save
      self.balance -= amount
      self.save
      operation.operation_status = AccountOperation::STATUS_COMPLETE
      operation.auth_code = auth_code
      operation.save
    end
  end

  def do_deposit(amount)
    self.transaction do
      auth_code = SecureRandom.hex(3)
      description = "Stub description"
      clabe = "aaaaaaaaa"
      operation = AccountOperation.new(:checking_account => self, :amount => amount,
                                       :operation_type => AccountOperation::OP_DEPOSIT,
                                       :operation_status => AccountOperation::STATUS_INIT, :description => description,
                                       :clabe => clabe)
      operation.save
      self.balance += amount
      self.save
      operation.operation_status = AccountOperation::STATUS_COMPLETE
      operation.auth_code = auth_code
      operation.save
    end
  end
end
