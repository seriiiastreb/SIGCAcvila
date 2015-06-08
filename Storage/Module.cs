using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;

namespace Store
{
    public class Module
    {
        public const string ID = "Module Store";
        public const string Description = "Warehouse management";
        public static readonly string DBConnectionsStringKey = "mainDBConnectionString";
        public static DataBridge mDataBridge = new DataBridge(ConfigManager.GetDbConnectionString(Module.DBConnectionsStringKey), ConfigManager.GetProviderName(Module.DBConnectionsStringKey));

        private string Plus = string.Empty;

        string mLastError = string.Empty;
        public string LastError
        {
            get { return mLastError; }
        }

        public static void Register()
        {
            Security.Registrar.RegisterModule(ID, Description);
            Domains.WarehouseManagement.Register();
        }

        public Module()
        {
            Plus = Module.mDataBridge.ConcatSimbol + " ' ' " + Module.mDataBridge.ConcatSimbol;
        }
    }

    namespace Domains
    {
        public class WarehouseManagement
        {
            public static readonly string Name = "Warehouse Management";
            public static readonly string Description = "Warehouse Management";

            public static void Register()
            {
                Security.Registrar.RegisterDomain(Store.Module.ID, Name, Description);
            }
        }

       

    }
}

