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

    string appPath = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.GetMaster(this).PerformPreloadActions(mCurrentModule, mPageName);

        allowEdit = Utils.PermissionAllowed(mCurrentModule, Security.Domains.Administration.Name, Constants.Classifiers.Permissions_Edit);
        allowView = Utils.PermissionAllowed(mCurrentModule, Security.Domains.Administration.Name, Constants.Classifiers.Permissions_View);

        try
        {
            appPath = Utils.GetApplicationPath(Request); 

            if (allowView)
            {
                if (!IsPostBack)
                {
                    husbandClientSelectionControl.Show();
                    //Utils.GetMaster(this).AddNavlink("Customers", appPath+  "/ModuleCustomers/Orders.aspx", "OrdersPageID");

                    //FillAllComboBox();
                }
                else
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




    //private void ShowPanel(string panelName)
    //{
    //    #region Hide panels
    //    clientSelectionPanel.Visible = false;
    //    clientWorkPanel.Visible = false;
    //    #endregion Hide panels

    //    try
    //    {
    ////        #region Get Panel Name

    ////        switch (panelName)
    ////        {
    ////            case "clientSelectionPanel":
    ////                clientSelectionPanel.Visible = true;
    ////                FillClientSelectionGrid();
    ////                break;

    ////            case "clientWorkPanel":
    ////                DataObjects.Client client = this.ClientObject;
    ////                FillClientAllForms(client);

    ////                clientWorkPanel.Visible = true;

    ////                break;
    ////        }

    ////        #endregion Get Panel Name
    //    }
    //    catch (Exception ex)
    //    { Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Attention! Error in system!", ex.Message); }
    //}

    protected void FillAllComboBox()
    {
       
    }





}