﻿using System;
using System.Web.UI.WebControls;

public interface IMasterItems
{
    void PerformPreloadActions(string currentModuleId, string pageName);
    void ShowMessage(int messageType, string TitleWindow, string message);
    //void AddNavlink(string linkName, string linkURL, string linkID);
    //bool IsEmptyNavLinks { get; }
    //void ClearNavLinks();

    void AddSubClientForm();

    //int SelectedSubClientID { set; }
    //DataObjects.Client SelectedClient { get; set; }
}

