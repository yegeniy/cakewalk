// Reference code from http://gmaps-samples-v3.googlecode.com/svn/trunk/sidebar/random-markers.html
/** I want to be able to click on a map and create points with each click. 
 * 	Also, the points should be connected by a line representing the edge between them.
 * 	The edge should be
 *   Eventually the line should be any shape between two points.
 **/
var map;
//mapContainer: document.getElementById('mapContainer'),
//sideContainer: document.getElementById('sideContainer'),
//generateLink: document.getElementById('generateLink'),
//numMarkers: 40,
//markers: [],
var poly;
//visibleInfoWindow: null,
/*
function generateTriggerCallback(object, eventType){
    return function(){
        google.maps.event.trigger(object, eventType);
    };
};

function openInfoWindow(infoWindow, marker){
    return function(){
        // Close the last selected marker before opening this one.
        if (Demo.visibleInfoWindow) {
            Demo.visibleInfoWindow.close();
        }
        
        infoWindow.open(Demo.map, marker);
        Demo.visibleInfoWindow = infoWindow;
    };
};
*/
/**
 * Handles click events on a map, and adds a new point to the Polyline.
 * @param {MouseEvent} mouseEvent
 */
 function addLatLng(event){
 	var path = poly.getPath();
 	// Because path is an MVCArray, we can simply append a new coordinate
		// and it will automatically appear
		path.push(event.latLng);
		//TODO:  add marker to polyline
		// Add a new marker at the new plotted point on the polyline.
		var marker = new google.maps.Marker({
			position: event.latLng,
			title: '#' + path.getLength(),
			map: map
		});
	};
//TODO: Create the point from the marker's info and other info?


// TODO: Write tests. 
/**
 * displays a marker on the map.
 * stores the marker's position as a point in the database
 * @param {Object} selectedLatLng
 *
 createPoint: function(selectedLatLng){
 return function() {
 // TODO: Where do
 }
 } ,
 */

function init(){
    // Generate map with some center. TODO: Change center to something sensible.
    var firstLatLng = new google.maps.LatLng(37.4419, -122.1419);
    //alert('firstLatLng made?');
    
    // Initialize polyline
    var polyOptions = {
        strokeColor: '#000000',
        strokeOpacity: 1.0,
        strokeWeight: 3
    }
    poly = new google.maps.Polyline(polyOptions);
    //Demo.poly.setMap(map);
    //alert('poly stroke weight is ' + poly.strokeWeight);
    
    mapContainer = document.getElementById('mapContainer');
    //alert('mapContainer is' + mapContainer);
    map = new google.maps.Map(mapContainer, {
        zoom: 12,
        center: firstLatLng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    //alert('map should have been made I think?');
    // Initialize polyline
    var polyOptions = {
        strokeColor: '#000000',
        strokeOpacity: 1.0,
        strokeWeight: 3
    }
    poly = new google.maps.Polyline(polyOptions);
    poly.setMap(map);
	
  
  	// Add a listener for the click event
    google.maps.event.addListener(map, 'click', addLatLng);
  
	
	
	
};
/*// Show generate link only after map tiles finish loading.
 google.maps.event.addListener(Demo.map, 'tilesloaded', function() {
 Demo.generateLink.style.display = 'block';
 });
 // Add onclick handler to generate link.
 google.maps.event.addDomListener(Demo.generateLink, 'click', function() {
 Demo.generateRandomMarkers(Demo.map.getCenter());
 });
 // Add a listener for the click event
 google.maps.event.addListener(Demo.map, 'click', addLatLng);
 
 // Generate markers against map center.
 google.maps.event.trigger(Demo.generateLink, 'click');*/
//  }


//alert('about to load Demo.init');
google.maps.event.addDomListener(window, 'load', init);

