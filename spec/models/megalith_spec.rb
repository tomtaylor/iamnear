# require File.dirname(__FILE__) + '/../spec_helper'
# 
# # describe Megalith do
# #   before(:each) do
# #     @megalith = Megalith.new
# #   end
# # 
# #   it "should be valid" do
# #     @megalith.should be_valid
# #   end
# # end
# 
# def valid_megalith_attributes
#   {
#     :name => "Big Stone",
#     :url => "http://www.tomtaylor.co.uk",
#     :longitude => 51.0,
#     :latitude => 1.0
#   }
# end
# 
# describe Megalith, "which is new" do
#   
#   before(:each) do
#     @megalith = Megalith.new
#   end
#   
#   it "should be invalid without a name" do
#     @megalith.attributes = valid_megalith_attributes.except(:name)
#     @megalith.should_not be_valid
#     @megalith.name = "Waffles"
#     @megalith.should be_valid
#   end
#   
#   it "should be invalid without a url" do
#     @megalith.attributes = valid_megalith_attributes.except(:url)
#     @megalith.should_not be_valid
#     @megalith.url = "http://www.tomtaylor.co.uk"
#     @megalith.should be_valid
#   end
#   
#   it "should be invalid without a longitude" do
#     @megalith.attributes = valid_megalith_attributes.except(:longitude)
#     @megalith.should_not be_valid
#     @megalith.longitude = 51.0
#     @megalith.should be_valid
#   end
#   
#   it "should be invalid without a latitude" do
#     @megalith.attributes = valid_megalith_attributes.except(:latitude)
#     @megalith.should_not be_valid
#     @megalith.latitude = 1.0
#     @megalith.should be_valid
#   end
#     
# end
# 
# describe Megalith, "which has been imported" do
#   
#   before(:all) do
#     Megalith.stub!(:source_path).and_return(asset_path('megalith.kml'))
#     Megalith.import_all!
#     @megalith = Megalith.find(:first)
#   end
#   
#   it "should have some megaliths" do
#     Megalith.count.should == 8614
#   end
#   
#   it "should have a name" do
#     @megalith.name.should == ''
#   end
#   
#   it "should have a url" do
#     @megalith.url.should == ''
#   end
#   
#   it "should have a longitude" do
#     @megalith.longitude.should == ''
#   end
#   
#   it "should have a latitude" do
#     @megalith.latitude.should == ''
#   end
#   
# end