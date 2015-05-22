using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SysServices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Utils.AutentificatedUser)
        {
            string appPath = Utils.GetApplicationPath(Request);
            Response.Redirect(appPath + "/Default.aspx", true);
        }
    }

    [System.Web.Services.WebMethod]
    public static string CheckNewEmail(string userID)
    {
        string result = String.Empty;

        int intUserID = 0;
        int.TryParse(userID, out intUserID);

        if (Utils.AutentificatedUser && intUserID != 0)
        {
            if (Utils.ModuleMain().CheckNewEmailForUser(intUserID))
            { result = "Yes"; }
            else
            { result = "No"; }
        }

        return result;
    }  

}