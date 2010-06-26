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
map.addOverlay(marker);
var location2 = new GLatLng(42.365734,-71.260757);
var marker1 = new GMarker(location2);
map.addOverlay(marker1);
GEvent.addListener(map, "click", function(overlay, latlng) {
var marker = new GMarker(latlng)
map.addOverlay(marker);
});
GEvent.addListener(map, "click", function(overlay, latlng) {
//create an HTML DOM form element
var inputForm = document.createElement("form");
inputForm.setAttribute("action","");
inputForm.onsubmit = function() {createMarker(); return false;};
//retrieve the longitude and lattitude of the click point
var lng = latlng.lng();
var lat = latlng.lat();
inputForm.innerHTML = '<fieldset style="width:150px;">'
+ '<legend>New Marker</legend>'
+ '<label for="found">Found</label>'
+ '<input type="text" id="found" name="m[found]" style="width:100%;"/>'
+ '<label for="left">Left</label>'
+ '<input type="text" id="left" name="m[left]" style="width:100%;"/>'
+ '<input type="submit" value="Save"/>'
+ '<input type="hidden" id="longitude" name="m[lng]" value="'+ lng +'"/>'
+ '<input type="hidden" id="latitude" name="m[lat]" value="' + lat + '"/>'
+ '</fieldset>';
map.openInfoWindow (latlng,inputForm);
});
}
}
window.onload = init;
window.onunload = GUnload;