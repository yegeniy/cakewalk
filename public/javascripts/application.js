



var centerLatitude = 42.368078;
var centerLongitude = -71.257064;
var startZoom = 16;
var map;
function init()
{
  if (GBrowserIsCompatible()) {
	map = new GMap2(document.getElementById("map"));
	map.addControl(new GSmallMapControl());
	map.addControl(new GMapTypeControl());
	map.setCenter(new GLatLng(42.368089,-71.258698), startZoom);
	var location = new GLatLng(centerLatitude, centerLongitude);
	var marker = new GMarker(location);
	//map.addOverlay(marker);
	var location2 = new GLatLng(42.365734,-71.260757);
	var marker1 = new GMarker(location2);
	//map.addOverlay(marker1);
	GEvent.addListener(map, "click", function(overlay, latlng) {
	var marker = new GMarker(latlng)
	//map.addOverlay(marker);
  });
 GEvent.addListener(map, "click", function(overlay, latlng) {
	//create an HTML DOM form element
	var inputForm = document.createElement("form");
	inputForm.setAttribute("action","");
	inputForm.onsubmit = function() { createMarker(); return false;};
	//retrieve the longitude and lattitude of the click point
	var lng = latlng.lng();
	var lat = latlng.lat();
	inputForm.innerHTML = '<fieldset style="width:150px;">'
	+ '<legend>New Point</legend>'
	+ '<label for="name">Name</label>'
	+ '<input type="text" id="name" name="m[name]" style="width:100%;"/>'
	//+ '<label for="city"></label>'
	//+ '<input type="text" id="city" name="m[city]" style="width:100%;"/>'
	//+ '<label for="state">State</label>'
	//+ '<input type="text" id="state" name="m[state]" style="width:100%;"/>'
	+ '<label for="comment">Comment</label>'
	+ '<input type="text" id="comment" name="m[comment]" style="width:100%;"/>'
	+ '<input type="submit" value="Save"/>'

	+ '<input type="hidden" id="longitude" name="m[lng]" value="'+ lng +'"/>'
	+ '<input type="hidden" id="latitude" name="m[lat]" value="' + lat + '"/>'
	+ '</fieldset>';
	
map.openInfoWindow (latlng,inputForm);

});
}

}
function addMarkerToMap(latlng, html) {
var marker = new GMarker(latlng);
GEvent.addListener(marker, 'click', function() {
var markerHTML = html;
marker.openInfoWindowHtml(markerHTML);
});
return marker;
}

function createMarker(){
var lng = document.getElementById("longitude").value;
var lat = document.getElementById("latitude").value;

var getVars = "?m[name]=" + document.getElementById("name").value
+ "&m[comment]=" + document.getElementById("comment").value
+ "&m[lng]=" + lng
+ "&m[lat]=" + lat ;
var request = GXmlHttp.create();

//call the create action back on the server
request.open('GET', 'create' + getVars, true);
request.onreadystatechange = function() {
if (request.readyState == 4) {
//the request is complete
 
var success=false;
var content='Error contacting web service';
try {
//parse the result to JSON (simply by eval-ing it)
res=eval( "(" + request.responseText + ")" );
content=res.content;
success=res.success;
}catch (e){
success=false;
}
//check to see if it was an error or success
if(!success) {
} else {
//create a new marker and add its info window
var latlng = new GLatLng(parseFloat(lat),parseFloat(lng));
var marker = addMarkerToMap(latlng, content);
map.addOverlay(marker);}
}
}

//create a new marker and add its info window
//var latlng = new GLatLng(parseFloat(lat),parseFloat(lng));
//var marker = addMarkerToMap(latlng, content);
//map.addOverlay(marker);
//map.closeInfoWindow();
request.send(null);
return false;
}



window.onload = init;
window.onunload = GUnload;