using System;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web;
using System.Data;
using System.Text;
using System.Collections.Generic;

public partial class _Default : System.Web.UI.Page
{
    private readonly string mCurrentModule = Security.MainModule.ID;
    private readonly string mPageName = "Pagina de start";
    private string appPath = string.Empty;
    
    protected string WriteAppPath()
    {
        string appPath = Utils.GetApplicationPath(Request);
        return appPath;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        appPath = Utils.GetApplicationPath(Request);

        //#region LogOut Action
        //if (Request["action"] != null)
        //{
        //    string action = Request["action"].ToString();

        //    switch (action)
        //    {
        //        case "logout":
        //            Session["UserObject"] = null;
        //            Session["ModuleCredits"] = null;
        //            Session["ServerObject"] = null;
        //            Session["MenuObject"] = null;
        //            Session["NavLinks"] = null;
        //            Session["ClientObject"] = null;
        //            Session["CurrentCredit"] = null;
        //            Session["Fidejusori"] = null;
        //            Response.Redirect(appPath + "/Default.aspx", true);
        //            break;
        //        default:
        //            break;
        //    }
        //}
        //#endregion LogOut ACtion
        
        //string areaGUID = string.Empty;
        //if (Request["area"] != null)
        //{
        //    areaGUID = Request["area"].ToString();
        //}

        //#region Display Panels depending of area
                
        //if (!IsPostBack)
        //{
        //    string areaName = areaGUID;

        //    switch (areaName)
        //    {
        //        case "login":
        //            ShowPanel(loginPanel.ID);
        //            break;

        //        default:

        //            if (Utils.AutentificatedUser)
        //            {   
        //                Credits.Module moduleCredits = Utils.ModuleCredits();

        //                if (moduleCredits != null)
        //                {
        //                    DataTable clientsDT = moduleCredits.GetClientlist();
        //                    clientFilter.DisplayValueField = "Client Full Name";
        //                    clientFilter.DataValueFiled = "clientID";
        //                    clientFilter.DataSource = clientsDT;
        //                    clientFilter.DataBind();                          
        //                }    

        //                newClientHyperLink.NavigateUrl = appPath + "/ModuleCredits/Client.aspx?clid=n";
        //                ShowPanel(mainPagePanel.ID);
                        
        //                changeRateDateLabel.Text = DateTime.Now.ToString(Constants.ISODateBackwardDotsFormat);

        //                Utils.ModuleCredits().CheckChangeRateForAllDays();

        //                cursEUROTextBox.Text = Utils.ModuleCredits().GetCurrencyRateByDate(DateTime.Now.Date, (int)Constants.CurrencyList.EURO).ToString();
        //                cursUSDTextBox.Text = Utils.ModuleCredits().GetCurrencyRateByDate(DateTime.Now.Date, (int)Constants.CurrencyList.USD).ToString();
        //            }
        //            else
        //            {
        //                //ShowPanel(emptyPanel.ID);
        //            }
        //            break;
        //    }
        //}

        //if (Utils.AutentificatedUser)
        //{
        //    //string parReport = Server.UrlEncode(Crypt.Module.CreateEncodedString(Constants.ReportNames.ParReportName));
        //    //RPT_PAR_HyperLink.NavigateUrl = appPath + "/ModuleCredits/Reports.aspx?rpt=" + parReport;

        //    //string lopipReport = Server.UrlEncode(Crypt.Module.CreateEncodedString(Constants.ReportNames.ListOfPaymentsInSelectedPeriodReportName));
        //    //RPTListOfPaymentsInPeriodHyperLink.NavigateUrl = appPath + "/ModuleCredits/Reports.aspx?rpt=" + lopipReport;

        //    //string lpoclReport = Server.UrlEncode(Crypt.Module.CreateEncodedString(Constants.ReportNames.LoanPartOfCreditsReportName));
        //    //RPTLoansPartOfCreditLinesHyperLink.NavigateUrl = appPath + "/ModuleCredits/Reports.aspx?rpt=" + lpoclReport;

        //    //string persReport = Server.UrlEncode(Crypt.Module.CreateEncodedString(Constants.ReportNames.ClientPersonalDataReportName));
        //    //RPTClientPersonalReportHyperLink.NavigateUrl = appPath + "/ModuleCredits/Reports.aspx?rpt=" + persReport;

        //    //string credtAcord = Server.UrlEncode(Crypt.Module.CreateEncodedString(Constants.ReportNames.ImprumuturiAcordateReportName));
        //    //RPTListaCreditelorAcordateHyperLink.NavigateUrl = appPath + "/ModuleCredits/Reports.aspx?rpt=" + credtAcord;

        //    //string consultEval = Server.UrlEncode(Crypt.Module.CreateEncodedString(Constants.ReportNames.ConsultariEvaluariReportName));
        //    //RPTConsulEvalHyperLink.NavigateUrl = appPath + "/ModuleCredits/Reports.aspx?rpt=" + consultEval;
        //}

        //#endregion Display Panels depending of area

    }            

