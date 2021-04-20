require 'test_helper'

class Api::V1::MoneyTransferControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_money_transfer_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_money_transfer_show_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_money_transfer_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_money_transfer_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_money_transfer_destroy_url
    assert_response :success
  end

end
