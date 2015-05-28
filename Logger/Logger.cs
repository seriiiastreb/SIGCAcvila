using System;
using DAL;

public class Logger
{
    private static readonly string DBConnectionsStringKey = "mainDBConnectionString";
    public static DataBridge DataBridge = new DataBridge(ConfigManager.GetDbConnectionString(Logger.DBConnectionsStringKey), ConfigManager.GetProviderName(Logger.DBConnectionsStringKey));

    private string Plus = DataBridge.ConcatSimbol + " ' ' " +  DataBridge.ConcatSimbol;

    string mLastError = string.Empty;

    public string LastError
    {
        get { return mLastError; }
    }
  
    public static void WriteError(string message)
    {
        
    }

    public static void WriteWarning(string message)
    {
        
    }

    public static void WriteInfo(string message)
    {
        
    }

}

