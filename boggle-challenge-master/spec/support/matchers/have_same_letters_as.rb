require 'rspec/expectations'

RSpec::Matchers.define :have_same_letters_as do |expected|
  match do |actual|
    sorted_characters(expected.to_s) == sorted_characters(actual.to_s)
  end

  def sorted_characters(word)
    word.chars.sort.join
  end

  failure_message do |actual|
    "expected #{actual.inspect} to have the exact same letters as #{expected.inspect}"
  end

  failure_message_when_negated do |actual|
    "expected #{actual.inspect} to have different letters than #{expected.inspect}, but it has the exact same characters"
  end

  description do
    "has the same letters as #{expected}"
  end
end
