require 'test_helper'
require 'devise/jwt/test_helpers'

class Api::V1::MoneyTransferControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers


  ##
  # ADMIN user can add funds to HOLDER account
  # Should return 201 created status
  # Should return operation auth code
  test "should add funds" do
    user = users(:one)
    sign_in user
    headers = {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    # This will add a valid token for `user` in the `Authorization` header
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    payload = {
        "user": {
            "email": "gtasistro@gmail.com",
            "amount": "1500.00",
            "clabe": "002115016003269411"
        }
    }
    post '/api/v1/add_funds', as: :json, params: payload, headers: auth_headers
    op_result = response.parsed_body
    #puts "::#{op_result}"
    assert_equal 201, status
    assert_not_nil op_result['auth_code']
  end

  ##
  # ADMIN user can't add funds to invalid HOLDER account
  # Should return 400 bad request status
  test "should not add funds to invalid HOLDER account" do
    user = users(:one)
    sign_in user
    headers = {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    # This will add a valid token for `user` in the `Authorization` header
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    payload = {
        "user": {
            "email": "gtasist@gmail.com",
            "amount": "1500.00",
            "clabe": "002115016003269411"
        }
    }
    post '/api/v1/add_funds', as: :json, params: payload, headers: auth_headers
    op_result = response.parsed_body
    #puts "::#{op_result}"
    assert_equal 400, status
    assert_not_nil op_result['message']
    assert_equal "No such user", op_result['message']
  end

  test "should transfer funds" do
    user = users(:two)
    sign_in user
    headers = {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    # This will add a valid token for `user` in the `Authorization` header
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    payload = {
        "operation": {
            "amount": "1500.00",
            "source_account": "002115016003269411",
            "destination_account": "014190016333269411",
            "destination_bank": "SANTANDER"
        }
    }
    post '/api/v1/transfer', as: :json, params: payload, headers: auth_headers
    op_result = response.parsed_body
    #puts "::#{op_result} CODE #{op_result['auth_code']}"
    assert_equal 201, status
    assert_not_nil op_result['auth_code']
  end

  # test "should get index" do
  #   get api_v1_money_transfer_index_url
  #   assert_response :success
  # end
  #
  # test "should get show" do
  #   get api_v1_money_transfer_show_url
  #   assert_response :success
  # end
  #
  # test "should get create" do
  #   get api_v1_money_transfer_create_url
  #   assert_response :success
  # end
  #
  # test "should get update" do
  #   get api_v1_money_transfer_update_url
  #   assert_response :success
  # end
  #
  # test "should get destroy" do
  #   get api_v1_money_transfer_destroy_url
  #   assert_response :success
  # end

end
