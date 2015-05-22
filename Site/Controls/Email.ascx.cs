using System;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web;
using System.Text;
using System.Data;
using System.Collections.Generic;

public partial class Controls_Email : System.Web.UI.UserControl
{
    string mWindowTitle = string.Empty;
    private string appPath = string.Empty;

    public string CurrentmailBoxUserName
    {
        set { currentMailBoxUsserHiddenVield.Value = value; }
        get { return currentMailBoxUsserHiddenVield.Value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        appPath = Utils.GetApplicationPath(Request);
        RegisterAllClientJavaScripts();
    }

    private void RegisterAllClientJavaScripts()
    {
        if (Utils.AutentificatedUser && !Page.ClientScript.IsClientScriptBlockRegistered(typeof(Page), "CheckNewEmail"))
        {
            StringBuilder cstext2 = new StringBuilder();
            cstext2.Append("<script type=text/javascript> \r\n ");
            cstext2.Append("    $(document).ready(function () { \r\n ");
            cstext2.Append("    CheckNewEmail(); \r\n ");
            cstext2.Append("    }); \r\n \r\n\r\n");
            cstext2.Append("    var refreshEmailIcon = setInterval(CheckNewEmail, 10000); \r\n \r\n\r\n");


            cstext2.Append("function CheckNewEmail() { \r\n ");
            cstext2.Append("             $.ajax({ \r\n ");
            cstext2.Append("                type: \"POST\", \r\n ");
            cstext2.Append("                url: \"" + appPath + "/SysServices.aspx/CheckNewEmail\", \r\n ");
            cstext2.Append("                data: '{userID:" + Utils.UserObject().UserID + "}', \r\n ");
            cstext2.Append("                contentType: \"application/json; charset=utf-8\", \r\n ");
            cstext2.Append("                dataType: \"json\", \r\n ");
            cstext2.Append("                success: OnSuccess, \r\n ");
            cstext2.Append("                failure: function (response) {             \r\n ");
            cstext2.Append("                } \r\n ");
            cstext2.Append("            }); \r\n ");
            cstext2.Append("        } \r\n\r\n\r\n ");

            cstext2.Append("       function OnSuccess(response) { \r\n ");
            cstext2.Append("           var resp = response.d; \r\n ");
            cstext2.Append("           var ebutton = document.getElementById('emailBoxButton'); \r\n ");

            cstext2.Append("           if (resp == \"Yes\") \r\n ");
            cstext2.Append("           { ebutton.src = \"" + appPath + "/App_Images/animatedemail.gif\";        } \r\n ");
            cstext2.Append("          else \r\n ");
            cstext2.Append("           { ebutton.src = \"" + appPath + "/App_Images/mail_simple.png\";         } \r\n ");
            cstext2.Append("       }\r\n\r\n");                      
            
            
            cstext2.Append("</script>  \r\n ");
            Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "CheckNewEmail", cstext2.ToString(), false);
        }
    }

    public void Show()
    {
        if (Utils.AutentificatedUser)
        {
            this.CurrentmailBoxUserName = Utils.UserObject().FirstName + " " + Utils.UserObject().LastName;
            string appPath = Utils.GetApplicationPath(Request);

            ShowPanel(inboxPanel.ID);

            DataTable messageTypesList = new DataTable();
            messageTypesList.Columns.Add("Code", typeof(int));
            messageTypesList.Columns.Add("Name", typeof(string));
            messageTypesList.Rows.Add(Constants.EmailMessageTypes.SystemMessage, "System Mesage");
            messageTypesList.Rows.Add(Constants.EmailMessageTypes.Email, "Email");

            Utils.FillSelector(composeEmail_MessageTypeDDL, messageTypesList, "Name", "Code");

            DataTable userList = Utils.ModuleMain().GetMessageUsersList();
            Utils.FillSelector(composeEmailToUsersDDL, userList, "Name", "userid");           

            this.programmaticModalPopup.Show();
        }
    }

