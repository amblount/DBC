require_relative '../die'
require_relative '../dice_factory'
require_relative 'support/matchers/have_same_letters_as_one_of'

describe DiceFactory do
  describe '.official_boggle_dice' do
    let(:dice) { DiceFactory.official_boggle_dice }

    it 'returns a collection of 16 elements' do
      expect(dice.length).to be 16
    end

    describe 'behaviors of returned objects' do
      it 'returns a collection of rollable objects' do
        dice.each do |die|
          expect(die).to respond_to :roll
        end
      end

      it 'returns a collection of objects with sides' do
        dice.each do |die|
          expect(die).to respond_to :sides
        end
      end
    end

    it 'represents each of the dice in the real Boggle game' do
      official_letter_combinations = %w(AAEEGN ELRTTY AOOTTW ABBJOO EHRTVW CIMOTU DISTTY EIOSST DELRVY ACHOPS HIMNQU EEINSU EEGHNW AFFKPS HLNNRZ DEILRX)
      dice_sides = dice.map(&:sides)

      official_letter_combinations.each do |letter_combination|
        expect(letter_combination).to have_same_letters_as_one_of dice_sides
      end
    end
  end
end
