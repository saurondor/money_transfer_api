require 'test_helper'

class UserTest < ActiveSupport::TestCase


  test "do deposit" do
    user = users(:one)
    assert_not_nil(user)

    assert_equal(1, user.checking_accounts.size())
    checking_account = user.checking_accounts.first
    assert_equal(1, checking_account.account_operations.size())
    assert_equal(2500, checking_account.balance)
    puts "Starting balance #{user.checking_accounts.first.balance}"
    user.do_deposit(checking_account.clabe, 1500)
    puts "Ending balance #{user.checking_accounts.first.balance}"
  end

  test "do withdraw" do
    user = users(:one)
    assert_not_nil(user)

    assert_equal(1, user.checking_accounts.size())
    checking_account = user.checking_accounts.first
    assert_equal(1, checking_account.account_operations.size())
    assert_equal(2500, checking_account.balance)
    puts "Starting balance #{user.checking_accounts.first.balance}"
    user.do_withdraw(checking_account.clabe, 500)
    puts "Ending balance #{user.checking_accounts.first.balance}"

  end
end
