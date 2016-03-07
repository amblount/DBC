require_relative '../boggle_board'

describe BoggleBoard do
  let(:dice) do
    Array.new(16) { double("a die", { roll: "A", sides: "A" * 6 }) }
  end

  let(:boggle_board) { BoggleBoard.new(dice) }

  it 'has dice', { new_boggle_board: true } do
    expect(boggle_board.dice).to eq dice
  end

  describe 'has a 4 x 4 board' do
    it "board has four rows", { new_boggle_board: true } do
      expect(boggle_board.board.count).to eq 4
    end

    it "each row in the board has four columns", { new_boggle_board: true } do
      boggle_board.board.each do |row|
        number_of_columns = row.count
        expect(number_of_columns).to eq 4
      end
    end

    context 'before being shaken' do
      it "has no letters showing on the board" do
        values_on_board = boggle_board.board.flatten
        letters_on_board = values_on_board.map(&:to_s).select { |value| value.match(/A-Z/i) }
        expect(letters_on_board).to be_empty
      end
    end

    context 'after being shaken', { shake: true } do
      let(:expected_letters_on_board) { ("A".."Z").first(16) }
      let(:dice) do
        expected_letters_on_board.map { |letter| double("a die", {roll: letter, sides: letter * 6 }) }
      end
      let(:shaken_board) do
        boggle_board.shake
        boggle_board
      end

      it 'has each of the board\'s dice represented by a letter on the board' do
        letters_on_board = shaken_board.board.to_a.flatten
        expect(letters_on_board).to match_array expected_letters_on_board
      end

      it 'continues to have four rows' do
        expect(shaken_board.board.count).to eq 4
      end

      it 'continues to have four columns' do
        shaken_board.board.each do |row|
          number_of_columns = row.count
          expect(number_of_columns).to eq 4
        end
      end
    end
  end

  describe '#shake', { shake: true } do
    it 'changes the board' do
      expect { boggle_board.shake }.to change { boggle_board.board }
    end
  end
end