    protected void ClientSelecetd_Event(object sender, FilterWindow.FilterWindowEventsArg e)
    {
        string selectedClietID = e.SelectedItems.Count == 1 ? e.SelectedItems[0] : string.Empty;
        Response.Redirect(appPath + "/ModuleCredits/Client.aspx?clid=" + selectedClietID);
    }     


    protected void currencyRateUpdateButton_Click(object sender, EventArgs e)
    {
        try
        {
            bool allowHere = Utils.PermissionAllowed(mCurrentModule, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_Edit);
            if (allowHere)
            {
                DateTime date = DateTime.Now.Date;
                decimal euroRate = Crypt.Utils.MyDecimalParce(cursEUROTextBox.Text.Trim());
                decimal usdRate = Crypt.Utils.MyDecimalParce(cursUSDTextBox.Text.Trim());

                //if (!Utils.ModuleCredits().UpdateCurrencyRate(date, (int)Constants.CurrencyList.EURO, euroRate))
                //{ Utils.InfoText(this, "Eroare de salvare!", "Rata de schimb pentru EURO nu a fost salvata."); }

                //if (!Utils.ModuleCredits().UpdateCurrencyRate(date, (int)Constants.CurrencyList.USD, usdRate))
                //{ Utils.InfoText(this, "Eroare de salvare!", "Rata de schimb pentru EURO nu a fost salvata."); }
            }
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage(Constants.InfoBoxMessageType.Error, "Error on Page.", ex.Message);
        }
    }

    //protected void login_Ok_Button_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string username = userNameTextBox.Text.Trim();
    //        string password = passwordTextBox.Text;

    //        Security.User mUserObject = Security.User.Login(username, password);
            
    //        if (mUserObject != null && mUserObject.UserID != 0)
    //        {            
    //            Session["UserObject"] = mUserObject;
    //            Session["ModuleSecurity"] = new Security.Module();
    //            Session["ModuleMain"] = new Security.MainModule();             

    //            Response.Redirect(appPath + "/Default.aspx", false);  
    //        }
    //        else
    //        {
    //            Utils.InfoText(this, "USERNAME sau PAROLA nu este corecta", "In Baza de date nu s-a gasit astfel de USERNAME, sau dumneavoastra ati gresit parola. Va rog verificati corectitudinea datelor introduse!");
    //        }

    //        Session["MenuObject"] = GenerateNavigationMenu();
    //        Utils.GetMaster(this).ShowMainMenu();
    //    }
    //    catch (Exception ex)
    //    {
    //        Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
    //    }
    //}

