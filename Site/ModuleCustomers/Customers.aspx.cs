using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Customers : System.Web.UI.Page
{
    private readonly string mCurrentModule = Client.Module.ID;
    private readonly string mPageName = "Customers administraion";

    bool allowEdit = false;
    bool allowView = false;

    string appPath = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowEdit = Utils.PermissionAllowed(mCurrentModule, Client.Domains.CustomersPersonalData.Name, Constants.Classifiers.Permissions_Edit);
        allowView = Utils.PermissionAllowed(mCurrentModule, Client.Domains.CustomersPersonalData.Name, Constants.Classifiers.Permissions_View);

        try
        {
            appPath = Utils.GetApplicationPath(Request);                 

            clientContractDateFromCalendareExtender.Format = Constants.ISODateBackwardDotsFormat;
            clientContractDateToCalendareExtender.Format = Constants.ISODateBackwardDotsFormat;

            if (allowView)
            {
                if (!IsPostBack)  FillAllComboBox();
                ShowPanel(clientWorkPanel.ID);
                
                if (!IsPostBack)
                {
                }
                else
                {
                    string eventSource = Request.Params.Get("__EVENTTARGET");
                    string action = Request.Params.Get("__EVENTARGUMENT");

                    int selectedIndexInContractsGridView = 0;
                    int.TryParse(clientContracts_SelectedIndex_HiddenValue.Value, out selectedIndexInContractsGridView);
                    if (!clientContracts_SelectedIndex_HiddenValue.Value.Equals(string.Empty)) clientContractsGridView.SelectedIndex = selectedIndexInContractsGridView;

                    int selectedIndexInSubclientsGridView = 0;
                    int.TryParse(subcliet_SelectedIndex_HiddenValue.Value, out selectedIndexInSubclientsGridView);
                    if (!subcliet_SelectedIndex_HiddenValue.Value.Equals(string.Empty)) subclientiGridView.SelectedIndex = selectedIndexInSubclientsGridView;


                    switch (eventSource)
                    {
                        case "clientContractsGridClik":

                            #region Domains Grid Events

                            switch (action.ToLower())
                            {
                                case "add":
                                    {
                                        ClearContractForm();
                                        clientContractPopupExtender.Show();
                                    }
                                    break;

                                case "edit":
                                    ClearContractForm();

                                    clientContractActionHiddenField.Value = Crypt.Module.CreateEncodedString("Edit");
                                    contractSelectedContractIDHiddenField.Value = clientContractsGridView.Rows[selectedIndexInContractsGridView].Cells[1].Text.Replace("&nbsp;", "");
                                    clientContractNrTextBox.Text = clientContractsGridView.Rows[selectedIndexInContractsGridView].Cells[2].Text.Replace("&nbsp;", "");

                                    Label dateFromLabel = (Label)clientContractsGridView.Rows[selectedIndexInContractsGridView].Cells[3].FindControl("dateFromLabel");
                                    clientContractDateFromTextBox.Text = dateFromLabel != null ? dateFromLabel.Text : string.Empty;

                                    Label dateToLabel = (Label)clientContractsGridView.Rows[selectedIndexInContractsGridView].Cells[4].FindControl("dateToLabel");
                                    clientContractDateToTextBox.Text = dateToLabel != null ? dateToLabel.Text : string.Empty;

                                    clientContractActiveCheckBox.Checked = clientContractsGridView.Rows[selectedIndexInContractsGridView].Cells[5].Text.Replace("&nbsp;", "").ToLower().Equals("true");

                                    clientContractPopupExtender.Show();
                                    break;

                                case "delete":
                                    if (allowEdit)
                                    {
                                        string contractIDSTR = clientContractsGridView.Rows[selectedIndexInContractsGridView].Cells[1].Text.Replace("&nbsp;", "");

                                        //int clinetIDInt = this.ClientObject.ClientID;

                                        //int contractIDInt = 0;
                                        //int.TryParse(contractIDSTR, out contractIDInt);

                                        //if (Utils.ModuleCustomers().DeleteClientContract(clinetIDInt, contractIDInt))
                                        //{
                                        //    FIllContractsGridView();
                                        //}
                                        //else
                                        //{
                                        //    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error deleting record.", "Selected contract not deleted. Try again later! " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
                                        //}
                                    }
                                    else
                                    {
                                        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
                                    }
                                    break;
                            }
                            #endregion Domains Grid Events

                            break;

                        case "subclientGridClik":

                            #region subclient Grid Events

                            switch (action.ToLower())
                            {
                                case "edit":
                                    {
                                        ClearSubClientPersonalDataClientForm(0);
                                        int subclID = 0;
                                        int.TryParse(subclientiGridView.Rows[selectedIndexInSubclientsGridView].Cells[0].Text.Replace("&nbsp;", ""), out subclID);

                                        subClienteditedIDHiddenFiled.Value = subclID.ToString();
                                        DataObjects.Client subClientOBJ = Utils.ModuleCustomers().GetCleintObjectByID(subclID);

                                        FillSubClientPersonalDataForm(subClientOBJ);
                                        subclientPersonalDataModalPopupExtender.Show();
                                    }
                                    break;

                                case "delete":
                                    if (allowEdit)
                                    {
                                        int subclID = 0;
                                        int.TryParse(subclientiGridView.Rows[selectedIndexInSubclientsGridView].Cells[0].Text.Replace("&nbsp;", ""), out subclID);
                                        
                                        if (Utils.ModuleCustomers().DeleteClient(subclID))
                                        {
                                            FillSubclientiList();
                                        }
                                        else
                                        {
                                            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error deleting record.", "Selected subclient not deleted. Try again later! " + (Utils.UserObject().IsSysadmin ? Utils.ModuleCustomers().LastError : string.Empty));
                                        }
                                    }
                                    else
                                    {
                                        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
                                    }
                                    break;
                            }
                            #endregion subcliet Grid Events

                            break;
                    }
                }
            }
            else
            {
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
            }
        }
        catch (Exception ex)
        { Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message); }
    }

    
    //protected void customerSelectionControl_ClientSelected(object sender, ClientSelectionControl.FilterWindowEventsArg e)
    //{
    //    if (e.SelectedItem != 0)
    //    {
    //        DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(e.SelectedItem);
    //        this.ClientObject = clientObject;

    //        ShowPanel(clientWorkPanel.ID);

    //        Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName, appPath + "/ModuleCustomers/Customers.aspx?clid=" + e.SelectedItem, Utils.Customer_HotNavogateKey);        
    //    }
    //    else
    //    {
    //        ClearNewClientForm((int)Constants.Classifiers.ClientType_PersoanaJuridica);
    //        clientPurposeHiddenField.Value = "Client";
    //        newClientPopupExtender.Show();
    //    }
    //}



    private void ShowPanel(string panelName)
    {
        #region Hide panels
        //clientSelectionPanel.Visible = false;
        clientWorkPanel.Visible = false;
        #endregion Hide panels

        try
        {
            #region Get Panel Name

            switch (panelName)
            {
            //    case "clientSelectionPanel":
            //        //clientSelectionPanel.Visible = true;
            //        //FillClientSelectionGrid();
            //        customerSelectionControl.Show();
            //        break;

                case "clientWorkPanel":
                    DataObjects.Client client = Utils.SelectedClient;
                    FillClientAllForms(client);

                    clientWorkPanel.Visible = true;

                    break;
            }

            #endregion Get Panel Name
        }
        catch (Exception ex)
        { Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message); }
    }

    protected void FillAllComboBox()
    {
        DataTable gendersList = Security.MainModule.GetClassifierByTypeID((int)Constants.ClassifierTypes.ClientType_Juridic_Fizic);
        Utils.FillSelector(clientPersDataGenderListDDL, gendersList, "Name", "Code");
        Utils.FillSelector(subclientGenderDDL, gendersList, "Name", "Code");

        DataTable countryList = Security.MainModule.GetClassifierByTypeID((int)Constants.ClassifierTypes.CountryList);
        Utils.FillSelector(vizaClientAddressCountryDDL, countryList, "Name", "Code");
        Utils.FillSelector(subclientPD_CountryDDL, countryList, "Name", "Code");

        try
        {
            vizaClientAddressCountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
            FillVizaRaionDDDL();

            subclientPD_CountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
            FillVizaRaionDDDL();
        }
        catch
        { }
    }

    private void FillVizaRaionDDDL()
    {
        if (vizaClientAddressCountryDDL.SelectedValue != null && !vizaClientAddressCountryDDL.SelectedValue.ToString().Equals(string.Empty))
        {
            int countruCOde = 0;
            int.TryParse(vizaClientAddressCountryDDL.SelectedValue.ToString(), out countruCOde);

            DataTable b_provinceList = Utils.ModuleMain().GetProvinceListByCountry(countruCOde);
            Utils.FillSelector(vizaClientAddressClientRaionDDL, b_provinceList, "Name", "Code");
        }
    }

    #region ClientSelection Region

    //protected void juridicPersonRadioButton_CheckedChanged(object sender, EventArgs e)
    //{
    //    FillClientSelectionGrid();
    //}

    //private void FillClientSelectionGrid()
    //{
    //    int category = 0;

    //    List<int> juridicPerson = new List<int>(new int[] {(int)Constants.Classifiers.ClientType_PersoanaJuridica});
    //    List<int> fizicPerson = new List<int>(new int[] {(int)Constants.Classifiers.ClientType_PersoanaFizica});

    //    List<int> genderList = juridicPersonRadioButton.Checked ? juridicPerson : fizicPerson;
    //    DataTable clientsList = Utils.ModuleCustomers().GetClientList(category, genderList);
    //    clientListGridView.DataSource = clientsList;
    //    clientListGridView.DataBind();
    //}

    //protected void clientListGridView_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (clientListGridView.SelectedRow != null)
    //    {
    //        GridViewRow row = clientListGridView.SelectedRow;

    //        int clientID = 0;
    //        int.TryParse(row.Cells[0].Text, out clientID);

    //        if (clientID > 0)
    //        {
    //            DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(clientID);
    //            this.ClientObject = clientObject;

    //            ShowPanel(clientWorkPanel.ID);

    //            Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName,  appPath + "/ModuleCustomers/Customers.aspx?clid=" + clientID, Utils.Customer_HotNavogateKey);
    //        }
    //    }
    //}

    //protected void usersGrid_RowCreated(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    { e.Row.TableSection = TableRowSection.TableHeader; }

    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
    //        e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

    //        for (int i = 0; i < e.Row.Cells.Count; i++)
    //        {
    //            e.Row.Cells[i].Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.clientListGridView, "Select$" + e.Row.RowIndex);
    //        }
    //    }
    //}

    #endregion ClientSelection Region

    #region Customers
    
    protected void FillClientAllForms(DataObjects.Client clientObject)
    {
        #region GeneralTab
        string htmlTags_GeneralInfo = string.Empty;

        if (clientObject.Gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
        {
            htmlTags_GeneralInfo += "<ul class=\"section menu\"> \r\n ";
            htmlTags_GeneralInfo += "   <li> \r\n ";
            htmlTags_GeneralInfo += "       <a class=\"menuitem current\">Personal Info</a>  \r\n  ";
            htmlTags_GeneralInfo += "           <ul class=\"submenu current\" style=\"padding-top: 0px; border-top-style: none; padding-bottom: 0px; border-bottom-style: none; overflow: hidden; height: 125px;\"> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">First Name: " + clientObject.FirstName + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Last Name: " + clientObject.LastName + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Birth Date: " + clientObject.BirthDate.ToString(Constants.ISODateBackwardDotsFormat) + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Personal ID: " + clientObject.PersonalID + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Telefon Fix: " + clientObject.TelefonFix + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Telefon Mobil: " + clientObject.TelefonMobil + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Email: " + clientObject.Email + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "           </ul> \r\n ";
            htmlTags_GeneralInfo += "   </li>  \r\n ";
            htmlTags_GeneralInfo += "</ul> \r\n ";
        }
        else
        {
            htmlTags_GeneralInfo += "<ul class=\"section menu\"> \r\n ";
            htmlTags_GeneralInfo += "   <li> \r\n ";
            htmlTags_GeneralInfo += "       <a class=\"menuitem current\">Personal Info</a>  \r\n  ";
            htmlTags_GeneralInfo += "           <ul class=\"submenu current\" style=\"padding-top: 0px; border-top-style: none; padding-bottom: 0px; border-bottom-style: none; overflow: hidden; height: 125px;\"> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Legal Entity Name: " + clientObject.FirstName + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Registration Number: " + clientObject.PersonalID + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Contact person: " + clientObject.LastName + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Telefon Fix: " + clientObject.TelefonFix + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Telefon Mobil: " + clientObject.TelefonMobil + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "               <li> <a style=\"margin-left: -25px;\">Email: " + clientObject.Email + " </a>	</li> \r\n ";
            htmlTags_GeneralInfo += "       </ul> \r\n ";
            htmlTags_GeneralInfo += "   </li>  \r\n ";
            htmlTags_GeneralInfo += "</ul> \r\n ";
        }

        generalInfo_personal.InnerHtml = htmlTags_GeneralInfo;

        #endregion GeneralTab

        #region ComandedOrders

        List<int> orderStates = new List<int>();
        orderStates.Add((int)Constants.Classifiers.OrderState_Solicitat);
        //orderStates.Add((int)Constants.Classifiers.OrderState_Confirmat);
        //orderStates.Add((int)Constants.Classifiers.OrderState_Anulat);

        DataTable comandedOrders = Utils.ModuleCustomers().GetClientOrdersList(clientObject.ClientID, orderStates);
        clientComandedOrdersGridView.DataSource = comandedOrders;
        clientComandedOrdersGridView.DataBind();

        #endregion ComandedOrders

        #region ComandedOrders

        DataTable ordersDetalied = Utils.ModuleCustomers().GetOrdersDeliveryListShortDetailed(clientObject.ClientID);
        List<string> hiddenColumns = new List<string>(new string[] {"order_id"});
        List<string> columnsToDisplay = new List<string>(new string[] { "order_id", "nr", "Dimensiuni", "Total Comandat", "Total livrat", "Diferenta" });
        string doNavLinkStr = "/Site/ModuleCustomers/Orders.aspx?ord=";

        activeOrdersDIV.InnerHtml = Utils.GetTableAsHTMLFormatedTable(ordersDetalied, hiddenColumns, columnsToDisplay, "detailedOrders", doNavLinkStr, "order_id");


        #endregion ComandedOrders
        
        #region PersonalData

        clientPersonalDataSimplePanel.Visible = false;
        clientPersonalDataJuridicPanel.Visible = false;

        if (clientObject.Gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
        {
            clientPersonalDataSimplePanel.Visible = true;

            try
            { clientPersDataGenderListDDL.SelectedValue = clientObject.Gender.ToString(); }
            catch { }

            clientPersDataSimple_FirstNameTextBox.Text = clientObject.FirstName;
            clientPersDataSimple_LastNameTextBox.Text = clientObject.LastName;
            clientPersDataSimple_BirthDateTextBox.Text = clientObject.BirthDate.ToString(Constants.ISODateBackwardDotsFormat);
            clientPersDataSimple_IDNPTextBox.Text = clientObject.PersonalID;
            clientPersDataSimple_BuletinTextBox.Text = clientObject.BuletinSeria;
            clientPersDataSimple_TelefonFixTextBox.Text = clientObject.TelefonFix;
            clientPersDataSimple_TelefonMobilTextBox.Text = clientObject.TelefonMobil;
            clientPersDataSimple_EmailTextBox.Text = clientObject.Email;
        }
        else
        {
            clientPersonalDataJuridicPanel.Visible = true;

            try
            { clientPersDataGenderListDDL.SelectedValue = clientObject.Gender.ToString(); }
            catch { }

            clientPersData_juridFullNameTextBox.Text = clientObject.FirstName;
            clientPersData_juridRegistrationNRTextBox.Text = clientObject.PersonalID;
            clientPersData_juridContactPersonTextBox.Text = clientObject.LastName;
            clientPersData_juridTelefonFixTextBox.Text = clientObject.TelefonFix;
            clientPersData_juridTelefonMobilTextBox.Text = clientObject.TelefonMobil;
            clientPersData_juridEmailTextBox.Text = clientObject.Email;
        }
        
        #endregion PersonalData

        #region Address

        try
        {
            vizaClientAddressCountryDDL.SelectedValue = clientObject.Viza_Country.ToString();
            FillVizaRaionDDDL();
        }  catch    { }

        try
        {
            vizaClientAddressClientRaionDDL.SelectedValue = clientObject.Viza_Raion.ToString();

        } catch  { }

        vizaClientAddressLocalitateaTextBox.Text = clientObject.Viza_Localitatea;
        vizaClientAddressAdresaTextBox.Text = clientObject.Viza_Localitatea;

        #endregion Address

        FIllContractsGridView();

        FillSubclientiList();
    }

    protected void FillSubclientiList() {
        DataTable comandedOrders = Utils.ModuleCustomers().GetSubclientsList(Utils.SelectedClient.ClientID);
        subclientiGridView.DataSource = comandedOrders;
        subclientiGridView.DataBind();
    }
    
    protected void clientComandedOrdersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
            e.Row.Attributes["OnClick"] = "DoNav('" + appPath + "/ModuleCustomers/Orders.aspx?ord=" + e.Row.Cells[0].Text + "'); ";
        }
    }

    //protected void clientActiveOrdersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    { e.Row.TableSection = TableRowSection.TableHeader; }

    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
    //        e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
    //        e.Row.Attributes["OnClick"] = "DoNav('" + appPath + "/ModuleCustomers/Orders.aspx?ord=" + e.Row.Cells[0].Text + "'); ";
    //    }
    //}
    
    protected void clientPersDataGenderList_SelectedIndexChanged(object sender, EventArgs e)
    {
        int gender =0;
        int.TryParse(clientPersDataGenderListDDL.SelectedValue, out gender);

        ClearPersonalDataClientForm(gender);
    }

    protected void ClearPersonalDataClientForm(int gender)
    {
        #region Personal Data

        clientPersonalDataSimplePanel.Visible = false;
        clientPersonalDataJuridicPanel.Visible = false;

        if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
        {
            clientPersonalDataSimplePanel.Visible = true;

            try
            { clientPersDataGenderListDDL.SelectedValue = ((int)Constants.Classifiers.ClientType_PersoanaFizica).ToString(); }
            catch { }

            clientPersDataSimple_FirstNameTextBox.Text = string.Empty;
            clientPersDataSimple_LastNameTextBox.Text = string.Empty;
            clientPersDataSimple_BirthDateTextBox.Text = string.Empty;
            clientPersDataSimple_IDNPTextBox.Text = string.Empty;
            clientPersDataSimple_BuletinTextBox.Text = string.Empty;
            clientPersDataSimple_TelefonFixTextBox.Text = string.Empty;
            clientPersDataSimple_TelefonMobilTextBox.Text = string.Empty;
            clientPersDataSimple_EmailTextBox.Text = string.Empty;
        }
        else
        {
            clientPersonalDataJuridicPanel.Visible = true;

            try
            { clientPersDataGenderListDDL.SelectedValue = ((int)Constants.Classifiers.ClientType_PersoanaJuridica).ToString(); }
            catch { }

            clientPersData_juridFullNameTextBox.Text = string.Empty;
            clientPersData_juridRegistrationNRTextBox.Text = string.Empty;
            clientPersData_juridContactPersonTextBox.Text = string.Empty;
            clientPersData_juridTelefonFixTextBox.Text = string.Empty;
            clientPersData_juridTelefonMobilTextBox.Text = string.Empty;
            clientPersData_juridEmailTextBox.Text = string.Empty;
        }

        #endregion
        
        #region Address
        try
        {
            vizaClientAddressCountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
            FillVizaRaionDDDL();
            vizaClientAddressClientRaionDDL.SelectedIndex = -1;
        }
        catch
        { }

        vizaClientAddressLocalitateaTextBox.Text = string.Empty;
        vizaClientAddressAdresaTextBox.Text = string.Empty;

        #endregion
    }

    protected void vizaClientCountryDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillVizaRaionDDDL();
    }

    protected void clientPersDataSaveBurtton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            //DataObjects.Client clientObject = this.ClientObject;

            //int gender = 0;
            //int.TryParse(clientPersDataGenderListDDL.SelectedValue, out gender);

            //clientObject.Gender = gender;
            //clientObject.Gender_String = clientPersDataGenderListDDL.SelectedItem.Text;


            //if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
            //{
            //    clientObject.FirstName = clientPersDataSimple_FirstNameTextBox.Text.Trim();
            //    clientObject.LastName = clientPersDataSimple_LastNameTextBox.Text.Trim();
            //    clientObject.BirthDate = Crypt.Utils.ToDateTime(clientPersDataSimple_BirthDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
            //    clientObject.PersonalID = clientPersDataSimple_IDNPTextBox.Text.Trim();
            //    clientObject.BuletinSeria = clientPersDataSimple_BuletinTextBox.Text.Trim();
            //    clientObject.TelefonFix = clientPersDataSimple_TelefonFixTextBox.Text.Trim();
            //    clientObject.TelefonMobil = clientPersDataSimple_TelefonMobilTextBox.Text.Trim();
            //    clientObject.Email = clientPersDataSimple_EmailTextBox.Text.Trim();
            //}
            //else
            //{
            //    clientObject.FirstName = clientPersData_juridFullNameTextBox.Text.Trim();
            //    clientObject.LastName = clientPersData_juridContactPersonTextBox.Text.Trim();               
            //    clientObject.PersonalID = clientPersData_juridRegistrationNRTextBox.Text.Trim();
            //    clientObject.TelefonFix = clientPersData_juridTelefonFixTextBox.Text.Trim();
            //    clientObject.TelefonMobil = clientPersData_juridTelefonMobilTextBox.Text.Trim();
            //    clientObject.Email = clientPersData_juridEmailTextBox.Text.Trim();
            //}

            //int country=0;
            //int.TryParse(vizaClientAddressCountryDDL.SelectedValue, out country);
            //clientObject.Viza_Country = country;

            //int raion=0;
            //int.TryParse(vizaClientAddressClientRaionDDL.SelectedValue, out raion);
            //clientObject.Viza_Raion = raion;

            //clientObject.Viza_Localitatea = vizaClientAddressLocalitateaTextBox.Text.Trim();
            //clientObject.Viza_StradaAdresa = vizaClientAddressAdresaTextBox.Text.Trim();

            //if (Utils.ModuleCustomers().UpdateClient(clientObject))
            //{
            ////    this.ClientObject = clientObject;
            ////    Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName, appPath + "/ModuleCustomers/Customers.aspx?clid=" + clientObject.ClientID, Utils.Customer_HotNavogateKey);
            //}
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }
    }

    #endregion Customers
    
    #region ClientContracts



    protected void FIllContractsGridView()
    {
        //DataObjects.Client client = this.ClientObject;

        //DataTable contracts  = null;

        //if(client != null)
        //    contracts = Utils.ModuleCustomers().GetClientContractsList(client.ClientID);

        //clientContractsGridView.DataSource = contracts;
        //clientContractsGridView.DataBind();
    }


    protected void ClearContractForm()
    {
        clientContractActionHiddenField.Value = Crypt.Module.CreateEncodedString("New");
        contractSelectedContractIDHiddenField.Value = string.Empty;
        clientContractNrTextBox.Text = string.Empty;
        clientContractDateFromTextBox.Text = string.Empty;
        clientContractDateToTextBox.Text = string.Empty;
        clientContractActiveCheckBox.Checked = false;
    }

    protected void clientContractSaveButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            string usersAction = Crypt.Module.DecodeCriptedString(clientContractActionHiddenField.Value);
            bool actionResult = false;

            //int clientID = this.ClientObject.ClientID;

            //int contractID = 0;
            //if (usersAction.Equals("Edit")) int.TryParse(contractSelectedContractIDHiddenField.Value, out contractID);
            
            //string nr = clientContractNrTextBox.Text;
            //DateTime dateFrom = Crypt.Utils.ToDateTime(clientContractDateFromTextBox.Text, Constants.ISODateBackwardDotsFormat);
            //DateTime dateTo = Crypt.Utils.ToDateTime(clientContractDateToTextBox.Text, Constants.ISODateBackwardDotsFormat);

            //bool isActive = clientContractActiveCheckBox.Checked;

            //if (usersAction.Equals("New"))
            //{
            //    actionResult = Utils.ModuleCustomers().AddClientContract(clientID, nr, dateFrom, dateTo, isActive);
            //}
            //else
            //{
            //    actionResult = Utils.ModuleCustomers().UpdateClientContract(clientID, contractID, nr, dateFrom, dateTo, isActive);
            //}

            //if (actionResult)
            //{
            //    ClearContractForm();
            //    FIllContractsGridView();
            //    clientContractPopupExtender.Hide();
            //}
            //else
            //{
            //    clientContractPopupExtender.Show();
            //    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention", "Unable to save contract, try again later. " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
            //}
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }            
    }


    protected void clientContractsGridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        }
    }

    #endregion ClientContracts

    #region subclients

    protected void subclientPD_CountryDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillVizaRaionForSubCLientDDDL();
    }

    protected void subclientGenderDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        int gender =0;
        int.TryParse(subclientGenderDDL.SelectedValue, out gender);

        ClearSubClientPersonalDataClientForm(gender);
        subclientPersonalDataModalPopupExtender.Show();
    }

    private void FillVizaRaionForSubCLientDDDL()
    {
        if (subclientPD_CountryDDL.SelectedValue != null && !subclientPD_CountryDDL.SelectedValue.ToString().Equals(string.Empty))
        {
            int countruCOde = 0;
            int.TryParse(subclientPD_CountryDDL.SelectedValue.ToString(), out countruCOde);

            DataTable b_provinceList = Utils.ModuleMain().GetProvinceListByCountry(countruCOde);
            Utils.FillSelector(subclientPD_RaionDDL, b_provinceList, "Name", "Code");
        }
    }

    protected void ClearSubClientPersonalDataClientForm(int gender)
    {
        #region Personal Data

        subclientPDSimpleFormPanel.Visible = false;
        subclientPJPD_Panel.Visible = false;

        if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
        {
            subclientPDSimpleFormPanel.Visible = true;

            try
            { subclientGenderDDL.SelectedValue = ((int)Constants.Classifiers.ClientType_PersoanaFizica).ToString(); }
            catch { }

            subclientPD_FirstnameTextBox.Text = string.Empty;
            subclientPD_lastNameTextBox.Text = string.Empty;
            subclientPD_BirthdateTextBox.Text = string.Empty;
            subclientPD_IDNPTextBox.Text = string.Empty;
            subclientPD_BuletinTextBox.Text = string.Empty;
            subclientPD_TelefonFixTextBox.Text = string.Empty;
            subclientPD_MobilTextBox.Text = string.Empty;
            subclientPD_EmailTextBox.Text = string.Empty;
        }
        else
        {
            subclientPJPD_Panel.Visible = true;

            try
            { subclientGenderDDL.SelectedValue = ((int)Constants.Classifiers.ClientType_PersoanaJuridica).ToString(); }
            catch { }

            subclientPJPD_FullNameTextBox.Text = string.Empty;
            subclientPJPD_RegistratioNRTextBox.Text = string.Empty;
            subclientPJPD_ContactPersonTextBox.Text = string.Empty;
            subclientPJPD_TelefonFixTextBox.Text = string.Empty;
            subclientPJPD_MObilTextBox.Text = string.Empty;
            subclientPJPD_EmailTextBox.Text = string.Empty;
        }

        #endregion

        #region Address
        try
        {
            subclientPD_CountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
            FillVizaRaionForSubCLientDDDL();
            subclientPD_RaionDDL.SelectedIndex = -1;
        }
        catch
        { }

        subclientPD_LocalitateaTextBox.Text = string.Empty;
        subclientPD_AddressTextBox.Text = string.Empty;

        #endregion
    }

    protected void FillSubClientPersonalDataForm(DataObjects.Client clientObject)
    {
        #region PersonalData


        subclientPDSimpleFormPanel.Visible = false;
        subclientPJPD_Panel.Visible = false;


        if (clientObject.Gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
        {
            subclientPDSimpleFormPanel.Visible = true;

            try
            { subclientGenderDDL.SelectedValue = clientObject.Gender.ToString(); }
            catch { }

            subclientPD_FirstnameTextBox.Text = clientObject.FirstName;
            subclientPD_lastNameTextBox.Text = clientObject.LastName;
            subclientPD_BirthdateTextBox.Text = clientObject.BirthDate.ToString(Constants.ISODateBackwardDotsFormat);
            subclientPD_IDNPTextBox.Text = clientObject.PersonalID;
            subclientPD_BuletinTextBox.Text = clientObject.BuletinSeria;
            subclientPD_TelefonFixTextBox.Text = clientObject.TelefonFix;
            subclientPD_MobilTextBox.Text = clientObject.TelefonMobil;
            subclientPD_EmailTextBox.Text = clientObject.Email;
        }
        else
        {
            subclientPJPD_Panel.Visible = true;

            try
            { subclientGenderDDL.SelectedValue = clientObject.Gender.ToString(); }
            catch { }

            subclientPJPD_FullNameTextBox.Text = clientObject.FirstName;
            subclientPJPD_RegistratioNRTextBox.Text = clientObject.PersonalID;
            subclientPJPD_ContactPersonTextBox.Text = clientObject.LastName;
            subclientPJPD_TelefonFixTextBox.Text = clientObject.TelefonFix;
            subclientPJPD_MObilTextBox.Text = clientObject.TelefonMobil;
            subclientPJPD_EmailTextBox.Text = clientObject.Email;
        }

        #endregion PersonalData

        #region Address

        try
        {
            subclientPD_CountryDDL.SelectedValue = clientObject.Viza_Country.ToString();
            FillVizaRaionForSubCLientDDDL();
        }
        catch { }

        try
        {
            subclientPD_RaionDDL.SelectedValue = clientObject.Viza_Raion.ToString();

        }
        catch { }

        subclientPD_LocalitateaTextBox.Text = clientObject.Viza_Localitatea;
        subclientPD_AddressTextBox.Text = clientObject.Viza_Localitatea;

        #endregion Address
    
    }

    protected void subclientPD_SaveButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            int clientID = 0;
            int.TryParse(subClienteditedIDHiddenFiled.Value, out clientID);

            DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(clientID);

            int gender = 0;
            int.TryParse(subclientGenderDDL.SelectedValue, out gender);

            clientObject.Gender = gender;
            clientObject.Gender_String = subclientGenderDDL.SelectedItem.Text;


            if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
            {
                clientObject.FirstName = subclientPD_FirstnameTextBox.Text.Trim();
                clientObject.LastName = subclientPD_lastNameTextBox.Text.Trim();
                clientObject.BirthDate = Crypt.Utils.ToDateTime(subclientPD_BirthdateTextBox.Text, Constants.ISODateBackwardDotsFormat);
                clientObject.PersonalID = subclientPD_IDNPTextBox.Text.Trim();
                clientObject.BuletinSeria = subclientPD_BuletinTextBox.Text.Trim();
                clientObject.TelefonFix = subclientPD_TelefonFixTextBox.Text.Trim();
                clientObject.TelefonMobil = subclientPD_MobilTextBox.Text.Trim();
                clientObject.Email = subclientPD_EmailTextBox.Text.Trim();
            }
            else
            {
                clientObject.FirstName = subclientPJPD_FullNameTextBox.Text.Trim();
                clientObject.LastName = subclientPJPD_ContactPersonTextBox.Text.Trim();
                clientObject.PersonalID = subclientPJPD_RegistratioNRTextBox.Text.Trim();
                clientObject.TelefonFix = subclientPJPD_TelefonFixTextBox.Text.Trim();
                clientObject.TelefonMobil = subclientPJPD_MObilTextBox.Text.Trim();
                clientObject.Email = subclientPJPD_EmailTextBox.Text.Trim();
            }

            int country = 0;
            int.TryParse(subclientPD_CountryDDL.SelectedValue, out country);
            clientObject.Viza_Country = country;

            int raion = 0;
            int.TryParse(subclientPD_RaionDDL.SelectedValue, out raion);
            clientObject.Viza_Raion = raion;

            clientObject.Viza_Localitatea = subclientPD_LocalitateaTextBox.Text.Trim();
            clientObject.Viza_StradaAdresa = subclientPD_AddressTextBox.Text.Trim();

            if (Utils.ModuleCustomers().UpdateClient(clientObject))
            {
                FillSubclientiList();

            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }
    }

    protected void refreshSubClientListButton_Click(object sender, ImageClickEventArgs e)
    {
        FillSubclientiList();
    }

    #endregion subclients


    protected void newOrderButton_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(appPath + "/ModuleCustomers/Orders.aspx?ord=n");        
    }

    protected void addSubClientButton_Click(object sender, ImageClickEventArgs e)
    {
        Utils.GetMaster(this).AddSubClientForm();
    }


}