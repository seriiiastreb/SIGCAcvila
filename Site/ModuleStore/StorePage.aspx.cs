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


}