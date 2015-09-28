using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

public partial class MasterPage : System.Web.UI.MasterPage, IMasterItems
{
    string mCurrentModule = string.Empty;

    void IMasterItems.ShowMessage(int messageType, string messageTitle, string message)
    {
        InfoWindow infoBox = (InfoWindow)mainDIV.FindControl("InfoBox");
        if (infoBox == null)
        {
            infoBox = (InfoWindow)LoadControl("~/Controls/InfoWindow.ascx");
        }

        infoBox.ID = "InfoBox";
        infoBox.MessageType = messageType;
        infoBox.WindowTitle = messageTitle;
        infoBox.Message = message;

        mainDIV.Controls.Add(infoBox);
        infoBox.Show();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        newClientSimple_BirthDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;

        if (Utils.AutentificatedUser)
        {
            if (!IsPostBack)
            {
                DataTable gendersList = Security.MainModule.GetClassifierByTypeID((int)Constants.ClassifierTypes.ClientType_Juridic_Fizic);
                Utils.FillSelector(newClientGenderListDDL, gendersList, "Name", "Code");
            }

            if (Session["currentSelectedClientObject"] != null)
            {
                DataObjects.Client clientObject = (DataObjects.Client)Session["currentSelectedClientObject"];
                if (clientObject != null)
                {
                    clientSelectionLink.Text = "Client: " + clientObject.FirstName + " " + clientObject.LastName;
                }

                ClearNavLinks();
                List<DataObjects.Client> subClientsList = Utils.ModuleCustomers().GetSubclientsObjectsList(clientObject.ClientID);

                AddNavlink(clientObject.FirstName + " " + clientObject.LastName, Request.Path + "?clt=" + clientObject.ClientID, clientObject.ClientID.ToString());

                if (subClientsList != null && subClientsList.Count > 0)
                {
                    for (int i = 0; i < subClientsList.Count; i++)
                    {
                        AddNavlink(subClientsList[i].FirstName + " " + subClientsList[i].LastName, Request.Path + "?clt=" + subClientsList[i].ClientID, subClientsList[i].ClientID.ToString());
                    }
                }
            }
        }
    }
       
    void IMasterItems.PerformPreloadActions(string currentModuleId, string pageName)
    {   
        bool isAutentificatedUser = Utils.AutentificatedUser;

        if (isAutentificatedUser)
        {
            mCurrentModule = currentModuleId;

            string moduleDescription = string.Empty;

            switch (mCurrentModule)
            {
                case Security.MainModule.ID:
                case Security.Module.ID:
                    moduleDescription = Utils.ModuleSecurity().GetModuleDescriptionById(mCurrentModule);
                    break;

            }

            string pageDescription = !string.IsNullOrEmpty(moduleDescription) ? moduleDescription : "Self-service platform";

            this.Page.Title = pageName + (!string.IsNullOrEmpty(pageDescription) && !string.IsNullOrEmpty(pageName) ? " - " : string.Empty) + pageDescription;


            #region Create Menu

            //// CREATE MODULE SELECTORS
            mainNavigateMenu.InnerHtml = Session[Utils.SessionKey_HeadModuleSlector] != null ? (string)Session[Utils.SessionKey_HeadModuleSlector] : string.Empty;

            //// CREATE GENERAL MENU FOR MODULE
            //switch (mCurrentModule)
            //{
            //    case Security.MainModule.ID:
            //    case Security.Module.ID:
            //        currentNavigateMenu.InnerHtml = Session[Utils.SessionKey_ModuleMainMenu] != null ? (string)Session[Utils.SessionKey_ModuleMainMenu] : string.Empty;
            //        break;

            //    case Client.Module.ID:
            //        currentNavigateMenu.InnerHtml = Session[Utils.SessionKey_ModuleCustomersMenu] != null ? (string)Session[Utils.SessionKey_ModuleCustomersMenu] : string.Empty;
            //        break;

            //    default:
            //        currentNavigateMenu.InnerHtml = string.Empty;
            //        break;

            //}


            //// LoginLOgout ButtonLink       
            string firstName = Utils.UserObject().FirstName;
            string lastName = Utils.UserObject().LastName;
            LogInLogOutLinkButton.Text = firstName + " " + lastName + " | Log OUT";
            LogInLogOutLinkButton.NavigateUrl = "~/Login.aspx?action=logout";


            emailBoxButton.Visible = true;
            clientSelectionLink.Visible = true;

            #endregion Create Menu
        }
        else
        {

            #region CLEAR ALL MENIU

            //// CREATE MODULE SELECTORS
            mainNavigateMenu.InnerHtml = string.Empty;

            //// CREATE GENERAL MENU FOR MODULE
            currentNavigateMenu.InnerHtml = string.Empty;


            //// LoginLOgout ButtonLink    
            LogInLogOutLinkButton.Text = "Log IN";
            LogInLogOutLinkButton.NavigateUrl = "~/Login.aspx?action=login";

            emailBoxButton.Visible = false;

            #endregion CLEAR ALL MENIU

            clientSelectionLink.Visible = false;

            FormsAuthentication.RedirectToLoginPage(Utils.GetQueryString(this.Page.Request, this.Page));
            Response.End();
        }

    }

