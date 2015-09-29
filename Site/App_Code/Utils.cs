﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Collections;
using System.IO;
using System.Web.UI.WebControls;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Collections.Specialized;


public class Utils
{
    public const string SessionKey_UserObject = "UserObject";
    public const string SessionKey_ModuleSecurity = "ModuleSecurity";
    public const string SessionKey_ModuleMain = "ModuleMain";
    public const string SessionKey_ModuleCustomers = "ModuleCustomers";
    public const string SessionKey_ModuleStore = "ModuleStore";
    public const string SessionKey_HeadModuleSlector = "HeadModuleSlector";
    public const string SessionKey_ClientObject = "ClientObject";
    public const string SessionKey_OrderObject = "OrderObject";

    public const string Orders_HotNavogateKey = "Orders";
    public const string Customer_HotNavogateKey = "clientID";
    public const string CustomerPage_HotNavogateKey = "ClientsPageID";


	public Utils()
	{
	}

    #region Email
    /// <summary>
    /// Send email. The files to attach are passed as names of files on disk.
    /// </summary>
    /// <param name="emailFrom"></param>
    /// <param name="toEmail"></param>
    /// <param name="emailTemplate"></param>
    /// <param name="emailSubject"></param>
    /// <param name="listFileName"></param>
    /// <param name="bccTo"></param>
    /// <returns></returns>
    public static string SendEmailMessage(string emailFrom, string toEmail, string emailTemplate, string emailSubject, List<string> listFileName, string bccTo, string copyTo)
    {
        string response = string.Empty;
        emailFrom = emailFrom.Trim();

        try
        {
            if (!string.IsNullOrEmpty(toEmail))
            {
                string fromDisplay = string.IsNullOrEmpty(emailFrom) ? ConfigurationManager.AppSettings["fromDisplay"] : string.Empty;
                if (emailFrom.Equals(string.Empty)) emailFrom = ConfigurationManager.AppSettings["emailFrom"];

                if (!string.IsNullOrEmpty(emailFrom))
                {
                    string smtpHost = ConfigurationManager.AppSettings["smtpHost"];
                    string smtpUser = ConfigurationManager.AppSettings["smtpUser"];
                    string password = ConfigurationManager.AppSettings["smtpPassword"];

                    int smtpPort = 25;
                    int.TryParse(ConfigurationManager.AppSettings["smtpPort"], out smtpPort);
                    if (smtpPort == 0)
                    {
                        smtpPort = 25;
                    }

                    string body = @"<html><body><div style=""font-family:arial;font-size:12pt;"">";

                    if (toEmail.Trim() != string.Empty)
                    {
                        body += "<pre>";
                        body += emailTemplate;
                        body += "</pre>";
                        body += @"</div></body></html>";

                        // AuthTypes: "Basic", "NTLM", "Digest", "Kerberos", "Negotiate"
                        string authType = "Negotiate";

                        response = SendEmail(emailFrom, fromDisplay, toEmail, emailFrom, emailFrom, copyTo, bccTo, emailSubject,
                            body, System.Text.Encoding.ASCII, System.Text.Encoding.UTF8,
                            true, smtpHost, smtpUser, password, smtpPort, authType, listFileName);

                    }
                    else
                    {
                        response = "Error. Empty destination address";
                    }
                }
                else
                {
                    response = "Error. Empty FROM address";
                }
            }
        }
        catch (Exception e)
        {
            response = "Exception sending email: " + e.Message;
        }

        return response;
    }