    protected void ShowPanel(string idPanel)
    {
        inboxPanel.Visible = false;
        readEmailPanel.Visible = false;
        composePanel.Visible = false;
        sendedEmails.Visible = false;
        addessBookPanel.Visible = false;
        deletedEmailsPanel.Visible = false;

        switch (idPanel)
        {
            case "inboxPanel":
                inboxPanel.Visible = true;
                lastPanelHiddenField.Value = inboxPanel.ID;
                infoBoxTitleLabel.Text = this.CurrentmailBoxUserName + "&nbsp;&nbsp;&nbsp;[ INBOX ]";
                FillInboxGridView();
                break;

            case "readEmailPanel":
                readEmailPanel.Visible = true;
                break;

            case "composePanel":
                composePanel.Visible = true;
                lastPanelHiddenField.Value = composePanel.ID;
                infoBoxTitleLabel.Text = this.CurrentmailBoxUserName + "&nbsp;&nbsp;&nbsp;[ COMPOSE EMAIL ]";
                break;

            case "sendedEmails":
                sendedEmails.Visible = true;
                FillSendedEmailsGridView();
                lastPanelHiddenField.Value = sendedEmails.ID;
                infoBoxTitleLabel.Text = this.CurrentmailBoxUserName + "&nbsp;&nbsp;&nbsp;[ SENDED EMAILS ]";
                break;

            case "addessBookPanel":
                addessBookPanel.Visible = true;
                lastPanelHiddenField.Value = addessBookPanel.ID;
                infoBoxTitleLabel.Text = this.CurrentmailBoxUserName + "&nbsp;&nbsp;&nbsp;[ ADDRESS BOOK ]";
                break;

            case "deletedEmailsPanel":
                deletedEmailsPanel.Visible = true;
                FillDeletedEmailsGridView();
                lastPanelHiddenField.Value = deletedEmailsPanel.ID;
                infoBoxTitleLabel.Text = this.CurrentmailBoxUserName + "&nbsp;&nbsp;&nbsp;[ RECYCLE BIN ]";
                break;  
        }
    }

    protected void FillInboxGridView()
    {
        inbox_emailsGridView.DataSource = null;
        inbox_emailsGridView.DataBind();

        List<int> typesList = new List<int>();
        typesList.Add(Constants.EmailMessageStatus.UnReaded);
        typesList.Add(Constants.EmailMessageStatus.Readed);
        typesList.Add(Constants.EmailMessageStatus.Draft);

        DataTable inboxDT = Utils.ModuleMain().GetMessagesListByUserID(Utils.UserObject().UserID, typesList, Constants.EmailScope.InBox);

        if (inboxDT != null && inboxDT.Rows.Count > 0)
        {
            inbox_emailsGridView.DataSource = inboxDT;
            inbox_emailsGridView.DataBind();
        }           
    }

    protected void FillSendedEmailsGridView()
    {
        sendedGridView.DataSource = null;
        sendedGridView.DataBind();

        List<int> typesList = new List<int>();
        typesList.Add(Constants.EmailMessageStatus.UnReaded);
        typesList.Add(Constants.EmailMessageStatus.Readed);
        typesList.Add(Constants.EmailMessageStatus.Draft);

        DataTable sendedDT = Utils.ModuleMain().GetMessagesListByUserID(Utils.UserObject().UserID, typesList, Constants.EmailScope.OutBox);

        if (sendedDT != null && sendedDT.Rows.Count > 0)
        {
            sendedGridView.DataSource = sendedDT;
            sendedGridView.DataBind();
        }   
    }

    protected void FillDeletedEmailsGridView()
    {
        deletedEmailsGridView.DataSource = null;
        deletedEmailsGridView.DataBind();

        List<int> typesList = new List<int>();
        typesList.Add(Constants.EmailMessageStatus.UnReaded);
        typesList.Add(Constants.EmailMessageStatus.Readed);
        typesList.Add(Constants.EmailMessageStatus.Draft);

        DataTable deletedDT = Utils.ModuleMain().GetMessagesListByUserID(Utils.UserObject().UserID, typesList, Constants.EmailScope.Deleted);

        if (deletedDT != null && deletedDT.Rows.Count > 0)
        {
            deletedEmailsGridView.DataSource = deletedDT;
            deletedEmailsGridView.DataBind();
        }    
    }