    private void ClearNavLinks()
    {
        Session["NavLinks"] = null;
    }

    private void AddNavlink(string linkName, string linkURL, string linkID)
    {
        #region Check Autentifications

        bool resulAutentification = Utils.AutentificatedUser;

        if (resulAutentification)
        {
            if (Session["NavLinks"] == null)
            {
                DataTable navLinksDT = new DataTable();
                navLinksDT.Columns.Add("linkName", typeof(string));
                navLinksDT.Columns.Add("linkURL", typeof(string));
                navLinksDT.Columns.Add("linkID", typeof(string));

                Session["NavLinks"] = navLinksDT;
            }
        }
        else
        {
            Session["NavLinks"] = null;
        }

        #endregion Check Autentifications

        if (resulAutentification && Session["NavLinks"] != null)
        {
            DataTable navLinksDT = (DataTable)Session["NavLinks"];

            bool foundLinkID = false;
            int foundIndex = -1;

            for (int i = 0; i < navLinksDT.Rows.Count; i++)
            {
                if (!foundLinkID && navLinksDT.Rows[i]["linkID"].ToString().Equals(linkID))
                {
                    foundLinkID = true;
                    foundIndex = i;
                }
            }

            if (!foundLinkID)
            {
                navLinksDT.Rows.Add();
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkName"] = linkName;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkURL"] = linkURL;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkID"] = linkID;
            }
            else
            {
                for (int i = foundIndex; i < navLinksDT.Rows.Count; i++)
                {
                    navLinksDT.Rows[i].Delete();
                    navLinksDT.AcceptChanges();
                    i--;
                }

                navLinksDT.Rows.Add();
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkName"] = linkName;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkURL"] = linkURL;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkID"] = linkID;
            }
        }

        currentNavigateMenu.InnerHtml = GenerateShortNavLinks();
    }
    
    private string GenerateShortNavLinks()
    {
        string result = string.Empty;

        #region Check Autentifications
        
        if (Utils.AutentificatedUser)
        {
            DataObjects.Client currentClient = Utils.SelectedClient; 

            if (Session["NavLinks"] == null)
            {
                DataTable navLinksDT = new DataTable();
                navLinksDT.Columns.Add("linkName", typeof(string));
                navLinksDT.Columns.Add("linkURL", typeof(string));
                navLinksDT.Columns.Add("linkID", typeof(string));

                Session["NavLinks"] = navLinksDT;
            }
            
            DataTable shortNavLinksDT = (DataTable)Session["NavLinks"];

            if (shortNavLinksDT != null && shortNavLinksDT.Rows.Count > 0)
            {
                for (int i = 0; i < shortNavLinksDT.Rows.Count; i++)
                {
                    string backGriound = currentClient.ClientID.ToString().Equals(shortNavLinksDT.Rows[i]["linkID"].ToString()) ? "style='background-color: darkgrey;'" : string.Empty;
                    result += " <li> <a id=\"" + shortNavLinksDT.Rows[i]["linkID"].ToString() + "\" href=\"" + shortNavLinksDT.Rows[i]["linkURL"].ToString() + "\" " + backGriound + ">" + shortNavLinksDT.Rows[i]["linkName"].ToString() + (i < shortNavLinksDT.Rows.Count - 1 ? "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//" : string.Empty) + "</a> </li>";
                }
            }
        }
        else
        {
            Session["NavLinks"] = null;
        }

        #endregion Check Autentifications      

        return result;
    }

    protected void clientSelectionLink_Click(object sender, EventArgs e)
    {
        clientModalPopup.Show();
        ScriptManager.RegisterStartupScript(programmaticPopup, typeof(string), "GetCustomersList", "GetCustomersList(0);", true);

        txtSearch.Attributes["onkeyup"] = "Search('" + txtSearch.ClientID + "', '" + this.ClientID + "customersList');";
        customersDiv.Attributes["onscroll"] = "SetDivPosition('" + customersDiv.ClientID + "');";

        txtSearch.Value = txtSearch.Value;
        ScriptManager.RegisterStartupScript(programmaticPopup, typeof(string), "Search", "Search('" + txtSearch.ClientID + "', '" + this.ClientID + "customersList');", true);
        ScriptManager.RegisterStartupScript(programmaticPopup, typeof(string), "Scroll", "SetLastScrollPosition('" + customersDiv.ClientID + "');", true);
    }
    
    void IMasterItems.AddSubClientForm()
    {
        ClearNewClientForm((int)Constants.Classifiers.ClientType_PersoanaJuridica);
        clientPurposeHiddenField.Value = "SubClient";
        newClientPopupExtender.Show();
    }

    protected void okButton_Click(object sender, EventArgs e)
    {
        int selectedCelinID = 0;
        int.TryParse(selectedClientIDHiddenField.Value, out selectedCelinID);

        DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(selectedCelinID);

        clientSelectionLink.Text = "Client: " + clientObject.FirstName + " " + clientObject.LastName;

        Session["currentSelectedClientObject"] = clientObject;

        ClearNavLinks();
        List<DataObjects.Client> subClientsList = Utils.ModuleCustomers().GetSubclientsObjectsList(selectedCelinID);

        AddNavlink(clientObject.FirstName + " " + clientObject.LastName, Request.RawUrl + "?clt=" + selectedCelinID, Request.RawUrl);

        if (subClientsList != null && subClientsList.Count > 0)
        {
            for (int i = 0; i < subClientsList.Count; i++)
            {
                AddNavlink(subClientsList[i].FirstName + " " + subClientsList[i].LastName, Request.RawUrl + "?clt=" + subClientsList[i].ClientID, Request.RawUrl);
            }
        }


        //Utils.GetMaster(this).AddNavlink("Vinzari pentru: " + clientObject.FirstName + " " + clientObject.LastName, appPath + "/ModuleStore/Orders.aspx?act=chooseclt", Utils.Customer_HotNavogateKey);
    }

    protected void cancelButton_Click(object sender, EventArgs e)
    {
        clientModalPopup.Hide();
        DataObjects.Client clientObject = (DataObjects.Client)Session["currentSelectedClientObject"];
        selectedClientIDHiddenField.Value = clientObject != null ? clientObject.ClientID.ToString() : "";
    }
    
    protected void addNewClientButton_Click(object sender, EventArgs e)
    {
        ClearNewClientForm((int)Constants.Classifiers.ClientType_PersoanaJuridica);
        clientPurposeHiddenField.Value = string.Empty;
        newClientPopupExtender.Show();
    }
    
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
        clientPurposeHiddenField.Value = string.Empty;

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

    //protected void newClientSaveBurtton_Click(object sender, EventArgs e)
    //{       
        //DataObjects.Client newClientObject = new DataObjects.Client();

        //bool doByPass = false;
        //if (clientPurposeHiddenField.Value.EndsWith("SubClient") && Session["currentSelectedClientObject"] != null)
        //{
        //    DataObjects.Client parentClient = (DataObjects.Client)Session["currentSelectedClientObject"];

        //    if (parentClient != null && parentClient.ClientID != 0)
        //    {
        //        newClientObject.ParentClientID = parentClient.ClientID;
        //        doByPass = true;
        //    }
        //}
        //else
        //{
        //    doByPass = true;
        //}

        //if (doByPass)
        //{
        //    int gender = 0;
        //    int.TryParse(newClientGenderListDDL.SelectedValue, out gender);

        //    newClientObject.Gender = gender;
        //    newClientObject.Gender_String = newClientGenderListDDL.SelectedItem.Text;


        //    if (gender == (int)Constants.Classifiers.ClientType_PersoanaFizica)
        //    {
        //        newClientObject.FirstName = newClientSimple_FirstNameTextBox.Text.Trim();
        //        newClientObject.LastName = newClientSimple_LastNameTextBox.Text.Trim();
        //        newClientObject.BirthDate = Crypt.Utils.ToDateTime(newClientSimple_BirthDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
        //        newClientObject.PersonalID = newClientSimple_IDNPTextBox.Text.Trim();
        //        newClientObject.BuletinSeria = newClientSimple_BuletinTextBox.Text.Trim();
        //        newClientObject.TelefonFix = newClientSimple_TelefonFixTextBox.Text.Trim();
        //        newClientObject.TelefonMobil = newClientSimple_TelefonMobilTextBox.Text.Trim();
        //        newClientObject.Email = newClientSimple_EmailTextBox.Text.Trim();
        //    }
        //    else
        //    {
        //        newClientObject.FirstName = newClient_juridFullNameTextBox.Text.Trim();
        //        newClientObject.LastName = newClient_juridContactPersonTextBox.Text.Trim();
        //        newClientObject.PersonalID = newClient_juridRegistrationNRTextBox.Text.Trim();
        //        newClientObject.TelefonFix = newClient_juridTelefonFixTextBox.Text.Trim();
        //        newClientObject.TelefonMobil = newClient_juridTelefonMobilTextBox.Text.Trim();
        //        newClientObject.Email = newClient_juridEmailTextBox.Text.Trim();
        //    }

        //    if (Utils.ModuleCustomers().AddNewClient(ref newClientObject))
        //    {
        //        newClientPopupExtender.Hide();

        //        if (!clientPurposeHiddenField.Value.EndsWith("SubClient"))
        //        {
        //            clientSelectionLink.Text = "Client: " + newClientObject.FirstName + " " + newClientObject.LastName;
        //            Session["currentSelectedClientObject"] = newClientObject;
        //        }
        //    }
        //}
    

}