    /// <summary>
    /// Send email. The files to attach are passed as hashtable with file bytes.
    /// </summary>
    /// <param name="emailFrom"></param>
    /// <param name="toEmail"></param>
    /// <param name="emailTemplate"></param>
    /// <param name="emailSubject"></param>
    /// <param name="htFiles"></param>
    /// <param name="bccTo"></param>
    /// <returns></returns>
    public static string SendEmailMessage(string emailFrom, string toEmail, string emailTemplate, string emailSubject, Hashtable htFiles, string bccTo, string copyTo)
    {
        string response = string.Empty;

        try
        {
            if (!string.IsNullOrEmpty(toEmail))
            {
                if (emailFrom.Equals(string.Empty)) emailFrom = ConfigurationManager.AppSettings["emailFrom"];

                if (!string.IsNullOrEmpty(emailFrom.Trim()))
                {
                    string fromDisplay = ConfigurationManager.AppSettings["fromDisplay"];

                    string smtpHost = ConfigurationManager.AppSettings["smtpHost"];
                    string smtpUser = ConfigurationManager.AppSettings["smtpUser"];
                    string password = ConfigurationManager.AppSettings["smtpPassword"];

                    int smtpPort = 25;
                    int.TryParse(ConfigurationManager.AppSettings["smtpPort"], out smtpPort);
                    if (smtpPort == 0)
                    {
                        smtpPort = 25;
                    }

                    string body = @"<html><body><div style=""font-family:arial;font-size:12pt;"">";

                    if (toEmail.Trim() != string.Empty)
                    {
                        body += "<pre>";
                        body += emailTemplate;
                        body += "</pre>";
                        body += @"</div></body></html>";

                        // AuthTypes: "Basic", "NTLM", "Digest", "Kerberos", "Negotiate"
                        string authType = "Basic";


                        response = SendEmail(emailFrom, fromDisplay, toEmail, emailFrom, emailFrom, copyTo, bccTo, emailSubject,
                            body, System.Text.Encoding.ASCII, System.Text.Encoding.UTF8,
                            true, smtpHost, smtpUser, password, smtpPort, authType, htFiles);

                    }
                    else
                    {
                        response = "Error. Empty destination address";
                    }
                }
                else
                {
                    response = "Error. Empty FROM address";
                }
            }
        }
        catch (Exception e)
        {
            response = "Exception sending email: " + e.Message;
        }

        return response;
    }

    static string SendEmail(string from, string fromDisplay, string to, string sender,
       string replyTo, string copyTo, string bccTo, string subject, string body, System.Text.Encoding subjectEncoding,
       System.Text.Encoding bodyEncoding, bool isBodyHtml, string smtpHost, string smtpUser,

        string smtpPass, int smtpPort, string smtpAuthType, List<string> listFileName)
    {
        string response = null;

        try
        {
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
            emailMessage.SubjectEncoding = Encoding.UTF8;
            emailMessage.BodyEncoding = Encoding.UTF8;

            emailMessage.Priority = System.Net.Mail.MailPriority.High;

            if (listFileName != null && listFileName.Count > 0)
            {
                for (int indexList = 0; indexList < listFileName.Count; indexList++)
                {
                    string fileName = listFileName[indexList];
                    System.Net.Mail.Attachment emailAttachment = new System.Net.Mail.Attachment(fileName);
                    emailMessage.Attachments.Add(emailAttachment);
                }
            }

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

    static string SendEmail(string from, string fromDisplay, string to, string sender,
   string replyTo, string copyTo, string bccTo, string subject, string body, System.Text.Encoding subjectEncoding,
   System.Text.Encoding bodyEncoding, bool isBodyHtml, string smtpHost, string smtpUser,
   string smtpPass, int smtpPort, string smtpAuthType, Hashtable htFiles)
    {
        string response = null;

        try
        {
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
            emailMessage.SubjectEncoding = Encoding.UTF8;
            emailMessage.BodyEncoding = Encoding.UTF8;

            emailMessage.Priority = System.Net.Mail.MailPriority.High;

            if (htFiles != null)
            {
                foreach (DictionaryEntry entry in htFiles)
                {
                    string fileName = (string)entry.Key;
                    byte[] fileContent = null;
                    if (entry.Value.GetType() == typeof(byte[]))
                    {
                        fileContent = (byte[])entry.Value;

                        System.Net.Mail.Attachment emailAttachment = new System.Net.Mail.Attachment(new MemoryStream(fileContent), fileName);
                        emailMessage.Attachments.Add(emailAttachment);
                    }
                }
            }

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
    #endregion Email	

    public static void DownloadStringAsFile(string fileString, Page sourcePage, string fileName)
    {
        if (!string.IsNullOrEmpty(fileString))
        {
            sourcePage.Response.Clear();
            sourcePage.Response.ClearHeaders();
            sourcePage.Response.ClearContent();

            byte[] fileInByte = System.Text.Encoding.UTF8.GetBytes(fileString);
            string fileNameEncoded = System.Web.HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8);
            sourcePage.Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileNameEncoded);
            sourcePage.Response.AppendHeader("Content-Length", fileInByte.Length.ToString());
            sourcePage.Response.AddHeader("Connection", "Keep-Alive");
            sourcePage.Response.ContentType = "application/download";
            sourcePage.Response.BinaryWrite(fileInByte);
            sourcePage.Response.Flush();
        }
    }

    //public static void DownloadFile(List<string> fileNames, string tempDirectoryFullPath, Page sourcePage)
    //{
    //    ////  adding files in one archive

    //    string zipFile = HRPM.Utils.ArchiveManager.ZIP.AddFileToArchive(fileNames, tempDirectoryFullPath, string.Empty, string.Empty);

    //    if (System.IO.File.Exists(zipFile))
    //    {
    //        string funal_fileName = Path.GetFileName(zipFile);
    //        byte[] fileInByte = System.IO.File.ReadAllBytes(zipFile);

    //        DownloadFile(fileInByte, sourcePage, funal_fileName);

    //        foreach (string file in fileNames)
    //        {
    //            if (System.IO.File.Exists(file))
    //            {
    //                System.IO.File.Delete(file);
    //            }
    //        }

    //        if (System.IO.File.Exists(zipFile))
    //        {
    //            System.IO.File.Delete(zipFile);
    //        }
    //    }
    //}

    public static void DownloadFile(byte[] fileInByte, Page sourcePage, string fileName)
    {
        if (fileInByte != null)
        {
            sourcePage.Response.Clear();
            sourcePage.Response.ClearHeaders();
            sourcePage.Response.ClearContent();

            string fileNameEncoded = System.Web.HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8);
            sourcePage.Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileNameEncoded);
            sourcePage.Response.AppendHeader("Content-Length", fileInByte.Length.ToString());
            sourcePage.Response.AddHeader("Connection", "Keep-Alive");
            sourcePage.Response.ContentType = "application/download";
            sourcePage.Response.BinaryWrite(fileInByte);
            sourcePage.Response.Flush();
        }
    }

