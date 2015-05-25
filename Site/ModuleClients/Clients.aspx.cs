using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ImageResizer;
using ImageResizer.Encoding;

public partial class Clients : System.Web.UI.Page
{
    private readonly string mCurrentModule = string.Empty; //Credits.Module.ID;
    private readonly string mPageName = "Administrarea Contragentilor";
    private string appPath = string.Empty;

    bool allowPersonalDataView = false;
    bool allowPersonalDataEdit = false;
    bool allowContragentEditConsultEval = false;

    //Credits.DataObjects.Client ClientObject
    //{
    //    get { return Session["ClientObject"] != null ? (Credits.DataObjects.Client)Session["ClientObject"] : new Credits.DataObjects.Client(); }
    //    set { Session["ClientObject"] = value; }
    //}

    bool IsNewConsultEval
    {
        get { return Session["IsNewConsultEval"] != null ? (bool)Session["IsNewConsultEval"] : false; }
        set { Session["IsNewConsultEval"] = value; }
    }

    int CurrentConsultEval
    {
        get { return Session["CurrentConsultEval"] != null ? (int)Session["CurrentConsultEval"] : 0; }
        set { Session["CurrentConsultEval"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        appPath = Utils.GetApplicationPath(Request);
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        //allowPersonalDataView = Utils.PermissionAllowed(mCurrentModule, Credits.Domains.InputClientPersonalData.Name, Constants.Classifiers.Permissions_View);
        //allowPersonalDataEdit = Utils.PermissionAllowed(mCurrentModule, Credits.Domains.InputClientPersonalData.Name, Constants.Classifiers.Permissions_Edit);
        //allowContragentEditConsultEval = Utils.PermissionAllowed(mCurrentModule, Credits.Domains.ManageConsultEval.Name, Constants.Classifiers.Permissions_Edit);

        if (allowPersonalDataView)
        {
            newClientBirthDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            clientDateOfBirthCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            dataEliberariiCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            dataExpirariiCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
          

            if (!IsPostBack)
            {
                //Utils.GetMaster(this).AddNavlink("Clients", "../ModuleCredits/Clients.aspx", "ClientsPageID");

                //ShowPanel(clientSelectionPanel.ID);

                //FillAllComboOnAjaxTabPanel();

                //if (Request["clid"] != null && !Request["clid"].ToString().Equals(string.Empty))
                //{
                //    string stringClientID = Request["clid"].ToString();
                //    int clientID = 0;
                //    int.TryParse(stringClientID, out clientID);

                //    if (clientID > 0)
                //    {
                //        //Credits.DataObjects.Client clientObject = Utils.ModuleCredits().GetCleintObjectByID(clientID);
                //        //this.ClientObject = clientObject;
                //        //FillClientAllForms(clientObject);
                //        ShowPanel(clientWorkPanel.ID);

                //        if (Utils.GetMaster(this.Page).IsEmptyNavLinks)
                //        {
                //            Utils.GetMaster(this).AddNavlink("Clients", "../ModuleCredits/Clients.aspx", "ClientsPageID");
                //        }
                        
                //        Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName, "../ModuleCredits/Clients.aspx?clid=" + clientObject.ClientID, "clientID");
                //    }
                //    else
                //    {
                //        ClearPersonalDataForms();
                //        ClearClientBussinesTab();
                //        ClearConsultEvalForm();
                //    }
                //}
            }
            else
            {
                //string actionPanelName = Request.Params.Get("__EVENTTARGET");

                //if (actionPanelName.Equals(Constants.SessionPhotoTable.ConsultEvalPhotoFiles))
                //{
                //    string inputParams = Request.Params.Get("__EVENTARGUMENT");

                //    if (!string.IsNullOrEmpty(inputParams))
                //    {
                //        string decodedParams = Server.UrlDecode(inputParams);

                //        string[] manyParams = decodedParams.Split(';');

                //        if (manyParams.Length == 4)
                //        {
                //            string inputPhotoID = manyParams[0];
                //            string inputClevID = manyParams[1];
                //            string inputPhotoLink = manyParams[2];
                //            string inputSmollPhotoLink = manyParams[3];

                //            RemovePhotoFile(actionPanelName, inputPhotoID, inputClevID, inputPhotoLink, inputSmollPhotoLink);

                //            //if (actionPanelName.Equals(Constants.SessionPhotoTable.ConsultEvalPhotoFiles))
                //            //{
                //            //    editConsultPfotoContainer.InnerHtml = GetImagesLinks(actionPanelName);
                //            //}
                //        }
                //    }
                //}
            }
            
            personalPhotoUploadButton.Visible = allowPersonalDataEdit;
            clientPersonalDataSaveButton.Visible = allowPersonalDataEdit;
        }
        else
        {
            //Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
        }   
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
        {
            Utils.GetMaster(this).ShowMessage(Constants.InfoBoxMessageType.Error, "Error on Page.", ex.Message);
        }
    }

    protected void FillClientSelectionGrid()
    {
        //int category = 0;

        //DataTable clientsDT = Utils.ModuleCredits().GetClientlist(category);
        //clientListGridView.DataSource = clientsDT;
        //clientListGridView.DataBind();
    }

    //protected void FillClientAllForms(Credits.DataObjects.Client clientObject)
    //{
    //    ClearGenInfoForm();
    //    FillGenInfoForm(clientObject);

    //    ClearMainDataEditForms();
    //    FillMainEditFormInformationTab(clientObject);

    //    FillLoansGridView(clientObject.ClientID);

    //    ClearPersonalDataForms();
    //    FillPersonalInformationTab(clientObject);

    //    ClearClientBankForm();
    //    FillClientBankInformationTab(clientObject);

    //    ClearAddressesForms();
    //    FillClientAddressInformationTab(clientObject);

    //    ClearClientBussinesTab();
    //    FillClientBussinesTab(clientObject.ClientID);

    //    FillpersonalTrainigsGridView(clientObject.ClientID);

    //    ClearConsultEvalForm();
    //    FillConsultEvalGridView(clientObject.ClientID);
    //}

    private void FillAllComboOnAjaxTabPanel()
    {
        #region persoal Data TAB

        DataTable genderList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.GenderList);
        Utils.FillSelector(clientGenderDDL, genderList, "Name", "Code");

        //DataTable civilStatList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.CivilStatus);
        //Utils.FillSelector(clientCivilStatusDDL, civilStatList, "Name", "Code");

        //DataTable studiiList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.StudyLevel);
        //Utils.FillSelector(clientEducationLevelDDL, studiiList, "Name", "Code");

        //DataTable socialStatList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.SocialStatus);
        //Utils.FillSelector(clientSocialStatusDDL, socialStatList, "Name", "Code");

        //DataTable conditiiLocative = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.SituatiaMateriala);
        //Utils.FillSelector(situatiaMaterialaDDL, conditiiLocative, "Name", "Code");

        //DataTable bisericiList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.Biserica);
        //Utils.FillSelector(clientChurchDDL, bisericiList, "Name", "Code");

        //DataTable clientCategoryForFilter = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.ClientCategories);
        //Utils.FillSelector(clientCategoryForFilterDDL, clientCategoryForFilter, "Name", "Code");
        //Utils.FillSelector(newClientCategoryDDL, clientCategoryForFilter, "Name", "Code");

        #endregion persoal Data TAB        
      
    }

    #region ClientSelection Region

    protected void clientListGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (clientListGridView.SelectedRow != null)
        //{
        //    GridViewRow row = clientListGridView.SelectedRow;

        //    int clientID = 0;
        //    int.TryParse(row.Cells[0].Text, out clientID);

        //    if (clientID > 0)
        //    {
        //        Credits.DataObjects.Client clientObject = Utils.ModuleCredits().GetCleintObjectByID(clientID);
        //        this.ClientObject = clientObject;

        //        FillClientAllForms(clientObject);
        //        ShowPanel(clientWorkPanel.ID);

        //        Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName, "../ModuleCredits/Clients.aspx?clid=" + clientID, "clientID");
        //    }
        //}
    }

