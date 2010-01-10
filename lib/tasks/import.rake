desc "I Am Near tasks"
namespace :iamnear do
  
  desc "Download pubs data"
  task :fetch do
    system("wget http://www.informationfreeway.org/api/0.5/node[amenity=pub][bbox=-6,50,2,61] -O #{RAILS_ROOT}/data/pubs.osm")
  end
  
  desc "Import from OSM file"
  task :import => :environment do
    require 'hpricot'
    
    Pub.transaction do
      Pub.destroy_all # kill the existing ones
    
      source = File.join(RAILS_ROOT, 'data/pubs.osm')
    
      doc = Hpricot.XML(open(source))
    
      doc.search("//node").each do |node|
        p = Pub.new
        p.longitude = node.attributes['lon']
        p.latitude = node.attributes['lat']
        %w(name).each do |attr|
          p[attr] = node.at("//tag[@k='#{attr}']")['v'] if node.at("//tag[@k='#{attr}']")
        end
        if p.save
          puts "#{p.name}... saved"
        else
          puts "#{p.name}... failed"
        end
      end
    end
  end
end