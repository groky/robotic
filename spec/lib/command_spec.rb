require 'spec_helper'

describe Command do
  describe 'translate' do

    subject(:command) { Command.new }

    context 'when valid input' do

      let(:input) { ['left', 'right', 'report', 'move'].sample.upcase }

      context 'when move, left, right and report' do
        before do
          allow(STDIN).to receive(:gets).and_return(input)
          command.read
        end
        it "should have only a command and no options" do
          expect(command.command).to eql(input)
          expect(command.options).to be_empty
        end
      end

      context 'when place' do
        let(:options) {
          {
            column:    2,
            row:       3,
            direction: 'SOUTH'
          }
        }

        let(:valid_input){'PLACE 2,3,SOUTH'}

        before do
          allow(STDIN).to receive(:gets).and_return(valid_input)
          command.read
        end

        it "should match the expected result" do
          expect(command.command).to eql "PLACE"
          expect(command.options).to eql options
        end
      end
    end

    context 'when invalid input' do
      let(:invalid_input){ "NORTH 2,5" }

      before do
        allow(STDIN).to receive(:gets).and_return(invalid_input)
      end

      it "should show a message" do
        expect{ command.read }.to raise_error(RuntimeError, /Please supply a valid input. Valid inputs include:/)
        expect( command.command).to be_nil
        expect( command.options).to be_empty
      end
    end
  end
end