    protected void clientListGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

            for (int i = 0; i < e.Row.Cells.Count - 1; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.clientListGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }
    
    protected void clientListGridView_PreRender(object sender, EventArgs e)
    {
        if(clientListGridView.HeaderRow != null)
        clientListGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    #endregion ClientSelection Region
    
    #region New Client Region

    protected void addNewClientButton_Click(object sender, EventArgs e)
    {
        ClearNewClientForm();
        newClientModalPopup.Show();
    }

    protected void ClearNewClientForm()
    {
        newClientImage.ImageUrl = string.Empty;
        newClientImageHiddenField.Value = string.Empty;
        newClientNumeTextBox.Text = string.Empty;
        newClientPrenumeTextBox.Text = string.Empty;
        newClientBirthDateTextBox.Text = string.Empty;
        newClientTelefonFixTextBox.Text = string.Empty;
        newClientTelefonMobilTextBox.Text = string.Empty;
        newClientTelefonMobil2TextBox.Text = string.Empty;
        newClientEmailTextBox.Text = string.Empty;

        try { newClientCategoryDDL.SelectedIndex = 0; }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage(Constants.InfoBoxMessageType.Error, "Error on Page.", ex.Message);
        }
    }

    //protected void newClientFotoUploadButton_Click(object sender, EventArgs e)
    //{
    //    if (allowPersonalDataEdit)
    //    {
    //        HttpPostedFile file = newClientFotoFileUpload.PostedFile;
    //        if (file != null && file.ContentLength > 0)
    //        {
    //            Dictionary<string, string> versions = new Dictionary<string, string>();
    //            //Define the version to generate
    //            versions.Add("_thumb", "width=250&height=250&format=jpg&mode=max");

