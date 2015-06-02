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


    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowEdit = Utils.PermissionAllowed(mCurrentModule, Security.Domains.Administration.Name, Constants.Classifiers.Permissions_Edit);
        allowView = Utils.PermissionAllowed(mCurrentModule, Security.Domains.Administration.Name, Constants.Classifiers.Permissions_View);

        try
        {

            if (allowView)
            {
                if (!IsPostBack)
                {
                    Utils.GetMaster(this).AddNavlink("Customers", "../ModuleCustomers/Customers.aspx", "ClientsPageID");

                    newClientSimple_BirthDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;

                    FillAllComboBox();
                    ShowPanel(clientSelectionPanel.ID);
                }
                else
                {
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
        DataTable gendersList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.GenderList);
        Utils.FillSelector(newClientGenderListDDL, gendersList, "Name", "Code");
    }


    #region ClientSelection Region
    
    private void FillClientSelectionGrid()
    {
        int category = 0;
        DataTable clientsList = Utils.ModuleCustomers().GetClientList(category);
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

                FillClientAllForms(clientObject);
                ShowPanel(clientWorkPanel.ID);

                Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName, "../ModuleCredits/Clients.aspx?clid=" + clientID, "clientID");
            }
        }
    }

    protected void clientListGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
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

    protected void usersGrid_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }
    }

    #endregion ClientSelection Region

    #region Customers

    protected void newClientGenderList_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selectedGender = 0;
        int.TryParse(newClientGenderListDDL.SelectedValue, out selectedGender);

        ClearNewClientForm(selectedGender);
    }

    protected void ClearNewClientForm(int gender)
    {
        newCleint_simplePersonPanel.Visible = false;
        newCleint_juridPersonPanel.Visible = false;

        if (gender == (int)Constants.Classifiers.Gender_Male || gender == (int)Constants.Classifiers.Gender_Female)
        {
            newCleint_simplePersonPanel.Visible = true;

            try
            { newClientGenderListDDL.SelectedValue = ((int)Constants.Classifiers.Gender_Male).ToString(); }
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
            { newClientGenderListDDL.SelectedValue = ((int)Constants.Classifiers.Gender_JuridicPerson).ToString(); }
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
        ClearNewClientForm((int)Constants.Classifiers.Gender_JuridicPerson);
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


            if (gender == (int)Constants.Classifiers.Gender_Male || gender == (int)Constants.Classifiers.Gender_Female)
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
                //newClientObject.BirthDate = Crypt.Utils.ToDateTime(newClientSimple_BirthDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
                newClientObject.PersonalID = newClient_juridRegistrationNRTextBox.Text.Trim();
                //newClientObject.BuletinSeria = newClientSimple_BuletinTextBox.Text.Trim();
                newClientObject.TelefonFix = newClient_juridTelefonFixTextBox.Text.Trim();
                newClientObject.TelefonMobil = newClient_juridTelefonMobilTextBox.Text.Trim();
                newClientObject.Email = newClient_juridEmailTextBox.Text.Trim();
            }

            if (Utils.ModuleCustomers().AddNewClient(ref newClientObject))
            {
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
        clientPersonalDataSimplePanel.Visible = false;
        clientPersonalDataJuridicPanel.Visible = false;

        if (clientObject.Gender == (int)Constants.Classifiers.Gender_Male || clientObject.Gender == (int)Constants.Classifiers.Gender_Female)
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
    }

    protected void clientPersDataGenderList_SelectedIndexChanged(object sender, EventArgs e)
    {
        int gender =0;
        int.TryParse(clientPersDataGenderListDDL.SelectedValue, out gender);

        ClearPersonalDataClientForm(gender);
    }

    protected void ClearPersonalDataClientForm(int gender)
    {
        newCleint_simplePersonPanel.Visible = false;
        newCleint_juridPersonPanel.Visible = false;

        clientPersonalDataSimplePanel.Visible = false;
        clientPersonalDataJuridicPanel.Visible = false;

        if (gender == (int)Constants.Classifiers.Gender_Male || gender == (int)Constants.Classifiers.Gender_Female)
        {
            clientPersonalDataSimplePanel.Visible = true;

            try
            { clientPersDataGenderListDDL.SelectedValue = ((int)Constants.Classifiers.Gender_Male).ToString(); }
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
            { clientPersDataGenderListDDL.SelectedValue = ((int)Constants.Classifiers.Gender_JuridicPerson).ToString(); }
            catch { }

            clientPersData_juridFullNameTextBox.Text = string.Empty;
            clientPersData_juridRegistrationNRTextBox.Text = string.Empty;
            clientPersData_juridContactPersonTextBox.Text = string.Empty;
            clientPersData_juridTelefonFixTextBox.Text = string.Empty;
            clientPersData_juridTelefonMobilTextBox.Text = string.Empty;
            clientPersData_juridEmailTextBox.Text = string.Empty;
        }
    }

    #endregion Customers




}