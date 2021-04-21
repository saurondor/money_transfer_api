class Api::V1::MoneyTransferController < ApplicationController
  before_action :authenticate_user!

  before_action :require_admin, except: [:transfer]

  def require_admin
    render json: {"message" => "User is not ADMIN"}, status: :unauthorized unless current_user.is_admin?
  end

  def index
  end

  def show
  end

  ##
  # Creates a CLABE transfer
  # Outbound operation of funds from checking account
  # parameters
  # USER - from login
  # amount
  # clabe account
  #
  # ?? return values
  # OK - Created
  # invalid operation - invalid CLABE
  #
  def transfer

  end

  ##
  # Creates a deposit
  # Inbound operation of funds to checking account
  # generates deposit to
  # account number
  # clabe
  #
  # ? parameters
  # CLABE
  # account number
  # BIN
  def add_funds
    email = params['user']['email']
    clabe = params['user']['clabe']
    amount = params['user']['amount'].to_f
    user = User.where(:email => email).first
    raise InvalidUserAccountException.new "Specified user does not exist" unless !user.nil?
    begin
      user.do_deposit(clabe, amount)
    rescue InvalidAmountException => e
    rescue InvalidBalanceException => e
    rescue InvalidClabeException => e

    end
  end

  def create
  end

  def update
  end

  def destroy
  end
end
