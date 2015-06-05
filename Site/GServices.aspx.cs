using System;
using System.Data;
using System.Collections.Generic;


public partial class GServices : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private static bool IsAutentificatedUser()
    {
        bool result = false;

        if (Utils.AutentificatedUser)
        {
            result = true;
        }
        else
        {
            System.Web.HttpContext.Current.Response.Redirect(Utils.GetApplicationPath(System.Web.HttpContext.Current.Request) + "/Login.aspx");
            System.Web.HttpContext.Current.Response.End();
        }   

        return result;
    }


    [System.Web.Services.WebMethod]
    public static string GetCustomersListAsHTMLTable(int category, bool juridicPerson, string additionalGridID)
    {
        string result = String.Empty;

        bool allowHere = Utils.PermissionAllowed(Client.Module.ID, Client.Domains.CustomersPersonalData.Name, Constants.Classifiers.Permissions_View);

        if (IsAutentificatedUser() && allowHere)
        {
            List<int> genderList = new List<int>();
            if (juridicPerson)
            {
                genderList.Add((int)Constants.Classifiers.ClientType_PersoanaJuridica);
            }
            else
            {
                genderList.Add((int)Constants.Classifiers.ClientType_PersoanaFizica);
            }

            DataTable clientdt = Utils.ModuleCustomers().GetClientList(category, genderList);

            if (clientdt != null && clientdt.Rows.Count > 0)
            {
                result += " <table id='" + additionalGridID + "customersList'> \r\n";
                result += "     <thead> \r\n ";
                result += "         <tr> \r\n ";

                if (juridicPerson)
                {
                    result += "             <th class=\"hidden\">Client ID</th>\r\n ";
                    result += "             <th>Name</th>\r\n ";
                    result += "             <th>Registration nr.</th>\r\n ";
                    result += "             <th>Contact person</th>\r\n ";                    
                    result += "             <th>Telefon</th>\r\n ";
                }
                else
                {
                    result += "             <th class=\"hidden\">Client ID</th>\r\n ";
                    result += "             <th>First Name</th>\r\n ";
                    result += "             <th>Last Name</th>\r\n ";
                    result += "             <th>Birth Date</th>\r\n ";
                    result += "             <th>Buletin</th>\r\n ";
                    result += "             <th>Personal ID</th>\r\n ";
                    result += "             <th>Telefon</th>\r\n ";
                }               

                result += "         </tr> \r\n ";
                result += "     </thead> \r\n ";
                result += "     <tbody> \r\n ";


                for (int i = 0; i < clientdt.Rows.Count; i++)
                {
                    result += "         <tr id='" + clientdt.Rows[i]["clientID"].ToString() + "' " + (i % 2 == 1 ? " class=\"odd\" " : string.Empty) + " onclick=\"clickGrid(this)\"  onmouseover=\"this.style.cursor='pointer';this.style.textDecoration='underline';\" onmouseout=\"this.style.textDecoration='none';\" style=\"cursor: pointer; text-decoration: none;\"> \r\n ";

                    if (juridicPerson)
                    {
                        result += "             <td class=\"hidden\"> " + clientdt.Rows[i]["clientID"].ToString() + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["FirstName"].ToString() + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["personalID"].ToString() + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["LastName"].ToString() + "</td>";                     
                        result += "             <td> " + clientdt.Rows[i]["telefon"].ToString() + "</td>";
                    }
                    else
                    {
                        result += "             <td class=\"hidden\"> " + clientdt.Rows[i]["clientID"].ToString() + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["FirstName"].ToString() + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["LastName"].ToString() + "</td>";
                        result += "             <td> " + (clientdt.Rows[i]["DateOfBirth"] != System.DBNull.Value ? ((DateTime)clientdt.Rows[i]["DateOfBirth"]).ToString(Constants.ISODateBackwardDotsFormat) : string.Empty) + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["buletinSeria"].ToString() + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["personalID"].ToString() + "</td>";
                        result += "             <td> " + clientdt.Rows[i]["telefon"].ToString() + "</td>";
                    }

                    result += "         </tr> \r\n ";
                }

                result += "     </tbody> \r\n ";
                result += " </table> \r\n";
            }
        }
        else
        {
            result = "Not allowed access to customers data";
        }

        return result;
    }
    
}