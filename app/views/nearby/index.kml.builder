xml.instruct! :xml
xml.kml(:xmlns => "http://earth.google.com/kml/2.2", 'xmlns:atom' => "http://www.w3.org/2005/Atom") do
  xml.Document {
    xml.name
    xml.Placemark(:id => 99999999) {
      xml.name "You are here"
      xml.Point {
        xml.coordinates "#{@latlon[1]},#{@latlon[0]}"
      }
      xml.Style {
        xml.IconStyle {
          xml.Icon {
            xml.href "http://www.iamnear.net/images/home-marker.png"
          }
        }
      }
    }
    @places.each do |place|
      xml.Placemark(:id => place.id) {
        xml.name {
          xml.cdata! place.name
        } 
        xml.description {
          xml.cdata! place.description
        }
        xml.tag! 'atom:link', "http://www.example.com"
        xml.Point {
          xml.coordinates "#{place.longitude},#{place.latitude}"
        }
      }
    end
  }
end