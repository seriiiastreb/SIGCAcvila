using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class StorePage : System.Web.UI.Page
{
    private readonly string mCurrentModule = Store.Module.ID;
    private readonly string mPageName = "Warehouse management page";

    bool allowEdit = false;
    bool allowView = false;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowEdit = Utils.PermissionAllowed(mCurrentModule, Store.Domains.WarehouseManagement.Name, Constants.Classifiers.Permissions_Edit);
        allowView = Utils.PermissionAllowed(mCurrentModule, Store.Domains.WarehouseManagement.Name, Constants.Classifiers.Permissions_View);

        try
        {
            if (allowView)
            {
                if (!IsPostBack)
                {
                    ShowPanel(stokListPanel.ID);
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
        stokListPanel.Visible = false;
        uploadFromFilePanel.Visible = false;


        switch (panelID)
        { 
            case "stokListPanel":
                stokListPanel.Visible = true;
                FillStokGridView();
                break;

            case "uploadFromFilePanel":
                uploadFromFilePanel.Visible = true;
                break;
        }

    }

    protected void FillStokGridView()
    {
        DataTable dt = Utils.ModuleStore().GetStokList();
        productsListGridView.DataSource = dt;
        productsListGridView.DataBind();
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

                DataTable sourceDataTable = Crypt.Excel.GetSheetAsTable(file.InputStream, sheetName ,useFirstRowAsColumnNames);
                DataTable transformedtable = TransformColumnsTable(sourceDataTable);

                uploadFileGridView.DataSource = transformedtable;
                uploadFileGridView.DataBind();
            }
        }
    }
    protected void confirmUploadButton_Click(object sender, EventArgs e)
    {

    }
}