using System;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class Controls_DialogBox : System.Web.UI.UserControl
{
    string mWindowTitle = string.Empty;
    string mMessage = string.Empty;

    Unit mWidth = 400;

    public Unit Width
    {
        get { return mWidth; }
        set { mWidth = value; }
    }

    public string WindowTitle
    {
        set { mWindowTitle = value; }
    }

    public string Message
    {
        set { mMessage = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}