require_relative '../official_finder'

describe OfficialFinder do

  describe '#include?' do
    let(:board_data) do
      [['F', 'A', 'N', 'G'],
       ['E', 'E', 'O', 'N'],
       ['N', 'N', 'E', 'O'],
       ['E', 'D', 'O', 'S']]
    end

    let(:board) { double("board", { :board => board_data }) }
    let(:finder) { OfficialFinder.new(board) }

    it 'does not find words with less than three letters' do
      expect(finder.include? "FA").to be false
    end

    # Add the rest of the tests

    context 'when the board has a Q' do
      let(:board_data_with_q) do
        [['S', 'Q', 'A', 'T'],
         ['X', 'X', 'X', 'X'],
         ['X', 'X', 'X', 'X'],
         ['X', 'X', 'X', 'X']]
      end

      let(:board_with_q) { double("board", { :board => board_data_with_q }) }
      let(:finder) { OfficialFinder.new(board_with_q) }

      # Add tests for how the finder behaves with a Q on the board
    end
  end
end
