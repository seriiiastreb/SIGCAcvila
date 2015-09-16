using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class Vinzari : System.Web.UI.Page
{
    private readonly string mCurrentModule = Store.Module.ID;
    private readonly string mPageName = "Warehouse management page";

    bool allowEdit = false;
    bool allowView = false;
    string appPath = string.Empty;
    DataObjects.Client ClientObject
    {
        get { return Session[Utils.SessionKey_ClientObject] != null ? (DataObjects.Client)Session[Utils.SessionKey_ClientObject] : new DataObjects.Client(); }
        set { Session[Utils.SessionKey_ClientObject] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {        
        appPath = Utils.GetApplicationPath(Request);    
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowEdit = Utils.PermissionAllowed(mCurrentModule, Store.Domains.WarehouseManagement.Name, Constants.Classifiers.Permissions_Edit);
        allowView = Utils.PermissionAllowed(mCurrentModule, Store.Domains.WarehouseManagement.Name, Constants.Classifiers.Permissions_View);

        try
        {
            if (allowView)
            {
                if (!IsPostBack)
                {
                    Utils.GetMaster(this).ClearNavLinks();
                    if (Request["act"] != null && !Request["act"].ToString().Equals(string.Empty))
                    {
                        string act = Request["act"].ToString();

                        if (act.Equals("chooseclt"))
                            customerSelectionControl.Show();  
                    }
                    else
                    {
                        customerSelectionControl.Show();
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


    protected void ShowPanel(string panelID)
    {
        vinzariListPanel.Visible = false;
        uploadFromFilePanel.Visible = false;

        switch (panelID)
        {
            case "vinzariListPanel":
                vinzariListPanel.Visible = true;
                FillVinzariGridView();
                break;

            case "uploadFromFilePanel":
                FillSheetsDDL();
                uploadFromFilePanel.Visible = true;
                break;
        }
    }

    protected void FillSheetsDDL()
    {
        DataTable weeksDT = Utils.ModuleStore().GetWeeksList();
        Utils.FillSelector(weeksDDL, weeksDT, "week", "week");

        List<string> sheets = new List<string>();
        sheets.Add("Sheet1");
        sheets.Add("Sheet2");
        sheets.Add("Sheet3");
        sheets.Add("Sheet4");
        fileSheetsDDL.DataSource = sheets;
        fileSheetsDDL.DataBind();

        fileSheetsDDL.SelectedValue = "Sheet2";
    }

    protected void FillVinzariGridView()
    {
        DataTable dt = Utils.ModuleStore().GetVinzariList(this.ClientObject.ClientID);
        vinzariListGridView.DataSource = dt;
        vinzariListGridView.DataBind();
    }

    protected void uploadFromFileButton_Click(object sender, ImageClickEventArgs e)
    {
        ShowPanel(uploadFromFilePanel.ID);
    }
    protected void openFileButton_Click(object sender, EventArgs e)
    {
        if (excelFileUpload.HasFile)
        {
            HttpPostedFile file = excelFileUpload.PostedFile;

            if (file != null && file.ContentLength > 0)
            {
                bool useFirstRowAsColumnNames = true;

                string sheetName = fileSheetsDDL.SelectedValue;

                DataTable sourceDataTable = Crypt.Excel.GetSheetAsTable(file.InputStream, sheetName, useFirstRowAsColumnNames);

                uploadFileGridView.DataSource = sourceDataTable;
                uploadFileGridView.DataBind();
            }
        }
    }
    protected void confirmUploadButton_Click(object sender, EventArgs e)
    {
        if (uploadFileGridView.Rows.Count > 0)
        {
            int client_id = this.ClientObject.ClientID;

            for (int i = 0; i < uploadFileGridView.Rows.Count; i++)
            {
                CheckBox rowCheckBox = (CheckBox)uploadFileGridView.Rows[i].Cells[0].FindControl("rowCheckBox");
                Label resultUploadLabel = (Label)uploadFileGridView.Rows[i].Cells[1].FindControl("resultUploadLabel");

                if (rowCheckBox != null && rowCheckBox.Checked)
                {
                    string week = weeksDDL.SelectedValue;
                    string articolSTR = uploadFileGridView.Rows[i].Cells[2].Text;
                    string desenSTR = uploadFileGridView.Rows[i].Cells[3].Text;
                    string tipSTR = uploadFileGridView.Rows[i].Cells[4].Text;
                    string coloritSTR = uploadFileGridView.Rows[i].Cells[5].Text;
                    decimal latime = Crypt.Utils.MyDecimalParce(uploadFileGridView.Rows[i].Cells[6].Text);
                    decimal lungime = Crypt.Utils.MyDecimalParce(uploadFileGridView.Rows[i].Cells[7].Text);
                    decimal cantitate = Crypt.Utils.MyDecimalParce(uploadFileGridView.Rows[i].Cells[8].Text);

                    if(!week.Equals(string.Empty))
                    {
                        int productID = Utils.ModuleStore().DetectProduct(articolSTR, desenSTR, tipSTR, coloritSTR, latime, lungime);

                        if (productID != 0)
                        {
                            if (cantitate >= 0)
                            {
                                if (Utils.ModuleStore().UpdateVinzari(client_id, week, productID, cantitate))
                                {
                                    resultUploadLabel.Text = "OK.";
                                }
                                else
                                {
                                    resultUploadLabel.Text = "Error upload row." + Utils.ModuleStore().LastError;
                                }
                            }
                            else
                            {
                                resultUploadLabel.Text = "Quantity is not valid!";
                            }
                        }
                        else
                        {
                            resultUploadLabel.Text = "Product not found!";
                        }
                    }
                    else
                    {
                        resultUploadLabel.Text = "Week can not be empty!";
                    }
                }
            }
        }
    }

    protected void backButton_Click(object sender, EventArgs e)
    {
        ShowPanel(vinzariListPanel.ID);
    }

    protected void refreshButton_Click(object sender, ImageClickEventArgs e)
    {
        ShowPanel(vinzariListPanel.ID);
    }

    protected void customerSelectionControl_OnClientSelected(object sender, ClientSelectionControl.FilterWindowEventsArg e)
    {
        if (e.SelectedItem != 0)
        {
            DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(e.SelectedItem);
            this.ClientObject = clientObject;
            ShowPanel(vinzariListPanel.ID);
            Utils.GetMaster(this).AddNavlink("Vinzari pentru: " + clientObject.FirstName + " " + clientObject.LastName, appPath + "/ModuleStore/Vinzari.aspx?act=chooseclt", Utils.Customer_HotNavogateKey);
        }
    }
}