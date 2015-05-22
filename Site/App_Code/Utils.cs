using System;
using System.Data;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using AjaxControlToolkit;
using System.Collections;
using System.Globalization;
using System.Drawing;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Runtime.Serialization;
using System.Reflection;
using System.Runtime.CompilerServices;

[assembly: AssemblyVersion("1.0.*")]

public class Utils
{
    #region Email Settings

    public static string EmailTemplate(string toEmail, string[] replaceFields, string[] fieldsArray, string legalEntity, DataTable templateTable, int languageID, int event_type)
    {
        string response = string.Empty;
        try
        {
            if (templateTable != null && templateTable.Rows.Count == 1)
            {
                string emailSubject = templateTable.Rows[0]["subject"].ToString();
                string emailTemplate = templateTable.Rows[0]["text"].ToString();
                if (emailTemplate != null && emailTemplate.Length > 0)
                {
                    if (fieldsArray != null && fieldsArray.Length > 0)
                    {
                        for (int indexKey = 0; indexKey < fieldsArray.Length; indexKey++)
                        {
                            emailTemplate = emailTemplate.Replace("[" + fieldsArray[indexKey].Trim() + "]", replaceFields[indexKey]);
                        }
                    }
                }

                response = EmailSend(toEmail, emailTemplate, emailSubject);
            }
        }
        catch (Exception e)
        {
            response = "Error sending mail: Exception!!!" + e.Message;
        }
        return response;
    }

    public static string EmailSend(string toEmail, string emailTemplate, string emailSubject)
    {
        string response = string.Empty;

        try
        {
            string to = toEmail;
            string smtpHost = ConfigurationManager.AppSettings["smtpHost"];

            string emailFrom = ConfigurationManager.AppSettings["emailFrom"];

            if (!string.IsNullOrEmpty(emailFrom.Trim()))
            {

                string fromDisplay = ConfigurationManager.AppSettings["fromDisplay"];
                string smtpUser = ConfigurationManager.AppSettings["smtpUser"];
                string password = ConfigurationManager.AppSettings["smtpPassword"];

                int smtpPort = 25;
                int.TryParse(ConfigurationManager.AppSettings["smtpPort"], out smtpPort);
                if (smtpPort == 0)
                {
                    smtpPort = 25;
                }

                string body = @"<html><body><div style=""font-family:arial;font-size:12pt;"">";

                if (emailTemplate.Trim() != string.Empty)
                {
                    body += "<pre>";
                    body += emailTemplate;
                    body += "</pre>";
                    body += @"</div></body></html>";

                    // AuthTypes: "Basic", "NTLM", "Digest", "Kerberos", "Negotiate"
                    string authType = "Basic";
                    string bccTo = string.Empty;
                    string copyTo = string.Empty;

                    response = SendEmail(emailFrom, fromDisplay, to, emailFrom, emailFrom, copyTo, bccTo, emailSubject,
                        body, System.Text.Encoding.ASCII, System.Text.Encoding.UTF8,
                        true, smtpHost, smtpUser, password, smtpPort, authType);
                }
                else
                {
                    response = "Unable to send to an empty email address!";
                }
            }
            else
            {
                response = "Error. Empty address in from field.";
            }
        }
        catch (Exception e)
        {
            response = "Error sending mail: Exception!!!" + e.Message;
        }

        return response;
    }

