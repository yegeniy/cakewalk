require 'open-uri' 
require 'rexml/document' 

# Retrieve geocode information for all records in the Stores table 
task :google_geocode => :environment do 
api_key="ABQIAAAAxEu4zYabDH1ybGR2fHbcZxSIOG_jcHTbyiVdF_0wDxeB8HluTRS8uPj0RuK03a-gofElARj0S6zaTQ" 
	(Store.find :all).each do |store| 
	puts "\nStore: #{store.name}" 
	puts "Source Address: #{store.full_address}" 
	xml=open("http://maps.google.com/maps/geo?q=#{CGI.escape(store.full_address)}&output=xml&key=#{api_key}").read 
	doc=REXML::Document.new(xml) 
	puts "Status: "+doc.elements['//kml/Response/Status/code'].text 
	if doc.elements['//kml/Response/Status/code'].text != '200' 
	puts "Unable to parse Google response for #{store.name}" 
	else 
	doc.root.each_element('//Response') do |response| 
	response.each_element('//Placemark') do |place|      
	lng,lat=place.elements['//coordinates'].text.split(',') 

	puts "Result Address: " << place.elements['//address'].text 
	puts "  Latitude: #{lat}" 
	puts "  Longitude: #{lng}" 
end # end each place 
end # end each response 
end # end if result == 200 
end # end each store 
end # end rake task 
