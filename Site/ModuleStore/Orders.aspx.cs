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
                if (!IsPostBack)
                {
                    FIllOrdersGridView();
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
    
   
    protected void FIllOrdersGridView()
    {
        DataTable ordersList = Utils.ModuleStore().GetOrdersHistory();

        ordersListGridView.DataSource = ordersList;
        ordersListGridView.DataBind();
    }    
}