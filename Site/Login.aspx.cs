using System;
using System.Configuration;
using System.Data;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    #region Logger Setup
    protected static readonly log4net.ILog msLogger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
    #endregion Logger Setup

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
                    Session[Utils.SessionKey_UserObject] = null;
                    Session[Utils.SessionKey_ModuleSecurity] = null;
                    Session[Utils.SessionKey_ModuleMain] = null;

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
                    msLogger.Info("Login success. " + username + " from " + userIP);
                    //Session[Constants.GlobalSessionKey_CurrentLanguage] = languageDropDownList.SelectedValue;
                    FormsAuthentication.RedirectFromLoginPage(username, false);
                }
                else
                {
                    Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", "Login failed. Incorrect user name or password.");
                    msLogger.Info("Login failed. " + username + " from " + userIP);
                }
            }
            else
            {
                Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", "Sorry. This site is closed for maintenance. Please check back soon.");
                msLogger.Warn("Login attempt while site closed for maintenance." + username + " from " + userIP);
            }
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage((int)Constants.InfoBoxMessageType.Error, "Error on page.", ex.Message);
            msLogger.Fatal(ex.Message + userIP);
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

        msLogger.Info("Login attempt.  " + userObject.UserLogin + " - UserObject created. Creating modules...");
        
        CreateModulesByRole(userObject);

        result = true;

        return result;
    }

    private void CreateModulesByRole(Security.User userObject)
    {
        string appPath = Utils.GetApplicationPath(Request);

        Session[Utils.SessionKey_UserObject] = userObject;

        bool allowBasicAdministration = Utils.PermissionAllowed(Security.MainModule.ID, Security.Domains.BasicProgramAdministration.Name, Constants.Classifiers.Permissions_View);
        bool allowUserManagement = Utils.PermissionAllowed(Security.Module.ID, Security.Domains.Administration.Name, Constants.Classifiers.Permissions_View);
        bool allowCustomersModule = Utils.PermissionAllowed(Client.Module.ID, Security.Domains.Administration.Name, Constants.Classifiers.Permissions_View);

        if (allowUserManagement) Session[Utils.SessionKey_ModuleSecurity] = new Security.Module();
        if (allowBasicAdministration) Session[Utils.SessionKey_ModuleMain] = new Security.MainModule();
        if (allowCustomersModule) Session[Utils.SessionKey_ModuleCustomers] = new Client.Module();

        ////  Generate ModulesLiks
        string modulesLiks = string.Empty;

        modulesLiks += " <a href=\"" + appPath + "/Default.aspx\">  <img id=\"Img1\" width=\"24\" height=\"24\" alt=\"Start page\" title=\"Start page\" src=\"" + appPath + "/Images/home.png\" style=\" cursor:pointer; \"> </a> ";
        
        if (allowBasicAdministration) modulesLiks += " <a href=\"" + appPath + "/ModuleMain/Classifiers.aspx\">  <img id=\"Img2\" width=\"24\" height=\"24\" alt=\"Basic Program administration\" title=\"Basic Program administration\" src=\"" + appPath + "/Images/admin.png\" style=\" cursor:pointer; \"> </a> ";
        if (allowCustomersModule) modulesLiks += " <a href=\"" + appPath + "/ModuleCustomers/Customers.aspx\">  <img id=\"Img3\" width=\"24\" height=\"24\" alt=\"Customers page\" title=\"Customers page\" src=\"" + appPath + "/Images/man.png\" style=\" cursor:pointer; \"> </a> ";
        
        Session[Utils.SessionKey_HeadModuleSlector] = modulesLiks;



        //<%--<li>
            //            <a href="../12/">Fluid 12-column</a>
            //            <ul>
            //                <li>
            //                    <a href="../12/fluid/mootools/">MooTools</a>
            //                </li>
            //                <li>
            //                    <a href="../12/fluid/jquery/">jQuery</a>
            //                </li>
            //                <li>
            //                    <a href="../12/fluid/none/">No Javascript</a>
            //                </li>
            //            </ul>
            //        </li>--%>

        ////  Generate Menus for each module

        #region Main AND SECURITY MODULE

        string mainModuleMenuLinks = string.Empty;

       
        if (allowBasicAdministration) mainModuleMenuLinks  += "<li>  <a href=\"" + appPath + "/ModuleMain/Classifiers.aspx\">Classifiers Management</a> </li> ";
        if (allowUserManagement) mainModuleMenuLinks += "<li>  <a href=\"" + appPath + "/ModuleMain/SystemSeqAdmin.aspx\">User Management</a> </li> ";

        Session[Utils.SessionKey_ModuleMainNavigateMenu] = mainModuleMenuLinks;

        #endregion Main AND SECURITY MODULE


        #region Customers MODULE         
        string customersModuleMenuLinks = string.Empty;

        if (allowCustomersModule) customersModuleMenuLinks += "<li>  <a href=\"" + appPath + "/ModuleCustomers/Customer.aspx\">Customers</a> </li> ";

        Session[Utils.SessionKey_ModuleCustomers] = customersModuleMenuLinks;

        #endregion Customers MODULE                 

    }

}