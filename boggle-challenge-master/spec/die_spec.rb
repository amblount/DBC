require_relative '../die'
require_relative 'support/matchers/have_same_letters_as'

describe Die do
  let(:first_set_of_letters) { 'ABCDEF' }
  let(:first_die) { Die.new(first_set_of_letters) }

  let(:second_set_of_letters) { 'UVWXYZ' }
  let(:second_die) { Die.new(second_set_of_letters) }

  describe '#sides' do
    it 'returns a string representing its sides' do
      expect(first_die.sides).to be_an_instance_of String
    end

    it 'all of the dices sides are represented' do
      expect(first_die.sides).to have_same_letters_as first_set_of_letters
    end
  end

  describe '#roll' do
    it 'returns one letter' do
      expect(first_die.roll.length).to eq 1
    end

    it 'returns one of its own letters' do
      expect(first_die.roll).to match /[#{first_set_of_letters}]/
      expect(second_die.roll).to match /[#{second_set_of_letters}]/
    end
  end
end
