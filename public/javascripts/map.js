var map;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();


function initGSearch(canvas) {

	directionsDisplay = new google.maps.DirectionsRenderer();

	var myLatlng = new google.maps.LatLng(42.365405,-71.257178);

	var myOptions = {
		zoom: 8,
		center: myLatlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		
	};
	var id = document.getElementById("map_canvas");
	map = new google.maps.Map(canvas,myOptions); 
	directionsDisplay.setMap(map);
	directionsDisplay.setPanel(document.getElementById("directionsPanel"));

}

function getDirections(start, end){
	var request = {
		origin: start, 
		destination: end,
		travelMode: google.maps.DirectionsTravelMode.WALKING
	};
	directionsService.route({origin: start, destination: end, travelMode: google.maps.DirectionsTravelMode.DRIVING}, function(response, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(response);
		}
	});
}








