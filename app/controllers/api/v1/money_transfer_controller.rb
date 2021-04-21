class Api::V1::MoneyTransferController < ApplicationController
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
