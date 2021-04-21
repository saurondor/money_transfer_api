class Api::V1::MoneyTransferController < ApplicationController
  before_action :authenticate_user!

  before_action :require_admin, except: [:transfer]

  def require_admin
    render json: {"message" => "User is not ADMIN"}, status: :unauthorized unless current_user.is_admin?
  end

  def index
    puts "USER #{current_user.as_json}"
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
  # Inboud operation of funds to checking account
  # generates deposit to
  # account number
  # clabe
  #
  # ? parameters
  # CLABE
  # account number
  # BIN
  def deposit

  end

  def create
  end

  def update
  end

  def destroy
  end
end
