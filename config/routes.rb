ActionController::Routing::Routes.draw do |map|
  
  map.with_options(:conditions => {:subdomain => "www"}) do |main|
    main.root :controller => "home", :action => "index"
    main.connect 'oauth/:action', :controller => "oauth"
  end
  
  map.with_options(:conditions => {:subdomain => /^(?!www|admin)/i}) do |place|
    place.root :controller => "nearby", :action => "index"
    # place.kml 'kml', :controller => "nearby", :action => "index", :format => "kml"
  end
  
  
  
end