    static string SendEmail(string from, string fromDisplay, string to, string sender,
       string replyTo, string copyTo, string bccTo, string subject, string body, System.Text.Encoding subjectEncoding,
       System.Text.Encoding bodyEncoding, bool isBodyHtml, string smtpHost, string smtpUser,
       string smtpPass, int smtpPort, string smtpAuthType)
    {
        string response = null;
        System.Net.Mail.MailAddress fromAddress = new System.Net.Mail.MailAddress(from, fromDisplay);
        System.Net.Mail.MailAddress toAddress = new System.Net.Mail.MailAddress(to);
        System.Net.Mail.MailAddress senderAddress = new System.Net.Mail.MailAddress(sender);
        System.Net.Mail.MailAddress replyToAddress = new System.Net.Mail.MailAddress(replyTo);
        System.Net.Mail.MailMessage emailMessage = new System.Net.Mail.MailMessage(fromAddress, toAddress);

        if (!copyTo.Equals(string.Empty))
        {
            System.Net.Mail.MailAddress copyToAddress = new System.Net.Mail.MailAddress(copyTo);
            emailMessage.CC.Add(copyToAddress);
        }

        if (!bccTo.Equals(string.Empty))
        {
            System.Net.Mail.MailAddress bccToAddress = new System.Net.Mail.MailAddress(bccTo);
            emailMessage.Bcc.Add(bccToAddress);
        }

        emailMessage.Body = body;
        emailMessage.Sender = senderAddress;
        emailMessage.ReplyTo = replyToAddress;
        emailMessage.SubjectEncoding = subjectEncoding;
        emailMessage.BodyEncoding = bodyEncoding;
        emailMessage.Subject = subject;
        emailMessage.IsBodyHtml = isBodyHtml;
        emailMessage.Priority = System.Net.Mail.MailPriority.High;

        System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(smtpHost);
        bool enableSsl = true;
        bool.TryParse(ConfigurationManager.AppSettings["EnableSsl"], out enableSsl);

        smtp.EnableSsl = enableSsl;
        smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;

        // Note: on GoDaddy host the creadentials are unnecessary
        bool withCredentials = false;
        bool.TryParse(ConfigurationManager.AppSettings["smtpUseCredentials"], out withCredentials);
        if (withCredentials)
        {
            smtp.UseDefaultCredentials = false;
            System.Net.NetworkCredential networkCredential = new System.Net.NetworkCredential(smtpUser, smtpPass);
            smtp.Credentials = (System.Net.ICredentialsByHost)networkCredential.GetCredential(smtpHost, smtpPort, smtpAuthType);
        }

        try
        {
            smtp.Send(emailMessage);
        }
        catch (System.Net.Mail.SmtpException smtpException)
        {
            response = smtpException.Message;
            response = response.Replace("\r\n", "");
            response = response.Replace("\"", "");
            response = response.Insert(0, "SMTP Agent Error: ");
        }
        catch (Exception ex)
        {
            response = ex.Message;
            response = response.Replace("\r\n", "");
            response = response.Replace("\"", "");
            response = response.Insert(0, "Error: ");
        }
        return response;
    }



    #endregion Email Settings

    public static TreeNode FindNode(TreeNode treenode, string name)
    {
        // Ищем в узлах первого уровня.
        foreach (TreeNode tn in treenode.ChildNodes)
        {
            // Если нашли,
            if (tn.Value == name) { return tn; }  // то возвращаем.

        }
        // Ищем в подузлах.
        TreeNode node;
        foreach (TreeNode tn in treenode.ChildNodes)
        {
            // Делаем поиск в узлах.
            node = FindNode(tn, name);
            // Если нашли,
            if (node != null) { return node; } // то возвращаем.
        }

        return null;
    }

    public static TreeNode FindNode(TreeView tv, string name)
    {
        // Ищем в узлах первого уровня.
        foreach (TreeNode tn in tv.Nodes)
        {
            if (tn.Value == name) { return tn; } // то возвращаем.
        }
        // Ищем в подузлах.
        TreeNode node;
        foreach (TreeNode tn in tv.Nodes)
        {
            // Делаем поиск в узлах.
            node = FindNode(tn, name);
            // Если нашли,
            if (node != null) { return node; } // то возвращаем.
        }

        return null;
    }

    public static void FillSelector(DropDownList destinationDDl, DataTable inputTable, string displayTextField, string valueField)
    {
        try
        {
            if (inputTable == null)
            {
                inputTable = new DataTable();
                inputTable.Columns.Add(valueField, typeof(string));
                inputTable.Columns.Add(displayTextField, typeof(string));

                inputTable.NewRow();
                inputTable.Rows.Add();
                inputTable.Rows[0][valueField] = "0";
                inputTable.Rows[0][displayTextField] = "**";
            }

            if (destinationDDl != null && inputTable != null)
            {
                destinationDDl.DataSource = null;
                destinationDDl.DataSource = inputTable;
                destinationDDl.DataValueField = valueField;
                destinationDDl.DataTextField = displayTextField;
                destinationDDl.DataBind();
            }
        }
        catch { }
    }
    
    public static void InfoText(System.Web.UI.Page inputPage, string messageTitle, string message)
    {
        Label infoWindowTitleLabel = (Label)inputPage.Master.FindControl("infoWindowTitleLabel");
        ToolkitScriptManager toolkitScriptManager1 = (ToolkitScriptManager)inputPage.Master.FindControl("ToolkitScriptManager1");

        if (infoWindowTitleLabel != null)
        {
            if (toolkitScriptManager1.IsInAsyncPostBack)
            {
                toolkitScriptManager1.RegisterDataItem(infoWindowTitleLabel, messageTitle);
            }
            else
            { infoWindowTitleLabel.Text = messageTitle; }
        }

        Label infoWindowMessageLabel = (Label)inputPage.Master.FindControl("infoWindowMessageLabel");
        if (infoWindowMessageLabel != null)
        {
            if (toolkitScriptManager1.IsInAsyncPostBack)
            {
                toolkitScriptManager1.RegisterDataItem(infoWindowMessageLabel, message);
            }
            else
            {
                infoWindowMessageLabel.Text = message;
            }
        }

        ModalPopupExtender infoLabelMaster = (ModalPopupExtender)inputPage.Master.FindControl("infoWindowPopupExtender");
        if (infoLabelMaster != null)
        {
            infoLabelMaster.Show();
        }
    }

