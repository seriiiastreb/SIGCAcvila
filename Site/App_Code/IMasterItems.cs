using System;

public interface IMasterItems
{
    void ShowMessage(int messageType, string TitleWindow, string message);
    void PerformPreloadActions(string currentModuleId, string pageName);
    void AddNavlink(string linkName, string linkURL, string linkID);
    bool IsEmptyNavLinks{ get; }
    void ClearNavLinks();
    void ShowMainMenu();

}



