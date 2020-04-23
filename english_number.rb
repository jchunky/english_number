def english_number(number)
  if number < 0
    return 'Please enter a number that isn\'t negative.'
  end # No negative numbers.
  return 'zero' if number == 0

  # No more special cases! No more returns!

  numString = '' # This is the string we will return.

  onesPlace = %w[
    one
    two
    three
    four
    five
    six
    seven
    eight
    nine
  ]
  tensPlace = %w[
    ten
    twenty
    thirty
    forty
    fifty
    sixty
    seventy
    eighty
    ninety
  ]
  teenagers = %w[
    eleven
    twelve
    thirteen
    fourteen
    fifteen
    sixteen
    seventeen
    eighteen
    nineteen
  ]

  # "left" is how much of the number we still have left to write out.
  # "write" is the part we are writing out right now.
  # write and left... get it?  :)
  left = number
  write = left / 100 # How many hundreds left to write out?
  left -= write * 100 # Subtract off those hundreds.

  if write > 0
    # Now here's a really sly trick:
    hundreds = english_number write
    numString = numString + hundreds + ' hundred'
    # That's called "recursion". So what did I just do?
    # I told this method to call itself, but with "write" instead of
    # "number". Remember that "write" is (at the moment) the number of
    # hundreds we have to write out. After we add "hundreds" to
    # "numString", we add the string ' hundred' after it.
    # So, for example, if we originally called english_number with
    # 1999 (so "number" = 1999), then at this point "write" would
    # be 19, and "left" would be 99. The laziest thing to do at this
    # point is to have english_number write out the 'nineteen' for us,
    # then we write out ' hundred', and then the rest of
    # english_number writes out 'ninety-nine'.

    if left > 0
      # So we don't write 'two hundredfifty-one'...
      numString += ' '
    end
  end

  write = left / 10 # How many tens left to write out?
  left -= write * 10 # Subtract off those tens.

  if write > 0
    if (write == 1) && (left > 0)
      # Since we can't write "tenty-two" instead of "twelve",
      # we have to make a special exception for these.
      numString += teenagers[left - 1]
      # The "-1" is because teenagers[3] is 'fourteen', not 'thirteen'.

      # Since we took care of the digit in the ones place already,
      # we have nothing left to write.
      left = 0
    else
      numString += tensPlace[write - 1]
      # The "-1" is because tensPlace[3] is 'forty', not 'thirty'.
    end

    if left > 0
      # So we don't write 'sixtyfour'...
      numString += '-'
    end
  end

  write = left # How many ones left to write out?
  left = 0 # Subtract off those ones.

  if write > 0
    numString += onesPlace[write - 1]
    # The "-1" is because onesPlace[3] is 'four', not 'three'.
  end

  # Now we just return "numString"...
  numString
end
