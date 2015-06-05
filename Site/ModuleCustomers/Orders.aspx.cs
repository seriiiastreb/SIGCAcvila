using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Orders : System.Web.UI.Page
{
    private readonly string mCurrentModule = Client.Module.ID;
    private readonly string mPageName = "Customers orders administration";

    bool allowEdit = false;
    bool allowView = false;

    DataObjects.Client ClientObject
    {
        get { return Session[Utils.SessionKey_ClientObject] != null ? (DataObjects.Client)Session[Utils.SessionKey_ClientObject] : new DataObjects.Client(); }
        set { Session[Utils.SessionKey_ClientObject] = value; }
    }

    DataObjects.Order OrderObject
    {
        get { return Session[Utils.SessionKey_OrderObject] != null ? (DataObjects.Order)Session[Utils.SessionKey_OrderObject] : new DataObjects.Order(); }
        set { Session[Utils.SessionKey_OrderObject] = value; }
    }

    string appPath = string.Empty;


    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowEdit = Utils.PermissionAllowed(mCurrentModule, Client.Domains.CustomersOrders.Name, Constants.Classifiers.Permissions_Edit);
        allowView = Utils.PermissionAllowed(mCurrentModule, Client.Domains.CustomersOrders.Name, Constants.Classifiers.Permissions_View);

        try
        {
            appPath = Utils.GetApplicationPath(Request); 

            if (allowView)
            {
                newOrderDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;
                orderDateCalendarExtender.Format = Constants.ISODateBackwardDotsFormat;

                if (!IsPostBack)
                {
                    FillAllComboBox();
                    
                    if (this.ClientObject == null || this.ClientObject.ClientID == 0)
                    {
                        customerSelectionControl.Show();
                    }
                    else
                    {
                        FIllOrdersGridView();
                    }                
                }
                else
                {
                    string eventSource = Request.Params.Get("__EVENTTARGET");
                    string eventArgument = Request.Params.Get("__EVENTARGUMENT");

                    int selectedIndexInOrdersGrid = 0;
                    int.TryParse(selectedOrdersListGridViewIndexHiddenField.Value, out selectedIndexInOrdersGrid);
                    if (!selectedOrdersListGridViewIndexHiddenField.Value.Equals(string.Empty)) ordersListGridView.SelectedIndex = selectedIndexInOrdersGrid;
               

                    switch (eventSource)
                    {
                        case "ordersListGridViewClik":

                            #region Orders Grid enents
                            switch (eventArgument)
                            {
                                case "add":
                                    {
                                        ClearNewOrderForm();
                                        newOrderPopupExtender.Show();
                                    }
                                    break;

                                case "edit":
                                case "select":
                                    {
                                        ClearOrderDetailsForm();

                                        int orderID = 0;
                                        int.TryParse(ordersListGridView.Rows[selectedIndexInOrdersGrid].Cells[0].Text, out orderID);

                                        DataObjects.Order orderObject = Utils.ModuleCustomers().GetOrderObjectByID(orderID);
                                        this.OrderObject = orderObject;

                                        FillMainordersForm(orderObject);
                                    }
                                    break;

                                case "delete":
                                    {
                                        int orderID = 0;
                                        int.TryParse(ordersListGridView.Rows[selectedIndexInOrdersGrid].Cells[0].Text, out orderID);

                                        if (Utils.ModuleCustomers().DeleteClientOrder(orderID))
                                        {
                                            FIllOrdersGridView();
                                        }
                                        else
                                        {
                                            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "The order was not deleted. Try again later.");
                                        }
                                    }
                                    break;
                            }
                            #endregion Orders Grid enents

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
        DataTable orderState = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.OrderSate);
        Utils.FillSelector(newOrderStateDDL, orderState, "Name", "Code");
        Utils.FillSelector(orderStateDDL, orderState, "Name", "Code");

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

    protected void customerSelectionControl_ClientSelected(object sender, ClientSelectionControl.FilterWindowEventsArg e)
    {
        if (e.SelectedItem != 0)
        {
            DataObjects.Client clienObject = Utils.ModuleCustomers().GetCleintObjectByID(e.SelectedItem );

            this.ClientObject = clienObject;

            Utils.GetMaster(this).ClearNavLinks();

            Utils.GetMaster(this).AddNavlink("Customers", appPath + "/ModuleCustomers/Customers.aspx", Utils.CustomerPage_HotNavogateKey);
            Utils.GetMaster(this).AddNavlink(clienObject.FirstName + " " + clienObject.LastName, appPath + "/ModuleCustomers/Customers.aspx?clid=" + clienObject.ClientID, Utils.Customer_HotNavogateKey);
            
            FIllOrdersGridView();
        }
    }

    #region new orders

    private void ClearNewOrderForm()
    {
        DataObjects.Client clientObject = this.ClientObject;
        string part2Descr = clientObject != null && clientObject.Gender == (int)Constants.Classifiers.ClientType_PersoanaFizica ? clientObject.LastName + " (" + clientObject.BirthDate.ToString(Constants.ISODateBackwardDotsFormat) + ")" : string.Empty;

        newOrderClientInfoTextBox.Text = clientObject != null ? clientObject.FirstName + " " + part2Descr  : string.Empty;
        newOrderDateTextBox.Text = string.Empty;

        try
        { newOrderStateDDL.SelectedValue = ((int)Constants.Classifiers.OrderState_Solicitat).ToString(); }
        catch { }

        newOrderMetrajTextBox.Text = string.Empty;
        newOrderBucatiTextBox.Text = string.Empty;
    }

    protected void newOrderSaveBurtton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            try
            {
                bool resultAction = false;

                DataObjects.Order orderObject = new DataObjects.Order();

                int state = 0;
                int.TryParse(newOrderStateDDL.SelectedValue, out state);
                orderObject.State = state;

                orderObject.Date = Crypt.Utils.ToDateTime(newOrderDateTextBox.Text, Constants.ISODateBackwardDotsFormat);
                orderObject.Client_ID = this.ClientObject.ClientID;
                orderObject.Metraj = Crypt.Utils.MyDecimalParce(newOrderMetrajTextBox.Text);

                int bucati = 0;
                int.TryParse(newOrderBucatiTextBox.Text, out bucati);
                orderObject.Bucati = bucati;              

                if (resultAction = Utils.ModuleCustomers().AddClientOrder(orderObject))
                {
                    FIllOrdersGridView();                   
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "Order was not saved. Try again later.");
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


    protected void FIllOrdersGridView()
    {
        DataObjects.Client client = this.ClientObject;

        DataTable ordersList = null;

        if (client != null)
            ordersList = Utils.ModuleCustomers().GetClientOrdersList(client.ClientID);

        ordersListGridView.DataSource = ordersList;
        ordersListGridView.DataBind();
    }

    protected void ordersListGridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        { e.Row.TableSection = TableRowSection.TableHeader; }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        }
    }

    protected void ClearOrderDetailsForm()
    {
        ordersWorkPanel.Visible = false;

        try
        { orderStateDDL.SelectedValue = ((int)Constants.Classifiers.OrderState_Solicitat).ToString(); }
        catch { }

        orderDateTextBox.Text = string.Empty;
        orderSolicitantDescriptionTextBox.Text = string.Empty;
        orderNrTextBox.Text = string.Empty;

        try
        { orderArticolDDL.SelectedIndex = -1; }
        catch { }

        try
        { orderTipDDL.SelectedIndex = -1; }
        catch { }

        try
        { orderColoritDDL.SelectedIndex = -1; }
        catch { }

        orderLatimeTextBox.Text = string.Empty;
        orderLungimeTextBox.Text = string.Empty;
        orderBucatiTextBox.Text = string.Empty;
        orderMetrajTextBox.Text = string.Empty;

        try
        { orderFestonareDDL.SelectedIndex = -1; }
        catch { }

        orderEAN13TextBox.Text = string.Empty;
    }

    protected void saveOrderDetailsButton_Click(object sender, EventArgs e)
    {
        if (allowEdit)
        {
            try
            {
                bool resultAction = false;

                DataObjects.Order orderObject = this.OrderObject;

                int orderState = 0;
                int.TryParse(orderStateDDL.SelectedValue, out orderState);
                orderObject.State = orderState;

                orderObject.Date = Crypt.Utils.ToDateTime(orderDateTextBox.Text, Constants.ISODateBackwardDotsFormat);

                int nr = 0;
                int.TryParse(orderNrTextBox.Text.Trim(), out nr);
                orderObject.State = orderState;

                orderObject.Nr = nr;
                
                int articol = 0;
                int.TryParse(orderArticolDDL.SelectedValue, out articol);
                orderObject.Articol = articol;

                int tip = 0;
                int.TryParse(orderTipDDL.SelectedValue, out tip);
                orderObject.Tip = tip;

                int colorit = 0;
                int.TryParse(orderColoritDDL.SelectedValue, out colorit);
                orderObject.Colorit = colorit;

                orderObject.Latime = Crypt.Utils.MyDecimalParce(orderLatimeTextBox.Text);
                orderObject.Lungime = Crypt.Utils.MyDecimalParce(orderLungimeTextBox.Text);

                int bucati = 0;
                int.TryParse(orderBucatiTextBox.Text, out bucati);
                orderObject.Bucati = bucati;            

                orderObject.Metraj = Crypt.Utils.MyDecimalParce(orderMetrajTextBox.Text);
    
                int festonare = 0;
                int.TryParse(orderFestonareDDL.SelectedValue, out festonare);
                orderObject.Festonare = festonare;

                orderObject.EAN13 =  orderEAN13TextBox.Text.Trim();

                if (orderObject.Order_ID == 0)
                {
                    resultAction = Utils.ModuleCustomers().AddClientOrder(orderObject);
                }
                else
                {
                    resultAction = Utils.ModuleCustomers().UpdateClientOrder(orderObject);
                }

                if (resultAction)
                {
                    FIllOrdersGridView();
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Warning, "Attention!", "Order was not saved. Try again later.");
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


    private void FillMainordersForm(DataObjects.Order orderObject)
    {
        if (orderObject != null)
        {
            ordersWorkPanel.Visible = true;

            try
            { orderStateDDL.SelectedValue = orderObject.State.ToString(); }
            catch { }

            orderDateTextBox.Text = orderObject.Date.ToString(Constants.ISODateBackwardDotsFormat);
            orderSolicitantDescriptionTextBox.Text = orderObject.ClientDescription;
            orderNrTextBox.Text = orderObject.Nr.ToString();

            try
            { orderArticolDDL.SelectedValue = orderObject.Articol.ToString(); }
            catch { }

            try
            { orderTipDDL.SelectedValue = orderObject.Tip.ToString(); }
            catch { }

            try
            { orderColoritDDL.SelectedValue = orderObject.Colorit.ToString(); }
            catch { }

            orderLatimeTextBox.Text = orderObject.Latime.ToString();
            orderLungimeTextBox.Text = orderObject.Lungime.ToString();
            orderBucatiTextBox.Text = orderObject.Bucati.ToString();
            orderMetrajTextBox.Text = orderObject.Metraj.ToString();

            try
            { orderFestonareDDL.SelectedValue = orderObject.Festonare.ToString(); }
            catch { }

            orderEAN13TextBox.Text = orderObject.EAN13;

            Utils.GetMaster(this).AddNavlink("Order Nr:" + orderObject.Nr, appPath + "/ModuleCustomers/Orders.aspx?ord=" + orderObject.Order_ID, Utils.Orders_HotNavogateKey);

        }
    }


   
}