    //            string tempFolder = Utils.ModuleMain().TempFolder;

    //            ImageJob im = new ImageJob(file, tempFolder + "\\<guid>.<ext>", new ResizeSettings(versions["_thumb"]));
    //            im.CreateParentDirectory = true; //Auto-create the uploads directory.
    //            im.Build();

    //            string[] fullPath = im.FinalPath.Split('\\');

    //            string finalSmallFullFileName = string.Empty;
    //            if (fullPath != null && fullPath.Length > 1)
    //            {
    //                finalSmallFullFileName = tempFolder + fullPath[fullPath.Length - 1];
    //            }

    //            newClientImage.ImageUrl = finalSmallFullFileName;
    //            newClientImageHiddenField.Value = finalSmallFullFileName;
    //        }

    //        newClientModalPopup.Show();
    //    }
    //    else
    //    {
    //        Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
    //    }
    //}
    
    protected void newClientSaveButton_Click(object sender, EventArgs e)
    {
        try
        {
            //if (allowPersonalDataEdit)
            //{ 
            //    Credits.DataObjects.Client clientObject = new Credits.DataObjects.Client();

            //    clientObject.FirstName = newClientNumeTextBox.Text;
            //    clientObject.LastName = newClientPrenumeTextBox.Text;
            //    clientObject.BirthDate = Crypt.Utils.ToDateTime(newClientBirthDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
            //    clientObject.TelefonFix = newClientTelefonFixTextBox.Text.Trim();
            //    clientObject.TelefonMobil = newClientTelefonMobilTextBox.Text.Trim();
            //    clientObject.TelefonMobil2 = newClientTelefonMobil2TextBox.Text.Trim();
            //    clientObject.Email = newClientEmailTextBox.Text.Trim();

            //    int category = 0;
            //    int.TryParse(newClientCategoryDDL.SelectedValue, out category);

            //    clientObject.SortGroup = category;

            //    int newClientID = 0;

            //    string temImageURL = newClientImageHiddenField.Value; 

            //    if (!Utils.ModuleCredits().CheckExistClient(clientObject.FirstName, clientObject.LastName, clientObject.BirthDate))
            //    {
            //        if (Utils.ModuleCredits().AddNewClient(clientObject, out newClientID))
            //        {
            //            ClearNewClientForm();
            //            clientObject.ClientID = newClientID;
            //            this.ClientObject = clientObject;

            //            if (!temImageURL.Equals(string.Empty))
            //            {
            //                string creditModuleFileDirectory = Utils.ModuleCredits().RootModuleFolder;
            //                Utils.ModuleCredits().CheckClientPersonalFolders(clientObject, Server.MapPath(creditModuleFileDirectory));
            //                string clientPersonalFolder = this.ClientObject.ClientPersonalFolder;

            //                string[] fullPath = temImageURL.Split('/');

            //                string finalSmallFullFileName = string.Empty;
            //                if (fullPath != null && fullPath.Length > 1)
            //                {
            //                    finalSmallFullFileName = clientPersonalFolder + "/" + fullPath[fullPath.Length - 1];
            //                }

            //                try
            //                {
            //                    string tempFullPath = Server.MapPath(temImageURL);
            //                    string pathToCopy = Server.MapPath(creditModuleFileDirectory + "/" + finalSmallFullFileName);
            //                    System.IO.File.Move(tempFullPath, pathToCopy);
                              
            //                    clientObject.ImageURL = finalSmallFullFileName;
            //                    Utils.ModuleCredits().UpdateClient(clientObject);
            //                }
            //                catch { }
            //            }

            //            FillClientSelectionGrid();
            //            FillClientAllForms(clientObject);
            //        }
            //        else
            //        {
            //            clientImage.ImageUrl = newClientImageHiddenField.Value;
            //            generalInfoImage.ImageUrl = newClientImageHiddenField.Value;
            //            newClientModalPopup.Show();
            //            Utils.InfoText(this, "Atentie! Datele nu au fost salvate!", "Datele nu au fost salvate. " + Utils.ModuleCredits().LastError);
            //        }
            //    }
            //    else
            //    {
            //        clientImage.ImageUrl = newClientImageHiddenField.Value;
            //        generalInfoImage.ImageUrl = newClientImageHiddenField.Value;
            //        newClientModalPopup.Show();
            //        Utils.InfoText(this, "Atentie! Datele nu au fost salvate!", "Astfel de client deja este in baza de date. Va rugam sa verificati intre clientii inregistrati.");
            //    }
            //}
            //else
            //{
            //    Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
            //}
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage(Constants.InfoBoxMessageType.Error, "Error on Page.", ex.Message);
        }
    }    

