using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class Classifiers : System.Web.UI.Page
{
    private readonly string mCurrentModule = Security.MainModule.ID;
    private readonly string mPageName = "System Sequrity Administration";

    private bool allowEdit = false;
    private bool allowView = false;


    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowView = Utils.PermissionAllowed(mCurrentModule, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_View);
        allowEdit = Utils.PermissionAllowed(mCurrentModule, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_Edit);

        if (allowView)
        {
            try
            {
                if (!IsPostBack)
                {
                    FillClasifiersTypesGridView();
                }
                else
                {
                    string eventSource = Request.Params.Get("__EVENTTARGET");
                    string eventArgument = Request.Params.Get("__EVENTARGUMENT");

                    int selectedClassifierTypeIndexInGrid = 0;
                    int.TryParse(selectedClassifierTypeIndexHiddenField.Value, out selectedClassifierTypeIndexInGrid);
                    if (!selectedClassifierTypeIndexHiddenField.Value.Equals(string.Empty)) classifierTypesGridView.SelectedIndex = selectedClassifierTypeIndexInGrid;

                    int classifiersGridSelectedIndex = 0;
                    int.TryParse(classifiersGridViewSelectedIndexHiddenFiled.Value, out classifiersGridSelectedIndex);
                    if (!classifiersGridViewSelectedIndexHiddenFiled.Value.Equals(string.Empty)) classifiersGridView.SelectedIndex = classifiersGridSelectedIndex;

                    switch (eventSource)
                    {
                        case "classifierTypesGridViewClik":

                            #region ClassierType enents
                            switch (eventArgument)
                            {
                                case "add":
                                    {
                                        ClearClassifierTypesForm();                                        
                                        classifierTypePopupExtender.Show();
                                    }
                                    break;

                                case "edit":
                                    {
                                        ClearClassifierTypesForm();
                                        
                                        classiferTypeAction.Value = Crypt.Module.CreateEncodedString("Edit");
                                        selectedClassifierTypeIDHiddenField.Value = classifierTypesGridView.Rows[selectedClassifierTypeIndexInGrid].Cells[0].Text;
                                        classifierTypeTextBox.Text = classifierTypesGridView.Rows[selectedClassifierTypeIndexInGrid].Cells[1].Text;
                                        curentClassifierTypeSelectedLabel.Text = classifierTypesGridView.Rows[selectedClassifierTypeIndexInGrid].Cells[1].Text;
                                        classifierTypePopupExtender.Show();
                                    }
                                    break;

                                case "delete":
                                    {
                                        int typeID = 0;
                                        int.TryParse(classifierTypesGridView.Rows[selectedClassifierTypeIndexInGrid].Cells[0].Text, out typeID);

                                        if (Utils.ModuleMain().DeleteClassifierType(typeID))
                                        {
                                            FillClasifiersTypesGridView();
                                            FillClassifiersGrid();
                                        }
                                        else
                                        {
                                            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The classifier type was not deleted. Try again later.");
                                        }
                                    }
                                    break;

                                case "select":
                                    {
                                        FillClassifiersGrid();
                                    }
                                    break;
                            }
                            #endregion ClassierType enents

                            break;


                        case "classifierGridViewClik":

                            #region Classifiers Grid events
                            switch (eventArgument)
                            {
                                case "add":
                                    {
                                        ClearClassiferForm();
                                        classifersPopupExtender.Show();
                                    }
                                    break;

                                case "edit":
                                    {
                                        ClearClassiferForm();      
                                        
                                        classifiersActionHiddenField.Value = Crypt.Module.CreateEncodedString("Edit");
                                        currentClassifierSelectedHiddenFiled.Value = classifiersGridView.Rows[classifiersGridSelectedIndex].Cells[1].Text;
                                        classifierNameTextBox.Text = classifiersGridView.Rows[classifiersGridSelectedIndex].Cells[2].Text;
                                        classifierGroupCodeTextBox.Text = (classifiersGridView.Rows[classifiersGridSelectedIndex].Cells[3].Text.Equals("&nbsp;") ? string.Empty : classifiersGridView.Rows[classifiersGridSelectedIndex].Cells[3].Text);
                                            
                                        classifersPopupExtender.Show();
                                    }
                                    break;

                                case "delete":
                                    if (allowEdit)
                                    {
                                        int classiferCode = 0;
                                        int.TryParse(classifiersGridView.Rows[classifiersGridSelectedIndex].Cells[1].Text, out classiferCode);

                                        if (Utils.ModuleMain().DeleteClassifier(classiferCode))
                                        {
                                            FillClassifiersGrid();
                                        }
                                        else
                                        {
                                            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The classifier  was not deleted. Try again later.");
                                        }
                                    }
                                    else
                                    { Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Access restricted.", "You do not have access to this page or options. Contact DataBase administrator to resolve this issues."); }
                                    break;
                            }
                            #endregion Classifiers Grid events

                            break;
                    }
                }
            }
            catch (Exception ex)
            { Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message); }
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
            selectedClassifierTypeIndexHiddenField.Value = string.Empty;
            DataTable classifiersTypesDT = Utils.ModuleMain().GetClassifierTypesList();
            classifierTypesGridView.DataSource = classifiersTypesDT;
            classifierTypesGridView.DataBind();
        }
        catch(Exception ex)
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", ex.Message);
        }
    }
    
    protected void classifierTypesGridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        }
    }

    protected void ClearClassifierTypesForm()
    {
        classiferTypeAction.Value = Crypt.Module.CreateEncodedString("New");
        classifierTypeTextBox.Text = string.Empty;
        curentClassifierTypeSelectedLabel.Text = string.Empty;
    }
       
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
                string cltypeAction = Crypt.Module.DecodeCriptedString(classiferTypeAction.Value);

                string clnName = classifierTypeTextBox.Text;

                int selectedClassifierTypeIndexInGrid = 0;
                int.TryParse(selectedClassifierTypeIndexHiddenField.Value, out selectedClassifierTypeIndexInGrid);

                int selectedClTypeID = 0;
                if (cltypeAction.Equals("Edit"))
                int.TryParse(classifierTypesGridView.Rows[selectedClassifierTypeIndexInGrid].Cells[0].Text, out selectedClTypeID);
                
                if (!clnName.Equals(string.Empty))
                {
                    if (cltypeAction.Equals("New"))
                    {
                        resultAction = Utils.ModuleMain().NewClassifierTypes(clnName);
                    }
                    else
                    {
                        if (selectedClTypeID != 0)
                        {
                            resultAction = Utils.ModuleMain().UpdateClassifierTypes(selectedClTypeID, clnName);
                        }
                    }

                    if (resultAction)
                    {
                        ClearClassifierTypesForm();
                        FillClasifiersTypesGridView();
                        FillClassifiersGrid();
                    }
                    else
                    {
                        Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The type { " + clnName + " } was not saved. Try again later.");
                    }
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "Empty Name not allowed.");
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
     
    #endregion Classifier Types
    
    #region Classifiers

    private void ClearClassiferForm()
    {
        classifiersActionHiddenField.Value = Crypt.Module.CreateEncodedString("New");
        selectedClassifierTypeIDHiddenField.Value = string.Empty;
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
            int selectedClassifierTypeIndexInGrid = 0;
            int.TryParse(selectedClassifierTypeIndexHiddenField.Value, out selectedClassifierTypeIndexInGrid);

            int clTypeID = 0;
            int.TryParse(classifierTypesGridView.Rows[selectedClassifierTypeIndexInGrid].Cells[0].Text, out clTypeID);

            classifiersGridViewSelectedIndexHiddenFiled.Value = string.Empty;

            DataTable classifiers = Utils.ModuleMain().GetAllClassifiers(clTypeID);
            classifiersGridView.DataSource = classifiers;
            classifiersGridView.DataBind();
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message);
        }
    }

    protected void classifiersGridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
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

                int selectedClassifierTypeIndexInGrid = 0;
                int.TryParse(selectedClassifierTypeIndexHiddenField.Value, out selectedClassifierTypeIndexInGrid);

                int selectedClassifierIndexInGrid = 0;
                int.TryParse(classifiersGridViewSelectedIndexHiddenFiled.Value, out selectedClassifierIndexInGrid);
                
                int clTypeID = 0;
                int.TryParse(classifierTypesGridView.Rows[selectedClassifierTypeIndexInGrid].Cells[0].Text, out clTypeID);

                int classifierCode = 0;
                if(classifersAction.Equals("Edit"))
                int.TryParse(classifiersGridView.Rows[selectedClassifierIndexInGrid].Cells[1].Text, out classifierCode);

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

    #endregion Classifiers



}