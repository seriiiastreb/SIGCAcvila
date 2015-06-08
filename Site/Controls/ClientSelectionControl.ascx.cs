using System;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web;
using System.Data;
using System.Text;

public partial class ClientSelectionControl : System.Web.UI.UserControl
{
    int parameterX = 0;
    int parameterY = 0;

    string appPath = string.Empty;

    public int ParameterX
    {
        set { parameterX = value; }
    }

    public int ParameterY
    {
        set { parameterY = value; }
    }

   

    public int SelectedClientID
    {
        get
        {
            int tempInt = 0;
            int.TryParse(selectedClientIDHiddenField.Value, out tempInt);
            return tempInt;
        }
        set
        {
            selectedClientIDHiddenField.Value = value.ToString();
            //DataTable clientInfo = Utils.ModuleCredits().GetClientByID(value);

            //if (clientInfo != null && clientInfo.Rows.Count == 1)
            //{
            //    selectedClientFirstNameHiddenField.Value = clientInfo.Rows[0]["FirstName"].ToString();
            //    SelectedClientLastNameHiddenField.Value = clientInfo.Rows[0]["LastName"].ToString();
            //    SelectedClientIDNOHiddenField.Value = clientInfo.Rows[0]["personalID"].ToString();
            //    SelectedClientBirthDateHiddenField.Value = clientInfo.Rows[0]["DateOfBirth"] != System.DBNull.Value ? ((DateTime)clientInfo.Rows[0]["DateOfBirth"]).ToString(Constants.Constants.ISODateBackwardDotsFormat) : string.Empty;
            //}
        }
    }

    private void BindDataSource()
    {
        ScriptManager.RegisterStartupScript(programmaticPopup, typeof(string), "GetCustomersList", "GetCustomersList(0);", true);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        appPath = Utils.GetApplicationPath(Request);

       //// WindowTitleLabel.Text = mTitleWindow;
       // txtSearch.Attributes.Add("onkeyup", "Search('" + txtSearch.ClientID + "','" + clientiGridView.ClientID + "')");
       // clientsListDiv.Attributes.Add("onscroll", "SetDivPosition('" + clientsListDiv.ClientID + "')");

        if (parameterX != 0) clientModalPopup.X = parameterX;
        if (parameterY != 0) clientModalPopup.Y = parameterY;
       RegisterAllClientJavaScripts();
    }

