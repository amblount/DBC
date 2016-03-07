require_relative '../command_line_board_presenter'

describe CommandLineBoardPresenter do
  let(:board_data_no_q) do
    [['A', 'B', 'C', 'D'],
     ['E', 'F', 'G', 'H'],
     ['I', 'J', 'K', 'L'],
     ['M', 'N', 'O', 'P']]
  end

  let(:board_no_q) { double("board", { :board => board_data_no_q }) }
  let(:presenter) { CommandLineBoardPresenter.new(board_no_q) }

  describe '#to_s' do
    it 'returns a string' do
      expect(presenter.to_s).to be_an_instance_of String
    end

    it 'includes all the letters from the board' do
      expected_letters = board_data_no_q.flatten
      expected_letters.each do |letter|
        expect(presenter.to_s).to match /#{letter}/
      end
    end

    it 'is formatted to look like a Boggle board (four rows, four columns)'

    context 'when the board has a Q' do
      let(:board_data_with_q) do
        [['Q', 'L', 'A', 'E'],
         ['I', 'N', 'O', 'Y'],
         ['S', 'S', 'O', 'W'],
         ['J', 'A', 'R', 'E']]
      end

      let(:board_with_q) { double("board", { :board => board_data_with_q }) }
      let(:presenter) { CommandLineBoardPresenter.new(board_with_q) }

      it 'displays Q as Qu' do
        expect(presenter.to_s).to match /Qu/
      end
    end
  end
end
