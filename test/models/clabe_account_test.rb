require 'test_helper'

class ClabeAccountTest < ActiveSupport::TestCase

  test "validate clabe" do
    clabe1 = "002115016003269411"
    bad_clabe1 = "002115016003269412"
    clabe2 = "032180000118359719"
    bad_clabe2 = "032180000118359718"
    sub_clabe1 = "00211501600326941"
    sub_clabe2 = "03218000011835971"
    account.validate_clabe(clabe2)
    digit = ClabeAccount.get_clabe_checksum(sub_clabe2)
    assert_equal(9, digit)
    digit = ClabeAccount.get_clabe_checksum(sub_clabe1)
    assert_equal(1, digit)
    digit = ClabeAccount.get_clabe_checksum("92342343")
    assert_nil( digit)

    assert_equal(true, ClabeAccount.validate_clabe(clabe1))
    assert_equal(true, ClabeAccount.validate_clabe(clabe2))
    assert_equal(false, ClabeAccount.validate_clabe(bad_clabe1))
    assert_equal(false, ClabeAccount.validate_clabe(bad_clabe2))
  end
end
