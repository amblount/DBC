require_relative '../simple_finder'

describe SimpleFinder do

  describe '#include?' do
    let(:board_data) do
      [['F', 'A', 'N', 'G'],
       ['E', 'E', 'O', 'N'],
       ['N', 'N', 'E', 'O'],
       ['E', 'D', 'O', 'S']]
    end

    let(:board) { double("board", { :board => board_data }) }
    let(:finder) { SimpleFinder.new(board) }

    it 'does not find words with less than three letters' do
      expect(finder.include? "FA").to be false
    end

    xit 'finds words in a row spelled left-to-right' do
      expect(finder.include? "FANG").to be true
    end

    xit 'finds words in a row spelled right-to-left' do
      expect(finder.include? "SOD").to be true
    end

    it 'finds words in a column spelled top-to-bottom'

    it 'finds words in a column spelled bottom-to-top'

    it 'finds words diagonally from top left to bottom right'

    it 'finds words diagonally from top right to bottom left'

    it 'finds words diagonally from bottom left to top right'

    it 'finds words diagonally from bottom right to top left'

    xit 'is case insensitive' do
      expect(finder.include? "fAnG").to be true
    end

    xit 'does not find words not on the board' do
      expect(finder.include? "FANGS").to be false
    end

    xit 'only finds words in straight lines' do
      expect(finder.include? "NEON").to be false
    end

    context 'when the board has a Q' do
      let(:board_data_with_q) do
        [['S', 'Q', 'A', 'T'],
         ['X', 'X', 'X', 'X'],
         ['X', 'X', 'X', 'X'],
         ['X', 'X', 'X', 'X']]
      end

      let(:board_with_q) { double("board", { :board => board_data_with_q }) }
      let(:finder) { SimpleFinder.new(board_with_q) }

      xit 'treats a Q on the board as QU' do
        expect(finder.include? "SQUAT").to be true
      end

      xit 'does not treat Q as just a Q' do
        expect(finder.include? "QAT").to be false
      end
    end
  end
end
