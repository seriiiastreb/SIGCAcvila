﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SystemSeqAdmin : System.Web.UI.Page
{
    private readonly string mCurrentModule = Security.Module.ID;
    private readonly string mPageName = "System Sequrity Administration";

    bool allowEdit = false;
    bool allowView = false;
    
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
                    FillDDLOnUsersFroms();
                    FillPermissionsComboBox();
                    ShowPanels(usersListPanel.ID);
                }
                else
                {
                    string eventSource = Request.Params.Get("__EVENTTARGET");
                    string action = Request.Params.Get("__EVENTARGUMENT");

                    int selectedIndexInUsresGrid = 0;
                    int.TryParse(usersGrid_SelectedIndex_HiddenValue.Value, out selectedIndexInUsresGrid);
                    if (!usersGrid_SelectedIndex_HiddenValue.Value.Equals(string.Empty)) usersGrid.SelectedIndex = selectedIndexInUsresGrid;

                    int selectedIndexInDomainGrid = 0;
                    int.TryParse(domainsGridSelectedIndexHiddenField.Value, out selectedIndexInDomainGrid);
                    if (!domainsGridSelectedIndexHiddenField.Value.Equals(string.Empty)) doaminsGridView.SelectedIndex = selectedIndexInDomainGrid;


                    switch (eventSource)
                    {

                        case "domainsGridClik":

                            #region Users Grid Events

                            switch (action.ToLower())
                            {
                                case "add":
                                    {
                                        ClearDomainsForm();
                                        domainsModalPopupExtender.Show();
                                    }
                                    break;

                                case "edit":
                                    ClearDomainsForm();

                                    string role_ID = doaminsGridView.Rows[selectedIndexInDomainGrid].Cells[0].Text.Replace("&nbsp;", "");
                                    string module_id = doaminsGridView.Rows[selectedIndexInDomainGrid].Cells[1].Text.Replace("&nbsp;", "");
                                    string domain_id = doaminsGridView.Rows[selectedIndexInDomainGrid].Cells[2].Text.Replace("&nbsp;", "");
                                    string permissions = doaminsGridView.Rows[selectedIndexInDomainGrid].Cells[3].Text.Replace("&nbsp;", "");

                                    try
                                    {
                                        roleID_DDL.Items.FindByValue(role_ID).Selected = true;
                                    }
                                    catch { }

                                    try
                                    {
                                        moduleID_DDL.Items.FindByValue(module_id).Selected = true;
                                    }
                                    catch { }

                                    try
                                    {
                                        FillDomainsDDL();
                                        domainID_DDL.Items.FindByValue(domain_id).Selected = true;
                                    }
                                    catch { }

                                    try
                                    {
                                        permissionDDL.Items.FindByValue(permissions).Selected = true;
                                    }
                                    catch { }

                                    domainsModalPopupExtender.Show();
                                    break;
                                                                
                                case "delete":
                                    if (allowEdit)
                                    {
                                        string role_IDd = doaminsGridView.Rows[selectedIndexInDomainGrid].Cells[0].Text.Replace("&nbsp;", "");
                                        string module_idd = doaminsGridView.Rows[selectedIndexInDomainGrid].Cells[1].Text.Replace("&nbsp;", "");
                                        string domain_idd = doaminsGridView.Rows[selectedIndexInDomainGrid].Cells[2].Text.Replace("&nbsp;", "");

                                        if (Utils.ModuleSecurity().DeletePermissions(module_idd, role_IDd, domain_idd))
                                        {
                                            FillDomainsGridView();
                                        }
                                        else
                                        {
                                            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error deleting record.", "Selected permission not deleted. Try again later! " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
                                        }                                       
                                    }
                                    else
                                    {
                                        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
                                    }
                                    break;
                            }
                            #endregion Users Grid Events


                            break;
                        case "usersGridClik":

                            #region Users Grid Events

                            switch (action.ToLower())
                            {
                                case "add":
                                    {
                                        ClearUsersForm();
                                        usersPopupExtender.Show();
                                    }
                                    break;

                                case "edit":
                                    ClearUsersForm();

                                    usersActionHiddenField.Value = Crypt.Module.CreateEncodedString("Edit");
                                    usersSelectedUserIDHiddenField.Value = usersGrid.Rows[selectedIndexInUsresGrid].Cells[0].Text.Replace("&nbsp;", "");
                                    users_Nume_TextBox.Text = usersGrid.Rows[selectedIndexInUsresGrid].Cells[1].Text.Replace("&nbsp;", "");
                                    users_Prenume_TextBox.Text = usersGrid.Rows[selectedIndexInUsresGrid].Cells[2].Text.Replace("&nbsp;", "");
                                    users_Login_TextBox.Text = usersGrid.Rows[selectedIndexInUsresGrid].Cells[3].Text.Replace("&nbsp;", "");
                                    users_Email_TextBox.Text = usersGrid.Rows[selectedIndexInUsresGrid].Cells[6].Text.Replace("&nbsp;", "");
                                    try
                                    { userDetails_RecordStatusDDL.SelectedValue = usersGrid.Rows[selectedIndexInUsresGrid].Cells[4].Text.Replace("&nbsp;", ""); }
                                    catch { }

                                    usersPopupExtender.Show();
                                    break;

                                case "reset":
                                    ClearResetPasswordForm();
                                    resetPasswordSelectedClientID.Value = usersGrid.Rows[selectedIndexInUsresGrid].Cells[0].Text.Replace("&nbsp;", "");
                                    resetPassPopupExtender.Show();
                                    break;

                                case "delete":
                                    if (allowEdit)
                                    {
                                        int userID = 0;
                                        int.TryParse(usersGrid.Rows[selectedIndexInUsresGrid].Cells[0].Text, out userID);

                                        if (userID != 0)
                                        {
                                            if (Utils.ModuleSecurity().DeleteUser(userID))
                                            {
                                                FillUsersGridView();
                                            }
                                            else
                                            {
                                                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error deleting record.", "Selected user not deleted. Try again later! " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
                                            }
                                        }
                                    }
                                    else
                                    {
                                        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
                                    }
                                    break;
                            }
                            #endregion Users Grid Events

                            break;

                        default:
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

    private void ShowPanels(string panelID)
    {
        #region Hode all panels
        usersListPanel.Visible = false;
        groupsListPanel.Visible = false;
        domainsListPanel.Visible = false;
        #endregion Hode all panels


        switch (panelID)
        {
            case "usersListPanel":
                currentSelected.Text = "Registered Users List:";
                FillUsersGridView();
                usersListPanel.Visible = true;
                break;

            case "groupsListPanel":
                currentSelected.Text = "Registered Groups:";
                FillGroupsGridView();
                groupsListPanel.Visible = true;
                break;

            case "domainsListPanel":
                currentSelected.Text = "Registered Domains:";
                FillDomainsGridView();
                FillModulesComboBox();
                FillDomainsDDL();
                FillRolesDDL();
                domainsListPanel.Visible = true;
                break;


            default:
                FillUsersGridView();
                usersListPanel.Visible = true;
                break;
        }
    }


    #region Users

    protected void ClearUsersForm()
    {
        usersActionHiddenField.Value = Crypt.Module.CreateEncodedString("New");
        users_Nume_TextBox.Text = string.Empty;
        users_Prenume_TextBox.Text = string.Empty;
        users_Login_TextBox.Text = string.Empty;
        users_Email_TextBox.Text = string.Empty;
        try
        { userDetails_RecordStatusDDL.SelectedIndex = 0; }
        catch { }
    }

    protected void users_SaveButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            string usersAction = Crypt.Module.DecodeCriptedString(usersActionHiddenField.Value);
            bool actionResult = false; 

            int userID = 0; 
            if(usersAction.Equals("Edit")) int.TryParse(usersSelectedUserIDHiddenField.Value , out userID);

            string nume = users_Nume_TextBox.Text;
            string prenume = users_Prenume_TextBox.Text;
            string login = users_Login_TextBox.Text;
            string email = users_Email_TextBox.Text;

            int recordStatusID = 0;
            int.TryParse(userDetails_RecordStatusDDL.SelectedValue, out recordStatusID);

            if (usersAction.Equals("New"))
            {
                actionResult = Utils.ModuleSecurity().NewUser(nume, prenume, login, email, recordStatusID);
            }
            else
            {
                actionResult = Utils.ModuleSecurity().UpdateUser(userID, nume, prenume, login, email, recordStatusID);
            }

            if (actionResult)
            {
                ClearUsersForm();
                FillUsersGridView();
                usersPopupExtender.Hide();
                   
                //Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Ok, "Congratulation", "Succesifuly added user information.");
            }
            else
            {
                usersPopupExtender.Show();
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention", "Unable to add new user, try again later. " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }            
    }
    
    protected void FillDDLOnUsersFroms()
    {
        DataTable recordStatus = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.SystemUserRecordStatus);
        Utils.FillSelector(userDetails_RecordStatusDDL, recordStatus, "Name", "Code");
    }

    protected void FillUsersGridView()
    {
        usersSelectedUserIDHiddenField.Value = string.Empty;
        usersActionHiddenField.Value = string.Empty;
        usersGrid_SelectedIndex_HiddenValue.Value = string.Empty;

        DataTable sourceDT = Utils.ModuleSecurity().GetUsersList();
        usersGrid.DataSource = sourceDT;
        usersGrid.DataBind();
    }

    protected void usersGrid_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        }
    }
    
    protected void usersListLinkButton_Click(object sender, EventArgs e)
    {
        ShowPanels(usersListPanel.ID);
    }

    #region Reset Pass

    protected void ClearResetPasswordForm()
    {
        resetPasswordSelectedClientID.Value = string.Empty;
        resetPassTextBox.Text = string.Empty;
        resetPass_repeatTextBox.Text = string.Empty;
    }

    protected void resetPassOkButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            if (usersGrid.SelectedRow != null)
            {
                int userID = 0;
                int.TryParse(usersGrid.SelectedRow.Cells[0].Text, out userID);

                if (userID != 0)
                {
                    string newPassword = resetPass_repeatTextBox.Text.Trim();

                    if (Utils.ModuleSecurity().ResetUserPassword(userID, newPassword))
                    {
                        resetPassPopupExtender.Hide();
                        ClearResetPasswordForm();
                        ///Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Info, "Succes!", "Password was changet successfully.");
                    }
                    else
                    {
                        resetPassPopupExtender.Hide();
                        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error updating record.", "For selected user was not changet password. Try again later! " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
                    }
                }
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }
    }

    #endregion Reset Pass
    
    #endregion Users

    #region Groups 

    protected void groupsListLinkButton_Click(object sender, EventArgs e)
    {        
        ShowPanels(groupsListPanel.ID);
    }

    protected void FillGroupsGridView()
    { 
    }

    #endregion Groups 


    #region Domains 
    protected void ClearDomainsForm()
    {
        try
        {
            moduleID_DDL.SelectedIndex = -1;
        }
        catch { }

        try
        {
            roleID_DDL.SelectedIndex = -1;
        }
        catch { }

        try
        {
            domainID_DDL.SelectedIndex = -1;
        }
        catch { }

        try
        {
            permissionDDL.SelectedIndex = -1;
        }
        catch { }
    }
    
    protected void FillPermissionsComboBox()
    {
        DataTable sourceDT = new DataTable();
        sourceDT.Columns.Add("Code", typeof(int));
        sourceDT.Columns.Add("Name", typeof(string));

        sourceDT.Rows.Add();
        sourceDT.Rows[sourceDT.Rows.Count - 1]["code"] = (int)Constants.Classifiers.Permissions_View;
        sourceDT.Rows[sourceDT.Rows.Count - 1]["Name"] = "View";

        sourceDT.Rows.Add();
        sourceDT.Rows[sourceDT.Rows.Count - 1]["code"] = (int)Constants.Classifiers.Permissions_Edit;
        sourceDT.Rows[sourceDT.Rows.Count - 1]["Name"] = "Edit";

        sourceDT.Rows.Add();
        sourceDT.Rows[sourceDT.Rows.Count - 1]["code"] = (int)Constants.Classifiers.Permissions_Deny;
        sourceDT.Rows[sourceDT.Rows.Count - 1]["Name"] = "Deny";

        Utils.FillSelector(permissionDDL, sourceDT, "Name", "Code");
    }

    protected void FillRolesDDL()
    {
        DataTable rolesList = Utils.ModuleSecurity().GetGroupsList();
        Utils.FillSelector(roleID_DDL, rolesList, "role_id", "role_id");        
    }

    protected void FillModulesComboBox()
    {
        DataTable modulList = Utils.ModuleSecurity().GetModulesList();
        Utils.FillSelector(moduleID_DDL, modulList, "description", "module_id");
    }

    protected void FillDomainsDDL()
    {
        if (allowView)
        {
            if (moduleID_DDL.SelectedValue != null && !moduleID_DDL.SelectedValue.Equals(string.Empty))
            {
                string moduleID = moduleID_DDL.SelectedValue;
                DataTable domainsList = Utils.ModuleSecurity().GetDomainsListInModule(moduleID);
                Utils.FillSelector(domainID_DDL, domainsList, "description","domain_id");
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }  
    }
    
    protected void refreshDomainsButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            try
            {
                Security.MainModule.Register();
                Security.Module.Register();

                FillModulesComboBox();
                FillDomainsDDL();
                FillRolesDDL();
            }
            catch (Exception ex)
            {
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message);
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }  
    }

    protected void moduleID_DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillDomainsDDL();
        domainsModalPopupExtender.Show();
    }

    protected void domainsListLinkButton_Click(object sender, EventArgs e)
    {
        ShowPanels(domainsListPanel.ID);
    }

    protected void doaminsGridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        }
    }

    protected void FillDomainsGridView()
    {
        domainsGridSelectedIndexHiddenField.Value = string.Empty;

        DataTable efectivvePermissGroup = Utils.ModuleSecurity().GetPermissionsForGroup();
        doaminsGridView.DataSource = efectivvePermissGroup;
        doaminsGridView.DataBind();
    }

    protected void domainsSaveButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            string moduleID = moduleID_DDL.SelectedIndex != -1 ? moduleID_DDL.SelectedValue.ToString() : string.Empty;
            string domainID = domainID_DDL.SelectedIndex != -1 ? domainID_DDL.SelectedValue.ToString() : string.Empty;
            string roleID = roleID_DDL.SelectedIndex != -1 ? roleID_DDL.SelectedValue.ToString() : string.Empty;
            string permissionID = permissionDDL.SelectedIndex != -1 ? permissionDDL.SelectedValue.ToString() : string.Empty;
            int permission = 0;
            int.TryParse(permissionID, out permission);

            if (Utils.ModuleSecurity().UpdatePermissions(moduleID, roleID, domainID, permission))
            {
                ClearDomainsForm();
                FillDomainsGridView();
                domainsModalPopupExtender.Hide();

                //Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Ok, "Congratulation", "Succesifuly added user information.");
            }
            else
            {
                domainsModalPopupExtender.Show();
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention", "Unable to save permisson, try again later. " + (Utils.UserObject().IsSysadmin ? Utils.ModuleSecurity().LastError : string.Empty));
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }            
    }

    #endregion Domains 
}