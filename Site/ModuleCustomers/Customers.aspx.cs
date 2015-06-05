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

    DataObjects.Client ClientObject
    {
        get { return Session[Utils.SessionKey_ClientObject] != null ? (DataObjects.Client)Session[Utils.SessionKey_ClientObject] : new DataObjects.Client(); }
        set { Session[Utils.SessionKey_ClientObject] = value; }
    }

    string appPath = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowEdit = Utils.PermissionAllowed(mCurrentModule, Client.Domains.CustomersPersonalData.Name, Constants.Classifiers.Permissions_Edit);
        allowView = Utils.PermissionAllowed(mCurrentModule, Client.Domains.CustomersPersonalData.Name, Constants.Classifiers.Permissions_View);

        try
        {
            appPath = Utils.GetApplicationPath(Request); 

            if (allowView)
            {
                if (!IsPostBack)
                {
                    Utils.GetMaster(this).AddNavlink("Customers", appPath+  "/ModuleCustomers/Customers.aspx", "ClientsPageID");

                    newClientSimple_BirthDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
                    clientContractDateFromCalendareExtender.Format = Constants.ISODateBackwardDotsFormat;
                    clientContractDateToCalendareExtender.Format = Constants.ISODateBackwardDotsFormat;

                    FillAllComboBox();
                    ShowPanel(clientSelectionPanel.ID);
                }
                else
                {
                    string eventSource = Request.Params.Get("__EVENTTARGET");
                    string action = Request.Params.Get("__EVENTARGUMENT");

                    int selectedIndexInContractsGridView = 0;
                    int.TryParse(clientContracts_SelectedIndex_HiddenValue.Value, out selectedIndexInContractsGridView);
                    if (!clientContracts_SelectedIndex_HiddenValue.Value.Equals(string.Empty)) clientContractsGridView.SelectedIndex = selectedIndexInContractsGridView;
                            
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

                                        int clinetIDInt = this.ClientObject.ClientID;

                                        int contractIDInt = 0;
                                        int.TryParse(contractIDSTR, out contractIDInt);

                                        if (Utils.ModuleCustomers().DeleteClientContract(clinetIDInt, contractIDInt))
                                        {
                                            FIllContractsGridView();
                                        }
                                        else
                                        {
                                            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error deleting record.", "Selected contract not deleted. Try again later! " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
                                        }
                                    }
                                    else
                                    {
                                        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
                                    }
                                    break;
                            }
                            #endregion Domains Grid Events

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

    private void ShowPanel(string panelName)
    {
        #region Hide panels
        clientSelectionPanel.Visible = false;
        clientWorkPanel.Visible = false;
        #endregion Hide panels

        try
        {
            #region Get Panel Name

            switch (panelName)
            {
                case "clientSelectionPanel":
                    clientSelectionPanel.Visible = true;
                    FillClientSelectionGrid();
                    break;

                case "clientWorkPanel":
                    DataObjects.Client client = this.ClientObject;
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
        DataTable gendersList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.ClientType_Juridic_Fizic);
        Utils.FillSelector(newClientGenderListDDL, gendersList, "Name", "Code");
        Utils.FillSelector(clientPersDataGenderListDDL, gendersList, "Name", "Code");

        DataTable countryList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.CountryList);
        Utils.FillSelector(vizaClientAddressCountryDDL, countryList, "Name", "Code");

        try
        {
            vizaClientAddressCountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
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

    protected void juridicPersonRadioButton_CheckedChanged(object sender, EventArgs e)
    {
        FillClientSelectionGrid();
    }

    private void FillClientSelectionGrid()
    {
        int category = 0;

        List<int> juridicPerson = new List<int>(new int[] {(int)Constants.Classifiers.ClientType_PersoanaJuridica});
        List<int> fizicPerson = new List<int>(new int[] {(int)Constants.Classifiers.ClientType_PersoanaFizica});

        List<int> genderList = juridicPersonRadioButton.Checked ? juridicPerson : fizicPerson;
        DataTable clientsList = Utils.ModuleCustomers().GetClientList(category, genderList);
        clientListGridView.DataSource = clientsList;
        clientListGridView.DataBind();
    }

    protected void clientListGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (clientListGridView.SelectedRow != null)
        {
            GridViewRow row = clientListGridView.SelectedRow;

            int clientID = 0;
            int.TryParse(row.Cells[0].Text, out clientID);

            if (clientID > 0)
            {
                DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(clientID);
                this.ClientObject = clientObject;

                ShowPanel(clientWorkPanel.ID);

                Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName,  appPath + "/ModuleCustomers/Customers.aspx?clid=" + clientID, "clientID");
            }
        }
    }

    protected void usersGrid_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.clientListGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }

    #endregion ClientSelection Region

    #region Customers

    protected void newClientGenderList_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selectedGender = 0;
        int.TryParse(newClientGenderListDDL.SelectedValue, out selectedGender);

        ClearNewClientForm(selectedGender);
        newClientPopupExtender.Show();
    }

    protected void ClearNewClientForm(int gender)
    {
        newCleint_simplePersonPanel.Visible = false;
        newCleint_juridPersonPanel.Visible = false;

        if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
        {
            newCleint_simplePersonPanel.Visible = true;

            try
            { newClientGenderListDDL.SelectedValue = ((int)Constants.Classifiers.ClientType_PersoanaFizica).ToString(); }
            catch { }

            newClientSimple_FirstNameTextBox.Text = string.Empty;            
            newClientSimple_LastNameTextBox.Text = string.Empty;
            newClientSimple_BirthDateTextBox.Text = string.Empty;
            newClientSimple_IDNPTextBox.Text = string.Empty;
            newClientSimple_BuletinTextBox.Text = string.Empty;
            newClientSimple_TelefonFixTextBox.Text = string.Empty;
            newClientSimple_TelefonMobilTextBox.Text = string.Empty;
            newClientSimple_EmailTextBox.Text = string.Empty;
        }
        else
        {
            newCleint_juridPersonPanel.Visible = true;

            try
            { newClientGenderListDDL.SelectedValue = ((int)Constants.Classifiers.ClientType_PersoanaJuridica).ToString(); }
            catch { }

            newClient_juridFullNameTextBox.Text = string.Empty;
            newClient_juridRegistrationNRTextBox.Text = string.Empty;
            newClient_juridContactPersonTextBox.Text = string.Empty;
            newClient_juridTelefonFixTextBox.Text = string.Empty;
            newClient_juridTelefonMobilTextBox.Text = string.Empty;
            newClient_juridEmailTextBox.Text = string.Empty;
        }
    }
    
    protected void addNewClientButton_Click(object sender, EventArgs e)
    {
        ClearNewClientForm((int)Constants.Classifiers.ClientType_PersoanaJuridica);
        newClientPopupExtender.Show();
    }

    protected void newClientSaveBurtton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            DataObjects.Client newClientObject = new DataObjects.Client();

            int gender = 0;
            int.TryParse(newClientGenderListDDL.SelectedValue, out gender);

            newClientObject.Gender = gender;
            newClientObject.Gender_String = newClientGenderListDDL.SelectedItem.Text;


            if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
            {
                newClientObject.FirstName = newClientSimple_FirstNameTextBox.Text.Trim();
                newClientObject.LastName = newClientSimple_LastNameTextBox.Text.Trim();
                newClientObject.BirthDate = Crypt.Utils.ToDateTime(newClientSimple_BirthDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
                newClientObject.PersonalID = newClientSimple_IDNPTextBox.Text.Trim();
                newClientObject.BuletinSeria = newClientSimple_BuletinTextBox.Text.Trim();
                newClientObject.TelefonFix = newClientSimple_TelefonFixTextBox.Text.Trim();
                newClientObject.TelefonMobil = newClientSimple_TelefonMobilTextBox.Text.Trim();
                newClientObject.Email = newClientSimple_EmailTextBox.Text.Trim();
            }
            else
            {
                newClientObject.FirstName = newClient_juridFullNameTextBox.Text.Trim();
                newClientObject.LastName = newClient_juridContactPersonTextBox.Text.Trim();
                newClientObject.PersonalID = newClient_juridRegistrationNRTextBox.Text.Trim();
                newClientObject.TelefonFix = newClient_juridTelefonFixTextBox.Text.Trim();
                newClientObject.TelefonMobil = newClient_juridTelefonMobilTextBox.Text.Trim();
                newClientObject.Email = newClient_juridEmailTextBox.Text.Trim();
            }

            if (Utils.ModuleCustomers().AddNewClient(ref newClientObject))
            {
                newClientPopupExtender.Hide();
                this.ClientObject = newClientObject;
                ShowPanel(clientWorkPanel.ID);
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }
    }

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
    }

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
            DataObjects.Client clientObject = this.ClientObject;

            int gender = 0;
            int.TryParse(clientPersDataGenderListDDL.SelectedValue, out gender);

            clientObject.Gender = gender;
            clientObject.Gender_String = clientPersDataGenderListDDL.SelectedItem.Text;


            if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
            {
                clientObject.FirstName = clientPersDataSimple_FirstNameTextBox.Text.Trim();
                clientObject.LastName = clientPersDataSimple_LastNameTextBox.Text.Trim();
                clientObject.BirthDate = Crypt.Utils.ToDateTime(clientPersDataSimple_BirthDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
                clientObject.PersonalID = clientPersDataSimple_IDNPTextBox.Text.Trim();
                clientObject.BuletinSeria = clientPersDataSimple_BuletinTextBox.Text.Trim();
                clientObject.TelefonFix = clientPersDataSimple_TelefonFixTextBox.Text.Trim();
                clientObject.TelefonMobil = clientPersDataSimple_TelefonMobilTextBox.Text.Trim();
                clientObject.Email = clientPersDataSimple_EmailTextBox.Text.Trim();
            }
            else
            {
                clientObject.FirstName = clientPersData_juridFullNameTextBox.Text.Trim();
                clientObject.LastName = clientPersData_juridContactPersonTextBox.Text.Trim();               
                clientObject.PersonalID = clientPersData_juridRegistrationNRTextBox.Text.Trim();
                clientObject.TelefonFix = clientPersData_juridTelefonFixTextBox.Text.Trim();
                clientObject.TelefonMobil = clientPersData_juridTelefonMobilTextBox.Text.Trim();
                clientObject.Email = clientPersData_juridEmailTextBox.Text.Trim();
            }

            int country=0;
            int.TryParse(vizaClientAddressCountryDDL.SelectedValue, out country);
            clientObject.Viza_Country = country;

            int raion=0;
            int.TryParse(vizaClientAddressClientRaionDDL.SelectedValue, out raion);
            clientObject.Viza_Raion = raion;

            clientObject.Viza_Localitatea = vizaClientAddressLocalitateaTextBox.Text.Trim();
            clientObject.Viza_StradaAdresa = vizaClientAddressAdresaTextBox.Text.Trim();

            if (Utils.ModuleCustomers().UpdateClient(clientObject))
            {
                this.ClientObject = clientObject;
                Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName, appPath + "/ModuleCustomers/Customers.aspx?clid=" + clientObject.ClientID, "clientID");
            }
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
        DataObjects.Client client = this.ClientObject;

        DataTable contracts  = null;

        if(client != null)
            contracts = Utils.ModuleCustomers().GetClientContractsList(client.ClientID);

        clientContractsGridView.DataSource = contracts;
        clientContractsGridView.DataBind();
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

            int clientID = this.ClientObject.ClientID;

            int contractID = 0;
            if (usersAction.Equals("Edit")) int.TryParse(contractSelectedContractIDHiddenField.Value, out contractID);
            
            string nr = clientContractNrTextBox.Text;
            DateTime dateFrom = Crypt.Utils.ToDateTime(clientContractDateFromTextBox.Text, Constants.ISODateBackwardDotsFormat);
            DateTime dateTo = Crypt.Utils.ToDateTime(clientContractDateToTextBox.Text, Constants.ISODateBackwardDotsFormat);

            bool isActive = clientContractActiveCheckBox.Checked;

            if (usersAction.Equals("New"))
            {
                actionResult = Utils.ModuleCustomers().AddClientContract(clientID, nr, dateFrom, dateTo, isActive);
            }
            else
            {
                actionResult = Utils.ModuleCustomers().UpdateClientContract(clientID, contractID, nr, dateFrom, dateTo, isActive);
            }

            if (actionResult)
            {
                ClearContractForm();
                FIllContractsGridView();
                clientContractPopupExtender.Hide();
            }
            else
            {
                clientContractPopupExtender.Show();
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention", "Unable to save contract, try again later. " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
            }
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
    
}