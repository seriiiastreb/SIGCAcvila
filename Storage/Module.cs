using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using System.Data;
using System.Collections;

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

        #region Customers Products

        public DataTable GetProductsList()
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string query = @" 
                    SELECT 
                      product_id,
                      articol,
                        (SELECT Name from Classifiers Where Code = PD.articol) as articol_name, 
                      desen,
                        (SELECT Name from Classifiers Where Code = PD.desen) as desen_name, 
                      tip,
                        (SELECT Name from Classifiers Where Code = PD.tip) as tip_name, 
                      colorit,
                        (SELECT Name from Classifiers Where Code = PD.colorit) as colorit_name, 
                      latime,
                      lungime,
                      metraj,
                      festonare,
                        (SELECT Name from Classifiers Where Code = PD.festonare) as festonare_name, 
                      ean13
                    FROM 
                      ProductDetails as PD ;  ";

                result = mDataBridge.ExecuteQuery(query);
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool AddProduct(int articol, int desen, int tip, int colorit, decimal latime, decimal lungime, decimal metraj, int festonare, string ean13)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {              
                string nonQuery = @"INSERT INTO ProductDetails ( articol, desen, tip, colorit, latime, lungime, metraj, festonare, ean13 ) 
                                             VALUES ( @articol, @desen, @tip, @colorit, @latime, @lungime, @metraj, @festonare, @ean13); ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@articol", articol);
                parameters.Add("@desen", desen);
                parameters.Add("@tip", tip);
                parameters.Add("@colorit", colorit);
                parameters.Add("@latime", latime);
                parameters.Add("@lungime", lungime);
                parameters.Add("@metraj", metraj);
                parameters.Add("@festonare", festonare);
                parameters.Add("@ean13", ean13);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;                                
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool UpdateProduct(int product_id, int articol, int desen, int tip, int colorit, decimal latime, decimal lungime, decimal metraj, int festonare, string ean13)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"UPDATE 
                              ProductDetails  
                            SET 
                              articol = @articol,
                              desen = @desen,
                              tip = @tip,
                              colorit = @colorit,
                              latime = @latime,
                              lungime = @lungime,
                              metraj = @metraj,
                              festonare = @festonare,
                              ean13 = @ean13 
                            WHERE 
                              product_id = @product_id; ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@product_id", product_id);
                parameters.Add("@articol", articol);
                parameters.Add("@desen", desen);
                parameters.Add("@tip", tip);
                parameters.Add("@colorit", colorit);
                parameters.Add("@latime", latime);
                parameters.Add("@lungime", lungime);
                parameters.Add("@metraj", metraj);
                parameters.Add("@festonare", festonare);
                parameters.Add("@ean13", ean13);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool DeleteProduct(int product_id)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"DELETE FROM  ProductDetails  WHERE product_id = @product_id; ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@product_id", product_id);            

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        #endregion Customers Products

        #region Stok


        public DataTable GetStokList()
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string distinctDays = " SELECT DISTINCT day FROM Stok";
                DataTable days = mDataBridge.ExecuteQuery(distinctDays);
                mLastError = mDataBridge.LastError;

                if (days != null && days.Rows.Count > 0)
                {
                    string query = @" WITH MainTBL as (SELECT DISTINCT product_id FROM Stok)
                                , ProdDet as (SELECT 
                                product_id
                                , ClArt.Name as ""Articol"" 
                                , ClDesen.Name as ""Desen"" 
                                , ClTip.Name as ""Tip"" 
                                , ClColorit.Name as ""Colorit"" 
                                , latime as ""Latime""
                                , lungime as ""Lungime""  
                                , CLFestonare.Name as ""Festonare""
                                , ean13 as ""EAN13""                    
                                FROM productdetails PD
                                LEFT JOIN Classifiers as ClArt on ClArt.Code = PD.articol
                                LEFT JOIN Classifiers as ClDesen on ClDesen.Code = PD.desen
                                LEFT JOIN Classifiers as ClTip on ClTip.Code = PD.tip
                                LEFT JOIN Classifiers as ClColorit on ClColorit.Code = PD.colorit
                                LEFT JOIN Classifiers as CLFestonare on CLFestonare.Code = PD.festonare)  ";

                    query += @" SELECT  
                            ProdDet.""Articol""  
                            ,ProdDet.""Desen""                             
                            ,ProdDet.""Tip""                             
                            ,ProdDet.""Colorit""   
                            ,ProdDet.""Latime""   
                            ,ProdDet.""Lungime""   
                            ,ProdDet.""Festonare""  
                            ,ProdDet.""EAN13""  ";
                    for (int i = 0; i < days.Rows.Count; i++)
                    {
                        query += ", ST" + i + ".quantity as \"" + days.Rows[i]["day"].ToString() + "\"   \r\n ";
                    }
                    query += "  FROM MainTBL  \r\n ";
                    query += " LEFT JOIN ProdDet ON ProdDet.product_id = MainTBL.product_id ";
                    for (int i = 0; i < days.Rows.Count; i++)
                    {
                        query += " LEFT JOIN Stok as ST" + i + " ON ST" + i + ".product_id =  MainTBL.product_id AND ST" + i + ".day = '" + days.Rows[i]["day"].ToString() + "' ";
                    }

                    result = mDataBridge.ExecuteQuery(query);
                    mLastError = mDataBridge.LastError;
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool UpdateStok(int product_id, int articol, int desen, int tip, int colorit, decimal latime, decimal lungime, decimal metraj, int festonare, string ean13)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"UPDATE 
                              ProductDetails  
                            SET 
                              articol = @articol,
                              desen = @desen,
                              tip = @tip,
                              colorit = @colorit,
                              latime = @latime,
                              lungime = @lungime,
                              metraj = @metraj,
                              festonare = @festonare,
                              ean13 = @ean13 
                            WHERE 
                              product_id = @product_id; ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@product_id", product_id);
                parameters.Add("@articol", articol);
                parameters.Add("@desen", desen);
                parameters.Add("@tip", tip);
                parameters.Add("@colorit", colorit);
                parameters.Add("@latime", latime);
                parameters.Add("@lungime", lungime);
                parameters.Add("@metraj", metraj);
                parameters.Add("@festonare", festonare);
                parameters.Add("@ean13", ean13);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }


        #endregion Stok
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

