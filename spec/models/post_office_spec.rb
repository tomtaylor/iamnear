require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostOffice do
  before(:each) do
    @post_office = PostOffice.new
  end

  it "should be valid" do
    @post_office.should be_valid
  end
end
