/* Reference code from http://gmaps-samples-v3.googlecode.com/svn/trunk/sidebar/random-markers.html
 * 	has a nice style which we could use for an object oriented approach to javascript. Notice how
 * 	the Demo is a dictionary (a.k.a. hash).
 * I think we can use this structure to compartmentalize some of our code.
 * It's getting to be rather monolothic here.
 */
/** I want to be able to click on a map and create points with each click. 
 * 	 The points should give a popup form through which they can be updated.
 * 	Subsequent points should be connected by a line representing the edge between them.
 * 	 The edge should be saved automatically.
 *   Eventually the line should be any shape between two points.
 *  After a path is complete it should be given a name?
 *
 *  NOTE: I want a point to be created even if the form is not filled out.
 *   So basically an empty point is created along with the marker.
 *   Then, clicking on the marker reveals an infoWindow with a form and a 'Save' button
 *   Clicking 'Save' passes the form into the edit method of the point controller.
 *   A similar procedure can be applied for edges and paths.
 *
 *  NOTE: A note on info windows.
 *   As far as I can tell, their content is associated with their location
 *    (or optionally, an anchor). They are not otherwise associated
 **/
var map; // Will be set to a Map object
var poly; // Will be set to a Polyline object
alert('before newPointForm declaration');

///* This is the content for a new infoWindow.
var newPointForm;

alert('after newPointForm declaration');


function openInfoWindow(infoWindow, marker){
    // Close the last selected marker before opening this one.
    if (Demo.visibleInfoWindow) {
        Demo.visibleInfoWindow.close();
    }
    
    infoWindow.open(map, marker);
    Demo.visibleInfoWindow = infoWindow;
}


/**
 * Opens an info window above the marker and displays a form!
 * TODO: Set the marker's info window's content to that of the point.
 * @param {Object} marker is a google maps Marker object.
 */
function markerInfoWindow(marker){
    infoWindow
}

/**
 * Handles click events on a map:
 *  adds a new marker to the Polyline.
 *  creates a new Point for that marker.
 *
 * Create a marker at the coordinate that was clicked.
 *  Then, assign a click listener to the marker that pops open an info window over the marker.
 * @param {MouseEvent} mouseEvent
 */
function addToPath(event){
    var path = poly.getPath();
    // Because path is an MVCArray, we can simply append a new coordinate
    // and it will automatically appear
    path.push(event.latLng);
    
    /* Add a new marker at the new plotted point on the polyline.
     * Note that a marker is just the visual marker on the map.
     */
    var marker = new google.maps.Marker({
        position: event.latLng,
        //title: '#' + path.getLength(),
        map: map
    });
    
    //FIXME: Does the content of the infoWindow get reset to newPointForm at each call? Or does the marker "block" the DomListener which invokes addToPath? 
    var infoWindow = new google.maps.InfoWindow({
        content: newPointForm
    })
    //TODO: Save the marker as a point
    // Add marker click event listener.
    alert('entering marker InfoWindow');
    //google.maps.event.addListener(marker, 'click', markerInfoWindow(marker));
    
    // Opens an infowindow over the 
    google.maps.event.addListener(marker, 'click', function(){
        infoWindow.open(map, marker);
    });
    
    
    
    
    alert('exiting marker InfoWindow');
    //var point


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
    //poly.setMap(map); // not needed since there's only one map?
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
    
	//FIXME: This is not a very useful newPointForm...
    newPointForm = "<fieldset style='width:150px;'>" +
    "<legend>New Point</legend>" +
    "<label for='name'>Name</label>" +
    "<input type='text' id='name' name='m[name]' style='width:100%;'/>" +
    "<label for='comment'>Comment</label>" +
    "<input type='text' id='comment' name='m[comment]' style='width:100%;'/>" +
    "<input type='submit' value='Save'/>" +
    "</fieldset>";
    alert('before addToPath listener is declared');
    
    // Add a listener for click events in the map
    google.maps.event.addListener(map, 'click', addToPath);
    
};

alert('about to call init');
google.maps.event.addDomListener(window, 'load', init);

