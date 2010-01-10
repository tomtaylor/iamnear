require File.dirname(__FILE__) + '/spec_helper.rb'
require 'pp'
require 'uri'

module Analytics
  class Property
    include HappyMapper
    
    tag 'property'
    namespace 'dxp'
    attribute :name, String
    attribute :value, String
  end
  
  class Entry
    include HappyMapper
    
    tag 'entry'
    element :id, String
    element :updated, DateTime
    element :title, String
    element :table_id, String, :namespace => 'dxp', :tag => 'tableId'
    has_many :properties, Property
  end
  
  class Feed
    include HappyMapper
    
    tag 'feed'
    element :id, String
    element :updated, DateTime
    element :title, String
    has_many :entries, Entry
  end
end

class Feature
  include HappyMapper
  element :name, String, :tag => '.|.//text()'
end

class FeatureBullet
  include HappyMapper

  tag 'features_bullets'
  has_many :features, Feature
  element :bug, String
end

class Product
  include HappyMapper

  element :title, String
  has_one :feature_bullets, FeatureBullet
end

module FamilySearch
  class Person
    include HappyMapper
    
    attribute :version, String
    attribute :modified, Time
    attribute :id, String
  end
  
  class Persons
    include HappyMapper
    has_many :person, Person
  end
  
  class FamilyTree
    include HappyMapper
    
    tag 'familytree'
    attribute :version, String
    attribute :status_message, String, :tag => 'statusMessage'
    attribute :status_code, String, :tag => 'statusCode'
    has_one :persons, Persons
  end
end

module FedEx
  class Address
    include HappyMapper
    
    tag 'Address'
    namespace 'v2'
    element :city, String, :tag => 'City'
    element :state, String, :tag => 'StateOrProvinceCode'
    element :zip, String, :tag => 'PostalCode'
    element :countrycode, String, :tag => 'CountryCode'
    element :residential, Boolean, :tag => 'Residential'
  end
  
  class Event
    include HappyMapper
    
    tag 'Events'
    namespace 'v2'
    element :timestamp, String, :tag => 'Timestamp'
    element :eventtype, String, :tag => 'EventType'
    element :eventdescription, String, :tag => 'EventDescription'
    has_one :address, Address
  end
  
  class PackageWeight
    include HappyMapper
    
    tag 'PackageWeight'
    namespace 'v2'
    element :units, String, :tag => 'Units'
    element :value, Integer, :tag => 'Value'
  end
  
  class TrackDetails
    include HappyMapper
    
    tag 'TrackDetails'
    namespace 'v2'
    element   :tracking_number, String, :tag => 'TrackingNumber'
    element   :status_code, String, :tag => 'StatusCode'
    element   :status_desc, String, :tag => 'StatusDescription'
    element   :carrier_code, String, :tag => 'CarrierCode'
    element   :service_info, String, :tag => 'ServiceInfo'
    has_one   :weight, PackageWeight, :tag => 'PackageWeight'
    element   :est_delivery,  String, :tag => 'EstimatedDeliveryTimestamp'
    has_many  :events, Event
  end 
    
  class Notification
    include HappyMapper
    
    tag 'Notifications'
    namespace 'v2'
    element :severity, String, :tag => 'Severity'
    element :source, String, :tag => 'Source'
    element :code, Integer, :tag => 'Code'
    element :message, String, :tag => 'Message'
    element :localized_message, String, :tag => 'LocalizedMessage'
  end
  
  class TransactionDetail
    include HappyMapper
    
    tag 'TransactionDetail'
    namespace 'v2'
    element :cust_tran_id, String, :tag => 'CustomerTransactionId'
  end
  
  class TrackReply
    include HappyMapper
    
    tag 'TrackReply'
    namespace 'v2'
    element   :highest_severity, String, :tag => 'HighestSeverity'
    element   :more_data, Boolean, :tag => 'MoreData'
    has_many  :notifications, Notification, :tag => 'Notifications'
    has_many  :trackdetails, TrackDetails, :tag => 'TrackDetails'
    has_one   :tran_detail, TransactionDetail, :tab => 'TransactionDetail'
  end
end

class Place
  include HappyMapper
  element :name, String
end

class Radar
  include HappyMapper
  has_many :places, Place
end

class Post
  include HappyMapper
  
  attribute :href, String
  attribute :hash, String
  attribute :description, String
  attribute :tag, String
  attribute :time, Time
  attribute :others, Integer
  attribute :extended, String
end

