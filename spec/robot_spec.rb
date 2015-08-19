require 'spec_helper'

describe Robot::Robot do

  describe '#new' do
    it "should create a new robot" do
      Robot::Robot.new
    end
  end

  describe "#run" do

    it "should be waiting for a command" do
      robot = Robot::Robot.new
      expect(robot.run!).to_not be_nil
      expect(robot.alive).to be_truthy
      robot.stop!
    end

    context "when placed in a valid location" do

      subject(:robot) { Robot::Robot.new }

      it "should happily place itself on the mark" do
        robot.run!
        expect(robot.location).to eql [1,2]
        expect(robot.facing).to   eql Robot::Robot::WEST
      end
    end

    # context "when placed in an invalid location" do
    #   before do
    #     allow(STDIN).to receive(:read).and_return("PLACE 6,2,SOUTH")
    #   end
    #
    #   subject(:robot) { Robot::Robot.new(STDIN) }
    #
    #   it "should complain that its going to fall off the table" do
    #     expect { robot.run! }.to raise_error
    #   end
    # end



  end

end
