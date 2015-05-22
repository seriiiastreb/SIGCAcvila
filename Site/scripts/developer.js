/************* principalele functii executate **********/
function ModifiedRate(modifedIndex, gridID, contractAmountTxBxID, dataElibTxBxID, dataScadTxBxID, contractPercentTxBxID, calcDinSoldInitRadioID, currencyChangeRateLabelID, loanNrOfMonthsTxBxID, payPeriodDDLID) {
    var grid = document.getElementById(gridID);
    grid.rows[modifedIndex].cells[4].getElementsByTagName('input')[1].value = 'true';

    CalculateNewLoanOrders(gridID, contractAmountTxBxID, dataElibTxBxID, dataScadTxBxID, contractPercentTxBxID, calcDinSoldInitRadioID, currencyChangeRateLabelID, loanNrOfMonthsTxBxID, payPeriodDDLID);
}

function ModifiedTotalAmount(modifedIndex, gridID, contractAmountTxBxID, dataElibTxBxID, dataScadTxBxID, contractPercentTxBxID, calcDinSoldInitRadioID, currencyChangeRateLabelID, loanNrOfMonthsTxBxID, payPeriodDDLID) {

    var grid = document.getElementById(gridID);
    grid.rows[modifedIndex].cells[4].getElementsByTagName('input')[1].value = 'true';

    var enteredTotalAmount = GetCellValue(grid, modifedIndex, 6, 0);
    var currentPercent = GetCellValue(grid, modifedIndex, 5, 0);

    grid.rows[modifedIndex].cells[4].getElementsByTagName('input')[0].value = enteredTotalAmount - currentPercent;

    CalculateNewLoanOrders(gridID, contractAmountTxBxID, dataElibTxBxID, dataScadTxBxID, contractPercentTxBxID, calcDinSoldInitRadioID, currencyChangeRateLabelID, loanNrOfMonthsTxBxID, payPeriodDDLID);
}
/*********************************************************/
/******* Pasul 2 ****************************************/

function CalculateNewLoanOrders(gridID, contractAmountTxBxID, dataElibTxBxID, dataScadTxBxID, contractPercentTxBxID, calcDinSoldInitRadioID, currencyChangeRateLabelID, loanNrOfMonthsTxBxID, payPeriodDDLID) {
    var grid = document.getElementById(gridID);    

    var creditAmount = GetInitialAmountValue(contractAmountTxBxID);
    var creditPercent = GetInitialPercentValue(contractPercentTxBxID);

    var rate = creditPercent / 100 / GetNrPlatilorPeAn(payPeriodDDLID);
    var nrTotalDeTranseInCredit = GetTotalMonthInLoan(loanNrOfMonthsTxBxID);
    var nrDeTranseNemodificate = GetTotalUnmodifiedMonths(grid);
    var totalMoifiedRateAmount = GetTotalModifiedRateAmount(grid);
    var totalNemodifiedRateAmount = creditAmount - totalMoifiedRateAmount;

    var gridLength = grid.rows.length;
    var passedRows = 1;
    var cumulativeRateAmount = 0;
    var remainingAmount = 0;

    for (var i = 1; i < gridLength - 1; i++) {

        var rindModificat = grid.rows[i].cells[4].getElementsByTagName('input')[1].value == 'true';

        var rateAmountForPay = 0;
        var percentAmountForPay = 0;

        if (document.getElementById(calcDinSoldInitRadioID).checked) {
            if (rindModificat) {
                rateAmountForPay = GetCellValue(grid, i, 4, 0);
            }
            else {
                rateAmountForPay = Math.round((creditAmount - totalMoifiedRateAmount) / nrDeTranseNemodificate * 100) / 100;
            }

            percentAmountForPay = Math.round(IPMT(rate, 1, nrTotalDeTranseInCredit, -creditAmount, 1, 0) * 100) / 100;
        }
        else {
            if (rindModificat) {
                rateAmountForPay = GetCellValue(grid, i, 4, 0);
            }
            else {
                rateAmountForPay = Math.round(PPMT(rate, passedRows, nrDeTranseNemodificate, -totalNemodifiedRateAmount, 1, 0) * 100) / 100;
            }

            percentAmountForPay = Math.round(IPMT(rate, passedRows, nrDeTranseNemodificate, -totalNemodifiedRateAmount, 1, 0) * 100) / 100;
        }
        
        if (i > 1) cumulativeRateAmount = Math.round((cumulativeRateAmount + GetCellValue(grid, i - 1, 4, 0)) * 100) / 100;
        remainingAmount =  Math.round((creditAmount - cumulativeRateAmount) * 100) / 100 ;

        if (i == gridLength - 2) {
            rateAmountForPay = remainingAmount; ////  la ultima transa facem ca rata sa fie egala cu suma ramasa
        }

        totalAmountForPay =  Math.round((rateAmountForPay + percentAmountForPay) * 100) / 100;
      
        grid.rows[i].cells[3].getElementsByTagName('input')[0].value = remainingAmount.toFixed(2);                          /* atribuim summa ramasa */
        if (!rindModificat) grid.rows[i].cells[4].getElementsByTagName('input')[0].value = rateAmountForPay.toFixed(2);     /* atribuim o rata noua */
        grid.rows[i].cells[5].getElementsByTagName('input')[0].value = percentAmountForPay.toFixed(2);                      /* atribuim precentul nou */
        grid.rows[i].cells[6].getElementsByTagName('input')[0].value = totalAmountForPay.toFixed(2);                        /* atribuim precentul nou */
       
        if (!rindModificat) {  passedRows = passedRows + 1; }
    }

    CalculateTotals(grid);
    CalculateCurrencyEchivalence(grid, currencyChangeRateLabelID);
}





