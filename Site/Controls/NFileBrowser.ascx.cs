using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using IZ.WebFileManager;

public partial class Controls_NFileBrowser : System.Web.UI.UserControl
{
    Unit mWidth = 820;
    string mTitleWindow = "File Browser";
    string defaultDirectory = "~/Files";

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

    public string RootDirectory
    {
        get { return (string)ViewState[this.ClientID + "FB"]; }
        set { ViewState[this.ClientID + "FB"] = value; }
    }   

    public void Show()
    {
        if (!string.IsNullOrEmpty(this.RootDirectory))
        {
            WindowTitleLabel.Text = mTitleWindow;

            FileManager.RootDirectories.Clear();
            RootDirectory rootDirectory = new RootDirectory();    
            rootDirectory.DirectoryPath = this.RootDirectory;
            rootDirectory.Text = "PersonalFolder";
            FileManager.RootDirectories.Add(rootDirectory);
            FileManager.Directory = null;
        }

        programmaticPopup.Style.Value = "background-color:white; border: 1px solid Gray; ";
        modalPopup.Show();
    }

    public void Hide()
    {
        modalPopup.Hide();
    }

    protected void cancelButton_Click(object sender, EventArgs e)
    {
        programmaticPopup.Style.Value = "background-color:white; border: 1px solid Gray; display:none;";
        modalPopup.Hide();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        WindowTitleLabel.Text = mTitleWindow;
    }

    protected void uploadButtonButton_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFiles)
        {
            foreach (HttpPostedFile uploadedFile in FileUpload1.PostedFiles)
            {
                uploadedFile.SaveAs(Server.MapPath(FileManager.RootDirectories[0] + "/" + uploadedFile.FileName)); 
            }
        }

        modalPopup.Show();
    }
}