    protected void inboxLinkButton_Click(object sender, EventArgs e)
    {
        ShowPanel(inboxPanel.ID);
    }

    protected void composeLinkButton_Click(object sender, EventArgs e)
    {
        composeEmailTo_TextBox.Text = string.Empty;
        composeEmail_Subject.Text = string.Empty;
        composeEMail_MessageBodyTextBox.Text = string.Empty;
        ShowPanel(composePanel.ID);
    }

    protected void sendedMailsLinkButton_Click(object sender, EventArgs e)
    {
        ShowPanel(sendedEmails.ID);
    }

    protected void addressBookLinkButton_Click(object sender, EventArgs e)
    {
        ShowPanel(addessBookPanel.ID);
    }

    protected void inbox_deleteImageButton_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            List<int> messagesIDList = new List<int>();

            for (int i = 0; i < inbox_emailsGridView.Rows.Count; i++)
            {
                CheckBox ckBx = (CheckBox)inbox_emailsGridView.Rows[i].Cells[1].FindControl("checkBoxID");

                if (ckBx != null && ckBx.Checked)
                {
                    int messageID = 0;
                    int.TryParse(inbox_emailsGridView.Rows[i].Cells[0].Text, out messageID);

                    messagesIDList.Add(messageID);
                }
            }

            Utils.ModuleMain().MoveLocalMessageInSpecificFolder(messagesIDList, Constants.EmailScope.Deleted);
            FillInboxGridView();
        }
        catch { }
    }
    
    protected void inbox_emailsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        readEmailID_HiddenFiled.Value = string.Empty;
        readEmail_subjectLabel.Text = string.Empty;
        readEmail_FromLabel.Text = string.Empty;
        readEmail_DateLabel.Text = string.Empty;
        readEmail_bodyMessage.Text = string.Empty;

        try {
            if (inbox_emailsGridView.SelectedRow != null)
            {
                GridViewRow row = inbox_emailsGridView.SelectedRow;
                int emailID = 0;
                int.TryParse(row.Cells[0].Text, out emailID);

                readEmailID_HiddenFiled.Value = emailID.ToString();
                readEmail_FromLabel.Text = row.Cells[3].Text;
                readEmail_ToLabel.Text = row.Cells[4].Text;
                readEmail_subjectLabel.Text = row.Cells[5].Text;
                readEmail_DateLabel.Text = row.Cells[6].Text;

                readEmail_bodyMessage.Text = Utils.ModuleMain().GetMessageBody(emailID);
                List<int> listEmailsID = new List<int>();
                listEmailsID.Add(emailID);

                Utils.ModuleMain().MakeLocalMessageAsSpecificStatus(listEmailsID, Constants.EmailMessageStatus.Readed);

                ShowPanel(readEmailPanel.ID);
            }
        }
        catch { }
    }

    protected void inbox_emailsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                    
            for (int i = 3; i < e.Row.Cells.Count; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = this.Page.ClientScript.GetPostBackClientHyperlink(this.inbox_emailsGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }

    protected void deletedMailsLinkButton_Click(object sender, EventArgs e)
    {
        ShowPanel(deletedEmailsPanel.ID);
    }

    protected void somposeMessageSendButton_Click(object sender, EventArgs e)
    {
        try
        {
            int messageType = 0;
            int.TryParse(composeEmail_MessageTypeDDL.SelectedValue, out messageType);

            switch (messageType)
            {
                case Constants.EmailMessageTypes.Email:
                    break;

                case Constants.EmailMessageTypes.SystemMessage:
                    int toUserID = 0;
                    int.TryParse(composeEmailToUsersDDL.SelectedValue, out toUserID);
                    
                    string subject = composeEmail_Subject.Text.Trim();
                    string bodyEmail = composeEMail_MessageBodyTextBox.Text;

                    int fromUserID = Utils.UserObject().UserID;

                    bool sendToUser = Utils.ModuleMain().SaveMessage(toUserID, fromUserID, toUserID.ToString(), messageType, subject, DateTime.Now, Constants.EmailMessageStatus.UnReaded, bodyEmail, Constants.EmailScope.InBox);
                    bool sendTome = Utils.ModuleMain().SaveMessage(fromUserID, fromUserID, toUserID.ToString(), messageType, subject, DateTime.Now, Constants.EmailMessageStatus.Readed, bodyEmail, Constants.EmailScope.OutBox);

                    if (sendToUser && sendTome) 
                    {
                        ShowPanel(inboxPanel.ID);
                    }

                    break;
            }
        }
        catch { }
    }

    protected void composeEmail_MessageTypeDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (composeEmail_MessageTypeDDL.SelectedValue != null)
        {
            int selectedType = 0;
            int.TryParse(composeEmail_MessageTypeDDL.SelectedValue, out selectedType);

            switch (selectedType)
            {
                case Constants.EmailMessageTypes.SystemMessage:
                    composeEmailToUsersDDL.Visible = true;
                    composeEmailTo_TextBox.Visible = false;
                    break;

                case Constants.EmailMessageTypes.Email:
                    composeEmailToUsersDDL.Visible = true;
                    composeEmailTo_TextBox.Visible = false;
                    break;
            }
        }
    }

    protected void sendedGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        readEmailID_HiddenFiled.Value = string.Empty;
        readEmail_subjectLabel.Text = string.Empty;
        readEmail_FromLabel.Text = string.Empty;
        readEmail_DateLabel.Text = string.Empty;
        readEmail_bodyMessage.Text = string.Empty;

        try
        {
            if (sendedGridView.SelectedRow != null)
            {
                GridViewRow row = sendedGridView.SelectedRow;
                int emailID = 0;
                int.TryParse(row.Cells[0].Text, out emailID);

                readEmailID_HiddenFiled.Value = emailID.ToString();
                readEmail_FromLabel.Text = row.Cells[2].Text;
                readEmail_ToLabel.Text = row.Cells[3].Text;
                readEmail_subjectLabel.Text = row.Cells[4].Text;
                readEmail_DateLabel.Text = row.Cells[5].Text;

                readEmail_bodyMessage.Text = Utils.ModuleMain().GetMessageBody(emailID);

                ShowPanel(readEmailPanel.ID);
            }
        }
        catch { }
    }

    protected void sendedGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

            for (int i = 2; i < e.Row.Cells.Count; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = this.Page.ClientScript.GetPostBackClientHyperlink(this.sendedGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }

    protected void sendedEmailsDeleteImageButton_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            List<int> messagesIDList = new List<int>();

            for (int i = 0; i < sendedGridView.Rows.Count; i++)
            {
                CheckBox ckBx = (CheckBox)sendedGridView.Rows[i].Cells[1].FindControl("checkBoxID");

                if (ckBx != null && ckBx.Checked)
                {
                    int messageID = 0;
                    int.TryParse(sendedGridView.Rows[i].Cells[0].Text, out messageID);

                    messagesIDList.Add(messageID);
                }
            }

            Utils.ModuleMain().MoveLocalMessageInSpecificFolder(messagesIDList, Constants.EmailScope.Deleted);
            FillSendedEmailsGridView();
        }
        catch { }
    }

    protected void deletedEmailsDeleteImageButton_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            List<int> forDelete = new List<int>();

            for (int i = 0; i < deletedEmailsGridView.Rows.Count; i++)
            {
                CheckBox ckBx = (CheckBox)deletedEmailsGridView.Rows[i].Cells[0].FindControl("checkBoxID");

                if (ckBx != null && ckBx.Checked)
                {
                    int messageID = 0;
                    int.TryParse(deletedEmailsGridView.Rows[i].Cells[0].Text, out messageID);

                    forDelete.Add(messageID);
                }
            }

            Utils.ModuleMain().DeleteMessage(forDelete);
            FillDeletedEmailsGridView();
        }
        catch { }
    }

    protected void deletedEmailsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        readEmailID_HiddenFiled.Value = string.Empty;
        readEmail_subjectLabel.Text = string.Empty;
        readEmail_FromLabel.Text = string.Empty;
        readEmail_DateLabel.Text = string.Empty;
        readEmail_bodyMessage.Text = string.Empty;

        try
        {
            if (deletedEmailsGridView.SelectedRow != null)
            {
                GridViewRow row = deletedEmailsGridView.SelectedRow;
                int emailID = 0;
                int.TryParse(row.Cells[0].Text, out emailID);

                readEmailID_HiddenFiled.Value = emailID.ToString();
                readEmail_FromLabel.Text = row.Cells[2].Text;
                readEmail_ToLabel.Text = row.Cells[3].Text;
                readEmail_subjectLabel.Text = row.Cells[4].Text;
                readEmail_DateLabel.Text = row.Cells[5].Text;

                readEmail_bodyMessage.Text = Utils.ModuleMain().GetMessageBody(emailID);

                ShowPanel(readEmailPanel.ID);
            }
        }
        catch { }
    }

    protected void deletedEmailsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";

            for (int i = 2; i < e.Row.Cells.Count; i++)
            {
                e.Row.Cells[i].Attributes["onclick"] = this.Page.ClientScript.GetPostBackClientHyperlink(this.deletedEmailsGridView, "Select$" + e.Row.RowIndex);
            }
        }
    }

    protected void readEmailReplayImageButton_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string subject = readEmail_subjectLabel.Text.Trim();
            string bodyMessage = readEmail_bodyMessage.Text.Trim();
            string dateEmail = readEmail_DateLabel.Text;
            string emailFrom = readEmail_FromLabel.Text;
            string emailTo = readEmail_DateLabel.Text;

            string newMessageBody = "\r\n\r\n";
            newMessageBody += "----------------------------------- \r\n";
            newMessageBody += " Message was writed by: " + emailFrom + "\r\n";
            newMessageBody += " For: " + emailTo + "\r\n";
            newMessageBody += " On date: " + dateEmail + "\r\n\r\n";
            newMessageBody += " Original message: \r\n  \r\n";
            newMessageBody += bodyMessage;

            ShowPanel(composePanel.ID);

            try
            {
                composeEmail_MessageTypeDDL.SelectedValue = Constants.EmailMessageTypes.SystemMessage.ToString();

                composeEmailToUsersDDL.ClearSelection();
                composeEmailToUsersDDL.SelectedValue = composeEmailToUsersDDL.Items.FindByText(emailFrom).Value;
            }
            catch { }

            composeEmail_Subject.Text = "Re: " + subject;
            composeEMail_MessageBodyTextBox.Text = newMessageBody;
        }
        catch { }
    }

    protected void readEmailForwardImageButton_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string subject = readEmail_subjectLabel.Text.Trim();
            string bodyMessage = readEmail_bodyMessage.Text.Trim();
            string dateEmail = readEmail_DateLabel.Text;
            string emailFrom = readEmail_FromLabel.Text;
            string emailTo = readEmail_DateLabel.Text;

            string newMessageBody = "\r\n\r\n";
            newMessageBody += "----------------------------------- \r\n";
            newMessageBody += " Message was writed by: " + emailFrom + "\r\n";
            newMessageBody += " For: " + emailTo + "\r\n";
            newMessageBody += " On date: " + dateEmail + "\r\n\r\n";
            newMessageBody += " Original message: \r\n  \r\n";
            newMessageBody += bodyMessage;

            ShowPanel(composePanel.ID);

            try
            {
                composeEmail_MessageTypeDDL.SelectedValue = Constants.EmailMessageTypes.SystemMessage.ToString();
            }
            catch { }

            composeEmail_Subject.Text = "Fwd: " + subject;
            composeEMail_MessageBodyTextBox.Text = newMessageBody;
        }
        catch { }
    }

    protected void readEmailDeleteImageButton_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            int emailID = 0;
            int.TryParse(readEmailID_HiddenFiled.Value, out emailID);

            if (emailID > 0)
            {
                List<int> messagesIDList = new List<int>();
                messagesIDList.Add(emailID);

                Utils.ModuleMain().MoveLocalMessageInSpecificFolder(messagesIDList, Constants.EmailScope.Deleted);
                ShowPanel(lastPanelHiddenField.Value);
            }
        }
        catch { }
    }
}