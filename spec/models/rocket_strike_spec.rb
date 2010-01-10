require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RocketStrike do
  before(:each) do
    @rocket_strike = RocketStrike.new
  end

  it "should be valid" do
    @rocket_strike.should be_valid
  end
end
