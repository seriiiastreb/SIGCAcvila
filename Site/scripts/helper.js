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


//* simple modal plugin

jQuery.fn.showModal = function (options) {
    return this.each(function () {
        var modalDiv = $('#modal');
        if (modalDiv.length == 0)
            modalDiv = $('<div id="modal" class="modalDiv"></div>').appendTo(document.body);

        //* you can remove this if you don't have to support IE6
        if ($.browser.msie && $.browser.version == "6.0") {
            $('select').hide();
            modalDiv.css({ 'position': 'absolute', 'height': $(document).height() - 5, 'width': $(window).width() }).show();
        }
        else
            modalDiv.css({ 'position': 'fixed' }).show();

        var x = $(window).width() / 2 - $(this).outerWidth() / 2;
        var y = $(window).height() / 2 - $(this).outerHeight() / 2;

        $(this).css({ 'position': 'absolute', 'left': x + $(window).scrollLeft(), 'top': y + $(window).scrollTop(), 'z-index': '10001' }).focus().slideDown();
    });
};


jQuery.fn.hideModal = function (options) {
    return this.each(function () {
        //* you can remove this if you don't have to support IE6
        if ($.browser.msie && $.browser.version == '6.0')
            $('select').show();

        $(this).slideUp(function () { $('#modal').hide(); });
    });
};


function Search(txtSearchID, gridViewClientID) {
    var value = $('input[id$="' + txtSearchID + '"]').val();
    if (value) {
        $('#' + gridViewClientID + ' tr:not(:first)').each(function () {
            var index = -1;
            $(this).children('td').each(function () {
                var text = $(this).text();
                if (text.toLowerCase().indexOf(value.toLowerCase()) != -1) {
                    index = 0;
                    return false;
                }
            });
            if (index == 0)
                $(this).show();
            else
                $(this).hide();
        });
    }
    else
        $('#' + gridViewClientID + ' tr').show();
}

function SetLastScrollPosition(scrolledDiv) {
    var strCook = document.cookie;
    if (strCook.indexOf("!~") != 0) {
        var intS = strCook.indexOf("!~");
        var intE = strCook.indexOf("~!");
        var strPos = strCook.substring(intS + 2, intE);
        document.getElementById(scrolledDiv).scrollTop = strPos;
    }
}

function SetDivPosition(scrolledDiv) {
    var intY = document.getElementById(scrolledDiv).scrollTop;
    document.cookie = "yPos=!~" + intY + "~!";
}

function AllowOnlyOneSelectOnGridView(gridID, selectedCkBx) {
    var grid = document.getElementById(gridID);
    var rows = grid.getElementsByTagName("tr");

    for (i = 1; i < rows.length; i++) {
        var cxbx = rows[i].cells[0].getElementsByTagName("input")[0];

        if (cxbx.id != selectedCkBx.children[0].id) {
            cxbx.checked = false;
        }
    }
}

function CheckAllForGrid(gridID, selAllCxBx) {
    var grid = document.getElementById(gridID);
    var rows = grid.getElementsByTagName("tr");

    for (i = 1; i < rows.length; i++) {
        if (rows[i].style.display != "none") {
            var cxbx = rows[i].cells[0].getElementsByTagName("input")[0];
            cxbx.checked = selAllCxBx.checked;
        }
    }
}


function value_contains(hiddedFieldValue, value) {
    var foundValue = false; var totalValues = hiddedFieldValue.split(";");
    for (var i = 0; i < totalValues.length; i++)
    { if (totalValues[i] == value) { foundValue = true; } }
    return foundValue;
}

function addEntryValue(inptValue, hiddenFieldID) {
    var hiddentFValue = document.getElementById(hiddenFieldID).value;
    var countainValue = value_contains(hiddentFValue, inptValue);
    if (!countainValue) {
        if (hiddentFValue.length > 0) { hiddentFValue += ';' + inptValue; }
        else { hiddentFValue += inptValue; }
        document.getElementById(hiddenFieldID).value = hiddentFValue;
    }
};

function removeEntryValue(inptValue, hiddenFieldID) {
    var hiddentFieldValue = document.getElementById(hiddenFieldID).value;
    var newText = ''; var totalValues = hiddentFieldValue.split(";");
    for (var i = 0; i < totalValues.length; i++)
    { if (totalValues[i] != inptValue) { if (newText.length > 0) { newText += ';'; } newText += totalValues[i]; } }
    document.getElementById(hiddenFieldID).value = newText;
};

function DoNav(url) {
    document.location.href = url;
};