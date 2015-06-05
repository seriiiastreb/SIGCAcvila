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
                    moduleDescription = Utils.ModuleSecurity().GetModuleDescriptionById(mCurrentModule);
                    break;

            }

            string pageDescription = !string.IsNullOrEmpty(moduleDescription) ? moduleDescription : "Self-service platform";

            this.Page.Title = pageName + (!string.IsNullOrEmpty(pageDescription) && !string.IsNullOrEmpty(pageName) ? " - " : string.Empty) + pageDescription;


            #region Create Menu

            //// CREATE MODULE SELECTORS
            mainNavigateMenu.InnerHtml = Session[Utils.SessionKey_HeadModuleSlector] != null ? (string)Session[Utils.SessionKey_HeadModuleSlector] : string.Empty;

            //// CREATE GENERAL MENU FOR MODULE
            //switch (mCurrentModule)
            //{
            //    case Security.MainModule.ID:
            //    case Security.Module.ID:
            //        currentNavigateMenu.InnerHtml = Session[Utils.SessionKey_ModuleMainMenu] != null ? (string)Session[Utils.SessionKey_ModuleMainMenu] : string.Empty;
            //        break;

            //    case Client.Module.ID:
            //        currentNavigateMenu.InnerHtml = Session[Utils.SessionKey_ModuleCustomersMenu] != null ? (string)Session[Utils.SessionKey_ModuleCustomersMenu] : string.Empty;
            //        break;

            //    default:
            //        currentNavigateMenu.InnerHtml = string.Empty;
            //        break;

            //}


            //// LoginLOgout ButtonLink       
            string firstName = Utils.UserObject().FirstName;
            string lastName = Utils.UserObject().LastName;
            LogInLogOutLinkButton.Text = firstName + " " + lastName + " | Log OUT";
            LogInLogOutLinkButton.NavigateUrl = "~/Login.aspx?action=logout";


            emailBoxButton.Visible = true;

            #endregion Create Menu
        }
        else
        {

            #region CLEAR ALL MENIU

            //// CREATE MODULE SELECTORS
            mainNavigateMenu.InnerHtml = string.Empty;

            //// CREATE GENERAL MENU FOR MODULE
            currentNavigateMenu.InnerHtml = string.Empty;


            //// LoginLOgout ButtonLink    
            LogInLogOutLinkButton.Text = "Log IN";
            LogInLogOutLinkButton.NavigateUrl = "~/Login.aspx?action=login";

            emailBoxButton.Visible = false;

            #endregion CLEAR ALL MENIU


            FormsAuthentication.RedirectToLoginPage(Utils.GetQueryString(this.Page.Request, this.Page));
            Response.End();
        }

    }

    bool IMasterItems.IsEmptyNavLinks
    {
        get
        {
            bool isEmpty = true;

            if (Session["NavLinks"] != null)
            {
                DataTable navDT = (DataTable)Session["NavLinks"];

                if (navDT != null && navDT.Rows.Count > 0)
                {
                    isEmpty = false; ;
                }
            }

            return isEmpty;
        }
    }

    void IMasterItems.ClearNavLinks()
    {
        Session["NavLinks"] = null;
    }

    void IMasterItems.AddNavlink(string linkName, string linkURL, string linkID)
    {
        #region Check Autentifications

        bool resulAutentification = Utils.AutentificatedUser;

        if (resulAutentification)
        {
            if (Session["NavLinks"] == null)
            {
                DataTable navLinksDT = new DataTable();
                navLinksDT.Columns.Add("linkName", typeof(string));
                navLinksDT.Columns.Add("linkURL", typeof(string));
                navLinksDT.Columns.Add("linkID", typeof(string));

                Session["NavLinks"] = navLinksDT;
            }
        }
        else
        {
            Session["NavLinks"] = null;
        }

        #endregion Check Autentifications

        if (resulAutentification && Session["NavLinks"] != null)
        {
            DataTable navLinksDT = (DataTable)Session["NavLinks"];

            bool foundLinkID = false;
            int foundIndex = -1;

            for (int i = 0; i < navLinksDT.Rows.Count; i++)
            {
                if (!foundLinkID && navLinksDT.Rows[i]["linkID"].ToString().Equals(linkID))
                {
                    foundLinkID = true;
                    foundIndex = i;
                }
            }

            if (!foundLinkID)
            {
                navLinksDT.Rows.Add();
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkName"] = linkName;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkURL"] = linkURL;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkID"] = linkID;
            }
            else
            {
                for (int i = foundIndex; i < navLinksDT.Rows.Count; i++)
                {
                    navLinksDT.Rows[i].Delete();
                    navLinksDT.AcceptChanges();
                    i--;
                }

                navLinksDT.Rows.Add();
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkName"] = linkName;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkURL"] = linkURL;
                navLinksDT.Rows[navLinksDT.Rows.Count - 1]["linkID"] = linkID;
            }
        }

        currentNavigateMenu.InnerHtml = GenerateShortNavLinks();
    }
    
    private string GenerateShortNavLinks()
    {
        string result = string.Empty;

        #region Check Autentifications
        
        if (Utils.AutentificatedUser)
        {
            if (Session["NavLinks"] == null)
            {
                DataTable navLinksDT = new DataTable();
                navLinksDT.Columns.Add("linkName", typeof(string));
                navLinksDT.Columns.Add("linkURL", typeof(string));
                navLinksDT.Columns.Add("linkID", typeof(string));

                Session["NavLinks"] = navLinksDT;
            }
            
            DataTable shortNavLinksDT = (DataTable)Session["NavLinks"];

            if (shortNavLinksDT != null && shortNavLinksDT.Rows.Count > 0)
            {
                for (int i = 0; i < shortNavLinksDT.Rows.Count; i++)
                {
                    result += " <li> <a id=\"" + shortNavLinksDT.Rows[i]["linkID"].ToString() + "\" href=\"" + (i < shortNavLinksDT.Rows.Count - 1 ? shortNavLinksDT.Rows[i]["linkURL"].ToString() : "#") + "\">" + shortNavLinksDT.Rows[i]["linkName"].ToString() + (i < shortNavLinksDT.Rows.Count - 1 ? "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//" : string.Empty) + "</a> </li>";
                }
            }
        }
        else
        {
            Session["NavLinks"] = null;
        }

        #endregion Check Autentifications      

        return result;
    }
    
}
