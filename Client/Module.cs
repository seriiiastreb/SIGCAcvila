using System;
using System.Collections.Generic;
using System.Text;
using DAL;

namespace Client
{
    public class Module
    {
        public const string ID = "Module Customers";
        public const string Description = "Processing data customer related";
        public static readonly string DBConnectionsStringKey = "mainDBConnectionString";
        public static DataBridge DataBridge = new DataBridge(ConfigManager.GetDbConnectionString(Module.DBConnectionsStringKey), ConfigManager.GetProviderName(Module.DBConnectionsStringKey));

        private string Plus = string.Empty;

        string mLastError = string.Empty;
        public string LastError
        {
            get { return mLastError; }
        }

        public Module()
        {
            Plus = Module.DataBridge.ConcatSimbol + " ' ' " + Module.DataBridge.ConcatSimbol;
        }


    }

    namespace Domains
    {
        /// <summary>
        /// Default domain. Calculations.
        /// </summary>
        public class ClientsInputData
        {
            public static readonly string Name = "Customers Input Data";
        }
    }

}