    public static string GetApplicationPath(HttpRequest Request)
    {
        string appPath = Request.ApplicationPath;

        if (appPath.Length == 1 && appPath.Equals("/"))
        {
            appPath = string.Empty;
        }

        return appPath;
    }

    public static string GetBuildNumber()
    {
        string buildNumber = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
        string[] buildNumberSplited = buildNumber.Split('.');
        return buildNumberSplited[buildNumberSplited.Length - 1];
    }

    public static bool ContentTypeAllowed(string contentType)
    {
        bool result = false;

        contentType = contentType.ToLower();

        if (contentType.Equals(Constants.ContentType.DOC)
                        || contentType.Equals(Constants.ContentType.DOCX)
                        || contentType.Equals(Constants.ContentType.ODS)
                        || contentType.Equals(Constants.ContentType.ODT)
                        || contentType.Equals(Constants.ContentType.PDF)
                        || contentType.Equals(Constants.ContentType.RTF)
                        || contentType.Equals(Constants.ContentType.TXT)
                        || contentType.Equals(Constants.ContentType.CSV)
                        || contentType.Equals(Constants.ContentType.XLS)
                        || contentType.Equals(Constants.ContentType.XLSX)
                        || contentType.Equals(Constants.ContentType.ZIP)
                        || contentType.Equals(Constants.ContentType.ZIPX)
                        || contentType.Equals(Constants.ContentType.ZIPCompressed)
                        || contentType.Equals(Constants.ContentType.ZIPCompressedX)
                        || contentType.Equals(Constants.ContentType.ZIPMultipart)
                        || contentType.Equals(Constants.ContentType.ZIPMultipartX)
                        || contentType.Equals(Constants.ContentType.DownloadX)
                        || contentType.Equals(Constants.ContentType.Download)
                        || contentType.Equals(Constants.ContentType.PNG)
                        || contentType.Equals(Constants.ContentType.JPEGP)
                        || contentType.Equals(Constants.ContentType.JPG)
                        || contentType.Equals(Constants.ContentType.JPEG)
                            )
        {
            result = true;
        }

        return result;
    }
    
    public static IMasterItems GetMaster(System.Web.UI.Page page)
    {
        IMasterItems myMaster = (IMasterItems)page.Master;
        return myMaster;
    }

    public static Credits.Module ModuleCredits()
    {
        Credits.Module  mModuleCredits = (Credits.Module)HttpContext.Current.Session["ModuleCredits"];
        if (mModuleCredits == null) HttpContext.Current.Response.Redirect(Utils.GetApplicationPath(HttpContext.Current.Request) + "/Default.aspx");
        return mModuleCredits;
    }


    public static Security.Module ModuleSecurity()
    {
        Security.Module mModuleSecurity = (Security.Module)HttpContext.Current.Session["ModuleSecurity"];
        if (mModuleSecurity == null) HttpContext.Current.Response.Redirect(Utils.GetApplicationPath(HttpContext.Current.Request) + "/Default.aspx");
        return mModuleSecurity;
    }

    public static Security.User UserObject()
    {
        Security.User mUserObject = (Security.User)HttpContext.Current.Session["UserObject"];
        if (mUserObject == null) HttpContext.Current.Response.Redirect(Utils.GetApplicationPath(HttpContext.Current.Request) + "/Default.aspx");
        return mUserObject;
    }

    public static Security.MainModule ModuleMain()
    {
        Security.MainModule mModuleMain = (Security.MainModule)HttpContext.Current.Session["ModuleMain"];
        if (mModuleMain == null) HttpContext.Current.Response.Redirect(Utils.GetApplicationPath(HttpContext.Current.Request) + "/Default.aspx");
        return mModuleMain;
    }

    public static bool PermissionAllowed(string moduleName, string domainName, Constants.Classifiers permission)
    {
        bool result = false;

        Security.User user = Utils.UserObject();
        if (user != null)
        {            
            result = user.PermissionAllowed(moduleName, domainName, (int)permission);           
        }

        return result;
    }

    public static bool AutentificatedUser
    {
        get
        {
            bool resulAutentification = false;
            Security.User userOBJ = (Security.User)HttpContext.Current.Session["UserObject"];

            if (userOBJ != null && userOBJ.UserID != 0)
                resulAutentification = true;

            return resulAutentification;
        }    
    }
    
}