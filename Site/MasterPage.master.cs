using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

public partial class MasterPage : System.Web.UI.MasterPage, IMasterItems
{
    string mCurrentModule = string.Empty;

    void IMasterItems.ShowMessage(int messageType, string messageTitle, string message)
    {
        InfoWindow infoBox = (InfoWindow)mainDIV.FindControl("InfoBox");
        if (infoBox == null)
        {
            infoBox = (InfoWindow)LoadControl("~/Controls/InfoWindow.ascx");
        }

        infoBox.ID = "InfoBox";
        infoBox.MessageType = messageType;
        infoBox.WindowTitle = messageTitle;
        infoBox.Message = message;

        mainDIV.Controls.Add(infoBox);
        infoBox.Show();
    }

    protected void Page_Load(object sender, EventArgs e)
    {      
    }

    void IMasterItems.PerformPreloadActions(string currentModuleId, string pageName)
    {   
        bool isAutentificatedUser = Utils.AutentificatedUser;

        if (isAutentificatedUser)
        {
            mCurrentModule = currentModuleId;

            string moduleDescription = string.Empty;

            switch (mCurrentModule)
            {
                case Security.MainModule.ID:
                case Security.Module.ID:
                    mCurrentModule = Utils.ModuleSecurity().GetModuleDescriptionById(mCurrentModule);
                    break;

            }

            string pageDescription = !string.IsNullOrEmpty(moduleDescription) ? moduleDescription : "Self-service platform";

            this.Page.Title = pageName + (!string.IsNullOrEmpty(pageDescription) && !string.IsNullOrEmpty(pageName) ? " - " : string.Empty) + pageDescription;

            MakeAllMenu(isAutentificatedUser);
        }
        else
        {
            MakeAllMenu(isAutentificatedUser);
            FormsAuthentication.RedirectToLoginPage(Utils.GetQueryString(this.Page.Request, this.Page));
            Response.End();
        }

    }

    private void MakeAllMenu(bool autentificatedUser)
    {
        if (autentificatedUser)
        {
            //// CREATE MODULE SELECTORS
            navMainMenuDIV.InnerHtml = Session[Utils.SessionKey_HeadModuleSlector] != null ? (string)Session[Utils.SessionKey_HeadModuleSlector] : string.Empty;

            //// CREATE GENERAL MENU FOR MODULE
            switch (mCurrentModule)
            {
                case Security.MainModule.ID:
                case Security.Module.ID:
                    currentNavigateMenu.InnerHtml = Session[Utils.SessionKey_ModuleMainNavigateMenu] != null ? (string)Session[Utils.SessionKey_ModuleMainNavigateMenu] : string.Empty; 
                    break;

                default:
                    currentNavigateMenu.InnerHtml = string.Empty;
                    break;

            }


            //// LoginLOgout ButtonLink       
            string firstName = Utils.UserObject().FirstName;
            string lastName = Utils.UserObject().LastName;
            LogInLogOutLinkButton.Text = firstName + " " + lastName + " | Log OUT";
            LogInLogOutLinkButton.NavigateUrl = "~/Login.aspx?action=logout";


            emailBoxButton.Visible = true;
        }
        else
        {
            //// CREATE MODULE SELECTORS
            navMainMenuDIV.InnerHtml = string.Empty;

            //// CREATE GENERAL MENU FOR MODULE
            currentNavigateMenu.InnerHtml = string.Empty;        


            //// LoginLOgout ButtonLink    
            LogInLogOutLinkButton.Text = "Log IN";
            LogInLogOutLinkButton.NavigateUrl = "~/Login.aspx?action=login";

            emailBoxButton.Visible = false;
        }
    }


}