    public string GenerateNavigationMenu()
    {
        string resultMenu = string.Empty;
        string appPath = Utils.GetApplicationPath(Request);

        if (Utils.AutentificatedUser)
        {
            resultMenu += " <ul id=\"menu\"> ";
            resultMenu += "     <li style=\"width: 50px;\"> <a href=\"" + appPath + "/Default.aspx\">  <img id=\"Img1\" width=\"24\" height=\"24\" alt=\"Pagina de start\" title=\"Pagina de start\" src=\"" + appPath + "/App_Images/home.png\" style=\" cursor:pointer; \"> </a> </li>";
            resultMenu += "     <li style=\"width: 50px;\"> <a href=\"" + appPath + "/ModuleCredits/Clients.aspx\" id=\"contragentLink\"><img id=\"Img2\" width=\"24\" height=\"24\" alt=\"Lista Clientilor\" title=\"Lista Clientilor\" src=\"" + appPath + "/App_Images/man.png\" style=\" cursor:pointer; \"> </a> </li>";


            ////////  Nommeclatoare
            resultMenu += " <li style=\"width: 50px;\"> <a href=\"#\" > <img id=\"Img3\" width=\"24\" height=\"24\" alt=\"Nomenclatoare\" title=\"Nomenclatoare\" src=\"" + appPath + "/App_Images/list.png\" style=\"cursor:pointer; \"> </a> "
                        + " <ul> "
                        + " 	<li><a href=\"" + appPath + "/ModuleMain/classifiers.aspx\" title=\"lista clasificatoarelor\">clasificatoare</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/bank.aspx?area=allList\" title=\"nomenclatorul bancilor\">banci</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/currency.aspx\" title=\"nomenclatorul valutelor\">valuta</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/persons.aspx\" title=\"lista angajatilor\">angajati</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/company.aspx\" title=\"structura companiei\">Организация</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/currentaccount.aspx\" title=\"Расчетные счета\">Расчетные счета</a></li> "
                        + " </ul> </li>";


            /////////  Capital

            resultMenu += "<li style=\"width: 50px;\"> <a href=\"#\" > <img id=\"Img3\" width=\"24\" height=\"24\" alt=\"Capital\" title=\"Capital\" src=\"" + appPath + "/App_Images/capital.png\" style=\"cursor:pointer; \"> </a> "
                        + " <ul> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/client.aspx\" title=\"Lista Contragentilor\">Contragenti</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/trainings.aspx\" title=\"Cursuri de instruire\">Cursuri de instruire</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/loanproducts.aspx\" title=\"Producte de Creditare\">Producte de Creditare</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/credits.aspx\" title=\"Administrarea Creditelor\">Administrarea Creditelor</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/operators.aspx\" title=\"Operatori\">Operatori</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/creditline.aspx\" title=\"Linia de creditare\">Linia de creditare</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/guarantors.aspx?area=allList\" title=\"lista de garantori\">Garantori</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/PlatiSpreAchitare.aspx\" title=\"PlatiSpreAchitare\">Plati spre achitare</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleCredits/TestGrafic.aspx\" title=\"Test Grafic\">Test Grafic</a></li> "
                        + " </ul> ";



            ///////  Contabilitatea 
            resultMenu += "<li style=\"width: 50px;\"> <a href=\"#\" > <img id=\"Img3\" width=\"24\" height=\"24\" alt=\"Contabilitatea\" title=\"Contabilitatea\" src=\"" + appPath + "/App_Images/money.png\" style=\"cursor:pointer; \"> </a> "
                        + " <ul> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/plancont.aspx\" title=\"planul de conturi\">planul de conturi</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/contragent.aspx\" title=\"Lista de Contragenti\">Contragent</a></li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/#\" title=\"operatiunile bancara\">banca &gt;</a> "
                        + " 		<ul> "
                        + " 			<li><a href=\"" + appPath + "/ModuleAccounting/BankInputAccount.aspx\" title=\"Поступление на расчетный счет\">Поступление на расчетный счет</a></li> "
                        + " 			<li><a href=\"" + appPath + "/ModuleAccounting/BankOutputAccount.aspx\" title=\"Списания с расчетного счета\">Списания с расчетного счета</a></li> "
                        + " 			<li><a href=\"" + appPath + "/ModuleAccounting/BankPaymentOrder.aspx\" title=\"Платежные поручение\">Платежные поручение</a></li> "
                        + " 		</ul> "
                        + " 	</li> "
                        + " 	<li><a href=\"" + appPath + "/ModuleAccounting/#\" title=\"operatiuni de cassa\">cassa &gt;</a> "
                        + " 		<ul> "
                        + " 			<li><a href=\"" + appPath + "/ModuleAccounting/ordincont.aspx\" title=\"Ordine de intrare\">Ordine de intrare</a></li> "
                        + " 		</ul> "
                        + " 	</li> "
                        + " </ul> </li> ";



            ////////   Administrarea
            resultMenu += "     <li> "
                        + "     <a href=\"#\" ><img id=\"Img3\" width=\"24\" height=\"24\" alt=\"Administrare\" title=\"Administrare\" src=\"" + appPath + "/App_Images/admin.png\" style=\"cursor:pointer; \"> </a> "
                        + "     <ul> <li><a href=\"" + appPath + "/ModuleMain/usersadmin.aspx?area=systemusers\" title=\"administrarea utilizatorilor\">utilizatori</a></li> "
                        + "     <li><a href=\"" + appPath + "/ModuleMain/ConfigPanels.aspx\" title=\"Config panels\">Config panels</a></li> "
                        + "     <li><a href=\"" + appPath + "/ModuleMain/ConfigMenu.aspx\" title=\"Menu Config\">Menu Config</a></li> "
                        + "     <li><a href=\"" + appPath + "/ModuleMain/TestToolBox.aspx\" title=\"Test ToolBox Objects\">Test ToolBox</a></li> "
                        + "     <li><a href=\"" + appPath + "/ModuleMain/SystemSeqAdmin.aspx\" title=\"System Security administration\">System Security</a></li> </ul> "
                + " </li>";

            resultMenu += "  </ul> ";


            resultMenu += "";
        }
        else
        {
            resultMenu = string.Empty;
        }

        return resultMenu;
    }


   


    //public string GenerateNavigationMenu(bool autentificatedUser)
    //{
    //    string resultMenu = string.Empty;

