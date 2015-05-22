using System;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web;
using System.Data;
using System.Text;

public partial class ClientSelectionControl : System.Web.UI.UserControl
{
    Unit mWidth = 820;
    string mTitleWindow = "CONTRAGENTI EXISTENTI";

    int parameterX = 0;
    int parameterY = 0;

    public string selectedClientFirstName
    {
        get { return selectedClientFirstNameHiddenField.Value.Replace("&nbsp;", ""); }
    }

    public string SelectedClientLastName
    {
        get { return SelectedClientLastNameHiddenField.Value.Replace("&nbsp;", ""); }
    }

    public string ClientFirstLastName
    {
        get { return selectedClientFirstNameHiddenField.Value.Replace("&nbsp;", "") + " " + SelectedClientLastNameHiddenField.Value.Replace("&nbsp;", ""); }
    }

    public DateTime SelectedClientBirthDate
    {
        get { return Crypt.Utils.ToDateTime(SelectedClientBirthDateHiddenField.Value.Replace("&nbsp;", ""), Constants.ISODateBackwardDotsFormat); }
    } 

    public string SelectedClientIDNO
    {
        get { return SelectedClientIDNOHiddenField.Value.Replace("&nbsp;", ""); }
    } 

    public int ParameterX
    {
        set { parameterX = value; }
    }

    public int ParameterY
    {
        set { parameterY = value; }
    }

    public Unit Width
    {
        get { return mWidth; }
        set { mWidth = value; }
    }

    public string TitleWindow
    {
        get { return mTitleWindow; }
        set { mTitleWindow = value; }
    }   

    public int SelectedClientID
    {
        get
        {
            int tempInt = 0;
            int.TryParse(selectedClientIDInCSCHiddenField.Value, out tempInt);
            return tempInt;
        }
        set 
        {
            selectedClientIDInCSCHiddenField.Value = value.ToString();
            DataTable clientInfo = Utils.ModuleCredits().GetClientByID(value);

            if (clientInfo != null && clientInfo.Rows.Count == 1)
            {
                selectedClientFirstNameHiddenField.Value = clientInfo.Rows[0]["FirstName"].ToString();
                SelectedClientLastNameHiddenField.Value = clientInfo.Rows[0]["LastName"].ToString();
                SelectedClientIDNOHiddenField.Value = clientInfo.Rows[0]["personalID"].ToString();
                SelectedClientBirthDateHiddenField.Value = clientInfo.Rows[0]["DateOfBirth"] != System.DBNull.Value ? ((DateTime)clientInfo.Rows[0]["DateOfBirth"]).ToString(Constants.ISODateBackwardDotsFormat) : string.Empty;
            }
        }
    }

    public void BindDataSource()
    {
        clientCategoriesTreeView.Nodes[0].ChildNodes.Clear();

        DataTable categoriesDT = Utils.ModuleMain().GetClassifierByTypeID((int)Constants.ClassifierTypes.ClientCategories);
        
        if(categoriesDT != null && categoriesDT.Rows.Count > 0)
        {
            for(int i=0; i< categoriesDT.Rows.Count; i++)
            {
                if ((int)categoriesDT.Rows[i]["Code"] != 0)
                {
                    TreeNode rotNode = clientCategoriesTreeView.Nodes[0];

                    TreeNode newNode = new TreeNode();
                    newNode.Text = categoriesDT.Rows[i]["Name"].ToString();
                    newNode.Value = categoriesDT.Rows[i]["Code"].ToString();

                    rotNode.ChildNodes.Add(newNode);
                }
            }
        }

        clientCategoriesTreeView.Nodes[0].Selected = true;
        FillClientsGridView();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        WindowTitleLabel.Text = mTitleWindow;
        txtSearch.Attributes.Add("onkeyup", "Search('" + txtSearch.ClientID + "','" + clientiGridView.ClientID + "')");
        clientsListDiv.Attributes.Add("onscroll", "SetDivPosition('" + clientsListDiv.ClientID + "')");

        if(parameterX != 0) clientModalPopup.X = parameterX;
        if(parameterY != 0) clientModalPopup.Y = parameterY;
        RegisterAllClientJavaScripts();
    }

