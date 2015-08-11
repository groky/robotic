require 'spec_helper'

describe Reporter do

  context 'report' do
    it 'should respond with /x,y,facing/' do
      expect(Reporter.report(3,4,'NORTH')).to eql('3,4,NORTH')
    end
  end
end
