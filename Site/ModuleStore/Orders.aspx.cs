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

    //DataObjects.Order OrderObject
    //{
    //    get { return Session[Utils.SessionKey_OrderObject] != null ? (DataObjects.Order)Session[Utils.SessionKey_OrderObject] : new DataObjects.Order(); }
    //    set { Session[Utils.SessionKey_OrderObject] = value; }
    //}

    DataObjects.Client ClientObject
    {
        get { return Session[Utils.SessionKey_ClientObject] != null ? (DataObjects.Client)Session[Utils.SessionKey_ClientObject] : new DataObjects.Client(); }
        set { Session[Utils.SessionKey_ClientObject] = value; }
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
        ordersPanel.Visible = false;

        switch (panelID)
        {
            case "ordersPanel":
                ordersPanel.Visible = true;
                FIllOrdersGridView();
                break;
        }
    }
   
    protected void FIllOrdersGridView()
    {
        DataTable ordersList = Utils.ModuleStore().GetOrdersHistory(this.ClientObject.ClientID);

        ordersListGridView.DataSource = ordersList;
        ordersListGridView.DataBind();
    }


    protected void customerSelectionControl_OnClientSelected(object sender, ClientSelectionControl.FilterWindowEventsArg e)
    {
        if (e.SelectedItem != 0)
        {
            DataObjects.Client clientObject = Utils.ModuleCustomers().GetCleintObjectByID(e.SelectedItem);
            this.ClientObject = clientObject;
            ShowPanel(ordersPanel.ID);
            Utils.GetMaster(this).AddNavlink("Vinzari pentru: " + clientObject.FirstName + " " + clientObject.LastName, appPath + "/ModuleStore/Orders.aspx?act=chooseclt", Utils.Customer_HotNavogateKey);
        }
    }
}