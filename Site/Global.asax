<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {    

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        //// Code that runs when a new session is started
        //#region Initializarea Tabelelor pentru Foto in Session
        //System.Data.DataTable newConsultPhotoFiles = new System.Data.DataTable();
        //newConsultPhotoFiles.Columns.Add(Constants.ConsultEvalPhoto_ColumnNames.photoID, typeof(int));
        //newConsultPhotoFiles.Columns.Add(Constants.ConsultEvalPhoto_ColumnNames.clevID, typeof(int));
        //newConsultPhotoFiles.Columns.Add(Constants.ConsultEvalPhoto_ColumnNames.PhotoLink, typeof(string));
        //newConsultPhotoFiles.Columns.Add(Constants.ConsultEvalPhoto_ColumnNames.SmallPhotoLink, typeof(string));
        //newConsultPhotoFiles.Columns.Add(Constants.ConsultEvalPhoto_ColumnNames.OriginalFileName, typeof(string));
        //newConsultPhotoFiles.Columns.Add(Constants.ConsultEvalPhoto_ColumnNames.GlobalPahtFile, typeof(string));

        //System.Data.DataTable editConsultPhotoFiles = newConsultPhotoFiles.Clone();

        ////if (Session[Constants.SessionPhotoTable.newConsultPhotoFiles] == null)
        ////{
        ////    Session[Constants.SessionPhotoTable.newConsultPhotoFiles] = newConsultPhotoFiles;
        ////}

        //if (Session[Constants.SessionPhotoTable.ConsultEvalPhotoFiles] == null)
        //{
        //    Session[Constants.SessionPhotoTable.ConsultEvalPhotoFiles] = editConsultPhotoFiles;
        //}
               
        //#endregion Initializarea Tabelelor pentru Foto in Session
    }

    //private void RemoveFogetFiles(string panelName)
    //{
    //    if (Session[panelName] != null)
    //    {
    //        System.Data.DataTable fileTable = (System.Data.DataTable)Session[panelName];
    //        if (fileTable != null)
    //        {
    //            for (int i = 0; i < fileTable.Rows.Count; i++)
    //            {
    //                if (fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.photoID].ToString().Equals(string.Empty)
    //                    && fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.clevID].ToString().Equals(string.Empty))
    //                {
    //                    string bigFotoLink = fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.PhotoLink].ToString();
    //                    string smallFotoLink = fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.SmallPhotoLink].ToString();
    //                    string globalPahtFilePath = fileTable.Rows[i][Constants.ConsultEvalPhoto_ColumnNames.GlobalPahtFile].ToString();

    //                    if (System.IO.File.Exists(Server.MapPath(globalPahtFilePath + "/" + bigFotoLink))) System.IO.File.Delete(Server.MapPath(globalPahtFilePath + "/" + bigFotoLink));
    //                    if (System.IO.File.Exists(Server.MapPath(globalPahtFilePath + "/" + smallFotoLink))) System.IO.File.Delete(Server.MapPath(globalPahtFilePath + "/" + smallFotoLink));
    //                }
    //            }

    //            fileTable.AcceptChanges();
    //        }

    //        Session[panelName] = null;
    //    }
    //}

    
    void Session_End(object sender, EventArgs e)
    {
        ////RemoveFogetFiles(Constants.SessionPhotoTable.newConsultPhotoFiles);
        //RemoveFogetFiles(Constants.SessionPhotoTable.ConsultEvalPhotoFiles);      
    }
       
</script>
