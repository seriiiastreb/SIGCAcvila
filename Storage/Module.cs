﻿using System;
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
                      lungime                     
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

        public bool AddProduct(int articol, int desen, int tip, int colorit, decimal latime, decimal lungime)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {              
                string nonQuery = @"INSERT INTO ProductDetails ( articol, desen, tip, colorit, latime, lungime ) 
                                    VALUES ( @articol, @desen, @tip, @colorit, @latime, @lungime); ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@articol", articol);
                parameters.Add("@desen", desen);
                parameters.Add("@tip", tip);
                parameters.Add("@colorit", colorit);
                parameters.Add("@latime", latime);
                parameters.Add("@lungime", lungime);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;                                
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool UpdateProduct(int product_id, int articol, int desen, int tip, int colorit, decimal latime, decimal lungime)
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


        public DataTable GetWeeksList()
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string distinctDays = " SELECT week FROM weeks ";
                result = mDataBridge.ExecuteQuery(distinctDays);
                mLastError = mDataBridge.LastError;

            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        #region Orders
        public DataTable GetOrdersHistory()
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string wekssql = @"SELECT DISTINCT week FROM Orders order by week asc ";
                DataTable weeksInOrders = mDataBridge.ExecuteQuery(wekssql);

                if (weeksInOrders != null && weeksInOrders.Rows.Count > 0)
                {
                    string query = @" WITH MainTBL as (SELECT DISTINCT product_id FROM Orders)
                                , ProdDet as (SELECT 
                                product_id
                                , ClArt.Name as ""Articol"" 
                                , ClDesen.Name as ""Desen"" 
                                , ClTip.Name as ""Tip"" 
                                , ClColorit.Name as ""Colorit"" 
                                , latime as ""Latime""
                                , lungime as ""Lungime""                
                                FROM productdetails PD
                                LEFT JOIN Classifiers as ClArt on ClArt.Code = PD.articol
                                LEFT JOIN Classifiers as ClDesen on ClDesen.Code = PD.desen
                                LEFT JOIN Classifiers as ClTip on ClTip.Code = PD.tip
                                LEFT JOIN Classifiers as ClColorit on ClColorit.Code = PD.colorit )
";
                    query += @" SELECT  
                             ProdDet.""Articol""  
                            ,ProdDet.""Desen""                             
                            ,ProdDet.""Tip""                             
                            ,ProdDet.""Colorit""   
                            ,ProdDet.""Latime""   
                            ,ProdDet.""Lungime""  ";

                    for (int i = 0; i < weeksInOrders.Rows.Count; i++)
                    {
                        query += ", coalesce(ORD" + i + ".quantity,0) as \"Confirmat " + weeksInOrders.Rows[i]["week"].ToString() + "\"   \r\n ";
                        query += ", coalesce(LVR" + i + ".quantity,0) as \"Livrat " + weeksInOrders.Rows[i]["week"].ToString() + "\"   \r\n ";
                    }

                    query += ", ";
                    for (int i = 0; i < weeksInOrders.Rows.Count; i++)
                    {
                        if (i > 0) query += " + ";
                        query += "  coalesce(ORD" + i + ".quantity,0) -   coalesce(LVR" + i + ".quantity,0)  \r\n ";
                    }
                    query += " as \"In Wey\" \r\n ";

                    query += "  FROM MainTBL  \r\n ";

                    query += " LEFT JOIN ProdDet ON ProdDet.product_id = MainTBL.product_id \r\n ";

                    for (int i = 0; i < weeksInOrders.Rows.Count; i++)
                    {
                        query += "  LEFT JOIN Orders as ORD" + i + " ON ORD" + i + ".product_id =  MainTBL.product_id AND ORD" + i + ".week = '" + weeksInOrders.Rows[i]["week"].ToString() + "' \r\n ";
                        query += "  LEFT JOIN Livrari as LVR" + i + " ON LVR" + i + ".product_id =  MainTBL.product_id AND LVR" + i + ".week = '" + weeksInOrders.Rows[i]["week"].ToString() + "' \r\n ";
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

        public DataTable CreateNewOrder(int clientID, string week)
        {
            DataTable result = new DataTable();

            try
            {
                string wekssql = @"SELECT DISTINCT week FROM Stok WHERE week < '" + week + "' order by week asc ";
                DataTable weeksInStok = mDataBridge.ExecuteQuery(wekssql);
                bool primaSaptamina = false;
                if (weeksInStok != null && weeksInStok.Rows.Count == 0) { weeksInStok.Rows.Add("0000"); primaSaptamina = true; }

                if (weeksInStok != null && weeksInStok.Rows.Count > 0)
                {
                    string query = @" WITH MainTBL as (SELECT DISTINCT product_id FROM Stok WHERE week <= '" + week + @"' )
                                , ProdDet as (SELECT 
                                product_id
                                , ClArt.Name as ""Articol"" 
                                , ClDesen.Name as ""Desen"" 
                                , ClTip.Name as ""Tip"" 
                                , ClColorit.Name as ""Colorit"" 
                                , latime as ""Latime""
                                , lungime as ""Lungime""                
                                FROM productdetails PD
                                LEFT JOIN Classifiers as ClArt on ClArt.Code = PD.articol
                                LEFT JOIN Classifiers as ClDesen on ClDesen.Code = PD.desen
                                LEFT JOIN Classifiers as ClTip on ClTip.Code = PD.tip
                                LEFT JOIN Classifiers as ClColorit on ClColorit.Code = PD.colorit )
";

                    query += @" SELECT  
                             ProdDet.product_id
                            ,ProdDet.""Articol""  
                            ,ProdDet.""Desen""                             
                            ,ProdDet.""Tip""                             
                            ,ProdDet.""Colorit""   
                            ,ProdDet.""Latime""   
                            ,ProdDet.""Lungime"" 
                            , coalesce(Kanban.quantity,0) as ""Kanban""  
, ";

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        if (i > 0) query += " + ";
                        query += "  coalesce(ORD" + i + ".quantity,0) -   coalesce(LVR" + i + ".quantity,0)  \r\n ";
                    }
                    query += " as \"In Wey\" \r\n ";

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        query += ", coalesce(ST" + i + ".quantity,0) as \"" + (primaSaptamina ? week : weeksInStok.Rows[i]["week"].ToString()) + "\"   \r\n ";
                    }

                    query += "  FROM MainTBL  \r\n ";
                    query += " LEFT JOIN ProdDet ON ProdDet.product_id = MainTBL.product_id \r\n ";
                    query += " LEFT JOIN Kanban ON Kanban.product_id = MainTBL.product_id \r\n ";

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        query += " LEFT JOIN Stok as ST" + i + " ON ST" + i + ".product_id =  MainTBL.product_id AND ST" + i + ".week = '" + weeksInStok.Rows[i]["week"].ToString() + "' \r\n ";
                    }

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        query += "  LEFT JOIN Orders as ORD" + i + " ON ORD" + i + ".product_id =  MainTBL.product_id AND ORD" + i + ".week = '" + weeksInStok.Rows[i]["week"].ToString() + "' \r\n ";
                        query += "  LEFT JOIN Livrari as LVR" + i + " ON LVR" + i + ".product_id =  MainTBL.product_id AND LVR" + i + ".week = '" + weeksInStok.Rows[i]["week"].ToString() + "' \r\n ";
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


        #endregion Orders

        #region Stok


        public DataTable GetStokList()
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string distinctDays = " SELECT DISTINCT week FROM Stok";
                DataTable weeksInStok = mDataBridge.ExecuteQuery(distinctDays);
                mLastError = mDataBridge.LastError;

                string distinctDaysVinzari = " SELECT DISTINCT week FROM Vinzari";
                DataTable weeksInVinzari = mDataBridge.ExecuteQuery(distinctDaysVinzari);
                mLastError = mDataBridge.LastError;

                if (weeksInStok != null && weeksInStok.Rows.Count > 0)
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
                                FROM productdetails PD
                                LEFT JOIN Classifiers as ClArt on ClArt.Code = PD.articol
                                LEFT JOIN Classifiers as ClDesen on ClDesen.Code = PD.desen
                                LEFT JOIN Classifiers as ClTip on ClTip.Code = PD.tip
                                LEFT JOIN Classifiers as ClColorit on ClColorit.Code = PD.colorit )
";

                    query += @" SELECT  
                            ProdDet.""Articol""  
                            ,ProdDet.""Desen""                             
                            ,ProdDet.""Tip""                             
                            ,ProdDet.""Colorit""   
                            ,ProdDet.""Latime""   
                            ,ProdDet.""Lungime"" 
                            , coalesce(Kanban.quantity,0) as ""Kanban""  
, ";

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        if (i > 0) query += " + ";
                        query += "  coalesce(ORD" + i + ".quantity,0) -   coalesce(LVR" + i + ".quantity,0)  \r\n ";
                    }
                    query += " as \"In Wey\" \r\n ";

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        query += ", coalesce(ST" + i + ".quantity,0) as \"" + weeksInStok.Rows[i]["week"].ToString() + "\"   \r\n ";
                    }

                    query += "  FROM MainTBL  \r\n ";
                    query += " LEFT JOIN ProdDet ON ProdDet.product_id = MainTBL.product_id \r\n ";
                    query += " LEFT JOIN Kanban ON Kanban.product_id = MainTBL.product_id \r\n ";

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        query += " LEFT JOIN Stok as ST" + i + " ON ST" + i + ".product_id =  MainTBL.product_id AND ST" + i + ".week = '" + weeksInStok.Rows[i]["week"].ToString() + "' \r\n ";
                    }

                    for (int i = 0; i < weeksInStok.Rows.Count; i++)
                    {
                        query += "  LEFT JOIN Orders as ORD" + i + " ON ORD" + i + ".product_id =  MainTBL.product_id AND ORD" + i + ".week = '" + weeksInStok.Rows[i]["week"].ToString() + "' \r\n ";
                        query += "  LEFT JOIN Livrari as LVR" + i + " ON LVR" + i + ".product_id =  MainTBL.product_id AND LVR" + i + ".week = '" + weeksInStok.Rows[i]["week"].ToString() + "' \r\n ";
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

        public bool UpdateStok(string week, int product_id, decimal quantity)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {        
                string nonQuery = @"UPDATE stok  SET quantity = @quantity WHERE  product_id = @product_id AND week = @week 

                                    INSERT INTO stok(product_id, week, quantity)
                                    SELECT @product_id, @week, @quantity 
                                    WHERE not exists (select 1 from stok WHERE product_id = @product_id AND week = @week) ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@product_id", product_id);
                parameters.Add("@week", week);
                parameters.Add("@quantity", quantity);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        public bool UpdateLivrari(string week, int product_id, decimal quantity)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"UPDATE Livrari  SET quantity = @quantity WHERE  product_id = @product_id AND week = @week 

                                    INSERT INTO Livrari(product_id, week, quantity)
                                    SELECT @product_id, @week, @quantity 
                                    WHERE not exists (select 1 from Livrari WHERE product_id = @product_id AND week = @week) ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@product_id", product_id);
                parameters.Add("@week", week);
                parameters.Add("@quantity", quantity);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool UpdateOrders(string week, DataTable productList)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = string.Empty;
                    
                if(productList != null && productList.Rows.Count > 0)
                {
                    Hashtable parameters = new Hashtable();

                    for(int i=0; i< productList.Rows.Count; i++)
                    {
                        nonQuery += "UPDATE Orders  SET quantity = @quantity" + i + " WHERE  product_id = @product_id" + i + " AND week = @week" + i + " \r\n ";
                        nonQuery += " INSERT INTO Orders(product_id, week, quantity) \r\n ";
                        nonQuery += " SELECT @product_id" + i + ", @week" + i + ", @quantity" + i + " \r\n ";
                        nonQuery += " WHERE not exists (select 1 from Orders WHERE product_id = @product_id" + i + " AND week = @week" + i + ") \r\n ";

                        int product_id = (int)productList.Rows[i]["product_id"];
                        decimal cantitate = (decimal)productList.Rows[i]["cantitate"];

                        parameters.Add("@product_id" + i, product_id);
                        parameters.Add("@week" + i, week);
                        parameters.Add("@quantity" + i, cantitate);
                    }

                    result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                    mLastError = mDataBridge.LastError;
                }        
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
           
        public bool UpdateKanban(int product_id, decimal quantity)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"UPDATE Kanban  SET quantity = @quantity WHERE  product_id = @product_id 

                                    INSERT INTO Kanban(product_id, quantity)
                                    SELECT @product_id, @quantity 
                                    WHERE not exists (select 1 from InWey WHERE product_id = @product_id) ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@product_id", product_id);
                parameters.Add("@quantity", quantity);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        public int DetectProduct(string articol, string desen , string tip, string colorit, decimal latime, decimal lungime)
        {
            int result = 0;
            mLastError = string.Empty;

            try
            {
                string distinctDays = @"select product_id from productDetails
                    WHERE 
                    articol = (select code from classifiers where name = @articol)
                    and desen = (select code from classifiers where name = @desen)
                    and tip = (select code from classifiers where name = @tip)
                    and colorit = (select code from classifiers where name = @colorit)
                    and latime = @latime
                    and lungime =  @lungime";

                Hashtable parameters = new Hashtable();
                parameters.Add("@articol", articol);
                parameters.Add("@desen", desen);
                parameters.Add("@tip", tip);
                parameters.Add("@colorit", colorit);
                parameters.Add("@latime", latime);
                parameters.Add("@lungime", lungime);

                DataTable tempDT = mDataBridge.ExecuteQuery(distinctDays, parameters);
                mLastError = mDataBridge.LastError;

                if (tempDT != null && tempDT.Rows.Count > 0)
                {
                    result = (int)tempDT.Rows[0][0];
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        #endregion Stok

        #region Vinzari

        public DataTable GetVinzariList()
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string distinctDays = " SELECT DISTINCT week FROM Vinzari";
                DataTable weeks = mDataBridge.ExecuteQuery(distinctDays);
                mLastError = mDataBridge.LastError;

                if (weeks != null && weeks.Rows.Count > 0)
                {
                    string query = @" WITH MainTBL as (SELECT DISTINCT product_id FROM Vinzari)
                                , ProdDet as (SELECT 
                                product_id
                                , ClArt.Name as ""Articol"" 
                                , ClDesen.Name as ""Desen"" 
                                , ClTip.Name as ""Tip"" 
                                , ClColorit.Name as ""Colorit"" 
                                , latime as ""Latime""
                                , lungime as ""Lungime""  
                                FROM productdetails PD
                                LEFT JOIN Classifiers as ClArt on ClArt.Code = PD.articol
                                LEFT JOIN Classifiers as ClDesen on ClDesen.Code = PD.desen
                                LEFT JOIN Classifiers as ClTip on ClTip.Code = PD.tip
                                LEFT JOIN Classifiers as ClColorit on ClColorit.Code = PD.colorit) 

";

                    query += @" SELECT  
                            ProdDet.""Articol""  
                            ,ProdDet.""Desen""                             
                            ,ProdDet.""Tip""                             
                            ,ProdDet.""Colorit""   
                            ,ProdDet.""Latime""   
                            ,ProdDet.""Lungime""   
                            , coalesce(Kanban.quantity,0) as ""Kanban""";

                    //query += " , dbo.MaxVAL(5, ( ";

                    //for (int i = 0; i < weeks.Rows.Count && i < 5; i++)
                    //{
                    //    if (i > 0) query += " + ";
                    //    query += "coalesce(ST" + (weeks.Rows.Count - i - 1) + ".quantity, 0)";
                    //}

                    //query += " ) / 5 * 3) as \"Kanban\" \r\n ";


                    query += " , cast ( ( ";

                    for (int i = 0; i < weeks.Rows.Count && i < 5; i++)
                    {
                        if (i > 0) query += " + ";
                        query += "coalesce(ST" + (weeks.Rows.Count - i - 1) + ".quantity, 0)";
                    }

                    query += " ) / 5 as decimal(18,2))  as \"Vinz Medii\" \r\n ";

                   
                    for (int i = 0; i < weeks.Rows.Count; i++)
                    {
                        query += ", coalesce(ST" + i + ".quantity,0) as \"" + weeks.Rows[i]["week"].ToString() + "\"   \r\n ";
                    }

                    query += "  FROM MainTBL  \r\n ";
                    query += " LEFT JOIN ProdDet ON ProdDet.product_id = MainTBL.product_id ";
                    query += " LEFT JOIN Kanban ON Kanban.product_id = MainTBL.product_id ";
                    for (int i = 0; i < weeks.Rows.Count; i++)
                    {
                        query += " LEFT JOIN Vinzari as ST" + i + " ON ST" + i + ".product_id =  MainTBL.product_id AND ST" + i + ".week = '" + weeks.Rows[i]["week"].ToString() + "' \r\n ";
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

        public bool UpdateVinzari(string week, int product_id, decimal quantity)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"UPDATE Vinzari  SET quantity = @quantity WHERE  product_id = @product_id AND week = @week 

                                    INSERT INTO Vinzari(product_id, week, quantity)
                                    SELECT @product_id, @week, @quantity 
                                    WHERE not exists (select 1 from Vinzari WHERE product_id = @product_id AND week = @week) ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@product_id", product_id);
                parameters.Add("@week", week);
                parameters.Add("@quantity", quantity);

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