    public static void FillSelector(DropDownList destinationSelector, DataTable sourceTable, string dataTextField, string dataValueField)
    {
        if (destinationSelector != null)
        {
            destinationSelector.ClearSelection();
            destinationSelector.DataSource = null;
            destinationSelector.DataBind();
            if (sourceTable != null
                && sourceTable.Columns.Contains(dataTextField)
                && sourceTable.Columns.Contains(dataValueField))
            {
                destinationSelector.DataSource = sourceTable;
                destinationSelector.DataValueField = dataValueField;
                destinationSelector.DataTextField = dataTextField;
                destinationSelector.DataBind();
                if (sourceTable != null && sourceTable.Rows.Count > 0)
                {
                    destinationSelector.SelectedIndex = 0;
                }
            }
        }
    }

    public static string GetTableAsHTMLFormatedTable(DataTable sourceTable, List<string> hiddenColumns, List<string> columnsToDisplay, string idtable, string doNavLink, string columnNameForDoNav)
    {
        string result = string.Empty;

        if (sourceTable != null && sourceTable.Rows.Count > 0)
        {
            result += "<table id=\"" + idtable + "\" style=\"border-collapse:collapse;\" border=\"1\" cellspacing=\"0\"> \r\n ";

            result += "<thead>\r\n <tr> \r\n ";
            for (int i = 0; i < columnsToDisplay.Count; i++)
            {
                if (sourceTable.Columns.Contains(columnsToDisplay[i]))
                    result += "<th " + (hiddenColumns.Contains(columnsToDisplay[i]) ? " class=\"hidden\" " : string.Empty) + ">" + columnsToDisplay[i] + "</th> \r\n";
            }
            result += "</tr> \r\n </thead>\r\n ";

            result += "<tbody>\r\n ";

            for (int r = 0; r < sourceTable.Rows.Count; r++)
            {
                result += "<tr " + (r % 2 == 1 ? " class=\"odd\" " : string.Empty) + (!doNavLink.Equals(string.Empty) ? "   onclick=\"DoNav('" + doNavLink + sourceTable.Rows[r][columnNameForDoNav].ToString() + "');\"  onmouseover=\"this.style.cursor='pointer';this.style.textDecoration='underline';\" onmouseout=\"this.style.textDecoration='none';\"      " : string.Empty) + " >\r\n";
                             
                for (int c = 0; c < columnsToDisplay.Count; c++)
                {
                    if (sourceTable.Columns.Contains(columnsToDisplay[c]))
                        result += "<td " + (hiddenColumns.Contains(columnsToDisplay[c]) ? " class=\"hidden\" " : string.Empty) + ">" + sourceTable.Rows[r][columnsToDisplay[c]].ToString() + "</td> \r\n";
                }

                result += "</tr> \r\n";
            }

            result += "</tbody>\r\n ";
            result += "</table>";
        }

        return result;
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

    public static void RedirectIfSslRequired(HttpRequest Request, HttpResponse Response)
    {
        //bool msNoSsl = false;

        //if (ConfigurationManager.AppSettings["noSSL"] != null && !string.IsNullOrEmpty(ConfigurationManager.AppSettings["noSSL"]))
        //{
        //    bool.TryParse(ConfigurationManager.AppSettings["noSSL"], out msNoSsl);
        //}

        //if (!msNoSsl
        //    && Request.IsSecureConnection.Equals(false)
        //    && Request.ServerVariables["SERVER_NAME"] != "localhost"
        //    && !Request.UserHostAddress.StartsWith("192.168"))
        //{
        //    string secureURL = "https://";
        //    secureURL += Request.ServerVariables["SERVER_NAME"];
        //    secureURL += Request.ServerVariables["URL"];
        //    Response.Redirect(secureURL);
        //}
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

    public static string GetQueryString(System.Web.HttpRequest Request, Page page)
    {
        string queryString = "";

        NameValueCollection qs = Request.QueryString;

        foreach (string key in qs.AllKeys)
            foreach (string value in qs.GetValues(key))
                queryString += page.Server.UrlEncode(key) + "=" + page.Server.UrlEncode(value) + "&";

        return queryString.TrimEnd('&');
    }

    public static IMasterItems GetMaster(System.Web.UI.Page page)
    {
        IMasterItems myMaster = (IMasterItems)page.Master;
        return myMaster;
    }

    public static Security.User UserObject()
    {
        Security.User mUserObject = (Security.User)HttpContext.Current.Session[SessionKey_UserObject];
        return mUserObject;
    }

    public static Security.Module ModuleSecurity()
    {
        Security.Module mModuleSecurity = (Security.Module)HttpContext.Current.Session[SessionKey_ModuleSecurity];
        return mModuleSecurity;
    }

    public static Security.MainModule ModuleMain()
    {
        Security.MainModule mModuleMain = (Security.MainModule)HttpContext.Current.Session[SessionKey_ModuleMain];
        return mModuleMain;
    }

    public static Client.Module ModuleCustomers()
    {
        Client.Module mModuleCustomers = (Client.Module)HttpContext.Current.Session[SessionKey_ModuleCustomers];
        return mModuleCustomers;
    } 

    public static Store.Module ModuleStore()
    {
        Store.Module mModuleStore = (Store.Module)HttpContext.Current.Session[SessionKey_ModuleStore];
        return mModuleStore;
    }

    //public static DataObjects.Client ClientObject
    //{
    //    get { DataObjects.Client clientObj = (DataObjects.Client)HttpContext.Current.Session[SessionKey_ClientObject];   return clientObj;  }
    //    set { HttpContext.Current.Session[Utils.SessionKey_ClientObject] = value; }
    //}

    public static DataObjects.Client SelectedClient
    {
        get
        {
            DataObjects.Client clientObject = HttpContext.Current.Session["currentSelectedSubClientObject"] != null ? (DataObjects.Client)HttpContext.Current.Session["currentSelectedSubClientObject"] : (DataObjects.Client)HttpContext.Current.Session["currentSelectedClientObject"];
            return clientObject != null ? clientObject : new DataObjects.Client();
        }

        set
        {
            DataObjects.Client clientObject = value;
            HttpContext.Current.Session["currentSelectedSubClientObject"] = null;

            if (clientObject != null)
            {
                //clientSelectionLink.Text = "Client: " + clientObject.FirstName + " " + clientObject.LastName;
                HttpContext.Current.Session["currentSelectedClientObject"] = clientObject;
                //selectedClientIDHiddenField.Value = clientObject.ClientID.ToString();
            }
        }
    }

    public static int SelectedSubClientID
    {
        set
        {
            HttpContext.Current.Session["currentSelectedSubClientObject"] = Utils.ModuleCustomers().GetCleintObjectByID((int)value);
        }
    }

    public static bool PermissionAllowed(string moduleName, string domainName, Constants.Classifiers permission)
    {
        bool result = false;

        try
        {
            Security.User user = Utils.UserObject();
            if (user != null)
            {
                result = user.PermissionAllowed(moduleName, domainName, (int)permission);
            }
        }
        catch(Exception ex)
        { Logger.WriteWarning("Security exception. User:" + Utils.UserObject().FirstName + " " + Utils.UserObject().LastName + " with ID:" + Utils.UserObject().UserID + " try acces {" + moduleName + "}, domain {" + domainName + "} but does not have access here. Excetion Message:" + ex.Message); }

        return result;
    }

    public static bool AutentificatedUser
    {
        get
        {
            bool resulAutentification = false;
            Security.User userOBJ = (Security.User)HttpContext.Current.Session[Utils.SessionKey_UserObject];

            if (userOBJ != null && userOBJ.UserID != 0)
                resulAutentification = true;

            return resulAutentification;
        }
    }

}