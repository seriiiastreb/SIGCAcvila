﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class StorePage : System.Web.UI.Page
{
    private readonly string mCurrentModule = Store.Module.ID;
    private readonly string mPageName = "Warehouse management page";
    string tempDirectory = System.Configuration.ConfigurationManager.AppSettings["TempDirectory"];
    static readonly string msDirectorySeparator = System.IO.Path.DirectorySeparatorChar.ToString();

    bool allowEdit = false;
    bool allowView = false;
    string appPath = string.Empty;
    
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
                if (Request["clt"] != null && !Request["clt"].ToString().Equals(string.Empty))
                {
                    int clID = 0;
                    int.TryParse(Request["clt"].ToString(), out clID);
                    if (clID != 0) Utils.SelectedSubClientID = clID;
                }    

                FillSheetsDDL();                   
                ShowPanel(StockListPanel.ID);                          
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
        StockListPanel.Visible = false;
        uploadFromFilePanel.Visible = false;

        switch (panelID)
        {
            case "StockListPanel":
                StockListPanel.Visible = true;
                FillStockGridView();
                break;

            case "uploadFromFilePanel":
                uploadFromFilePanel.Visible = true;
                break;
        }

    }

    protected void FillSheetsDDL()
    {
        DataTable weeksDT = Utils.ModuleStore().GetWeeksList();
        Utils.FillSelector(weeksDDL, weeksDT, "week", "week");
        Utils.FillSelector(generateCommandWeekDDL, weeksDT, "week", "week");


        List<string> InWaySource = new List<string>();
        InWaySource.Add("Stock");
        InWaySource.Add("Kanban");
        InWaySource.Add("Livrari");
        InWaySource.Add("In Way");
        destinationDDL.DataSource = InWaySource;
        destinationDDL.DataBind();


        List<string> sheets = new List<string>();
        sheets.Add("Sheet1");
        sheets.Add("Sheet2");
        sheets.Add("Sheet3");
        fileSheetsDDL.DataSource = sheets;
        fileSheetsDDL.DataBind();

        fileSheetsDDL.SelectedValue = "Sheet2";
    }

    protected void FillStockGridView()
    {
        DataTable dt = Utils.ModuleStore().GetStockList(Utils.SelectedClient.ClientID);
        StockListGridView.DataSource = dt;
        StockListGridView.DataBind();
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
            string destinationUpload = destinationDDL.SelectedValue;
            int client_id = Utils.SelectedClient.ClientID;

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
                    
                    if (!week.Equals(string.Empty))
                    {
                        int productID = Utils.ModuleStore().DetectProduct(articolSTR, desenSTR, tipSTR, coloritSTR, latime, lungime);

                        if (productID != 0)
                        {
                            if (cantitate >= 0)
                            {
                                bool resultUpload = false;

                                switch (destinationUpload)
                                {
                                    case "Stock":
                                        resultUpload = Utils.ModuleStore().UpdateStock(client_id, week, productID, cantitate);                                        
                                        break;

                                    case "Livrari":
                                        resultUpload = Utils.ModuleStore().UpdateLivrari(client_id, week, productID, cantitate);     
                                        break;

                                    case "Kanban":
                                        resultUpload = Utils.ModuleStore().UpdateKanban(productID, cantitate);                                        
                                        break;

                                    case "In Way":
                                        resultUpload = Utils.ModuleStore().UpdateManualInWay(client_id, week, productID, cantitate);                                          
                                        break;
                                }

                                if (resultUpload)
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
        ShowPanel(StockListPanel.ID);
    }

    protected void refreshButton_Click(object sender, ImageClickEventArgs e)
    {
        ShowPanel(StockListPanel.ID);
    }
    
    protected void createOrdersButton_Click(object sender, ImageClickEventArgs e)
    {
        string selectedWeek = generateCommandWeekDDL.SelectedValue;

        if (!string.IsNullOrEmpty(selectedWeek))
        {
            int client_id = Utils.SelectedClient.ClientID;

            DataTable comanda = Utils.ModuleStore().CreateNewOrder(client_id, selectedWeek);

            if (comanda != null && comanda.Rows.Count > 0)
            {
                comanda.Columns.Add("cantitate", typeof(decimal));

                for (int i = 0; i < comanda.Rows.Count; i++)
                {
                    int productID = (int)comanda.Rows[i]["product_id"];
                    decimal kanban = (decimal)comanda.Rows[i]["Kanban"];
                    decimal InWay = (decimal)comanda.Rows[i]["In Way"];
                    decimal StockInSelectedWeek = comanda.Rows[i][selectedWeek] != System.DBNull.Value ? (decimal)comanda.Rows[i][selectedWeek] : 0; 

                    decimal cantitate = kanban / 2 - StockInSelectedWeek - InWay;
                    comanda.Rows[i]["cantitate"] = cantitate > 0 ? Math.Ceiling(cantitate) : 0;                                     
                }
                Utils.ModuleStore().UpdateOrders(client_id, selectedWeek, comanda);  

                for (int i = 0; i < comanda.Columns.Count; i++)
                {
                    string colName = comanda.Columns[i].ColumnName;

                    if (!colName.Equals("Articol") && !colName.Equals("Desen") && !colName.Equals("Tip") && !colName.Equals("Colorit") && !colName.Equals("Latime") && !colName.Equals("Lungime") && !colName.Equals("cantitate"))
                    {
                        comanda.Columns.Remove(colName);
                        comanda.AcceptChanges();
                        i--;
                    }
                }              
                
                comanda.TableName = "Comanda " + selectedWeek;

                string documentName = "Comanda " + selectedWeek + ".xls";
                string fileNameFullPath = Server.MapPath("~/" + tempDirectory + msDirectorySeparator + documentName);

                Crypt.Excel.ExportDataTableToExcelUsingNPOI(null, comanda, fileNameFullPath, string.Empty, string.Empty, string.Empty, null, 0, null, true);

                byte[] fileInByte = System.IO.File.ReadAllBytes(fileNameFullPath);

                Utils.DownloadFile(fileInByte, this, documentName);
            }            
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Atentie", "Alegeti saptamina!");
        }

    }

    protected void StockListGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            for (int i = 3; i < e.Row.Cells.Count; i++)
            {
                double kanban = (double)Crypt.Utils.MyDecimalParce(e.Row.Cells[1].Text);
                decimal cantitatea = Crypt.Utils.MyDecimalParce(e.Row.Cells[i].Text);

                if (((double)cantitatea) < (kanban * 0.3) || cantitatea == 0) { e.Row.Cells[i].BackColor = System.Drawing.Color.Red; }
                if ((kanban * 0.3) <= ((double)cantitatea) && ((double)cantitatea) <= (kanban * 0.7)) { e.Row.Cells[i].BackColor = System.Drawing.Color.Yellow; }
                if (((double)cantitatea) > (kanban * 0.7)) { e.Row.Cells[i].BackColor = System.Drawing.Color.Green; }
            }
        }
    }

    //protected void customerSelectionControl_OnClientSelected(object sender, ClientSelectionControl.FilterWindowEventsArg e)
    //{
    //    if (e.SelectedItem != 0)
    //    {
    //        DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(e.SelectedItem);
    //        this.ClientObject = clientObject;
    //        ShowPanel(StockListPanel.ID);
    //        Utils.GetMaster(this).AddNavlink("Vinzari pentru: " + clientObject.FirstName + " " + clientObject.LastName, appPath + "/ModuleStore/StorePage.aspx?act=chooseclt", Utils.Customer_HotNavogateKey);
    //    }        
    //}
}