 function doPost(eventTarget, eventArgument) {
	__doPostBack(eventTarget, eventArgument);
	theForm.__EVENTTARGET.value = "";
	theForm.__EVENTARGUMENT.value = "";
}

function ResetGridSelection(gridID) {
    var grid = document.getElementById(gridID);
    var rows = grid.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        if (i % 2 == 0) {
            rows[i].removeAttribute("class");
        }
        else {
            rows[i].setAttribute("class", "odd");
        }
    }
}