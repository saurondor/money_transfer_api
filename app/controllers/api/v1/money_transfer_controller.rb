class Api::V1::MoneyTransferController < ApplicationController
  #around_action :log
  before_action :authenticate_user!

  before_filter :require_admin, :except => []

  def require_admin

  end

  def log
    puts "IN LOG #{request.headers}"

    request.headers.each do |key, value|
      puts "\t\t H - #{key}, #{value}"
    end
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
