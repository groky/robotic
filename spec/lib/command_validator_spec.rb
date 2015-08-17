require 'spec_helper'

describe CommandValidator do

  let(:validator) { CommandValidator }

  describe 'valid?' do
    context "when valid input" do
      let(:valid_input){ ['MOVE', 'PLACE 2,3,SOUTH', 'LEFT', 'RIGHT', 'REPORT'].sample }
      it "should be truthy" do
        output = validator.valid?(valid_input)
        expect( output ).to be_truthy
      end
    end

    context "when invalid input" do
      let(:invalid_input){ ['JUMP','MOOVE','2,3,SOUTH','LEF', 'RITE'].sample }

      it "should be falsy" do
        output = validator.valid?(invalid_input)
        expect( output ).to be_falsy
      end
    end
  end
end
