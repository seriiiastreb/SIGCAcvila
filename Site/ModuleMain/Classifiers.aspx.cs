using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class Classifiers : System.Web.UI.Page
{
    private readonly string mCurrentModule = Security.MainModule.ID;
    private readonly string mPageName = "System Sequrity Administration";
    private readonly string mEfectivePermVS = "EfectivePermissions";

    private bool allowEdit = false;
    private bool allowView = false;


    private string appPath = string.Empty;

    //private void ShowClassifierTypesPanels(string panelName)
    //{
    //    #region Hide panels
    //    classifiersGeneraPanel.Visible = false;

    //    classifierTypesPanel.Visible = false;


    //    #endregion Hide panels

    //    try
    //    {
    //        #region Get Panel Name

    //        switch (panelName)
    //        {
    //            case "classifierTypesPanel":
    //                classifiersGeneraPanel.Visible = true;
    //                classifierTypesPanel.Visible = true;
    //                FillClasifiersTypesGridView();
    //                break;

    //            case "addNewClassifierTypePanel":
    //                classifiersGeneraPanel.Visible = true;
    //                addNewClassifierTypePanel.Visible = true;                    
    //                break;

    //            case "editClassifierTypePanel":
    //                classifiersGeneraPanel.Visible = true;
    //                editClassifierTypePanel.Visible = true;
    //                break;

    //            default:
    //                break;
    //        }

    //        #endregion Get Panel Name
    //    }
    //    catch (Exception ex)
    //    {
    //        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message);
    //    }
    //}

    //private void ShowClassifierPanels(string panelName)
    //{
    //    #region Hide panels

    //    classifiersPanel.Visible = false;
    //    addNewClassifierPanel.Visible = false;
    //    editClassifierPanel.Visible = false;

    //    #endregion Hide panels

    //    try
    //    {
    //        #region Get Panel Name

    //        switch (panelName)
    //        {
    //            case "classifiersPanel":
    //                classifiersPanel.Visible = true;

    //                FillClassifiersGrid();
    //                break;

    //            case "addNewClassifierPanel":
    //                addNewClassifierPanel.Visible = true;

    //                break;

    //            case "editClassifierPanel":
    //                editClassifierPanel.Visible = true;

    //                break;
               
    //            default:
                    
    //                break;
    //        }

    //        #endregion Get Panel Name
    //    }
    //    catch (Exception ex)
    //    {
    //        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message);
    //    }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowView = Utils.PermissionAllowed(mCurrentModule, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_View);
        allowEdit = Utils.PermissionAllowed(mCurrentModule, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_Edit);


        if (allowView)
        {
            if (!IsPostBack)
            {
                FillClasifiersTypesGridView();
            }
            else
            {
                string eventArgument = Request.Params.Get("__EVENTARGUMENT");

                switch (Request.Params.Get("__EVENTTARGET"))
                {
                    case "classifierTypesGridViewClik":
                        EditEntry(eventArgument);
                        break;
                    case "editClock":
                        EditClock(eventArgument);
                }
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        }  
    }
    
    #region Classifier Types

    private void FillClasifiersTypesGridView()
    {
        try
        {
            selectedClassifierTypeIDHiddenField.Value = string.Empty;
            DataTable classifiersTypesDT = Utils.ModuleMain().GetClassifierTypesList();
            classifierTypesGridView.DataSource = classifiersTypesDT;
            classifierTypesGridView.DataBind();
        }
        catch(Exception ex)
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", ex.Message);
        }
    }

    protected void ClearClTypeForm()
    {
        classiferTypeAction.Value = Crypt.Module.CreateEncodedString("New");
        classifierTypeTextBox.Text = string.Empty;
        curentClassifierTypeSelectedLabel.Text = string.Empty;
    }

    protected void classifierTypesGridView_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";          
        }
    }

    //protected void classifierTypesGridView_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (classifierTypesGridView.SelectedRow != null)
    //    {
    //        ClearClTypeForm();

    //        GridViewRow row = classifierTypesGridView.SelectedRow;

    //        if (row != null)
    //        {
    //            classiferTypeAction.Value = Crypt.Module.CreateEncodedString("Edit");
    //            selectedClassifierTypeIDHiddenField.Value = row.Cells[0].Text;
    //            classifierTypeTextBox.Text = row.Cells[1].Text;
    //            curentClassifierTypeSelectedLabel.Text = row.Cells[1].Text;
    //        }
    //    }

    //    FillClassifiersGrid();
    //}
    
    protected void refreshClassifirsTypesButton_Click(object sender, EventArgs e)
    {
        FillClasifiersTypesGridView();
    }

    protected void classifierTypeSaveButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            try
            {
                bool resultAction = false;

                string clnName = classifierTypeTextBox.Text;

                int selectedClTypeID = 0;
                int.TryParse(selectedClassifierTypeIDHiddenField.Value, out selectedClTypeID);

                string cltypeAction = Crypt.Module.DecodeCriptedString(classiferTypeAction.Value);

                if (cltypeAction.Equals("New"))
                {
                    resultAction = Utils.ModuleMain().NewClassifierTypes(clnName);
                }
                else
                {
                    if(selectedClTypeID != 0)
                    {
                         resultAction = Utils.ModuleMain().UpdateClassifierTypes(selectedClTypeID, clnName);
                    }
                }

                if (resultAction)
                {
                    ClearClTypeForm();
                    FillClasifiersTypesGridView();                    
                    FillClassifiersGrid();
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The type { " + clnName + " } was not saved. Try again later.");
                }
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
    
    //protected void classifierTypesGridView_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
    //{
    //    bool allowHere = Utils.PermissionAllowed(mCurrentModule, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_Edit);
    //    if (allowHere)
    //    {
    //        int index = e.RowIndex;

    //        try
    //        {
    //            string strTypeID = classifierTypesGridView.Rows[index].Cells[0].Text;
    //            int typeID = 0;
    //            int.TryParse(strTypeID, out typeID);

    //            if (Utils.ModuleMain().DeleteClassifierType(typeID))
    //            {
    //                ShowClassifierTypesPanels(classifierTypesPanel.ID);
    //            }
    //            else
    //            {
    //                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The classifier type was not deleted. Try again later.");
    //            }
    //        }
    //        catch (Exception ex)
    //        { Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message); }
    //    }
    //    else
    //    {
    //      Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
    //    }         
    //}
    
    #endregion Classifier Types
    
    #region Classifiers

    private void ClearClassiferForm()
    {
        classifiersActionHiddenField.Value = Crypt.Module.CreateEncodedString("New");
        classifierNameTextBox.Text = string.Empty;
        classifierGroupCodeTextBox.Text = string.Empty;
    }

    protected void classifiersRefreshButton_Click(object sender, ImageClickEventArgs e)
    {
        FillClassifiersGrid();
    }

    private void FillClassifiersGrid()
    {
        try
        {
            int clTypeID = 0;
            int.TryParse(selectedClassifierTypeIDHiddenField.Value, out clTypeID);

            currentClassifierSelectedHiddenFiled.Value = string.Empty;

            DataTable classifiers = Utils.ModuleMain().GetAllClassifiers(clTypeID);
            classifiersGridView.DataSource = classifiers;
            classifiersGridView.DataBind();
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message);
        }
    }

    protected void classifiersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        }
    }

    protected void EditClassifier()
    {     
        try
        {
            if (currentClassifierSelectedHiddenFiled.Value.Equals(string.Empty))
            {
                int index = -1;
                int.TryParse(currentClassifierSelectedHiddenFiled.Value, out index);

                if (index != -1)
                {
                    classifiersActionHiddenField.Value = Crypt.Module.CreateEncodedString("Edit");
                    currentClassifierSelectedHiddenFiled.Value = classifiersGridView.Rows[index].Cells[1].Text;
                    classifierNameTextBox.Text = classifiersGridView.Rows[index].Cells[2].Text;
                    classifierGroupCodeTextBox.Text = (classifiersGridView.Rows[index].Cells[3].Text.Equals("&nbsp;") ? string.Empty : classifiersGridView.Rows[index].Cells[3].Text);
                }
            }
            else
            {
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "Select classifier befor editing.");
            }
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message);
        }
    }

    protected void classifiersSaveButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            try
            {
                bool resultAction = false;
                string classifersAction = Crypt.Module.DecodeCriptedString(classifiersActionHiddenField.Value);

                int clTypeID = 0;
                int.TryParse(selectedClassifierTypeIDHiddenField.Value, out clTypeID);

                int classifierCode = 0;
                int.TryParse(classifiersActionHiddenField.Value, out classifierCode);

                string denumirea = classifierNameTextBox.Text;

                int groupCode = 0;
                int.TryParse(classifierGroupCodeTextBox.Text, out groupCode);


                if (classifersAction.Equals("New"))
                { 
                    resultAction = Utils.ModuleMain().NewClassifier(clTypeID, denumirea, groupCode);
                }
                else
                {
                    resultAction = Utils.ModuleMain().UpdateClassifier(classifierCode, denumirea, groupCode);
                }

                if (resultAction)
                {
                    ClearClassiferForm();
                    FillClassifiersGrid();
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The classifier  { " + denumirea + " }  was not saved. Try again later.");
                }
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

    protected void DeleteClassifer()
    {
        //if (allowEdit)
        //{
        //    int index = e.RowIndex;

        //    try
        //    {
        //        int clCode = 0;
        //        int.TryParse(classifiersPanelGridView.Rows[index].Cells[1].Text, out clCode);

        //        if (Utils.ModuleMain().DeleteClassifier(clCode))
        //        {
        //            editClassifierCodeLabel.Text = string.Empty;
        //            ShowClassifierPanels(classifiersPanel.ID);
        //        }
        //        else
        //        {
        //            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The classifier  was not deleted. Try again later.");
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message);
        //    }
        //}
        //else
        //{
        //    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues.");
        //}        
    }
    

    #endregion Classifiers



}