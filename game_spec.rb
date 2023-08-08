require_relative 'game'

describe Game do

  subject(:game) { Game.new }
  describe '#play' do
    it 'begins with win_state set to false' do
      game.play
      expect(game.win_state).to eq(false)
    end

    context 'after receiving valid user input' do

      xit 'calls place piece function when given valid input' do

      end

      xit 'switches current player when given valid input' do

      end
    end
  end

  describe '#player_input' do
    subject(:game) { described_class.new }
    context 'when receiving two invalid inputs, and then a valid input' do
      before do
        invalid_input = 'one'
        another_invalid_input = '9'
        valid_input = '2'
        allow(game).to receive(:gets).and_return(invalid_input, another_invalid_input, valid_input)
      end

      it 'sends two error messages, and then finishes' do
        error_message = 'invalid input, please choose valid column'
        expect(game).to receive(:puts).with(error_message).twice
        expect(game).not_to receive(:puts).with(error_message)
        game.player_input
      end

      it 'returns the valid input' do
        expect(game.player_input).to eq(2)
        game.player_input
      end
    end

    # is this necessary?
    context 'when receiving valid input' do
      before do
        valid_input = '3'
        allow(game).to receive(:gets).and_return(valid_input)
      end

      it 'does not send error message' do
        error_message = 'invalid input, please choose valid column'
        expect(game).not_to receive(:puts).with(error_message)
        game.player_input
      end
    end
  end
end