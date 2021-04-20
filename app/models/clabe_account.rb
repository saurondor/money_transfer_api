class ClabeAccount < ApplicationRecord

  # TODO we might want to crop corporate name field length to shorter text
  #
  #
  # CHECKSUM CALCULATION source (https://en.wikipedia.org/wiki/CLABE#Control_digit)
  # City code
  # This three-digit code refers to the city ("Plaza") where the checking account is located is interna. A bank can have several Branches in a city, therefore the number of the Branch is included in the next, eleven digit section for the checking account number.
  #
  # Account number
  # The account number in the financial institution, padded on the left with zeroes to a width of 11 digits.
  #
  # Control digit
  # The control digit is calculated as the modulus 10 of 10 minus the modulus 10 of the sum of the modulus 10 of the product of the first 17 digits by its weight factor.[3][4]
  #
  # The first 17 digits of the CLABE are, as mentioned above, the Bank Code, the Branch Office Code and the Account Number.
  #
  # The weight factor of a given digit is:
  #
  # 3 if its position (starting at 0) modulus 3 is 0
  # 7 if its position modulus 3 is 1
  # 1 if its position modulus 3 is 2
  # A 17 digit weight is always "37137137137137137".
  #
  # The method is:
  #
  # For every digit, multiply it by its weight factor and take their modulus 10 (modulus is the Remainder of the integer division. The modulus X of a baseX number is its rightmost digit).
  # Sum all of the calculated products, and take modulus 10 again.
  # Subtract the sum to 10, take modulus 10, and you have the resulting control digit.
  # So, as an example:
  #
  # Bank	Branch	Account Number
  # 17 CLABE digits	0	3	2	1	8	0	0	0	0	1	1	8	3	5	9	7	1
  # ×
  # Weight factors	3	7	1	3	7	1	3	7	1	3	7	1	3	7	1	3	7
  # = ( % 10 )
  # Products, modulus 10	0	1	2	3	6	0	0	0	0	3	7	8	9	5	9	1	7
  # Product sum, modulus 10	1
  # 10 - sum, modulus 10	9 (control digit)
  # And so, the complete CLABE is: 032180000118359719

  CLABE_WEIGHTS = [3,7,1,3,7,1,3,7,1,3,7,1,3,7,1,3,7]
  CLABE_LENGTH = 17

  ##
  # Calculates the checksum digit for the 17 characters
  def self.get_clabe_checksum(sub_clabe)
    return unless sub_clabe.size() == CLABE_LENGTH
    weight = 0;
    CLABE_WEIGHTS.each_with_index do |weight_factor, index|
      weight += sub_clabe[index].to_i*weight_factor % 10
    end
    (10 - weight) % 10
  end

  ##
  # Verifies an 18 character CLABE is valid
  def self.validate_clabe(clabe)
    return unless clabe.size() == CLABE_LENGTH+1
    validation_digit = clabe[17].to_i
    return validation_digit == get_clabe_checksum(clabe[0..16])
  end
end
