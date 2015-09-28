using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Produse : System.Web.UI.Page
{
    private readonly string mCurrentModule = Store.Module.ID;
    private readonly string mPageName = "Produse management page";

    bool allowEdit = false;
    bool allowView = false;

    string appPath = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
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

                if (!IsPostBack)
                { FillAllComboBox(); }

                ShowPanel(productsPanel.ID);


                if (!IsPostBack)
                {
                }
                else
                {
                    string eventSource = Request.Params.Get("__EVENTTARGET");
                    string eventArgument = Request.Params.Get("__EVENTARGUMENT");

                    int selectedIndexInProdusGrid = 0;
                    int.TryParse(selectedProductsListGridViewIndexHiddenField.Value, out selectedIndexInProdusGrid);
                    if (!selectedProductsListGridViewIndexHiddenField.Value.Equals(string.Empty)) productsListGridView.SelectedIndex = selectedIndexInProdusGrid;


                    switch (eventSource)
                    {
                        case "productsListGridViewClik":

                            switch (eventArgument)
                            {
                                case "add":
                                    {
                                        ClearProductsForm();
                                        productPopupExtender.Show();
                                    }
                                    break;

                                case "edit":
                                case "select":
                                    {
                                        ClearProductsForm();

                                        productActionHiddenField.Value = Crypt.Module.CreateEncodedString("Edit");
                                        productIDHiddenField.Value = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[0].Text;

                                        try { orderArticolDDL.SelectedValue = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[1].Text; }
                                        catch { }
                                        try { orderDesenDDL.SelectedValue = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[3].Text; }
                                        catch { }
                                        try { orderTipDDL.SelectedValue = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[5].Text; }
                                        catch { }
                                        try { orderColoritDDL.SelectedValue = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[7].Text; }
                                        catch { }

                                        orderLatimeTextBox.Text = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[9].Text;
                                        orderLungimeTextBox.Text = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[10].Text;

                                        productPopupExtender.Show();
                                    }
                                    break;

                                case "delete":
                                    {
                                        int productID = 0;
                                        int.TryParse(productsListGridView.Rows[selectedIndexInProdusGrid].Cells[0].Text, out productID);

                                        if (Utils.ModuleStore().DeleteProduct(Utils.SelectedClient.ClientID, productID))
                                        {
                                            FIllProductsGridView();
                                        }
                                        else
                                        {
                                            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The order was not deleted. Try again later.");
                                        }
                                    }
                                    break;
                            }

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

    protected void ShowPanel(string panelID)
    {
        productsPanel.Visible = false;
        uploadFromFilePanel.Visible = false;


        switch (panelID)
        {
            case "productsPanel":
                productsPanel.Visible = true;
                FIllProductsGridView();
                break;

            case "uploadFromFilePanel":
                FillSheetsDDL();
                uploadFromFilePanel.Visible = true;
                break;
        }
    }

    protected void FillSheetsDDL()
    {
        List<string> sheets = new List<string>();
        sheets.Add("Sheet1");
        sheets.Add("Sheet2");
        sheets.Add("Sheet3");
        fileSheetsDDL.DataSource = sheets;
        fileSheetsDDL.DataBind();

        fileSheetsDDL.SelectedValue = "Sheet1";
    }

    protected void FillAllComboBox()
    {
        DataTable articolList = Security.MainModule.GetClassifierByTypeID((int)Constants.ClassifierTypes.Articol);
        Utils.FillSelector(orderArticolDDL, articolList, "Name", "Code");

        DataTable desene = Security.MainModule.GetClassifierByTypeID((int)Constants.ClassifierTypes.Desen);
        Utils.FillSelector(orderDesenDDL, desene, "Name", "Code");

        DataTable tips = Security.MainModule.GetClassifierByTypeID((int)Constants.ClassifierTypes.Tip);
        Utils.FillSelector(orderTipDDL, tips, "Name", "Code");

        DataTable colorit = Security.MainModule.GetClassifierByTypeID((int)Constants.ClassifierTypes.Colorit);
        Utils.FillSelector(orderColoritDDL, colorit, "Name", "Code");
    }

    #region new orders

    private void ClearProductsForm()
    {
        productIDHiddenField.Value = string.Empty;
        productActionHiddenField.Value = Crypt.Module.CreateEncodedString("New");
        try { orderArticolDDL.SelectedIndex = 0; }
        catch { }
        try { orderDesenDDL.SelectedIndex = 0; }
        catch { }
        try { orderTipDDL.SelectedIndex = 0; }
        catch { }
        try { orderColoritDDL.SelectedIndex = 0; }
        catch { }

        orderLatimeTextBox.Text = string.Empty;
        orderLungimeTextBox.Text = string.Empty;
    }

    protected void saveProductDetailsButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            try
            {
                bool resultAction = false;
                bool isNewAction = Crypt.Module.DecodeCriptedString(productActionHiddenField.Value).Equals("New");

                int productID = 0;
                int.TryParse(productIDHiddenField.Value, out productID);

                int articol = 0;
                int.TryParse(orderArticolDDL.SelectedValue, out articol);

                int desen = 0;
                int.TryParse(orderDesenDDL.SelectedValue, out desen);

                int tip = 0;
                int.TryParse(orderTipDDL.SelectedValue, out tip);

                int colorit = 0;
                int.TryParse(orderColoritDDL.SelectedValue, out colorit);

                decimal latime = Crypt.Utils.MyDecimalParce(orderLatimeTextBox.Text);
                decimal lungime = Crypt.Utils.MyDecimalParce(orderLungimeTextBox.Text);

                string short_description = orderArticolDDL.SelectedItem.Text + " " + orderDesenDDL.SelectedItem.Text + " " + orderTipDDL.SelectedItem.Text + " " + orderColoritDDL.SelectedItem.Text + " " + latime.ToString() + "x" + lungime.ToString();

                if (isNewAction)
                {
                    resultAction = Utils.ModuleStore().AddProduct(Utils.SelectedClient.ClientID, articol, desen, tip, colorit, latime, lungime, short_description);
                }
                else
                {
                    resultAction = Utils.ModuleStore().UpdateProduct(Utils.SelectedClient.ClientID, productID, articol, desen, tip, colorit, latime, lungime, short_description);
                }


                if (resultAction)
                {
                    FIllProductsGridView();
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "Product was not saved. Try again later.");
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

    #endregion new orders

    protected void FIllProductsGridView()
    {
        DataTable ordersList = Utils.ModuleStore().GetProductsList(Utils.SelectedClient.ClientID);
        productsListGridView.DataSource = ordersList;
        productsListGridView.DataBind();
    }

    protected void productsListGridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(this.productsListGridView, "Select$" + e.Row.RowIndex);
        }
    }

    protected void refreshButton_Click(object sender, ImageClickEventArgs e)
    {
        FIllProductsGridView();
    }
    protected void backButton_Click(object sender, EventArgs e)
    {
        ShowPanel(productsPanel.ID);
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

    DataTable articolHashTable = new DataTable();
    DataTable desenHashTable = new DataTable();
    DataTable tipHashTable = new DataTable();
    DataTable coloritHashTable = new DataTable();

    protected void confirmUploadButton_Click(object sender, EventArgs e)
    {
        if (uploadFileGridView.Rows.Count > 0)
        {
            for (int i = 0; i < uploadFileGridView.Rows.Count; i++)
            {
                CheckBox rowCheckBox = (CheckBox)uploadFileGridView.Rows[i].Cells[0].FindControl("rowCheckBox");
                Label resultUploadLabel = (Label)uploadFileGridView.Rows[i].Cells[1].FindControl("resultUploadLabel");

                if (rowCheckBox != null && rowCheckBox.Checked)
                {
                    string articolSTR = uploadFileGridView.Rows[i].Cells[2].Text;
                    int articolInt = 0;

                    string desenSTR = uploadFileGridView.Rows[i].Cells[3].Text;
                    int desenINT = 0;

                    string tipSTR = uploadFileGridView.Rows[i].Cells[4].Text;
                    int tipInt = 0;

                    string coloritSTR = uploadFileGridView.Rows[i].Cells[5].Text;
                    int coloritINt = 0;

                    decimal latime = Crypt.Utils.MyDecimalParce(uploadFileGridView.Rows[i].Cells[6].Text);
                    decimal lungime = Crypt.Utils.MyDecimalParce(uploadFileGridView.Rows[i].Cells[7].Text);

                    string short_description = articolSTR + " " + desenSTR + " " + tipSTR + " " + coloritSTR + " " + latime.ToString() + "x" + lungime.ToString();

                    if (!articolHashTable.Columns.Contains(articolSTR))
                    {
                        if (articolHashTable.Rows.Count == 0) articolHashTable.Rows.Add();

                        articolInt = Utils.ModuleMain().GetClassifierCodeByName(articolSTR, (int)Constants.ClassifierTypes.Articol);
                        if (articolInt == 0)
                        {
                            articolInt = Utils.ModuleMain().NewClassifier((int)Constants.ClassifierTypes.Articol, articolSTR);
                        }

                        articolHashTable.Columns.Add(articolSTR, typeof(int));
                        articolHashTable.Rows[0][articolSTR] = articolInt;
                    }
                    else
                    {
                        articolInt = (int)articolHashTable.Rows[0][articolSTR];
                    }

                    if (!desenHashTable.Columns.Contains(desenSTR))
                    {
                        if (desenHashTable.Rows.Count == 0) desenHashTable.Rows.Add();

                        desenINT = Utils.ModuleMain().GetClassifierCodeByName(desenSTR, (int)Constants.ClassifierTypes.Desen);
                        if (desenINT == 0)
                        {
                            desenINT = Utils.ModuleMain().NewClassifier((int)Constants.ClassifierTypes.Desen, desenSTR);
                        }
                        desenHashTable.Columns.Add(desenSTR, typeof(int));
                        desenHashTable.Rows[0][desenSTR] = desenINT;
                    }
                    else
                    {
                        desenINT = (int)desenHashTable.Rows[0][desenSTR];
                    }

                    if (!tipHashTable.Columns.Contains(tipSTR))
                    {
                        if (tipHashTable.Rows.Count == 0) tipHashTable.Rows.Add();

                        tipInt = Utils.ModuleMain().GetClassifierCodeByName(tipSTR, (int)Constants.ClassifierTypes.Tip);
                        if (tipInt == 0)
                        {
                            tipInt = Utils.ModuleMain().NewClassifier((int)Constants.ClassifierTypes.Tip, tipSTR);
                        }
                        tipHashTable.Columns.Add(tipSTR, typeof(int));
                        tipHashTable.Rows[0][tipSTR] = tipInt;
                    }
                    else
                    {
                        tipInt = (int)tipHashTable.Rows[0][tipSTR];
                    }

                    if (!coloritHashTable.Columns.Contains(coloritSTR))
                    {
                        if (coloritHashTable.Rows.Count == 0) coloritHashTable.Rows.Add();

                        coloritINt = Utils.ModuleMain().GetClassifierCodeByName(coloritSTR, (int)Constants.ClassifierTypes.Colorit);
                        if (coloritINt == 0)
                        {
                            coloritINt = Utils.ModuleMain().NewClassifier((int)Constants.ClassifierTypes.Colorit, coloritSTR);
                        }
                        coloritHashTable.Columns.Add(coloritSTR, typeof(int));
                        coloritHashTable.Rows[0][coloritSTR] = coloritINt;
                    }
                    else
                    {
                        coloritINt = (int)coloritHashTable.Rows[0][coloritSTR];
                    }

                    if (Utils.ModuleStore().DetectProduct(articolSTR, desenSTR, tipSTR, coloritSTR, latime, lungime) == 0)
                    {
                        if (Utils.ModuleStore().AddProduct(Utils.SelectedClient.ClientID, articolInt, desenINT, tipInt, coloritINt, latime, lungime, short_description))
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
                        resultUploadLabel.Text = "Productul deja exista!";
                    }
                }
            }
        }
    }

    protected void uploadFromFileButton_Click(object sender, ImageClickEventArgs e)
    {
        ShowPanel(uploadFromFilePanel.ID);
    }
}