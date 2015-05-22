using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage, IMasterItems
{
    public string navMainMenu = string.Empty;
    string mCurrentModule = string.Empty;

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
                for (int i = foundIndex + 1; i < navLinksDT.Rows.Count; i++)
                {
                    navLinksDT.Rows[i].Delete();
                    navLinksDT.AcceptChanges();
                    i--;
                }
            }
        }

        shortNavigation.InnerHtml = GenerateNavlinks();
    }

    void IMasterItems.ShowMainMenu()
    {
        ShowMenu();
    }
    
    void IMasterItems.PerformPreloadActions(string currentModuleId, string pageName)
    {
        mCurrentModule = currentModuleId;

        string moduleDescription = Utils.ModuleSecurity().GetModuleDescriptionById(mCurrentModule);
        string pageDescription = !string.IsNullOrEmpty(moduleDescription) ? moduleDescription : "Self-service platform";

        this.Page.Title = pageName + (!string.IsNullOrEmpty(pageDescription) && !string.IsNullOrEmpty(pageName) ? " - " : string.Empty) + pageDescription;
    }

    private void ShowMenu()
    {
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
            Session["MenuObject"] = null;
        }

        navMainMenu = resulAutentification && Session["MenuObject"] != null ? (string)Session["MenuObject"] : string.Empty;
    }

    private string GenerateNavlinks()
    {
        string result = string.Empty;

        #region Check Autentifications

        bool resulAutentification = false;
        Security.User userOBJ = (Security.User)Session["UserObject"];

        if (userOBJ != null && userOBJ.UserID != 0)
            resulAutentification = true;

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

            for (int i = 0; i < navLinksDT.Rows.Count; i++)
            {
                result += (i > 0 ? "&nbsp;&nbsp;/&nbsp;&nbsp;" : string.Empty) + "<a id=\"" + navLinksDT.Rows[i]["linkID"].ToString() + "\" href=\"" + (i < navLinksDT.Rows.Count - 1 ? navLinksDT.Rows[i]["linkURL"].ToString() : "#") + "\">" + navLinksDT.Rows[i]["linkName"].ToString() + "</a>";
            }
        }

        return result;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ShowMenu();

        switch (Request.Params.Get("__EVENTTARGET"))
        {
            case "OpenEmailBox":
                emailBox.Show();
                break;           
        }
    }  

    protected void LogInLogOutLinkButton_Load(object sender, EventArgs e)
    {
        if (Utils.AutentificatedUser)
        {
            string firstName = Utils.UserObject().FirstName;
            string lastName = Utils.UserObject().LastName;
            LogInLogOutLinkButton.Text = firstName + " " + lastName + " | Log OUT";
            LogInLogOutLinkButton.NavigateUrl = "~/Default.aspx?action=logout";

            emailBoxButton.Visible = true;
        }
        else
        {
            LogInLogOutLinkButton.Text = "Log IN";
            LogInLogOutLinkButton.NavigateUrl = "~/Default.aspx?area=login";

            emailBoxButton.Visible = false;
        }      
    }
    
    protected string WriteAppPath()
    {
        string appPath = Utils.GetApplicationPath(Request);
        return appPath;
    }
}
