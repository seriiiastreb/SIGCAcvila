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
    private readonly string mCurrentModule = Credits.Module.ID;
    private readonly string mPageName = "Administrarea Contragentilor";
    private string appPath = string.Empty;

    bool allowPersonalDataView = false;
    bool allowPersonalDataEdit = false;
    bool allowContragentEditConsultEval = false;

    Credits.DataObjects.Client ClientObject
    {
        get { return Session["ClientObject"] != null ? (Credits.DataObjects.Client)Session["ClientObject"] : new Credits.DataObjects.Client(); }
        set { Session["ClientObject"] = value; }
    }

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

        allowPersonalDataView = Utils.PermissionAllowed(mCurrentModule, Credits.Domains.InputClientPersonalData.Name, Constants.Classifiers.Permissions_View);
        allowPersonalDataEdit = Utils.PermissionAllowed(mCurrentModule, Credits.Domains.InputClientPersonalData.Name, Constants.Classifiers.Permissions_Edit);
        allowContragentEditConsultEval = Utils.PermissionAllowed(mCurrentModule, Credits.Domains.ManageConsultEval.Name, Constants.Classifiers.Permissions_Edit);

        if (allowPersonalDataView)
        {
            newClientBirthDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            clientDateOfBirthCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            dataEliberariiCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            dataExpirariiCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            bussinesStartDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
            editDataCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;


            if (!IsPostBack)
            {
                Utils.GetMaster(this).AddNavlink("Clients", "../ModuleCredits/Clients.aspx", "ClientsPageID");

                ShowPanel(clientSelectionPanel.ID);

                husbandClientSelectionControl.BindDataSource();
                FillAllComboOnAjaxTabPanel();

                if (Request["clid"] != null && !Request["clid"].ToString().Equals(string.Empty))
                {
                    string stringClientID = Request["clid"].ToString();
                    int clientID = 0;
                    int.TryParse(stringClientID, out clientID);

                    if (clientID > 0)
                    {
                        Credits.DataObjects.Client clientObject = Utils.ModuleCredits().GetCleintObjectByID(clientID);
                        this.ClientObject = clientObject;
                        FillClientAllForms(clientObject);
                        ShowPanel(clientWorkPanel.ID);

                        if (Utils.GetMaster(this.Page).IsEmptyNavLinks)
                        {
                            Utils.GetMaster(this).AddNavlink("Clients", "../ModuleCredits/Clients.aspx", "ClientsPageID");
                        }
                        
                        Utils.GetMaster(this).AddNavlink(clientObject.FirstName + " " + clientObject.LastName, "../ModuleCredits/Clients.aspx?clid=" + clientObject.ClientID, "clientID");
                    }
                    else
                    {
                        ClearPersonalDataForms();
                        ClearClientBussinesTab();
                        ClearConsultEvalForm();
                    }
                }
            }
            else
            {
                string actionPanelName = Request.Params.Get("__EVENTTARGET");

                if (actionPanelName.Equals(Constants.SessionPhotoTable.ConsultEvalPhotoFiles))
                {
                    string inputParams = Request.Params.Get("__EVENTARGUMENT");

                    if (!string.IsNullOrEmpty(inputParams))
                    {
                        string decodedParams = Server.UrlDecode(inputParams);

                        string[] manyParams = decodedParams.Split(';');

                        if (manyParams.Length == 4)
                        {
                            string inputPhotoID = manyParams[0];
                            string inputClevID = manyParams[1];
                            string inputPhotoLink = manyParams[2];
                            string inputSmollPhotoLink = manyParams[3];

                            RemovePhotoFile(actionPanelName, inputPhotoID, inputClevID, inputPhotoLink, inputSmollPhotoLink);

                            if (actionPanelName.Equals(Constants.SessionPhotoTable.ConsultEvalPhotoFiles))
                            {
                                editConsultPfotoContainer.InnerHtml = GetImagesLinks(actionPanelName);
                            }
                        }
                    }
                }
            }

            addNewClientButton.Visible = allowPersonalDataEdit;
            Button3.Visible = allowPersonalDataEdit;
            Button5.Visible = allowPersonalDataEdit;


            personalPhotoUploadButton.Visible = allowPersonalDataEdit;
            clientPersonalDataSaveButton.Visible = allowPersonalDataEdit;
            clientBusinessSaveButton.Visible = allowPersonalDataEdit;
            addPersonalTrainiButton.Visible = allowPersonalDataEdit;


            addNewConsultEvalButton.Visible = allowContragentEditConsultEval;
            editFileUploadButton.Visible = allowContragentEditConsultEval;
            editConsultSaveButton.Visible = allowContragentEditConsultEval;
        }
        else
        {
            Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
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
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
        }
    }

    protected void FillClientSelectionGrid()
    {
        int category = 0;

        DataTable clientsDT = Utils.ModuleCredits().GetClientlist(category);
        clientListGridView.DataSource = clientsDT;
        clientListGridView.DataBind();
    }

    protected void FillClientAllForms(Credits.DataObjects.Client clientObject)
    {
        ClearGenInfoForm();
        FillGenInfoForm(clientObject);

        ClearMainDataEditForms();
        FillMainEditFormInformationTab(clientObject);

        FillLoansGridView(clientObject.ClientID);

        ClearPersonalDataForms();
        FillPersonalInformationTab(clientObject);

        ClearClientBankForm();
        FillClientBankInformationTab(clientObject);

        ClearAddressesForms();
        FillClientAddressInformationTab(clientObject);

        ClearClientBussinesTab();
        FillClientBussinesTab(clientObject.ClientID);

        FillpersonalTrainigsGridView(clientObject.ClientID);

        ClearConsultEvalForm();
        FillConsultEvalGridView(clientObject.ClientID);
    }

    private void FillAllComboOnAjaxTabPanel()
    {
        #region persoal Data TAB

        DataTable genderList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.GenderList);
        Utils.FillSelector(clientGenderDDL, genderList, "Name", "Code");

        DataTable civilStatList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.CivilStatus);
        Utils.FillSelector(clientCivilStatusDDL, civilStatList, "Name", "Code");

        DataTable studiiList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.StudyLevel);
        Utils.FillSelector(clientEducationLevelDDL, studiiList, "Name", "Code");

        DataTable socialStatList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.SocialStatus);
        Utils.FillSelector(clientSocialStatusDDL, socialStatList, "Name", "Code");

        DataTable conditiiLocative = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.SituatiaMateriala);
        Utils.FillSelector(situatiaMaterialaDDL, conditiiLocative, "Name", "Code");

        DataTable bisericiList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.Biserica);
        Utils.FillSelector(clientChurchDDL, bisericiList, "Name", "Code");

        DataTable clientCategoryForFilter = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.ClientCategories);
        Utils.FillSelector(clientCategoryForFilterDDL, clientCategoryForFilter, "Name", "Code");
        Utils.FillSelector(newClientCategoryDDL, clientCategoryForFilter, "Name", "Code");

        #endregion persoal Data TAB

        #region Bank

        DataTable bankList = Utils.ModuleAccounting().GetBankList();
        Utils.FillSelector(clientBankDDL, bankList, "Name", "BankID");

        #endregion Bank
        
        #region client address TAB

        DataTable countryList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.CountryList);
        Utils.FillSelector(vizaClientAddressCountryDDL, countryList, "Name", "Code");

        try
        {
            vizaClientAddressCountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
            vizaClientAddressCountryDDL.Enabled = false;
            FillVizaRaionDDDL();
        }
        catch
        { }

        Utils.FillSelector(rAddressClientCountryDDL, countryList, "Name", "Code");
        try
        {
            rAddressClientCountryDDL.SelectedValue = Constants.DefaultCountry.ToString();
            rAddressClientCountryDDL.Enabled = false;
            FillRealRaionDDDL();
        }
        catch
        { }

        #endregion client address TAB

        #region client bussines TAB

        DataTable sectorAfaceriList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.SectorAfaceri);
        Utils.FillSelector(clientBusinessSectorAfacereDDL, sectorAfaceriList, "Name", "Code");

        DataTable formeDeIntregistrare = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.FormaDeInregistrareItreprindere);
        Utils.FillSelector(clientBusinessFormaInregisrAfaceriiDDL, formeDeIntregistrare, "Name", "Code");

        #endregion client bussines TAB

        #region Consultari evaluari TAB

        DataTable operatorsLIst = Utils.ModuleCredits().GetOperatorsList();
        Utils.FillSelector(consultEvalOperDDL, operatorsLIst, "Operator Full Name", "OperatorID");

        DataTable tipConsultEval = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.TipEvaluareConsultare);
        Utils.FillSelector(tipConsultEvalDDL, tipConsultEval, "Name", "Code");

        DataTable stareaAfacerii = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.StareaAfacerii);
        Utils.FillSelector(consultEvalBussnesStateDDL, stareaAfacerii, "Name", "Code");

        #endregion Consultari evaluari TAB
    }

    #region ClientSelection Region

    protected void clientListGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (clientListGridView.SelectedRow != null)
        {
            GridViewRow row = clientListGridView.SelectedRow;

            int clientID = 0;
            int.TryParse(row.Cells[0].Text, out clientID);

            if (clientID > 0)
            {
                Credits.DataObjects.Client clientObject = Utils.ModuleCredits().GetCleintObjectByID(clientID);
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
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
        }
    }

    protected void newClientFotoUploadButton_Click(object sender, EventArgs e)
    {
        if (allowPersonalDataEdit)
        {
            HttpPostedFile file = newClientFotoFileUpload.PostedFile;
            if (file != null && file.ContentLength > 0)
            {
                Dictionary<string, string> versions = new Dictionary<string, string>();
                //Define the version to generate
                versions.Add("_thumb", "width=250&height=250&format=jpg&mode=max");

                string tempFolder = Utils.ModuleMain().TempFolder;

                ImageJob im = new ImageJob(file, tempFolder + "\\<guid>.<ext>", new ResizeSettings(versions["_thumb"]));
                im.CreateParentDirectory = true; //Auto-create the uploads directory.
                im.Build();

                string[] fullPath = im.FinalPath.Split('\\');

                string finalSmallFullFileName = string.Empty;
                if (fullPath != null && fullPath.Length > 1)
                {
                    finalSmallFullFileName = tempFolder + fullPath[fullPath.Length - 1];
                }

                newClientImage.ImageUrl = finalSmallFullFileName;
                newClientImageHiddenField.Value = finalSmallFullFileName;
            }

            newClientModalPopup.Show();
        }
        else
        {
            Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
        }
    }
    
    protected void newClientSaveButton_Click(object sender, EventArgs e)
    {
        try
        {
            if (allowPersonalDataEdit)
            { 
                Credits.DataObjects.Client clientObject = new Credits.DataObjects.Client();

                clientObject.FirstName = newClientNumeTextBox.Text;
                clientObject.LastName = newClientPrenumeTextBox.Text;
                clientObject.BirthDate = Crypt.Utils.ToDateTime(newClientBirthDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
                clientObject.TelefonFix = newClientTelefonFixTextBox.Text.Trim();
                clientObject.TelefonMobil = newClientTelefonMobilTextBox.Text.Trim();
                clientObject.TelefonMobil2 = newClientTelefonMobil2TextBox.Text.Trim();
                clientObject.Email = newClientEmailTextBox.Text.Trim();

                int category = 0;
                int.TryParse(newClientCategoryDDL.SelectedValue, out category);

                clientObject.SortGroup = category;

                int newClientID = 0;

                string temImageURL = newClientImageHiddenField.Value; 

                if (!Utils.ModuleCredits().CheckExistClient(clientObject.FirstName, clientObject.LastName, clientObject.BirthDate))
                {
                    if (Utils.ModuleCredits().AddNewClient(clientObject, out newClientID))
                    {
                        ClearNewClientForm();
                        clientObject.ClientID = newClientID;
                        this.ClientObject = clientObject;

                        if (!temImageURL.Equals(string.Empty))
                        {
                            string creditModuleFileDirectory = Utils.ModuleCredits().RootModuleFolder;
                            Utils.ModuleCredits().CheckClientPersonalFolders(clientObject, Server.MapPath(creditModuleFileDirectory));
                            string clientPersonalFolder = this.ClientObject.ClientPersonalFolder;

                            string[] fullPath = temImageURL.Split('/');

                            string finalSmallFullFileName = string.Empty;
                            if (fullPath != null && fullPath.Length > 1)
                            {
                                finalSmallFullFileName = clientPersonalFolder + "/" + fullPath[fullPath.Length - 1];
                            }

                            try
                            {
                                string tempFullPath = Server.MapPath(temImageURL);
                                string pathToCopy = Server.MapPath(creditModuleFileDirectory + "/" + finalSmallFullFileName);
                                System.IO.File.Move(tempFullPath, pathToCopy);
                              
                                clientObject.ImageURL = finalSmallFullFileName;
                                Utils.ModuleCredits().UpdateClient(clientObject);
                            }
                            catch { }
                        }

                        FillClientSelectionGrid();
                        FillClientAllForms(clientObject);
                    }
                    else
                    {
                        clientImage.ImageUrl = newClientImageHiddenField.Value;
                        generalInfoImage.ImageUrl = newClientImageHiddenField.Value;
                        newClientModalPopup.Show();
                        Utils.InfoText(this, "Atentie! Datele nu au fost salvate!", "Datele nu au fost salvate. " + Utils.ModuleCredits().LastError);
                    }
                }
                else
                {
                    clientImage.ImageUrl = newClientImageHiddenField.Value;
                    generalInfoImage.ImageUrl = newClientImageHiddenField.Value;
                    newClientModalPopup.Show();
                    Utils.InfoText(this, "Atentie! Datele nu au fost salvate!", "Astfel de client deja este in baza de date. Va rugam sa verificati intre clientii inregistrati.");
                }
            }
            else
            {
                Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
            }
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
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

    private void FillGenInfoForm(Credits.DataObjects.Client clientObject)
    {
        try
        {
            if (clientObject != null)
            {
                genInfoActivationDateLabel.Text = clientObject.ActivationDate.ToString(Constants.ISODateBackwardDotsFormat);
                genInfoMobileNumberLabel.Text = clientObject.TelefonMobil;
                genInfoManagerCreditareLabel.Text = clientObject.LastManager;
                genInfoTotalLoansNumberLabel.Text = clientObject.TotalLoansNumber.ToString();
                genInfoLastLoanAmountLabel.Text = clientObject.LastLoanAmount.ToString();
                genInfoActiveLoansLabel.Text = clientObject.ActiveLoans.ToString();
                genInfoTotalSavingsLabel.Text = clientObject.TotalProfits.ToString();
                genInfoActiveSavingsLabel.Text = clientObject.ActiveProfits.ToString();
            }
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
        }
    }

    #endregion GeneralInfo Form

    #region Main Personal data panel

    protected void personalPhotoUploadButton_Click(object sender, EventArgs e)
    {
        if (allowPersonalDataEdit && this.ClientObject != null)
        {
            HttpPostedFile file = personalPhotoFileUpload.PostedFile;

            if (file != null && file.ContentLength > 0 && this.ClientObject != null && !this.ClientObject.ClientPersonalFolder.Equals(string.Empty))
            {
                Dictionary<string, string> versions = new Dictionary<string, string>();
                //Define the version to generate
                versions.Add("_thumb", "width=250&height=250&format=jpg&mode=max");

                string creditModuleFileDirectory = Utils.ModuleCredits().RootModuleFolder;
                string clientPersonalFolder = this.ClientObject.ClientPersonalFolder;

                ImageJob im = new ImageJob(file, creditModuleFileDirectory + "\\" + clientPersonalFolder + "\\<guid>.<ext>", new ResizeSettings(versions["_thumb"]));
                im.CreateParentDirectory = true; //Auto-create the uploads directory.
                im.Build();

                string[] fullPath = im.FinalPath.Split('\\');

                string finalSmallFullFileName = string.Empty;
                if (fullPath != null && fullPath.Length > 1)
                {
                    finalSmallFullFileName = clientPersonalFolder + "/" + fullPath[fullPath.Length - 1];
                }

                string oldImageURL = clientImage.ImageUrl;

                try
                {
                    System.IO.File.Delete(Server.MapPath(creditModuleFileDirectory + "/" + oldImageURL)); 
                }
                catch { }

                clientImage.ImageUrl = creditModuleFileDirectory + "/" + finalSmallFullFileName;
                generalInfoImage.ImageUrl = creditModuleFileDirectory + "/" + finalSmallFullFileName;
                this.ClientObject.ImageURL = finalSmallFullFileName;
                Utils.ModuleCredits().UpdateClient(ClientObject);
            }
        }
        else
        {
            Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
        }
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

    private void FillMainEditFormInformationTab(Credits.DataObjects.Client clientObject)
    {
        try
        {
            if (clientObject != null)
            {
                //// Main finfo  
                clientImage.ImageUrl = Utils.ModuleCredits().RootModuleFolder + "/" + clientObject.ImageURL;
                generalInfoImage.ImageUrl = Utils.ModuleCredits().RootModuleFolder + "/" + clientObject.ImageURL;
                clientNumeTextBox.Text = clientObject.FirstName;
                clientPrenumeTextBox.Text = clientObject.LastName;
                clientDateOfBirthTextBox.Text = clientObject.BirthDate.ToString(Constants.ISODateBackwardDotsFormat);
                clientPlaseOfBirthTextBox.Text = clientObject.PlaceOfBirth;
                addNewClientTelefonFixTextBox.Text = clientObject.TelefonFix;
                addNewClientTelefonMobilTextBox.Text = clientObject.TelefonMobil;
                addNewClientTelefonMobil2TextBox.Text = clientObject.TelefonMobil2;
                addNewClientEmailTextBox.Text = clientObject.Email;
                try { clientCategoryForFilterDDL.SelectedValue = clientObject.SortGroup.ToString(); }
                catch { }
            }
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
        }
    }

    #endregion Main Personal data panel

    #region Loans

    private void FillLoansGridView(int clientID)
    {
        int loanState = activInactivloansHiddenField.Value.ToLower().Equals("active") ? (int)Constants.Classifiers.CreditState_Activ : (int)Constants.Classifiers.CreditState_Achitat ;

        DataTable loanss = Utils.ModuleCredits().GetLoansList(loanState, clientID);

        if (loanss != null)
        {
            loansGridView.DataSource = loanss;
            loansGridView.DataBind();
        }
    }

    protected void loansGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        loansGridView.PageIndex = e.NewPageIndex;

        int clientID = this.ClientObject.ClientID;
        FillLoansGridView(clientID);
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
        int clientID = this.ClientObject.ClientID;
        FillLoansGridView(clientID);
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

        int clientID = this.ClientObject.ClientID;
        FillLoansGridView(clientID);
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
        husbandDescriptionTextbox.Text = string.Empty;
        personalDataClientCildrensTextBox.Text = string.Empty;
        nrPersoaneInIntretinereTextbox.Text = string.Empty;
        personalDataClientVenitLunarInceputTextBox.Text = string.Empty;
        slujireaInBisericaTextBox.Text = string.Empty;
        pastorLiderTextBox.Text = string.Empty;
        telefonPastorTextBox.Text = string.Empty;

        try { clientChurchDDL.SelectedIndex = 0; }
        catch { }

        try { situatiaMaterialaDDL.SelectedIndex = 0; }
        catch { }

        try { clientGenderDDL.SelectedIndex = 0; }
        catch { }

        try { clientCivilStatusDDL.SelectedIndex = 0; }
        catch { }

        try { clientEducationLevelDDL.SelectedIndex = 0; }
        catch { }

        try { clientSocialStatusDDL.SelectedIndex = 0; }
        catch { }

        husbandClientSelectionControl.SelectedClientID = 0;
    }
    
    private void FillPersonalInformationTab(Credits.DataObjects.Client clientObject)
    {
        try
        {
            if (clientObject != null)
            {           
                ////// personal info form
                clientPersonalIDTextBox.Text = clientObject.PersonalID;
                buletinSeriaTextBox.Text = clientObject.BuletinSeria;
                eliberatDeTextBox.Text = clientObject.BuletinEliberatDe;
                dataEliberariiTextBox.Text = clientObject.DataEliberariiBuletin != DateTime.MinValue ? clientObject.DataEliberariiBuletin.ToString("dd.M.yyyy") : string.Empty;
                dataExpirariiTextBox.Text = clientObject.DataExpirariiBuletin != DateTime.MinValue ? clientObject.DataExpirariiBuletin.ToString("dd.M.yyyy") : string.Empty;
                
                SetLabelsOnPersonsGenderSelect(clientObject.Gender);                
                husbandDescriptionTextbox.Text = clientObject.HusbandFullName;
                husbandClientSelectionControl.SelectedClientID = clientObject.HusbandID;
                personalDataClientCildrensTextBox.Text = clientObject.NumberOfChildren.ToString();
                nrPersoaneInIntretinereTextbox.Text = clientObject.NrPersoaneIntretinere.ToString();
                personalDataClientVenitLunarInceputTextBox.Text = clientObject.VenitFamInceputAfacere.ToString();
                slujireaInBisericaTextBox.Text = clientObject.SlujireInBiserica;
                pastorLiderTextBox.Text = clientObject.PastorLider;
                telefonPastorTextBox.Text = clientObject.TelefonPastor;

                try { clientGenderDDL.SelectedValue = clientObject.Gender.ToString(); } catch { }
                try { clientCivilStatusDDL.SelectedValue = clientObject.CivilStatus.ToString(); } catch { }
                try { clientEducationLevelDDL.SelectedValue = clientObject.StudyLevel.ToString(); } catch { }
                try { clientSocialStatusDDL.SelectedValue = clientObject.SocialStatus.ToString(); } catch { }
                try { situatiaMaterialaDDL.SelectedValue = clientObject.SituatiaMateriala.ToString(); }  catch { }
                try { clientChurchDDL.SelectedValue = clientObject.Church.ToString(); } catch { }
            }
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
        }
    }
    
    protected void clientGenderDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        int slectedGender = 0;
        int.TryParse(clientGenderDDL.SelectedValue, out slectedGender);

        SetLabelsOnPersonsGenderSelect(slectedGender);
    }

    private void SetLabelsOnPersonsGenderSelect(int genderType)
    {
        if (genderType == (int)Constants.Classifiers.Persoana_Juridica)
        {
            husbendLabel.Text = "Administrator:";
            personalNumebrLabel.Text = "Cod Fiscal:";
            buletinSeriaLabel.Text = "Certificat de inreg.";
            numeleLabel.Text = "Denumirea Organiz.:";
            dataNastereLabel.Text = "Data inregistraii:";

            civilStatusDt.Visible = false;
            civilStatusDD.Visible = false;
            clientCivilStatusDDL.SelectedIndex = 0;

            childrenDt.Visible = false;
            childrenDD.Visible = false;
            prenumeleDT.Visible = false;
            prenumeleDD.Visible = false;
            plaseOfBirthDT.Visible = false;
            plaseOfBirthDD.Visible = false;
        }
        else
        {
            husbendLabel.Text = "Sotia/Sotul:";
            personalNumebrLabel.Text = "Cod Personal:";
            buletinSeriaLabel.Text = "Buletin Seria:";
            numeleLabel.Text = "Numele:";
            dataNastereLabel.Text = "Data Nasterii:";

            civilStatusDt.Visible = true;
            civilStatusDD.Visible = true;

            childrenDt.Visible = true;
            childrenDD.Visible = true;
            prenumeleDT.Visible = true;
            prenumeleDD.Visible = true;
            plaseOfBirthDT.Visible = true;
            plaseOfBirthDD.Visible = true;
        }
    }

    protected void husbendShowButton_Click(object sender, EventArgs e)
    {
        husbandClientSelectionControl.Show();
    }

    protected void husbandClientSelectionControl_OnClientSelected(object sender, ClientSelectionControl.FilterWindowEventsArg e)
    {
        if (e.SelectedItem != 0)
        {
            husbandDescriptionTextbox.Text = husbandClientSelectionControl.ClientFirstLastName + " : " + husbandClientSelectionControl.SelectedClientBirthDate.ToString(Constants.ISODateBackwardDotsFormat);
        }
    }

    protected void clientPersonalDataSaveButton_Click(object sender, EventArgs e)
    {
        if (allowPersonalDataEdit)
        {
            try
            {
                Credits.DataObjects.Client clientObject = null;
                if (this.ClientObject != null)
                {
                    clientObject = this.ClientObject;
                }

                if (clientObject != null)
                {
                    //////  general info  
                    clientObject.FirstName = clientNumeTextBox.Text.Trim();
                    clientObject.LastName = clientPrenumeTextBox.Text.Trim();
                    clientObject.BirthDate = Crypt.Utils.ToDateTime(clientDateOfBirthTextBox.Text, Constants.ISODateBackwardDotsFormat);
                    clientObject.PlaceOfBirth = clientPlaseOfBirthTextBox.Text.Trim();
                    clientObject.TelefonFix = addNewClientTelefonFixTextBox.Text.Trim();
                    clientObject.TelefonMobil = addNewClientTelefonMobilTextBox.Text.Trim();
                    clientObject.TelefonMobil2 = addNewClientTelefonMobil2TextBox.Text.Trim();
                    clientObject.Email = addNewClientEmailTextBox.Text.Trim();

                    int Category = 0;
                    int.TryParse(clientCategoryForFilterDDL.SelectedValue, out Category);
                    clientObject.SortGroup = Category;
                    clientObject.SortGroup_String = clientCategoryForFilterDDL.SelectedItem.Text;

                    //////// personal info form
                    clientObject.PersonalID = clientPersonalIDTextBox.Text.Trim();
                    clientObject.BuletinSeria = buletinSeriaTextBox.Text.Trim();
                    clientObject.BuletinEliberatDe = eliberatDeTextBox.Text.Trim();
                    clientObject.DataEliberariiBuletin = Crypt.Utils.ToDateTime(dataEliberariiTextBox.Text, Constants.ISODateBackwardDotsFormat);
                    clientObject.DataExpirariiBuletin = Crypt.Utils.ToDateTime(dataExpirariiTextBox.Text, Constants.ISODateBackwardDotsFormat);

                    int gender = 0;
                    int.TryParse(clientGenderDDL.SelectedValue, out gender);
                    clientObject.Gender = gender;
                    clientObject.Gender_String = clientGenderDDL.SelectedItem.Text;

                    int sivilStatus = 0;
                    int.TryParse(clientCivilStatusDDL.SelectedValue, out sivilStatus);
                    clientObject.CivilStatus = sivilStatus;
                    clientObject.CivilStatus_String = clientCivilStatusDDL.SelectedItem.Text;

                    clientObject.HusbandID = husbandClientSelectionControl.SelectedClientID;
                    clientObject.HusbandFullName = husbandDescriptionTextbox.Text;

                    int numberOfCildren = 0;
                    int.TryParse(personalDataClientCildrensTextBox.Text, out numberOfCildren);
                    clientObject.NumberOfChildren = numberOfCildren;

                    int NrPersoaneIntretinere = 0;
                    int.TryParse(nrPersoaneInIntretinereTextbox.Text, out NrPersoaneIntretinere);
                    clientObject.NrPersoaneIntretinere = NrPersoaneIntretinere;

                    int StudyLevel = 0;
                    int.TryParse(clientEducationLevelDDL.SelectedValue, out StudyLevel);
                    clientObject.StudyLevel = StudyLevel;
                    clientObject.StudyLevel_String = clientEducationLevelDDL.SelectedItem.Text;

                    int SocialStatus = 0;
                    int.TryParse(clientSocialStatusDDL.SelectedValue, out SocialStatus);
                    clientObject.SocialStatus = SocialStatus;
                    clientObject.SocialStatus_String = clientSocialStatusDDL.SelectedItem.Text;

                    int VenitFamInceputAfacere = 0;
                    int.TryParse(personalDataClientVenitLunarInceputTextBox.Text, out VenitFamInceputAfacere);
                    clientObject.VenitFamInceputAfacere = VenitFamInceputAfacere;

                    int SituatiaMateriala = 0;
                    int.TryParse(situatiaMaterialaDDL.SelectedValue, out SituatiaMateriala);
                    clientObject.SituatiaMateriala = SituatiaMateriala;
                    clientObject.SituatiaMateriala_String = situatiaMaterialaDDL.SelectedItem.Text;

                    int Church = 0;
                    int.TryParse(clientChurchDDL.SelectedValue, out Church);
                    clientObject.Church = Church;
                    clientObject.Church_String = clientChurchDDL.SelectedItem.Text;

                    clientObject.SlujireInBiserica = slujireaInBisericaTextBox.Text.Trim();
                    clientObject.PastorLider = pastorLiderTextBox.Text.Trim();
                    clientObject.TelefonPastor = telefonPastorTextBox.Text.Trim();


                    ////////   address form
                    clientObject.Viza_Localitatea = vizaClientAddressLocalitateaTextBox.Text.Trim();
                    clientObject.Viza_StradaAdresa = vizaClientAddressAdresaTextBox.Text.Trim();
                    clientObject.Raddress_Localitatea = rAddressClientLocalitateaTextBox.Text.Trim();
                    clientObject.Raddress_StradaAdresa = rAddressAddresaStradaTextBox.Text.Trim();

                    clientObject.Viza_UrbanRural = vizaUrbanRuralDDL.SelectedValue;
                    clientObject.Raddress_UrbanRural = rAddressUrbanRuralDDL.SelectedValue;

                    int Viza_Country = 0;
                    int.TryParse(vizaClientAddressCountryDDL.SelectedValue, out Viza_Country);
                    clientObject.Viza_Country = Viza_Country;
                    clientObject.Viza_Country_String = vizaClientAddressCountryDDL.SelectedItem.Text;

                    int Viza_Raion = 0;
                    int.TryParse(vizaClientAddressClientRaionDDL.SelectedValue, out Viza_Raion);
                    clientObject.Viza_Raion = Viza_Raion;
                    clientObject.Viza_Raion_String = vizaClientAddressClientRaionDDL.SelectedItem.Text;

                    int Raddress_Country = 0;
                    int.TryParse(rAddressClientCountryDDL.SelectedValue, out Raddress_Country);
                    clientObject.Raddress_Country = Raddress_Country;
                    clientObject.Raddress_Country_String = rAddressClientCountryDDL.SelectedItem.Text;

                    int Raddress_Raion = 0;
                    int.TryParse(rAddressClientRaionDDL.SelectedValue, out Raddress_Raion);
                    clientObject.Raddress_Raion = Raddress_Raion;
                    clientObject.Raddress_Raion_String = rAddressClientRaionDDL.SelectedItem.Text;


                    /////////  bank fomr   
                    int bankID = 0;
                    if (clientBankDDL.SelectedValue != null) int.TryParse(clientBankDDL.SelectedValue, out bankID);
                    clientObject.Bank_id = bankID;

                    clientObject.Bank_IBAN = clientBankIBANTextBox.Text.Trim();
                    clientObject.BankName = clientBankDDL.SelectedItem.Text;
                    clientObject.ContBancar = clientBankContBancarTextBox.Text.Trim();

                    string moduleFolder = Utils.ModuleCredits().RootModuleFolder;
                    int newClientID = 0;

                    if (clientObject.ClientID != 0 && Utils.ModuleCredits().UpdateClient(clientObject))
                    {
                        addNewCreditButton.Attributes.Add("onclick", "window.open('Credits.aspx?cd=n&clid=" + newClientID + "', '_blank' );");

                        this.ClientObject = clientObject;
                        FillClientSelectionGrid();
                        husbandClientSelectionControl.BindDataSource();
                        Utils.InfoText(this, "Success!", "Datele au fost salvate.");
                    }
                    else
                    {
                        Utils.InfoText(this, "Atentie", " { " + clientObject.FirstName + " " + clientObject.LastName + " } - nu a fost salvat.");
                    }      
                }
            }
            catch (Exception ex)
            { Utils.InfoText(this, "Eroare in System!", ex.Message.ToString()); }
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    protected void clientPersonalDataCancelButton_Click(object sender, EventArgs e)
    {
        FillClientAllForms(this.ClientObject);
    }

    protected void clientPersonalFolderButton_Click(object sender, EventArgs e)
    {
        try
        {
            Credits.DataObjects.Client clientObject = this.ClientObject;

            if (clientObject != null && clientObject.ClientID != 0)
            {
                Utils.ModuleCredits().CheckClientPersonalFolders(clientObject, Server.MapPath(Utils.ModuleCredits().RootModuleFolder));
                personalFileBrowser.TitleWindow = "Mapa Personala pentru: " + clientObject.FirstName + " " + clientObject.LastName;
                personalFileBrowser.RootDirectory = Utils.ModuleCredits().RootModuleFolder + "/" + clientObject.ClientPersonalFolder + "/" + "PersonalDocuments";
                personalFileBrowser.Show();
            }
        }
        catch
        { }
    }

    protected void addNewCreditButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("Credits.aspx?cd=n");
    }

    #endregion Personal Data Region

    #region Bankregion

    private void ClearClientBankForm()
    {
        try
        {
            clientBankDDL.SelectedIndex = 0;
        }
        catch { }

        clientBankIBANTextBox.Text = string.Empty;
        clientBankContBancarTextBox.Text = string.Empty;
    }


    private void FillClientBankInformationTab(Credits.DataObjects.Client clientObject)
    {
        try
        {
            if (clientObject != null)
            {
                try
                {
                    clientBankDDL.SelectedValue = clientObject.Bank_id.ToString();
                }
                catch{}

                clientBankIBANTextBox.Text = clientObject.Bank_IBAN;
                clientBankContBancarTextBox.Text = clientObject.ContBancar;
            }
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
        }
    }

    protected void clientBankDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        int bankID = 0;
        int.TryParse(clientBankDDL.SelectedValue, out bankID);

        clientBankIBANTextBox.Text = Utils.ModuleAccounting().GetBankIBAN_ByBankID(bankID);
    }

    #endregion Bankregion

    #region Addreses Region

    protected void ClearAddressesForms()
    {
        vizaClientAddressLocalitateaTextBox.Text = string.Empty;
        vizaClientAddressAdresaTextBox.Text = string.Empty;
        rAddressClientLocalitateaTextBox.Text = string.Empty;
        rAddressAddresaStradaTextBox.Text = string.Empty;

        try { vizaUrbanRuralDDL.SelectedIndex = 0; }
        catch { }
        try { rAddressUrbanRuralDDL.SelectedIndex = 0; }
        catch { }

        try { vizaClientAddressCountryDDL.SelectedIndex = 0; }
        catch { }
        FillVizaRaionDDDL();

        try { vizaClientAddressClientRaionDDL.SelectedIndex = 0; }
        catch { }

        try { rAddressClientCountryDDL.SelectedIndex = 0; }
        catch { }
        FillRealRaionDDDL();

        try { rAddressClientRaionDDL.SelectedIndex = 0; }
        catch { }      
    }

    private void FillClientAddressInformationTab(Credits.DataObjects.Client clientObject)
    {
        try
        {
            if (clientObject != null)
            {
                //////   address form
                vizaClientAddressLocalitateaTextBox.Text = clientObject.Viza_Localitatea;
                vizaClientAddressAdresaTextBox.Text = clientObject.Viza_StradaAdresa;
                rAddressClientLocalitateaTextBox.Text = clientObject.Raddress_Localitatea;
                rAddressAddresaStradaTextBox.Text = clientObject.Raddress_StradaAdresa;

                try { vizaUrbanRuralDDL.SelectedValue = clientObject.Viza_UrbanRural; }
                catch { }
                try { rAddressUrbanRuralDDL.SelectedValue = clientObject.Raddress_UrbanRural; }
                catch { }

                try { vizaClientAddressCountryDDL.SelectedValue = clientObject.Viza_Country != 0 ? clientObject.Viza_Country.ToString() : Constants.DefaultCountry.ToString(); }
                catch { }
                FillVizaRaionDDDL();

                try { vizaClientAddressClientRaionDDL.SelectedValue = clientObject.Viza_Raion.ToString(); }
                catch { }

                try { rAddressClientCountryDDL.SelectedValue = clientObject.Raddress_Country != 0 ? clientObject.Raddress_Country.ToString() : Constants.DefaultCountry.ToString(); }
                catch { }
                FillRealRaionDDDL();

                try { rAddressClientRaionDDL.SelectedValue = clientObject.Raddress_Raion.ToString(); }
                catch { }
            }
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Atentie! Eroare in sistem!", ex.Message);
        }
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

    private void FillRealRaionDDDL()
    {
        if (rAddressClientCountryDDL.SelectedValue != null && !rAddressClientCountryDDL.SelectedValue.ToString().Equals(string.Empty))
        {
            int countruCOde = 0;
            int.TryParse(rAddressClientCountryDDL.SelectedValue.ToString(), out countruCOde);

            DataTable b_provinceList = Utils.ModuleMain().GetProvinceListByCountry(countruCOde);
            Utils.FillSelector(rAddressClientRaionDDL, b_provinceList, "Name", "Code");
        }
    }
    
    protected void rAddressClientCountryDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillRealRaionDDDL();
    }

    protected void vizaClientCountryDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillVizaRaionDDDL();
    }

    protected void copyInfoFromVizaAddress_Click(object sender, EventArgs e)
    {
        try
        {
            rAddressClientLocalitateaTextBox.Text = vizaClientAddressLocalitateaTextBox.Text;
            rAddressAddresaStradaTextBox.Text = vizaClientAddressAdresaTextBox.Text;
            rAddressClientCountryDDL.SelectedValue = vizaClientAddressCountryDDL.SelectedValue;
            rAddressClientRaionDDL.SelectedValue = vizaClientAddressClientRaionDDL.SelectedValue;
            rAddressUrbanRuralDDL.SelectedValue = vizaUrbanRuralDDL.SelectedValue;
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Erroare in Sistem!", ex.Message);
        }
    }


    #endregion Addreses Region

    #region Bussiness Region 

    private void ClearClientBussinesTab()
    {
        clientBusinessDexcriereActivitateTextbox.Text = string.Empty;
        clientBusinessAniExperientaInDomeniuTextBox.Text = string.Empty;
        clientBusinessAniExperientaInAfaceriTextBox.Text = string.Empty;
        tipAfacereTextBox.Text = string.Empty;
        clientBusinessSectorAfacereDDL.SelectedIndex = -1;

        bussinesStartDateTextBox.Text = string.Empty;

        clientBusinessFormaInregisrAfaceriiDDL.SelectedIndex = -1;

        clientBussinesSuprafataTerenAgricolTextBox.Text = string.Empty;
        clientBussinesCladiriComTextBox.Text = string.Empty;
        clientBussinesAnimaleTextBox.Text = string.Empty;
        clientBussinesvehicoleComercialeTextBox.Text = string.Empty;
        clientBussinesNrAngajatiTextBox.Text = string.Empty;
        clientBussinesDatoriiTextBox.Text = string.Empty;
    }

    protected void FillClientBussinesTab(int clientID)
    {
        try
        {
            DataTable bussinesInfo = Utils.ModuleCredits().GetBussinesByClientID(clientID);

            if (bussinesInfo != null && bussinesInfo.Rows.Count == 1)
            {
                clientBusinessDexcriereActivitateTextbox.Text = bussinesInfo.Rows[0]["descriereActivitate"].ToString();
                clientBusinessAniExperientaInDomeniuTextBox.Text = bussinesInfo.Rows[0]["aniExperientaInDomeniu"].ToString();
                clientBusinessAniExperientaInAfaceriTextBox.Text = bussinesInfo.Rows[0]["aniTotalExperientaAfaceri"].ToString();
                tipAfacereTextBox.Text = bussinesInfo.Rows[0]["tipafacere"].ToString();
                //clientInfoTipAfacsreTextBox.Text = bussinesInfo.Rows[0]["tipafacere"].ToString();

                if (!bussinesInfo.Rows[0]["sector_afacere"].ToString().Equals(string.Empty))
                {
                    clientBusinessSectorAfacereDDL.SelectedValue = bussinesInfo.Rows[0]["sector_afacere"].ToString();
                    //clientInfoDomeniuEconomicAfacereTextBox.Text = clientBusinessSectorAfacereDDL.SelectedItem.Text;
                }

                clientBusinessDexcriereActivitateTextbox.Text = bussinesInfo.Rows[0]["descriereActivitate"].ToString();

                if (!bussinesInfo.Rows[0]["bussinessStartDate"].ToString().Equals(string.Empty))
                {
                    bussinesStartDateTextBox.Text = ((DateTime)bussinesInfo.Rows[0]["bussinessStartDate"]).ToString(Constants.ISODateBackwardDotsFormat);
                }

                if (!bussinesInfo.Rows[0]["formaInregistrareAfacere"].ToString().Equals(string.Empty))
                {
                    clientBusinessFormaInregisrAfaceriiDDL.SelectedValue = bussinesInfo.Rows[0]["formaInregistrareAfacere"].ToString();
                }

                clientBussinesSuprafataTerenAgricolTextBox.Text = bussinesInfo.Rows[0]["suprafataTerenAgricol"].ToString();

                clientBussinesCladiriComTextBox.Text = bussinesInfo.Rows[0]["claridiComerciale"].ToString();
                clientBussinesAnimaleTextBox.Text = bussinesInfo.Rows[0]["animale"].ToString();
                clientBussinesvehicoleComercialeTextBox.Text = bussinesInfo.Rows[0]["vehicoleComerciale"].ToString();
                clientBussinesNrAngajatiTextBox.Text = bussinesInfo.Rows[0]["nrAngajati"].ToString();
                clientBussinesDatoriiTextBox.Text = bussinesInfo.Rows[0]["datorii"].ToString();
            }
        }
        catch (Exception ex)
        {
            Utils.InfoText(this, "Eroare in System!", ex.Message.ToString());
        }
    }

    protected void clientBusinessSaveButton_Click(object sender, EventArgs e)
    {
        if (allowPersonalDataEdit)
        {
            int clientID = this.ClientObject.ClientID;

            int sectorAfaceri = 0;
            int.TryParse(clientBusinessSectorAfacereDDL.SelectedValue.ToString(), out sectorAfaceri);

            int formaInregistrare = 0;
            int.TryParse(clientBusinessFormaInregisrAfaceriiDDL.SelectedValue.ToString(), out formaInregistrare);

            string descriereActivitate = clientBusinessDexcriereActivitateTextbox.Text.Trim();

            int aniExperientaInDomeniu = 0;
            int.TryParse(clientBusinessAniExperientaInDomeniuTextBox.Text, out aniExperientaInDomeniu);

            int aniTotalExperientaInAfacere = 0;
            int.TryParse(clientBusinessAniExperientaInAfaceriTextBox.Text, out aniTotalExperientaInAfacere);

            string tipAfacere = tipAfacereTextBox.Text.Trim();

            DateTime bussnessStartDate = Crypt.Utils.ToDateTime(bussinesStartDateTextBox.Text, Constants.ISODateBackwardDotsFormat);

            string suprafataTerenAgricol = clientBussinesSuprafataTerenAgricolTextBox.Text.Trim();

            int cladiriComerciale = 0;
            int.TryParse(clientBussinesCladiriComTextBox.Text, out cladiriComerciale);

            int animale = 0;
            int.TryParse(clientBussinesAnimaleTextBox.Text, out animale);

            int vehicoleComerciale = 0;
            int.TryParse(clientBussinesvehicoleComercialeTextBox.Text, out vehicoleComerciale);

            int nrAngajati = 0;
            int.TryParse(clientBussinesNrAngajatiTextBox.Text, out nrAngajati);

            int datorii = 0;
            int.TryParse(clientBussinesDatoriiTextBox.Text, out datorii);

            if (Utils.ModuleCredits().UpdateClientBussines(clientID, sectorAfaceri, descriereActivitate, formaInregistrare, aniExperientaInDomeniu, aniTotalExperientaInAfacere, bussnessStartDate, suprafataTerenAgricol, cladiriComerciale, animale, vehicoleComerciale, nrAngajati, datorii, tipAfacere))
            {
                Utils.InfoText(this, "Success!", "Datele au fost salvate.");
                //clientInfoDomeniuEconomicAfacereTextBox.Text = clientBusinessSectorAfacereDDL.SelectedItem.Text;
                //clientInfoTipAfacsreTextBox.Text = tipAfacereTextBox.Text;
            }
            else
            {
                Utils.InfoText(this, "Atentie", "Datele nu au fost salvate. Verificati corectitudinea datelor introduse sau verificati conectiunea cu internet");
            }
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }
    
    protected void clientBusinessCancelButton_Click(object sender, EventArgs e)
    {
        ClearClientBussinesTab();
        FillClientBussinesTab(this.ClientObject.ClientID);
    }

    #endregion Bussiness Region 

    #region Personal Trainings

    private void FillpersonalTrainigsGridView(int clientID)
    {
        DataTable trainingList = Utils.ModuleCredits().GetTrainingsListByClientID(clientID);

        if (trainingList != null)
        {
            personalTrainigsGridView.DataSource = trainingList;
            personalTrainigsGridView.DataBind();
        }
    }

    protected void personalTrainigsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

            for (int i = 0; i < e.Row.Cells.Count - 2; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.personalTrainigsGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }

    protected void personalTrainigsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        personalTrainigsGridView.PageIndex = e.NewPageIndex;

        int clientID = this.ClientObject.ClientID;
        FillpersonalTrainigsGridView(clientID);
    }

    protected void addPersonalTrainiButton_Click(object sender, EventArgs e)
    {
        if (allowPersonalDataEdit)
        {
            addPersonalTrainingPanel.Visible = true;

            int trainingid = 0;
            DataTable trainingList = Utils.ModuleCredits().GetTrainingList(trainingid);
            Utils.FillSelector(addPersonalTrainingListDDL, trainingList, "Trainig Full Description", "trainingID");
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    protected void addPersonalTrainingSaveButton_Click(object sender, EventArgs e)
    {
        if (allowPersonalDataEdit)
        {
            int trainingID = 0;
            int.TryParse(addPersonalTrainingListDDL.SelectedValue, out trainingID);

            int clientID = this.ClientObject.ClientID;

            if (trainingID != 0 && clientID != 0 && Utils.ModuleCredits().AddOneClientToTraining(trainingID, clientID))
            {
                addPersonalTrainingPanel.Visible = false;
                FillpersonalTrainigsGridView(clientID);
            }
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    protected void personalTrainigsGridView_Deleting(object sender, GridViewDeleteEventArgs e)
    {
        if (allowPersonalDataEdit)
        {
            int index = e.RowIndex;
            int trainingID = 0;
            int.TryParse(personalTrainigsGridView.Rows[index].Cells[0].Text, out trainingID);

            int clientID = this.ClientObject.ClientID;

            if (trainingID != 0 && clientID != 0 && Utils.ModuleCredits().DeleteOneClientFromTraining(trainingID, clientID))
            {
                FillpersonalTrainigsGridView(clientID);
            }
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    protected void personalTrainigsGridView_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        int index = e.NewSelectedIndex;

        Label idataLabel = (Label)personalTrainigsGridView.Rows[index].Cells[2].FindControl("trainingDateLabel");
        if (idataLabel != null)
            dataLabel.Text = idataLabel.Text;

        operatorLabel.Text = string.Empty;

        tipInstruireLabel.Text = personalTrainigsGridView.Rows[index].Cells[3].Text;
        denumireaLabel.Text = personalTrainigsGridView.Rows[index].Cells[1].Text;
        scopLabel.Text = personalTrainigsGridView.Rows[index].Cells[4].Text;
        descriereLabel.Text = personalTrainigsGridView.Rows[index].Cells[5].Text;

        int trainingID = 0;
        int.TryParse(personalTrainigsGridView.Rows[index].Cells[0].Text, out trainingID);

        if (trainingID != 0)
        {
            DataTable operatorsList = Utils.ModuleCredits().GetTrainingOperatorsListByTrainingID(trainingID);
            if (operatorsList != null && operatorsList.Rows.Count > 0)
            {
                operatorLabel.Text = operatorsList.Rows[0]["Operator Full Name"].ToString();
            }
        }
    }

    #endregion Personal Trainings

    #region Consult Eval

    protected void addNewConsultEvalButton_Click(object sender, EventArgs e)
    {
        if (allowContragentEditConsultEval)
        {
            ClearConsultEvalForm();
            consultEvalGridView.SelectedIndex = -1;
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    protected void editConsultCancelButton_Click(object sender, EventArgs e)
    {
        ClearConsultEvalForm();
        FillConsultEvalGridView(this.ClientObject.ClientID);
    }

    private void ClearConsultEvalForm()
    {
        this.IsNewConsultEval = true;
        this.CurrentConsultEval = 0;

        editDataTextBox.Text = string.Empty;
        consultEvalOperDDL.SelectedIndex = -1;
        tipConsultEvalDDL.SelectedIndex = -1;
        editConsultDescriptionTextBox.Text = string.Empty;
        consultEvalBussnesStateDDL.SelectedIndex = -1;
        editNrEmplTextBox.Text = string.Empty;
        editAverajeMonthlyIncomeTextBox.Text = string.Empty;
        editShortDescriptionStateTextBox.Text = string.Empty;
        editConsultPfotoContainer.InnerHtml = string.Empty;

        if (ViewState[Constants.SessionPhotoTable.ConsultEvalPhotoFiles] != null)
        {
            DataTable filesTable = (DataTable)ViewState[Constants.SessionPhotoTable.ConsultEvalPhotoFiles];
            
            if (filesTable != null)
            {
                filesTable.Rows.Clear();
                filesTable.AcceptChanges();
                ViewState[Constants.SessionPhotoTable.ConsultEvalPhotoFiles] = filesTable;
            }
        }
    }

    protected void FillConsultEvalGridView(int clientID)
    {
        DataTable consultList = Utils.ModuleCredits().GetAllConsultsForClient(clientID);

        consultEvalGridView.DataSource = consultList;
        consultEvalGridView.DataBind();
    }

    protected void consultEvalGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

            for (int i = 0; i < e.Row.Cells.Count - 1; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.consultEvalGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }

    protected void consultEvalGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearConsultEvalForm();

        if (consultEvalGridView.SelectedRow != null)
        {
            GridViewRow row = consultEvalGridView.SelectedRow;

            int clevID = 0;
            int.TryParse(row.Cells[0].Text, out clevID);

            if (clevID != 0)
            {
                this.CurrentConsultEval = clevID;
                this.IsNewConsultEval = false;

                DataTable clevTable = Utils.ModuleCredits().GetVisitsConsultById(clevID);

                if (clevTable != null && clevTable.Rows.Count == 1)
                {
                    try
                    {
                        editDataTextBox.Text = ((DateTime)clevTable.Rows[0]["data"]).ToString(Constants.ISODateBackwardDotsFormat);
                        editConsultDescriptionTextBox.Text = clevTable.Rows[0]["ConsultDescription"].ToString();
                        editNrEmplTextBox.Text = clevTable.Rows[0]["employeesCount"].ToString();
                        editAverajeMonthlyIncomeTextBox.Text = clevTable.Rows[0]["AverageMonthlyIncome"].ToString();
                        editShortDescriptionStateTextBox.Text = clevTable.Rows[0]["shortDescription"].ToString();

                        consultEvalBussnesStateDDL.SelectedValue = clevTable.Rows[0]["BusinessState"].ToString();
                        consultEvalOperDDL.SelectedValue = clevTable.Rows[0]["OperatorID"].ToString();
                        tipConsultEvalDDL.SelectedValue = clevTable.Rows[0]["TipConsultEval"].ToString();

                        DataTable pfotoLinks = Utils.ModuleCredits().GetVisitsConsultPhotoByClevId(clevID);
                        pfotoLinks.Columns.Add(Constants.ConsultEvalPhoto_ColumnNames.GlobalPahtFile, typeof(string));
                        ViewState[Constants.SessionPhotoTable.ConsultEvalPhotoFiles] = pfotoLinks;
                        editConsultPfotoContainer.InnerHtml = GetImagesLinks(Constants.SessionPhotoTable.ConsultEvalPhotoFiles);
                    }
                    catch
                    {
                        Utils.InfoText(this, "Atentie", " Eroare In sistem! ");
                    }
                }
            }
        }
    }

    protected void consultEvalGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (allowContragentEditConsultEval)
        {
            string moduleFolder = Utils.ModuleCredits().RootModuleFolder;

            int index = e.RowIndex;
            int consultId = 0;
            int.TryParse(consultEvalGridView.Rows[index].Cells[0].Text, out consultId);

            string data = string.Empty;
            Label consultDataLabel = (Label)consultEvalGridView.Rows[index].Cells[1].FindControl("consultDataLabel");
            if (consultDataLabel != null) data = consultDataLabel.Text;

            DataTable filesTable = Utils.ModuleCredits().GetVisitsConsultPhotoByClevId(consultId);
            if (consultId != 0 && Utils.ModuleCredits().DeleteVizitConsult(consultId))
            {
                for (int i = 0; i < filesTable.Rows.Count; i++)
                {
                    string fileID = filesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID].ToString();
                    if (!string.IsNullOrEmpty(fileID))
                    {
                        string PhotoLink = filesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.PhotoLink].ToString();
                        string SmollPhotoLink = filesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.SmallPhotoLink].ToString();

                        if (File.Exists(Server.MapPath(moduleFolder + "/" + PhotoLink))) File.Delete(Server.MapPath(moduleFolder + "/" + PhotoLink));
                        if (File.Exists(Server.MapPath(moduleFolder + "/" + SmollPhotoLink))) File.Delete(Server.MapPath(moduleFolder + "/" + SmollPhotoLink));
                    }
                }

                filesTable.Rows.Clear();
                filesTable.AcceptChanges();
                ViewState[Constants.SessionPhotoTable.ConsultEvalPhotoFiles] = filesTable;

                Utils.ModuleCredits().DeleteVizitConsultFotoFilesFromDB(consultId);
                ClearConsultEvalForm();
                FillConsultEvalGridView(this.ClientObject.ClientID);
            }
            else
            {
                Utils.InfoText(this, "Atentie", " Inscrierea despre vizita catre pe data { " + data + " } - nu a fost stearsa. Verificati conectiunea cu internet ");
            }
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    protected void editFileUploadButton_Click(object src, EventArgs e)
    {
        if (allowContragentEditConsultEval && editConsultFileUpload.HasFiles)
        {
            foreach (HttpPostedFile file in editConsultFileUpload.PostedFiles)
            {
                string largeFileName = string.Empty;
                string smallFileName = string.Empty;
                string originalFileName = string.Empty;

                int vizitConsultID = this.CurrentConsultEval;

                string moduleFolder = Utils.ModuleCredits().RootModuleFolder;

                if (vizitConsultID != 0 && file != null && file.ContentLength >= 0)
                {                   
                    int newFileID = 0;

                    if (Utils.ModuleCredits().TransformImageFile(file.InputStream, file.FileName, this.ClientObject, out largeFileName, out smallFileName, out originalFileName) && !largeFileName.Equals(string.Empty) && !smallFileName.Equals(string.Empty))
                    {
                        if (Utils.ModuleCredits().AddVizitFoto(vizitConsultID, largeFileName, smallFileName, originalFileName, out newFileID) && newFileID != 0)
                        {
                            AddPhotoFileToViewState(Constants.SessionPhotoTable.ConsultEvalPhotoFiles, newFileID, vizitConsultID, largeFileName, smallFileName, originalFileName);
                        }
                        else
                        {
                            ///  delete transformated file
                            if (File.Exists(Server.MapPath(moduleFolder + "/" + largeFileName))) File.Delete(Server.MapPath(moduleFolder + "/" + largeFileName));
                            if (File.Exists(Server.MapPath(moduleFolder + "/" + smallFileName))) File.Delete(Server.MapPath(moduleFolder + "/" + smallFileName));
                        }
                    }

                    editConsultPfotoContainer.InnerHtml = GetImagesLinks(Constants.SessionPhotoTable.ConsultEvalPhotoFiles);
                }
            }
        }
        else
        {
            Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx");
        }
    }
    
    private string GetImagesLinks(string PanelName)
    {
        string result = string.Empty;

        if (ViewState[PanelName] != null)
        {
            DataTable photoTable = (DataTable)ViewState[PanelName];

            if (photoTable != null)
            {
                for (int i = 0; i < photoTable.Rows.Count; i++)
                {
                    string moduleRootDirectory = Utils.ModuleCredits().RootModuleFolder.Replace("~", "..") + "/";
                    string photoID = photoTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID].ToString();
                    string clevID = photoTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.clevID].ToString();
                    string photoLink = photoTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.PhotoLink].ToString();
                    string smallPhotoLink = photoTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.SmallPhotoLink].ToString();
                    string originalFileName = photoTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.OriginalFileName].ToString();

                    result += "<span class=\"smallImageLink\"  >";
                    result += "<div>";
                    result += "<a class=\"group3\" href=\"" + moduleRootDirectory + photoLink + "\" title=\"" + originalFileName + "\"><img src=\"" + moduleRootDirectory + smallPhotoLink + "\" /> </a>";

                    result += "</div>";
                    string encodedParameters = Server.UrlEncode(photoID + ";" + clevID + ";" + photoLink + ";" + smallPhotoLink);
                    result += "<div style=\"text-align:center;\"> <a href=\"javascript: //\" id=\"deleteImageLink\"  onclick=\"doPost('" + PanelName + "','" + encodedParameters + "')\">Delete <img src=\"../App_Images/delete.png\" alt=\"Delete\" title=\"Delete\" height=\"12\" width=\"12\" border=\"0\" /></a> </div>";
                    result += "</span>";
                }
            }
        }

        return result;
    }

    private void AddPhotoFileToViewState(string PanelName, int intFotoId, int intClevId, string PhotoLink, string SmollPhotoLink, string OriginalFileName)
    {
        if (ViewState[PanelName] != null)
        {
            DataTable fileTable = (DataTable)ViewState[PanelName];
            if (fileTable != null)
            {
                fileTable.Rows.Add();

                string moduleFolder = Utils.ModuleCredits().RootModuleFolder;

                fileTable.Rows[fileTable.Rows.Count - 1][Constants.ConsultEvalPhoto_ColumnNames.photoID] = intFotoId;
                fileTable.Rows[fileTable.Rows.Count - 1][Constants.ConsultEvalPhoto_ColumnNames.clevID] = intClevId;
                fileTable.Rows[fileTable.Rows.Count - 1][Constants.ConsultEvalPhoto_ColumnNames.PhotoLink] = PhotoLink;
                fileTable.Rows[fileTable.Rows.Count - 1][Constants.ConsultEvalPhoto_ColumnNames.SmallPhotoLink] = SmollPhotoLink;
                fileTable.Rows[fileTable.Rows.Count - 1][Constants.ConsultEvalPhoto_ColumnNames.OriginalFileName] = OriginalFileName;
                fileTable.Rows[fileTable.Rows.Count - 1][Constants.ConsultEvalPhoto_ColumnNames.GlobalPahtFile] = moduleFolder;
            }

            ViewState[PanelName] = fileTable;
        }
    }

    private void RemovePhotoFile(string PanelName, string photoID, string clevID, string PhotoLink, string SmollPhotoLink)
    {
        if (ViewState[PanelName] != null)
        {
            string moduleFolder = Utils.ModuleCredits().RootModuleFolder;

            DataTable fileTable = (DataTable)ViewState[PanelName];
            if (fileTable != null)
            {
                for (int i = 0; i < fileTable.Rows.Count; i++)
                {
                    if (fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID].ToString().Equals(photoID)
                        && fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.clevID].ToString().Equals(clevID)
                        && fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.PhotoLink].ToString().Equals(PhotoLink)
                        && fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.SmallPhotoLink].ToString().Equals(SmollPhotoLink))
                    {

                        if (!fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID].ToString().Equals(string.Empty) && !fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.clevID].ToString().Equals(string.Empty))
                        {
                            int intPhotoID = 0;
                            int.TryParse(fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID].ToString(), out intPhotoID);
                            if (intPhotoID != 0) Utils.ModuleCredits().DeleteVizitFoto(intPhotoID);
                        }

                        fileTable.Rows[i].Delete();
                    }
                }

                fileTable.AcceptChanges();

                if (File.Exists(Server.MapPath(moduleFolder + "/" + PhotoLink))) File.Delete(Server.MapPath(moduleFolder + "/" + PhotoLink));
                if (File.Exists(Server.MapPath(moduleFolder + "/" + SmollPhotoLink))) File.Delete(Server.MapPath(moduleFolder + "/" + SmollPhotoLink));
            }

            ViewState[PanelName] = fileTable;
        }
    }

    protected void editConsultSaveButton_Click(object sender, EventArgs e)
    {
        if (allowContragentEditConsultEval)
        {
            int vizitConsultID = this.CurrentConsultEval;

            DateTime consultDate = Crypt.Utils.ToDateTime(editDataTextBox.Text, Constants.ISODateBackwardDotsFormat);

            int clientID = this.ClientObject.ClientID;

            int operatorID = 0;
            int.TryParse(consultEvalOperDDL.SelectedValue, out operatorID);

            int tipConsultEvalID = 0;
            int.TryParse(tipConsultEvalDDL.SelectedValue, out tipConsultEvalID);

            string descriereConsult = editConsultDescriptionTextBox.Text.Trim();

            int businessStateID = 0;
            int.TryParse(consultEvalBussnesStateDDL.SelectedValue, out businessStateID);

            int nrDeAngajati = 0;
            int.TryParse(editNrEmplTextBox.Text, out nrDeAngajati);

            int venitMediuLunar = 0;
            int.TryParse(editAverajeMonthlyIncomeTextBox.Text, out venitMediuLunar);

            string shortDescription = editShortDescriptionStateTextBox.Text;

            bool resultUpdate = false;

            if (this.IsNewConsultEval)
            {
                int newClevID = 0;

                resultUpdate = Utils.ModuleCredits().AddVizitConsult(consultDate, clientID, operatorID, tipConsultEvalID, descriereConsult, businessStateID, nrDeAngajati, venitMediuLunar, shortDescription, out newClevID);
                if (resultUpdate && newClevID != 0)
                {
                    this.CurrentConsultEval = newClevID;
                    this.IsNewConsultEval = false;
                    vizitConsultID = newClevID;
                }
            }
            else
            {
                resultUpdate = Utils.ModuleCredits().UpdateVizitConsult(vizitConsultID, consultDate, clientID, operatorID, tipConsultEvalID, descriereConsult, businessStateID, nrDeAngajati, venitMediuLunar, shortDescription);
            }

            if (resultUpdate)
            {
                DataTable photoFilesTable = (DataTable)ViewState[Constants.SessionPhotoTable.ConsultEvalPhotoFiles];
                if (photoFilesTable != null)
                {
                    for (int i = 0; i < photoFilesTable.Rows.Count; i++)
                    {
                        string photoID = photoFilesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID].ToString();
                        string clevID = photoFilesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.clevID].ToString();
                        string photoLink = photoFilesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.PhotoLink].ToString();
                        string smallPhotoLink = photoFilesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.SmallPhotoLink].ToString();
                        string originalFileName = photoFilesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.OriginalFileName].ToString();
                        int newFileID = 0;

                        if (string.IsNullOrEmpty(photoID) && string.IsNullOrEmpty(clevID) && Utils.ModuleCredits().AddVizitFoto(vizitConsultID, photoLink, smallPhotoLink, originalFileName, out newFileID) && newFileID != 0)
                        {
                            photoFilesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID] = newFileID;
                            photoFilesTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.clevID] = vizitConsultID;
                        }
                    }

                    ViewState[Constants.SessionPhotoTable.ConsultEvalPhotoFiles] = photoFilesTable;
                }

                Utils.InfoText(this, "Felicitari", "Detalii despre VIZITA au fost salvate! ");
                FillConsultEvalGridView(clientID);
            }
            else
            { Utils.InfoText(this, "Atentie", " Datele nu a fost salvate. Verificati conectiunea cu internet "); }
        }
        else
        { Response.Redirect(Utils.GetApplicationPath(Request) + "/AccessDenied.aspx"); }
    }

    //protected void ChekNewConsultEval()
    //{
    //    if (this.IsNewConsultEval)
    //    {
    //        DateTime consultDate = Crypt.Utils.ConvertStringDateToDateTime(editDataTextBox.Text);

    //        int clientID = this.ClientObject.ClientID;

    //        int operatorID = 0;
    //        int.TryParse(consultEvalOperDDL.SelectedValue, out operatorID);

    //        int tipConsultEvalID = 0;
    //        int.TryParse(tipConsultEvalDDL.SelectedValue, out tipConsultEvalID);

    //        string descriereConsult = editConsultDescriptionTextBox.Text.Trim();

    //        int businessStateID = 0;
    //        int.TryParse(consultEvalBussnesStateDDL.SelectedValue, out businessStateID);

    //        int nrDeAngajati = 0;
    //        int.TryParse(editNrEmplTextBox.Text, out nrDeAngajati);

    //        int venitMediuLunar = 0;
    //        int.TryParse(editAverajeMonthlyIncomeTextBox.Text, out venitMediuLunar);

    //        string shortDescription = editShortDescriptionStateTextBox.Text;

    //        bool resultUpdate = false;

    //        int newClevID = 0;

    //        resultUpdate = Utils.ModuleCredits().AddVizitConsult(consultDate, clientID, operatorID, tipConsultEvalID, descriereConsult, businessStateID, nrDeAngajati, venitMediuLunar, shortDescription, out newClevID);
    //        if (resultUpdate && newClevID != 0)
    //        {
    //            this.CurrentConsultEval = newClevID;
    //            this.IsNewConsultEval = false;

    //            FillConsultEvalGridView(clientID);
    //            consultEvalGridView.SelectedIndex = -1;

    //            for (int i = 0; i < consultEvalGridView.Rows.Count; i++)
    //            {
    //                if (consultEvalGridView.Rows[i].Cells[0].Text.Equals(this.CurrentConsultEval.ToString()))
    //                {
    //                    consultEvalGridView.SelectedIndex = i;
    //                }
    //            }
    //        }
    //    }
    //}

    //protected void consultEvalOperDDL_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    ChekNewConsultEval();
    //}

    //protected void tipConsultEvalDDL_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    ChekNewConsultEval();
    //}

    //protected void consultEvalBussnesStateDDL_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    ChekNewConsultEval();
    //}

    #endregion Consult Eval  
}