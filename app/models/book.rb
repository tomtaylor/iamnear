class Book < ActiveRecord::Base
  
  validates_presence_of :title
  validates_presence_of :longitude
  validates_presence_of :latitude

  acts_as_mappable :lat_column_name => "latitude", :lng_column_name => "longitude"
  
  def self.import_all!
    destroy_all
    
    doc = Nokogiri::XML(open("#{Rails.root}/data/books.xml"))
    doc.xpath("//marker").each do |marker|
      book = new
      book.title = marker.xpath('title').first.content
      book.author = marker.xpath('author').first.content
      book.publisher = marker.xpath('publisher').first.content
      book.comment = marker.xpath('comment').first.content
      book.image_url = marker.xpath('image').first.content
      book.longitude = marker.xpath('lng').first.content
      book.latitude = marker.xpath('lat').first.content
      book.save!
    end
  end
  
  def name
    title
  end
  
  def description
    "<img src='#{self.image_url}' style='float: left; margin: 5px 5px 5px 0;' /><strong>By #{self.author}.</strong> #{self.comment}"
  end
  
end