class User  
  include HappyMapper
  
  element :id, Integer
  element :name, String
  element :screen_name, String
  element :location, String
  element :description, String
  element :profile_image_url, String
  element :url, String
  element :protected, Boolean
  element :followers_count, Integer
end

class Status
  include HappyMapper
  
  element :id, Integer
  element :text, String
	element :created_at, Time
	element :source, String
	element :truncated, Boolean
	element :in_reply_to_status_id, Integer
	element :in_reply_to_user_id, Integer
	element :favorited, Boolean
	element :non_existent, String, :tag => 'dummy', :namespace => 'fake'
	has_one :user, User
end

class CurrentWeather
  include HappyMapper
  
  tag 'ob'
  namespace 'aws'
  element :temperature, Integer, :tag => 'temp'
  element :feels_like, Integer, :tag => 'feels-like'
  element :current_condition, String, :tag => 'current-condition', :attributes => {:icon => String}
end

class Address
  include HappyMapper
  
  tag 'address'
  element :street, String
  element :postcode, String
  element :housenumber, String
  element :city, String
  element :country, String
end

# for type coercion
class ProductGroup < String; end

module PITA
  class Item
    include HappyMapper
    
    tag 'Item' # if you put class in module you need tag
    element :asin, String, :tag => 'ASIN'
    element :detail_page_url, URI, :tag => 'DetailPageURL', :parser => :parse
    element :manufacturer, String, :tag => 'Manufacturer', :deep => true
    element :point, String, :tag => 'point', :namespace => 'georss'
    element :product_group, ProductGroup, :tag => 'ProductGroup', :deep => true, :parser => :new, :raw => true
  end

  class Items
    include HappyMapper
    
    tag 'Items' # if you put class in module you need tag
    element :total_results, Integer, :tag => 'TotalResults'
    element :total_pages, Integer, :tag => 'TotalPages'
    has_many :items, Item
  end
end

module GitHub
  class Commit
    include HappyMapper

    tag "commit"
    element :url, String
    element :tree, String
    element :message, String
    element :id, String
    element :'committed-date', Date
  end
end

