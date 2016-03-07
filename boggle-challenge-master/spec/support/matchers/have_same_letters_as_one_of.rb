require 'rspec/expectations'

RSpec::Matchers.define :have_same_letters_as_one_of do |expected|
  match do |actual|
    expected.any? do |el|
      sorted_characters(el.to_s) == sorted_characters(actual.to_s)
    end
  end

  def sorted_characters(word)
    word.chars.sort.join
  end

  failure_message do |actual|
    "expected #{actual.inspect} to have the exact same letters as one of the elements in #{expected}"
  end

  failure_message_when_negated do |actual|
    matching_element = expected.find { |el| sorted_characters(el.to_s) == sorted_characters(actual.to_s) }
    "expected #{actual.inspect} to have different letters than each of the elements in #{expected}, but it has the same characters as #{matching_element.inspect}"
  end

  description do
    "has the same letters as one of the elements in #{expected}"
  end
end
