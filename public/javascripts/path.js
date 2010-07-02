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
var visibleInfoWindow; //Will be used to set the current, open info window.
//var newPointForm; // Will be an HTML object stored in an InfoWindow
var pointIds = []; //Will hold an ordered list of the point ids. Can traverse this list to create edges. 

/**
 * Opens selected infoWindow over the selected marker
 * after closing the previously opened infoWindow
 * NOTE: If this wrapper function is omitted from the click listener at marker,
 * 	then only data in the first open infoWindow will be saved to the database... I think.
 * @param {Object} infoWindow
 * @param {Object} marker
 */
function openInfoWindow(infoWindow, marker){
    // Close the last selected marker before opening this one.
    if (visibleInfoWindow) {
        visibleInfoWindow.close();
    }
    
    infoWindow.open(map, marker);
    visibleInfoWindow = infoWindow;
}

/**
 * Extracts data from marker and infoWindow and saves it into a point object
 * NOTE: See page 53+ in "Beginning Google Maps Applications with Rails and Ajax" for reference
 * 	Listing 3-6 has the controller code
 * "in the HTML form we displayed on the map, the fields were named in an m[fieldname]
 bracketed format—for example, m[lat]. When aform is submitted to aRails action using the bracketed format,
 ActiveView converts all the bracketed strings to ahash, in this case under the key :m.
 After the action creates the marker, it saves it. Finally, it renders aJSON structure with two
 keys, :successand :content, which indicate whether the action is successful, and the HTML
 to be displayed, respectively. "
 * TODO: Can probably copy operate_marker and its controller
 * Looks like the XMLHttpRequest is what I need to use since GXmlHttp doesn't exist in Google Maps JS API V3
 * Following http://code.google.com/apis/maps/articles/phpsqlinfo_v3.html
 */
function saveData(){//marker, infoWindow){
    //    alert('entering saveData()');
    
    var name = escape(document.getElementById("name").value);
    var comment = escape(document.getElementById("comment").value);
    var lat = escape(document.getElementById("latitude").value);
    var lng = escape(document.getElementById("longitude").value);
    //    alert('in saveData()');
    var url = "../operate_marker/create?" + //FIXME: Might not be robust to url changes.
    "point[name]=" + //NOTE: N.B. that point[...] is used, which means edge[someEdgeParam] can be used too.
    name +
    "&point[comment]=" +
    comment +
    "&point[lat]=" +
    lat +
    "&point[lng]=" +
    lng;
    //  alert('in saveData()');
    downloadUrl(url, function(data, responseCode){
    
        // Check that the returned status code is 200. This means that the file was retrieved successfully and we can continue processing.
        // Check the length of the data string returned - an empty data file indicates that the request generated no error strings. If the length is zero, you can close the info window and output a success message. 
        if (responseCode == 200 && data.length <= 1) {
            infowindow.close();
            document.getElementById("message").innerHTML = "Location added.";// TODO: How does this work?
        }
    });
    //alert('in saveData()');
    //alert('in saveData');
	//alert('point Ids are: ' + pointIds);
};

/**
 * a simple function which wraps the XMLHTTPRequest object that lets you retrieve files (commonly in XML format) via JavaScript. 
 * The downloadUrl() callback function will provide you with the content of the URL and the status code. 
 * If you use a framework like jQuery or YUI, you may want to replace this function with their respective wrapper functions.
 * @param {Object} url
 * @param {Object} callback
 */
function downloadUrl(url, callback){
    // Create browser compatible http request
    var request = window.ActiveXObject ? new ActiveXObject('Microsoft.XMLHTTP') : new XMLHttpRequest;
    
    request.onreadystatechange = function(){
        if (request.readyState == 4) {
			
			var success = false;
            var content = 'Error contacting web service';
            try {
                //parse the result to JSON (simply by eval-ing it)
                res = eval("(" + request.responseText + ")");
                content = res.content;
                success = res.success;
				id = res.id;
				pointIds.push(id);
            }
            catch (e) {
                success = false;
            }
			
			
            request.onreadystatechange = doNothing;
            callback(request.responseText, request.status);
        }
    };
    
    request.open('GET', url, true);
    request.send(null);

}

function doNothing(){
}


/**
 * A form for passing data about a point associated with the event (invoked by clicking a marker)
 * 	form contains name, comment, longitude, and latitude for a point.
 * @param {MouseEvent} event
 */
function newPointForm(event){

    //FIXME: This is not a very useful newPointForm... Also, need something to control edges.
    //NOTE: The ".." in point[..] within the name parameters are passed into the controller I think.
    return "<fieldset style='width:150px;'>" +
    "<legend>New Point</legend>" +
    "<label for='name'>Name</label>" +
    "<input type='text' id='name' name='point[name]' style='width:100%;'/>" +
    "<label for='comment'>Comment</label>" +
    "<input type='text' id='comment' name='point[comment]' style='width:100%;'/>" +
    "<input type='submit' value='Save' onclick='saveData()'/>" +
    '<input type="hidden" id="longitude" name="point[lng]" value="' +
    event.latLng.lng() +
    '"/>' +
    '<input type="hidden" id="latitude" name="point[lat]" value="' +
    event.latLng.lat() +
    '"/>'
    "</fieldset>";
};

/**
 * Handles click events on a map:
 *  adds a new marker to the Polyline.
 *  creates a new Point for that marker.
 *
 * Create a marker at the coordinate that was clicked.
 *  Then, assign a click listener to the marker that pops open an info window over the marker.
 * @param {MouseEvent} event
 */
function addToMap(event){
    var path = poly.getPath();
    // Because path is an MVCArray, we can simply append a new coordinate
    // and it will automatically appear
    path.push(event.latLng);
    
    /* Add a new marker at the new plotted point on the polyline.
     * Note that a marker is just the visual marker on the map.
     */
    var marker = new google.maps.Marker({
        position: event.latLng,
        title: '#' + path.getLength(),
        map: map
    });
    

    
    //FIXME: The content of infoWindow is reset whenever it's closed. This is inconvenient, but acceptable for now.
    var infoWindow = new google.maps.InfoWindow({
        content: newPointForm(event)
    });
    //alert('added infoWidnow')
    // Opens an infowindow over the marker on click
    google.maps.event.addListener(marker, 'click', function(){
        openInfoWindow(infoWindow, marker);
    });
    
    
    //alert('added listener for infoWindow');
    //var point


};
//TODO: Create the point from the marker's info and other info?

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
    
    
    
    // Add a listener for click events in the map
    google.maps.event.addListener(map, 'click', addToMap);
    
};

//alert('about to call init');
google.maps.event.addDomListener(window, 'load', init);



// Jquery: Only checks for a click when document is ready
$(document).ready(function(){
    // Attach an event when div 'execute-search' is clicked
    $('#path_submit').click(function(){
		alert('hi');
        // Create the edges using the pointIds array
		alert(pointIds.length);
		getvars = pointIds;
		url = '/paths/create_edges' + getvars ;
		
		
		
		
		
//        for (var i in (pointIds.length -1) ) {
//			alert(i + 'in loop');
//			
//		}
    });
});