    #endregion New Client Region

    #region GeneralInfo Form

    protected void ClearGenInfoForm()
    {
        genInfoActivationDateLabel.Text = string.Empty;
        genInfoManagerCreditareLabel.Text = string.Empty;
        genInfoTotalLoansNumberLabel.Text = string.Empty;
        genInfoLastLoanAmountLabel.Text = string.Empty;
        genInfoActiveLoansLabel.Text = string.Empty;
        genInfoTotalSavingsLabel.Text = string.Empty;
        genInfoActiveSavingsLabel.Text = string.Empty;
    }

    //private void FillGenInfoForm(Credits.DataObjects.Client clientObject)
    //{
    //    try
    //    {
    //        if (clientObject != null)
    //        {
    //            genInfoActivationDateLabel.Text = clientObject.ActivationDate.ToString(Constants.ISODateBackwardDotsFormat);
    //            genInfoMobileNumberLabel.Text = clientObject.TelefonMobil;
    //            genInfoManagerCreditareLabel.Text = clientObject.LastManager;
    //            genInfoTotalLoansNumberLabel.Text = clientObject.TotalLoansNumber.ToString();
    //            genInfoLastLoanAmountLabel.Text = clientObject.LastLoanAmount.ToString();
    //            genInfoActiveLoansLabel.Text = clientObject.ActiveLoans.ToString();
    //            genInfoTotalSavingsLabel.Text = clientObject.TotalProfits.ToString();
    //            genInfoActiveSavingsLabel.Text = clientObject.ActiveProfits.ToString();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
    //    }
    //}

    #endregion GeneralInfo Form

    #region Main Personal data panel

    protected void personalPhotoUploadButton_Click(object sender, EventArgs e)
    {
        //if (allowPersonalDataEdit && this.ClientObject != null)
        //{
        //    HttpPostedFile file = personalPhotoFileUpload.PostedFile;

        //    if (file != null && file.ContentLength > 0 && this.ClientObject != null && !this.ClientObject.ClientPersonalFolder.Equals(string.Empty))
        //    {
        //        Dictionary<string, string> versions = new Dictionary<string, string>();
        //        //Define the version to generate
        //        versions.Add("_thumb", "width=250&height=250&format=jpg&mode=max");

        //        string creditModuleFileDirectory = Utils.ModuleCredits().RootModuleFolder;
        //        string clientPersonalFolder = this.ClientObject.ClientPersonalFolder;

        //        ImageJob im = new ImageJob(file, creditModuleFileDirectory + "\\" + clientPersonalFolder + "\\<guid>.<ext>", new ResizeSettings(versions["_thumb"]));
        //        im.CreateParentDirectory = true; //Auto-create the uploads directory.
        //        im.Build();

        //        string[] fullPath = im.FinalPath.Split('\\');

        //        string finalSmallFullFileName = string.Empty;
        //        if (fullPath != null && fullPath.Length > 1)
        //        {
        //            finalSmallFullFileName = clientPersonalFolder + "/" + fullPath[fullPath.Length - 1];
        //        }

        //        string oldImageURL = clientImage.ImageUrl;

        //        try
        //        {
        //            System.IO.File.Delete(Server.MapPath(creditModuleFileDirectory + "/" + oldImageURL)); 
        //        }
        //        catch { }

        //        clientImage.ImageUrl = creditModuleFileDirectory + "/" + finalSmallFullFileName;
        //        generalInfoImage.ImageUrl = creditModuleFileDirectory + "/" + finalSmallFullFileName;
        //        this.ClientObject.ImageURL = finalSmallFullFileName;
        //        //Utils.ModuleCredits().UpdateClient(ClientObject);
        //    }
        //}
        //else
        //{
        //    Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
        //}
    }