/*******************************************************/
function GetNrPlatilorPeAn(payPeriodDdl_ID) {
    var result = 0;

    var ddl = document.getElementById(payPeriodDdl_ID);
    if(ddl != null)
    {
        var payPeriodCode = ddl.options[ddl.selectedIndex].value;

        switch (payPeriodCode) {
            case "291":
                result = 24; /////  odata la doua saptamini
                break

            case "293":
                result = 12; /////  monthly payment
                break

            case "292": /// odata la doua luni
                result = 6;
                break

            case "294":  ///  odata la 3 luni ..  simestrial
                result = 4;
                break

            case "295":  ///  jumate de an
                result = 2;
                break

            case "296":  ///  odata intr-un an
                result = 1;
                break

            default:
                result = 12;
        }
    }  

    return result;
}
/*******************************************************/
function GetInitialAmountValue(contractAmountTxBxId) {
    var initialAmountValue = 0;
    var stringInitialAmountValue = document.getElementById(contractAmountTxBxId).value;
    if (parseFloat(stringInitialAmountValue)) {
        initialAmountValue = parseFloat(stringInitialAmountValue);
    }
    return initialAmountValue;
}
/*******************************************************/
function GetInitialPercentValue(contractPercentTxBxId) {
    var initialPercent = 0;
    var stringInitialPercentValue = document.getElementById(contractPercentTxBxId).value;
    if (parseFloat(stringInitialPercentValue)) {
        initialPercent = parseFloat(stringInitialPercentValue);
    }
    return initialPercent;
}
/*******************************************************/
function GetTotalUnmodifiedMonths(grid) {
    var gridLength = grid.rows.length;

    var totalUnmodifiedMonths = 0;

    for (var i = 1; i < gridLength - 1; i++) {
        var hiddenFieldStatus = grid.rows[i].cells[4].getElementsByTagName('input')[1].value == 'true';

        if (hiddenFieldStatus == false) {
            totalUnmodifiedMonths = totalUnmodifiedMonths + 1;
        }
    }

    return totalUnmodifiedMonths;
}
/*******************************************************/
function GetCurrencyChangeRate(currencyChangeRateLableID) {
    var usdChangeRateSTR = document.getElementById(currencyChangeRateLableID).value.replace(',', '.');
    var usdChangeRate = 0;
    if (parseFloat(usdChangeRateSTR)) {
        usdChangeRate = parseFloat(usdChangeRateSTR);
    }
    return usdChangeRate;
}
/*******************************************************/
function GetTotalModifiedRateAmount(grid) {
    var gridLength = grid.rows.length;

    var totalModifiedRateAmount = 0;

    for (var i = 1; i < gridLength - 1; i++) {

        var hiddenFieldStatus = grid.rows[i].cells[4].getElementsByTagName('input')[1].value == 'true';

        if (hiddenFieldStatus == true) {

            var currentRateAmount = GetCellValue(grid, i, 4, 0);
            totalModifiedRateAmount = totalModifiedRateAmount + currentRateAmount;
        }
    }

    return totalModifiedRateAmount;
}
/*******************************************************/
function GetTotalMonthInLoan(loanNrOfMonthsTextBoxID) {
    var totalMonthsInloan = 0;
    var nrOfMothSTR = document.getElementById(loanNrOfMonthsTextBoxID).value;
    if (parseFloat(nrOfMothSTR)) {
        totalMonthsInloan = parseFloat(nrOfMothSTR);
    }

    return totalMonthsInloan;
}


