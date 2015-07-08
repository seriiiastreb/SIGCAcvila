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
                if (!IsPostBack)
                {
                    FillAllComboBox();
                    FIllProductsGridView();
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
                                        orderMetrajTextBox.Text = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[11].Text;

                                        try { orderFestonareDDL.SelectedValue = productsListGridView.Rows[selectedIndexInProdusGrid].Cells[12].Text; }
                                        catch { }

                                        productPopupExtender.Show();
                                    }
                                    break;

                                case "delete":
                                    {
                                        int productID = 0;
                                        int.TryParse(productsListGridView.Rows[selectedIndexInProdusGrid].Cells[0].Text, out productID);

                                        if (Utils.ModuleStore().DeleteProduct(productID))
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



    
    protected void FillAllComboBox()
    {
        DataTable articolList = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.Articol);
        Utils.FillSelector(orderArticolDDL, articolList, "Name", "Code");

        DataTable desene = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.Desen);
        Utils.FillSelector(orderDesenDDL, desene, "Name", "Code");

        DataTable tips = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.Tip);
        Utils.FillSelector(orderTipDDL, tips, "Name", "Code");

        DataTable colorit = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.Colorit);
        Utils.FillSelector(orderColoritDDL, colorit, "Name", "Code");

        DataTable festonare = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.Festonare);
        Utils.FillSelector(orderFestonareDDL, festonare, "Name", "Code");
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

        try { orderFestonareDDL.SelectedIndex = 0; }
        catch { }
        orderLatimeTextBox.Text = string.Empty;
        orderLungimeTextBox.Text = string.Empty;
        orderMetrajTextBox.Text = string.Empty;
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
                decimal metraj = Crypt.Utils.MyDecimalParce(orderMetrajTextBox.Text);

                int festonare = 0;
                int.TryParse(orderFestonareDDL.SelectedValue, out festonare);

                if (isNewAction)
                {
                    resultAction = Utils.ModuleStore().AddProduct(articol, desen, tip, colorit, latime, lungime, metraj, festonare);
                }
                else
                {
                    resultAction = Utils.ModuleStore().UpdateProduct(productID, articol, desen, tip, colorit, latime, lungime, metraj, festonare);
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
        DataTable ordersList = Utils.ModuleStore().GetProductsList();
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

}