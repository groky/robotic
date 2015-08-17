require 'spec_helper'

describe Robot::Table do

  describe "#new" do
    it "should create a new table" do
      Robot::Table.new
    end
  end

  describe "#has_point?" do
    subject(:table) { Robot::Table.new }

    context "when on the table" do
      it "should have the point" do
        expect(table.has_point?(0,3)).to be_truthy
      end
    end
  end
end