    private void RegisterAllClientJavaScripts()
    {
        if (!Page.ClientScript.IsClientScriptBlockRegistered(typeof(Page), "setSelection" + this.ClientID))
        {
            StringBuilder cstext2 = new StringBuilder();
            cstext2.Append("<script type=text/javascript>  \r\n     function setSelection" + this.ClientID + "(gridIndex) { \r\n ");
            cstext2.Append("   var table = document.getElementById('" + clientiGridView.ClientID + "'); \r\n  ");
            cstext2.Append("   var rows = table.getElementsByTagName(\"tr\");  \r\n  ");
            cstext2.Append("    for (i = 0; i < rows.length; i++) {\r\n ");

            cstext2.Append("        if (gridIndex == i - 1){ \r\n ");
            cstext2.Append("            rows[i].style.backgroundColor = \"#CCCCFF\"; \r\n  ");
            cstext2.Append("            document.getElementById('" + selectedClientIDInCSCHiddenField.ClientID + "').value = rows[i].cells[0].innerHTML; \r\n ");
            cstext2.Append("            document.getElementById('" + selectedClientFirstNameHiddenField.ClientID + "').value = rows[i].cells[1].innerHTML; \r\n ");
            cstext2.Append("            document.getElementById('" + SelectedClientLastNameHiddenField.ClientID + "').value = rows[i].cells[2].innerHTML; \r\n ");
            cstext2.Append("            document.getElementById('" + SelectedClientIDNOHiddenField.ClientID + "').value = rows[i].cells[5].innerHTML; \r\n ");
            cstext2.Append("            document.getElementById('" + SelectedClientBirthDateHiddenField.ClientID + "').value = rows[i].cells[3].getElementsByTagName('span')[0].innerHTML; \r\n ");
            cstext2.Append("            } \r\n ");

            cstext2.Append("        else { rows[i].style.backgroundColor = \"\"; } \r\n ");
            cstext2.Append("        } \r\n ");
            cstext2.Append("    } \r\n ");
            cstext2.Append("</script>\r\n ");

            Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "checkAllScript" + this.ClientID, cstext2.ToString(), false);
        }
    }

    public void Show()
    {
        clientModalPopup.Show();
    }

    protected void okButton_Click(object sender, EventArgs e)
    {
        int selectedClientID = 0;
        int.TryParse(selectedClientIDInCSCHiddenField.Value, out selectedClientID);

        if (selectedClientID != 0)
        {
            FilterWindowEventsArg args = new FilterWindowEventsArg(selectedClientID);
            OnClientSelected(this, args);
        }
        else
        { clientModalPopup.Show(); }
    }   

    public class FilterWindowEventsArg : EventArgs
    {
        private int selectedItem;
        public int SelectedItem
        {
            get { return selectedItem; }
        }

        public FilterWindowEventsArg(int item)
        {
            selectedItem = item;
        }
    }

    public delegate void CustomItemEventHandler(object sender, FilterWindowEventsArg e);

    public event CustomItemEventHandler OnClientSelected;

    protected void FillClientsGridView()
    {
        clientiGridView.SelectedIndex = -1;
        clientiGridView.DataSource = null;
        clientiGridView.DataBind();

        Credits.Module moduleCredits = Utils.ModuleCredits();

        if (moduleCredits != null)
        {
            int category = 0;
            int.TryParse(clientCategoriesTreeView.SelectedValue, out category);

            DataTable clientsDT = moduleCredits.GetClientlist(category);
            clientiGridView.DataSource = clientsDT;
            clientiGridView.DataBind();
        }
    }   

    protected void clientiGridView_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
            e.Row.Attributes["onclick"] = "setSelection" + this.ClientID + "('" + e.Row.RowIndex + "');";
        }
    }

    protected void clientiGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtSearch.Value = txtSearch.Value;
        ScriptManager.RegisterStartupScript(clinetUpdatePanel, typeof(string), "Search", "Search('" + txtSearch.ClientID + "', '" + clientiGridView.ClientID + "')", true);
        ScriptManager.RegisterStartupScript(clinetUpdatePanel, typeof(string), "Scroll", "SetLastScrollPosition('" + clientsListDiv.ClientID + "')", true);
        clientModalPopup.Show();
    }
                            
    protected void clientCategoriesTreeView_SelectedNodeChanged(object sender, EventArgs e)
    {
        FillClientsGridView();
        clientModalPopup.Show();
    }
}
