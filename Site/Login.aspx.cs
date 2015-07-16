﻿using System;
using System.Configuration;
using System.Data;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void ClearSessionObject()
    {
        Session[Utils.SessionKey_UserObject] = null;
        Session[Utils.SessionKey_ModuleSecurity] = null;
        Session[Utils.SessionKey_ModuleMain] = null;
        Session[Utils.SessionKey_ModuleCustomers] = null;
        Session[Utils.SessionKey_ModuleStore] = null;
        Session[Utils.SessionKey_HeadModuleSlector] = null;
        Session[Utils.SessionKey_ClientObject] = null;
        Session[Utils.SessionKey_OrderObject] = null;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Utils.RedirectIfSslRequired(Request, Response);

        //if (!IsPostBack && languageDropDownList.DataSource == null) FillLanguageDropDownList();

        if (Request["action"] != null)
        {
            string action = Request["action"].ToString();

            switch (action)
            {
                case "logout":
                    ClearSessionObject();
                    break;

                default:
                    break;
            }
        }

        if (!MaintenanceMode())
        {
            // If already logged in
            Security.User userObject = (Security.User)Session[Utils.SessionKey_UserObject];
            string userName = string.Empty;

            if (userObject != null)
            {
                userName = userObject.UserLogin;                

                // if user is active 
                if (userName != string.Empty)
                {
                    FormsAuthentication.RedirectFromLoginPage(userName, false);
                }
            }
        }
        else
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Info, "Sorry.....", "This site is closed for maintenance. Please check back soon.");
        }
    }

    private bool MaintenanceMode()
    {
        bool maintenanceModeActive = true;
        bool.TryParse(ConfigurationManager.AppSettings["maintenanceMode"], out maintenanceModeActive);

        return maintenanceModeActive;
    }

    protected void loginButton_Click(object sender, EventArgs e)
    {
        string userIP = " IP:" + Request.UserHostAddress;
        try
        {
            string username = userNameTextBox.Text.Trim();
            string password = passwordTextBox.Text;

            string bypassers = ConfigurationManager.AppSettings["allowBypassMaintenanceMode"];

            if (!MaintenanceMode() || bypassers.Contains(username))
            {
                if (Authenticate(username, password))
                {
                    Logger.WriteInfo("Login success. " + username + " from " + userIP);
                    //Session[Constants.GlobalSessionKey_CurrentLanguage] = languageDropDownList.SelectedValue;
                    FormsAuthentication.RedirectFromLoginPage(username, false);
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", "Login failed. Incorrect user name or password.");
                    Logger.WriteInfo("Login failed. " + username + " from " + userIP);
                }
            }
            else
            {
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", "Sorry. This site is closed for maintenance. Please check back soon.");
                Logger.WriteWarning("Login attempt while site closed for maintenance." + username + " from " + userIP);
            }
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", ex.Message);
            Logger.WriteError(ex.Message + userIP);
        }
    }

    private bool Authenticate(string login, string password)
    {
        bool result = false;

        if (Session[Utils.SessionKey_UserObject] != null) Session[Utils.SessionKey_UserObject] = null;

        if (login.Contains("'") || login.Contains(" ") || password.Contains("'") || password.Contains(" "))
        {
            throw new Exception("Invalid characters in login or password");
        }

        Security.User userObject = Security.User.Login(login, password);
        if (userObject == null) throw new Exception("Null user object received");

        Logger.WriteInfo("Login attempt.  " + userObject.UserLogin + " - UserObject created. Creating modules...");

        ClearSessionObject();

        CreateModulesByRole(userObject);

        result = true;

        return result;
    }

    private void CreateModulesByRole(Security.User userObject)
    {
        string appPath = Utils.GetApplicationPath(Request);

        Session[Utils.SessionKey_UserObject] = userObject;

        bool allowBasicAdministration = Utils.PermissionAllowed(Security.MainModule.ID, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_View);
        bool allowUserManagement = Utils.PermissionAllowed(Security.Module.ID, Security.Domains.SecurityAdministration.Name, Constants.Classifiers.Permissions_View);
        bool allowCustomersModule = Utils.PermissionAllowed(Client.Module.ID, Client.Domains.CustomersPersonalData.Name, Constants.Classifiers.Permissions_View);
        bool allowCustomersOrdersModule = Utils.PermissionAllowed(Client.Module.ID, Client.Domains.CustomersOrders.Name, Constants.Classifiers.Permissions_View);

        bool allowModuleStore = Utils.PermissionAllowed(Store.Module.ID, Store.Domains.WarehouseManagement.Name, Constants.Classifiers.Permissions_View);

        if (allowBasicAdministration) Session[Utils.SessionKey_ModuleMain] = new Security.MainModule();
        if (allowUserManagement) Session[Utils.SessionKey_ModuleSecurity] = new Security.Module();
        if (allowCustomersModule || allowCustomersOrdersModule) Session[Utils.SessionKey_ModuleCustomers] = new Client.Module();
        if (allowModuleStore) Session[Utils.SessionKey_ModuleStore] = new Store.Module();


        ////  Generate ModulesLiks
        string modulesMenu = string.Empty;

        modulesMenu += " <li> <a href=\"" + appPath + "/Default.aspx\">  <img id=\"Img1\" width=\"24\" height=\"24\" alt=\"Start page\" title=\"Start page\" src=\"" + appPath + "/Images/home.png\" style=\" cursor:pointer; \"> </a> </li>  \r\n ";

        if (allowCustomersModule)
        {
            modulesMenu += " <li> <a href=\"" + appPath + "/ModuleCustomers/Customers.aspx\">  <img id=\"Img3\" width=\"24\" height=\"24\" alt=\"Customers page\" title=\"Customers page\" src=\"" + appPath + "/Images/man.png\" style=\" cursor:pointer; \"> </a> </li>\r\n ";
        }

        if(allowCustomersOrdersModule)
        {
            modulesMenu += " <li> <a href=\"" + appPath + "/ModuleStore/Orders.aspx\">  <img id=\"Img5\" width=\"24\" height=\"24\" alt=\"Customer orders page\" title=\"Customer orders page\" src=\"" + appPath + "/Images/order.png\" style=\" cursor:pointer; \"> </a> </li>\r\n ";
        }

        if (allowModuleStore)
        {
            modulesMenu += "<li> \r\n";
            modulesMenu += "<a>  <img id=\"Img6\" width=\"24\" height=\"24\" alt=\"Warehouse management page\" title=\"Warehouse management page\" src=\"" + appPath + "/Images/shopping_cart.png\" style=\" cursor:pointer; \"> </a> \r\n ";
            modulesMenu += " <ul>  \r\n ";
            modulesMenu += "     <li>  <a href=\"" + appPath + "/ModuleStore/StorePage.aspx\"> Stok</a> </li> \r\n ";
            modulesMenu += "     <li>  <a href=\"" + appPath + "/ModuleStore/Produse.aspx\"> Products </a> </li> \r\n ";
            modulesMenu += "     <li>  <a href=\"" + appPath + "/ModuleStore/Vinzari.aspx\"> Vinzari </a> </li> \r\n ";
            modulesMenu += " </ul>  \r\n ";
            modulesMenu += "</li>\r\n ";


           //modulesMenu += " <li> <a href=\"" + appPath + "/ModuleStore/StorePage.aspx\">  <img id=\"Img6\" width=\"24\" height=\"24\" alt=\"Warehouse management page\" title=\"Warehouse management page\" src=\"" + appPath + "/Images/shopping_cart.png\" style=\" cursor:pointer; \"> </a> </li>\r\n ";
        }



        if (allowBasicAdministration)
        {
            modulesMenu += "<li> \r\n";
            modulesMenu += "<a href='#'> <img id=\"Img2\" width=\"24\" height=\"24\" alt=\"Basic Program administration\" title=\"Basic Program administration\" src=\"" + appPath + "/Images/admin.png\" style=\" cursor:pointer; \"> </a> \r\n ";
            modulesMenu += " <ul>  \r\n ";
            modulesMenu += "     <li>  <a href=\"" + appPath + "/ModuleMain/Classifiers.aspx\">Classifiers Management</a> </li> \r\n ";

            if (allowUserManagement) 
                modulesMenu += "    <li>  <a href=\"" + appPath + "/ModuleMain/SystemSeqAdmin.aspx\">User Management</a> </li> \r\n ";
            modulesMenu += " </ul>  \r\n ";
            modulesMenu += "</li>\r\n ";
        }     
        
        Session[Utils.SessionKey_HeadModuleSlector] = modulesMenu;
    }

}