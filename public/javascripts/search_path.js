

// function to display each row of results in a table
function toRow() {
    columns = '';
	path = ''
	for (j in item) {
	  
	   item2 = item[j];
	   alert(item2);
	   columns += '<td width = 400>' + item2 + '</td>';
       path =  '<tr>' + columns + '</tr>';
	alert(path);
  }
	return path
	}

//function to display the results 
function display(json) {
    //create a html string
    html = '<table cellspacing =5 cellpadding=5 >';
	
    
	// for each object in json
    for(var i in json) {
	    
		//html += '<th>Path'
		html += '<b>****Path ****</b>'
		//html += j
		html += ''
		//html += '</th>'
		item = json[i];
		html += '<br/>'
		for (k in item) {
		//   item2 = item[j];
		   
		  html += item[k]
		  html += '<br/>'
		  
		  }
		  html += '<p/>'
      // html += toRow(item);
	  //}
		
    }
    html += '</table>';
	//add it to the 'search-results' div
    $('#search-results').html(html);
}


function search(start,finish) {
   
	getVars = "?m[start]=" + start + "&m[finish]=" + finish;
	//vars = {start:start, finish:finish}
	//alert(getVars);
	url = '/paths/search_path' + getVars
    
	//receives JSON objects from the url 
    $.getJSON(url,function(json) {
	//alert('in loop');
	//alert(json);
	//call display function to display json object in html
    display(json);
	});
}

//AJAX request to check whether the response is ready or not 
 $(document).ready(function() {
    // Attach an event when div 'execute-search' is clicked
    $('#execute-search').click(function() {
	     // call function search 
        search($('#start').val(), $('#finish').val());
                
    });
});
	

	