describe HappyMapper do
  
  describe "being included into another class" do
    before do
      @klass = Class.new do
        include HappyMapper
        
        def self.to_s
          'Foo'
        end
      end
    end
    
    it "should set attributes to an array" do
      @klass.attributes.should == []
    end
    
    it "should set @elements to a hash" do
      @klass.elements.should == []
    end
    
    it "should allow adding an attribute" do
      lambda {
        @klass.attribute :name, String
      }.should change(@klass, :attributes)
    end
    
    it "should allow adding an attribute containing a dash" do
      lambda {
        @klass.attribute :'bar-baz', String
      }.should change(@klass, :attributes)
    end

    it "should be able to get all attributes in array" do
      @klass.attribute :name, String
      @klass.attributes.size.should == 1
    end
    
    it "should allow adding an element" do
      lambda {
        @klass.element :name, String
      }.should change(@klass, :elements)
    end

    it "should allow adding an element containing a dash" do
      lambda {
        @klass.element :'bar-baz', String
      }.should change(@klass, :elements)

    end
    
    it "should be able to get all elements in array" do
      @klass.element(:name, String)
      @klass.elements.size.should == 1
    end
    
    it "should allow has one association" do
      @klass.has_one(:user, User)
      element = @klass.elements.first
      element.name.should == 'user'
      element.type.should == User
      element.options[:single] = true
    end
    
    it "should allow has many association" do
      @klass.has_many(:users, User)
      element = @klass.elements.first
      element.name.should == 'users'
      element.type.should == User
      element.options[:single] = false
    end

    it "should default tag name to lowercase class" do
      @klass.tag_name.should == 'foo'
    end
    
    it "should default tag name of class in modules to the last constant lowercase" do
      module Bar; class Baz; include HappyMapper; end; end
      Bar::Baz.tag_name.should == 'baz'
    end
    
    it "should allow setting tag name" do
      @klass.tag('FooBar')
      @klass.tag_name.should == 'FooBar'
    end
    
    it "should allow setting a namespace" do
      @klass.namespace(namespace = "foo")
      @klass.namespace.should == namespace
    end

    it "should provide #parse" do
      @klass.should respond_to(:parse)
    end
  end
  
  describe "#attributes" do
    it "should only return attributes for the current class" do
      Post.attributes.size.should == 7
      Status.attributes.size.should == 0
    end
  end
  
  describe "#elements" do
    it "should only return elements for the current class" do
      Post.elements.size.should == 0
      Status.elements.size.should == 10
    end
  end
  
  it "should parse xml attributes into ruby objects" do
    posts = Post.parse(fixture_file('posts.xml'))
    posts.size.should == 20
    first = posts.first
    first.href.should == 'http://roxml.rubyforge.org/'
    first.hash.should == '19bba2ab667be03a19f67fb67dc56917'
    first.description.should == 'ROXML - Ruby Object to XML Mapping Library'
    first.tag.should == 'ruby xml gems mapping'
    first.time.should == Time.utc(2008, 8, 9, 5, 24, 20)
    first.others.should == 56
    first.extended.should == 'ROXML is a Ruby library designed to make it easier for Ruby developers to work with XML. Using simple annotations, it enables Ruby classes to be custom-mapped to XML. ROXML takes care of the marshalling and unmarshalling of mapped attributes so that developers can focus on building first-class Ruby classes.'
  end
  
  it "should parse xml elements to ruby objcts" do
    statuses = Status.parse(fixture_file('statuses.xml'))
    statuses.size.should == 20
    first = statuses.first
    first.id.should == 882281424
    first.created_at.should == Time.utc(2008, 8, 9, 5, 38, 12)
    first.source.should == 'web'
    first.truncated.should be_false
    first.in_reply_to_status_id.should == 1234
    first.in_reply_to_user_id.should == 12345
    first.favorited.should be_false
    first.user.id.should == 4243
    first.user.name.should == 'John Nunemaker'
    first.user.screen_name.should == 'jnunemaker'
    first.user.location.should == 'Mishawaka, IN, US'
    first.user.description.should == 'Loves his wife, ruby, notre dame football and iu basketball'
    first.user.profile_image_url.should == 'http://s3.amazonaws.com/twitter_production/profile_images/53781608/Photo_75_normal.jpg'
    first.user.url.should == 'http://addictedtonew.com'
    first.user.protected.should be_false
    first.user.followers_count.should == 486
  end
  
  it "should parse xml containing the desired element as root node" do
    address = Address.parse(fixture_file('address.xml'), :single => true)
    address.street.should == 'Milchstrasse'
    address.postcode.should == '26131'
    address.housenumber.should == '23'
    address.city.should == 'Oldenburg'
    address.country.should == 'Germany'
  end

  it "should parse xml with default namespace (amazon)" do
    file_contents = fixture_file('pita.xml')
    items = PITA::Items.parse(file_contents, :single => true)
    items.total_results.should == 22
    items.total_pages.should == 3
    first  = items.items[0]
    second = items.items[1]
    first.asin.should == '0321480791'
    first.point.should == '38.5351715088 -121.7948684692'
    first.detail_page_url.should be_a_kind_of(URI)
    first.detail_page_url.to_s.should == 'http://www.amazon.com/gp/redirect.html%3FASIN=0321480791%26tag=ws%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/0321480791%253FSubscriptionId=dontbeaswoosh'
    first.manufacturer.should == 'Addison-Wesley Professional'
    first.product_group.should == '<ProductGroup>Book</ProductGroup>'
    second.asin.should == '047022388X'
    second.manufacturer.should == 'Wrox'
  end

  it "should parse xml that has attributes of elements" do
    items = CurrentWeather.parse(fixture_file('current_weather.xml'))
    first = items[0]
    first.temperature.should == 51
    first.feels_like.should == 51
    first.current_condition.should == 'Sunny'
    first.current_condition.icon.should == 'http://deskwx.weatherbug.com/images/Forecast/icons/cond007.gif'
  end

  it "should parse xml with nested elements" do
    radars = Radar.parse(fixture_file('radar.xml'))
    first = radars[0]
    first.places.size.should == 1
    first.places[0].name.should == 'Store'
    second = radars[1]
    second.places.size.should == 0
    third = radars[2]
    third.places.size.should == 2
    third.places[0].name.should == 'Work'
    third.places[1].name.should == 'Home'
  end
  
  it "should parse xml that has elements with dashes" do
    commit = GitHub::Commit.parse(fixture_file('commit.xml'))
    commit.message.should == "move commands.rb and helpers.rb into commands/ dir"
    commit.url.should == "http://github.com/defunkt/github-gem/commit/c26d4ce9807ecf57d3f9eefe19ae64e75bcaaa8b"
    commit.id.should == "c26d4ce9807ecf57d3f9eefe19ae64e75bcaaa8b"
    commit.committed_date.should == Date.parse("2008-03-02T16:45:41-08:00")
    commit.tree.should == "28a1a1ca3e663d35ba8bf07d3f1781af71359b76"
  end
  
  it "should parse xml with no namespace" do
    product = Product.parse(fixture_file('product_no_namespace.xml'), :single => true)
    product.title.should == "A Title"
    product.feature_bullets.bug.should == 'This is a bug'
    product.feature_bullets.features.size.should == 2
    product.feature_bullets.features[0].name.should == 'This is feature text 1'
    product.feature_bullets.features[1].name.should == 'This is feature text 2'
  end
  
  it "should parse xml with default namespace" do
    product = Product.parse(fixture_file('product_default_namespace.xml'), :single => true)
    product.title.should == "A Title"
    product.feature_bullets.bug.should == 'This is a bug'
    product.feature_bullets.features.size.should == 2
    product.feature_bullets.features[0].name.should == 'This is feature text 1'
    product.feature_bullets.features[1].name.should == 'This is feature text 2'
  end
  
  it "should parse xml with single namespace" do
    product = Product.parse(fixture_file('product_single_namespace.xml'), :single => true)
    product.title.should == "A Title"
    product.feature_bullets.bug.should == 'This is a bug'
    product.feature_bullets.features.size.should == 2
    product.feature_bullets.features[0].name.should == 'This is feature text 1'
    product.feature_bullets.features[1].name.should == 'This is feature text 2'
  end
  
  it "should parse xml with multiple namespaces" do
    track = FedEx::TrackReply.parse(fixture_file('multiple_namespaces.xml'))
    track.highest_severity.should == 'SUCCESS'
    track.more_data.should be_false
    notification = track.notifications.first
    notification.code.should == 0
    notification.localized_message.should == 'Request was successfully processed.'
    notification.message.should == 'Request was successfully processed.'
    notification.severity.should == 'SUCCESS'
    notification.source.should == 'trck'
    detail = track.trackdetails.first
    detail.carrier_code.should == 'FDXG'
    detail.est_delivery.should == '2009-01-02T00:00:00'
    detail.service_info.should == 'Ground-Package Returns Program-Domestic'
    detail.status_code.should == 'OD'
    detail.status_desc.should == 'On FedEx vehicle for delivery'
    detail.tracking_number.should == '9611018034267800045212'
    detail.weight.units.should == 'LB'
    detail.weight.value.should == 2
    events = detail.events
    events.size.should == 10
    first_event = events[0]
    first_event.eventdescription.should == 'On FedEx vehicle for delivery'
    first_event.eventtype.should == 'OD'
    first_event.timestamp.should == '2009-01-02T06:00:00'
    first_event.address.city.should == 'WICHITA'
    first_event.address.countrycode.should == 'US'
    first_event.address.residential.should be_false
    first_event.address.state.should == 'KS'
    first_event.address.zip.should == '67226'
    last_event = events[-1]
    last_event.eventdescription.should == 'In FedEx possession'
    last_event.eventtype.should == 'IP'
    last_event.timestamp.should == '2008-12-27T09:40:00'
    last_event.address.city.should == 'LONGWOOD'
    last_event.address.countrycode.should == 'US'
    last_event.address.residential.should be_false
    last_event.address.state.should == 'FL'
    last_event.address.zip.should == '327506398'
    track.tran_detail.cust_tran_id.should == '20090102-111321'
  end
  
  it "should be able to parse google analytics api xml" do
    data = Analytics::Feed.parse(fixture_file('analytics.xml'))
    data.id.should == 'http://www.google.com/analytics/feeds/accounts/nunemaker@gmail.com'
    data.entries.size.should == 4
    
    entry = data.entries[0]
    entry.title.should == 'addictedtonew.com'
    entry.properties.size.should == 4
    
    property = entry.properties[0]
    property.name.should == 'ga:accountId'
    property.value.should == '85301'
  end
  
  it "should allow instantiating with a string" do
    module StringFoo
      class Bar
        include HappyMapper
        has_many :things, 'StringFoo::Thing'
      end
      
      class Thing
        include HappyMapper
      end
    end
  end
  
  xit "should parse family search xml" do
    tree = FamilySearch::FamilyTree.parse(fixture_file('family_tree.xml'))
    tree.version.should == '1.0.20071213.942'
    tree.status_message.should == 'OK'
    tree.status_code.should == '200'
    # tree.people.size.should == 1
    # tree.people.first.version.should == '1199378491000'
    # tree.people.first.modified.should == Time.utc(2008, 1, 3, 16, 41, 31) # 2008-01-03T09:41:31-07:00
    # tree.people.first.id.should == 'KWQS-BBQ'
  end
end
