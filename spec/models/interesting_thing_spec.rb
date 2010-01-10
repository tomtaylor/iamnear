require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InterestingThing do
  before(:each) do
    @interesting_thing = InterestingThing.new
  end

  it "should be valid" do
    @interesting_thing.should be_valid
  end
end
