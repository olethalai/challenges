When(/^I choose a consonant$/) do
  choose_consonant
end

When(/^I choose a vowel$/) do
  choose_vowel
end

Then(/^a consonant is shown on the letters board$/) do
  letters = get_letters_board
  assert_equal false, is_vowel?(letters.last)
end

Then(/^(\d+) consonants are shown on the letters board$/) do |expected_consonant_count|
  letters = get_letters_board
  actual_consonant_count = 0
  # Count consonants on the board
  letters.each do |letter|
    actual_consonant_count += 1 unless is_vowel?(letter)
  end
  assert_equal expected_consonant_count, actual_consonant_count
end

Then(/^(\d+) vowels are shown on the letters board$/) do |expected_vowel_count|
  letters = get_letters_board
  actual_vowel_count = 0
  # Count vowels on the board
  letters.each do |letter|
    actual_vowel_count += 1 if is_vowel?(letter)
  end
  assert_equal expected_vowel_count, actual_vowel_count
end

When(/^I guess a valid (\d+)\-letter word$/) do |word_length|
  guess_valid_word(word_length)
end

When(/^I guess an invalid (\d+)\-letter word$/) do |word_length|
  guess_invalid_word(word_length)
end
