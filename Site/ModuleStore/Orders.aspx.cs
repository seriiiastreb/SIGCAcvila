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
                if (Request["clt"] != null && !Request["clt"].ToString().Equals(string.Empty))
                {
                    int clID = 0;
                    int.TryParse(Request["clt"].ToString(), out clID);
                    if (clID != 0) Utils.SelectedSubClientID = clID;
                }

                ShowPanel(ordersPanel.ID);
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
        DataTable ordersList = Utils.ModuleStore().GetOrdersHistory(Utils.ClientObject.ClientID);

        ordersListGridView.DataSource = ordersList;
        ordersListGridView.DataBind();
    }
     
}