    protected void ClearMainDataEditForms()
    {
        /////  main form
        clientImage.ImageUrl = string.Empty;
        generalInfoImage.ImageUrl = string.Empty;
        clientNumeTextBox.Text = string.Empty;
        clientPrenumeTextBox.Text = string.Empty;
        clientDateOfBirthTextBox.Text = string.Empty;
        clientPlaseOfBirthTextBox.Text = string.Empty;
        addNewClientTelefonFixTextBox.Text = string.Empty;
        addNewClientTelefonMobilTextBox.Text = string.Empty;
        addNewClientTelefonMobil2TextBox.Text = string.Empty;
        addNewClientEmailTextBox.Text = string.Empty;
        clientCategoryForFilterDDL.SelectedIndex = -1;
        /////////////
    }

    //private void FillMainEditFormInformationTab(Credits.DataObjects.Client clientObject)
    //{
    //    try
    //    {
    //        if (clientObject != null)
    //        {
    //            //// Main finfo  
    //            clientImage.ImageUrl = Utils.ModuleCredits().RootModuleFolder + "/" + clientObject.ImageURL;
    //            generalInfoImage.ImageUrl = Utils.ModuleCredits().RootModuleFolder + "/" + clientObject.ImageURL;
    //            clientNumeTextBox.Text = clientObject.FirstName;
    //            clientPrenumeTextBox.Text = clientObject.LastName;
    //            clientDateOfBirthTextBox.Text = clientObject.BirthDate.ToString(Constants.ISODateBackwardDotsFormat);
    //            clientPlaseOfBirthTextBox.Text = clientObject.PlaceOfBirth;
    //            addNewClientTelefonFixTextBox.Text = clientObject.TelefonFix;
    //            addNewClientTelefonMobilTextBox.Text = clientObject.TelefonMobil;
    //            addNewClientTelefonMobil2TextBox.Text = clientObject.TelefonMobil2;
    //            addNewClientEmailTextBox.Text = clientObject.Email;
    //            try { clientCategoryForFilterDDL.SelectedValue = clientObject.SortGroup.ToString(); }
    //            catch { }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
    //    }
    //}

    #endregion Main Personal data panel

    #region Loans

    private void FillLoansGridView(int clientID)
    {
        //int loanState = activInactivloansHiddenField.Value.ToLower().Equals("active") ? (int)Constants.Classifiers.CreditState_Activ : (int)Constants.Classifiers.CreditState_Achitat ;

        //DataTable loanss = Utils.ModuleCredits().GetLoansList(loanState, clientID);

        //if (loanss != null)
        //{
        //    loansGridView.DataSource = loanss;
        //    loansGridView.DataBind();
        //}
    }

    protected void loansGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        loansGridView.PageIndex = e.NewPageIndex;