    private void RegisterAllClientJavaScripts()
    {
        if (Utils.AutentificatedUser)
        {
            if (!Page.ClientScript.IsClientScriptBlockRegistered(typeof(Page), "ClientSelecttionControlScript"))
            {
                StringBuilder cstext2 = new StringBuilder();
                cstext2.Append("<script type=text/javascript> \r\n ");
                cstext2.Append("function GetCustomersList(varcategory) { \r\n ");
                cstext2.Append("    var varjuridicPerson = document.getElementById('" + juridicPersonRadio.ClientID + "').checked;    \r\n \r\n ");
                cstext2.Append("    var params = { category: varcategory, juridicPerson: varjuridicPerson, additionalGridID : '" + this.ClientID + "'}; \r\n ");
                cstext2.Append("             $.ajax({ \r\n ");
                cstext2.Append("                type: \"POST\", \r\n ");
                cstext2.Append("                url: \"" + appPath + "/GServices.aspx/GetCustomersListAsHTMLTable\", \r\n ");
                cstext2.Append("                data: JSON.stringify(params) , \r\n ");
                cstext2.Append("                contentType: \"application/json; charset=utf-8\", \r\n ");
                cstext2.Append("                dataType: \"json\", \r\n ");
                cstext2.Append("                success: OnSuccess, \r\n ");
                cstext2.Append("                failure: function (response) {    } \r\n ");
                cstext2.Append("            }); \r\n ");
                cstext2.Append("        } \r\n\r\n\r\n ");
                cstext2.Append("       function OnSuccess(response) { \r\n ");
                cstext2.Append("           var resp = response.d; \r\n ");
                cstext2.Append("           var divelement = document.getElementById('" + customersDiv .ClientID + "'); \r\n ");
                cstext2.Append("           divelement.innerHTML = resp;  \r\n ");
                cstext2.Append("           document.getElementById('" + txtSearch.ClientID + "').value = ''; \r\n ");
                cstext2.Append("           document.getElementById('" + selectedClientIDHiddenField.ClientID + "').value = ''; \r\n ");
                cstext2.Append("       }\r\n\r\n");
                cstext2.Append("</script>  \r\n ");
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "ClientSelecttionControlScript", cstext2.ToString(), false);
            }

            if (!Page.ClientScript.IsClientScriptBlockRegistered(typeof(Page), "clickGrid"))
            {
                StringBuilder cstext1 = new StringBuilder();

                cstext1.Append("<script type=text/javascript> \r\n ");
                cstext1.Append("    function clickGrid(ckikedRow) { \r\n ");
                cstext1.Append("        ResetGridSelection('" + this.ClientID + "customersList'); \r\n ");
                cstext1.Append("        ckikedRow.className = \"selectedRow\"; \r\n ");
                cstext1.Append("        document.getElementById('" + selectedClientIDHiddenField.ClientID + "').value = ckikedRow.id; \r\n ");
                cstext1.Append("   }  \r\n \r\n ");
                cstext1.Append("</script>  \r\n ");

                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "clickGrid", cstext1.ToString(), false);
            }
        }
    }
    
    protected void SetScrollOnGrid()
    {
        txtSearch.Attributes["onkeyup"] = "Search('" + txtSearch.ClientID + "', '" + this.ClientID + "customersList');";
        customersDiv.Attributes["onscroll"] = "SetDivPosition('" + customersDiv.ClientID + "');";

        txtSearch.Value = txtSearch.Value;
        ScriptManager.RegisterStartupScript(programmaticPopup, typeof(string), "Search", "Search('" + txtSearch.ClientID + "', '" + this.ClientID + "customersList');", true);
        ScriptManager.RegisterStartupScript(programmaticPopup, typeof(string), "Scroll", "SetLastScrollPosition('" + customersDiv.ClientID + "');", true);
    }

    public void Show()
    {
        BindDataSource();
        SetScrollOnGrid();
        clientModalPopup.Show();
    }

    protected void addNewClientButton_Click(object sender, EventArgs e)
    {
        clientModalPopup.Hide();

        FilterWindowEventsArg args = new FilterWindowEventsArg(0);
        if (OnClientSelected != null)
            OnClientSelected(this, args);
    }

    protected void okButton_Click(object sender, EventArgs e)
    {
        int selectedClientID = 0;
        int.TryParse(selectedClientIDHiddenField.Value, out selectedClientID);

        if (selectedClientID != 0)
        {
            clientModalPopup.Hide();

            FilterWindowEventsArg args = new FilterWindowEventsArg(selectedClientID);
            if (OnClientSelected != null)
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

    //protected void FillClientsGridView()
    //{
    //    clientiGridView.SelectedIndex = -1;
    //    clientiGridView.DataSource = null;
    //    clientiGridView.DataBind();

    //    Credits.Module moduleCredits = Utils.ModuleCredits();

    //    if (moduleCredits != null)
    //    {
    //        int category = 0;
    //        int.TryParse(clientCategoriesTreeView.SelectedValue, out category);

    //        DataTable clientsDT = moduleCredits.GetClientlist(category);
    //        clientiGridView.DataSource = clientsDT;
    //        clientiGridView.DataBind();
    //    }
    //}   

    //protected void clientiGridView_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
    //        e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
    //        e.Row.Attributes["onclick"] = "setSelection" + this.ClientID + "('" + e.Row.RowIndex + "');";
    //    }
    //}

    //protected void clientiGridView_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    txtSearch.Value = txtSearch.Value;
    //    ScriptManager.RegisterStartupScript(clinetUpdatePanel, typeof(string), "Search", "Search('" + txtSearch.ClientID + "', '" + clientiGridView.ClientID + "')", true);
    //    ScriptManager.RegisterStartupScript(clinetUpdatePanel, typeof(string), "Scroll", "SetLastScrollPosition('" + clientsListDiv.ClientID + "')", true);
    //    clientModalPopup.Show();
    //}
                            
    //protected void clientCategoriesTreeView_SelectedNodeChanged(object sender, EventArgs e)
    //{
    //    FillClientsGridView();
    //    clientModalPopup.Show();
    //}
}
