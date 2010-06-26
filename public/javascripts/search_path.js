/* 
Author:Charu Jain
Homework 11
Description: Use jquery and AJAX 
Usage: run localhost:3000/categories
*/

// function to display each row of results in a table


function search(start,finish) {
   //append the name of argument to the '/notes/category'
    alert(start);
	//alert(finish);
	getVars = "?m[start]=" + start + "&m[finish]=" + finish;
	//vars = {start:start, finish:finish}
	alert(getVars);
	url = '/paths/search' + getVars
    
	//receives JSON objects from the url 
    $.getJSON(url,  function(json) {
	//call display function to display json object in html
    display(json);
	});
}

//AJAX request to check whether the response is ready or not 
 $(document).ready(function() {
   // alert('hi....');
    // Attach an event when div 'execute-search' is clicked
    $('#execute-search').click(function() {
	   //alert('bye');
        // call function search with value entered in the text-box id 'category'
        search($('#start').val(), $('#finish').val());
                
    });
});
	

	