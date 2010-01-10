# require File.dirname(__FILE__) + '/../spec_helper'
# 
# def valid_place_attributes
#   {
#     :name => "testing",
#     :longitude => 1.0,
#     :latitude => 51.0,
#   }
# end
# 
# describe Place, "which is new" do
#   
#   before(:each) do
#     @place = Place.new
#   end
#   
#   it "should be invalid without a valid url" do
#     @place.attributes = valid_place_attributes.except(:url)
#     
#     ["waffles.com", " http://www.tomtaylor.co.uk", "http://bob"].each do |url|
#       @place.url = url
#       @place.should_not be_valid
#     end
#     
#     ["http://www.tomtaylor.co.uk"].each do |url|
#       @place.url = url
#       @place.should be_valid
#     end
#   end
# end