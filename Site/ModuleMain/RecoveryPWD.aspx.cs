using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class RecoveryPWD : System.Web.UI.Page
{
    private void ShowPanel(string panelName)
    {
        #region Hide panels

        resetPasswordStep1Panel.Visible = false;
        resetPasswordStep2Panel.Visible = false;
        emptyPanel.Visible = false;

        #endregion Hide panels

        try
        {     
            switch (panelName)
            {
                #region Services
                case "resetPasswordStep1Panel":
                    resetPasswordStep1Panel.Visible = true;

                    break;

                case "resetPasswordStep2Panel":
                    resetPasswordStep2Panel.Visible = true;

                    break;

                #endregion Services

                default:
                    emptyPanel.Visible = true;
                    break;
            }
        }
        catch (Exception ex)
        {
            Utils.GetMaster(this).ShowMessage(Constants.InfoBoxMessageType.Error, "Error on Page.", ex.Message); 
        }
    }

    public void ServerValidation(object source, ServerValidateEventArgs args)
    {
        try
        {
            string inputLogin = loginTextBox.Text.Trim();
            string imputEmail = args.Value.ToString();
            //DataTable dt = mServerObject.ChekExistRegistredEmail(inputLogin, imputEmail);

            //if (dt != null && dt.Rows.Count > 0)
            //{
            //    args.IsValid = true;
            //}
            //else
            //    args.IsValid = false;
        }

        catch (Exception ex)
        {
            args.IsValid = false;
            Utils.GetMaster(this).ShowMessage(Constants.InfoBoxMessageType.Error, "Error on Page.", ex.Message); 
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        ShowPanel(resetPasswordStep1Panel.ID);
    }

    protected void resetPasswordStep1_OkButton_Click(object sender, EventArgs e)
    {
        if (resetPasswordStep1CustomValidator.IsValid)
        {
            string loginString = loginTextBox.Text.Trim();
            string emailString = emailTextBox.Text;
            string newPassword = Crypt.Module.CreateRandomPassword(8);

            if (Utils.ModuleSecurity().UpdateUserPasswordByLoginAndEmail(loginString, emailString, newPassword))
            {
                #region sendEmail

                string emailTemplate = @"Buna ziua, <br/> "
                    + "Adersa aceasta de Email a fost indicata pentru efectuarea schimbarii parolei.  <br/>"
                    + " Pentru logarea in sistemul DINAR-CAPITAL folositi urmatoarele date: <br />"
                    + " Nume utilizator: " + loginString + " <br />"
                    + " Parola: " + newPassword + " <br />"
                    + " Atentie! Dupa ce intrati pe pagina WEB folosind parola data - schimbati parola!";
                string emailSubject = "DINAR-Capital. Parola noua.";
                string resultEmail = Utils.EmailSend(emailString, emailTemplate, emailSubject);

                #endregion send email

                ShowPanel(resetPasswordStep2Panel.ID);
            }
            else
            {

               // Utils.InfoText(this, "Atentie!", "Parola nu a fost schimbata! In momentul dat nu este posibil de a schimba parola. Incercati mai tirziu!");
            }
        }   
    }
}