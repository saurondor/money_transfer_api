class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # STOCK AUTH SETTINGS
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  #
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  # alternate blacklist JWT Deny mechanism
  #:jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  ##
  # USER should have a set of accounts
  # ? maybe polimorphic
  # - at least one checking account type
  # - add operation log to accounts
  #
  #

  validates :email, presence: true
  validates :role, presence: true

  has_many :checking_accounts

  ROLE_ADMIN = "admin"
  ROLE_HOLDER = "holder"

  def is_admin?
    self.role == ROLE_ADMIN
  end

  ##
  # Transfers money out of the account
  def do_withdraw(source_account, amount, destination_account, destination_bank)
    raise Api::V1::InvalidAmountException.new "Amount must be positive" unless amount > 0
    raise Api::V1::InvalidClabeException.new "Invalid CLABE for source account" unless ClabeAccount.validate_clabe(source_account)
    raise Api::V1::InvalidClabeException.new "Invalid CLABE for destination account" unless ClabeAccount.validate_clabe(destination_account)
    clabe_account = ClabeAccount.get_clabe_account(destination_account)
    puts "#{clabe_account.as_json} vs #{destination_bank}"
    raise Api::V1::InvalidClabeException.new "Invalid ABM code or bank short name for CLABE destination account " if clabe_account.nil? or clabe_account.short_name != destination_bank

    account = self.checking_accounts.where(:clabe => source_account).first
    return unless !account.nil? ## probably handle some exception here
    account.do_withdraw(amount, destination_account)
  end

  ##
  # Deposits a certain amount to the account
  def do_deposit(account_number, amount)
    raise Api::V1::InvalidAmountException.new "Amount must be positive" unless amount > 0
    account = self.checking_accounts.where(:clabe => account_number).first
    return unless !account.nil? ## probably handle some exception here
    account.do_deposit(amount)

  end
end
