require 'spec_helper'

describe Robot::Robot do

  let(:table) { Robot::Table.new }
  let(:robot) { Robot::Robot.new table}

  describe 'place' do
    context 'on the board' do
      it "at 0,0,SOUTH should" do
        robot.place(0,0, Robot::Robot::SOUTH)
        expect(robot.report).to eql("0,0,SOUTH")
      end

      it "at 4,4,NORTH should" do
        robot.place(4,4, Robot::Robot::NORTH)
        expect(robot.report).to eql("4,4,NORTH")
      end
    end

    context 'off the board' do
      # facing direction does not matter when you place 
      # the robot on a space that is not on the table
      #
      #
      let(:message) {"Don't place me here. I will fall!"}

      it "at -1,0 should" do
        expect( robot.place(-1,0, Robot::Robot::WEST) ).to eql(message)
      end

      it "at 0,-1 should" do
        expect( robot.place(0,-1, Robot::Robot::WEST) ).to eql(message)
      end

      it "at -1,-3 should" do
        expect( robot.place(-1,-3, Robot::Robot::WEST) ).to eql(message)
      end

      it "at 5,2 should" do
        expect( robot.place(5,2, Robot::Robot::WEST) ).to eql(message)
      end

      it "at 1,6 should" do
        expect( robot.place(1,6, Robot::Robot::WEST) ).to eql(message)
      end

      it "at 5,6 should" do
        expect( robot.place(5,6, Robot::Robot::WEST) ).to eql(message)
      end
    end
  end

  describe 'left' do
    before do
      robot.place(2,3, Robot::Robot::NORTH)
    end
    it "turns" do
      expect(robot.left).to eql(Robot::Robot::WEST)
      expect(robot.left).to eql(Robot::Robot::SOUTH)
      expect(robot.left).to eql(Robot::Robot::EAST)
      expect(robot.left).to eql(Robot::Robot::NORTH)
    end
  end

  describe 'right' do
    before do
      robot.place(2,3, Robot::Robot::NORTH)
    end
    it "turns" do
      expect(robot.right).to eql(Robot::Robot::EAST)
      expect(robot.right).to eql(Robot::Robot::SOUTH)
      expect(robot.right).to eql(Robot::Robot::WEST)
      expect(robot.right).to eql(Robot::Robot::NORTH)
    end    
  end

  describe 'move' do
    context 'into a valid location' do

      it "should move from 0,0, NORTH" do
        robot.place(0,0,Robot::Robot::NORTH)
        robot.move
        expect( robot.report ).to eql("0,1,NORTH")
      end

      it "should move from 3,3, WEST" do
        robot.place(3,3,Robot::Robot::WEST)
        robot.move
        expect( robot.report ).to eql("2,3,WEST")
      end

    end

    context 'off the table' do
      
      let(:message) { "I'm going to fall off the edge!" }

      it "should complain when moving from 0,0, SOUTH" do
        robot.place(0,0,Robot::Robot::SOUTH)
        expect( robot.move ).to eql(message)
      end

      it "should complain when moving from 0,0, WEST" do
        robot.place(0,0,Robot::Robot::WEST)
        expect( robot.move ).to eql(message)
      end

      it "should complain when moving from 0,4, NORTH" do
        robot.place(0,4,Robot::Robot::NORTH)
        expect( robot.move ).to eql(message)
      end

      it "should complain when moving from 0,4, WEST" do
        robot.place(0,4,Robot::Robot::WEST)
        expect( robot.move ).to eql(message)
      end

      it "should complain when moving from 4,0, SOUTH" do
        robot.place(4,0,Robot::Robot::SOUTH)
        expect( robot.move ).to eql(message)
      end

      it "should complain when moving from 4,0, SOUTH" do
        robot.place(4,0,Robot::Robot::EAST)
        expect( robot.move ).to eql(message)
      end

      it "should complain when moving from 4,4, SOUTH" do
        robot.place(4,4,Robot::Robot::NORTH)
        expect( robot.move ).to eql(message)
      end

      it "should complain when moving from 4,4, SOUTH" do
        robot.place(4,4,Robot::Robot::EAST)
        expect( robot.move ).to eql(message)
      end
    end
  end
end