    //    if (autentificatedUser)
    //    {
    //        resultMenu = GetMenuObject();
    //    }
    //    else
    //    {
    //        DataTable submenu = new DataTable();
    //        submenu.Columns.Add("Link", typeof(string));
    //        submenu.Columns.Add("Name", typeof(string));

    //        submenu.Clear();
    //        submenu.AcceptChanges();
    //        submenu.Rows.Add(appPath + "/default.aspx?area=contacts", "Contacte");
    //        submenu.Rows.Add(appPath + "/default.aspx?area=history", "Istoria Companiei");
    //        submenu.Rows.Add(appPath + "/default.aspx?area=job", "Cariera Personala");

    //        resultMenu += "<li>";
    //        resultMenu += "<a>DESPRE COMPANIE</a>";
    //        resultMenu += GenerateSubmenu(submenu);
    //        resultMenu += "</li>";

    //        resultMenu += "<li>";
    //        resultMenu += "<a href=\"" + appPath + "/ModuleMain/RecoveryPWD.aspx\">RESTABILIREA PAROLIE</a>";
    //        resultMenu += "</li>";
    //    }

    //    return resultMenu;
    //}

    //private string GetMenuObject()
    //{
    //    string resultMenu = string.Empty;

    //    ServerObject mServerObject = new ServerObject();

    //    DataTable sourceTable = mServerObject.UniversalGetFromSingleTable("MenuList", "*", " menuID >1 and isB=0 and enabled = 'true'");

    //    resultMenu += "<li>";
    //    resultMenu += "<a href=\"" + appPath + "/default.aspx\">HOME</a>";
    //    resultMenu += "</li>";

    //    if (sourceTable != null && sourceTable.Rows.Count > 0)
    //    {
    //        resultMenu += GenerateSubmenuByParentID(sourceTable, 1);
    //    }

    //    return resultMenu;
    //}

    //private string GenerateSubmenuByParentID(DataTable inputTable, int parentID)
    //{
    //    string result = string.Empty;

    //    string link = string.Empty;
    //    ServerObject mServerObject = new ServerObject();
    //    string moduleDirectory = string.Empty;

    //    string linkEx = ".aspx";
    //    string linkNote = string.Empty;
    //    string linkToken = string.Empty;

    //    DataRow[] selectedRows = inputTable.Select("parentID=" + parentID);

    //    for (int indexRow = 0; indexRow < selectedRows.Length; indexRow++)
    //    {
    //        moduleDirectory = mServerObject.UniversalGetFromSingleTable("Classifiers", " Name ", " code = " + selectedRows[indexRow]["ClassifierID_46"].ToString()).Rows[0][0].ToString();
    //        if (moduleDirectory.Equals("root"))
    //        {
    //            moduleDirectory = string.Empty;
    //        }
    //        else
    //        {
    //            if (!string.IsNullOrEmpty(moduleDirectory))
    //            {
    //                moduleDirectory = moduleDirectory + "/";
    //            }
    //        }

    //        link = selectedRows[indexRow]["link"].ToString();
    //        if (!link.Equals("#"))
    //        {
    //            link = link + linkEx;
    //        }

    //        linkToken = selectedRows[indexRow]["token"].ToString();
    //        if (!string.IsNullOrEmpty(linkToken))
    //        {
    //            link = link + "?area=" + linkToken;
    //        }

    //        linkNote = selectedRows[indexRow]["Note"].ToString();
    //        if (!string.IsNullOrEmpty(linkNote))
    //        {
    //            linkNote = " title =\"" + linkNote + "\"";
    //        }

    //        string subItem = GenerateSubmenuByParentID(inputTable, int.Parse(selectedRows[indexRow]["menuid"].ToString()));

    //        result += "<li>";

    //        result += "<a href=\"" + appPath + "/" + moduleDirectory + link + "\" " + linkNote + ">";

    //        result += selectedRows[indexRow]["Name"].ToString();

    //        result += "</a>";

    //        if (!string.IsNullOrEmpty(subItem))
    //        {
    //            subItem = "<ul>" + subItem + "</ul>";
    //        }

    //        result += subItem + "</li>";
    //    }
    //    return result;
    //}

    //private string GenerateSubmenu(DataTable inputTable)
    //{
    //    string result = string.Empty;

    //    result = "<ul>";

    //    if (inputTable != null)
    //    {
    //        for (int i = 0; i < inputTable.Rows.Count; i++)
    //        {
    //            result += "<li> " + "<a href=\"" + inputTable.Rows[i]["Link"].ToString() + "\">" + inputTable.Rows[i]["Name"].ToString() + "</a> </li>";
    //        }
    //    }

    //    result += "</ul>";

    //    return result;
    //}


}