function CalculateTotals(grid) {
    var gridLength = grid.rows.length;

    var totalRate = 0;
    var totalPercent = 0;
    var totalAmountForPay = 0;

    for (var i = 1; i < gridLength - 1; i++) {
        var currentRate = GetCellValue(grid, i, 4, 0);
        var currentPercent = GetCellValue(grid, i, 5, 0);
        var currentAmountForPay = GetCellValue(grid, i, 6, 0);

        totalRate =  Math.round((totalRate + currentRate) * 100) / 100;
        totalPercent =  Math.round((totalPercent + currentPercent) * 100) / 100;
        totalAmountForPay =  Math.round((totalAmountForPay + currentAmountForPay) * 100) / 100;
    }

    grid.rows[gridLength - 1].cells[4].getElementsByTagName('span')[0].innerHTML = totalRate.toFixed(2);
    grid.rows[gridLength - 1].cells[5].getElementsByTagName('span')[0].innerHTML = totalPercent.toFixed(2);
    grid.rows[gridLength - 1].cells[6].getElementsByTagName('span')[0].innerHTML = totalAmountForPay.toFixed(2);
}


function CalculateCurrencyEchivalence(grid, currencyChangeRateLabelID) {
    var currencyChangeRate = GetCurrencyChangeRate(currencyChangeRateLabelID);
    var gridLength = grid.rows.length;

    var cumulativeTotalAmountRated = 0;

    for (var i = 1; i < gridLength - 1; i++) {

        var currentTotalAmount = GetCellValue(grid, i, 6, 0);      

        var currentTotalAmountRated = 0;
        if (currencyChangeRate > 0) {
            currentTotalAmountRated = Math.round(currentTotalAmount / currencyChangeRate * 100) / 100;
            cumulativeTotalAmountRated =  Math.round((cumulativeTotalAmountRated + currentTotalAmountRated) * 100) / 100;
        }
        
        grid.rows[i].cells[7].getElementsByTagName('input')[0].value = currentTotalAmountRated.toFixed(2);
    }

    grid.rows[gridLength - 1].cells[7].getElementsByTagName('span')[0].innerHTML = cumulativeTotalAmountRated.toFixed(2);
}


function GetCellValue(grid, index, cell, cellElementIndex) {
    var result = 0;

    var strVal = grid.rows[index].cells[cell].getElementsByTagName('input')[cellElementIndex].value;
    if (parseFloat(strVal)) {
        result = parseFloat(strVal);
    }

    return result;
}

function show_hide_column(tbl, col_no, do_show) {
    var stl;
    if (do_show) stl = ''
    else stl = 'none';

    var rows = tbl.getElementsByTagName('tr');

    var celsh = rows[0].getElementsByTagName('th');
    celsh[col_no].style.display = stl;

    for (var row = 1; row < rows.length; row++) {
        var cels = rows[row].getElementsByTagName('td');
        cels[col_no].style.display = stl;
    }
}


function graficPrintPreview(strid, sze, gridID) {
    var grid = document.getElementById(gridID);
    var gridLength = grid.rows.length;

    grid.rows[gridLength - 1].cells[1].getElementsByTagName('input')[0].style.display = "none";

    show_hide_column(grid, 8, false);

    var txt = document.getElementById(strid).innerHTML;

    txt = txt.fontsize(sze);

    objWindow = window.open("", "", "width=1000,height=1000");
    objWindow.document.write(txt);
    objWindow.print();
    objWindow.close();

    grid.rows[gridLength - 1].cells[1].getElementsByTagName('input')[0].style.display = "";
    show_hide_column(grid, 8, true);
}

function CalculateAlernativePercent(percent, destinationTxBxID) {
    var enteredPercent = 0;
    if (parseFloat(percent)) {
        enteredPercent = parseFloat(percent);
    }

    document.getElementById(destinationTxBxID).value = (enteredPercent * 1.843333).toFixed(2);
}

function CalculateAlernativePercent2(percent, destinationTxBxID) {
    var enteredPercent = 0;
    if (parseFloat(percent)) {
        enteredPercent = parseFloat(percent);
    }

    document.getElementById(destinationTxBxID).value = (enteredPercent / 1.843333).toFixed(2);
}


//call this function for select from checkbox into obout.grid and get the list of file_id
function DoTheClickJS(file_id, isCheck, valueText) {
    var result;
    if (isCheck == 1) {
        if (valueText.length == 0) {
            result = file_id;
        }
        else {
            //var valueText = valueText;
            var valueArray = new Array();
            valueArray = valueText.split(',');
            valueArray.push(file_id);
            if (valueArray.length != 0) {
                valueArray.sort();
            }
            result = valueArray;
        }
    }
    else {
        if (valueText.length == 0) {
            alert("Text value is empty");
        }
        else {
            var splitText = new Array();
            splitText = valueText.split(',');

            for (var count = 0; count < splitText.length; count++) {
                if (splitText[count] == file_id) {
                    delete splitText[count];
                }
            }

            var newArray = new Array();
            for (var count = 0; count < splitText.length; count++) {
                if (splitText[count] != null) {
                    newArray.push(splitText[count]);
                }
                if (newArray.length != 0) {
                    newArray.sort();
                }
                result = newArray;
            }
        }
    }
    return result;
}