        //int clientID = this.ClientObject.ClientID;
        //FillLoansGridView(clientID);
    }

    protected void loansGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

            for (int i = 0; i < e.Row.Cells.Count - 1; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.loansGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }

    protected void loansGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (loansGridView.SelectedRow != null)
        {
            GridViewRow row = loansGridView.SelectedRow;

            int loandID = 0;
            int.TryParse(row.Cells[0].Text, out loandID);

            Response.Redirect("LoanInfo.aspx?cd=" + loandID.ToString());
        }
    }

    protected void refreshLoansButton_Click(object sender, EventArgs e)
    {
        //int clientID = this.ClientObject.ClientID;
        //FillLoansGridView(clientID);
    }

    protected void activeInactiveCreditsButton_Click(object sender, EventArgs e)
    {
        if (activInactivloansHiddenField.Value.ToLower().Equals("active"))
        {
            activInactivloansHiddenField.Value = "Inchise";
            activeInactiveCreditsButton.Text = "Crdite Active";
        }
        else
        {
            activInactivloansHiddenField.Value = "Active";
            activeInactiveCreditsButton.Text = "Crdite Inchise";
        }

        //int clientID = this.ClientObject.ClientID;
        //FillLoansGridView(clientID);
    }

    #endregion Loans

    #region Personal Data Region
    
    protected void ClearPersonalDataForms()
    {
        clientPersonalIDTextBox.Text = string.Empty;
        buletinSeriaTextBox.Text = string.Empty;
        eliberatDeTextBox.Text = string.Empty;
        dataEliberariiTextBox.Text = string.Empty;
        dataExpirariiTextBox.Text = string.Empty;
       

        try { clientGenderDDL.SelectedIndex = 0; }
        catch { }

        try { clientCivilStatusDDL.SelectedIndex = 0; }
        catch { }
    }

    //private void FillPersonalInformationTab(Credits.DataObjects.Client clientObject)
    //{
    //    try
    //    {
    //        if (clientObject != null)
    //        {
    //            //// personal info form
    //            clientPersonalIDTextBox.Text = clientObject.PersonalID;
    //            buletinSeriaTextBox.Text = clientObject.BuletinSeria;
    //            eliberatDeTextBox.Text = clientObject.BuletinEliberatDe;
    //            dataEliberariiTextBox.Text = clientObject.DataEliberariiBuletin != DateTime.MinValue ? clientObject.DataEliberariiBuletin.ToString("dd.M.yyyy") : string.Empty;
    //            dataExpirariiTextBox.Text = clientObject.DataExpirariiBuletin != DateTime.MinValue ? clientObject.DataExpirariiBuletin.ToString("dd.M.yyyy") : string.Empty;

    //            SetLabelsOnPersonsGenderSelect(clientObject.Gender);
    //            husbandDescriptionTextbox.Text = clientObject.HusbandFullName;
    //            personalDataClientCildrensTextBox.Text = clientObject.NumberOfChildren.ToString();
    //            nrPersoaneInIntretinereTextbox.Text = clientObject.NrPersoaneIntretinere.ToString();
    //            personalDataClientVenitLunarInceputTextBox.Text = clientObject.VenitFamInceputAfacere.ToString();
    //            slujireaInBisericaTextBox.Text = clientObject.SlujireInBiserica;
    //            pastorLiderTextBox.Text = clientObject.PastorLider;
    //            telefonPastorTextBox.Text = clientObject.TelefonPastor;

    //            try { clientGenderDDL.SelectedValue = clientObject.Gender.ToString(); }
    //            catch { }
    //            try { clientCivilStatusDDL.SelectedValue = clientObject.CivilStatus.ToString(); }
    //            catch { }
    //            try { clientEducationLevelDDL.SelectedValue = clientObject.StudyLevel.ToString(); }
    //            catch { }
    //            try { clientSocialStatusDDL.SelectedValue = clientObject.SocialStatus.ToString(); }
    //            catch { }
    //            try { situatiaMaterialaDDL.SelectedValue = clientObject.SituatiaMateriala.ToString(); }
    //            catch { }
    //            try { clientChurchDDL.SelectedValue = clientObject.Church.ToString(); }
    //            catch { }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
    //    }
    //}
    
    protected void clientGenderDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        int slectedGender = 0;
        int.TryParse(clientGenderDDL.SelectedValue, out slectedGender);

       // SetLabelsOnPersonsGenderSelect(slectedGender);
    }

    //private void SetLabelsOnPersonsGenderSelect(int genderType)
    //{
    //    if (genderType == (int)Constants.Classifiers.Persoana_Juridica)
    //    {
    //        husbendLabel.Text = "Administrator:";
    //        personalNumebrLabel.Text = "Cod Fiscal:";
    //        buletinSeriaLabel.Text = "Certificat de inreg.";
    //        numeleLabel.Text = "Denumirea Organiz.:";
    //        dataNastereLabel.Text = "Data inregistraii:";

    //        civilStatusDt.Visible = false;
    //        civilStatusDD.Visible = false;
    //        clientCivilStatusDDL.SelectedIndex = 0;

    //        childrenDt.Visible = false;
    //        childrenDD.Visible = false;
    //        prenumeleDT.Visible = false;
    //        prenumeleDD.Visible = false;
    //        plaseOfBirthDT.Visible = false;
    //        plaseOfBirthDD.Visible = false;
    //    }
    //    else
    //    {
    //        husbendLabel.Text = "Sotia/Sotul:";
    //        personalNumebrLabel.Text = "Cod Personal:";
    //        buletinSeriaLabel.Text = "Buletin Seria:";
    //        numeleLabel.Text = "Numele:";
    //        dataNastereLabel.Text = "Data Nasterii:";

    //        civilStatusDt.Visible = true;
    //        civilStatusDD.Visible = true;

    //        childrenDt.Visible = true;
    //        childrenDD.Visible = true;
    //        prenumeleDT.Visible = true;
    //        prenumeleDD.Visible = true;
    //        plaseOfBirthDT.Visible = true;
    //        plaseOfBirthDD.Visible = true;
    //    }
    //}

   
    protected void clientPersonalDataSaveButton_Click(object sender, EventArgs e)
    {
        if (allowPersonalDataEdit)
        {
            try
            {
                //Credits.DataObjects.Client clientObject = null;
                //if (this.ClientObject != null)
                //{
                //    clientObject = this.ClientObject;
                //}

                //if (clientObject != null)
                //{
                //    //////  general info  
                //    clientObject.FirstName = clientNumeTextBox.Text.Trim();
                //    clientObject.LastName = clientPrenumeTextBox.Text.Trim();
                //    clientObject.BirthDate = Crypt.Utils.ToDateTime(clientDateOfBirthTextBox.Text, Constants.ISODateBackwardDotsFormat);
                //    clientObject.PlaceOfBirth = clientPlaseOfBirthTextBox.Text.Trim();
                //    clientObject.TelefonFix = addNewClientTelefonFixTextBox.Text.Trim();
                //    clientObject.TelefonMobil = addNewClientTelefonMobilTextBox.Text.Trim();
                //    clientObject.TelefonMobil2 = addNewClientTelefonMobil2TextBox.Text.Trim();
                //    clientObject.Email = addNewClientEmailTextBox.Text.Trim();

                //    int Category = 0;
                //    int.TryParse(clientCategoryForFilterDDL.SelectedValue, out Category);
                //    clientObject.SortGroup = Category;
                //    clientObject.SortGroup_String = clientCategoryForFilterDDL.SelectedItem.Text;

                //    //////// personal info form
                //    clientObject.PersonalID = clientPersonalIDTextBox.Text.Trim();
                //    clientObject.BuletinSeria = buletinSeriaTextBox.Text.Trim();
                //    clientObject.BuletinEliberatDe = eliberatDeTextBox.Text.Trim();
                //    clientObject.DataEliberariiBuletin = Crypt.Utils.ToDateTime(dataEliberariiTextBox.Text, Constants.ISODateBackwardDotsFormat);
                //    clientObject.DataExpirariiBuletin = Crypt.Utils.ToDateTime(dataExpirariiTextBox.Text, Constants.ISODateBackwardDotsFormat);

                //    int gender = 0;
                //    int.TryParse(clientGenderDDL.SelectedValue, out gender);
                //    clientObject.Gender = gender;
                //    clientObject.Gender_String = clientGenderDDL.SelectedItem.Text;

                //    int sivilStatus = 0;
                //    int.TryParse(clientCivilStatusDDL.SelectedValue, out sivilStatus);
                //    clientObject.CivilStatus = sivilStatus;
                //    clientObject.CivilStatus_String = clientCivilStatusDDL.SelectedItem.Text;

                //    clientObject.HusbandID = husbandClientSelectionControl.SelectedClientID;
                //    clientObject.HusbandFullName = husbandDescriptionTextbox.Text;

                //    int numberOfCildren = 0;
                //    int.TryParse(personalDataClientCildrensTextBox.Text, out numberOfCildren);
                //    clientObject.NumberOfChildren = numberOfCildren;

                //    int NrPersoaneIntretinere = 0;
                //    int.TryParse(nrPersoaneInIntretinereTextbox.Text, out NrPersoaneIntretinere);
                //    clientObject.NrPersoaneIntretinere = NrPersoaneIntretinere;

                //    int StudyLevel = 0;
                //    int.TryParse(clientEducationLevelDDL.SelectedValue, out StudyLevel);
                //    clientObject.StudyLevel = StudyLevel;
                //    clientObject.StudyLevel_String = clientEducationLevelDDL.SelectedItem.Text;

                //    int SocialStatus = 0;
                //    int.TryParse(clientSocialStatusDDL.SelectedValue, out SocialStatus);
                //    clientObject.SocialStatus = SocialStatus;
                //    clientObject.SocialStatus_String = clientSocialStatusDDL.SelectedItem.Text;

                //    int VenitFamInceputAfacere = 0;
                //    int.TryParse(personalDataClientVenitLunarInceputTextBox.Text, out VenitFamInceputAfacere);
                //    clientObject.VenitFamInceputAfacere = VenitFamInceputAfacere;

                //    int SituatiaMateriala = 0;
                //    int.TryParse(situatiaMaterialaDDL.SelectedValue, out SituatiaMateriala);
                //    clientObject.SituatiaMateriala = SituatiaMateriala;
                //    clientObject.SituatiaMateriala_String = situatiaMaterialaDDL.SelectedItem.Text;

                //    int Church = 0;
                //    int.TryParse(clientChurchDDL.SelectedValue, out Church);
                //    clientObject.Church = Church;
                //    clientObject.Church_String = clientChurchDDL.SelectedItem.Text;

                //    clientObject.SlujireInBiserica = slujireaInBisericaTextBox.Text.Trim();
                //    clientObject.PastorLider = pastorLiderTextBox.Text.Trim();
                //    clientObject.TelefonPastor = telefonPastorTextBox.Text.Trim();


                //    ////////   address form
                //    clientObject.Viza_Localitatea = vizaClientAddressLocalitateaTextBox.Text.Trim();
                //    clientObject.Viza_StradaAdresa = vizaClientAddressAdresaTextBox.Text.Trim();
                //    clientObject.Raddress_Localitatea = rAddressClientLocalitateaTextBox.Text.Trim();
                //    clientObject.Raddress_StradaAdresa = rAddressAddresaStradaTextBox.Text.Trim();

                //    clientObject.Viza_UrbanRural = vizaUrbanRuralDDL.SelectedValue;
                //    clientObject.Raddress_UrbanRural = rAddressUrbanRuralDDL.SelectedValue;

                //    int Viza_Country = 0;
                //    int.TryParse(vizaClientAddressCountryDDL.SelectedValue, out Viza_Country);
                //    clientObject.Viza_Country = Viza_Country;
                //    clientObject.Viza_Country_String = vizaClientAddressCountryDDL.SelectedItem.Text;

                //    int Viza_Raion = 0;
                //    int.TryParse(vizaClientAddressClientRaionDDL.SelectedValue, out Viza_Raion);
                //    clientObject.Viza_Raion = Viza_Raion;
                //    clientObject.Viza_Raion_String = vizaClientAddressClientRaionDDL.SelectedItem.Text;

                //    int Raddress_Country = 0;
                //    int.TryParse(rAddressClientCountryDDL.SelectedValue, out Raddress_Country);
                //    clientObject.Raddress_Country = Raddress_Country;
                //    clientObject.Raddress_Country_String = rAddressClientCountryDDL.SelectedItem.Text;

                //    int Raddress_Raion = 0;
                //    int.TryParse(rAddressClientRaionDDL.SelectedValue, out Raddress_Raion);
                //    clientObject.Raddress_Raion = Raddress_Raion;
                //    clientObject.Raddress_Raion_String = rAddressClientRaionDDL.SelectedItem.Text;


                //    /////////  bank fomr   
                //    int bankID = 0;
                //    if (clientBankDDL.SelectedValue != null) int.TryParse(clientBankDDL.SelectedValue, out bankID);
                //    clientObject.Bank_id = bankID;

                //    clientObject.Bank_IBAN = clientBankIBANTextBox.Text.Trim();
                //    clientObject.BankName = clientBankDDL.SelectedItem.Text;
                //    clientObject.ContBancar = clientBankContBancarTextBox.Text.Trim();

                //    string moduleFolder = Utils.ModuleCredits().RootModuleFolder;
                //    int newClientID = 0;

                //    if (clientObject.ClientID != 0 && Utils.ModuleCredits().UpdateClient(clientObject))
                //    {
                //        addNewCreditButton.Attributes.Add("onclick", "window.open('Credits.aspx?cd=n&clid=" + newClientID + "', '_blank' );");

                //        this.ClientObject = clientObject;
                //        FillClientSelectionGrid();
                //        husbandClientSelectionControl.BindDataSource();
                //        Utils.InfoText(this, "Success!", "Datele au fost salvate.");
                //    }
                //    else
                //    {
                //        Utils.InfoText(this, "Atentie", " { " + clientObject.FirstName + " " + clientObject.LastName + " } - nu a fost salvat.");
                //    }      
                //}
            }
            catch (Exception ex)
            { Utils.GetMaster(this).ShowMessage(Constants.InfoBoxMessageType.Error, "Error on Page.", ex.Message); }
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    protected void clientPersonalDataCancelButton_Click(object sender, EventArgs e)
    {
        //FillClientAllForms(this.ClientObject);
    }

    protected void clientPersonalFolderButton_Click(object sender, EventArgs e)
    {
        try
        {
            //Credits.DataObjects.Client clientObject = this.ClientObject;

            //if (clientObject != null && clientObject.ClientID != 0)
            //{
            //    Utils.ModuleCredits().CheckClientPersonalFolders(clientObject, Server.MapPath(Utils.ModuleCredits().RootModuleFolder));
            //    personalFileBrowser.TitleWindow = "Mapa Personala pentru: " + clientObject.FirstName + " " + clientObject.LastName;
            //    personalFileBrowser.RootDirectory = Utils.ModuleCredits().RootModuleFolder + "/" + clientObject.ClientPersonalFolder + "/" + "PersonalDocuments";
            //    personalFileBrowser.Show();
            //}
        }
        catch
        { }
    }

    protected void addNewCreditButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("Credits.aspx?cd=n");
    }

    #endregion Personal Data Region

    protected void newClientFotoUploadButton_Click(object sender, EventArgs e)
    {
    }

}